Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48957CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 09:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359E110E0AD;
	Fri, 20 Oct 2023 09:41:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2503E10E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 09:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzToMntz+vV3I4GaCrWqrhTeO3BMKmPs8H8vIDTdV7x/cNsFnkxGHwm8HF9vS0cv4uihLd1z/xbyaA2oPFG5GDpObm9JQ/OxDWLQp8qriDLYFy+7AtHSafN9ZNpdEh7PIaUdj3gexmtys7qJRy1lc0eiTAZbqVqe8gGvhBu7hntv/3O23wkz03KN4TUYqFpp67e2b26UqskC+ZA50csRjELvKXnxFCmSfUu6pNxyEwT9LABBGrMvGHW12Gn6CHoVcyk/QWXTqOkrmnkNbGCfcsPRaeSigx1YWzl57PWSpnuDDydPiOktH2bPSEqq+TjmFuUcnGramw0CRo5iS2U9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkf5H4PozHGLqR6NbZZsyM3QhkRWz22iq4UcbFzp6Dc=;
 b=UxMTTQQyRKVUTPrZK/ZQYALNlHgphPjasTQPs2AxqcreSA6LokXLxAMes1xALololScG32mWZVZYE4QFilG95xSHxQ/7AmHGINUpf57cx4qw1uNV/8/4DlwStNagzmcS0/1II3etMUPdkDwBdK3DK7lv/vQ/SEQ7gyKlD4ZuDi5Bsg+fr8quzbeuKB7nJjGnSMwVnQBD69gr3WF6FalKIjEPIaivxI45DpgziFx9VjixgOCIpSY3fIZG4rgrTqVj3vEj6TlLnAxH0sV7RPRyXyDmOG06ZBnrBpufooJZPqn1Z6ACuoyNY7wehdVmXj9idDyG7DKidlkf3LugLsWakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkf5H4PozHGLqR6NbZZsyM3QhkRWz22iq4UcbFzp6Dc=;
 b=2cDHodtx69VttHSfcSkKvyR1Zh+UPLzBAK3FLfda/Ey/Uxr8yTC/OVdOD9h3EhCPOZXltP6koS4DKNNVh+Y3QBrzt3qSmzIqoFtbuUpx3Cq/zMJVCnTXlobJ8PnRmWc6v1fg8tuy4RF/pj8T3HmyTCIVgUQVHyDlNXYryc1pUI0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 09:41:06 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::e583:d7ea:785e:7f4f]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::e583:d7ea:785e:7f4f%4]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 09:41:06 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test
Thread-Topic: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test
Thread-Index: AQHaAyNbxC8Ssh/+8kigs0HFzKns/LBSQYcAgAArEsA=
Date: Fri, 20 Oct 2023 09:41:06 +0000
Message-ID: <DS7PR12MB6071A67AD252E479E9521B688EDBA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231020070150.303423-1-lijo.lazar@amd.com>
 <BN9PR12MB525742D6CB12AA1785B67088FCDBA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525742D6CB12AA1785B67088FCDBA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fbea1042-2d9d-4e29-90e1-37c06b7d69bd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T07:05:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH3PR12MB8354:EE_
x-ms-office365-filtering-correlation-id: 14456f3f-5d2a-462d-b43b-08dbd150af02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wqRWPEYxZu0BGZhxjDdV5zpvA2P7cOydlAj4LH/ZjewJyuDKXmQgYLPy9m4n4BUKOjBJmbb4Pw9etynqrCTbrb1pUTA04QL5Ny0oOSdZ6WUMaUqqc9Fmg99gHXokncrFckKi0R9n0alllFKuqpa4NknexP/pXDq26IF6xfbFD5oQgvRMYW5+CCQGpyg0P0xpEDVPPfwzynepGOQgjqO8X/XrsCjU9xaomOBtYZxtBm/neK92gyQb2gXJnUXsTkjpknERP7hSlYGgDGubMXUdWC7ffxaeczxJVU7l27g28GE3PSnM6kJBNPqy/yLiH5yyNXpvxFYEBU8tEseiGc5c8Mn3D0iFW4n8pg/diabHtiEaZqOuPSJSZv5uu3KkxjNVGcdSBRMFGukqNsHdHEF0SQ+UbCTi1epLF9286PQ6QxCcFksoJa/Ch9KYz7eHtckMME9uS9UIACTVYGS5FNp/A7kgk/Ab+3yRIbmx3Tqw/MsRQibMurdTtS9ekNdkwKpTLwGDw8lKklr+3tYNecCjHsX260rMA72uo//AynbRMmVo6ZvCH0prXio29t39T8Zk8FbF6AkSZpRn98/PI2l3ypujYu0D97FUbV4hCeBf3NDDu72bMtl3efBhtl09BFf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(83380400001)(55016003)(38100700002)(2906002)(9686003)(122000001)(76116006)(66476007)(66446008)(110136005)(64756008)(66556008)(86362001)(8936002)(5660300002)(316002)(8676002)(54906003)(52536014)(66946007)(4326008)(53546011)(6506007)(7696005)(71200400001)(478600001)(33656002)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6QuPQ8TRTJzW8/XaD5dFb8zpAvOn+amxVNoO4OCPkGdcf+B0m+lQJ7nAIP6q?=
 =?us-ascii?Q?zFPb9EBqLgFMTaOc55GQ+t3YVaI9HX2hYlPbNnp8/bG/jm147JTNmbt6K7rA?=
 =?us-ascii?Q?ACFptoXWJat3y6Xydn5Ttb4qN82NkyHUEOi/NiGxuQa0yN6G6kjz4Tmqydhs?=
 =?us-ascii?Q?Q9rb6FGAxY/czmvD9WEKDfvi/RWBF5+VtaNsFW0N99h8ZqeeNP4fNbFRnMSG?=
 =?us-ascii?Q?RMSdAPrjh0pCR3+fYQMgbSTKGySGcbDYXGbiwBppEPw5lNijQo8hhwsK7P/B?=
 =?us-ascii?Q?UI8JGBAtEghOp9cOy9Fz1kOE/TeKo/J283vCj/VmGZFRGKDmoFwlV+udcAhc?=
 =?us-ascii?Q?kvHVdKTS4sod8icCwq0y9NRuRRwZdhc3OojDpw8G8USGGsaWmrLpTug5s1o2?=
 =?us-ascii?Q?uyaCLiLBZUINl1OCbaflTl9uGYd8aFvOQMsA4w/DyhYGApkGu3zWXW/b9u06?=
 =?us-ascii?Q?MzdZE9dD0XZYK7XwZvbj2iRDQz02Ci51h4xDbANw+sVoin28HG1q3os7Ndm4?=
 =?us-ascii?Q?IsVyPjhVjHdMcJcQr5n8ylJQIMsdsVGUiLN4PJ9fST2tsqyYUHPiM1JELSl1?=
 =?us-ascii?Q?/LPkCBXCWtG+SilQoO/MHkzjasC+vTMWlz8OrIfXCwMPVd4tZjLKrOPPZelc?=
 =?us-ascii?Q?FuVv7c1AFHj5fEMdM7gaAz8ZsARXO0urEyKuHqznoWaTCv47AZDFRHwlKIxC?=
 =?us-ascii?Q?sAcOvNlh6bEMpMieLd32XKRpAFzuA7m/LGrwdAy9MEHQbNXnzIeIpXVEjZ9S?=
 =?us-ascii?Q?c6dF9h5oriNXKMdrUj8/rm9GCJYRvNmMz8SBmjID2izvNes6ii9h+q8XLapo?=
 =?us-ascii?Q?+3q1PO0FixfVo6Xf38C07X3WsWjGncMNZ5HSFEhP/6DTdGz4u3jnDq51ZV4s?=
 =?us-ascii?Q?84yT2e9hcy9nTFP0sAbfwvnLNqNxIrcpyaTu4SObXMCrWpig7AtDuoxFz9VR?=
 =?us-ascii?Q?SHQwAlacQEV50L1F8JMDXiTbLZfIE8BvSdeCJlVl3pGBcaN8V79ocojTEJth?=
 =?us-ascii?Q?NiCHbOEYBUpR5re3P67/gokO/A8v1/oReYZIfHfEw7OGv/7fOwzY6zOHoLD0?=
 =?us-ascii?Q?LQM8ygEmERZ6XZ4L30I21ImUP9dPWsCNMv1vlgZg7KdA9vdoGg4Trzlzm1BQ?=
 =?us-ascii?Q?2Mq8bv6O7ZYIUJvZUfXdT3fBlqak0jSaU7kZQYsKHZo9rVbZvsxXzKAYLK9d?=
 =?us-ascii?Q?Bg1pnGiJmGXwDDW0/Dg8ckv+Tl2dPMGztmcGF8Ejf7k7Y7N6VD/h1RWFoA4b?=
 =?us-ascii?Q?a6Z2aGdSTOmpZ8xlZNYWyrsDp6LTPe7KybU9nEN09xt223Zb52sKaw+dtidt?=
 =?us-ascii?Q?zuy98oOvb5IaUjFLniG5S5Vl/4LK7et6UU76HMvQs0mJiRP9cYBWnhHmiQt+?=
 =?us-ascii?Q?A4L0YQozAv7bRpz+f7/2napgNWv8VN7qOgm6AtXjzun5WHg7oZOu7eezfXUW?=
 =?us-ascii?Q?cPoupqw2iY2kGWnX0Ho2mRSWP/tLqXhXSGax+05qOb1r9n6MwSnPLZgYw7yf?=
 =?us-ascii?Q?GBGUI5ygi/A/U7nwXPcNNeJku6qEQMKrFyA1ON8KZgvQiH/N+0/3HTlkxRDx?=
 =?us-ascii?Q?nQsXZkx1PW+w0lqnhJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14456f3f-5d2a-462d-b43b-08dbd150af02
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 09:41:06.6782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhs1VjuYleHJyfsk0W2tlmfIT3DVliN9mHCIuJgiuGZpu5QfQ9HuTeuwslZMOnXAkV4jBgQx9ZhRnOZsPQ8URw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, October 20, 2023 12:36 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test

[AMD Official Use Only - General]

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 20, 2023 15:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test

Issue a read to confirm the register write before ringing doorbell. With mu=
ltiple XCCs there is chance for race condition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index a1c2c952d882..5861e4d0eda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -256,6 +256,7 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring=
 *ring)
        xcc_offset =3D SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
        scratch_reg0_offset =3D SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc=
_id), regSCRATCH_REG0);
        WREG32(scratch_reg0_offset, 0xCAFEDEAD);
+       tmp =3D RREG32(scratch_reg0_offset);

        r =3D amdgpu_ring_alloc(ring, 3);
        if (r)
--
2.25.1


