Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6823EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31363610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31363610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36B26E578;
	Wed, 27 Oct 2021 22:40:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4866E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 22:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3t3GmjME8PiTyTmKe6L54Gu52mCuE9gBw1iabDlfCxlXaL2qR3OOWBYSWEZZSUjL4J3TZlCbHaYDnNoKX2MhcpQ95XUKwn1Ow5157t8rm/1dAD8PwH+W8UkntWnQN8y90M/Fd27oK7gUK/o3Cvku0w/BEsjyFc1ikldb1T8OsVEtX9dJcMMPadicUvEP0kIpNMIsJtJ7r3/YgGxYz005lE6wb8rPvFBzAHZ9baFaLObVU6od05xgS39lS2lU8I2NSFx8TSCk+YLDlneT6BHClWXOk5hBi7K1MojPvfUBNG6WSUFPvO3ABTRO+vNYFKlC2ned1Iz4E18n1Dt0UTbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHLC9gMTn6gB7gFpyxONlVoIM7YwMzch94lRcYwGnns=;
 b=ZYiNksG1B5HiSb1IIX9G/gNJXQLpLbEZqZ7vBb6mvEL7B0wN1HQbKsHuORh4UVslCYTvoZ70IfbEzZtgTEIhk68EpnQIgLTqrJUVukRFB4TpYCEinMjD7wuI48RSbhbXtoXBRan1vwgi/FTCd+PT6ETLu719Cp8PNY8PO6MvnD5mF6/OH5b8J1ba2WB83xI2GtSX+0jO1n/saDn+ddA37VWVbnHgcO8g+tt7E9MQ4CpIUqISkyu1lCljZwXKzMzONQdKeoXyzkeKCDl1XbBN6EO+Zy3AhIgsr+LMIxGBfBrxMMxxE30PhRJJNSPPuPZL2f0puwUoN0a7FKPLW7h3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHLC9gMTn6gB7gFpyxONlVoIM7YwMzch94lRcYwGnns=;
 b=AtC3v4oPiqzjB8kyjktC7MQ9GHA8aQL2uykvvB0XHy0Y0aiSC3NvvyqKxAP4BEz1YqdPhaoY6CPT5sjgVNVplouPZlrqbt2VX2f0x7hstH608PAgHhanBG5Ex3pN55APFIHQcnKpfN4xj2f6KrQXZ4hG9hNifF8MzRlEG6Wy2/Q=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 22:40:10 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::e8) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Wed, 27 Oct 2021 22:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 22:40:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 17:40:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN is
 not set
Date: Wed, 27 Oct 2021 18:39:52 -0400
Message-ID: <20211027223953.1776162-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f933feae-3256-4d78-eb79-08d9999abbf9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349640CFB151D12881D3945F7859@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygFFACPXvNOOgCgYimi5wR0za4vovwcPqZpQ/ZHstEENb3goFyb9APvocwmwsIy4ToIR0X4bLbUHfwVu4QEWmE8iX8kr63srB9CigGQamUrUtFGAb/99aC063ZPrvR3EHhoVBAOcJUwEX9ggBJbu4H8b4fN3kj7Cs0ac4Dxw7aKlWP3rsqIXUnGB9+180NSzZBNZBhtQ74bWOXVKuNX5JiQMSPaIfti7j6fA3zIsTqSOUDsq0pxWaDPV/6put3ZbHDplJQHjBsG6BQJYLfkxKUabPIPToEoKB/o6ROJwMfqNHOgplhbfmgEeQyYfeNTtveTEbCz86ts8crwCdqpj+f0XBi/dCygOMobWWOdyxra1pFGBOxvVdBINdl3X2k9WGQ7sMAVQ3vtp7Y9IenFzhvXIy3bKDJUBBM+7SvykrvNkOYx9l2Gam+S7nfIQASWi9STBAS/M4jtEVHIZiNmqeYCtO/Vt6aRq1Ig7xybEtcjxbrvyfhQXmDOQmYq1RFJhjhhSztKzPyRBZNcZLLtSh0iYoD54wIRWBELoGf65hCZK7f33qpZu102yZIUe3K3NCF3WUvcjGt4D6/n1VwS3tPg1JxJi6sQHCMFUjYBKWZOIZaajom8YT/HA0qKymSIR9PvrQo8EWYHHRlO7vcvkQr42d/aJbEQAaRITfv7Ndnd8ChZYjjB9ZyVHNOewM5SndJS/Up1M97B4dRsKkRyTvTF2Gq9pLy9hQGf5u58T8+g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(70586007)(70206006)(7696005)(83380400001)(86362001)(426003)(2616005)(8676002)(36860700001)(36756003)(8936002)(186003)(5660300002)(336012)(508600001)(26005)(6666004)(81166007)(16526019)(82310400003)(4326008)(47076005)(316002)(356005)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 22:40:10.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f933feae-3256-4d78-eb79-08d9999abbf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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

Need to guard some things with CONFIG_DRM_AMD_DC_DCN.

Fixes: 0c865d1d817b77 ("drm/amd/display: fix link training regression for 1 or 2 lane")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a9e940bd7e83..49a4d8e85bf8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -840,9 +840,11 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
 	uint32_t lane;
 
 	if (lt_settings->voltage_swing == NULL &&
-			lt_settings->pre_emphasis == NULL &&
-			lt_settings->ffe_preset == NULL &&
-			lt_settings->post_cursor2 == NULL)
+	    lt_settings->pre_emphasis == NULL &&
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	    lt_settings->ffe_preset == NULL &&
+#endif
+	    lt_settings->post_cursor2 == NULL)
 
 		return;
 
@@ -853,9 +855,10 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
 			lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
 		if (lt_settings->post_cursor2)
 			lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
-
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (lt_settings->ffe_preset)
 			lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
+#endif
 	}
 }
 
-- 
2.31.1

