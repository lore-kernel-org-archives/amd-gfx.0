Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD03C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391F410E476;
	Wed, 31 May 2023 04:49:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABA810E475
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gozNNth+sjdqXRkBxnDqhOfP0oDcVkBT6jLJLL3r1HNs32lqjYZsI9o+CiQvRD3FWQJGSGCA5canX4KTR+eaPmyKvG7nhSrHbHZ+6+YxLRhj/0ZOtKvx8Yrzo1utTLkMLRz9Wz5uX7rlVksV9Pu2oZrs9WwFny7OIUbO5+NUzWtNwQXpW+H2/ZCb/2IVXxyOys8OTl+aIDtx3EjpdKQg0bTSti5kG+AnK+8PieRUVC2/Xu2/Bv/++Uh3qYW805cxHQcK7BjmsQKjvYsw5RvcOC2Uvtf4IrOX4qHQCVmb0o04WuxMx+X83vMEX4PeDH6K2u9Hu4c2k/WirdDRzslBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dbjgW2vD7R1r/5rH7h984MA9G3UA9BH/dOwUok3xQE=;
 b=E4Z6llUdmoEEBy6duh58BvYrLnco0L0F8ZEy7GiYM80i5l/iqH1EumBOGAYKskzxc+xd6PRlo+G/iUvydlM9vrGKPjV65sca+GyjgnWTE1H/vfCpsYdjpebTvrq3/GcIC31RtCWQQlT9mEE8eSOiRR31tFNzh4ffvAKGzYigMqEqyCDZfw87K7SG61yPVlhGqBXunTjjFu0Mu4cwitH40OdtX1DvGpuSLiGe3obD7TIlD252iuCDX0SbE2ZodDAKu1fmiOQYFqyzTvNuiVMr41ltepY0PzTSqPjaPl3Mu8BzpXJ4XerXZ1MT/g51r/NYOEb/IsYAmkq1BB9uyDersQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dbjgW2vD7R1r/5rH7h984MA9G3UA9BH/dOwUok3xQE=;
 b=PeLAOnVLPIQWIqZhViwyJxPhsYzewBQ0Yonn1yXuDR+XgRPPlFK2yMB0TWETpSO6qhe5Qxe/nzJSisVEmU5u3FVlwv1ALW6AS1UDG7xIFNckNiq1gPcAfI2ONmRHEdXjKnZUPqLL4VewRDw8TGqe4q0mlxqLu0zGbLT6rZrFszo=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:35 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::d4) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:35 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:31 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] Revert "drm/amd/display: cache trace buffer size"
Date: Wed, 31 May 2023 12:48:09 +0800
Message-ID: <20230531044813.145361-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 20895e54-a7da-4bf9-66fd-08db61926ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MoS4vv1hp3PWlCI8DfyoLsJGDcUGdCbrYePSXXqtLBLq8C4XyXZVcgquhisVOM9UHXN7ri92mPnesU9anbnCGiPuANQWEQ+r87uwMBdeb23yREU7y0fN8PEzpWoLJ6tFXjCHGjipfQ5D05gkC0KSqoCA05OQbjcg2OcC/4pTWIWaRu8Gfh7dFmPGrt7n8KmqU3XhpJatBkCXLt2bzreyw2Hprw6tfjYrr40KjbigfCGKF8ZVhPA7GOnstrXXyNkZyxbmXf9iAepZr7MTpl8UTD1GfOfpLzhIfLWETVj9U8rixf8uMoa7yrbopb9LZexznJcmyTejBubGHA60CzbnohaEpM4GwmMxnwYJ6UX22pBx/GPYx8l8x8RRCkHly1a8uBqsU40uokKwp+r+YKY/mK4K4C+iTBdYW8/tZ8cgylJSYr+ELlnHaG+U2BI5O+XL6KUzbvhbbag6r9aMZ2B8Z8dGZk+UxM97GEknkB0A1RybwSMBMlk+ZNvJrPCMJXszfjBsqtIqnMZh41KKJ5MuD+A63ve82lsB/JQJHbf5ihj1CBO8YJtO3No6I8GW7MUCO859zQVZDnkwF4oNXUtkn3YjbnYNZJ39bt4Rkx9b8yuYeZMtFI0gp679ldxqr6K4NnnFga0k9Fk4frD2NN/7yFwVOXedno3bbN/CMWsWiObQZ4cV+tFlU6XuWMnHlMQ6KBZZRqxB9wJG4ejX8V/uCil92KhGp1y19jXfyG+BAIaFYfOi+BqyNQ/Nf6G5SLp++c6EsVjJrDpQKFdPk47lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(316002)(83380400001)(426003)(336012)(47076005)(186003)(16526019)(6666004)(6916009)(36860700001)(70206006)(478600001)(54906003)(4326008)(70586007)(7696005)(5660300002)(26005)(44832011)(1076003)(41300700001)(8676002)(2906002)(8936002)(40480700001)(82310400005)(86362001)(82740400003)(81166007)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:35.4400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20895e54-a7da-4bf9-66fd-08db61926ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

Revert commit 9caa026e4e65 ("drm/amd/display: cache trace buffer size")
to fix regression found in tests.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 1 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index e210cb082ebd..7c9a2b34bd05 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -428,7 +428,6 @@ struct dmub_srv {
 	enum dmub_asic asic;
 	void *user_ctx;
 	uint32_t fw_version;
-	uint32_t trace_buffer_size;
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
 	volatile const struct dmub_fw_state *fw_state;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 8b9af18e84fe..9e9a6a44a7ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -427,8 +427,6 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	dmub->trace_buffer_size = trace_buffer_size;
-
 	trace_buff->base = dmub_align(mail->top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
-- 
2.40.1

