Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9EC83001
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B723C2137B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VzojeYzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B723C2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718906EB45;
	Thu, 30 Apr 2020 06:44:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51706EA9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 06:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1QBxwzm1uWY9ffGKgY9pfINH6y7gWoP+XJYUOH03/4Zxz1VMyHhcDTvZrLqzwn3dkZtJWkzFVQRQ4mwypkMudXHtMGRf60miBzFiIW8AD+dkm2q69IKGPBxfSLLpoP+Oim+2DyFJsp+GzpVYYhLI4T6/MmngOrPpRSL8gGUsueEns310ZDXnR4qudfRhJZI5zdyfzgOhjhALNcgCRXvYWYgS9ROv6Ts/yGfGp5uxFipy21egjp33QEdnGEv5+mmY905CMYsz8ctRCo6GkgpTjSzJ7Y1g0Es0UNc2KX6HI1iuMulcMc1daIYRTT4gHJ2I8SixjmymHlGGdiJAhU9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/89GdM9bNS/REiCtzGas0cMkyf9N/DCLDexixUbkFU=;
 b=F1zYEfXac3KspR/stKVXh8iHZGe6rmBkxGNyKenHMCCOW1Wda/jAwbYj3VSlfVqnolDrmdchav4QAusaIkG0VjEgWw1ALiYL8ppvEppf29cA/2c1KogT6H8VXcIvNO0IxRmnzPecS1BMtBA7V2PyK18zXXcheSnSsfbGqnvPSgRGAebHyirvvIu2se01gajDfjl3Akqf/LnRsZbcmHl7pOH0muHapaUCgzp6uaU0XdZ7LVGrw6WYN2t0RCARcdh74MajXCKilOpeY+Zgb/8cUcU/YJzYOSGemUcmwRnaEeAi0KeDf1Pj0lyK3HxsWZfEgDYeFvDrQH30zWM6YjXXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/89GdM9bNS/REiCtzGas0cMkyf9N/DCLDexixUbkFU=;
 b=VzojeYzPJlo1fP4GYOrUF4jNQEDci3RqlYSWk8WUTwBhANDqHgDT0dfHDlEk5eQxtiVf0+r+uki25/4w9Vxq1tuTsYUZKH1z11xIuiLwmwi6uiZrbJNYt0JA6SkZq1zi8ngK3Ld0yTFqjIIO0TIVsHiRvvshV0HoF3UT2e5a9GA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Thu, 30 Apr 2020 06:43:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 06:43:57 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: drop unnecessary cancel_delayed_work_sync on
 PG ungate
Date: Thu, 30 Apr 2020 14:43:30 +0800
Message-Id: <20200430064331.23502-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064331.23502-1-evan.quan@amd.com>
References: <20200430064331.23502-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 06:43:56 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01c75695-e3c6-4cd2-f2c9-08d7ecd1dba2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:|DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31147F00FC39EE6A2AE8ACA0E4AA0@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgLKS4fd5nQdOCIm2L3YrU3ujxq03BIZsql9dqD0tBjhIbZkn2LNl8labTjNZr2DfGD9iPPWSIHQsczJT4cyDT/oiqXMKBS0apZTg/ThPBsGXfNOzhc+mja4/7lHhVSMT8VB0kQAFP5wiHxTujDbgQGggWhXxMn2vVN4vKPXYcMVzv7SB7RmzwjM6H2ig7iLBH8ZXnEDobg8hFcUoaTSowSqdXHFhGraRmKdEFrygHsggGeuqRVRInoOuyKX+pnfjAuRO2sCmEjl4i8Iy0ALlSsF6H2Uo3lL/ZUwaXcmgmi8WnYsGPFycur5jQrKDQ178tGTKTXvuoXivbsgyBZNsN+DSTG1E3BZGa/ZIyl/cn8dx5YEM3Cz1LLNrVF2mPiVJlqV0TDruJ7Da0K7nIz/mJ0mUdWgcfoH4Fo2EGL/FCTA3DH2147cPyY29YqF0HZB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(16526019)(6486002)(186003)(8676002)(8936002)(5660300002)(7696005)(52116002)(26005)(6666004)(316002)(86362001)(36756003)(1076003)(2906002)(2616005)(956004)(4326008)(44832011)(6916009)(478600001)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 69W+TaRJbRlkWOZOW8CRm+H6h7YR6EhqxiDSuvuFVBmU/L4JM7onoKx+VL9KSS7rwxvbokOOvB76jvxrKIspzsLFElYLIJ4mGJtS4tzV6EU1I2MR1g/UjZb8mJnRS+BTae4gWOEmPyLmIhinidlmvlicJvKREZhRN3ser4DK64H+sLjXB40WYx2b50Dj+QPW6pHbmzJZh+KWwxYzSQPD2JWi6Rh1C88vMQ/ADp11vZwi2ZDcFwd2A6jjQAhTyTj0vgKZ3zqUsBHdIgPHWvbB6R1r5MVqm9xUdQf0P3713YqigfTAqQHOabCGU9D2AJTrt28NMBt97eYcrgo4bzNGYX41N352CkowcQBeJzFGdHlCcYOu9yWztXCx9IL/aOrIW/HCbeb0IxJyVBwHtiDw6NiCUjZAnkmStVi7IeuXECyWZHwfYvltZWJQV6XHtWllB+u2/hHJ6ut0WG3fweZINJluYRXUzaSxorejKQ5x/Ym6fXzCvpL4bsaXq5dpftUTOTzIzx1N03LCp5PXaRDYSvn/Cu1KXUyeklkBWPItMhrWnrTuX9RWJGdgmI0oPRTLYIUtO6XR8Lz5cedGTnA4sjit32uQIrs7mfD1ZLd9D4ysb6PJEw/80YmGNlIxrO+f0bHUXzJ3RlzZ3MeECH4hVLCAorRDIyGxbcdB++Pb1zpAMl3RJHF6Fy3vtLcz4OLkWluDzhUNSJdg7alRTGU4EYfM9Xle6thgaZCN5wd7+ncBcdYBEtfsBHQnaZJZouniWBEBs2U8exHnAJN4qC2ft/4YYSkZfv4Qy4FuNaEB1pc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c75695-e3c6-4cd2-f2c9-08d7ecd1dba2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 06:43:57.6218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtaXCm3zwXxm6rg8fbOHnyTZIttV1O48zA6JhMuI68y0c04GeaErJzdfP2md6hd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As this is already properly handled in amdgpu_gfx_off_ctrl(). In fact,
this unnecessary cancel_delayed_work_sync may leave a small time window
for race condition and is dangerous.

Change-Id: I601b7b86850db3ed4f4990fd796de663401451ca
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  6 +-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 12 +++---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5519f31b2c00..53c47353c7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7108,11 +7108,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
-		if (!enable) {
-			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		} else
-			amdgpu_gfx_off_ctrl(adev, true);
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d89359485997..384ebabf8605 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5031,10 +5031,9 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
-		if (!enable) {
+		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		}
+
 		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
 			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
 			gfx_v9_0_enable_sck_slow_down_on_power_down(adev, true);
@@ -5058,12 +5057,7 @@ static int gfx_v9_0_set_powergating_state(void *handle,
 			amdgpu_gfx_off_ctrl(adev, true);
 		break;
 	case CHIP_VEGA12:
-		if (!enable) {
-			amdgpu_gfx_off_ctrl(adev, false);
-			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-		} else {
-			amdgpu_gfx_off_ctrl(adev, true);
-		}
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
