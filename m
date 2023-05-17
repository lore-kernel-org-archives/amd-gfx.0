Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16BEC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 15:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A05710E440;
	Wed, 17 May 2023 15:17:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1539E10E440
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 15:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imY3TUYbxnB+Ak7JT+qsyuDH/E4610iu4eESG7Lk6KJ7sMN3e2TgcKc05QrGT4pQ/MvJgeXDbzh9wFOB0ZZFNpKOD0Wd8XgUEBp4q8ZizaKU56qKSBxx+PCgHnxZUBc+Z7DEb/ByGnOj57AVqT2oDzJ/k/e+UPqLHyt40v6u+aqK0IE1bWr0yD5+RQVwU/SdKDA8aRFLLSOmr+VDIxMgg2uNnxMJMTy06HBqdBiN0gctVMPpOiKkV6+zWNXFlj8si5VfnCYQh4udQT6R/I76VJ85E0nwv0v60OtRm58FyoqXULhkHX60/hIB4CGTMcRMlxPmHjfy5kVS5swzRwp0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpAhapyZG35OfYlDQiXrCwg40hmo4aPhFXWQj1IanEY=;
 b=RIkpu5ARFipian0f0pzX6g6Y2bizx91f5RJLWK5uB5ng6cx4dvUGNAp9pBsaOGuDditLA0qcw2wTSN/lg39Z1GA1qx36CQimoQxaCZQDiM8/vigAF/1Q80tkKCUZiPy3lzrT23ThmMBuHhPxpiIa5U5r3Fo0ysh5IBKrfU4dy3ZkG8nBN3mzMdqJxxzNv1KyQ9RXW7bvcQnnAGf7qk/VFAlm8r4r304BW4XH5RO/Gntx5kebbONtLBdV3x9dHZ6KPdX4D0qfSTzD7wubrzHgsl32TzHzZrjrM9WPgoykK47esQsY+BhYOEXWZOWkj4kzWWR72+3yae7GDhzuicKNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpAhapyZG35OfYlDQiXrCwg40hmo4aPhFXWQj1IanEY=;
 b=1VTmQCnvcCTCWpmQ+Q3WnlN7LvaCmkgk71XN35+pQJXmyB/QZTNx2+8JwZX2YgbkggHxM+IzsDsgatZOsbIbdoJqPnbY7flBC6XxUy7ivU9NKouYRg8MoYOA5J5gGOV8nExEn8Q2sTQvOb9FnXS5bpM5UVAY5GmyWW/wYZYrzKk=
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 15:16:58 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::dd) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 15:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:16:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 10:16:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu_vcn.c
Date: Wed, 17 May 2023 20:43:46 +0530
Message-ID: <20230517151346.2357528-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 423c73dd-982e-48e2-eb07-08db56e9c1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4EIl293W+VEh0+M4tK1BvKo6uEkVLMew+F4JGIo5y9gHA2JWUpEndWBtRq0aGlk0opj/Devh3MU00vXwKPCEr+kIdF3NQycfkcCLODdh6UfXE26nNbCD8XxQ0yIxz+VCzc2C7THHwQ4LWLxyglJc2VnM6xJlzXoK4MHIb+Ydpg9ExD0/JMwd4WASBN5vJ2UxSHydQD9Uwg+I8Vr9kZ1ohMwf7hJU9q3sbQf8TUBQo2Nnu9IPYzcogi0yFNK33C8SVqrvOkgy0CUmyb3aeas3r6oqU+SnYIOhEbcrnknMlqDjWxGictP4WyRP8Wm9bsUYkOtIzUc8A8g5nC0Zm9xTJK47Mr5u8yZCcryuSZVM02RO9pJWzLsVPnDo1UTXrpoYwftbNhqy0QT5KCpu9HaEiwFiuzNIfQFsfZvcyqwd45Ium/usutff5RMTPeECBKivbCN6v2Azf1KS4+VEetkiDj7XHIBy+RthX+CznYDtMKnfD7ehLfMpAR4G6D6zOVO1+5nIXEHgasV8+U8je/Q06qUJQjramHKygQPXwIkGZ2VieOSeB+V8c8Va19KdAqx4JDA0pXV9ilIkObQv8cH3xUFaBJ9jYnbn9k1jMnlv0aJsWRI2zbBEIStW6vADZ2MeQoMU2ts1YuM3EuP4fNLtyb3vroQXeDObSBgX9sQoGd1INIABckbo62ok8aY4W+0OunUawLN/t7S1A034ohx6oksb1oZ4Acbnp10vab/wiUJ5n6Z+n5uWSX063BsyukniO390OCGFNqsKVSDtMX7sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(7696005)(6666004)(82310400005)(86362001)(2616005)(66574015)(47076005)(336012)(83380400001)(426003)(82740400003)(44832011)(36756003)(186003)(26005)(1076003)(16526019)(2906002)(356005)(36860700001)(81166007)(40480700001)(5660300002)(8676002)(8936002)(54906003)(110136005)(70206006)(70586007)(4326008)(6636002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:16:58.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423c73dd-982e-48e2-eb07-08db56e9c1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

Fix below checkpatch insisted error & warnings:

ERROR: space required before the open brace '{'
WARNING: braces {} are not necessary for any arm of this statement
+       if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
[...]
+       } else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
[...]
+       } else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
[...]
ERROR: code indent should use tabs where possible
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: braces {} are not necessary for single statement blocks
+               for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+                       fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
+
ERROR: space required before the open parenthesis '('
WARNING: Missing a blank line after declarations
WARNING: please, no spaces at the start of a line
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 ++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 06ec2dc55857..c088111c2321 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -169,7 +169,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
-	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0)){
+	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0)) {
 		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
 		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
 	} else {
@@ -276,20 +276,19 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	bool ret = false;
 	int vcn_config = adev->vcn.vcn_config[vcn_instance];
 
-	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
+	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK))
 		ret = true;
-	} else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK)) {
+	else if ((type == VCN_DECODE_RING) && (vcn_config & VCN_BLOCK_DECODE_DISABLE_MASK))
 		ret = true;
-	} else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
+	else if ((type == VCN_UNIFIED_RING) && (vcn_config & VCN_BLOCK_QUEUE_DISABLE_MASK))
 		ret = true;
-	}
 
 	return ret;
 }
 
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
-	unsigned size;
+	unsigned int size;
 	void *ptr;
 	int i, idx;
 
@@ -318,7 +317,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 
 int amdgpu_vcn_resume(struct amdgpu_device *adev)
 {
-	unsigned size;
+	unsigned int size;
 	void *ptr;
 	int i, idx;
 
@@ -340,7 +339,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			adev->vcn.inst[i].saved_bo = NULL;
 		} else {
 			const struct common_firmware_header *hdr;
-			unsigned offset;
+			unsigned int offset;
 
 			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
@@ -371,9 +370,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
-		}
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 			struct dpg_pause_state new_state;
@@ -460,7 +458,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t tmp = 0;
-	unsigned i;
+	unsigned int i;
 	int r;
 
 	/* VCN in SRIOV does not support direct register read/write */
@@ -797,7 +795,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t rptr;
-	unsigned i;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1012,7 +1010,7 @@ int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 {
-	switch(ring) {
+	switch (ring) {
 	case 0:
 		return AMDGPU_RING_PRIO_0;
 	case 1:
@@ -1031,6 +1029,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
+
 		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -1059,7 +1058,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
  */
 #if defined(CONFIG_DEBUG_FS)
 static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
-                                             size_t size, loff_t *pos)
+					     size_t size, loff_t *pos)
 {
 	struct amdgpu_vcn_inst *vcn;
 	void *log_buf;
@@ -1105,7 +1104,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
 			if (read_pos == AMDGPU_VCNFW_LOG_SIZE)
 				read_pos = plog->header_size;
 			if (read_num[i] == copy_to_user((buf + read_bytes),
-			                                (log_buf + read_pos), read_num[i]))
+							(log_buf + read_pos), read_num[i]))
 				return -EFAULT;
 
 			read_bytes += read_num[i];
@@ -1126,7 +1125,7 @@ static const struct file_operations amdgpu_debugfs_vcnfwlog_fops = {
 #endif
 
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
-                                   struct amdgpu_vcn_inst *vcn)
+				   struct amdgpu_vcn_inst *vcn)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
@@ -1134,7 +1133,7 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev, uint8_t i,
 	char name[32];
 
 	sprintf(name, "amdgpu_vcn_%d_fwlog", i);
-	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, vcn,
+	debugfs_create_file_size(name, S_IFREG | 0444, root, vcn,
 				 &amdgpu_debugfs_vcnfwlog_fops,
 				 AMDGPU_VCNFW_LOG_SIZE);
 #endif
@@ -1148,7 +1147,7 @@ void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn)
 	uint64_t fw_log_gpu_addr = vcn->fw_shared.gpu_addr + vcn->fw_shared.mem_size;
 	volatile struct amdgpu_vcn_fwlog *log_buf = fw_log_cpu_addr;
 	volatile struct amdgpu_fw_shared_fw_logging *fw_log = vcn->fw_shared.cpu_addr
-                                                         + vcn->fw_shared.log_offset;
+							 + vcn->fw_shared.log_offset;
 	*flag |= cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
 	fw_log->is_enabled = 1;
 	fw_log->addr_lo = cpu_to_le32(fw_log_gpu_addr & 0xFFFFFFFF);
-- 
2.25.1

