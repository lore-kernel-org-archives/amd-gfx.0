Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623E3C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 18:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CA210E4AC;
	Mon, 24 Mar 2025 18:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2e2fmFeG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A1D10E4AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 18:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5g0SmIEhWcoj0cf/lxyjUkCgDRrxrrnRt0GjbmAYj9g8gvs8nbigoW/6S7YKwckppodLH6jaCh2U773EwfZtW9n1SEUrxSO7MayE8nelu+u1OTOqjQchI7Y0SlqW0o0qf4kOcsso7zADpgEBsBkuWcuDYjOdY76gVvfCsUgeeRWY04jPdkm++erBX2IXQU9bqMmqGtcCW4iheQiEfjgLnLNUQoeoWEPdwmXMaa+XY/XS5K6t/PKsc4ygathBsxfwU9zdDgUM+shE4T4Yu72FJNqc5LEVBoVp+yauPlYAHD0LGXu4xGprv5l25RTAK6HVdDpLnTZ8DQNo6l/zzXkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CgURf1HhBMIHspP5GP8/2HF03Yw5KT6NdUNsJkf+Fc=;
 b=OrLlr9p72+j3a5ADRgKnehnAHAl4H9w18uAKhaAMpnPXmtj2CCu2FJNKQx4N+lny8ZiT8DFEvoOgXyFJxcoMaISAc0qPgUqLltuDdcERuvaFwgYItjuPO3kWJXLJQmryFUpy1rJVfkc3uAxICtyM0ympuzuVg1wNponQdIUNEZl/4rHY09AcjqdE93HQ5oeHR6DNLVsM/szt/FGaAd+TP/C1sdNTYuwC1zuAjtOv3qM3D/bfGjie+D/o4pbpokG7l1lmiz/e67Wl4gx/GG0ypNqNw7iXWGtdCp+twJ8G8xEWZHEDI+JcH5n3wdJfyyD2PQ88jmH40SNXIIV4gWvlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CgURf1HhBMIHspP5GP8/2HF03Yw5KT6NdUNsJkf+Fc=;
 b=2e2fmFeGXcm9wxT/suX7f7CV7EOwwKsIMGGUAJegAa66c+IwzT4xVmxrW2gdTr/OXWlmZXC5sBKWqFwuyNM2gUV+STLgR27N1nexqOH0XYks9p/HkXSy59fQliylflxxEEhbX8opEeAdoPZWnUnuTEsS7uDr0kwPiE95Pq4Rurw=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 18:45:32 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::17) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 18:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 18:45:31 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 13:45:29 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <siqueira@igalia.com>,
 <mario.limonciello@amd.com>
CC: <aurabindo.pillai@amd.com>, <alex.hung@amd.com>,
 <saleemkhan.jamadar@amd.com>
Subject: [PATCH v2] drm/amd/display: add proper error message for vblank init
Date: Tue, 25 Mar 2025 00:15:08 +0530
Message-ID: <20250324184508.1217038-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: d702183c-616a-496c-0a18-08dd6b040e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZsopT/voCST5+WxiAXdizN1GJiLpmDPUYYnt+TftwGQaVF3T+OVj8BITz5T+?=
 =?us-ascii?Q?XCpqOceiQKQGvePg2afcFu6Gx2pzIejc5So7SGI6kq3t+qikk63CD4QTXegS?=
 =?us-ascii?Q?5lj7Di4WK92rxozEyRRxuXdp+8eegb8Z6zIofKr9DsXlmWf/jqRyPoY/8UXS?=
 =?us-ascii?Q?xdmM24jZUPrZg1q6Y78PDAer61k8U5IgaiyArLf37/etjSiA4fbCODZ1pZq8?=
 =?us-ascii?Q?sHrZodOC/Wp/YZNcsSuVl1xI7rhVzM7FJNa5ZlhztN58u8glk96PrVXWuqlo?=
 =?us-ascii?Q?ndFiC2dWfh1qMYduIyowtJiUNN2sQXrxCswymhR/jmQZu55Q+AU460J87qZd?=
 =?us-ascii?Q?lMvZ9sEi8t3BMrJmM+TMJ9Ec+sFcHJlfquOzCjn+N5z43tlbGORCbc/j0wty?=
 =?us-ascii?Q?SchutrvVgkC5ExMdYGTp00o0TQntO2xhIUvIv9Q8EfdV8OYb01OCglDNNbbl?=
 =?us-ascii?Q?mCc0jsmPsG0vOK296/IvpI5raR1evtc0SBKaj9Em+/LRfX7bC596oAw+nqz9?=
 =?us-ascii?Q?cFI/8i0z7HGidyNWQXEi67qwip1bxyAblYeKMAoeGcNTFfq6ihYXA/ofQ2ht?=
 =?us-ascii?Q?+C7Q1M5cd9bhaHY6+rqUiJbD2vwsIH9i8maRS4Lu/hdpDacaf57Ef0SyYer6?=
 =?us-ascii?Q?OUt/9ttOZ99Pf4z5xG3Pz83ndDv4wPrK02Xs35rKzFLF+YTztRYcMb9kPRFL?=
 =?us-ascii?Q?BAHOMCleYT/syJjIOVWnAGywDxOt8qN5xy8hoO/A7ZVjYGdRkjgKUyswlLLC?=
 =?us-ascii?Q?aG+R5zZ1R7dZkpVahbqU2C7HMJgZ1dls+aDLh25nz43Mu854HzJV/Q2tHarK?=
 =?us-ascii?Q?p2FA+csXMDVqzYNH+rCnY1Dp09kasZwAN73XhdN++V49tPxo6KlecGexqCRl?=
 =?us-ascii?Q?/jT9TntpO/jgZ/B9yJxqA0Wr7wAohkVd/Qq9suTJoFK7kdV9eewUv+c21Ao1?=
 =?us-ascii?Q?EGk7Os1A9ioHODhS99Cmm03N1DmciCj73x2x/5go8/q1GkYbbeJVXdE97Osu?=
 =?us-ascii?Q?bpYMZ9LeUPl8EuExoQT7zNZ72b4vXEJRMslD10JqlmeVZlUq0/7KsQLo8Nmu?=
 =?us-ascii?Q?ar08EuUp/wKC/TtKUyMN1RGo6Ou2POHb83yJCxb7xqGv2Xg+t7zeNVzfZcIu?=
 =?us-ascii?Q?AzCDyNLs/FY0ken60YqN6WrsQI7kreezcghPeTZ80roEszDr9URwM9+2xfts?=
 =?us-ascii?Q?Wi36IIbtO43HlAEwRXVzzzRXRP4zhgn2CusBWlP3mKuGEPFKmnSd222HwYoU?=
 =?us-ascii?Q?MT+goEIbJG1fGFl2+iW5zCW9oUR6xiFNMfibLqhgCiLURENmjO9+1WebNAnL?=
 =?us-ascii?Q?NIdoqqQceOktPficlRGLqQDgr3cL8UlVDCsKBry8rEDMqUJE2xPbFfIUzHLG?=
 =?us-ascii?Q?ZH4VyV4LAmZbIKs2sXaDp98cUAh1XECTVJZLx7SNfbcG0kKlhfM/X9qCalsc?=
 =?us-ascii?Q?rj7assTmbaMmxMEp3rJTQyuC4avNNGAqMPLIAoHMA+SXD+ysO3EGkBuVhBhz?=
 =?us-ascii?Q?qcQJUjnTS5tXTIU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 18:45:31.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d702183c-616a-496c-0a18-08dd6b040e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

Hi Mario,

Made the suggested change.

Regards,
Saleem

--------------2.34.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


v1 - DRM_ERROR to drm_err (Mario)

Update message to identifiy the vblank initialization fail case

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--------------2.34.1
Content-Type: text/x-patch; name="v2-0001-drm-amd-display-add-proper-error-message-for-vbla.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="v2-0001-drm-amd-display-add-proper-error-message-for-vbla.patch"

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dd9bf58eac5..1d3585149b0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2217,8 +2217,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
-		DRM_ERROR(
-		"amdgpu: failed to initialize sw for display support.\n");
+		drm_err(adev_to_drm(adev),
+		"amdgpu: failed to initialize vblank sw for display support.\n");
 		goto error;
 	}
 

--------------2.34.1--


