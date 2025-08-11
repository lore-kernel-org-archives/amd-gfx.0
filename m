Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F47C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5770E10E40B;
	Mon, 11 Aug 2025 10:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qfrgyj81";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562C710E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktb5lJCDB9LVg3iVw3dAAYkAwPFESu/C/Pb+B6pEZUqa3hCtAxRMIbDaymDfsq8hyREH37x3vyG+XNBYTF+QXqlY0ZXIBkos10Su0Vy31pEylAWcaWV8sxr5HCp2M5OBGvfTd27dRChXuOOggRmUKoXcgjM4JZmIEjXUBdIXbzVj22bT5LxWpts0IqdbV/6zLOxx6IK2iwPM1Pr2RvnS1KHDtXWap5AehfOIRMg4jIIJgZyJkMha8eaxiA9jVyr5GjXOZmEYFnGOEs7ypWlyv4rKgNHgGUMfv3Vc1pu87CtgkvBeF8Lcni4IbrkMvvnOFNSFUL2/srjk8b1BXyOE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=hKnD+Lk2jzq5Oj3DdK7JeMNLddP1/QV/H8EGSUykPcUvIbIK0dBpvyatbPTSHQ4vbSWHG4ok6wxbye3ecqRPurVzQ9gZCDVeD+GegY8AupNSAJGbLvGUKQWhC3Yw6waA3lH7ky/MgbGCaQRN+7uO52+2dVPYdFU1d3EbvKC2WKH+qBxkTYRXGOttkymPlFU6d/L8VkOoY98BXDy4gTPn+gVy/LSEvUd4UOVB2Q5wUfvTqMqmKNjaQn5z/Id1S2CaWekSs0gOCeZlITUtIo4N9s3nXn0jpK5scAG63vEn4tSlvMFrsucGsYjuAaFEyIr+hV/f3y/3PkzEBujXGkZgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS7u0vRL2HiVTwFO9W8/2ObbCSb7pvCpsdKBTv8lRc0=;
 b=Qfrgyj81nA9IUGWUbOJPwt1p3SE1+1YgyqCMB+V+hZrfmDA/fzAYfPcoSnd+4BYgK83LQx6MbOgUSPfxKxLnL5F0fXwIE1m7vRSRGVtveGPpuN8nvTMPOhat/eiwwZITl54pWyOmzWRj5GmqYrVz0QS7RqrJI2MQDeSVRhQ4AXI=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:00:25 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b3) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 10:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:18 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v8 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Mon, 11 Aug 2025 17:56:53 +0800
Message-ID: <20250811095937.1978747-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b59a1f-9690-4025-fc34-08ddd8bde4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FZBDfn1Roc5CXAO+Dpm1PSg75ueKvBI3HXgfT1FNxdVLYmO86joHxrILQH+I?=
 =?us-ascii?Q?jqSY95KjvjBT6Xrb8R8hUWDFpYmO0CEd3YQ+NXO+i5cHOspumFhD3iLQ7rYx?=
 =?us-ascii?Q?3HKW19bK/U4OYpeyLAnmEQyaCb8he7VJ7gnvyf3o0hXfBnkZ8g1x6lQufrE6?=
 =?us-ascii?Q?m3n8w5m/6yLYjDqK4sHicPT19r7F0fkVuZqJKD/EOQZGA3/2dRk8LntWX/yn?=
 =?us-ascii?Q?L0wadZXZ0aBs8bd1KLn0J5b5b3gXiK7h4223L94q2+ckkkftKlOiR+ZINmLt?=
 =?us-ascii?Q?eM9XHkMNApmhMl0/yjM2SCSwxWJcUN3uGpCeniNdaHbZTuvLkGY1FxkTBn2j?=
 =?us-ascii?Q?4Edh/NAf19ox4JzDmEq+W5mNMPTJGWd+PJw+3dv0wM6VJJvUOSYT4EPGcJjq?=
 =?us-ascii?Q?0btqhD2U2UoZY/0Btc8MFui8Z9/9aA1+cP4SsuxMezgtxDo4xYJuTeF704W0?=
 =?us-ascii?Q?FvHWkH0f+b0ZQ6ii7sVfqHICLt/4iV6f6+g4hJTE+jJZn4vLKnBwp72STtYL?=
 =?us-ascii?Q?VHmcabDEOldycK1/x6obGjt6/DKqXzpGHaunwIQ3bvDzYxvssXK2ehQbrtig?=
 =?us-ascii?Q?hkpxZojJ4DK4/QtsXeIki6m8NN7IcjT9eNiuRSlEOOo/TOZWp9CyINoS99tX?=
 =?us-ascii?Q?G/8VlQ7Vk2CMAIwKXQEXcABvbrvTFkhJf6n0fJp12h62p3GSlh7eMLWEtAX3?=
 =?us-ascii?Q?A8z7Xjj6bU2ku7O13hTVk4ORm+1DclxNuwIdMgwYox5S7EhyAN38D+z8eylY?=
 =?us-ascii?Q?/PQtMwU55Nk6LGCp6KU/FWI+JljD5taMwqXED0tSk2igJEdRDniHutkFHglk?=
 =?us-ascii?Q?DAUYmEHyoZD1B4NBgE8aO+fezoRBW6xZrgOPn73/KRSOmEzCSKi8/HAnuaOT?=
 =?us-ascii?Q?rlsYihcp44AEloMhiSNVBhcgpbCx+WKqEQjcJeuPmXqzyjEYDM2yuQStgY3F?=
 =?us-ascii?Q?3wMXNXX1yW9J4nTSTkM83M5yyWqVkieGiMf08RVwPTuq/pMmIq0Zp59lOGEK?=
 =?us-ascii?Q?Vf1YXPqdMRBvYs2+0NBzaudW2Nlww/Epz0Ur0QG99RCXqVMTbYOHFgpvbkAO?=
 =?us-ascii?Q?3xvAZe5bFEVYbQNTPkcvbgb/Ca8o3AOXgrpe0WLOti6DqfYZqSUnI/TJn8zJ?=
 =?us-ascii?Q?Z2rHjS3lCjuif3L1OmF7Av38unjX3sQKndTEeXsgiXzjFHfQ+Zs836dqFiWl?=
 =?us-ascii?Q?sSZUCnULLE/j4Qx7upQ8Tkq0jDlaC8LVGSzHX2lsJTJao0/QbuVTJLak9jvf?=
 =?us-ascii?Q?Eu+BBfdMAeAj8osy7834ctpiDh/E5uSqkIKgx0G0bGJSeRM7skGMjSdqyaVp?=
 =?us-ascii?Q?chYUaC7HAqT+oTZfnUjsoE2MdI9RzUolwHQ056uJaflSvJI0td+OmxpwaGJV?=
 =?us-ascii?Q?8TbzO42BK20RWk6yOmfaVWnA7UMOFobSoNq/tTokDaDzGEyEoY6uMYl+Tqi2?=
 =?us-ascii?Q?JxPmu9mtwAxQFXqEUVknn5sw/HksK3Y2ODssYuOY1AMyUcNcjvEXa1MzSWke?=
 =?us-ascii?Q?DIXh6tNfu74MKVMBLj1nBbbT5Y+S33GNNte50rRRup1oewgAPWn6KrvGrN5B?=
 =?us-ascii?Q?err70wJZyIsBqddbaV1AOf1nUmxh4viYmFZphZxXQrPwAn/iWxz4ONVJNdkQ?=
 =?us-ascii?Q?BcPCx+ELtm7JzLjHbWxE8Q2p+SymRVWXAKyTsFaDGUn3UWdkJvxuYjWjMWWA?=
 =?us-ascii?Q?lJqCd7N5pZuzxx5eue53zVAnJlTz8zZBHGZotl96UjutBlMs4RvdT6NMsq0P?=
 =?us-ascii?Q?VMwWAe9ra6RfJD1P3K8K002YUvHpTG36Vpn9e5tFHZ57dRlSVmF5S/g1E6NR?=
 =?us-ascii?Q?gJvzUkqD3b4XNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:25.1371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b59a1f-9690-4025-fc34-08ddd8bde4a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 24c61239b25d..ca06046c5d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -907,6 +909,32 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -916,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1821,6 +1850,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

