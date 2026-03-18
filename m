Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3BBFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8F710E65D;
	Wed, 18 Mar 2026 01:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBfpD4DC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5D710E65C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijKW0QUXsMl7t8DADqFKeuJ25V4jS0UTLSpmwAm6xW/S8Mc5WkR4VfIJwzxyN22PK2wPo1yunuKGLwam+GtHrkXFkwaWV9BLrbMczWHbAodqNz5dMJ+X8V58QlE/yqNlDp6OHIs0BT9oEEgfAXK59udvRGn+IZwfbis590KK7EEg/sEipjKF3vEpVE1DAKIlBP27HC2iYHBHbng0Rt03NDM7QToMTFxIXfQZ7B7gehGFUjAVlk/mORp0C3hTxQs55O0OHX9Xei/0CgmagYrTdSbuPyrM37HXL/arvEwttwRSrwjGyNzNqz7G4xU/vagvMs8c/Th2q0JGziTrjYzS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kldbVdUewo/RbTGRJwQe+dfjEBWBsZQOHOVdzmZPcBY=;
 b=I4kBcI6ckyJ+VL7lSoXDs5aHPty4SHUsreUSuvwcnX4y7aKvEgqKYFYylffYKZLL8qW04K+tOGMHROHHFNWfth+6u1R1E5B4RqWjfUQvUzA6As7aeORkaUMUBNTd9fXnUszOinFO6KoOy4idQRBHHLycmxM2hjNcQzP2UbnvOaqITphfxOyZzIpuqqRX16tFvS6rDK73ZFETWbj1wn8CV+knuZD1v8/zRp4dw/083K/uzy+LFIC3zy8Qru27fpYv8inLxvRpOl3B1quQbCG3SmIexo2SpdBaov5dFRYyBdNB8dNRv7mEGRqWKahZaEq4hlkVHXAWPotQHmpHVw0o3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kldbVdUewo/RbTGRJwQe+dfjEBWBsZQOHOVdzmZPcBY=;
 b=aBfpD4DCtK2lKecGWj9dYX7aAIZ6kojdYdH4C/utrbmEjoNttIBN1hCfcHEkHw/X2tn6s+sQWqRFE0Dy0JYa5PqlI3DEeWIvCdpW0BEP7Q++gpyjmgyYuqSUOW5fuk6K9bi0bBFVdCjytZzZxer5cnUJeWdnzNN8Cz1FZjCzQ58=
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:02:43 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::ac) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:42 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:38 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 27/31] drm/amd/display: Remove unnecessary completion flag for
 secure display
Date: Wed, 18 Mar 2026 08:59:36 +0800
Message-ID: <20260318010224.513094-28-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d28a882-5ceb-42f7-21d4-08de848a0f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7ltaLB9hRUQ+XgMGxFgYce/OXHHuyV9Yb/HkOFMj+EUDvfVMScSt4Jzz+BFm6gXaBQkul5Tciqgd6tAAAHBxgQsdjBFJzUsx+dXGVK4bsAQ/UXGbox6vwVfNIaEg1EddzxJkccO6BYqcXhEtL7DWIBoR3+Z0XaYleRPHce706UzXWnWeLgcoEqXAeBAbZtT6u/CAtHDKNgE5YOsHRj7mkDrt2KgmcSlVwsLs9wfRU9E622JpF3RSfFtOp6kXA3SB1W5TsCXvbA7LAPxen1IMm/3CZ9Sih8qHeovnXutGCSSJP4NfiR20yKZy7Z/+QBr8qsfczcrBeFUW3VG78YshM4mbJQm2YxZp3pHQZ3rTsNgHGxJGran+L7zng9TdyoVm9BSCOERNOIqho/CvrkNvy4bXxIj6jqZA0L46KvFZ8tZpO28mKeTs8JJI3e4l+n5bTNH5ao+YhPGxQYdG4eXuHFNFIxns7bQLxlr3+pBlUZwFeGTtMTJknEu+5uc8sPiXXpq2qXJcN0T54tA60a0fWaojfkMqEJsFDZpJyCswzyS2f6UH7cwsKKfNacem0KDwt5mvobPegC3w234bFNYugnMR/6w/BGnuCxKDfRCCrmhBKHWGgwbWT+m6PKZJ8/+BOkmpRUM5wT10OTTtl8asydnzw8Aq3o7pFMLW/ENk+OyugdLf1V+8d6LXJkV0ng6b3yduIeX0Kr7XPqO5jt0lnRJFLc0cXP/WsGjUImwLOz1dcvzpUiCow3JJMmJQZrn8rt27G3Jb8u2A9tYLJxTleQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yVdWFfwhhHd87JSU3hT3HmgEyu4CEABYdS7cTrM8U7uYSKvztACoy4ma0PwTwaUNfDLKI/N99srkT0hF77MV/6bfP2+pa5Jp9HWuZ1r3Q6jdzN1NPTvs8AGxLxZ3ldc74cWmMBFt+2a3gO6fI9uX8Lo1qvQaeq9ZuaPFneW5UWAtfI1Q8Gvp9WT8hsKywGZB1Rt0MsE1xEXviqJczBsvw62e16EE1IN8ccck1fF/Bv3I8hR6A4yze6Q6ugKwvFDZgM22keBlaUzATHCs5TUBS+7a5bAyYZ+RKSrY6RsvOmY7PdFMyvHWI390Oe5Y2Ffv6fVIcASXSNxJbW5QJe5GL3So7WR7zFthaIaf5RfO6EyU9sYft+jSStM1WFPdK9lmvq5ICOnNRvxh6tFGjWRV17CnfVL8D6X8hOe8RD2gVSj9LKFvi7cNNuDax3/sW2un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:42.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d28a882-5ceb-42f7-21d4-08de848a0f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

From: Wayne Lin <Wayne.Lin@amd.com>

The completion flag is not used in secure display today.
Remove unnecessary code.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 7 -------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 1b03f2bf8d7a..dd79866df1fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -812,7 +812,6 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	unsigned long flags1;
 	bool forward_roi_change = false;
 	bool notify_ta = false;
-	bool all_crc_ready = true;
 	struct dc_stream_state *stream_state;
 	int i;
 
@@ -936,9 +935,6 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 			continue;
 		}
 
-		if (!crtc_ctx->crc_info.crc[i].crc_ready)
-			all_crc_ready = false;
-
 		if (reset_crc_frame_count[i] || crtc_ctx->crc_info.crc[i].frame_count == UINT_MAX)
 			/* Reset the reference frame count after user update the ROI
 			 * or it reaches the maximum value.
@@ -948,9 +944,6 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 			crtc_ctx->crc_info.crc[i].frame_count += 1;
 	}
 	spin_unlock_irqrestore(&crtc_ctx->crc_info.lock, flags1);
-
-	if (all_crc_ready)
-		complete_all(&crtc_ctx->crc_info.completion);
 }
 
 void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 95bdb8699d7f..8538513ea879 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -70,7 +70,6 @@ struct crc_data {
 
 struct crc_info {
 	struct crc_data crc[MAX_CRC_WINDOW_NUM];
-	struct completion completion;
 	spinlock_t lock;
 };
 
-- 
2.43.0

