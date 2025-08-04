Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F100C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E31710E415;
	Mon,  4 Aug 2025 08:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ta6UAbnk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF0210E414
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvyS/Ny9RFYFct+29G5gS+GzCxreNmdNj+aEeAeIRD9FnwPlUokx5J2fitGUQfjL3Oa3t4tgqHr6uoYjlC94r5XkREi9C2GmJ3chJwjTX0HF3VSFGMl71xgnBhO9LHva3DOspugi3YVx3bV01RGtCL1IQBcwjuNUbqaYEv/UxGyL1YP8t5m3p4pt1vycBSlYHnBxkGEQDYsJAPVwIeM93R+j6uZ228bfbHs2piBGkVq99uGntnBDRNuaqSym3FenOajKxtLgTZLqxxoVVbj3QxZlNxN8XxsWqzbZMYGrmcSWpPrlSrLocyioVAwApsOXsrAFwQb5+WaQgq87VTJsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=KcXG/GPODTz+CA7xsG2wITu0t/kxtObuRyvprb+mj9bW9fQ5bQ2/vhE/Cpl/CfEa3pLTxQ6CAZUOIpcD32ZjRArLJ+stoGtOOHHwr00u88ZkLq5bqDSa8iFDCLYb+2RMwosEaU3FpjrjEWX0WYqFbqQGcT2Sr94hEi9p6zd3s6bqsEefnh+XpqbpfgL96HsnVLC2i8w47vlDuulZNoA5ZUPe9cttnXUDijQZty8ZtzgvbX60RmyfCQHUIyN9GtZqEFxZRtM2UoQpk7NFO05LAFnhjbYtZcEZ/nAR+NwsGGHfcGuuEjuK7ArQ3cgLc6N3P7+DRThAq44zyFUYIBRcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=ta6UAbnkBu6HdPCJgMC44GXHKPIzqwjfVrMBt/Eq6e7Eut6KoPpMoMTawrtKHMCEEDetIiNJU41dZ7zQMe1/TJvqxOVYKMxr9fwhXq696+8p2vegCqloc80MiDdre7jWBsaAzeAcaG4tAZw1f2zOoGQxZ5VI+Kjk2o/ekC6joXM=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:40:44 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::c3) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:40:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:37 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 02/13] drm/amdgpu/mes11: implement detect and reset callback
Date: Mon, 4 Aug 2025 16:38:20 +0800
Message-ID: <20250804084029.863138-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf52456-e749-4f5f-ce3d-08ddd3329a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Khsdxs0CvcErjoST8ggMNHu/EjDGbooInn+B6t8FieUyansiGEgG7zJskU0?=
 =?us-ascii?Q?VbSXv08BSRiVKAFxEv8EhRoe5cVVUciMFW2izSMHv5+IpJZEugu0Ppq16FO3?=
 =?us-ascii?Q?alWoSVsq39eXi8GMDXtfyoDuqP0Y1oDpUEqmagxfczV01enqMDEx1ZOP5MKj?=
 =?us-ascii?Q?XOhZL9OTgKtOu4mxMctC4YCi700dlI39JJ9JQgLsYtFHZBmOd6JL0tVK4u+h?=
 =?us-ascii?Q?lredn80w7F/KVaGW7fQkdx9DSh/+eS0fIpCynZk0/5LfsxhDyZJ2Q8cfMHK0?=
 =?us-ascii?Q?ANtr224zMbi5kXBMPenab/2neWh1m31UMnv7jmXOkV2+rqwqXa5HHvqBdYNz?=
 =?us-ascii?Q?J7p86a9bqj2GL5ien7t9EL+zdXjoS7nM5a1osVes6p7pFlgMaA0WD16z+pIL?=
 =?us-ascii?Q?yK6xe+3pkz8/OQaEjbkD3PWiBS/0wh3fofpnNSyCp6w59RhLRD8wJNz5UYxC?=
 =?us-ascii?Q?sYhMfMFpXJsoLzooQPQzsNsi58ZB0Dj0RYOtlNbAlrlY4+7IgHF29S/Ca1U7?=
 =?us-ascii?Q?sXiqwohuHigOWr8ihay0565ep29K3cZkayfxCbA38wJMrfEAJu/ZqAqBApyo?=
 =?us-ascii?Q?LkFlNYFKSCCmv/wf9NaqPO8Wxfasi32M+bQbBLcjWr7Q/VdADUn3kzMaVlfr?=
 =?us-ascii?Q?eAPBYrNopCqgqj4EviLzjRNZaD4PSAJLE7A0xIoIe1GOo1dh7gerygZ0SaLh?=
 =?us-ascii?Q?jTtIeCTees4M9IPB6NaPmeBmcpvsM7duWOqOFvRc9rj73gfd2nzBiqRW1O7F?=
 =?us-ascii?Q?oHwHza4BVeQ8Ev0lK/jepX5HlXDunywuATT4ynQJ6woLiK2j2mRf39agxxUd?=
 =?us-ascii?Q?mYjy+ahiIVh5hZgCh7bxa/LWVUD+YO+YQTDveXYtLt0sT3DJRpefSqmevnLi?=
 =?us-ascii?Q?EKGU/NXSIwX5DNMb1w+l/VRS7uHBbC794U/NhUMpGxfGGuTQAcbeszB2AM8v?=
 =?us-ascii?Q?8IJBL808XiL9+K6ZQQNYQsrUMyp3cW3H2KZjl0QbDUmC3IKmoNWIYx+aEp0B?=
 =?us-ascii?Q?ggtf8cUseAkiLfcxWTG4v3mDhP3dX3pWSQX9HALgyAbGCtzEVT9R+kC4OV/B?=
 =?us-ascii?Q?xT+RtPgl4xD9X2hhIyNxVjAldJ3h5vIebOWMUX+8zx0TLAFSYgSyKGZKS6uO?=
 =?us-ascii?Q?b/lykCzWqhH2RtdQ/f8WolS66xzez1SpC/D7jaLVarlHwF74zCmRgC4wlwU7?=
 =?us-ascii?Q?a1dID/rP4x8sO8V2s/7DQpcQv9mRoRqD9YrnPnwTIz2Zy1Q675Owp2j9Yr5k?=
 =?us-ascii?Q?T34nCTCRi1E+NT7YAuv3UjuTLwlA/5DWLtxA3oHJ2GC/XeZxUoB7oxjYpUB1?=
 =?us-ascii?Q?c1WUcBC9nV5skMHPR5j7I7lueA/atIA2a82pEtxIGH+VPBqKZPsiGTsQpVKS?=
 =?us-ascii?Q?GBsjKxuyuua71ObkwL//7hnmrWqy44RSag1aOIzVS+aIP65YLF7THc/gbSh4?=
 =?us-ascii?Q?8MVUqzvAkQaDiiyBEv2TWMJXD8zP5al0gD7J5kUsdAQc4X9EOyOvkhO7ijLI?=
 =?us-ascii?Q?XDxc+KKtdfneI93q38PUCDBpMajBepkXx0Pj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:40:44.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf52456-e749-4f5f-ce3d-08ddd3329a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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

