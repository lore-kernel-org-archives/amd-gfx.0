Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7148AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 20:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFC110E1D5;
	Mon, 29 Apr 2024 20:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TW1DR8XK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E482310E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 20:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTm60rlPGFkvyupzrVpdG2gUKBBAnrAy+uhAXiAFxqEVLlVC6YWO+nNDN0jMVIKHG7HfsezxhCgzLFEqqGzEOYZALzlLEylEdN1dBbWYAsppbjwYqcUxbl6S1kbaYNqWZj/viBFPGp7Xjay0zpo7GjRddVr/hFwxpb95buhzHz9VflpF3Lg0a5cZ7/H8TUKoNDQglqbQI34HRLPCWU7wjB2DKeKAZh8WPJy+GD2k21jz37ULuxODz8t5JT1keYrCypRR2GS+vBmVWS3/tHV/NrbP9FjQAURAfDImsQyiBreUtZ7QddrUoj1eoUF/BMHiehvBUBNUXhzrJJPdfzXwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxgb+742mkoLlaH/eYB1Jv0clwTFgnzFlRYYCjUeQLc=;
 b=DvFM4fo10ehgIKVrUzHHKnUxtIPZO4p2g9d9qxCWnwpnEz9xeV+9cnb65UFlWCRgbo1qB5FQLnI8bIXGaF93eYeibNQmcpCq6PQwbix0EEyu3vy3gYJQYR//UUfgSxH2u7MjeJhx3G/bP7zZx/J54AZjLU/DV47QiFYRRqK+lXQVFXRWdF8pS4uBvcq2kpFpx+wcC9/Pqiwsf/4h1ueViDbM3BpEJKcFMdygSH22tMat4FIiz6PINURsZpxJCe4qBFkS53dwKH1nA+/cqab0unAYoBJkiOYa3yobTcAijWScKqt6nfmTBr/KlNmgGMb4scPfTTOh5CldFEsIHrKurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxgb+742mkoLlaH/eYB1Jv0clwTFgnzFlRYYCjUeQLc=;
 b=TW1DR8XKj6NC1VhP2BtcSFBIxJ51LBIwhTcUtJn6qftslBnleRLq8aegwLiv0WEOFr/yD4Dk4K7YoihWFUCXkWfbeJVSO6SBn1AmNe2bD95RhmijPxOTsX69VXmh6rFUM/hVij5ldkzQsFzYAQ7FzUC3XxLIGqQTtx39BUYey3k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 20:24:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 20:24:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Topic: [PATCH v2 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Index: AQHamgsU2sNikA2FBkmMxEd7G3C2D7F/skYg
Date: Mon, 29 Apr 2024 20:24:21 +0000
Message-ID: <BL1PR12MB5144CA2B5C79A556CB2B65C4F71B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240429075832.168593-1-Jun.Ma2@amd.com>
 <20240429075832.168593-2-Jun.Ma2@amd.com>
In-Reply-To: <20240429075832.168593-2-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T20:24:20.849Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9186:EE_
x-ms-office365-filtering-correlation-id: a8f31f1d-b48c-4f83-890c-08dc688a5ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?eAPBbgAh3sgTGLar3wS0HUdlfXQ87yM0ijzou5HTLJLj4tM3wfoCoEAzcaLr?=
 =?us-ascii?Q?ggme4BbJA+rU82mp2eryH/aNC/T4qiqU6SiUVCHBYznV6WBdH1YWuYyYXydS?=
 =?us-ascii?Q?LHkSx7/N1vTkJoH82r7rtOJeEsYLFRll2rrA9AFcLiLTl9DWW0t3BdFXDjn7?=
 =?us-ascii?Q?OPrgWeaFX1vLkfpGjtBR1kiAU8l8H/lqy83Z03hDWfKy/WvBzDwdXs4HfXTd?=
 =?us-ascii?Q?vflNc0XYJsk00vNDnQrZ/VK+rby+CQbLthVVth5yqf/Qn9LxWzhrhkhMo6Jy?=
 =?us-ascii?Q?cySx7UjjmCXk55VT0Fmag5JtsVFb8UbnZeibGSs2tU3nbd00MMaeQkgA1jfT?=
 =?us-ascii?Q?VOkwc8k3BN+Pgo3ghM/iSHNbw9PxzlGUtT7RJx8XQ3aVB9Zb5RVI1E2tH6ZO?=
 =?us-ascii?Q?fpRIUuUtZ5XVrVroeG8a6qgzcF+4ykMfINreq24PqSwVyBoV7G4wqxyBFyqD?=
 =?us-ascii?Q?YE2ilKgzm6innlRD2msN45Qk9gzlMl070r8txfv0mV3P7Qq/HQsKCa7LVwXV?=
 =?us-ascii?Q?st3W/xahTIYq37jMfu8uHrv0GjaDbw5Gh5TrITch8HQq4g2AhjNkb/rGjgy1?=
 =?us-ascii?Q?2TWRuYjltCnyG7wtCWY4T0XMqYuiYoZQdwpq+VudnPqU1pJw2m1yq8XGUsrq?=
 =?us-ascii?Q?EbHJrgAOG1Sea6FvhNewk22a0GAQw5lZ0TBnY41K3feBGKNDW0iQpHUplQDz?=
 =?us-ascii?Q?WlCF1eOqgBL0uuKVDq8C1FGmZt4osgY+n8CQjuUgnzTuWLlaK0xOuJhiwLDH?=
 =?us-ascii?Q?jaVZS/0zopqzgWvO0bx+/PRy1lymxXNGK36/LG55YKa9mPdQYbMtECLcT3mA?=
 =?us-ascii?Q?Tnnk4Zmg28cNyHvCV2/7z4050EeEcT9BWQ0Ib7gCiqJl2cpyUxuy3+sstrrw?=
 =?us-ascii?Q?26GeAnQIzyFuWRMDUw8Lj3c0Wh4pwge7m6FmmTlcTIIsKCqmhCwDmlIas7Wf?=
 =?us-ascii?Q?Da+Yw0JEcHuBE61gMWLXxNOqciI+U3WMCbTymi5g6tbqcghgLzs/JxQYkmv/?=
 =?us-ascii?Q?DnfyZe/amfWbJnP6VpGG4JbM+jPCltOFzE28e1CBdRy9XTef4LT4H6cvGyjk?=
 =?us-ascii?Q?2wy5vC6XkHLphnQuyrFvonFzsufWQQM8ggebye2arkL1GfyAWvv5v6TGg48d?=
 =?us-ascii?Q?4rM3tEjPIePuXOMa8HZWqldyxI/Ll5SDS4YTFw7Ud2hk21nviN+R5n+xwGPG?=
 =?us-ascii?Q?vhm2Pb0wbigsRNE8ZZl97fEQCdmxhl6TvaLt5EuA2J51CmnUcrPeAfZdRHU/?=
 =?us-ascii?Q?ZbcqqAGl0hpL4oQZAm+5SLeoudOqCsUBYW45LaWV1x/r7V5IGq3hckz3QXuL?=
 =?us-ascii?Q?o5Jmx67CFMJHDnSJTZNzH72rHw/ZSDgEV6mv2XYtgC7jOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zx6tyQl4ohK2yaoss/so9lQo5IOmOdmp82fQ/OT7ERUwFGGNJHuSCnzFzqaZ?=
 =?us-ascii?Q?U0Pw4ddDpFCilqfMuIssn+GKY0kg1yWw5HL33GW8rwdsyenE1mpTqBS52fwd?=
 =?us-ascii?Q?AzRRzhnj5ZyRJ8avCXQ4vxZeSWZ0sUAqs7WHHzckCz/rfokAGBov8Zjz+ZlJ?=
 =?us-ascii?Q?iq2YsiAcsbWwFcu5EYSqGRx606JskNhSHK2Obw3bMXhq/pznXpYeEzTzeg8h?=
 =?us-ascii?Q?1LXgYa9Pb1xZ3x6to70x27SmPnkPNr7TF+DFPVD868ynrUBzq2JtSnqtsyUE?=
 =?us-ascii?Q?3txrHr/+hKcQiHDxyYEY5QX6SlVMcligVhFKcT1l0/Ba5+f5fHELTfOqKieJ?=
 =?us-ascii?Q?GOTdAJ1j5CVXC5/LxBu0X+508FuCWntES/kkR/ckfOki/8N/+rsenfBcnCmd?=
 =?us-ascii?Q?EwNhje3BK1DQt2yI0jjKzmylrQWgy1r8xAQYv8WGsN7Icrrn24LlXc5CUvel?=
 =?us-ascii?Q?AtSoSUCyXeUUuMr606S4DVSKZQ6HW3F7y/FpSiadsvDOpJaATJgXQvyHANjM?=
 =?us-ascii?Q?bE7bKLGfzVUexcT1aXwcABs9VDhKecFEbMYml3wujQkMZZP6Ubt8RCf2BDRB?=
 =?us-ascii?Q?vDY5vD/cYdXyREALKo+9RiZ/wkkGd3Hd8WB/dSWsI/yrySvt7j1TCbnPbcez?=
 =?us-ascii?Q?FDxw77WX880DyDFXFUe6nGalL3SxuStoYXGvGhYsiNY+42OSYAjhj2bFbv6+?=
 =?us-ascii?Q?TU+nztOAU8dWAuImn86WIvHxJ3VQ6klT9+jcaeK5nZtbR/1lRv+y6/slRywv?=
 =?us-ascii?Q?Y0a5dHAU4ULFpLO0gBxT9W4ymWmc9ITko7/uRKu19ApZtB99OclWtr+kxEkX?=
 =?us-ascii?Q?SWIAGeOjSlWPqRRPCL68GSVtOlNP3rkm3aQg15W2cWjUUbr+EcmifrT1/goE?=
 =?us-ascii?Q?MBrNzJB89gTypVB9VYomLOyOCBcj3TxeteDcrcz8JKKbRmU3wifH64CjThQl?=
 =?us-ascii?Q?0p8YW//esSKB3p6BFE4S8LlNQlOVJnUyBucMzjhM/Tiots4qgnDAnMF1yM2g?=
 =?us-ascii?Q?DwF07mVuwr8Ykp/TE/ov9UT7gjY16qprgMZ32TIUqEjQljjjuvbVaiWzhekx?=
 =?us-ascii?Q?xcmBzGXl2pLLihMmm+HiMugxE75cOCNf2xDq2KJS0826jbQd3MXNtcF0p8cD?=
 =?us-ascii?Q?6fgIj5Dk6QThfqeSpUhwsUWFqGAGgSJLMryVr2UY2cv1Y3MRMV0nHCUC6HKf?=
 =?us-ascii?Q?TppIikVjSNTUyR0l6pCJL8HeaVIBT19KKza8UPQ3RBTcU01MsczO06Xeh3gd?=
 =?us-ascii?Q?AerwRWkPYDIDNW+zqJxd7cJEC3/xMHU2PaMd45QDuuGQMJffGvhwDNQtwIGP?=
 =?us-ascii?Q?CZJ6Kvv2ZhhA/rFvU/Q/vCuWQHBsz3S0vage+YqI1REwWzZ0tqHQ9tFT/hBC?=
 =?us-ascii?Q?EnSk2kILsHy7rcuemEz5j4Qhn0mu9btn/jky1N3vef4T8VNJp6HgTizr0Z03?=
 =?us-ascii?Q?ywGfTTRwRLJjPp9C0qb6ZlvafK0cQt83DzkSCT14z1LXE8X8O101F+xjhDxS?=
 =?us-ascii?Q?FKbM+rhnpplCvu6rolkphXmophRTw0wsqWTg5oAqfpPt9rqj0F2Lv2sOb0Ar?=
 =?us-ascii?Q?B5JdStT3vXSvrsJV0Y8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144CA2B5C79A556CB2B65C4F71B2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f31f1d-b48c-4f83-890c-08dc688a5ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 20:24:21.8787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h60/k0mgW8mjj1ZVvJCYr1U8WNX5GdgEwbGOCXoc2iVmwOiOT3qaKS42kV3ZptjWF9UPRhZH/ina/u72bUMvrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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

--_000_BL1PR12MB5144CA2B5C79A556CB2B65C4F71B2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Monday, April 29, 2024 3:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/pm: Fix uninitialized variable warning

Check return value of smum_send_msg_to_smc to fix
uninitialized variable varning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 +++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 20 ++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 23 ++++++++++++++-----
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 38d5605117ff..a8c732e07006 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1558,7 +1558,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                 }

                 if (input[0] =3D=3D 0) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMi=
nGfxclkFrequency, &min_freq);
+                       if (ret)
+                               return ret;
+
                         if (input[1] < min_freq) {
                                 pr_err("Fine grain setting minimum sclk (%=
ld) MHz is less than the minimum allowed (%d) MHz\n",
                                         input[1], min_freq);
@@ -1566,7 +1569,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                         }
                         smu10_data->gfx_actual_soft_min_freq =3D input[1];
                 } else if (input[0] =3D=3D 1) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMa=
xGfxclkFrequency, &max_freq);
+                       if (ret)
+                               return ret;
+
                         if (input[1] > max_freq) {
                                 pr_err("Fine grain setting maximum sclk (%=
ld) MHz is greater than the maximum allowed (%d) MHz\n",
                                         input[1], max_freq);
@@ -1581,10 +1587,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_h=
wmgr *hwmgr,
                         pr_err("Input parameter number not correct\n");
                         return -EINVAL;
                 }
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency=
, &min_freq);
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency=
, &max_freq);
-
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+               if (ret)
+                       return ret;
                 smu10_data->gfx_actual_soft_min_freq =3D min_freq;
+
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+               if (ret)
+                       return ret;
+
                 smu10_data->gfx_actual_soft_max_freq =3D max_freq;
         } else if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
                 if (size !=3D 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c223e3a6bfca..10fd4e9f016c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -293,12 +293,12 @@ static int vega12_set_features_platform_caps(struct p=
p_hwmgr *hwmgr)
         return 0;
 }

-static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
         struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backe=
nd);
         struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t top32, bottom32;
-       int i;
+       int i, ret;

         data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =3D
                         FEATURE_DPM_PREFETCHER_BIT;
@@ -364,10 +364,16 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr =
*hwmgr)
         }

         /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &=
top32);
+       if (ret)
+               return ret;
+       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32=
, &bottom32);
+       if (ret)
+               return ret;

         adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
+
+       return 0;
 }

 static int vega12_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr=
)
@@ -410,7 +416,11 @@ static int vega12_hwmgr_backend_init(struct pp_hwmgr *=
hwmgr)

         vega12_set_features_platform_caps(hwmgr);

-       vega12_init_dpm_defaults(hwmgr);
+       result =3D vega12_init_dpm_defaults(hwmgr);
+       if (result) {
+               pr_err("%s failed\n", __func__);
+               return result;
+       }

         /* Parse pptable data read from VBIOS */
         vega12_set_private_data_based_on_pptable(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad807..bf1b829f9d68 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -328,12 +328,12 @@ static int vega20_set_features_platform_caps(struct p=
p_hwmgr *hwmgr)
         return 0;
 }

-static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
         struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr->backe=
nd);
         struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t top32, bottom32;
-       int i;
+       int i, ret;

         data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =3D
                         FEATURE_DPM_PREFETCHER_BIT;
@@ -404,10 +404,17 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr =
*hwmgr)
         }

         /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &=
top32);
+       if (ret)
+               return ret;
+
+       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32=
, &bottom32);
+       if (ret)
+               return ret;

         adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
+
+       return 0;
 }

 static int vega20_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr=
)
@@ -427,6 +434,7 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)
 {
         struct vega20_hwmgr *data;
         struct amdgpu_device *adev =3D hwmgr->adev;
+       int result;

         data =3D kzalloc(sizeof(struct vega20_hwmgr), GFP_KERNEL);
         if (data =3D=3D NULL)
@@ -452,8 +460,11 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *=
hwmgr)

         vega20_set_features_platform_caps(hwmgr);

-       vega20_init_dpm_defaults(hwmgr);
-
+       result =3D vega20_init_dpm_defaults(hwmgr);
+       if (result) {
+               pr_err("%s failed\n", __func__);
+               return result;
+       }
         /* Parse pptable data read from VBIOS */
         vega20_set_private_data_based_on_pptable(hwmgr);

--
2.34.1


--_000_BL1PR12MB5144CA2B5C79A556CB2B65C4F71B2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ma, Jun &lt;Jun.Ma2@a=
md.com&gt;<br>
<b>Sent:</b> Monday, April 29, 2024 3:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.=
com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Ma, Jun &lt;Ju=
n.Ma2@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 2/2] drm/amdgpu/pm: Fix uninitialized variable wa=
rning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Check return value of smum_send_msg_to_smc to fix<=
br>
uninitialized variable varning<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 21 +++++++++++++=
----<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 20 ++++++++++++----<b=
r>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 23 ++++++++++++++----=
-<br>
&nbsp;3 files changed, 48 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 38d5605117ff..a8c732e07006 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1558,7 +1558,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (input[0] =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to=
_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &amp;min_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_sen=
d_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &amp;min_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
nput[1] &lt; min_freq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Fine grain setting =
minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n&quot;,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; input[1], min_freq);<br>
@@ -1566,7 +1569,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10=
_data-&gt;gfx_actual_soft_min_freq =3D input[1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (input[0] =3D=3D 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to=
_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &amp;max_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_sen=
d_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &amp;max_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
nput[1] &gt; max_freq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Fine grain setting =
maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n&quot;=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; input[1], max_freq);<br>
@@ -1581,10 +1587,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_er=
r(&quot;Input parameter number not correct\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &am=
p;min_freq);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &am=
p;max_freq);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFreque=
ncy, &amp;min_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;gfx_actual_soft_min_freq =3D min_freq;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFreque=
ncy, &amp;max_freq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;gfx_actual_soft_max_freq =3D max_freq;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (type =3D=3D PP_=
OD_COMMIT_DPM_TABLE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (size !=3D 0) {<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
index c223e3a6bfca..10fd4e9f016c 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -293,12 +293,12 @@ static int vega12_set_features_platform_caps(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)<br>
+static int vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D (struct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t top32, bottom32;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD=
_DPM_PREFETCHER].smu_feature_id =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATU=
RE_DPM_PREFETCHER_BIT;<br>
@@ -364,10 +364,16 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the SN to turn into=
 a Unique ID */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG=
_ReadSerialNumTop32, &amp;top32);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG=
_ReadSerialNumBottom32, &amp;bottom32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, P=
PSMC_MSG_ReadSerialNumTop32, &amp;top32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, P=
PSMC_MSG_ReadSerialNumBottom32, &amp;bottom32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D ((u=
int64_t)bottom32 &lt;&lt; 32) | top32;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega12_set_private_data_based_on_pptable(struct pp_hwmgr *=
hwmgr)<br>
@@ -410,7 +416,11 @@ static int vega12_hwmgr_backend_init(struct pp_hwmgr *=
hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_set_features_platfo=
rm_caps(hwmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_init_dpm_defaults(hwmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega12_init_dpm_defaults(h=
wmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;%s failed\n&quot;, __func__);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Parse pptable data read=
 from VBIOS */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_set_private_data_ba=
sed_on_pptable(hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
index f9efb0bad807..bf1b829f9d68 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -328,12 +328,12 @@ static int vega20_set_features_platform_caps(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)<br>
+static int vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D (struct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t top32, bottom32;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD=
_DPM_PREFETCHER].smu_feature_id =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATU=
RE_DPM_PREFETCHER_BIT;<br>
@@ -404,10 +404,17 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the SN to turn into=
 a Unique ID */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG=
_ReadSerialNumTop32, &amp;top32);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG=
_ReadSerialNumBottom32, &amp;bottom32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, P=
PSMC_MSG_ReadSerialNumTop32, &amp;top32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc(hwmgr, P=
PSMC_MSG_ReadSerialNumBottom32, &amp;bottom32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D ((u=
int64_t)bottom32 &lt;&lt; 32) | top32;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega20_set_private_data_based_on_pptable(struct pp_hwmgr *=
hwmgr)<br>
@@ -427,6 +434,7 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D kzalloc(sizeof(st=
ruct vega20_hwmgr), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data =3D=3D NULL)<br>
@@ -452,8 +460,11 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *=
hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_features_platfo=
rm_caps(hwmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_init_dpm_defaults(hwmgr);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega20_init_dpm_defaults(h=
wmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;%s failed\n&quot;, __func__);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Parse pptable data read=
 from VBIOS */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_private_data_ba=
sed_on_pptable(hwmgr);<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144CA2B5C79A556CB2B65C4F71B2BL1PR12MB5144namp_--
