Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B735606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q1vcrLZG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1812510F8B5;
	Tue, 17 Nov 2026 19:24:39 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CB410F8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTmatlXbdGWJ61XHR8P7SRntBEmMTFcM6H1JF9hvWJqD6iYDmQ4Vg7UMAKI4Rw6Z1B48TVblbGV6MKk5+PZEr91nU3uGvJskkO+rlw7yeTfDNuCR1QXaHbbyBzKut1rlxoOxoQHCtoafnbWWr1n/sYFKlbUWR6+SiNKSKGzc4YWS3vogpkhvYp9las3KkxbrDQpTRl0bbAm6E1FpJFvJPKlMblM4Wp2jvdO+K/kWO2EwFNbn99PErgBYcdrrSpsmtiikphc2oxuYNTfIrjpJdVG8wq8xFdtp9bvC50UD6rP7t4E9IRmO4YXwsisfMnqgPNl1LC/FWWV/g/keKkSRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPx7vtoSTRAMGtuzQ32bDBw2pIIvz1CdPvgbN1I498U=;
 b=D/t8CODm2om+b7j8OiLV6IR9t65ic5HN1LXawW5cq8cbS0H+mGkh+rLzZEIi3OCuZM7qXB0HI6+RGwzPXwxaXnWn+XEupWUkZ+dyxITnUPO/Z4a9eYpnRjhCO13cGBrj1obQ+Xn+LxO9OLX2SWFyGTtINNuJxSU83NTODFXNSZfzG6NQVtDSEw/yBXvxH9M8phIdtl6SJ9aQuMcBVm6fjmH+726/7fwBpJAKfeMu+YCu9Hllkuwfy9Y8hyxcjTCUYJ4fMIYZDsUOU/rUONqsmcGJQTBfh8hihuD3ODLdHNCADlnvTytEMTd3chU8SV29p4dC8JaI8qvA0VV2ismTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPx7vtoSTRAMGtuzQ32bDBw2pIIvz1CdPvgbN1I498U=;
 b=Q1vcrLZGC/pZ0auoBw7ocfZv2sXjnxwFrJHKP/OfRclxWnc0m2ZR5UMqNwHGXXHoLM4CNW9Pgg4qzYpbTuCvqB4HH5HTLFN/qKK7VwPhnivV7bVEVo7p5sHUXZ4Cb4p4/bqc0Y6BUHJYzREafQCaJGxJvl7DtbDY/FEjOwg3o9Y=
Received: from MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::19)
 by CHBPR12MB731189.namprd12.prod.outlook.com (2603:10b6:610:33d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:24:28 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::91) by MN0P220CA0026.outlook.office365.com
 (2603:10b6:208:52e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/mes11: add support for setting gang submit
Date: Tue, 17 Nov 2026 14:24:09 -0500
Message-ID: <20261117192415.810117-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|CHBPR12MB731189:EE_
X-MS-Office365-Filtering-Correlation-Id: 165e56fc-8ea7-4267-964f-08df44e06615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261009223027099003|18002099003|22082099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: xFOjJA+xb7sdxhTr6GlvT3xub4KoMaxesrEhq/4cmPWE2zWa6rXeLrrZhrFXuCJ7A58cXxcunwlrjOaNIuE8fINgchxppVC8ciwWZJcDUtsiwupbMcSIZjQQVob/F8UC7g4RPxqIV3jOMbMhCuHlLAoaYQyMu8oLW8jAMfa1dEHzTBKV3+7i+luLXQSkqMf/yDLY16s1DsOoNAAoq5pVMFUd7mZDkA21PzzHXehVnsOYpY6yFKdpC/bgNTo/O9WF9jxhZl2trk6kuckvh/8CiiOZW7/wG0JshlYsK/XbqBcTf78vX/eXa7QyQCFR9Iu9M0qasUhopQEFcySpvXL7k5c9ZjO1oB+gS0TQZf42f1s4FbzsfdDYc9FiVealqnKqW9BHCbD36fmu3OANKOk74OCG+AVcgh7DLC6FDeKJbQSAax2mqWzd3HdikeL/uTcJu0nBh14zsMVXvutJkICFPFBbowWUWvbQjHl9p+2PXijA7Dau3swrk/MC9yQrnf1esFjX0ieSxeEKAm0DlbSwamtAMz8kQ4zL0N/C6i0xLKcz8XACuNeJ9s04Eh85NgHR4ipDgLlX46LYoRzmTK5KY5xTMOQdAYZpREU1JbjA3rBQLEFGCD6osRYPMiyMQS5DbT6U7zROHjSwgkgClos6jHZ7BhsdDy11ETTCebN9Vct2JlMWe/GoBnO5VTkfggrJXODwt1phjlT6o1nflOC3xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e/HF8caxQzBuTUV/Ie/Pea+kpzC4ZV4u7MCrWA4cCXDemATGWtvv115dlD1jDlzOKBTR/dQL/ngZJakD/Z6WHGpPuZ45VlTMXt+xPL0TixCc6gYdG8D2A4x8MCksbHUWKWFe/FeC/CbkgQo4Px9qsdm6oR5w5UFDdkcIoSNsaFhR8cY6Wiy6r5kQm1rHObTfVeHEryObmAsvlj0uF4a6jIaCHRJ4ICEb/mJLmFWSbNiLpz46E1P2egD0YxDWqtM6a96bUDKSlTru6RVjusc0dHD7Y9bbuO9zggdI/oEelg42qt6k0mN8rhinyuOXhB70Glnl4Z1stkfogCpuWfv2L7SdL6f4Ifispl9CTDB1IvRGkFg29Fq7572JLIrgh1/ssBPPnj7RKjajJCEcD+52njaJ0iZ2oyYw5DFoNi8pKcvWub3WrZUUy0QUMLRx3EE4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:28.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e56fc-8ea7-4267-964f-08df44e06615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB731189
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0242fe8135374..6b6ffc05d8145 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1283,6 +1283,27 @@ static int mes_v11_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
 	return 0;
 }
 
+static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1294,6 +1315,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.enable_dbgext_irq = mes_v11_0_enable_dbgext_irq,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
+	.set_gang_submit = mes_v11_0_set_gang_submit,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.56.1

