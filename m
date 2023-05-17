Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B09C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 15:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401A110E44B;
	Wed, 17 May 2023 15:57:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0DC10E44B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 15:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdDV5ASh6PR8tpxuIEneLZTynQQQhexoCQawCnuOdVrhme8JfiA0F2okKWrTLfGTgEgnCsB0kLepf9Xssu7pCwmTQe//LgRwYDsi/J5r3TZXPugBGvPRUTdjiLVv5o5KwNfS9OaillF3yOKzAwjouOEjy9wGM94iikBmmWfaiFIyNRAMdHsEbTjmxrO1OSf1UrOAjiZLKORErglsLqtHCsUXBCbLJnMIUcg/1ToN9q3qlbw1Cc8k+z3sYDgN2D/M1UHvx6Cd0ERolO9o4vrTncLDRhuvYZ7Jz+qAOnX7ybrHhq4GeClyqrpE/yIMPVq+5Jl3fU0M+hYS7goSr1UdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ottBNw4vmraF8TAt4bhF2fBVbbY0jFnX6Yu8/fmx9JU=;
 b=NKk51j/cmaloJS64xGGxpzOy61Leq/cBGof8MGEi5yeTiEPDEUzr1nDN51B57Thvb0CcfSiwNLAOez6q6OnuQPaMUkjvwYDmI6IN3IO0UxfJh9KQcvFaTlW7PV6NC9Zx0du7itobRrOG23iiE6JNhGheJayfeCl2RHduZTjyuLw/bCKyVPZXrHuEt1woBtx1fJPH1fPPbM6tCoQtommppRvhYjfnHWptvRCFlCEOLUuv3CxD7jVM0WrzbNg2efPhj8AbWSESIvbkhbYK8q67FmI2GDUlMixeLqqSW4XoYoqnO5MOpJ+aHUzh2044hehuWZRdRtsd4b9Wq1nwynL+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ottBNw4vmraF8TAt4bhF2fBVbbY0jFnX6Yu8/fmx9JU=;
 b=yGW5edZuwrSoJVYWYQ8AsOOwUogLJN5RmobE4stYei4q3H8nbmvgcoISw9cBuWcX0mpgPhXruxs67Tx/G4FsI3D/cq3utreHT0wLQ0O0Zv9QnzQgRFn4gTiWbomLPBwN8yasEPwpvmJvitZBjlnDWV1OwXWDYp69lWKpgW5NnWQ=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Wed, 17 May 2023 15:57:17 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::ab) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 15:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:57:16 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 10:57:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu _uvd, _vce.c
Date: Wed, 17 May 2023 21:26:42 +0530
Message-ID: <20230517155642.2393980-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: e2321951-323b-40aa-4ac2-08db56ef6382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZ2Cs8FHYPsCzZ3Dz0lNU+EsOWUDR9/x2+vclQ1QzMYyU2JKsUfJWVx8b3Rc2PrliQyPc0ibVGbPbRnShMNg7gKTeuWnLLKCPK0P42i60+iPhLUcLgjtR9iNOsTauDK9lL7ra70y0S2NmHuubGWHe6uNqycCRrU5U3lHS7iDOt8xoH7f8MjOAnsWc4YZ3TVDEwJy0+KM0BTu2C3Ogi4F3ZtKacRBjPs/dDQPVWjcikU0vE3zL4Ggvt7WshGhRX9XhNEfP2e8szG8GAoC9ceGN/W7+FbhDfrVrCc6tsPhL4nVoJYObXmzPG+OU+KSKHP9HuP560LcCmdo5B8VDuZyuLkIi08Dek0p9oCH4E4a4ShBxZdtMSiPQH26EKCnwNh3YafcpJHGHMs8A+d9zYxZ/3q7ZVLUhB1KcHKWximm4IjbX2UZqLWgN5WE3EfnnzF3fjUNMOnkaTmqZGStr0Xlr6xSMXdFG57cDuc3grwSJZKgoxGNJg3EpvS0gJ6tJKT9ynaD4D4w2eI7F00Ss28QdPaJ0XHtYaIyQDCYKSAfnKTu52+4K1C7mAH7vOCLo4JrBbtOg7kEyH6tKYMOftmbC6KIyAemcT4gqjbAtNW217BnrEaP/NmCiXsuaP1A+hbPdZLsfXqvhegLQrT8U5NOGFarh8AQVPcdHnQ96qHLqliiowb/J4wRvuH13kDNe+y7MKVgaZ5C0MDXOyDfS+v69wog+56Y1VtrP7+GdjZ7W9nheIwDfGKNbfBQyiF2jxuTaxkELefNCBTyS6Xz17gMYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(40460700003)(356005)(82740400003)(81166007)(41300700001)(8676002)(5660300002)(30864003)(8936002)(36756003)(6636002)(86362001)(316002)(4326008)(40480700001)(82310400005)(70206006)(70586007)(2906002)(336012)(66574015)(426003)(47076005)(16526019)(26005)(186003)(1076003)(44832011)(478600001)(7696005)(2616005)(6666004)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:57:16.9244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2321951-323b-40aa-4ac2-08db56ef6382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch errors & warnings:

In amdgpu_uvd.c:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
WARNING: Missing a blank line after declarations
WARNING: %Lx is non-standard C, use %llx
ERROR: space required before the open parenthesis '('
ERROR: space required before the open brace '{'
WARNING: %LX is non-standard C, use %llX
WARNING: Block comments use * on subsequent lines
+/* multiple fence commands without any stream commands in between can
+   crash the vcpu so just try to emmit a dummy create/destroy msg to

WARNING: Block comments use a trailing */ on a separate line
+   avoid this */
WARNING: braces {} are not necessary for single statement blocks
+               for (j = 0; j < adev->uvd.num_enc_rings; ++j) {
+                       fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring_enc[j]);
+               }

In amdgpu_vce.c:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Missing a blank line after declarations
WARNING: %Lx is non-standard C, use %llx
WARNING: Possible repeated word: 'we'
ERROR: space required before the open parenthesis '('

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 83 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 39 ++++++------
 2 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 6887109abb13..b7441654e6fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -96,16 +96,16 @@
  */
 struct amdgpu_uvd_cs_ctx {
 	struct amdgpu_cs_parser *parser;
-	unsigned reg, count;
-	unsigned data0, data1;
-	unsigned idx;
+	unsigned int reg, count;
+	unsigned int data0, data1;
+	unsigned int idx;
 	struct amdgpu_ib *ib;
 
 	/* does the IB has a msg command */
 	bool has_msg_cmd;
 
 	/* minimum buffer sizes */
-	unsigned *buf_sizes;
+	unsigned int *buf_sizes;
 };
 
 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -186,7 +186,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	unsigned long bo_size;
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
-	unsigned family_id;
+	unsigned int family_id;
 	int i, j, r;
 
 	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
@@ -275,7 +275,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 
 	if (adev->asic_type < CHIP_VEGA20) {
-		unsigned version_major, version_minor;
+		unsigned int version_major, version_minor;
 
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
@@ -420,7 +420,7 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
 
 int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 {
-	unsigned size;
+	unsigned int size;
 	void *ptr;
 	int i, j, idx;
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
@@ -469,7 +469,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 
 int amdgpu_uvd_resume(struct amdgpu_device *adev)
 {
-	unsigned size;
+	unsigned int size;
 	void *ptr;
 	int i, idx;
 
@@ -491,7 +491,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			adev->uvd.inst[i].saved_bo = NULL;
 		} else {
 			const struct common_firmware_header *hdr;
-			unsigned offset;
+			unsigned int offset;
 
 			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
@@ -542,6 +542,7 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
 {
 	int i;
+
 	for (i = 0; i < abo->placement.num_placement; ++i) {
 		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
 		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
@@ -579,7 +580,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 
 	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
+		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
 		return r;
 	}
 
@@ -589,6 +590,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 		if (cmd == 0x0 || cmd == 0x3) {
 			/* yes, force it into VRAM */
 			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
+
 			amdgpu_bo_placement_from_domain(bo, domain);
 		}
 		amdgpu_uvd_force_into_uvd_segment(bo);
@@ -609,21 +611,21 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
  * Peek into the decode message and calculate the necessary buffer sizes.
  */
 static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
-	unsigned buf_sizes[])
+	unsigned int buf_sizes[])
 {
-	unsigned stream_type = msg[4];
-	unsigned width = msg[6];
-	unsigned height = msg[7];
-	unsigned dpb_size = msg[9];
-	unsigned pitch = msg[28];
-	unsigned level = msg[57];
+	unsigned int stream_type = msg[4];
+	unsigned int width = msg[6];
+	unsigned int height = msg[7];
+	unsigned int dpb_size = msg[9];
+	unsigned int pitch = msg[28];
+	unsigned int level = msg[57];
 
-	unsigned width_in_mb = width / 16;
-	unsigned height_in_mb = ALIGN(height / 16, 2);
-	unsigned fs_in_mb = width_in_mb * height_in_mb;
+	unsigned int width_in_mb = width / 16;
+	unsigned int height_in_mb = ALIGN(height / 16, 2);
+	unsigned int fs_in_mb = width_in_mb * height_in_mb;
 
-	unsigned image_size, tmp, min_dpb_size, num_dpb_buffer;
-	unsigned min_ctx_size = ~0;
+	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
+	unsigned int min_ctx_size = ~0;
 
 	image_size = width * height;
 	image_size += image_size / 2;
@@ -631,7 +633,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 
 	switch (stream_type) {
 	case 0: /* H264 */
-		switch(level) {
+		switch (level) {
 		case 30:
 			num_dpb_buffer = 8100 / fs_in_mb;
 			break;
@@ -709,7 +711,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		break;
 
 	case 7: /* H264 Perf */
-		switch(level) {
+		switch (level) {
 		case 30:
 			num_dpb_buffer = 8100 / fs_in_mb;
 			break;
@@ -742,7 +744,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		/* reference picture buffer */
 		min_dpb_size = image_size * num_dpb_buffer;
 
-		if (!adev->uvd.use_ctx_buf){
+		if (!adev->uvd.use_ctx_buf) {
 			/* macroblock context buffer */
 			min_dpb_size +=
 				width_in_mb * height_in_mb * num_dpb_buffer * 192;
@@ -805,7 +807,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
  * Make sure that we don't open up to many sessions.
  */
 static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
-			     struct amdgpu_bo *bo, unsigned offset)
+			     struct amdgpu_bo *bo, unsigned int offset)
 {
 	struct amdgpu_device *adev = ctx->parser->adev;
 	int32_t *msg, msg_type, handle;
@@ -911,7 +913,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 
 	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
+		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
 		return r;
 	}
 
@@ -930,7 +932,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 	if (cmd < 0x4) {
 		if ((end - start) < ctx->buf_sizes[cmd]) {
 			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-				  (unsigned)(end - start),
+				  (unsigned int)(end - start),
 				  ctx->buf_sizes[cmd]);
 			return -EINVAL;
 		}
@@ -938,7 +940,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 	} else if (cmd == 0x206) {
 		if ((end - start) < ctx->buf_sizes[4]) {
 			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-					  (unsigned)(end - start),
+					  (unsigned int)(end - start),
 					  ctx->buf_sizes[4]);
 			return -EINVAL;
 		}
@@ -949,14 +951,14 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 
 	if (!ctx->parser->adev->uvd.address_64_bit) {
 		if ((start >> 28) != ((end - 1) >> 28)) {
-			DRM_ERROR("reloc %LX-%LX crossing 256MB boundary!\n",
+			DRM_ERROR("reloc %llx-%llx crossing 256MB boundary!\n",
 				  start, end);
 			return -EINVAL;
 		}
 
 		if ((cmd == 0 || cmd == 0x3) &&
 		    (start >> 28) != (ctx->parser->adev->uvd.inst->gpu_addr >> 28)) {
-			DRM_ERROR("msg/fb buffer %LX-%LX out of 256MB segment!\n",
+			DRM_ERROR("msg/fb buffer %llx-%llx out of 256MB segment!\n",
 				  start, end);
 			return -EINVAL;
 		}
@@ -990,7 +992,7 @@ static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
 
 	ctx->idx++;
 	for (i = 0; i <= ctx->count; ++i) {
-		unsigned reg = ctx->reg + i;
+		unsigned int reg = ctx->reg + i;
 
 		if (ctx->idx >= ctx->ib->length_dw) {
 			DRM_ERROR("Register command after end of CS!\n");
@@ -1036,7 +1038,8 @@ static int amdgpu_uvd_cs_packets(struct amdgpu_uvd_cs_ctx *ctx,
 
 	for (ctx->idx = 0 ; ctx->idx < ctx->ib->length_dw; ) {
 		uint32_t cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx);
-		unsigned type = CP_PACKET_GET_TYPE(cmd);
+		unsigned int type = CP_PACKET_GET_TYPE(cmd);
+
 		switch (type) {
 		case PACKET_TYPE0:
 			ctx->reg = CP_PACKET0_GET_REG(cmd);
@@ -1070,7 +1073,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 			     struct amdgpu_ib *ib)
 {
 	struct amdgpu_uvd_cs_ctx ctx = {};
-	unsigned buf_sizes[] = {
+	unsigned int buf_sizes[] = {
 		[0x00000000]	=	2048,
 		[0x00000001]	=	0xFFFFFFFF,
 		[0x00000002]	=	0xFFFFFFFF,
@@ -1185,8 +1188,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 }
 
 /* multiple fence commands without any stream commands in between can
-   crash the vcpu so just try to emmit a dummy create/destroy msg to
-   avoid this */
+ * crash the vcpu so just try to emmit a dummy create/destroy msg to
+ * avoid this
+ */
 int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
@@ -1252,15 +1256,14 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, uvd.idle_work.work);
-	unsigned fences = 0, i, j;
+	unsigned int fences = 0, i, j;
 
 	for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
 		if (adev->uvd.harvest_config & (1 << i))
 			continue;
 		fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring);
-		for (j = 0; j < adev->uvd.num_enc_rings; ++j) {
+		for (j = 0; j < adev->uvd.num_enc_rings; ++j)
 			fences += amdgpu_fence_count_emitted(&adev->uvd.inst[i].ring_enc[j]);
-		}
 	}
 
 	if (fences == 0) {
@@ -1356,7 +1359,7 @@ int amdgpu_uvd_ring_test_ib(struct amdgpu_ring *ring, long timeout)
  */
 uint32_t amdgpu_uvd_used_handles(struct amdgpu_device *adev)
 {
-	unsigned i;
+	unsigned int i;
 	uint32_t used_handles = 0;
 
 	for (i = 0; i < adev->uvd.max_handles; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index e2b7324a70cb..1904edf68407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -99,7 +99,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 {
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
-	unsigned ucode_version, version_major, version_minor, binary_id;
+	unsigned int ucode_version, version_major, version_minor, binary_id;
 	int i, r;
 
 	switch (adev->asic_type) {
@@ -207,7 +207,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
  */
 int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 {
-	unsigned i;
+	unsigned int i;
 
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
@@ -286,7 +286,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 {
 	void *cpu_addr;
 	const struct common_firmware_header *hdr;
-	unsigned offset;
+	unsigned int offset;
 	int r, idx;
 
 	if (adev->vce.vcpu_bo == NULL)
@@ -332,7 +332,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, vce.idle_work.work);
-	unsigned i, count = 0;
+	unsigned int i, count = 0;
 
 	for (i = 0; i < adev->vce.num_rings; i++)
 		count += amdgpu_fence_count_emitted(&adev->vce.ring[i]);
@@ -409,6 +409,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 {
 	struct amdgpu_ring *ring = &adev->vce.ring[0];
 	int i, r;
+
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
 		uint32_t handle = atomic_read(&adev->vce.handles[i]);
 
@@ -436,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 				     struct dma_fence **fence)
 {
-	const unsigned ib_size_dw = 1024;
+	const unsigned int ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct amdgpu_ib ib_msg;
@@ -528,7 +529,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence)
 {
-	const unsigned ib_size_dw = 1024;
+	const unsigned int ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
@@ -596,12 +597,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
  */
 static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
 				  struct amdgpu_ib *ib, int lo, int hi,
-				  unsigned size, int32_t index)
+				  unsigned int size, int32_t index)
 {
 	int64_t offset = ((uint64_t)size) * ((int64_t)index);
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *mapping;
-	unsigned i, fpfn, lpfn;
+	unsigned int i, fpfn, lpfn;
 	struct amdgpu_bo *bo;
 	uint64_t addr;
 	int r;
@@ -619,7 +620,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
 
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%010Lx %d %d %d %d\n",
+		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
 			  addr, lo, hi, size, index);
 		return r;
 	}
@@ -646,7 +647,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
  * Patch relocation inside command stream with real buffer address
  */
 static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
-			       int lo, int hi, unsigned size, uint32_t index)
+			       int lo, int hi, unsigned int size, uint32_t index)
 {
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
@@ -662,14 +663,14 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
 
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%010Lx %d %d %d %d\n",
+		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
 			  addr, lo, hi, size, index);
 		return r;
 	}
 
 	if ((addr + (uint64_t)size) >
 	    (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-		DRM_ERROR("BO too small for addr 0x%010Lx %d %d\n",
+		DRM_ERROR("BO too small for addr 0x%010llx %d %d\n",
 			  addr, lo, hi);
 		return -EINVAL;
 	}
@@ -692,12 +693,12 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
  * @allocated: allocated a new handle?
  *
  * Validates the handle and return the found session index or -EINVAL
- * we we don't have another free session index.
+ * we don't have another free session index.
  */
 static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
 				      uint32_t handle, uint32_t *allocated)
 {
-	unsigned i;
+	unsigned int i;
 
 	/* validate the handle */
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
@@ -735,14 +736,14 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 			     struct amdgpu_job *job,
 			     struct amdgpu_ib *ib)
 {
-	unsigned fb_idx = 0, bs_idx = 0;
+	unsigned int fb_idx = 0, bs_idx = 0;
 	int session_idx = -1;
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
 	uint32_t *size = &tmp;
-	unsigned idx;
+	unsigned int idx;
 	int i, r = 0;
 
 	job->vm = NULL;
@@ -1084,7 +1085,7 @@ void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,
  *
  */
 void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
-				unsigned flags)
+				unsigned int flags)
 {
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
@@ -1106,7 +1107,7 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t rptr;
-	unsigned i;
+	unsigned int i;
 	int r, timeout = adev->usec_timeout;
 
 	/* skip ring test for sriov*/
@@ -1171,7 +1172,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring)
 {
-	switch(ring) {
+	switch (ring) {
 	case 0:
 		return AMDGPU_RING_PRIO_0;
 	case 1:
-- 
2.25.1

