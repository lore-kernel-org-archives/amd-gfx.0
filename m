Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6C6C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB4B10E3B2;
	Fri,  1 Aug 2025 06:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vAtIu2gz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888E110E3B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2a8NImGpa9EzouVRVenLEM8EultHaB+TfdAODRronz7dgNO7QZeYQps8MomM51wIPRkBdh+FXdDz02kxJzpu6cVm9YujlsMsfc8kMDLmeAgvTysGHbwCLF7HpVYnRtWtzkHbrXUMRP4iCafa27bBs2ORh02sLyZEMFTWc55Gp7npvnYHGfuNjsS4csuuD/v15heGd5Jm04AXDG6wysL2K5/jkMftpsaCc1HpP/vnbxkHGDWmsDjoeiEnoekabjKFf87ychDjY1hKqJBLUyi6ZK944wqj/mA60s+pK4ReWmuxGCnq+acHPGMa6bQ+JlFD8WeGWurIrz79l+RY/K5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4chIb6zwB7HW4D2PRxzEjMS1A6GYIfNIXyZKMTYvIUY=;
 b=v77UfpUZt7A8L6JkB9A8Ly3oAuLOk7P7Dvo+novFVncbUbURr0ZlxZUI8FDQEthdmEe4bbJ/ApY/HwlMF5xN/vIsDusGqI8Wog5OKtBYu6kuNfJDlncEMB32s4zMb2Z8CfGpRyD/O+Nx67k6/kQYL5Wvkp4vh8vOKUL629SeIaaVYs5+g6TXHswi4jiL0iOZLQcGTpZINIDYiiL/Ca9Txjc35b1Q47h2s279Pumfy9+1De6ogstDWlYxUZlCyjKGJXzRnYtZbUFnh71T7BVOz3/FOSuSSugffbpNSxFWxkxqvrCdFpr8RsU18RRHJbdRj2xoEPgT7aR3t2h49cB2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4chIb6zwB7HW4D2PRxzEjMS1A6GYIfNIXyZKMTYvIUY=;
 b=vAtIu2gz/3XWYhVbcq0xYKA/shlk1MPun/Bw8+gugFr0TwLTkuttvKMmjJ5YMvClRHzU+UHarCelpR8kqb7tW2P3ppvKFYUj6kwnkzn7vbkHq+Ueypo75rTDfUH3Q9Eg0sOEdYdF70OjCS7WAl8OVXh+ZzfF2EWsFpXmbHp7G9c=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 06:26:08 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::57) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Fri,
 1 Aug 2025 06:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:01 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 03/12] drm/amdgpu/mes12: implement detect and reset callback
Date: Fri, 1 Aug 2025 14:21:01 +0800
Message-ID: <20250801062547.4085580-3-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 915b19cd-b468-42f2-fd94-08ddd0c44d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?70KbzF2gAXxR3GfTxzu7i9irr7oqP2ePAwXkhVN99LBaHN4jRWUrJ53HxRXW?=
 =?us-ascii?Q?DhlyVcGL76PsaD8AhNJtvwMed+7jslROOuII7nDJfVlIcMMLHrSylCjGzpW2?=
 =?us-ascii?Q?jPeCu9oVNad1VreHq8Q7aMAwDXWWQpS6ArhLXwa5Px8jDeDBVsrkYGFU9iUM?=
 =?us-ascii?Q?GyyL5GZesisFOBEuLarDECuooNQ3Yny1XynWPJTLfBhx2oKQIzxN2Xj37D7G?=
 =?us-ascii?Q?CGBWgVUY3ZqKExDwv2bRwbofuGmDfQGD7ArHC+SXhvkISy9Orl8LJ4QKFKv0?=
 =?us-ascii?Q?DPOAKlUT+x4xDKGQBTvNvgvxir1KdwH7GR+ykAmcs5fauxt0mN9Z3HoSsBZp?=
 =?us-ascii?Q?skPv82bi7b1Y+u/fAiVpfNW7hxImvqwg1//UAkq6fy+ZjWRSclbE/NV80rNQ?=
 =?us-ascii?Q?w7QXzq17Wd8wPQKJuEw6xAc+FsW4pYNNHi7XyQW8yZmYsxRBf0CDySAIS3FH?=
 =?us-ascii?Q?lxt459RRj1GqRpqM23C5fdA3gVQu3vBYw9xQU8fdY5aMenhUbnEFRyRfp0uG?=
 =?us-ascii?Q?cC+JQXu+kuBbuhD3N3RFXmoFYlFWtD4CywETwTEdmsFkz6XMy/P1oIuoA0DD?=
 =?us-ascii?Q?+9A+Bv8FP4tJQQk8J7RXcAGz6GE0x8TkZvyp4R69eB0x8GSwJzTVSHRQjCIE?=
 =?us-ascii?Q?S7SIcFUb7FNg8Vi80qS8E4jPIndIJX+NMff0lBwEDhUv/k+n2wOYF+Ut9Kim?=
 =?us-ascii?Q?aAjQY0lX7U6uP7eUIuixoVayHKpULzc+J2MquSpNzWWh/Z0jKI+Rc71SRGNG?=
 =?us-ascii?Q?eKr742wdLTZQ3nFng0vlx4iYE+jx3pLxqUP5OcuY4z2eopSvg31l7JDYblEr?=
 =?us-ascii?Q?hDucb0jCFRLq28m8EPu9WAuOQgtJKES4JWnaZdJ4x8RT1B5xoEmbSEOYcBng?=
 =?us-ascii?Q?3zCshaEYT5Rba48DZR6agBexQgrOzyYtTqGJ76BVE8VYkSgviNkVRTNvzMgE?=
 =?us-ascii?Q?o+KXMRlLr9wtFebbIlrMMyfJ+xOmJgXYul3geWn3V79IWJ+8ZjlrMktjJ/l0?=
 =?us-ascii?Q?GjBk3AqUnmmbReqW/yMbrZtZFgQ7ZmNuiuNAaSJ+toJZ2L5qQlxQJ92DAZBi?=
 =?us-ascii?Q?CJ3ZY5K/YUHgZtS3/Dl8xA0vOdlQqZub6DvGzhXstdyNL6cq9DCq0q8iuQll?=
 =?us-ascii?Q?LjrXMVD8S3KzrHLg1lfU65kNppRx7G9pB4sYNUVr3wjixtesnI0UDisCu7YA?=
 =?us-ascii?Q?1im5NmciAc0UzyqWLbpDbIqmgms7r8heCEcdf8GmBRC+T2sJ8HOszHEO0D8u?=
 =?us-ascii?Q?UQpXK0rYaVFSqMvx+j7avmFr50+zY0c2wGSjcbxIHFr1twbxj1Vkm4R8FAKL?=
 =?us-ascii?Q?e7O/LWQwmboEVvycPRiztoCjdnycpsaAsldXQVIQYHbuw15jYkBinrjn14XY?=
 =?us-ascii?Q?/TFD/yERrCjV7otpyHDwhs2qSHq15+m8M6xEj1aXIXh9lYdLsM9DCbs3FgGb?=
 =?us-ascii?Q?btUXiJKyjPRZKqWuIhGF5AFS8KYY0Lpvs34gS71ytzJO/iIB3oZBN++CTOlk?=
 =?us-ascii?Q?pq51kS5WJ7mvR6oG0xb9eyN7hUSkPjjLuEgW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:08.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b19cd-b468-42f2-fd94-08ddd0c44d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..29d38aa1897e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -879,6 +881,38 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+	int pipe;
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
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +922,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1793,6 +1828,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

