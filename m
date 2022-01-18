Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EC0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 16:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AC310E5DC;
	Tue, 18 Jan 2022 16:40:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739DA10E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 16:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBeOVKJ/4iwOrr8+esE90QCoGFRiiUEF9y6wc1BIaI0Tz2W9QHO0aCfKWPKbfDjzHP18L7b9q/AshwBrXytYkbW5aXMDc0OUoKiRkr0BrKo83abqcBez8yCqsbnH+w0/UVP+AEZ8WhvyzYeMVCVe0IXBUmchbO2tFxGzDLJZ9rLmDTvrlOHenyat8Nk/0EgwMxbW4CzKqSMZDgMprLjSrtmKe9I3RUef6sEb+fDVj3jYse7HRXunRVrMRwmLVjdBCFJyv/aVEKpUSQE37ITdJ8xlHswfhXn1JGEpxhIosL2tL//X83T7NXjX/PZ2PhXDsdf8PaNTXo1jWBG4DLNqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2pYaCajHnigTnKnRZ6Ph58kRU7JyzReH5737ji9JmQ=;
 b=cPTIvLDqB0JwVAvtqF7NXq03hrlVG8ue3ZClD1bSjFcCfbeWQoZorjpl+AJ8AJge3/gOCZIwhsG3iI0uM37jIOkSUTvnCdHQrB+RCAE9/0VsPC9q0fqbz99RcakG2DVqYfe576HIit2CfOSC4RsZOTCwZHsgsV3aua+z5pgJTjCEeRQf6qYvfl7+ULH06QPT/40bX2oLV4M6Q6MX5DPE2DZm8AsWABbP9XOfwMZUG6QtOLLx0kOPrOi3Dw/PaJAADipn7II+3EtZbLR/lGCY6ggZ5NJQPr5U/3sX7It6CKel4G7g9sPnb0aOhaAXcoQb/btoeXOe0MghnTKlJXNDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2pYaCajHnigTnKnRZ6Ph58kRU7JyzReH5737ji9JmQ=;
 b=zNBl/eLj5HIvG6KadEVGJfpQV8616DpPSZcPe0omt9Yw1E2maZloHTtCq9Hral49eowdyPObMzslId6nCE/c/drZnC7hpXkDP4tyM6RkZtwK0Il2u/r1qmtu+SnGZzmYkEeua0B6K+eFCzjPV/dscZZS5hXhApUuG+eIoZLnk7Q=
Received: from DM5PR20CA0044.namprd20.prod.outlook.com (2603:10b6:3:13d::30)
 by BN6PR12MB1570.namprd12.prod.outlook.com (2603:10b6:405:5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 16:40:17 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::8b) by DM5PR20CA0044.outlook.office365.com
 (2603:10b6:3:13d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 16:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 16:40:16 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 10:40:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Mark Yacoub <markyacoub@chromium.org>, Leo Li <sunpeng.li@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Copy crc_skip_count when duplicating CRTC
 state
Date: Tue, 18 Jan 2022 11:40:04 -0500
Message-ID: <20220118164004.601780-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe6e8a1-5c9b-4ac6-b4e3-08d9daa13556
X-MS-TrafficTypeDiagnostic: BN6PR12MB1570:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1570B62252E042D73A8CC6CE98589@BN6PR12MB1570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh6rT4UYrwbtuet2ur0OY6XUrz8IB3rutjSn2SGLpkQ2ND+skjN7sUFvRkSkX2n3GYey+cHxd9k41vc/1mOjGGCilJU+AC26OrnQKYpXwSTQPxErPeS711YK895IdNW/btcKqxkz3C8xMKB7lC+S7rsxa/fMnjBGosm2JsmIGZkcAGkbs2QB1sH7e3qpAxmPNBZxo6ohmSjdfSQ6myklNRgfeil/fz5LNVseX513MKbNhz50D3H5I6OMeYTvIr7e2SdzJUp3nTMesUhWXTqZjadZPbknE/hNffN9cRdAeMkBrwhhyD6e//qVFeHvYuRq3XT5hSEmIj5Ae3OIA/DnRfOwGQYTOKYFcmI8K600T8WS1TOpZmyrmPsmYP8J+BfJ6IoJHy/Cp+5+n6YiE6m5DnlWFJltDwQxrN8+r2xOm55oUpp3OqU5vaXL3NnC//x5SBRqSs3fSRMx5PwKhRt/SbinaH/aisxUmU2tuwRjxw1gXKn0KVQHyWr/a39/K0napX4TQ2RYy9lDIJULy/HPv9SznJ6ORFxgP3XdwHo0PtQExOWcSsz61nN8jZY7/BJI256U23B8O2NRyuXpMfKSxiU4hGOf/aOtd/MsHG+C7FgwSvsgl+Wh4WdKdH9ykQXE/xpURX/I34wV2ajCLUJPEM6k6tEpQ+Dh3WJpasxkygUv3uL5qYneWQNJyeRDv4kGD9pSSuhl3pSVQRKKwsyzRFSY9Vw3uHeqUTLlK3PJng1tcUnQLXG8G1rFbqBqAoJz0PuVaDNHfgFvhPeEKHyY1FOOdB2oXtb70R8Szry9TRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(16526019)(186003)(82310400004)(40460700001)(2906002)(86362001)(356005)(110136005)(54906003)(316002)(6636002)(81166007)(47076005)(36756003)(5660300002)(8936002)(426003)(6666004)(4326008)(8676002)(2616005)(1076003)(36860700001)(70586007)(70206006)(508600001)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 16:40:16.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe6e8a1-5c9b-4ac6-b4e3-08d9daa13556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1570
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
Cc: Nicholas Choi <Nicholas.Choi@amd.com>, amd-gfx@lists.freedesktop.org,
 Hayden Goodfellow <hayden.goodfellow@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]
crc_skip_count is used to track how many frames to skip to allow the OTG
CRC engine to "warm up" before it outputs correct CRC values.
Experimentally, this seems to be 2 frames.

When duplicating CRTC states, this value was not copied to the
duplicated state. Therefore, when this state is committed, we will
needlessly wait 2 frames before outputing CRC values. Even if the CRC
engine is already warmed up.

[How]
Copy the crc_skip_count as part of dm_crtc_duplicate_state.

Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Hayden Goodfellow <hayden.goodfellow@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Choi <Nicholas.Choi@amd.com>

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87299e62fe12..5482b0925396 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6568,6 +6568,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
+	state->crc_skip_count = cur->crc_skip_count;
 	state->force_dpms_off = cur->force_dpms_off;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
-- 
2.25.1

