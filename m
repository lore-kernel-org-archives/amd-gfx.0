Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C02C7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F1610E49E;
	Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4uCp7+d/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD7A10E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1/fhzdc4+dp2ozA5GP3uiT1PbtplXUL+0rBtNrCyW4CPzMI3GEIFkrq0VGVw/gw/g3Up81na53xUoHmc0f6eiwn3U/xYA+gaespBfGcTBOXIWeZgUukEB9wuY9fMROC99sKXvdvjjw2fNUK+Kxvxem475BckLcD2hBTFBpt6A+UbkktQpfXEklxtHq/i/viarW96G3h/c7orO1jXMg2RrwYbjkR2n5NzRYScQaEWDPdQYgPpILW7X14PX3TzWBsFtW/7n0QM+0NRlC/7drzqOV7ciJynglptLacnXWCru+Qn8v2Hv/7exT1ZRG2RtNVsJfxnkJJ7LIC+q5kqGQzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tiqIvdzMpB797/kGax62oanNBarx09WHk/aIOU1lmg=;
 b=Rn/BRk/2+edFzLPDY6cSBiH6XdPl2GVLnE1fa7gPREr2MHBWAKbHMV5jjO0iSJF9cArTPMc8eF4xH+jgd16z6yvaojf0mG7H0QpeJs0uOBZQBXMBP4vyodqrDAmgrpn8vbfJMjDxa8mLKJSJE/aT/8CmUVM50a08y+0Y0DESuXWkWWfaHITH/AtuMMDC6x7ELobKPpKYju9OLj7QRJlNt5FRJW6NW9XOx3F4WOLgVX6yUW8gJ3NdCgNEjr0guhRESLlh0TM1e7mHl6SPioES1siEl9HfgPkkfO4GqQRcbOuAnCsGp3BT8lLPzR4QbQFtXJPP2QKNzFjKcsDGkvZEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tiqIvdzMpB797/kGax62oanNBarx09WHk/aIOU1lmg=;
 b=4uCp7+d/ggss7dU6HbxDxDzvFh6FTOA9Glbx+I6t2Ud/+SndAiVM68ZTjhmqkdGIuBTDi+AJRKw1U4E8nJNBUJGhtSvn8wsx/eHmrRaNrGjluYph3UiPTkHKMZNlv/X42PjXBQ8XwPqy0CfTt7ZDiJFMqnugPwaLJQCpjA8Wkrc=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:49 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::f) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Tue,
 17 Jun 2025 03:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/36] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Mon, 16 Jun 2025 23:08:05 -0400
Message-ID: <20250617030815.5785-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cd8772-1b95-4774-8378-08ddad4c47ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E3i85k7Yk7dSL49IMfZe4U20T0adlJixVnO2IZ8sJb4egZXEa7Q1RrCBnakv?=
 =?us-ascii?Q?lw5gPiNDVwdepEYYEFM63RSPNE69AWCwk18/t+xaSYi8h+tKkYM7xPtli1lz?=
 =?us-ascii?Q?e8hD5npHmeT6J3hugAIDTr48cxoSyE+LzUmzSEEa3r7oHXld0ecOy9ou8AY9?=
 =?us-ascii?Q?K6rMomVb9xeV7S2PiUeCXFZcF+RL2QnDDyabUh2WvS1r125B9jrrCMqUMdA8?=
 =?us-ascii?Q?4pc6IjUm50V5jemf54Y8NVihVYTA4b6Fnf+/tX6UlK2AMlmTu55SI34csm+4?=
 =?us-ascii?Q?QpJsw9F51tbztWOR+lE6oOBUrnmPD1JsHYDb6rkhiLqb2jWHW65TcRKa/FwP?=
 =?us-ascii?Q?D2NB57I6SCaHVVnzTsqA9lwP50vvpkojcEoMad4SM6Yburr/Qf/zHOQJ/mdl?=
 =?us-ascii?Q?4OPeWEQOH/0oEJkri7N91HlRpUehuhqP+w2vucGuI5V+tbEBYgabFCkAhn6Y?=
 =?us-ascii?Q?LOmqAEJuojz9X5yTGsKiIPVMgFKAmm2UVHRdNbbkspqFVQitSsfSvocQ/4y8?=
 =?us-ascii?Q?huyK8ZdlZecZcV/3ilvJF4U9vE9nyctIinvk+CG7C6srssAysmNeCrQxGC7X?=
 =?us-ascii?Q?8GeluaTYnnIjNfaXxxQ+H3LEh3/bDETWv4Nko51WRwHMpHYdAZaid4lXg1Ft?=
 =?us-ascii?Q?q5XeuvYUWSgegPqk1LGOaCLL7KIRit1CtDcnCca9N66Nm65NQmE5oN+a9DSv?=
 =?us-ascii?Q?BM/JOxgQGtiDh3KarKynpLYBHBDl/E6HD3In8OZfDZkpWPV0Phzjia6Lg0Dv?=
 =?us-ascii?Q?ZZfqR5kITEVpUe+mnUcBQfvq8hmtm2kwZ7Nfm5hM9/5H2nu8E1gFn+vPdG5K?=
 =?us-ascii?Q?P9ZeViVo2GT9lVg1kyJ+/dtrRxVtxcEYaARCSFqIgqF06pAvcm+Xl9sRegnI?=
 =?us-ascii?Q?Ktx2JIsRSN+xa3QytY7IL15HmiTpwMxazfaSIR6gXGo3se2QAMdsHgQNbYCm?=
 =?us-ascii?Q?z5ki23wpWW43G0/k0jMCwgwo7qpRHZqITRepnS53Xo52Z+qIG6AkGc9bA6Jh?=
 =?us-ascii?Q?SGDF+KUmdt7AWC3nwT2Fhq2oA9O5fjBClLnugKoCBSG4K654yXv+EKIQz0FI?=
 =?us-ascii?Q?iyJf9/SH/vlfOkE2bKUaS+VKkwSxBpfu2XJARcqOnl82E2K0Gl7Bk75FDirN?=
 =?us-ascii?Q?aG08qG/+2u3JTi81utaf9MUYGuLVT8OkjQMrR12OaurLTq0nPI/4JVrTISeJ?=
 =?us-ascii?Q?kDCBKv3WvDUancIK6Nh0jcCiLOzTnXqUWAOLd6LeuGA4TYFnfzQhTSsa06Y5?=
 =?us-ascii?Q?8kCu+8GRcvpT7XJtaGsqSxqaihNXgjFD5AXN4rYKFNqkO2dR6Ncdaa0H8fxp?=
 =?us-ascii?Q?Qa0BbixEWofQCMoFNOR4GIYIUig4a2ezuN3W2e00QTQEVSciZ0Vt4V6eh/HF?=
 =?us-ascii?Q?LLA0CRGUd3euIb4YFHY3kiPY3bxLSXj1U2ZdgkC+HsrX3B7y1zh5KiCuVIat?=
 =?us-ascii?Q?T8JAKoajeY3gfU+rM5Kavd+bS8pWBhLCyFqnvtrGp+mD13efwV7oE/of0KYW?=
 =?us-ascii?Q?X+7F7THe225wK49q3vbKFeMUyNlHwb8+SJ7A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:49.0802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cd8772-1b95-4774-8378-08ddad4c47ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..8d187c7f7afe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

