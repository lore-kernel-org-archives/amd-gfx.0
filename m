Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2DC44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 10:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C47910E432;
	Fri, 17 Jul 2026 10:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OJoQNadN";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4299910E432
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 10:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amGijXdHbeWdCUB1vbAFuDcGA3bKAerNSNxLR55ZvO9EkGh/yICgSVOVe/Ybh9rRo09456fgiS7qi1LfqQseiF4JLDWcB5gmtdU6y79LXP46qIvUSyBRcOBpPtiN+Djb4cKfQo5SKloAuSQ5xwMgzOUtwXPmdI4oYApzWkikAGx7KICyO0Je3CAZEuhHJ8x0e7gDkasfOKGQ1TkLJdmkAUfhIBdR5qLZdZDa0EP4wIpiQNkoGSfuRNhI2lN0cnMytSLhF830yP3pWEabKkZUxTWgizFQpGdnxyYYnt06zRYNWLXBmfbhIcq90KFN1FKn3Y9vguRmPIV6W/yDWUfvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx7bskDAs+uAqnEfT8pAsKjx4F8NCE7RknLVqerkb1M=;
 b=oUFcP1kObXg83RCPFsm+H99DVLQiMBGrcRV8docYIRB+l0h44R5DSdgvvUpMb4+8OHnTXAykzu2JOnZE43kMGaAUH6qrtRI2spbIb/gFpYdhXNTi9R7EVFzw2IBHAJXhHBJqzD5qtAWXNIahg+Eb/ZN6DcLF0qlVrDFPWMy5H/neLUljYwrW4LbnTwfDaTi5aaepszeRDal3f8HoD0edtnf4WZB5K/BmZS2LzeoOplVTPBOflpzkPrjmhybNDy0vQ/WluuLYdTwMAxdsE9zy8cRYh3ixdYO6cP4lSYTAtrryq4EFOsLlwP/y0qaFNGK9BhDtZeaanC8YN9g4GiA5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx7bskDAs+uAqnEfT8pAsKjx4F8NCE7RknLVqerkb1M=;
 b=OJoQNadNS59vT3OzxL+l+SqLc0AogTHSP/J7NtbDrYMd6M80hJ2M6Gi5JOnRhniYpulevD1yn36yKLaVjIsWWGff9ocv/Ae3tyh0r1WuaEBDfJwrXhX9Fn0ITnEisDGGij3xMtYPX1LKYjSXUShKcnKKQSg2F5bLV7figvDazic=
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 10:27:02 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::4f) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend
 Transport; Fri, 17 Jul 2026 10:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:27:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 05:27:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 05:27:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes12: set connected queue index in the reset
 packet
Date: Fri, 17 Jul 2026 18:26:02 +0800
Message-ID: <20260717102658.3665597-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260717102658.3665597-1-Jesse.Zhang@amd.com>
References: <20260717102658.3665597-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f9c68c-723e-47f4-4876-08dee3edf0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: YUeLS3eDl2UEaR87lyuMs+QJIPubbtZBz04t63NbPxefZcEsvC67mr7UWIXfzki3rk/QIJS/6fac1I2ezGzyAcjUmlw1DArj+k3Lr/8HtSWKtx/5uwTYksFAQE2Gu01Y6yVyQjjfv8iwN1KKofaSJULuQYLRu6+Zxr1KEVNleW8//9lUL0F5hSA+JJOy75QIuJmm2HeqXxrnRZSutPUx4W8zrPv31S+V8fstjyzRF916OrkXbq22TUtAVI+xrE2fHgBnzWVtV7dxLnRkvu/0TSuEkOk1ybYu7SjWUySFMIqcjQwBye/qK0sXPMTi0X5W9BaxXw5HN0lI49w+8wxf7f2Nwzui0QrgUt47qxXtYyfVncOC3xfZO2+carbPKHlQR5vO/1wRGTUCV5O8JxX+H33X6KIC2DiIWLCVBZqlcWnKAelj9bwJsUF/E9Oq15NsPWqONT75+93qsJ3LUJ0qx2mXM4H86L4Pr6LAheUR06XkzYdtyv1n1PXrLA7x2GANJCpQarbQ58WnlsM2xphU0k446LPzjU1Cfnd0oGuzHeLOqQXdzQj6Ihq2ZoCwfnc6I+cjhIcsq8JGBe5U7W3ulmEF4PRx15zmMNNBggCiSQraSDG8NCm0raP0O7sJofbpOGtOKIC+BKA14VgusbIBXFPuiR6ylFFxnZWm6yrCdIKWhKyJTfLIEcCoBaIY6fBbOkg39uJJPMwFgld+f88ynw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lqxPkxlQPOtjzBGbyub8pEWbO3VMuGQtJHllkfweWTxRu9mWHkGzd+SW1xVPSOY9363z/HrBy0PNX2WyoRX6HGGP4fzITJO7KbB5yXdZQK6TojzN59P1oEubNviAi5ctC3n4sIYOlJtHoG9Bf9npHnoI82bPGMH03IidwEEebYpfPuFDfLkwSbMSJISzJsl88gVEMg3OVhCJczOY2SAIrmD1E4KWkGNY3tRfAHB7vb1FhEh9pElBvUzaq1/K2QWH5NpswPVRZjPu/BASt0t3dvUM5NPI8CZIn5sSWlhfnV4z00aLgLcEbEN7S5IKIaGlpwVpmM80YkEpU7AwY9Lx0/tNvrUApwzlWUqqDpI0s69AnFjpLAjKMkM8/FHbg1r3I3tskrPa5Xg5bOdmM7kN3wV+5a10z2NnIN5wMVe8TI7+pyLT0h8yVflf/Y+q+Am5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:27:02.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9c68c-723e-47f4-4876-08dee3edf0f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
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

Program the connected queue index into the MES reset packet on gfx12 as
well, so the CP_CNTX_STAT fallback can find and reset a CP-frozen gfx
user queue without query_status. mes_v12_api_def.h already carries the
fields.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 04465804c254..2a38d0c560b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1151,6 +1151,17 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	else
 		mes_reset_queue_pkt.hang_detect_then_reset = 1;
 
+	if (input->use_connected_queue_index) {
+		mes_reset_queue_pkt.use_connected_queue_index = 1;
+		mes_reset_queue_pkt.connected_queue_index =
+			input->connected_queue_index;
+	}
+	if (input->use_connected_queue_index_p1) {
+		mes_reset_queue_pkt.use_connected_queue_index_p1 = 1;
+		mes_reset_queue_pkt.connected_queue_index_p1 =
+			input->connected_queue_index_p1;
+	}
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
 			offsetof(union MESAPI__RESET, api_status));
-- 
2.49.0

