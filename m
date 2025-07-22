Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C0C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A0810E2EE;
	Tue, 22 Jul 2025 03:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+dW9bNY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8321B10E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgUZaFzyODS5W6ZoSgklgZ4qvv4lxMkDQphzFGaThlA3uIk94fq9M7JBVcC+vNHf5yjY1mpX63mUB0uZ9JA8NGGtYVQtMHcFe6kb4/gl5fU2Vw383myAR7o7nzsTphrZCzYRxtJXWY6g/KY91R56W+1NRxzHILCzj07rzPU3ncjlIkQY2JW2stD4HPZCwb26z1Z/yhnAitRFlWI2T/Lg0u0VCa2S7Hk+6M5woqH4TLqqksAh6TPQM/cfAPGWiOZ6sDVDMvlK8W0TizBhk0xRMPc2TC2x1/VKIo1vzwIg1+eKcNFUjqbci/rPN3pjomCmmQpuvCkd6RAaTq/cMgZJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=WGiqPpeGI/XZ+aGjYopcv0oostbia3Y9uX8GqpzJR1YlPmf9Lgup1k2s6JVVeukOpMXC5FHAgdGGNRXfnlkc7Jr2QzIgvtAr5N1WhpHaYvRYrxDVYSxn6MQn4UweFtO/UCj16ii+hPY+R8oNRQQ6QJPK95JL27m8cnErXcHLO16qVUl5QxQPIFMeikoJh/iuhRJjJz1KHL1Ya6JIJ37io/+DTY3eEY8MKv0dG3mQQS9Ux9sKJLPtXM/l2/E2U77ypPiiIc5YqwqyumfBe+uV6Kh/z38UmHiqxnLxxIGueMmI+lyQ2gH8vqwsrHSBIQ1yu+PnXnCndqXKE9xKaVvOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=i+dW9bNYtEBU8Wlq5tKP8Jz3Of3ph5OleFt15TpEWeA1DWn0Qt7bc26dayy1/NSWou0AW1+ID2YYKEHlDZyrlk9VCr+9EvEfL69QvHNZZyIbR5gQo0sKlnCsFkFKfvy+LIzypIyYaZ8xcmrUBd7hNhVX0ShZAUaUItDDgUZA9dY=
Received: from SJ0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:a03:3a0::24)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:06:21 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ee) by SJ0PR03CA0259.outlook.office365.com
 (2603:10b6:a03:3a0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:19 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 2/9] drm/amdgpu/mes11: implement detect and reset callback
Date: Tue, 22 Jul 2025 11:03:38 +0800
Message-ID: <20250722030605.2741435-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a093dc6-6901-4eaa-dc5d-08ddc8ccbb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7aM2hr8DSe8zJJXlz+xP3m7xPE+DhZkIMKIe60KP6d0wxt+0v4eDeNFFKr2?=
 =?us-ascii?Q?+gKjqXyFUdZGYHyP7FNAirxnL/fes1+cyODjlyVXCxAMLCfSmO89G0zN1H8w?=
 =?us-ascii?Q?QIm/WXWzf52iWQb+vpbtGvPKK7wzl+ycBTMXeYFhd/w4Q1zq8dUjm1KTy6aw?=
 =?us-ascii?Q?+/xwCtU2KIW7IlGuaIPAwTsgsZrfEJAZhTk2sWMZ54xYr8S4k42aNXmNworQ?=
 =?us-ascii?Q?XwcGorsoZnjLo3uFeHBOjnt5QjMb+fy5pr35q47MvJCYdnyhB+Njh/LqbWA8?=
 =?us-ascii?Q?9rVmTO0u6dfvWwkLC4PyOnTan+CH/EERqKjAb/iqND4TopdhHdQhWeQ2IJmZ?=
 =?us-ascii?Q?Idz7wHu+nCw+JD656TYXMBsvrRoPg4KaNqnhwT3L8zjh5osdm0OcBjabk7BR?=
 =?us-ascii?Q?G9U5wajV3jkvLvJ8PkN8Lgr6DiXAGHnWpwoe8YwAk7xgRLyi8ZK5ZrOYTHjB?=
 =?us-ascii?Q?J05baXdh1Fe/BRWtrPcnOC1F79pwJ7LWRxfbCIpWsaXUivc6Cl8uuVPUc0le?=
 =?us-ascii?Q?/KJUkARshdTrFQzaeP9IL7cm8qNyfl3P68Ty2jW4Zt7JG8tYFBwoLZbX0X4M?=
 =?us-ascii?Q?RpXvIhZJT5QUwWqMN7wii8Spi7xgmVjbAWv/OppP9NKRw5bXPAAMUjt2lh5P?=
 =?us-ascii?Q?FzYK7JP19tyu2sw+rOjouY3ppDbPjIXesHyOoA5+HtAIaBykoRxnn9EIwN+L?=
 =?us-ascii?Q?Xk5CafDyiIrUcydMk/ARig8xyduFlZMaEtKpZdxzvx/p7mt2R52XoRnHx2PO?=
 =?us-ascii?Q?FHy1aVm9iDC1MU50HjPVAGsbvwl+YxuXlrBqmx8Mm3swkM6fJ4nl2D9PYrWq?=
 =?us-ascii?Q?eln3xLh32TPd8FG6RtYqgglCD73IvL5MM8saDP+8ThjJcoxjsexkPaWlaRlv?=
 =?us-ascii?Q?ETS2dW1FBP4hFoB3P7SxmRKu+VV42FoFm+Io+n5epal9B3IzV560ISvCee8N?=
 =?us-ascii?Q?uqcGHhum7nz2fBlOhT+Gwx9SlAcQE+qkMJmbuLRZN4tfbEuZS1YCDH3OmhhC?=
 =?us-ascii?Q?+osPfmE/Al9d50au9YygewrVT8iKSaJhC7Zt/CeZAQjW2ZaMk5TJLRZoNaVv?=
 =?us-ascii?Q?/IdXLo8w5a0KfaLHPQ2eQ/fb3EOByvATjs4FWaRETTiUgHL74Lyf9tAQcg26?=
 =?us-ascii?Q?mNcDDCMWcLpJWyB3X5nOEX86Vwis/alsQbme0Ea+YUY4a2N+DzdxHuzLnmVI?=
 =?us-ascii?Q?XwdJTTyZf+iD99m9cLCwmfDwAV7mbECzAnkjYmA+tWlG9tkfOe6FumvoazDI?=
 =?us-ascii?Q?xbAonTJXqg1yc0ZwQuUiJIwrMfqkOJswxXgZxtIT6S1vTacTQIgHHMtXTYzt?=
 =?us-ascii?Q?gxkm7sAq9AJupR4uMrIVFgSFWK7+/IJGH4U8jmuwuwR8L9w/j/ksxd1nO0NV?=
 =?us-ascii?Q?eG9znq55Wa3bd6OnJVkTYuqzF2QQRQQkKV3EJWSFVY1HeWbQtgx83/xisXD0?=
 =?us-ascii?Q?MQAg5h2vACqy9RcN30L2W47xtQPkWmBfQLDxC7w2tXoEHaRpaAIRcukwy9rP?=
 =?us-ascii?Q?M1Uj1Y7x+KmMaGUR7K1uvKnyjJ9k58cNUTQ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:19.9536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a093dc6-6901-4eaa-dc5d-08ddc8ccbb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

