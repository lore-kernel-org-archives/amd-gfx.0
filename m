Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56113C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1F310E595;
	Tue, 17 Jun 2025 09:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N/EXi7Ka";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31BD10E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTDcbjoHediVZ3bRfQiuQYdjC0C/d8Nsee9FOnhcjqYtWPQKDyVHDKRqE3nYnJxpi88P57j9swJcEFtUal5lih4yh/jJZ8q/96xGsBs3HXENj425MpBw9xVdyd/SBVWdq5cFCGY1xNaiN95dPrwGK72GjZ2Vj34U4p5hRzrcL3chw/SekdqYGXv+ae3UoEbo11o8XZiqqGu6mvYG+vXBMV1Ga192YJCvr09UMff9rEGWSOn6iRLMXsXObYuA0M7mBAvA+tAlaQ7hzbcuPQz28uRz9QVGI+2dxESA6f/ldZ4dPLe9cX3GeAbweyCC/QneuF/XB5zk2rEMylyx4UWDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0kCn7//FYApVZ1C0PgM0oDjZ4b/EKu0+EastcYtE94=;
 b=NLOS8JgPQr/ee/ToGWilhfMp3bVzc6WZP+5mJs1QREJ1yuy+HEJREYxwVmioAVLo4QX5yZzWxueJ/6dEvhCmFl1ckpzEUXy56SAsVJpDYNCFLyQuFyW1hz8Bm+BBFpj9fkLFa5j/0k+zl6ajteAdtI2e2fOHVyzQ5UQejzmeqKqKIPSUzuB0rubACYjSxUahUS0UkSXkX6EILo0iISaM5GrUsOgU5kAHvGVatOSjV5jTfzHvmKGjhzzaU6ilbiY7XcEG3QHLyoaGU0dox5W9BFnmIzkA+bR4ZSgnU4ruuJ5bAaCD2wiQKfzlspdvboxN4vPod5SloSG3daCQUx5C+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0kCn7//FYApVZ1C0PgM0oDjZ4b/EKu0+EastcYtE94=;
 b=N/EXi7KaYzYBaiPcD69tJD0LdT15FKYaOOwjWdMdQ1ic0kFx8hjsabtgye9FudyEJw1Ozl3p1ECXvpVB1JHJG5BXNG90y9uZ/W5HCLRn8BTcT6H7jNLtgFZy+4h3sdN45s+3qXy6fxiEISD/wMETjT95qivQNrRZMQrFspHxhv8=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Tue, 17 Jun 2025 09:23:16 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::a5) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 09:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:23:05 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 5/9] drm/amdgpu/mes12: implement detect and reset callback
Date: Tue, 17 Jun 2025 17:20:17 +0800
Message-ID: <20250617092243.2769580-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: bb91e109-24cc-4c65-a4ee-08ddad8096a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aoyjje0mRFCAytyUFilo74TMDCSv4f/9e3+xYXzZOUwRgAveu/YEbeQ9A+H2?=
 =?us-ascii?Q?ja3hOPOA0DoPCD+w6Qw76nKOq5o9Qn0C1YzOp7N/7ae5Qv6w0KNGmWZX/SIL?=
 =?us-ascii?Q?3kPJM1idhBaxwi6Hji+pkNROY72XcvAzI/NLfqbD3/JBXabJt/qS88oLAxCA?=
 =?us-ascii?Q?75S9Ys3JF115LeNIkC5zvTlU26lLEnk40kgUcEHQ2DPNr4fNLWAVWMoZNbfB?=
 =?us-ascii?Q?P2bszxR////bJNj6kXpjKFBueRxy72Qr4tTqDIU6oXQfm9vy6nBWqjbIjgPx?=
 =?us-ascii?Q?XviNna78hkttSwoKz252hsUueY3v6Q47Rk0l6m42bnXE5w9QKQ4S43qAm1z/?=
 =?us-ascii?Q?XMOvulF1Ws4KJCD2LQOhgxAPaWC5MOnOvz88sKpqeFnJhLrvvDGpKMfe/30P?=
 =?us-ascii?Q?GSu7xA93NzP7SkUM2qrSl+Kk50BjmQKtO4giJ75jA9636geuzAywSguv/c4J?=
 =?us-ascii?Q?2hz3UhPmrrK16/mJvdCx/+LcckjR+VxGwOjV5iIgbJn7zU4gF14YlkhjdPT+?=
 =?us-ascii?Q?6NR7SbPvfHVM8GOWPvo/CCxube56KFt+UzIb7y830pylIwuLxqjxckOVUsYC?=
 =?us-ascii?Q?6hzTFuSE3kS1qs1+1kMNmrojUcbe3qRizZWg1gp0yMNKjKfbwyY4AYOGgS9L?=
 =?us-ascii?Q?lCar0wvdWxKnx6hOXcLd1mu4d2NsCZrANfmIZVa/4+7dkVjqatI8kW7Po1YI?=
 =?us-ascii?Q?8J3tJKI/APXkVok7KtbeFLJZpB6gXEVTnhQOCwzurISohYKkj9Udu3C33BvQ?=
 =?us-ascii?Q?mpgdh9S2MXNX8NfT9KI7N5d7yDQE4SmaxFburOYipiTzrWnDEjrL9QGZuJX+?=
 =?us-ascii?Q?7PaoB807VDUdqBtzfn/ieqcVlb72P+kkMTysF+XE6ESYl42TTP5tU8tTerbM?=
 =?us-ascii?Q?wV3cBjGO2i7lQBs3Viu5bROs8HS+YGr4t6zEUXHYbIDhutTbyAbj+uS3rZV2?=
 =?us-ascii?Q?idwBhkpmPYcOpjJoW3F3ir0VGpkUVs4XwTCNPx9lNJDmpHdjT0ZZI7etlu6l?=
 =?us-ascii?Q?mKuueB205VRGlz82yaBuL1LgwwIX2Pt0DHH/C25sPRsum3rVAPJDB3cRDEOm?=
 =?us-ascii?Q?ktYSz8wcTDUthyHJVhBjrSszhOQqn3aCKB2h0/Y18Bt0wLT607LBRl8nYotO?=
 =?us-ascii?Q?KFP9DuLnkMWdm4jJO+BY0P50dfzFIWSaog5fb9FDVqtyeXAugfJjIu8WavJO?=
 =?us-ascii?Q?221sq06eVuXYo6WLBcq9k2Htw8XETxCl5/3vcV9FxVfs3dyWAfDv0mcb5Vm2?=
 =?us-ascii?Q?fuJ49V9Yiri/IR5nLTxz8D1xDJ8KADnhgl4Ji2dFMkoiy3Aqr9mDDOa5jcwI?=
 =?us-ascii?Q?lWC2O8oDdembSyK1J8msB95Vyq4oKqFeg4ayUg0VdL2pXdYxrmBeCiT2kPFb?=
 =?us-ascii?Q?RGvDW3T37uL0KHL2tPKyp/8hC0sPcWsUBcn4zNi0ryduiqHVhml4+baK4gvJ?=
 =?us-ascii?Q?xiYKZ69dWijj1zUy8ph/+OkCYMr2HyYRotdrqCVekxfMiDTIJKZy67Yi89u3?=
 =?us-ascii?Q?pOghcCW1wVjsOP7oODgzxSYxf+GBMTz/+lzP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:14.9743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb91e109-24cc-4c65-a4ee-08ddad8096a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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
index b4f17332d466..7d545a24e2f7 100644
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
@@ -1792,6 +1827,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

