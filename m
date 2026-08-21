Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C492AC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D5F10F45C;
	Fri, 21 Aug 2026 19:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="byoa0qlx";
	dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 19:42:01 UTC
Received: from CO1PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244D410F45C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeD0tcfl/Q6Vit82hH70KMj1KKlCC2ir8qjL8uUoL4ktqV04484K3fOMWwb8T4i0Eb8gW5W4bpQ2yktRBZH6GPpgff0ZBMtb2HPVOCrZGCFPWSDrdE2N8+VM9RlrLuvCOYe3YznJcbkXDurVmtjeTH+RAtPR0pxzHFGg1K3zV3vg2Xsd83rGzJWz5WHW2BvNwYIJnGcoDV7h/Pzh9sbaRdI8kbbZdABMMF8yOw6Wta0pEIJHqQGOlXrym7qY9MCGagLVRT9/c0JEThmdvCADHL7MtCaw56lhjVni+lfl1BWo96b9yjoDKdnfPshDtKNJuDYpR115QhMVRQT3G0h+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNhaWko5S5RAkUwqOSGDIMUqqfsvefr2AWAYxddo3H4=;
 b=fg+aTnuWW9nGl/zfrYwobllZqutwP3fifALsCjRrQtGQ3zn1O8YQgVVrUgUuKQtzf+BGWs21ilr00Q22OwUDDmbEVYQPoMUFBc2E5eeGtk+8HHvI2AHZnmh0kQoAD8t7TWFrraTt2Ql+BXsHAgS8rwJSyXQCohQYtvp9rHOGpf51LBLMwvzJYf9RFLZgCxoThl8U9Sqr0n2dpSE4vbOS4vOfcex32CtbX7NNnE2UqkPlyhM7WHq2jXG4kEGVJvMBCr6WuuYUzb+sFxps9t6YC4ekzB1KHIeBM2/3UdhdU750Nbq4FAD958ueWA/lmXRu7rexv7Wjx+uvlpXsweDdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNhaWko5S5RAkUwqOSGDIMUqqfsvefr2AWAYxddo3H4=;
 b=byoa0qlx9SYZuH5NqSjjsHvkUDLEyh9n6tmIVXPypBXhe42zrEPrJKE2zsPRu4W/8mIo1y2qR03zT5zlFwXR8eAilGRb8u1Su2iEQ8xDhF3lEh7q6Qc5D98C6vJmZ7vsghH9ie0QUyrUr52XcKKmXGdx/Pp8etN2VHiICQS9Y5A=
Received: from PH8PR20CA0015.namprd20.prod.outlook.com (2603:10b6:510:23c::8)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:36:08 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::3c) by PH8PR20CA0015.outlook.office365.com
 (2603:10b6:510:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 80/95] drm/amdgpu: Add support to send ASP completion
Date: Fri, 21 Aug 2026 15:34:43 -0400
Message-ID: <20260821193458.808626-81-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d31ad2-44f6-4093-9a4a-08deffbb7196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8PVvA+01a+5O+J7GaAKxpZ8PSQhnM0DWrlGCFqu6svHb46I/E1RYPg1DOZkevNBY8YwoWJdaVr8WBRtQdp1a/dggU4rZKEiKGvkC0WdBvH/1nJh4yWKV2cFKoUqL++UO8JpnJ5JwHSrUiwGXE5YyfGDvsoOg0FBfwCCKH7MX5q5EJjtrEWbP7rGp5vJZWtKkt8zZNRiUv/mEpFhHCaAt5zl60txhGssF9p6Cq6mCSB9YpSNvmai8JitmFEOcLVcqgBQO7rPYjqxSe6I8vBXP14EAZz/4zDa7pRkqk1megqlmoJNqNcXJKUrtVJayLV1KvVAUZXIqsP/oIIoRKpQO1tJvQugx8d92vZv/sDR438gHXyctRxUHnu36Ro8egacgACpJDdTfaSRL20AkjsG8MseL/nqqWTSUGbV441vW/4k479LR7cd+tSyDjZG76D0I+efsElcA2Lb2kQo0GlRpny4xwjF7m6BOyaWVWEZFOGKDrE41oOHUq0dnsxlVBhRsW4WLk0Y240qP4vEndyuQcR9dB14C3NCK3mCiJtmJiWr443XncTJm+T5Rp++6QmQnOR9bOM1Tyw4hpRgKVr3NT4wq3AoqhEzQP39VfMRu7d74rjPenGZ7vo14DQBvS+8AWYfQLcWKRk2DunBWNmMlvkSFVOhkGCdFPKkqM1bNZjt6w2YqneLsNiS5h4BAqsLa2vBP03VPtbRV7gpt4NmbVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MoNpK8dxj5vmRsI/iDiJIln/CEjQPKfzIzAKm7Gcivz8N9jTaZyz1YWvI5kz6h26Qilb1vZXw8qlrwh5RezQuMBbRZ7aHS6lda6RRaGtEnUmrkw/LZUHTRaUm1ZK2hUg/M75nw3hsFY8O0qGVrCJQp/fHf7X6Rupm368/Fgct/OSDD8hrhyMw9U6k7UIL1WUDyEVqhMzWYfEmbLgS6M+PkBXn/8ZQnkTOiooUDE4ulBlUAZbSM8MOXNP6ELIAznNbiL59T+woSmiXyy6f9RDJ3QrHMmw8DM2Sej+E09Cp2d8kYcgyO/G3Pr0ZhrLIow7skOZN5UvRs4GQdSZfv2Hdht+V299xET2bV9XF8o7y83Sfr2OsdMM11SvqQqsddebMwnRRDG2sIKqJoQ0KGhHCAn8sjr/AlF4qU2W9opH1YGHXwifCfipr9+uq2t61Rmy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:06.2406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d31ad2-44f6-4093-9a4a-08deffbb7196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add interface to send completion command to ASPs after processing ualink
notifications.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4fc7aed58bfc3..cb34148269160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1426,6 +1426,34 @@ int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_send_completion(struct psp_context *psp, uint32_t intf_ver,
+			    uint32_t cmd_id, uint32_t status)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	/* TBD check interface version 1.x */
+	if (intf_ver > 0x1ffff) {
+		pr_warn("PSP UAL interface version mismatch: 0x%x\n", intf_ver);
+		return -EOPNOTSUPP;
+	}
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_SEND_COMPLETION;
+	cmd->cmd.cmd_send_completion_ual.cmd_id = cmd_id;
+	cmd->cmd.cmd_send_completion_ual.status = status;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && cmd->resp.status)
+		ret = -EINVAL;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_update_fw_reservation(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2ba7ced36b7cc..35839f42b8a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -730,4 +730,7 @@ int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
 			   unsigned int vmid, bool enable);
 
+int psp_ual_send_completion(struct psp_context *psp, uint32_t intf_ver,
+			    uint32_t cmd_id, uint32_t status);
+
 #endif
-- 
2.55.0

