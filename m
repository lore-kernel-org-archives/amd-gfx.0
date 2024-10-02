Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D73CF6D3B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A93B10E223;
	Wed,  2 Oct 2024 17:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJLzEYB7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95DF10E223
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJUwR/XvfW+UTaFTKzLij+uDV2TrlrLuD4S634QoLkbmiuo2phyQ9oSScdCtaPQTccQCDwP80MN6hQQ26cBsrjcyjRE9x/J8QJ3gqT/XA4XFGlC6m5U9nPmT9Ti0SJ8qytI+pKYY7hCkIP9M+IT6cBdWI16trgBBLGTP3J9uUFRibhKKSip9zdfgl+1fcdDylOZln1Oc2/lXb6ltRiPzqpYHPkm1tkbMkiP19AjqvrzV0b+F/aZcmSSjHHQd0Pa96Aj5ryG+pUmCsH+cMKpMYvRzwvUrvmD0OoOZbn1Ks6UuZsOIRV9yspZFZmEZgse5kz07IGG2pcUvLMcQfiYaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuIw4SREOf24ClNWmpuf6/ukuPQdPCV+zThAwSBdwfA=;
 b=NbEp6LMbonk5PHuhJTSu3H91jmoEPnynPwT33k0XmpvCHPsBu5PVM8QBXhyhXOV7CymWpw82nu5vE4/dlJAWhGRHxwk56UxVT/Vhf0MS/by3YUpHACnhVt5KOcudJ9RcpoSECDJaKh5hKFYpNKTigbuHH/lrjb0pttSuddqX0LM8/lLU/4yjV62Vkz1deZG/MbSSmkRLrZHjWtQssRcGm3z/dnaYRdDIzQSxEE+B3fhlVhAL/+vacoK3hj6STgo1CQITQLjOk+orU5g9KaGpCOtS6xWYtd+dZGD1XOg+c8HO1PmN9RaudGyMKYm4EV4xKrJjOl3zTytjtZydXBvY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuIw4SREOf24ClNWmpuf6/ukuPQdPCV+zThAwSBdwfA=;
 b=KJLzEYB7kByG3E7j5HLpK/BK3GS5btgnO/E1uk72e2AZ/e9ATmZmfXORq5XryRrc8DMLVx7h/oZMfM76FWsN60anCtpEMonw1tJfOirmMCjZKc3AW3ghsj7aDxGI1gs+t5mMLfF3em+Pr7L9MYCCjlzRT7dGcOPEqpU1nQvxqtY=
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.29; Wed, 2 Oct
 2024 17:01:37 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b9) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 17:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:01:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:01:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/6] drm/amdgpu/gfx10: Implement cleaner shader support for
 GFX10 hardware
Date: Wed, 2 Oct 2024 22:31:20 +0530
Message-ID: <20241002170120.3179253-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: a65ebfd5-0b39-4fae-f2a5-08dce303e07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5QVGRrSW9CSEo0MThTQ1d1UGc5Z0VZZTlPZW1EakV4R0Uxb3Q1WWNtaTU0?=
 =?utf-8?B?d0hmeVpFTlFrTGZZLzdiTjMrdjcxSlRFVDM2VEdtcENaQ2t2M1ZWQUNkYVFs?=
 =?utf-8?B?MFh6KzBuZk1aUmhFaFBWNHhKNFpjRlZka3ZRT0hoOU02ZHVxcWk5RGwwYzAy?=
 =?utf-8?B?OVdHa2hTNWhVdWRUMm15THlNWm1hZnBwQUJGMTVSbGJJNjYzNHJFeXFvWHZw?=
 =?utf-8?B?dE9XbEFFMFBKaWZKRDc5Z25JUTF6QWcwWEhiNThSSnJld3dsZVM5Z1FNcVNn?=
 =?utf-8?B?SXBROWVweUd3eDVLMFJzS0R5TG5TbUw1VlI0RDJMTWIyN2ZwYzMxMmxrS284?=
 =?utf-8?B?dFpGeGFocXhQWWFXNHhHL2RvVmp5MGNjczh2UjN4SXZEUHkyVWhnc3lKUm1G?=
 =?utf-8?B?QjZhcjFxZ2RML3R4Yi9ySUJacEcxa2d4Y2xyUHlWZ1BodUQ3WDY5TWdwQmhC?=
 =?utf-8?B?ZWUvaWJkc01QUDJsUFdzUFhJV2FJR3FMQkFHeTBHNzUzbGhtRFVWN3d0Z3ZL?=
 =?utf-8?B?WHpKTWFvNENtTVFxUThEZU56Wks3Tmg5ZTF2dGptKzZ1YmtkQUZaZ0ZNZ2tr?=
 =?utf-8?B?bmVqbGt6UFR5SjE5MFNmMGNPT1Y0R2FFbkZTM0ZzVWYwRDVGRmN0aXRhL3NI?=
 =?utf-8?B?WUNsellCcitPbXo5end4dFM1TFZHUHlKbzQ1RE5JWmMxa3ZyS00wSzkrL1BS?=
 =?utf-8?B?Z1ZkRlRVa1BCZldvdU11dUxRRk84ZXN0VFhsQ3FzNmNtYktvcHRiTno2Y3kx?=
 =?utf-8?B?MW9iU08xMkZVSWtqaXZ0VkZzOEVvVUNPdm9BcXNiR3NqWU1PaXZKOC9wcXhi?=
 =?utf-8?B?NDErTjlGa3dzVWhiZEdnYWZFMkNCWlVWTkNCK2pUbHE0bVhOWGJ1TUt0dW0v?=
 =?utf-8?B?Z2RDcGxIVlBlWmlpOFdPN3lzV2U1cFk2bk56TUJ3VW9WamhncTN6ckU3YXN1?=
 =?utf-8?B?Z2ViWWQrVXpWQzBSbWg3czJ6TFFzaHlaaENocGFtc1BOZ05qbEpvZTdKa1Na?=
 =?utf-8?B?RWZqUU5IY0FWYVFHZ1B4Q1JDVmNlTGtTUDRZdU9KK3pSaHVsZjNCYXR5U1lN?=
 =?utf-8?B?T2s0ZXFpU01vR09qUXV6bXNrRjk0S1F4SXRxRnhwekdNc2hxb05Wd3RkcG5X?=
 =?utf-8?B?RkEzM3FvQktLSlFaa3FGRGFWN2RFNk9uelBROTZWcktpTGNVcnUyWm1QMjFR?=
 =?utf-8?B?TFVWMXdRK1NZS3g0blVUNHVYV25JOHBGS2x0d0s0ZVc4OHZZbmRJOHFBNVdJ?=
 =?utf-8?B?WmdXL3RUdW5XWnRaeVY5Zk5wSm1xZnBHdFJZRGFBc1E3Tkc5aCsrUjBoZktB?=
 =?utf-8?B?b3VjK3o0Z0NkWWxKTm9LUjE1TkZhUG8vcmxtK3BMTysxQXFXbmRhbmwzTHFN?=
 =?utf-8?B?NjIvcnJXR3RCbmNQb2hJWnRTMG52b01xV2l6UnpkOWE1d1lmWkx6K3M2YU9W?=
 =?utf-8?B?Nm5XZ1FDd01wbnJsbTQvTDhhcm40YzRjQXdRU2xLK0hiZmQ2NGxwQmJSQTRS?=
 =?utf-8?B?ZWM4UW1CRno2TElhUlgwamw0TkJnUSswTGtJUHlYcTFaOWFrc0lpb05BRmFq?=
 =?utf-8?B?TUxZYm9UTENLMWZ1ZWY5M0JOK2JNendFYXRlUFhPcGRVRFA2YllNM0psTHRt?=
 =?utf-8?B?NTBvN0ZBSTJSTklyNkdqYmRRT2xoWEpyTmFSZis2cXNtNW1YYzhtbk4vY1BG?=
 =?utf-8?B?OUxKNnlQN29JMHFLWS9Ed0ZKR3dXUHlWc2tDeFB4OWk4dUNvYkdocWVlS2Ry?=
 =?utf-8?B?UjJPN1hqWFJoaWpuNUdWdWpwc2YxK2dGdmdVbUJjZUdJaUlmb1NsekhSV2U4?=
 =?utf-8?Q?q4G4wYbXwUmxDO8WBdVqqt5NyO8irxeJYJuIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:01:36.8987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65ebfd5-0b39-4fae-f2a5-08dce303e07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

The patch modifies the gfx_v10_0_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v10_0_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v10_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v10_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
   Removed xcc mask, as it is calculated in amdgpu_discovery.c for 
   devices which have an IP discovery table. (Alex) 

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 39 +++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c544ea2aea6e..04ab5dba1d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3677,13 +3677,19 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
 	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -4726,6 +4732,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
 
 	/* KIQ event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
@@ -4842,6 +4853,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -4881,6 +4895,8 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 	amdgpu_gfx_kiq_fini(adev, 0);
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v10_0_pfp_fini(adev);
 	gfx_v10_0_ce_fini(adev);
 	gfx_v10_0_me_fini(adev);
@@ -4891,6 +4907,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
 
 	gfx_v10_0_free_microcode(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
@@ -7374,6 +7391,9 @@ static int gfx_v10_0_hw_init(void *handle)
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		/**
 		 * For gfx 10, rlc firmware loading relies on smu firmware is
@@ -9699,6 +9719,13 @@ static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -9749,7 +9776,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
 		2 + /* SWITCH_BUFFER */
-		8, /* gfx_v10_0_emit_mem_sync */
+		8 + /* gfx_v10_0_emit_mem_sync */
+		2, /* gfx_v10_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v10_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v10_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -9772,6 +9800,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -9791,7 +9820,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v10_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v10_0_emit_mem_sync */
+		8 + /* gfx_v10_0_emit_mem_sync */
+		2, /* gfx_v10_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -9809,6 +9839,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
-- 
2.34.1

