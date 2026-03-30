Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A31061B20
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE8710E7B3;
	Mon, 30 Mar 2026 19:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMZ62SJJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A071F10E7A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRpiW+98ve+wUhBeDf3m4awPuXKrJwGdQ4JZcWzML7wKJLLcEQmVBX6nanlEtqlgq3dZJvn2RV0rv/1zVurEjhfa8mgpSrzIyfGD4IGfqXTK1D0O0pPVrs8LvXAzE1+vHt055IqUPZOBUgytj2XCVDoU4VSQdq5zrl8n3d8gXeY9ISWRuAYkI3NyIdMvuozKTPdC5IVy/h5mX/bBxOIdBl/utghzVkfQarOzL3izvx59RKT3if1GlXOFYQS3Iw5nau5UubR5WRtNU4wYQpzW9t0I01Fv4TNcAUkxV4J2jwiN2Exnq+TtTe95wPIwDeD/YZFDMo7gvYos0R6HPEVMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdxTmOozPcjPJVRt+vlS+XBt30E1hHOSPrXa3MZm5ss=;
 b=kivvZwcvLlCO9Zd4Ty1aPnBUItxd0dvbvjdjdCuV7W7CrpMQadf8k5puqEBqthvC00ZM8QsWpKvfVpddrSkq0J+r+jWqtjrgTTmrE8B3yhUYoz2CUUxh4H5AL4fKaS1jZjDvTmQGqwASebtlIfbCpAMha046lU7o9kHebjrJ3+VvxLrkDWI7sBttZTV0dUF7N0Xr0FnKU3ykKgzBpesjKXR5FjvomI28pbu/eecjrJ631y2jtiamMqHO7G0gFo4YgQAmkOYY/pOJxh++JZCewCNZTR7c978pjvCM3HFnNKNcryy63YaWhqJlEbdT25ijw5mm72wFqx7o/7Ge/smEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdxTmOozPcjPJVRt+vlS+XBt30E1hHOSPrXa3MZm5ss=;
 b=kMZ62SJJwYNxKsoqu5wWAIiQ76plGtMd6pXH7evI+U8715VbQqMIKR4MY30joZeIf1VdY58ePfg9myo40QMTtVZPiWHvIO6AtXG1X9ioA9kurG+EFq+JJfHBB252J+gvVjEKEVhlJLqtTS14UTqD1KW1DQq2cxGnY9dS5SQ13Sg=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:58:47 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::84) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:58:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 14:58:36 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:35 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v4 3/5] drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
Date: Mon, 30 Mar 2026 15:57:55 -0400
Message-ID: <20260330195757.901509-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330195757.901509-1-benjamin.cheng@amd.com>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: c9544709-13fd-4e20-dd40-08de8e96c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XW42s5tpNmVWSlwKJc7cLb/W4VpcNZGmRZA19rM9x5RaijwyPLRE8j3QTRRydBH0O0rum9o42XdmGeZZaipbqywmOwPcA4PvuH86Cbv8pypkYlUku72h8/6IJZ1L+ezk7rUargzrlQZlNSYBnBrSc1AJ9Gbr3LLsmto15fB9PlW8nG9MPAaUnMZje+fPjz4JRyV6FNNBGjPnhvDxJzZLtlGMv+fd525L0OAsNKPw5N/NmhbbsOE9kgcLznLv8dbbl/uN/KhVqiLGqSZn5I/bi3gZxZMiGcRZbtAPSq1TLjhAOMJQeeFAIeRMciNE+yetNpxwYWZ0hW94ncfoN4QphZT49trqRZODZGn7ISPKNUz2Mfh100dZ4OcAj5u9078V1gn/SE0g6MUjO9Pt2OPOeIUnVyEST5ws7ftXYcC31ZaFKBK3SZUu1JJ33crc5sLrAIcoTzKi0vuuYr46iOVd8fuTUwhTLQawkHnl6Fp9Ry3C5r8hPBQXDKCj71RZH4wvOPJgzVKp4VCeq1CMwhdDNAXHT9rNJZJ1kC5j5aMzdm/8EDnh3+ZVk2YYHZms4ptEtM4Y0fzuPvxUlEYsfR+JMKFLYgMX0m2cpExOFdBtKUypVvzjnKeJcIdVLt9gbU+K9z7oPqpgZsFZuhXEk8NaRtB46Xg6DGXk0ut8tCXHQKzVYbhAnANtDEznFjqotZZxW5YMpOYwcHgVPMBDOwEu67ZripkGvJ78j4MeGh0xTM/Si+qKOBcqEeIP/Jr1rd8e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ort9m2T4xpHrhtLSEter2U1fINdaMMi6Ru7BdxfkS+RtMVEzKShIbobLoTVFiJNIaj+iw2+D4bKQpEnbwHR+oIOIixXkYZ6PyDaLdtsQa5+cMucdW0gGx6oC0TIBjecvFjksZFUJ+QJfPOEKmKS7UpizfyayCffDmYt9Ftl3Zys3R9DQ8wisiwuv0IfYRuumzF5FcKOeGcQNNdc3/gZk8GkoCF0phDPyrmjC/0Z1mvJkzKlJwIi4fwyvzdw2syrir90G6CZ3NmuNDptQ3FkKXtMCMR8QyrZwsvjuZbzKNd2llmNFkHv7lixu5qeXwwYU6sg1FeDxHVCyrIfmZYJ+tH3IIiXbFYRv9Efqja5Tvw2zaZDwaNHdlSJz6447Nq/ekQHQpkQ5Etmv2cplDjm7DOvG2gL/3J0nTYFh2yM1XO05k4hipRneWSI7Qd5yGLHU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:58:46.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9544709-13fd-4e20-dd40-08de8e96c0f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f2..6fb4fcdbba4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1909,7 +1909,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1930,6 +1930,11 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1946,8 +1951,8 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1955,7 +1960,16 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1965,14 +1979,15 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		create = ptr + addr + offset - start;
 
-		/* H246, HEVC and VP9 can run on any instance */
+		/* H264, HEVC and VP9 can run on any instance */
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-- 
2.53.0

