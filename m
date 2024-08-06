Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE25EC52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 16:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CC510E033;
	Tue,  6 Aug 2024 16:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcUJC4a9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E352310E033
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 16:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXZYhqV2K/sKzGikRj33dFdzzdj767XfxK41aK0BytwizWrORySjDnQPxToXk5I7cSj+sXdRK+ZF3SZ+jplFo3aJcw9jC7csGxGFRSlNmgAdiPQ/o+o+uJF7/TUNO2PmETdGVqJ94J3vyACFTYVN4b9FKOSr5pMtzxnKcm3lQ6awdT23uPhtdxklmslCWRaYkSSvLW7KagIX55HC8C3DFdHep5NjEi0Zzr8p9CQNmqIU4DsUoCmCCiaPyPhgLD4/xuBIJI/ClJqAt0uDWHS27VuORPTK8COAUS1c6ZIQ6smCFX9TSZm/6stKIPNxqWSC4bubIKO0DYohOGKKxPurQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpDeKs0eNymIDJhpAoWtfk4o5ljErwv/FQS+6D+sV/w=;
 b=fwbZ+nGLMU1W0057o+UpkOyB3g6rwXZIOVUSTlV7YugitHA+O6oiFXdr3f0jzrJrIkMFaLceZD24Y/jU8mw/2iefNLJhN8k63j1jMr723nxHznm9GqKclhw0S/aYILGMwlyCK8tn4THJDTdSJEzEg8U4Cn34kGxCbIHBuzkfZkhvzK4XZO9AFUlhvbMo60HZLJrG7UXN6v5uCxfVlCwnblmIamBax/Fj9GB9hPYkIL5GXJp76vdABx2eOn6Zp8K1E6NSyKxizOBLBmh+UneT9+CQxed5ThUz/Hx3hCdYGyJoWPKHhbhbXWEEkBY08pzyUz++QPJOawxX/UtYbtnHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpDeKs0eNymIDJhpAoWtfk4o5ljErwv/FQS+6D+sV/w=;
 b=rcUJC4a9SgikRhU0wbPwEhRU2fd1R49XEfBrbP8t8JstYXrO64OoZ9cGZb+WtmmjkCxX24Gqau6RbY2afKhpTpTvHQNroUIhoTnpSahL4IovzE5AGltUdJkLgDCSRw0p+re5V/Ye0ye1GSD+KNmbxn0U1uvZgxwCeBVMlKq+73Q=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 16:00:35 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::e9) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 16:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 16:00:35 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 11:00:34 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: command submission parser for JPEG
Date: Tue, 6 Aug 2024 12:00:11 -0400
Message-ID: <20240806160012.234633-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bb1929-f95b-47cb-52a2-08dcb630e87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G8byGoE4t29sHMfvEp0beEx7wZoOrcKm1L0MPO6503Wwc2uTYIbN/zZxsnFZ?=
 =?us-ascii?Q?HsPuNOpnSwGNIwmKA5fdejwBKxw0px5H13Sty1MFJyMVirjPHOvW0pKMJ2b5?=
 =?us-ascii?Q?ka8uMpblnz5bzjSx81gjGL+9eyYsdQOsE/0UJJbdpqXwN3ksAKMje8N0VK7G?=
 =?us-ascii?Q?fFdB8eyw9ZuhD7bE6Wyi/HV/ajFO0CUgHRJpkKhX0LDFS8Av9PxTqZH0UvmT?=
 =?us-ascii?Q?hEf/GDD4FfKXp7tu+5fKGCoJ9tPugToG/GjDqH2Lfn6KlOnPmbjY9KnDTqPl?=
 =?us-ascii?Q?VwwMpM101OXiV8sFgpjeF96NqIRSqWU6kDxAzpqnnVO7g0zsfxMR/eJ428Rx?=
 =?us-ascii?Q?Al6/btox0c0kNNOwErc15XilbVy5ZBfAgG9lF63NCgCfVFCWMun6gtT6b9Er?=
 =?us-ascii?Q?QlHlb+rzSc4aPB1+DW20pvd9GPMSXoHsjPUlbFNCwIf1cuQwLm6WfUvsICL7?=
 =?us-ascii?Q?KPsvFlS9Xy58uOVhnvKFS1vgoPpTOOUu8V1Nw4YWhooCtHph8OgR32/pDR2K?=
 =?us-ascii?Q?qvgVXrCiWv5vXuTPIr+3OfjdIIxckGbGZuwOeojFn/RWhN72ez7I8NApIZgu?=
 =?us-ascii?Q?GJpY1b1FhV99bvPGIbO5ME6rmjSbFn/R3j6yxP2lMx2gXEOrIlFgC8YY4aZT?=
 =?us-ascii?Q?E3FCIeCTyr7gQi3iyXwv1fcwrPllJ5qviUzVysAglczdH/xOkh6frs1qp4NJ?=
 =?us-ascii?Q?+zIroB1ymfiiM1vDc10nhUAt9ITXQzN6D4qIrwOMGbgUFcFD2AwuGzp9y7Xx?=
 =?us-ascii?Q?ORD3iNB6pFWPG3TjCV3g9lH0IlXhNiMrx52y7MNCCfXFdnIEV1NcN/YyR5fO?=
 =?us-ascii?Q?fWkVONAYCUqDdL0aUwOI3wv4ypDEhjZe+um5YPtyhwDi+ZvL+JKBpQNnhUDO?=
 =?us-ascii?Q?DvIOXmlI+uzPXImEOQOFqoPK5GN9ZQiIGobe9iNTotZEgf4z0Oalm8vebuK2?=
 =?us-ascii?Q?tX5qO+vkGQDeZSXlEFf5W6ZQq/MkYocznYeBTmGkkJJdcVgl5zI6oZU4AAsM?=
 =?us-ascii?Q?WuE1OXq+ucv50r/VHu1O50XXVMqYRyqTn7tJfEzJEcI/ew0/Ggi4Y4Usanz2?=
 =?us-ascii?Q?J59+OmnVPiw3BaR8Hw6MLZURr/iuJc4TGUsRm3rBpNtekbe95bt451t1T4No?=
 =?us-ascii?Q?9UHVXkOgN2gCBuK+CuYWHzbgpwiNefTEip7JZqSkqM0znvMPU4iPG7i1IADm?=
 =?us-ascii?Q?25I7tMibo6PJQ4Ji409ZCh5kTqVfzal4LcDxU37aU3tbgE/l7hEhza0gkSdh?=
 =?us-ascii?Q?oISEiec3fgqIYEDMwDzmHwBLGYqI3gEx0ueN2ujb99A6IlHsYQg3n0xHTvku?=
 =?us-ascii?Q?GF6r8rh55fDSInl6/mM+rs+wYj+mpV2AiazI/5sv882visRBEG8WcvgvNwKU?=
 =?us-ascii?Q?qwymeA/POwxcllnz2SlDQGNnje/tuTOn8fLVwWatzgN/ABTf1tvHYs9821T4?=
 =?us-ascii?Q?h5TBEieBYHXW9xLgNCAvB2ImJwVkHPyz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 16:00:35.4486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb1929-f95b-47cb-52a2-08dcb630e87f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
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

Add JPEG IB command parser to ensure registers
in the command are within the JPEG IP block.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
 5 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1e167d925b64..78b3c067fea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1061,6 +1061,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 			r = amdgpu_ring_parse_cs(ring, p, job, ib);
 			if (r)
 				return r;
+
+			if (ib->sa_bo)
+				ib->gpu_addr =  amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 		} else {
 			ib->ptr = (uint32_t *)kptr;
 			r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ad524ddc9760..6ccf61d7c13d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -782,7 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -1084,6 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
+	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1248,3 +1253,54 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.ras = &jpeg_v4_0_3_ras;
 }
+
+/**
+ * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet
+ * 0 otherwise
+ */
+int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
+{
+	uint32_t i, reg, res, cond, type;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if(res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
+				DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
+				DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			return -EINVAL;
+		default:
+			DRM_ERROR("Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 747a3e5f6856..71c54b294e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,6 +46,9 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
@@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					uint32_t val, uint32_t mask);
-
+int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index d694a276498a..f4daff90c770 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 2357ff39323f..e74e1983da53 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -76,6 +76,12 @@
 			 ((cond & 0xF) << 24) |				\
 			 ((type & 0xF) << 28))
 
+#define CP_PACKETJ_NOP		0x60000000
+#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
+#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
+#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
+#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
+
 /* Packet 3 types */
 #define	PACKET3_NOP					0x10
 #define	PACKET3_SET_BASE				0x11
-- 
2.34.1

