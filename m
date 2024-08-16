Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFF4C531DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 15:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F213210E098;
	Fri, 16 Aug 2024 15:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zOntEkIa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E5610E098
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 15:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9+xnJW3F12ZNgg3/+JjkZkgVv7PsBaTc9WTy+rMdg5FvAvZ9aGgHTRDrVrHPkYNw4IMAzzdowQpJnDUcdklm4r3J/kKR00O8Sb42mRcz4TwaM8uXpbGwcvwLHfVNxzR8jnD3/HMFVuEYZEcA36NAifvKrsWN6MAAicqSchVpMJV3oaRKdknL+d5wU7HI3uZ0T7Vk7EjUCAa8JgUyiiu9ukAupNZLcK3DjAapFe+0jACTbRmZ5gTB2BdbXq5uIm/e3OY+rSt2dhmWHQoVFWRr7nXYPQMnE6Y8u4PUAzsdP+dD/RDL3pGuqRRU7tyEYEnv6XyHwA2V+VAEV3AOhle6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGzgLqBPwBqXmF5Qczz9+VUs5khWSrmXSGo+GOIDwwA=;
 b=tyjmgS2WEcbNVieNfeLqtIO3OvNFtuVkrdw628bjgwVUHEg3kYJURI1asluRxpbJtIENiVVrStuXv2ZlHedULGXGyI43mj7c29ZjPUjBzbeAyToGqI5bcXyORbUM2fcNuEtovFp/c/+zPlgw1lDj4EJ/Oy7dNz4BO+T0dRXsk/qGFZjs6HFa/WZDGHKwTX6VW86fmJyDFQdEm26toKa2R+u6DYLaGFf4+cnLnU2VZ04mwc5Ns7zxki1ZQLMfUXRdYkUwRqtmALM/10PW+LmoJLkvxLdOsAQEYd5tikck8GFD3rEDP7W7ta9ZS4SKXZH2StZgeXg/+ysRnxEK1o6/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGzgLqBPwBqXmF5Qczz9+VUs5khWSrmXSGo+GOIDwwA=;
 b=zOntEkIa/PTlrmvI3RELVtnymwtiTlWa2b9smekHFfADJWDSvfHshr6UvsHs0RNKnW1k+rKcBqG0jLdLQxJGXOo9MJp4iHprUsx7BBIIEV9o942G+iUExn/zbGRSRfcmgnx5pddDnwHzriTuhm/9HTE1UeyXr+1B9Yd6cBmDJkA=
Received: from DM6PR07CA0065.namprd07.prod.outlook.com (2603:10b6:5:74::42) by
 MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 15:53:32 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::a3) by DM6PR07CA0065.outlook.office365.com
 (2603:10b6:5:74::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 15:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 15:53:32 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 10:53:31 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: apply command submission parser for all JPEG
 v2+
Date: Fri, 16 Aug 2024 11:53:18 -0400
Message-ID: <20240816155318.1676781-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdc0a6b-be5b-4f04-7b8a-08dcbe0b9465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcqz6K61XlFTdBkxAG1zBaWIzTWpRbs4kt4K+15qv6I6UDEMY7BvUdMpAjGS?=
 =?us-ascii?Q?zTCJ8CPcsF1iyIyaoo884HL+tfCZz8jPqza0b0N4Ioc+owpHxQrjRMrDk5B4?=
 =?us-ascii?Q?eB5pDYPXFjcQIDinb8toIcoEIy1qpOB5WDG6ar0gg3r4+9HuLxXnfm0BDWgR?=
 =?us-ascii?Q?pODnUzs8CAOBMvESNBxu/v4e3WVeizu0t23OuJ4ZBFnfXsCkQO8ZDPIyGA7X?=
 =?us-ascii?Q?+StE31HtvdNxyvYfHsI9LD/MYR3ifv/K4eFpcwkggg0leLYkRgkod/fk6pAs?=
 =?us-ascii?Q?YGlWv25F+TaH5LRJfBqiwzFRjv5AkdH+Zm+uN431KrB3kMrEjWbjZx1ReJBz?=
 =?us-ascii?Q?DZtZFQASJnsffDtYCMAkTysZcxAbBdz5ndawM2baAdV52gymZDWlmyB7ZjTS?=
 =?us-ascii?Q?17QFARn5BG9bW24F8x63IUpI0TkozNcxl+kbZKG4OnrQ5A2E/eROhyqpODAB?=
 =?us-ascii?Q?2g7T7vidqhhji4Q9UfbbytZgWzPcpxKGskCIIVtwCDC/vuwD+uyqwcIPn1cR?=
 =?us-ascii?Q?9z9AwgaEMHM3LT8N0EmJ/2msKgBIda8X/euG8rsAc/7MYnSEN5hXcx91Ahca?=
 =?us-ascii?Q?Fd2UzZlI0bereqp+jmkYfZVxr5Biv3vI8/FkLijJGjLUkg08plojlbJdyump?=
 =?us-ascii?Q?k9PTi22EOXZ+30hT5VxjkhHtNOUirMmr4PvRWQOyCIhmFzGc+kfTaeesNcgX?=
 =?us-ascii?Q?ue57Eb7Re5VE7+WSuLEcAPCmhMjvxfbmZGBjwFpq9yYtsCdLNQqaVurr+6Ae?=
 =?us-ascii?Q?fujM4zoZX2S3LxolEwkid8mHXSGhV6DWU9jDr+caad51Ntk5fncqwsaUpFnE?=
 =?us-ascii?Q?PW5vs83Yg4ceh/HHVQl8dqt09tCXIQwW1osBaPYTHRJDK6tBcr0hCDKWPzoN?=
 =?us-ascii?Q?+lGy+7V3ytsgztnTh2wfYV630ND9UKTJOc5nXbwxISbNufhXY9i/Z6sLuNQg?=
 =?us-ascii?Q?A98WFCzi4W9ZVHp90UNjgq5Cqunthh40Sk6jKcP667QIeTAIIf+0N1gMXiCg?=
 =?us-ascii?Q?a7kmvNS/4FmHnAMnVy/ere9LuzBkXyKuuaLhyLpi4MbpxW+U7tuZkmYxTAyY?=
 =?us-ascii?Q?e/V+/w5TNZ8bCot3FjKUwOvy7yLiPN6vEm9lFjajBLOETJ3kJ0bpflqDH5v3?=
 =?us-ascii?Q?/xIH2EIAmu7HAGYMNZNyhhCWeISQ0Sz/K8WT6HN2Fkf8bmvZRi7dPq2S/Erq?=
 =?us-ascii?Q?IcovZbOMtiO++oxBj3yyl7Y+S2vyBPXkQ2mG3Bnzjv+SZd+4Z0ZUTtbkgMkm?=
 =?us-ascii?Q?jnkNJk27IP7CCaarbPEOXXIcUD1ae/skfbORMtqvJTGOPkeYhR0MmVHVBpN0?=
 =?us-ascii?Q?zVMSKDX9ctUgntLzuaQ5RgZLnqkkivgGcoS0WnGNmKb/c9/k1dn4jPBM1+Vp?=
 =?us-ascii?Q?K/19u81Xmn8xX5JhXtPQqV9jKPStD2WEnAQP3J+SgEIsxjhDU6EIfgZgCnRa?=
 =?us-ascii?Q?OgNLXRgYfXyciVD4AGtgSzpou2QSKwae?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:53:32.2270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdc0a6b-be5b-4f04-7b8a-08dcbe0b9465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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

This patch extends the same cs parser from JPEG v4.0.3 to
all other JPEG versions (v2 and above).

Rename to more common name as jpeg_v2_dec_ring_parse_cs()
from jpeg_v4_0_3_dec_ring_parse_cs().

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 61 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  6 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h   |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 56 +---------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 10 files changed, 77 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 98aa3ccd0d20..1a2169e90aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -538,7 +539,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -764,6 +769,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -810,3 +816,56 @@ const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.rev = 0,
 		.funcs = &jpeg_v2_0_ip_funcs,
 };
+
+/**
+ * jpeg_v2_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
+{
+	uint32_t i, reg, res, cond, type;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			return -EINVAL;
+		default:
+			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83e2c..31476951e2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -45,6 +45,9 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
@@ -57,6 +60,9 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index d8ef95c847c2..eedb9a829d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -662,6 +662,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -691,6 +692,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 31cfa3ce6528..b1e7fd25afbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,6 +560,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3dac8f259d7f..6c5c1a68a9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -727,6 +727,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
index 07d36c2abd6b..2922c2dfed9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
@@ -32,5 +32,7 @@ enum amdgpu_jpeg_v4_0_sub_block {
 };
 
 extern const struct amdgpu_ip_block_version jpeg_v4_0_ip_block;
-
+extern int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 6ae5a784e187..b9a060c37979 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -23,7 +23,6 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
@@ -1089,7 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1254,56 +1253,3 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.ras = &jpeg_v4_0_3_ras;
 }
-
-/**
- * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
- *
- * @parser: Command submission parser context
- * @job: the job to parse
- * @ib: the IB to parse
- *
- * Parse the command stream, return -EINVAL for invalid packet,
- * 0 otherwise
- */
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			     struct amdgpu_job *job,
-			     struct amdgpu_ib *ib)
-{
-	uint32_t i, reg, res, cond, type;
-	struct amdgpu_device *adev = parser->adev;
-
-	for (i = 0; i < ib->length_dw ; i += 2) {
-		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
-		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
-		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
-		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
-
-		if (res) /* only support 0 at the moment */
-			return -EINVAL;
-
-		switch (type) {
-		case PACKETJ_TYPE0:
-			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE3:
-			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE6:
-			if (ib->ptr[i] == CP_PACKETJ_NOP)
-				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-			return -EINVAL;
-		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 71c54b294e15..e3b2fc9d5879 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,9 +46,6 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-#define JPEG_REG_RANGE_START						0x4000
-#define JPEG_REG_RANGE_END						0x41c2
-
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
@@ -65,7 +62,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					uint32_t val, uint32_t mask);
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+extern int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
 				  struct amdgpu_job *job,
 				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index f96ac6bce526..44eeed445ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -768,6 +768,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index f4daff90c770..1bdcce8d21ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -646,7 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.34.1

