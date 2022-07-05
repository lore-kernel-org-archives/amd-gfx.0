Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 11:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D56C10E303;
	Tue,  5 Jul 2022 11:29:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1A910FB70
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 06:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjq6LwYP8Ja62gPBh91hvnhnUXj97/0vDOu2HL1pFXwhS7jogxCQM9KzMsbH9GMuV6FIqCj6OjzAsbkwOtiByzkdLsqU8QUN3JrwBMGXWuG+1eHQRJBKfAt4RzzF1APP7/v+YE1Nca6B4Yp1hijdmvmoCyyus3NyGwNYhG3ugVHaXB8Fc7MRjJd3pB4p46EYqTBnre64LBZwh2N2ZYTPg9TybxuOym6W63KygASY87xMHTG8CqIWHn37Dd08U887t6U9yTk6EUS8m0zt30OC6KbZY+alSpvfMn6OhMYCWIv/vdHxoWQqLKEURh8RPH1D6IoQjQ5PZq2uwfaRAlxkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnWfub+u7vJA0gcBGjE9YeU8K0FjWCyrAbrOxfsEcbY=;
 b=SjIKBaDZo87vcirKOm2sJFV1pNRUI5FFzxUql6axTsd15GQcFBwsZUp0Rxd+Prt88K7v3OIlfmYSqZ81we1cg7oN+encGhX4qsWouikO73LNRMtKBTzWXB2JObZdx3Y6mV1LlfmkRKXXtOhtqTmE/SYrLq+mutxjPLqumtxg+8ll0Gz+O2VHSGUq2ZVVWU4iPWnz17k4vqd9pNRoOwH7MAFIbTtd2x1m5bQU8nai63l6enyJPIkzZ5ry8QT34OKnBWWHdbg0CP6OrsS3IdiNCskOt5mn/zlbdXMPLdJI9FofimGSLhZQy41dhp+6FrJVamC3SrZ8OVfl6SMm39wJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnWfub+u7vJA0gcBGjE9YeU8K0FjWCyrAbrOxfsEcbY=;
 b=UGcRBi66xMu2IvqWHrJJhsMs+8lbEp3UfGMGhRcfj4TBTnAhNSucRD6HIynjWwk3X5GeR1rPJSEkEuPVfNSQHmD0047Sw6Dp98R9wwGLw8A7JmC4drL5hfmX8OF9EqBLiL5eEcmZYG6Q1KQ1XGtOO0jzhh+vRlpWF1oelSbLf7M=
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 03:24:12 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ad) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Tue, 5 Jul 2022 03:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 03:24:11 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 22:24:09 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes11: fix to unmap legacy queue
Date: Tue, 5 Jul 2022 11:23:54 +0800
Message-ID: <20220705032354.978153-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0933610a-443b-4a23-157d-08da5e35d4b5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9Q11bqPiwXfejkwWfcoZQanirUa7V/ivKKZehsKL9ZQD+y75zcgzHfowHbRd2TDTdkCvWWiFIoOrK8qqk0spgcLv8t7tjnCT7X64eedSSgzKqs/uVMtYQdo9HAm2Dk78WoPaef2f3n9vT4whbjyypU3mb4LIWtb8HTDztRIh54bdEEZFVZPVTG8BBnB+i5er0DJWMn0Sh5L3kkCrjZ2InSNRXva4FyyPKkQr82tKi93WvVBX8O60fqTvT94CPNI91e2DeWClrs6lbmhUX0XR/WuSGOFwYIw3wrwq0r/kjKAjiCQlMHzY4QAkw/PRzNSAV3inGWgnMeA4/wD2z3gjBofYlChZc2bZhiwJNYb1hO2tTWR+T4KLTlCrYkY0WpMqcQV1c6StuFZSIIoWIS93BDgYzwC/kINhMhqnFW7amJxAJj+BRUJSztnQPKAtk9T2jf4aP5WCVVLZItgOrHqihtrBdZVmjz+MLQL5YcuoEwtVP61k9F6ePUvOEwjOtQJTjBY+PE60sI1leGrRepBbBqqrYMapv+vpQJfTs6a0XW/te91bZqurjxrnW52K4zN1wqGMj5bEbIgh1MoiXT9vlnpvziFgKKI+3aw0jeVeJS8XlCnW5LYmEwOwk8HlRuPuli+fMmQz9F75W6P26C+Uz/FT4UciW4kb6RS9035OO9DHbDmOJVx6/nqKtU/LGy+Rl5J5hOI/dwSsp7yO8Qhvzl9CbHcuxOfOIvH4bCQxZv2CM/zigFPwJ5djIXgeZo33ILSLpdlMYcjcZ3DJdO0TcLtBOWLSIv7W0P/5z56pQnRmMtXZkErp5+MUVsNtaQmNishMqfLqH077cXnJ9zXbBtM7jelAEyi1QofX75nQOxv3PKcj8IqaPl14nFaZNkn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(40470700004)(36756003)(26005)(7696005)(2616005)(40460700003)(47076005)(34020700004)(186003)(16526019)(82740400003)(83380400001)(1076003)(336012)(478600001)(40480700001)(2906002)(8676002)(70206006)(70586007)(4326008)(41300700001)(86362001)(82310400005)(8936002)(81166007)(5660300002)(426003)(36860700001)(6666004)(6916009)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 03:24:11.9386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0933610a-443b-4a23-157d-08da5e35d4b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES fw updated to support unmapping legacy gfx/compute queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 9 ++++-----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 6 +++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5bdc2babb070..6b07a8b23d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -216,7 +216,7 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.header.opcode = MES_SCH_API_REMOVE_QUEUE;
 	mes_remove_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset << 2;
+	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = 0;
 
 	mes_remove_queue_pkt.pipe_id = input->pipe_id;
@@ -228,10 +228,9 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 		mes_remove_queue_pkt.tf_data =
 			lower_32_bits(input->trail_fence_data);
 	} else {
-		if (input->queue_type == AMDGPU_RING_TYPE_GFX)
-			mes_remove_queue_pkt.unmap_legacy_gfx_queue = 1;
-		else
-			mes_remove_queue_pkt.unmap_kiq_utility_queue = 1;
+		mes_remove_queue_pkt.unmap_legacy_queue = 1;
+		mes_remove_queue_pkt.queue_type =
+			convert_to_mes_queue_type(input->queue_type);
 	}
 
 	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 1d37ec2cd737..80dab1146439 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -227,6 +227,7 @@ union MESAPI_SET_HW_RESOURCES {
 			uint32_t	uint32_t_all;
 		};
 		uint32_t	oversubscription_timer;
+		uint64_t        doorbell_info;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -286,7 +287,8 @@ union MESAPI__REMOVE_QUEUE {
 			uint32_t unmap_legacy_gfx_queue   : 1;
 			uint32_t unmap_kiq_utility_queue  : 1;
 			uint32_t preempt_legacy_gfx_queue : 1;
-			uint32_t reserved                 : 29;
+			uint32_t unmap_legacy_queue       : 1;
+			uint32_t reserved                 : 28;
 		};
 		struct MES_API_STATUS	    api_status;
 
@@ -295,6 +297,8 @@ union MESAPI__REMOVE_QUEUE {
 
 		uint64_t                    tf_addr;
 		uint32_t                    tf_data;
+
+		enum MES_QUEUE_TYPE         queue_type;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.35.1

