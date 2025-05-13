Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FEC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 16:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B21C10E1B3;
	Tue, 13 May 2025 16:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dt34cH31";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD57910E1B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 16:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlpQha/zAnq/3iBdN8tedN080U7ef+WHoDeu3czw0zuC6fJFm00yH62iBdddM3hxvhuQua1CoEypniVn3IaSLDp9ZDebu2AaA1nufvWVTs+AdnzqT7rNx13ZjUd46Vg2tnyASp3aemVilwv7C5yrHYiEwfkGXgDD78sRMmZgHV8L2/bt7Y77Uge4s7IbtrSoRVIKt6qKHArMc9QyFTp94GG7DKCOyjDa06d4UzsCSA+GORUS8fHMPlaVwA4Fpuu7cBG01lq0CucVcRvtAvVlDQsCN99YRbwX8MOAKQQIkkV5B75mjf3J5nq6SMWmbHtTWCumhmKDOjdFmmDUIqrVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0TEydY6JQjog7Nay+ZdYdPO2AF6lqttqwY7JAMiiME=;
 b=ZghdoahPgBVebRgs1T/SJXNgQE8TcA8nwAbJryycAiCTJqzFI4bbknAZ61baspvy9YVpmiVN07NEHSpnd6XRwcgpQ3pAWkkludR/VMrmphxPPuCrG8SX8cXc8CNdm9UVCD2Ccnyr1Io/228/K69ugJhQ0pWShKhnC4UgkME/Qe4EQW0NjnVGaEBA9VpIH/hB48i1R31HKDfUnbelfROxjhkUaAZoZ2+Ccf1L9wz7uPVvcKrQfoB7E0+HpuVrx8TP3ueAL5fFSynT3YrJmIGaAia020S6XDG+p9XFVcj4zSgsU3yb95Ouz2g65tRwu17ceX94nlNsBS4z3lHKto6zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0TEydY6JQjog7Nay+ZdYdPO2AF6lqttqwY7JAMiiME=;
 b=dt34cH31tyjFJNUfhinoiqlX2aZ/MIEYwQJizh/lns9DU8qhUssAHfcrOTuDFhRTVc6ARqOWM8BrQbE2vRkW3T1sn0QfZjbGL/8bNPIcovAn63+Y15UOqHytr7k/fsSgVD+G7wyCiS+t5HkhE0pGwAi+fk5xVKEzae2AzRjPVlk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 13 May
 2025 16:25:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:25:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Allow NPS2-CPX combination for VFs
Thread-Topic: [PATCH 2/2] drm/amdgpu: Allow NPS2-CPX combination for VFs
Thread-Index: AQHbwNbIW8/szYnVN0GFZi/Ie1/3sbPQxWZA
Date: Tue, 13 May 2025 16:25:10 +0000
Message-ID: <BN9PR12MB52571E3138C80CAF340425A9FC96A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250509113725.312103-1-lijo.lazar@amd.com>
 <20250509113725.312103-2-lijo.lazar@amd.com>
In-Reply-To: <20250509113725.312103-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1ed8400-c669-4e67-93c1-5d05e2dec9a5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T16:24:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN7PPF862C85B20:EE_
x-ms-office365-filtering-correlation-id: b20faa6e-e455-4686-c022-08dd923abb37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BxCUyFYwajQsKa5hj87FtYx0q4slXNxs2d14TC9/Co/iZsu2BIXzObVoLFU7?=
 =?us-ascii?Q?YcgLZJ3ksa6OjW0B9+NvQkO0JkHPkBE6053tGq1oq17JB2vWy+bn9uUYSUjV?=
 =?us-ascii?Q?amFBDVkn6JIK1X6PUMQeTgx9bbbgKByQeuF4Ru0v1HO6ANcU32v2lwiyHBAT?=
 =?us-ascii?Q?fRFxuCpTrp01YqZA9DNQgSsIkJ4WzmhJdjZSwjiHxmlOlLDkASu/yZpiT/fg?=
 =?us-ascii?Q?X/H6ZqH+um3ObH4yMfuqNOTojy2eX2r+Woi8JVEaRE8aHcNZ3vw/29w5YVDt?=
 =?us-ascii?Q?ThXNuR1GWfzXrU9WhBqNd6QhcRh65b08g0m0pUNoncQ/arwN4jT7W98WhRzk?=
 =?us-ascii?Q?+P7pexh7FKdKGkJvL4bSTwTmjzpr2QyCb4ld5qaKvOal70RxyCDbkHSdUXFY?=
 =?us-ascii?Q?Dv/9qysfzAJWPlgcV+UYFflz/8Js7dZV84AjhWanyis/WDc4UuaFKgxTKQB2?=
 =?us-ascii?Q?b6bpBI4h3yw5HQz4YOtG1WFWdUxRz+Sox2yeul8VvyXGa6k6Yls5NSB2/vm0?=
 =?us-ascii?Q?FNk33UXAdceHHRnlZ8m4Vu3VqU3pCCaQAmb28BydWnuxmTY8IqKTVJNCVyZe?=
 =?us-ascii?Q?KoQXWkyhYqXYlHMfCCjuzL9GkoELulsO9z6NbGe3cp1VSzgT2p4wwRYBxzR+?=
 =?us-ascii?Q?m7IfWJICkvrIqx1O20FuMoSyNAbgeXXUf+6jasFwQYx/awfJmkCWtWqSl7lB?=
 =?us-ascii?Q?qdVoI1QskxZN9FrpzOitRIJuJU0wY8DFWkRqLt0q9QOKH01q/IAqSOf0eeM1?=
 =?us-ascii?Q?j92Xee3o8shelsWK3/SnTy6BAB7io8jqewLKFfhGaOMrYPBU5U73idutO/87?=
 =?us-ascii?Q?iEAFmAQi6P1jtIxyHojmvi/KxlEo7pO6cix5eT6cneZyOZiUZG2EtnVpleI6?=
 =?us-ascii?Q?gAjhr5Pt5i36URQ7yk/Qc1pYiEk3Zq3RcA6o6Oyfd/Rd8lX4OFPNHI3bVv8j?=
 =?us-ascii?Q?L2P720T2VRJq76I6jZLkIf9pYYIB/kTZwoa3EOy93NS+tm81n0N+VqQ2kmYT?=
 =?us-ascii?Q?msvOsP7bPqZRpyffVReNtMzL7jgpXvfC1hcx52vG3460xmVySTlTZfk0JZSJ?=
 =?us-ascii?Q?1APwe4MLp5uk7cw6lg7jTwUKXHgiEVotNiEEMuVMEJiujV8QtFK740TEbi/0?=
 =?us-ascii?Q?sqPcGIi62AUW7C/LtvATgEn0QbRX6U6zkidGEUdNOU65oGG8HmhUzBm60l5t?=
 =?us-ascii?Q?C66R1HC16/+8n8IL1BWf9fHFL0rIx89yiA0ciqj6eEEambcRBhGrkgyUYF+e?=
 =?us-ascii?Q?MIQSjY9eHm24mjtqbfh6Dyw7hUpvHDveXawX2jRggPIyX0U6QmA/bCLDoKog?=
 =?us-ascii?Q?+KKHaaPLjCyS2WtQ4ostQQwHPvmiwtyag+DOyw7XN5NM3oddARkxlWd31lCl?=
 =?us-ascii?Q?pZ0VPwhQpgL6OqQg71NVbv2rTuz+Ad/pR6u8Mv7q4bR8k/VbVG3wCTY1uhJU?=
 =?us-ascii?Q?3UgNo3d4aIslRVxAoEydoq5G7gbbnsdLoi3dFPRdT9O643iVFPXfGNrVetpn?=
 =?us-ascii?Q?dSTKpCmpYe06hS0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2D3InVqlF1xV1FjvbAQEaU62m9MwrP6wmbVlhv5ro9wyMwGmhb5cgl07XJaK?=
 =?us-ascii?Q?8PE74nxf22t3Jo63iLEcCMsI9DTbKwQSH5pDzTywGWfNWJUAeXt6DFnMWNaL?=
 =?us-ascii?Q?Gb1HCJKt1JGE2tfZuQ0FgCeo77LEPFZIRqSt77K3K25kGRjKN6pJvDrozK2Q?=
 =?us-ascii?Q?M6Zn4QvVLdYlvpYFAMpITbfiHwH4msI6mvtxTVqn9iqfRXDgag4CVIEjXy7t?=
 =?us-ascii?Q?8I2p+wKPOP25T/BEuFYHI4m2jYiPK3ohVcJ0pNE3zGt+V6BG4b1kkjm6w0V7?=
 =?us-ascii?Q?CEhoQZnvVp2RbNB1egm7r8f+RtaEXcdF5DdafraBisYxvzWF9QDSu/8bwDxj?=
 =?us-ascii?Q?ZPRLWbETTAHsL7nFqDUnIogyIt9WEq7g1VZKWQveGLA3i6gUOo17T7maXNpl?=
 =?us-ascii?Q?5xboUpWQXBCFPYLLUQmSyAtzyJWY/QnOgT/NTzW/sbUskYxu+gSkIpZPlql/?=
 =?us-ascii?Q?A1YsjVTF6AnLwCp0+XshHuo9oTE7D1WXHFNS1pecMAVr7kl13vd/hzDtXYQk?=
 =?us-ascii?Q?Z6HmzySACJLhF+QnWpg7vEzE0oc+xnHwUbRnoaQRJhEKgA00nCk8T/7/dvhE?=
 =?us-ascii?Q?1+WPLqi34qHpqjvx+qHNW0iEPhQ668Kc8gJ8wvHncQE7vpQLd00pUJ77fUlL?=
 =?us-ascii?Q?isU1BFwb4n5FddwUKpFmV4fTXXWlBUazqX+7lKPypYaTxICAQ86jefBmjbFy?=
 =?us-ascii?Q?/2vRmGRUzQwDyVJeafkbQgiEDWr5qWDzPfdearxP3VPk3A96YDnDhCkz+nVy?=
 =?us-ascii?Q?MCjybLM7AuwPmiMUGE7vhEV2C0lyrUsopMSROf1W6iIL2pHeA3btFLXSJSr/?=
 =?us-ascii?Q?px3rMfb6rUTm1/tPqzrpPLvcMtXxbm/DVX/Xkdd5EUfe2Bh4Yox6e3cyUUcL?=
 =?us-ascii?Q?UjAh0qc1e2uihS/qAl69B1bmOgfKtq7tVtSyDaP1flhIwpEQprzmw+uy8MPh?=
 =?us-ascii?Q?sBAJe7mEdSyb5JCUZcPhL/UhEJrW+KZvDrXqhdWeuPKv8BvPjdwUq80p33OT?=
 =?us-ascii?Q?GzYQawX4qDrBzUxrdxBSgOJhmNB85YEOgWGYLGJb712hwO9xVjanu1D8C1yJ?=
 =?us-ascii?Q?NBmx0FSj+fvwp3aLrCTKKAAwFehqR67Em3xXYXr+TGu4vJCCRzGRVVxkfm0J?=
 =?us-ascii?Q?MKj2OA3scIvNHoQE27CK5KYF83CC6ZyI66h5CbTdtoHwaO8WQY0/jRoQxHtz?=
 =?us-ascii?Q?hLA1sdn2WC82jjdW1vpi7kLD+j3ZDa5V3TsdaXaSKsLsKz9WTISpb3SyxBzb?=
 =?us-ascii?Q?cJBrjtvRiBettjrIxDv9K3EtM9lHNwYuH6JjGOPioq0Qgtxgdjt8MSSOSxDL?=
 =?us-ascii?Q?6BbqXNw5ex8lviUVFbTa2gNdYILsbVtVSfOBUr0xJQaFJD13bfqrjJ7H90nd?=
 =?us-ascii?Q?Qkqpq7sE6SJ44yFWhoW7TwOdol6jw5oKRwQKCy4gQq1O5ylJVZF2skzuyIWM?=
 =?us-ascii?Q?MRAit4F8Il98jTs5yaH/S09ogojSR4fFhhHlM7B6RPICv6raciAzI2ARDFqa?=
 =?us-ascii?Q?jhq5O7ufArH3jJhZsHtglDKniPjiJX+OrkfFxzrhxFNGTG1qi96qBM2vEFjB?=
 =?us-ascii?Q?xK2QUkryNsNJA7U78O8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20faa6e-e455-4686-c022-08dd923abb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 16:25:10.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qNhh3T4VphG6/6Ai0owk7/pGijzTLi51FTEyL2XyArpjPR9gQ6si7t+hU7xd7mmJHrQDRWYtwvyQ6M7GeSFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 9, 2025 19:37
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Lin, Amber <Amber.Lin@am=
d.com>
Subject: [PATCH 2/2] drm/amdgpu: Allow NPS2-CPX combination for VFs

CPX partition mode is compatible with NPS2 on aquavanjaram VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index d4bd24e3c390..1c083304ae77 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -481,6 +481,8 @@ static int __aqua_vanjaram_get_px_mode_info(struct amdg=
pu_xcp_mgr *xcp_mgr,
                *num_xcp =3D NUM_XCC(adev->gfx.xcc_mask);
                *nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
                             BIT(AMDGPU_NPS4_PARTITION_MODE);
+               if (amdgpu_sriov_vf(adev))
+                       *nps_modes |=3D BIT(AMDGPU_NPS2_PARTITION_MODE);
                break;
        default:
                return -EINVAL;
--
2.25.1

