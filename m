Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDCC3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B88B2073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3OpDT8QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B88B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396A66EBB1;
	Thu,  5 Mar 2020 09:48:52 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1F46EBB9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNM0ow352T5RLIzQVVkpm7RHn8bkxCoMZVfyLXv222QXPCx8dUOlqizgbcFfnh8lwQWBCtPxsTDzX7ppAHEWDzdeJOIFAZV8jlTCuOMpJHqP8vRt9iJumf5YUTM15mel1Hk34vAG/X3cnbmi/RjzpIx1meupTsBxmADJvnMkIGFWMQ0qwt3ILBUnqKVZ8GKrpTLCD0wCuHXfBgUL+D2KrKynj/QpwAMi5V3DvkVurd26UIkxV0sgoxTZMCA2q3DFXg2cH2hKqNqQOv+C0mdX9MQ/VCDPSg70tPvkbufLoyHxl+SWEUi3gy3aUhnc4bxEJ+ZzG7VRuWgReuZT/RH6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85zv9ajSECpIEuhBWO85NvnxagHpKmV+HQOQ0C5lsVc=;
 b=ORnY+vrGCs6KZu6lZs/jyEd0RS9kF/Qm1D+Q+YG75xDQodL+r6lX2gL+KMxFP9YSZwbP2wGF2EF1phETANfTjrDKbvZyI9CHCe0KZP/rinyw+Z+AjD/FhP0tm5TUBswqc6gh2rfmfMc+hPEsLefRsaHlZ6xIaP3d6q3o3NV3Hn+8nkeuqECOmwxf8A0+dVT1OR17YLopNiIdiJ3vwBHnNMWqnUWW0AJ8ioroXNQRXbsLhrNXdlUsBhkWtrZV5KKqpcFmbsuqMU8HcPnkTRhyrSf1JvEf283THwLnA0moBuJ5ReS0KIyC8J4OaeNBsHpz59C7RXdoocRfWZVxPDX5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85zv9ajSECpIEuhBWO85NvnxagHpKmV+HQOQ0C5lsVc=;
 b=3OpDT8QIgXjaVVTSPBKJPzpu34jR3jHib9ULHquiCAnRiefnAn8W/ZbcId2fsE4imdd4cpr9EajvMi5/TpLt5TT1yjHhYLWXgi9c107GRzzkWq/lGR21kca9r5HJmYtyW0Wd4d6AZWq23SkSX7KgTxrIpdrT9XtEjE6nNP0kV3g=
Received: from MWHPR21CA0068.namprd21.prod.outlook.com (2603:10b6:300:db::30)
 by CH2PR12MB3719.namprd12.prod.outlook.com (2603:10b6:610:2c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 5 Mar
 2020 09:48:47 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::d6) by MWHPR21CA0068.outlook.office365.com
 (2603:10b6:300:db::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.1 via Frontend
 Transport; Thu, 5 Mar 2020 09:48:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 09:48:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 03:48:46 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 03:48:45 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 03:48:44 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable vcn 2.0 for SRIOV on NV12
Date: Thu, 5 Mar 2020 17:48:37 +0800
Message-ID: <1583401717-29821-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(428003)(199004)(189003)(6916009)(2906002)(7696005)(8676002)(2616005)(54906003)(81166006)(86362001)(26005)(81156014)(6666004)(356004)(186003)(8936002)(336012)(426003)(70206006)(4326008)(70586007)(316002)(478600001)(36756003)(30864003)(5660300002)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3719; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dade41f-0efe-4cfb-b606-08d7c0ea6636
X-MS-TrafficTypeDiagnostic: CH2PR12MB3719:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3719D0518FDBAB4E7B9E913584E20@CH2PR12MB3719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dldYbEXZHqiaWXCLYwwDPVFJLreXfLk86oLXp2tn6814wnumebXzFKdWoSNzGgo1OzoB8Ve1LI1oMP5aLveBZ6CI9ya178F7TiuesPY2iOScu3kHLp4nebNX/NMOCqolkUs8VMM7fdinGS7S052ohzq+PCBflw0GwIkSvFtPswpHElHsrK0udBiFPt4hHi9jpmo7Bb/XQAU8U5UfubzqFkaIlxEa8LFYwycJexXMIK42Nkj7IR3jPH7y30XmgSUIZPqVvuXEezLQuc0ova1Dgg1lymX7j+xd3O9/qEihl/kcTwS6feOBv8t4MWRrMcTlsk940gle7t2SQApA78RQ9Wx8DTMj/Tq3cBbTk7BUiuxAcdRyJfdnbP3t8qz14U97SjX62Da/1numiT+n6Rr5hv582taJuWHXPDf1cHNspTwLOCed5xktkFQflsAE3SxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 09:48:46.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dade41f-0efe-4cfb-b606-08d7c0ea6636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3719
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
Cc: Jiange Zhao <jiange.zhao@amd.com>,
 Darlington Opara <darlington.opara@amd.com>, Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this a patch that port from SRIOV project branch
to fix those IB/RING test fail on VCN 2.0 rings

Signed-off-by: Darlington Opara <darlington.opara@amd.com>
Signed-off-by: Jiange Zhao <jiange.zhao@amd.com>
Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h            | 141 ++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              | 303 ++++++++++++++++++++-
 .../amd/include/asic_reg/vcn/vcn_2_0_0_offset.h    | 197 ++++++++++++++
 6 files changed, 637 insertions(+), 24 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5727f00a..0120130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -181,6 +181,9 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *fence = NULL;
 	long r = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	r = amdgpu_jpeg_dec_set_reg(ring, 1, &fence);
 	if (r)
 		goto error;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f96464e..ca7c9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -359,6 +359,9 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
@@ -497,10 +500,6 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *fence;
 	long r;
 
-	/* temporarily disable ib test for sriov */
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
 	if (r)
 		goto error;
@@ -527,6 +526,9 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	r = amdgpu_ring_alloc(ring, 16);
 	if (r)
 		return r;
@@ -661,10 +663,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo = NULL;
 	long r;
 
-	/* temporarily disable ib test for sriov */
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &bo, NULL, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
new file mode 100644
index 0000000..ad99e92
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
@@ -0,0 +1,141 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __MMSCH_V2_0_H__
+#define __MMSCH_V2_0_H__
+
+#define MMSCH_VERSION_MAJOR	2
+#define MMSCH_VERSION_MINOR	0
+#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+
+enum mmsch_v2_0_command_type {
+	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
+	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
+	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
+	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
+	MMSCH_COMMAND__END = 0xf
+};
+
+struct mmsch_v2_0_init_header {
+	uint32_t version;
+	uint32_t header_size;
+	uint32_t vcn_init_status;
+	uint32_t vcn_table_offset;
+	uint32_t vcn_table_size;
+};
+
+struct mmsch_v2_0_cmd_direct_reg_header {
+	uint32_t reg_offset   : 28;
+	uint32_t command_type : 4;
+};
+
+struct mmsch_v2_0_cmd_indirect_reg_header {
+	uint32_t reg_offset    : 20;
+	uint32_t reg_idx_space : 8;
+	uint32_t command_type  : 4;
+};
+
+struct mmsch_v2_0_cmd_direct_write {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+struct mmsch_v2_0_cmd_direct_read_modify_write {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t write_data;
+	uint32_t mask_value;
+};
+
+struct mmsch_v2_0_cmd_direct_polling {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t mask_value;
+	uint32_t wait_value;
+};
+
+struct mmsch_v2_0_cmd_end {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+};
+
+struct mmsch_v2_0_cmd_indirect_write {
+	struct mmsch_v2_0_cmd_indirect_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+static inline void mmsch_v2_0_insert_direct_wt(struct mmsch_v2_0_cmd_direct_write *direct_wt,
+					       uint32_t *init_table,
+					       uint32_t reg_offset,
+					       uint32_t value)
+{
+	direct_wt->cmd_header.reg_offset = reg_offset;
+	direct_wt->reg_value = value;
+	memcpy((void *)init_table, direct_wt, sizeof(struct mmsch_v2_0_cmd_direct_write));
+}
+
+static inline void mmsch_v2_0_insert_direct_rd_mod_wt(struct mmsch_v2_0_cmd_direct_read_modify_write *direct_rd_mod_wt,
+						      uint32_t *init_table,
+						      uint32_t reg_offset,
+						      uint32_t mask, uint32_t data)
+{
+	direct_rd_mod_wt->cmd_header.reg_offset = reg_offset;
+	direct_rd_mod_wt->mask_value = mask;
+	direct_rd_mod_wt->write_data = data;
+	memcpy((void *)init_table, direct_rd_mod_wt,
+	       sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write));
+}
+
+static inline void mmsch_v2_0_insert_direct_poll(struct mmsch_v2_0_cmd_direct_polling *direct_poll,
+						 uint32_t *init_table,
+						 uint32_t reg_offset,
+						 uint32_t mask, uint32_t wait)
+{
+	direct_poll->cmd_header.reg_offset = reg_offset;
+	direct_poll->mask_value = mask;
+	direct_poll->wait_value = wait;
+	memcpy((void *)init_table, direct_poll, sizeof(struct mmsch_v2_0_cmd_direct_polling));
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
+	mmsch_v2_0_insert_direct_rd_mod_wt(&direct_rd_mod_wt, \
+					   init_table, (reg), \
+					   (mask), (data)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_WT(reg, value) { \
+	mmsch_v2_0_insert_direct_wt(&direct_wt, \
+				    init_table, (reg), \
+				    (value)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
+	mmsch_v2_0_insert_direct_poll(&direct_poll, \
+				      init_table, (reg), \
+				      (mask), (wait)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2d1bebd..033cbbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -516,7 +516,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+		if (!amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c387c81..65f46db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -29,23 +29,45 @@
 #include "soc15d.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_psp.h"
+#include "mmsch_v2_0.h"
 
 #include "vcn/vcn_2_0_0_offset.h"
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
-#define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x1fd
-#define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x503
-#define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET			0x504
-#define mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET			0x505
-#define mmUVD_NO_OP_INTERNAL_OFFSET				0x53f
-#define mmUVD_GP_SCRATCH8_INTERNAL_OFFSET			0x54a
-#define mmUVD_SCRATCH9_INTERNAL_OFFSET				0xc01d
-
-#define mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET			0x1e1
-#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x5a6
-#define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x5a7
-#define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x1e2
+#define mmUVD_CONTEXT_ID_INTERNAL_OFFSET            0x1fd
+#define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET            0x503
+#define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET          0x504
+#define mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET          0x505
+#define mmUVD_NO_OP_INTERNAL_OFFSET             0x53f
+#define mmUVD_GP_SCRATCH8_INTERNAL_OFFSET           0x54a
+#define mmUVD_SCRATCH9_INTERNAL_OFFSET              0xc01d
+#define mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET           0x1e1
+#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET     0x5a6
+#define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET      0x5a7
+#define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET           0x1e2
+#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET             0x1bfff
+#define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET                0x4029
+#define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET              0x402a
+#define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET              0x402b
+#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET      0x40ea
+#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET     0x40eb
+#define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET              0x40cf
+#define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET             0x40d1
+#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET         0x40e8
+#define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET        0x40e9
+#define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET              0x4082
+#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET      0x40ec
+#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET     0x40ed
+#define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET         0x4085
+#define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET              0x4084
+#define mmUVD_JRBC_STATUS_INTERNAL_OFFSET               0x4089
+#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET                0x401f
+#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR                0x18000
+#define mmUVD_RBC_XX_IB_REG_CHECK                   0x026b
+#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX              1
+#define mmUVD_REG_XX_MASK                       0x026c
+#define mmUVD_REG_XX_MASK_BASE_IDX                  1
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
@@ -54,7 +76,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
-
+static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 /**
  * vcn_v2_0_early_init - set function pointers
  *
@@ -67,7 +89,10 @@ static int vcn_v2_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->vcn.num_vcn_inst = 1;
-	adev->vcn.num_enc_rings = 2;
+	if (amdgpu_sriov_vf(adev))
+		adev->vcn.num_enc_rings = 1;
+	else
+		adev->vcn.num_enc_rings = 2;
 
 	vcn_v2_0_set_dec_ring_funcs(adev);
 	vcn_v2_0_set_enc_ring_funcs(adev);
@@ -154,7 +179,10 @@ static int vcn_v2_0_sw_init(void *handle)
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
+		else
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
 		if (r)
@@ -163,6 +191,10 @@ static int vcn_v2_0_sw_init(void *handle)
 
 	adev->vcn.pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
 
+	r = amdgpu_virt_alloc_mm_table(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -178,6 +210,8 @@ static int vcn_v2_0_sw_fini(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -203,6 +237,9 @@ static int vcn_v2_0_hw_init(void *handle)
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
+	if (amdgpu_sriov_vf(adev))
+		vcn_v2_0_start_sriov(adev);
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		goto done;
@@ -304,6 +341,9 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 	uint32_t offset;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
@@ -448,6 +488,9 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* UVD disable CGC */
 	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -606,6 +649,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* enable UVD CGC */
 	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -658,6 +704,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 	uint32_t data = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
@@ -705,6 +754,9 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 	uint32_t data = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		/* Before power off, this indicator has to be turned on */
 		data = RREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS);
@@ -1191,6 +1243,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+
 static bool vcn_v2_0_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1215,6 +1268,9 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (vcn_v2_0_is_idle(handle))
@@ -1631,6 +1687,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
@@ -1667,6 +1726,11 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
@@ -1680,6 +1744,215 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	return ret;
 }
 
+static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
+				struct amdgpu_mm_table *table)
+{
+	uint32_t data = 0, loop;
+	uint64_t addr = table->gpu_addr;
+	struct mmsch_v2_0_init_header *header;
+	uint32_t size;
+	int i;
+
+	header = (struct mmsch_v2_0_init_header *)table->cpu_addr;
+	size = header->header_size + header->vcn_table_size;
+
+	/* 1, write to vce_mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
+	 * of memory descriptor location
+	 */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(addr));
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(addr));
+
+	/* 2, update vmid of descriptor */
+	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID);
+	data &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+	/* use domain0 for MM scheduler */
+	data |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID, data);
+
+	/* 3, notify mmsch about the size of this descriptor */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_SIZE, size);
+
+	/* 4, set resp to zero */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
+
+	adev->vcn.inst->ring_dec.wptr = 0;
+	adev->vcn.inst->ring_dec.wptr_old = 0;
+	vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		adev->vcn.inst->ring_enc[i].wptr = 0;
+		adev->vcn.inst->ring_enc[i].wptr_old = 0;
+		vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
+	}
+
+	/* 5, kick off the initialization and wait until
+	 * VCE_MMSCH_VF_MAILBOX_RESP becomes non-zero
+	 */
+	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_HOST, 0x10000001);
+
+	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+	loop = 1000;
+	while ((data & 0x10000002) != 0x10000002) {
+		udelay(10);
+		data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+		loop--;
+		if (!loop)
+			break;
+	}
+
+	if (!loop) {
+		DRM_ERROR("failed to init MMSCH, " \
+			"mmMMSCH_VF_MAILBOX_RESP = 0x%08x\n", data);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
+{
+	int r;
+	uint32_t tmp;
+	struct amdgpu_ring *ring;
+	uint32_t offset, size;
+	uint32_t table_size = 0;
+	struct mmsch_v2_0_cmd_direct_write direct_wt = { {0} };
+	struct mmsch_v2_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
+	struct mmsch_v2_0_cmd_direct_polling direct_poll = { {0} };
+	struct mmsch_v2_0_cmd_end end = { {0} };
+	struct mmsch_v2_0_init_header *header;
+	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
+	uint8_t i = 0;
+
+	header = (struct mmsch_v2_0_init_header *)init_table;
+	direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	direct_poll.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_POLLING;
+	end.cmd_header.command_type = MMSCH_COMMAND__END;
+
+	if (header->vcn_table_offset == 0 && header->vcn_table_size == 0) {
+		header->version = MMSCH_VERSION;
+		header->header_size = sizeof(struct mmsch_v2_0_init_header) >> 2;
+
+		header->vcn_table_offset = header->header_size;
+
+		init_table += header->vcn_table_offset;
+
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+
+		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
+			0xFFFFFFFF, 0x00000004);
+
+		/* mc resume*/
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			tmp = AMDGPU_UCODE_ID_VCN;
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[tmp].tmr_mc_addr_lo);
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[tmp].tmr_mc_addr_hi);
+			offset = 0;
+		} else {
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i,
+					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst->gpu_addr));
+			offset = size;
+		}
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
+			size);
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst->gpu_addr + offset));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst->gpu_addr + offset));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
+			AMDGPU_VCN_STACK_SIZE);
+
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst->gpu_addr + offset +
+				AMDGPU_VCN_STACK_SIZE));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst->gpu_addr + offset +
+				AMDGPU_VCN_STACK_SIZE));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
+			0);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
+			AMDGPU_VCN_CONTEXT_SIZE);
+
+		for (r = 0; r < adev->vcn.num_enc_rings; ++r) {
+			ring = &adev->vcn.inst->ring_enc[r];
+			ring->wptr = 0;
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
+				lower_32_bits(ring->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
+				upper_32_bits(ring->gpu_addr));
+			MMSCH_V2_0_INSERT_DIRECT_WT(
+				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
+				ring->ring_size / 4);
+		}
+
+		ring = &adev->vcn.inst->ring_dec;
+		ring->wptr = 0;
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
+			lower_32_bits(ring->gpu_addr));
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i,
+				mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
+			upper_32_bits(ring->gpu_addr));
+		/* force RBC into idle state */
+		tmp = order_base_2(ring->ring_size);
+		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+		MMSCH_V2_0_INSERT_DIRECT_WT(
+			SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
+
+		/* add end packet */
+		tmp = sizeof(struct mmsch_v2_0_cmd_end);
+		memcpy((void *)init_table, &end, tmp);
+		table_size += (tmp / 4);
+		header->vcn_table_size = table_size;
+
+	}
+	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
+}
+
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.name = "vcn_v2_0",
 	.early_init = vcn_v2_0_early_init,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_offset.h
index b089af6..e67cfcf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_offset.h
@@ -22,6 +22,203 @@
 #define _vcn_2_0_0_OFFSET_HEADER
 
 
+// addressBlock: uvd0_mmsch_dec
+// base address: 0x1e000
+#define mmMMSCH_UCODE_ADDR                                                                             0x0000
+#define mmMMSCH_UCODE_ADDR_BASE_IDX                                                                    0
+#define mmMMSCH_UCODE_DATA                                                                             0x0001
+#define mmMMSCH_UCODE_DATA_BASE_IDX                                                                    0
+#define mmMMSCH_SRAM_ADDR                                                                              0x0002
+#define mmMMSCH_SRAM_ADDR_BASE_IDX                                                                     0
+#define mmMMSCH_SRAM_DATA                                                                              0x0003
+#define mmMMSCH_SRAM_DATA_BASE_IDX                                                                     0
+#define mmMMSCH_VF_SRAM_OFFSET                                                                         0x0004
+#define mmMMSCH_VF_SRAM_OFFSET_BASE_IDX                                                                0
+#define mmMMSCH_DB_SRAM_OFFSET                                                                         0x0005
+#define mmMMSCH_DB_SRAM_OFFSET_BASE_IDX                                                                0
+#define mmMMSCH_CTX_SRAM_OFFSET                                                                        0x0006
+#define mmMMSCH_CTX_SRAM_OFFSET_BASE_IDX                                                               0
+#define mmMMSCH_CTL                                                                                    0x0007
+#define mmMMSCH_CTL_BASE_IDX                                                                           0
+#define mmMMSCH_INTR                                                                                   0x0008
+#define mmMMSCH_INTR_BASE_IDX                                                                          0
+#define mmMMSCH_INTR_ACK                                                                               0x0009
+#define mmMMSCH_INTR_ACK_BASE_IDX                                                                      0
+#define mmMMSCH_INTR_STATUS                                                                            0x000a
+#define mmMMSCH_INTR_STATUS_BASE_IDX                                                                   0
+#define mmMMSCH_VF_VMID                                                                                0x000b
+#define mmMMSCH_VF_VMID_BASE_IDX                                                                       0
+#define mmMMSCH_VF_CTX_ADDR_LO                                                                         0x000c
+#define mmMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                                                0
+#define mmMMSCH_VF_CTX_ADDR_HI                                                                         0x000d
+#define mmMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                                                0
+#define mmMMSCH_VF_CTX_SIZE                                                                            0x000e
+#define mmMMSCH_VF_CTX_SIZE_BASE_IDX                                                                   0
+#define mmMMSCH_VF_GPCOM_ADDR_LO                                                                       0x000f
+#define mmMMSCH_VF_GPCOM_ADDR_LO_BASE_IDX                                                              0
+#define mmMMSCH_VF_GPCOM_ADDR_HI                                                                       0x0010
+#define mmMMSCH_VF_GPCOM_ADDR_HI_BASE_IDX                                                              0
+#define mmMMSCH_VF_GPCOM_SIZE                                                                          0x0011
+#define mmMMSCH_VF_GPCOM_SIZE_BASE_IDX                                                                 0
+#define mmMMSCH_VF_MAILBOX_HOST                                                                        0x0012
+#define mmMMSCH_VF_MAILBOX_HOST_BASE_IDX                                                               0
+#define mmMMSCH_VF_MAILBOX_RESP                                                                        0x0013
+#define mmMMSCH_VF_MAILBOX_RESP_BASE_IDX                                                               0
+#define mmMMSCH_VF_MAILBOX_0                                                                           0x0014
+#define mmMMSCH_VF_MAILBOX_0_BASE_IDX                                                                  0
+#define mmMMSCH_VF_MAILBOX_0_RESP                                                                      0x0015
+#define mmMMSCH_VF_MAILBOX_0_RESP_BASE_IDX                                                             0
+#define mmMMSCH_VF_MAILBOX_1                                                                           0x0016
+#define mmMMSCH_VF_MAILBOX_1_BASE_IDX                                                                  0
+#define mmMMSCH_VF_MAILBOX_1_RESP                                                                      0x0017
+#define mmMMSCH_VF_MAILBOX_1_RESP_BASE_IDX                                                             0
+#define mmMMSCH_CNTL                                                                                   0x001c
+#define mmMMSCH_CNTL_BASE_IDX                                                                          0
+#define mmMMSCH_NONCACHE_OFFSET0                                                                       0x001d
+#define mmMMSCH_NONCACHE_OFFSET0_BASE_IDX                                                              0
+#define mmMMSCH_NONCACHE_SIZE0                                                                         0x001e
+#define mmMMSCH_NONCACHE_SIZE0_BASE_IDX                                                                0
+#define mmMMSCH_NONCACHE_OFFSET1                                                                       0x001f
+#define mmMMSCH_NONCACHE_OFFSET1_BASE_IDX                                                              0
+#define mmMMSCH_NONCACHE_SIZE1                                                                         0x0020
+#define mmMMSCH_NONCACHE_SIZE1_BASE_IDX                                                                0
+#define mmMMSCH_PDEBUG_STATUS                                                                          0x0021
+#define mmMMSCH_PDEBUG_STATUS_BASE_IDX                                                                 0
+#define mmMMSCH_PDEBUG_DATA_32UPPERBITS                                                                0x0022
+#define mmMMSCH_PDEBUG_DATA_32UPPERBITS_BASE_IDX                                                       0
+#define mmMMSCH_PDEBUG_DATA_32LOWERBITS                                                                0x0023
+#define mmMMSCH_PDEBUG_DATA_32LOWERBITS_BASE_IDX                                                       0
+#define mmMMSCH_PDEBUG_EPC                                                                             0x0024
+#define mmMMSCH_PDEBUG_EPC_BASE_IDX                                                                    0
+#define mmMMSCH_PDEBUG_EXCCAUSE                                                                        0x0025
+#define mmMMSCH_PDEBUG_EXCCAUSE_BASE_IDX                                                               0
+#define mmMMSCH_PROC_STATE1                                                                            0x0026
+#define mmMMSCH_PROC_STATE1_BASE_IDX                                                                   0
+#define mmMMSCH_LAST_MC_ADDR                                                                           0x0027
+#define mmMMSCH_LAST_MC_ADDR_BASE_IDX                                                                  0
+#define mmMMSCH_LAST_MEM_ACCESS_HI                                                                     0x0028
+#define mmMMSCH_LAST_MEM_ACCESS_HI_BASE_IDX                                                            0
+#define mmMMSCH_LAST_MEM_ACCESS_LO                                                                     0x0029
+#define mmMMSCH_LAST_MEM_ACCESS_LO_BASE_IDX                                                            0
+#define mmMMSCH_IOV_ACTIVE_FCN_ID                                                                      0x002a
+#define mmMMSCH_IOV_ACTIVE_FCN_ID_BASE_IDX                                                             0
+#define mmMMSCH_SCRATCH_0                                                                              0x002b
+#define mmMMSCH_SCRATCH_0_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_1                                                                              0x002c
+#define mmMMSCH_SCRATCH_1_BASE_IDX                                                                     0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_0                                                                     0x002d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_0_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_0                                                                   0x002e
+#define mmMMSCH_GPUIOV_CMD_CONTROL_0_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_0                                                                    0x002f
+#define mmMMSCH_GPUIOV_CMD_STATUS_0_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0                                                                0x0030
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0                                                                   0x0031
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0                                                                 0x0032
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_0                                                                           0x0033
+#define mmMMSCH_GPUIOV_DW6_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_0                                                                           0x0034
+#define mmMMSCH_GPUIOV_DW7_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_0                                                                           0x0035
+#define mmMMSCH_GPUIOV_DW8_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_1                                                                     0x0036
+#define mmMMSCH_GPUIOV_SCH_BLOCK_1_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_1                                                                   0x0037
+#define mmMMSCH_GPUIOV_CMD_CONTROL_1_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_1                                                                    0x0038
+#define mmMMSCH_GPUIOV_CMD_STATUS_1_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1                                                                0x0039
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1                                                                   0x003a
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1                                                                 0x003b
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_1                                                                           0x003c
+#define mmMMSCH_GPUIOV_DW6_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_1                                                                           0x003d
+#define mmMMSCH_GPUIOV_DW7_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_1                                                                           0x003e
+#define mmMMSCH_GPUIOV_DW8_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_CNTXT                                                                           0x003f
+#define mmMMSCH_GPUIOV_CNTXT_BASE_IDX                                                                  0
+#define mmMMSCH_SCRATCH_2                                                                              0x0040
+#define mmMMSCH_SCRATCH_2_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_3                                                                              0x0041
+#define mmMMSCH_SCRATCH_3_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_4                                                                              0x0042
+#define mmMMSCH_SCRATCH_4_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_5                                                                              0x0043
+#define mmMMSCH_SCRATCH_5_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_6                                                                              0x0044
+#define mmMMSCH_SCRATCH_6_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_7                                                                              0x0045
+#define mmMMSCH_SCRATCH_7_BASE_IDX                                                                     0
+#define mmMMSCH_VFID_FIFO_HEAD_0                                                                       0x0046
+#define mmMMSCH_VFID_FIFO_HEAD_0_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_0                                                                       0x0047
+#define mmMMSCH_VFID_FIFO_TAIL_0_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_HEAD_1                                                                       0x0048
+#define mmMMSCH_VFID_FIFO_HEAD_1_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_1                                                                       0x0049
+#define mmMMSCH_VFID_FIFO_TAIL_1_BASE_IDX                                                              0
+#define mmMMSCH_NACK_STATUS                                                                            0x004a
+#define mmMMSCH_NACK_STATUS_BASE_IDX                                                                   0
+#define mmMMSCH_VF_MAILBOX0_DATA                                                                       0x004b
+#define mmMMSCH_VF_MAILBOX0_DATA_BASE_IDX                                                              0
+#define mmMMSCH_VF_MAILBOX1_DATA                                                                       0x004c
+#define mmMMSCH_VF_MAILBOX1_DATA_BASE_IDX                                                              0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0                                                                  0x004d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0                                                                 0x004e
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0                                                              0x004f
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0_BASE_IDX                                                     0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1                                                                  0x0050
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1                                                                 0x0051
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1                                                              0x0052
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1_BASE_IDX                                                     0
+#define mmMMSCH_GPUIOV_CNTXT_IP                                                                        0x0053
+#define mmMMSCH_GPUIOV_CNTXT_IP_BASE_IDX                                                               0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_2                                                                     0x0054
+#define mmMMSCH_GPUIOV_SCH_BLOCK_2_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_2                                                                   0x0055
+#define mmMMSCH_GPUIOV_CMD_CONTROL_2_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_2                                                                    0x0056
+#define mmMMSCH_GPUIOV_CMD_STATUS_2_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2                                                                0x0057
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2                                                                   0x0058
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2                                                                 0x0059
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_2                                                                           0x005a
+#define mmMMSCH_GPUIOV_DW6_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_2                                                                           0x005b
+#define mmMMSCH_GPUIOV_DW7_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_2                                                                           0x005c
+#define mmMMSCH_GPUIOV_DW8_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2                                                                  0x005d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2                                                                 0x005e
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2                                                              0x005f
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2_BASE_IDX                                                     0
+#define mmMMSCH_VFID_FIFO_HEAD_2                                                                       0x0060
+#define mmMMSCH_VFID_FIFO_HEAD_2_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_2                                                                       0x0061
+#define mmMMSCH_VFID_FIFO_TAIL_2_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_0                                                                       0x0062
+#define mmMMSCH_VM_BUSY_STATUS_0_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_1                                                                       0x0063
+#define mmMMSCH_VM_BUSY_STATUS_1_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_2                                                                       0x0064
+#define mmMMSCH_VM_BUSY_STATUS_2_BASE_IDX                                                              0
+
 
 // addressBlock: uvd0_jpegnpdec
 // base address: 0x1e200
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
