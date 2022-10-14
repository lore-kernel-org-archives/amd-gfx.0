Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A76C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C82010E9FD;
	Fri, 14 Oct 2022 06:09:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F85210E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SidwDzFjkQNyT6l/m9Jzdax9H2VHniJd607xA3R9zLYZ4iVJRCa/AQ6XKAI9K8hXRHX55y8ZQJgQ8zOz+gysRUu4EcFHBjwoqw8JJV69Xp82x4Y/4LLnLYU9NCVxJ1ugWxBZiyVaFSKwDchs0cjdaXgDbcKvU6LOsRAefuC3n48QtixHdQFg6dBMXe267z552S/68nKKOCjV4Ds6t4sFyBr4oz0NV0droimTnNptWyl7lCgEy+V4/FueGL7va5VORcNxmXEx8148MAN/zlMuri+EH88LGVbOMwRSPZ3Z6D+v3PXfPnDfr+B3AgxgMjXHsrxIrLR3Yw/HzMwdbXQkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPA4Lzf4IAXRQAWORn2gFe20Dr4gfg3t9z3ParWQ1WY=;
 b=lfqoMVZ6fypBbinzUty2XbRm21YLiCxgfx864YaMb2RMVBzCncENTOa9jcSmL8D6wP3XeT4Me3DvvGHF46zrYpUkaPd+hjvMY4/xPSZcYljmCJ2Bn0gnmwtkYkHRi70IHOpDh+2sA7XuqOacZwvxeuCsnMUvBd1F7oHwEySlVlSK8hhtRcRlie7o5Mcb/hwH09lR+Lxfzo+/NFcVZiDlQrA9HcG30ROWAxZhwUKRou35lIj9ycdaM8eGo7q2zg+1/BjN8n+2yLaAPn4SM8hxzspry8IGpaeL76ak7C12adY03r108pSAqbYMtdsBWxkvcVf/0gELk3bdQ9UCPvSw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPA4Lzf4IAXRQAWORn2gFe20Dr4gfg3t9z3ParWQ1WY=;
 b=vqCzUpTH6kfruyoEhoCOnQFDXOGbhPqa0V9zOjFnqrpBG1ImufSWbARs8G8/VxdF8mEVnjyp6JQ8cl7Ja5SzPx7jAbXDL8Jk1LauROLUui1iafgFCFzp6K36iKlXrUtzjpEC5HVukOu9tfq9+LNpgGLt6afgczJDWKhIN/Woa+g=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:08:57 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:08:57 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: Enable ras support for mp0 v13_0_0 and
 v13_0_10
Thread-Topic: [PATCH 7/8] drm/amdgpu: Enable ras support for mp0 v13_0_0 and
 v13_0_10
Thread-Index: AQHY35IGHO7eAznJ7kqrU+b5f0H64q4NZrqQ
Date: Fri, 14 Oct 2022 06:08:57 +0000
Message-ID: <DM4PR12MB5181EEB833891341F4F1DA2EEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055828.921896-1-Likun.Gao@amd.com>
In-Reply-To: <20221014055828.921896-1-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:08:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=43d6cf85-70d0-44ac-9024-5dd8a519a35c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:08:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5aa96427-fb06-4d6b-820f-14db6c623ee1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 778a362f-09d9-4786-206e-08daadaa94ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NnHgkfzD3lMzJvT+WUawk3NktQ+nYiyzqODZbZgLYC6FyoZV0ssukmu8CXdpB5Q166Po+59/T/0ua8D7tJiKAvIzMhEl+dSU8au6HykZ6OoT+1/Rvcz3jWsSiz8zFXS+wmCMwK7YXchniU3miZs+TXNaDMS1+DEreUfEGecGW+wYXmV4fgUWINGU3R2goG5f5NB+oYpqsJPQIbai4WN+DC2ENKYcv8vs6z/cRD1j4xL4AhI+onWfKtqsRhTt96S1hcEBZfNVVB2NCXkfEchyOJXjOnp72/Ur/IZL9Yk3G+bdbZSXA8upp5CqFhIy2oJeqBRiNaP3YsUWaoLk4CGWLp6MPUxosUkTn8QwIs2Y1ckGVFx2vEAgHFHujEhAtsD96pGvqg0wiXqk9epqX0koyTKNTNA33ZfWUvFdLb1Yko0sDn5Th2U/3mxwwH4yZMNBIODTMs3S5vaXs6Rc8a18jKUiYPDZC2ovfKkFbNHzxWOP0wiqxmPkI98id8nu1hvZStbVAiumQH33GGGxSslKSoMdO8XO5ueZHE42EvtVsXT6qHfss1gpWCptgY4ajNUuyBi2WCiEGx1rDYze2NuIqYVAhk6jvc6ElxMXLd4LnACIP4QNsId3N3l17dzqSxBf3Sp0ueDzg4FJ33/kWxy0k5Dg3fStZgIqrXREWDF3OjzNm56cdXiZlqaCclz2JXM6ztsCuu77H4Qnr1VGk7eYgT6G0ds/kuiTCIY0SXB4sJ+BzN5jcLM0L/LaYt7P3EkW0aKoxB070bpOOGek8HlE9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(38100700002)(122000001)(8676002)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BgEGJCOvyryFTVMjBtnl8Jo0c1sS50BHpozKvtlLxQ24FF7RdmPge8mYqRgB?=
 =?us-ascii?Q?XYKRaVQ1tLyoW3tVpmKYeTPEaKvEdjtTT2VjndMwetxzc0aOnZIsxMrGhLLd?=
 =?us-ascii?Q?xFzLHJxPOar2H2IRVljp2NhN9NzFIYrXwHHxtjSULbpJ5pH6uk2yGXYL3m3c?=
 =?us-ascii?Q?mHTc+ZUvnb2KA4MVFYRN5pi2ilkRN0tNi7UxAOyM7+IXK0VBrCmmTScZfY89?=
 =?us-ascii?Q?ao6DrjoR5MgIQfjEYw82lBbIz3fndXaDuYJKI95s+TZoqaHOgxGFTbJUjYCB?=
 =?us-ascii?Q?VkRCgpIKs7PwYDsV68167OauJwTDjuzPDDXXUFZYmnh6qFmc3Tn+uwaqBjBd?=
 =?us-ascii?Q?NRzhfvkYz0RC/S7U+nNfPFunHByY/HLihjqoftg/0WZBm6VB8vmdOGnfvnpe?=
 =?us-ascii?Q?0RZmE04YWYRnIWyz5Nx53mqgb6c1khIZM2hEph4eV0oLNBeBBOGCuwsY/6df?=
 =?us-ascii?Q?7kSssGr72Q22Nzo7JMLU04x73ymQ8pDjn7mGOxVFaDejKrnhkBYSKoVMtV/1?=
 =?us-ascii?Q?m67ALkSKEtFpWo6x1sLU8tivv/T2Byjx6lcoDw3ZbFWpqTcDRaQgQJJbIHh1?=
 =?us-ascii?Q?F7Ej7qnS/NpMnEXY+95m+uWqDQuxxBUSgU9s4yZov7EBVZ4qrn18rOUqUTqW?=
 =?us-ascii?Q?sGopLTKj0ULSERulQOzqEK8KT/Lv+xG3sc5n17IaZt4MY6Ujg+Ms8fBm510M?=
 =?us-ascii?Q?mycN5lFuHbYvOPXwwx8v3SAS+wL3LEMNTg2pPNoK8zPMfhJaoAFwQdjVtVLA?=
 =?us-ascii?Q?1yFWBa9i/DF3DTmijajbz4iYia6DvRSTTQ7lXYtHbsOj3ofpxSbyroalLwvk?=
 =?us-ascii?Q?pIpUz8FeMoG+VaG0txsdJWUhDEBZX5yhLi2lW/bwug6RTvcWkoUI+xifVfnO?=
 =?us-ascii?Q?2858TOIzXrTu+YBDyAF+oFAE1mHXws4y6OuUVnodHgNHszXyfUhmaVnPWUwb?=
 =?us-ascii?Q?U511ADaxiMI4AnmLDBKEjxFu3a3LKn3XpE9C3A/NZJ512yBR7upfWpiKgNAC?=
 =?us-ascii?Q?BueVFVqLV83/eJWF3tUt/AKH9q6syrOb4ArQuuWpmH1Wtr1J2VB5G85jlX4Y?=
 =?us-ascii?Q?/YK1pp1mfk1P2+2IrmM2YAqGrspS7F/tAVLukWFXBi3/cmpVPdZkjdwYJbFO?=
 =?us-ascii?Q?TRm8t4iK/p2oyrK0FZ96RxSQWSdj9g7OxKkClLI8/+7XMmc5eRc4j5E/1/V6?=
 =?us-ascii?Q?7L/KfTYDSj+qXI6Cwn+I4qqwhnmvo6ZyERoasJpc0BxflN/LvKCSSGCaAwjd?=
 =?us-ascii?Q?DhJniGqQvmFoMvtY6zBLeXrHQHvDvA54ildkpTkXegncNHACKFLwkzxI7Qan?=
 =?us-ascii?Q?v9Xp5e8KzwlAnj2dmLEa2eHPyF9COwctVrQuNlaHIwlNH1OOtCrtwRSTJZXO?=
 =?us-ascii?Q?ZcaCEHOSbB9GPUyjaAPABoEJBE7aQN07PenCbxuGYNPnwVauTM8H8eGqRUZv?=
 =?us-ascii?Q?NFQtPZzNY+eawwpIbJW4t4COnIwbRvqadtTSrzowN7Iyln72p9qf5UCmtAvq?=
 =?us-ascii?Q?lKc/1KqMVeVeXKAqr+ie+KFQo3wt22EMd9xnpibQnD/TAeWidzXp4qvRmbaB?=
 =?us-ascii?Q?/CfonbkG5YmN3wP5QO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778a362f-09d9-4786-206e-08daadaa94ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:08:57.6478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lJVAh9vksu8GnCoSvcgy47wWsV7wtpcrX/zDr36A+e7UfN/+uIW30PQtvkA8Jul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

[AMD Official Use Only - General]

V1:
Enable ras support for CHIP_IP_DISCOVERY asic type.

V2:
1. Change commit comment.
2. Enable ras support for mp0 v13_0_0 and v13_0_10.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 9fa64f92914a..fdd0bf91489a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2275,6 +2275,16 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_de=
vice *adev)
=20
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)  {
+	if (adev->asic_type =3D=3D CHIP_IP_DISCOVERY) {
+		switch (adev->ip_versions[MP0_HWIP][0]) {
+		case IP_VERSION(13, 0, 0):
+		case IP_VERSION(13, 0, 10):
+			return true;
+		default:
+			return false;
+		}
+	}
+
 	return adev->asic_type =3D=3D CHIP_VEGA10 ||
 		adev->asic_type =3D=3D CHIP_VEGA20 ||
 		adev->asic_type =3D=3D CHIP_ARCTURUS ||
--
2.25.1
