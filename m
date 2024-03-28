Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD80ECD1291
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A989D112557;
	Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PECQdFX4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B130112538
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrzM0wIHd5RQ/fvzsTpr4GUBqmNy9hdqBmDl6NLwG7pCPKqnRaD2hnxHk0H5N55a3WJ3AJHNb83L1dNgpJSixpZ0RaXmagzgWYT6hKu7Ccr0YfWlYQktmvQRm7YF0Tm0iPpBrJbQLTE7QB8oet3D08cmFxZWeb3WaPcCxb2uobndADSNkWZqrcOcJyd/Zb02e3U+7nIxy6fDyb3h820HgOVTQWmX55hSPSnWpwpXvhQSr6UO6u5uchOPgU2uvu6qKM1/St92vQqHK3IakO0WEhjJ+G+VEw4cXFDuL1k9y9gFTrbloX8VhvucUBtscp7lZlxYED39ddH5YtalDuQLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2KhXwkmP0i7o339v5Zqopdgzg8BUoBpRIy/cWwlepA=;
 b=DpmfgCveXLzI4QYjlp70n2TfOuGkhCe3IUkoYKkV+9n7CKkDifqA9kjZ4aXJBa0t63WRcFOFwVvZc++MAQIgPLb3cdHypvXr8leKAg62jiLMu/IFd3xKoH6r2S65DO9E3YhNIKunBzuniO9CX/ACbH3uZWBm8C38yUyMqVzQHhqadbHqpijSPqF/xOUg3pZmHCRPuZk+WCUtW9T3+1POoSENyhtvq9qCfkwS1l/dR89GC1z176hthkMS4qiDO8Laf5q9FtD8l8Wa/u02wwK5A9FWmw8qN0jJIGAxIXAuUhGSiHXsTaqAecy8CPLTwfUv4RhVRQc8NNoZmrqVE9oLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2KhXwkmP0i7o339v5Zqopdgzg8BUoBpRIy/cWwlepA=;
 b=PECQdFX45srUFJ1Usxl+lWQI3g4HOkSV3GMRgN9G+HECl/JZEyQq3sPE9OYBwaLzt7k/ozodnB9kyp/MjkWoXfmc/sVo81uncHdgbxPdC9laC+Sfste1KXXlafjg+ZegM3wOFyNCdI/E3i9u4Q014XifINE4/WfLBMJWN5CMMV0=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:52:08 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::b) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 35/43] drm/amd/display: Remove redundant RESERVE0 and RESERVE1
Date: Thu, 28 Mar 2024 15:50:39 -0400
Message-ID: <20240328195047.2843715-36-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cd3f54-4c4e-4bd5-7e6e-08dc4f608d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6kzzu9m/RD/RnxC8+a+gW6XR1Jh04xTQ922SqRGLalmWtxIv4WS8zbcXwiaiLKGLs3LoBv+nc2JL0pbuWcf3nhq/anG4J3PWuPsWE/t3VfuIeHbOaPwqNo7xGVl+0TuGQTPMsSFJYDYOlYag3ggTJmYR64v1C19nEALfANYhV9XZomgYhtppg+C3Sq6JBu0Ilw7Dj2vjBKAKvhG6BHvVL+AqCpNcuXs9RDJF556ieZXtP5Pp23vaio9QgpUMBQAkEBMOszMnBgWdrZvvihE3d0UqQKJAV6+SVocY1GNsD/MYSH9jdqzE0j3vknn4v2CVdg0LcYGJgdbfbavZZcMGz5IGu5adHqkfYQoDcu/NXS3V5YeeS8ca8127UYvT+7tFJuR0gMBAAG402QScCKAQ4Vcf/OuJBZFnsiNjCRYRdwDb4RI3sUF3d+bOxflbqr03ZGXNwWNo+OtqXUrvuZNrrbxoLQEDlcRGarJ4ThrYYWbjdXI7tWr4JFF85V6MRnX6wtITY8Q13slac3n1tlvyKsMwunB/kM8exGq4BYGx7u32/blfSOaven8HpCwz1zJucaA72D/1a/Ke29Bt62y1blDOvp2M566xVavQWlOYnzIJkDTH+YlXtYVhTyjJZCdDSduB4mnny8nMdT6y8h9PqkWe96gArjBWEV0WLBgNc/KJ4YRtICFF5xDdkmzPaTaG2VuHqoqidpWkgTvSxGFKDxQPtWSlmSQtTy/4hTk3MOfo6x0imhdNLufaXwRuOWX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:08.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cd3f54-4c4e-4bd5-7e6e-08dc4f608d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit drops the RESERVE0 and RESERVE1 since both of them can be
summarized as RESERVED.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index b7ad64e7b62a..b9f8eee5d2d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1222,8 +1222,7 @@ union replay_enable_and_configuration {
 		unsigned char FREESYNC_PANEL_REPLAY_MODE              :1;
 		unsigned char TIMING_DESYNC_ERROR_VERIFICATION        :1;
 		unsigned char STATE_TRANSITION_ERROR_DETECTION        :1;
-		unsigned char RESERVED0                               :1;
-		unsigned char RESERVED1                               :4;
+		unsigned char RESERVED                                :5;
 	} bits;
 	unsigned char raw;
 };
-- 
2.34.1

