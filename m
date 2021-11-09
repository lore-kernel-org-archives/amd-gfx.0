Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4510A6105A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4510A6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267EF6EC8C;
	Tue,  9 Nov 2021 22:43:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C886EC78
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 22:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4WXnBG6RFKe8m5dwuzcGK8WWOIfvBd4muXZ5thcNbmVrUug5h0DiwsR86saRrENYdIEAUGd6Zawerv6/jnVIV7hFt8Zl0075rgnzOZKm2gjfnBUFU497MVkRtpT9mn2hhPEI9dMzlXGr/ZnaxbxBO0dads4xyFOPH70eBqldUryEckDfqbK2+NKP9o0ajX7BvCKWy8seQHYdorC1hkIzBYFdifKCozO1eJHVNjqKcvOC/fR4Mb6THxuOQSOJQpvjm6+j4fzIf1B6Qh8l/mWd8i8uid3Vyy0ApKj8GLc1rQzYArJ1MJF7E3DRh31b52wmmBm1gMEXsfboweP7WpwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GthUTKbqWpGp5NmkJK8rll8qKwRodmd9raJPm2/jizA=;
 b=MHHAcM+8Ci4QtAYgUt4whyJpWvJ9sKY38dETfgq46XsdUKa09m0YV5yr6Z0Ro1W9znJxZ+YRA8jDzPvJ0eM0jnW9B8tlEicbro6X3YsXVpbdgqeMkWpjFDT/aBDunM/QGczFUo16qZNcx+FWSne/b/RzyR7rt0MSycqEHehbybgbmDNlkMyysnaWrC4Po40xMG7GItxdSbKTOUuvc0oy7zYUurz8JkljcUdOHvMoICBvZsXaJGXsi+OAllCTlmRkGq+5kIRW3hAOR3v/LgcQgK1e+BDebnT46pn02u5lNDFpdyDZFquVyukQVHJQv23eSHTsJkWhdHC2TAitc+0esQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GthUTKbqWpGp5NmkJK8rll8qKwRodmd9raJPm2/jizA=;
 b=rUd1kLJoNNY28QEihf/pKmVMnmVt4TFWVLnjFujhdGcCaZCA21e7IvpYuckagOwZ1T5Lzv91AcmMo4fuPSuvG6m2XxXyVTyZd/yaVa4TuVX3VDhqwAa6cVMbIyyQn8mLJoecEx3a2jGWdOibj3A7aQt9g051aAdibCnTNa28r1c=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Tue, 9 Nov
 2021 22:43:38 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::79) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 22:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 22:43:37 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 16:43:34 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP version checking
Date: Tue, 9 Nov 2021 17:42:51 -0500
Message-ID: <20211109224251.3484398-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109224251.3484398-1-Graham.Sider@amd.com>
References: <20211109224251.3484398-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c50bcd-4bb8-4d4d-c364-08d9a3d25ecc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011D99E801D7AF9B509AD9D8A929@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRYaSZ1GCeOwtJEISuldurF8IFOtHCcIf8q4Jj2D0OPlLMtcckZREeZ0sTserdZjQosL2UULt2zgB5A1RcvaG1BFGAx80wdgzcDdhbVVif5qr0txJwrJydAWGRTKNqONdarun1SgmiQEsrzpTiZ7EjbJ8Om4k5PoTJrREGSxsmAJZu4Sp+d+vwq4ijlhljisFkKKDgopnQFmPhduVBRuc54kS0t8XAzUZbJUkRJqv5RiWBLvR/Qk91bUe8nL3QN7/wvIL8CBDbNR44qy462Er34fk+glSt2JS4a0MX41eVw/gwEkTB72XF4lPLD9JYckmPmc9KAotnOlutoLAmiRXSU9etLAg2t6QJ1GxItJbmFlwlXDNVs/P7hjSPab+Rj2Sgxk6LHs3rBCriCh+qAGP3tkyytc/TB/ep389rB7oxpXXE/aw9SejmyY2m2nL25irg/3dawIoNNSU8v7kxKgcYHW0f4Q5nYpaugPyca5uRPDvjPh1xXTj0Cqx4SnLJDc1cBAFe01ZVlmRjyzg3ippUpAS4E0Xyy7dsTcipFWUcvxtflXROwKoapl60G9fBB0Skx4BiAImYG2VowJgDTZy7LqqL2jzYz2t/e+IZX9Cd8mj6dJpKamdwR9N/NE6glCTCbp+jkajBkLYN+COWmbcxzrDLv5fkt3NnDD0gRyGVaZG/vzw3++dreSf8t1UjjMUnkX6KVHDrIeZ+CMnoh+2nabJZ97mQk5MUSyO3mTqAA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(356005)(36860700001)(81166007)(316002)(1076003)(8676002)(47076005)(36756003)(82310400003)(6666004)(83380400001)(30864003)(16526019)(6916009)(2616005)(426003)(54906003)(336012)(2906002)(8936002)(7696005)(508600001)(4326008)(5660300002)(26005)(186003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 22:43:37.6884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c50bcd-4bb8-4d4d-c364-08d9a3d25ecc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to IP version checking instead of asic_type on various KFD
version checks.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 27 ++++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
 10 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2466a73b8c7d..f70117b00b14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 19dd472e9b06..b6d887edac85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->num_hops_xgmi = 1;
-		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
+		if (KFD_GC_VERSION(kdev) == IP_VERSION(9, 4, 2)) {
 			sub_type_hdr->minimum_bandwidth_mbs =
 					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
 							kdev->adev, NULL, true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ee813bd57c92..594dd28a391f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -848,23 +848,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
 	if (cwsr_enable && kfd->device_info->supports_cwsr) {
-		if (kfd->device_info->asic_family < CHIP_VEGA10) {
+		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
-		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
-		} else if (kfd->device_info->asic_family == CHIP_ALDEBARAN) {
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
-		} else if (kfd->device_info->asic_family < CHIP_NAVI10) {
+		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
-		} else if (kfd->device_info->asic_family < CHIP_SIENNA_CICHLID) {
+		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
@@ -886,14 +886,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		return 0;
 
 	if (hws_gws_support
-		|| (kfd->device_info->asic_family == CHIP_VEGA10
+		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 0, 1)
 			&& kfd->mec2_fw_version >= 0x81b3)
-		|| (kfd->device_info->asic_family >= CHIP_VEGA12
-			&& kfd->device_info->asic_family <= CHIP_RAVEN
+		|| ((KFD_GC_VERSION(kfd) == IP_VERSION(9, 2, 1)
+			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 0)
+			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 1, 0)
+			|| KFD_GC_VERSION(kfd) == IP_VERSION(9, 2, 2))
 			&& kfd->mec2_fw_version >= 0x1b3)
-		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
+		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
 			&& kfd->mec2_fw_version >= 0x30)
-		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
+		|| (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
 			&& kfd->mec2_fw_version >= 0x28))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
@@ -962,10 +964,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * calculate max size of runlist packet.
 	 * There can be only 2 packets at once
 	 */
-	map_process_packet_size =
-			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
+	map_process_packet_size = KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2) ?
 				sizeof(struct pm4_mes_map_process_aldebaran) :
-					sizeof(struct pm4_mes_map_process);
+				sizeof(struct pm4_mes_map_process);
 	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
 		max_num_of_queues_per_device * sizeof(struct pm4_mes_map_queues)
 		+ sizeof(struct pm4_mes_runlist)) * 2;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 93d41e0b9b41..c894cbe58a36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -250,8 +250,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 
 	program_sh_mem_settings(dqm, qpd);
 
-	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
-	    dqm->dev->cwsr_enabled)
+	if (KFD_IS_SOC15(dqm->dev) && dqm->dev->cwsr_enabled)
 		program_trap_handler_settings(dqm, qpd);
 
 	/* qpd->page_table_base is set earlier when register_process()
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index b5c3d13643f1..f20434d9980e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
-		if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN) {
+		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2)) {
 			/* Aldebaran can safely support different XNACK modes
 			 * per process
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3eea4edee355..afe72dd11325 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
 	/* Workaround on Raven to not kill the process when memory is freed
 	 * before IOMMU is able to finish processing all the excessive PPRs
 	 */
-	if (dev->device_info->asic_family != CHIP_RAVEN &&
-	    dev->device_info->asic_family != CHIP_RENOIR) {
+
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
 		mutex_lock(&p->event_mutex);
 
 		/* Lookup events by type and signal them */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index aeade32ec298..d59b73f69260 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	void *r;
 
 	/* Page migration works on Vega10 or newer */
-	if (kfddev->device_info->asic_family < CHIP_VEGA10)
+	if (!KFD_IS_SOC15(kfddev))
 		return -EINVAL;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fafc7b187fad..74c9323f32fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1317,14 +1317,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * support the SVM APIs and don't need to be considered
 		 * for the XNACK mode selection.
 		 */
-		if (dev->device_info->asic_family < CHIP_VEGA10)
+		if (!KFD_IS_SOC15(dev))
 			continue;
 		/* Aldebaran can always support XNACK because it can support
 		 * per-process XNACK mode selection. But let the dev->noretry
 		 * setting still influence the default XNACK mode.
 		 */
-		if (supported &&
-		    dev->device_info->asic_family == CHIP_ALDEBARAN)
+		if (supported && KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
 			continue;
 
 		/* GFXv10 and later GPUs do not support shader preemption
@@ -1332,7 +1331,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * management and memory-manager-related preemptions or
 		 * even deadlocks.
 		 */
-		if (dev->device_info->asic_family >= CHIP_NAVI10)
+		if (KFD_GC_VERSION(dev) > IP_VERSION(10, 1, 1))
 			return false;
 
 		if (dev->noretry)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 77239b06b236..88360f23eb61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (KFD_GC_VERSION(adev->kfd.dev)) {
+	case IP_VERSION(9, 4, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_adev == adev) {
 				mapping_flags |= coherent ?
@@ -1068,7 +1068,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_adev == adev) {
 				mapping_flags |= coherent ?
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a4c0c929444a..641e250dc95f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 		 */
 		if (inbound_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
 		    (inbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
-		    to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
+		    KFD_GC_VERSION(to_dev->gpu) == IP_VERSION(9, 4, 0))) {
 			outbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
 			inbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
 		}
@@ -1463,7 +1463,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
 		HSA_CAP_MEM_EDCSUPPORTED : 0;
 
-	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
+	if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 0, 1))
 		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-- 
2.25.1

