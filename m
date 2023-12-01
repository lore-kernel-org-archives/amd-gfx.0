Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099B4C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 10:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3C910E0D1;
	Fri,  1 Dec 2023 10:26:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BECD10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 10:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fooTh7jG4D4Ofen6bDkYsgFWKVEA/7B4THJH49LMXNrh3VNBVosk7N/cY5YdwPDen0BL/gFK9UYr0j8uJhAyi/rcTmOTNW4BGzR4EENKDDnY2vjpWUTkearT0ZI/HoMRKZSK7ThltbI4qR/8G0iH0epS4IPIGIrhNfbZguweSYnm2FFoM+w9pYFbFDeQVya1e2AJwH7o9NocImbuXDOAprcEYou9dWHHA774oW4FkgPpLOzmtOmhaLZUd5gMgb2KRYiDOJjmjRAlmB7PfxATecf1FpoNFhh+8EdBf3OaDFyU/O7hIRFQFzOnZkVbUz3lpOMgfoxLji82DXi+hwlC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/22/YFtVULBaCj5cQpUAIoR5VQUBwlYdIbV0+7FMyg=;
 b=X3eo0WuQSTCRfdGS8kLBsFZxhCzwOQV4SONzUEUuExPhmIYTP47bE0sAIlaM5xwCpnBZAUCjqs1dH9hrPOSVMi8Y4YyKNmGB+WSOJpu6n8xqPDTG2buueYbyWxD/B4HV9qfvfv4QOkyYhmg+YS07q6sznBVL84oPyRIeQ1kijQMs42/wc3rGlOOQEtjBd7GxuAwfGkc24QHuxY301+O+5n5VRGxVbFWC77mWKKsZqjEYwZap8iA+A9ujMdv5AG8bPXgb1UFQurT4Q+1tm0W1VFIHhllUq1lKW3DW3/lflWBljdsTRNZvimmUnR9v9KhS7TkdD7VWm7VqzbS59e4wkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/22/YFtVULBaCj5cQpUAIoR5VQUBwlYdIbV0+7FMyg=;
 b=2Id2fQfbUU21OAt/NHlv0M1yvsk9x0C+2yNOOm5AF3+qPDjCgcGpusSMzZ26WLWcqmWWhDKY38FhrIyjCXxePSU10sxpLm2BMmFeJBcMJYUNS8DM7WjrTMW47fQP16a5avYBK/BlxlBjMfAKB7mYIBBu05e+SE+zd85jcw65bHU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:25:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 10:25:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
Thread-Topic: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
Thread-Index: AQHaJCk+OXiYf4zhD0iEIKHTQ5GKtbCUOQnQ
Date: Fri, 1 Dec 2023 10:25:54 +0000
Message-ID: <BN9PR12MB52573462D0538621C21071FDFC81A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231201073636.1190113-1-lijo.lazar@amd.com>
 <20231201073636.1190113-3-lijo.lazar@amd.com>
In-Reply-To: <20231201073636.1190113-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4a7dcd2f-3876-4952-afcd-29464b32b89b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-01T10:25:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6427:EE_
x-ms-office365-filtering-correlation-id: 62e51525-1c49-4acb-6b28-08dbf257e65e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bhL03ku+GYnSzcf60eIo976p/mqWQqgr2Ds0SA/l8MLXQsaXDES/ICDgyUuHaLJd/y9+Q72w3ALVNFgxlMdgQgrI+Nzc8SqFy0EPgGRrBOPCGiYDuiizNYODyGM0RJVG5UPygM5hKQOqOBwDTml9K3+bC1DXMZVgFEIzLnS/3Ox8yiik9WFpGdXIhZAInHOSPLTNXUbXpYOoP7Rm8P5QA3mTnssbCYRfBm0MFWhXp4GcfZydwgU5vtvI4DLlZHdtAF4EgYN2UptxEzC5pu4il4zMgiZryIjXR3eKOmgrjvF0dqasSBeQpfbQMAin5O1H6aMVFBvTxagkxI6V4x0AiFgZI2pYidtF5rCZBIwFNBtzXMG7fgP5RrFqD2Ris5iJv+GVYD9FSoR/z20TMJBxq/2LhmqrOGhGA6+xBCTpc8LGe9Bk4o7ogjrlgQlQTQIQXbYjkZsC9NyO+QE3KcaPIpsS6seeNEaSzE+NmP4EC3K3yiUGTA6OPdZiUN3lrL+JIsBI1gt5fdxcZocpMJBHkmyxfxyf/mn8mvUkix6DCw9sffQLKbC/Dd7JKhyDPWdfQmynC6rQoaKNR5qs5R97OSRepAoURTlkGVjqh35D46s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(83380400001)(53546011)(6506007)(8676002)(7696005)(8936002)(4326008)(71200400001)(478600001)(41300700001)(52536014)(86362001)(9686003)(2906002)(38070700009)(122000001)(76116006)(316002)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(33656002)(55016003)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2EFbSuG0+/plbG/SbWeicPPYvzKKkdifqXxmayXgfqgc4nnbUmVW0Nb6eIgU?=
 =?us-ascii?Q?UcWhW4PkOrcc2kQMEKmbRI1L6Su8q4Yz3aBvbo9rBh9Wm2Iklpy4p3PlVn3z?=
 =?us-ascii?Q?gMg6/89RLa2ZMgaw9ZSuazjyMNiblS2GXiKX2HOE3XSErKCFKQa+JT0pjNDo?=
 =?us-ascii?Q?CgraxWY8ExN8hH92XX1f1LfK6DmCkP0VNHIg4Yc0OekXoJYuQtwkD5p+0aEV?=
 =?us-ascii?Q?kDTT7lJJ8VKzIx/8nQ0VdHhfVLpqyhn9nHAyvt7J50nMCikvbTatiuGJc0DR?=
 =?us-ascii?Q?gn9iBruE/7YeQ38zdHCrJRv/coNa16u7Db9CHeflO8q8GyA6i5Ml3gbamGBn?=
 =?us-ascii?Q?6gM5FS9fFt4GhQ5v0NWfOFxQ+mGmFhDE7vJmLzKI5A7x2ZfoSt5fKG0yiVYw?=
 =?us-ascii?Q?zb/QmniKrHXdZfUIAqvUiiLtObwUAeDzC+ZEr2PMe7/JSO9ynOTWOHrBB2D/?=
 =?us-ascii?Q?cgJgTOVnzyP/oZkC7c7me8iJRZuLFdv1Y9LgyrtcaIR/rgzKAd5FL4h3eKaL?=
 =?us-ascii?Q?H3wVir2Yep4mYI+gX/6WifJOxI9tVcyiQBG1ZjoYDowMVa0Ba96DSUYBlh4D?=
 =?us-ascii?Q?/mTK3mjCa0y/CO/TgRXlrDjJ1ia7obYwkWDX/Fec1FVux7g22x2uBF/MVTln?=
 =?us-ascii?Q?wd1hqigzeIl3vb8uQmVpIf4Qc+5nP8JOdU0F+9ZexOnLxRjsZV03tmiOz953?=
 =?us-ascii?Q?p5djXndawhvC/ilM5rY3k/fiQ8G4Xv7UrFNeQWiEEm8Q95MzPwNsb/D8MJ0Q?=
 =?us-ascii?Q?B2eA1k3HEuMjn/AgVb8cpoicysQmWAAPYiwyaMFnW010Ey8vzZss28HCTfjs?=
 =?us-ascii?Q?UC6AjUnaEufBBCRjNYnVeBgVwIJU4/ssLKJsst3FaVJ8vTQQ4BVZkdx8mWxQ?=
 =?us-ascii?Q?S75hIAja6rB2PyUrMdVyowKHLltg9hS+lTIXr3oWdjZt8zCTRYKz/bdhN/aY?=
 =?us-ascii?Q?xOteY1DgqrfUW0jOtQEpPHzHM+wv3BGTdxHDiDp6KUUzTBAm9tsmBKbl1K4q?=
 =?us-ascii?Q?GAgh6YQTWiMu/Gz1YZxkvRIP7XvPbhinZBnNB0V2K7i0nJ6t/4cKRk5LwGvm?=
 =?us-ascii?Q?5ysYMeeXabekAnYcN4QWeSUdP3Z3zn/ylsB0MSrlbN7xQGqMnit1yfPq7+VP?=
 =?us-ascii?Q?tjMgU43jXGxPY6KNrF8XRXG3SN0FArdKmIURuaJeR8EqiU9zl3OK0UyJsgVE?=
 =?us-ascii?Q?Rxp+K0Rwal0vhM6qBdRN2ipucTMZJQXmVInjdW7/d99+XDBTVQgPhjOocIqH?=
 =?us-ascii?Q?OiKe1Z4OJYY8hiYIwRe9dK2A7FNCwXkS+VTHaaS+DAiItODamS2tH33K7s02?=
 =?us-ascii?Q?UcN+qOmNR7dtpPZ1THVc19SdmzaERZj0UVzJJEwRRVFLxQ58PN6sFweZh/Wc?=
 =?us-ascii?Q?yNIO8mAGYY+cEp+jbpIuLMM14ltma2um3BTGqSsw5WaJB4KlRZEktz5EejcF?=
 =?us-ascii?Q?xin8CSMwwulCvO87a5u/3DxDaGMjvuBVXx6picetEaNKbL1y2x8CJ+09qam0?=
 =?us-ascii?Q?IHAY/NBVSxkvPDFvXi0ydA4ge/0Qz2jQgaFGmUowI9V3UADy1nnvdPZnB/Hz?=
 =?us-ascii?Q?ji6f6eicEhQsxihPHAVnkuqLU/PD5pwyElsg23DD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e51525-1c49-4acb-6b28-08dbf257e65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 10:25:54.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udJcC9uKjffdU9wfSE3xtI/s8vjTqAhULKeLfvO9uI6cJZ1+tNrkUEYBHaKC9MYJB6MK0RnatykfPipQaO8TeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, December 1, 2023 15:37
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status

MP0 v13.0.6 SOCs don't support DRM MGCG.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 9043ebf1e161..15033efec2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1430,7 +1430,8 @@ static void soc15_common_get_clockgating_state(void *=
handle, u64 *flags)
        if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
                adev->hdp.funcs->get_clock_gating_state(adev, flags);

-       if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2))=
 {
+       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2)=
) &&
+           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 6)=
)) {
                /* AMD_CG_SUPPORT_DRM_MGCG */
                data =3D RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CT=
RL0));
                if (!(data & 0x01000000))
--
2.25.1

