Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F66C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3845010F3D5;
	Thu,  9 Jul 2026 06:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K22nSbwq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7E410E028
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVI24D2P5JPq7G67NMamMyVtBCSpgx/V/UBQ7PRRXLhDm6oDdGwhzrkHmHYm7nrgE9YP0Xon7WqkWi3pMV6mMF+p6EP5S/j0Rl6dx5Zh2b56EN1Zyk/Q+9kIVaAqxu+GPBpMkKELMpL5tvBzP/bTlgA9XnXHFwH6djipz5sCIyPQwDZfNk0TYozrwhgaiZi6jvBHv4ny1a+JTUTd/0Dz66gomYZo9rjP0+I4mozOxJiYue3FWKFjw3lWmMlm2DmxiINgC2JUyvOn4F91y+f9J/O6YoDs3/XQM8eKpNYsDbN9APjt1TnbCSrFNlatPUEGTg+0Y2yL7PFSmkVAaWmFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAhqZvzHKL1kKpzYlU2PG3m42Zh2koSMEgSdrl7fG3A=;
 b=ZyexovxFhat7GJYSvnNU0cAPTgMUpn8X3f3NRHkMGBhYhxXxFfP55oezz1gx66w0ZEASF9Uxa+fa0VS0ZrUt6o9RMUwPAbHtgZTljAmWVSTG8kCslMVtym7cE7ZLvf9olGW0t/9gVEnQFi9a5xc4iWpVhGQigSwmzL/pcKegPc8XD2h5GMhtOT4CoGfiYsDKJWWvEQFGk8ajEi7tD0c7BaJdYfy6PqQzi/HGzgqL9/1BZS7tEyWM/3Oz3/SmNqj/sj2FjoEcZA5zRIaNHc8Kz52bdVn2i8kCmnTCYp4YYmndddyj3gFQFlIRURqmRwbopTcxU5dL/6ED83MAG5DIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAhqZvzHKL1kKpzYlU2PG3m42Zh2koSMEgSdrl7fG3A=;
 b=K22nSbwqPWqMLgwHxUeQTOEnRLEGACNr8S+/YWVLyXr73aFYqi7+b2+RTRn1/Z5TqTQdjxTrvCxYnRFK7yhkoxf7yzCFTmrSEZ2ElLGLfrEOVhKnnV56mdlzTdYbWe9utrEGBlOXBEZh4Vc6iJ77WjEpWJYj3ocUP9GHmo2v82o=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:59:16 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::9b) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/mes11: enable MES process/gang load from MES
 local mem
Date: Thu, 9 Jul 2026 14:58:56 +0800
Message-ID: <20260709065856.472296-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709065856.472296-1-Prike.Liang@amd.com>
References: <20260709065856.472296-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 2558ac82-8cb5-4e03-d90c-08dedd87975e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SXAIcu2bnjmzCc/PD0rZW99KaV4qLgCJvgVsBDMxxe4jsD5GNggQQq8Ndy1K4mvAOoqZRF10jyzNmnM4Vftr1RaHjH6/KXEkuI3tQS6bLRxRqtScaUGv9KDA5rdgOQ2CNiRvYF2fQ4k5tjiR3+9m3nk/9+6F2AVhzOf/PQIHBVwgY0f3jfdETHtWpQ4Ub6Tnc3QEEbetK2EHuurZqjMITetyJK9Gq1tN2ULz8h5mTTrl1h44sF6L7HebXxR3gAF/X04ctXlacDR2RuxyWaQx/UoKxzPaVawQVHeBlIfrwzZyDLwDGZ9SaUTGScRnOi4lfjfjqtkAlZ7ZxnvAaYw0XdwAuFsD2FxkXVFzVYhmqEjShwqf/U5fDd+bpGnZ5eaGQ2nNfp22YAuIw4gdiZBFbh5eujRcwex5MBwGV7DNJigfGSDdCfcvBhtmOwGV29zBp97fsYfL4ttd1zifaA7y1mNCM75m8DWkxDbz1bAjyshPgtMqnIea32ODYcJhxSPwMoLYtaasZVGu00CPzQyTh3a2cYiFk13PUM6CwHy2s5OP3WdrCdcnw2/7Fe2uzWFrHe0PpAX7Nlc1ZJQ9+djO2MxxCsWGlp5LKo1rXRoE5rfDG9vyfL8om443xoypvajbT2Sn0RtkbNAl2PWzggbW4ZXkrHs3+QoSCPLhO7qZHNbGYRChzr0uMw+hT0HXKsc0WgMd6Tkffdj+uIsl5IEtxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxKuEQ4bGdsL7ASb0SXN8+6iBfqz/+aF23zTRng3drJKObG6uFKhuT4NxNx4VTMQzyzGFl0jE9091a8+8QySQM9Hx0HYLCBk2DhVmhjDv8wRYkghd30WY40jxq0wee6WvOauwVJFm7e5EJjE2kO9Z8WjWkbTwByP+rRYDeXHxaEyjVt6sBo4D46sizudKhYcLfMxW/Op67+CsJ6rwlniVuEiemZOxZulw13F3WGh3cRWHm7IsediLOvjvwF1U+EWEhg62cs9tNkP+MciS5eiTAsWF/fgwPbPDO5ftjMtJ1P+H9KsbyFOIQzg83/nfqL03wttJtHRkNnGYNEMHuDxhrqPmnZ54YzDS3eGzOvdrwnO28NbKprOLXCQltfC87XFV3m2MUQAoelopgIqo5tujkBdX6NDpOyjpbWRpS3nGf3UZBVkNJxSJ2+WXrb9xKzL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:16.1803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558ac82-8cb5-4e03-d90c-08dedd87975e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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

Enable the MES process/gang context load from MES local memory,
this will reduce the MES firmware and driver handshake latency.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c2129ea6614b..a85387122b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1012,6 +1012,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
 
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
@@ -1945,6 +1946,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
+	adev->mes.use_rs64mem = true;
+
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v11_0_load_microcode(adev,
@@ -1964,11 +1967,12 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	/* Allocate GPU buffer for array size query results */
 	r = amdgpu_mes_rs64mem_init(&adev->mes);
-	if (r)
+	if (r) {
 		dev_warn(adev->dev,
 			 "RS64 local memory init failed (%d), "
 			 "falling back to system memory path\n", r);
-
+		adev->mes.use_rs64mem = false;
+	}
 	r = mes_v11_0_set_hw_resources(&adev->mes);
 
 	if (r)
@@ -1985,6 +1989,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 				 "Failed to query ctx array sizes (%d), "
 				 "disabling RS64 local memory\n", r);
 			/* Continue without optimization - not fatal */
+			adev->mes.use_rs64mem = false;
 		}
 	}
 
-- 
2.34.1

