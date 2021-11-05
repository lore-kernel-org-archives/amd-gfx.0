Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB20C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCCC6113B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FCCC6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379AA6E4E6;
	Fri,  5 Nov 2021 19:58:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E976E456
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 19:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKgSx4o4EuQ+qA83ZhOvfqXOjlV6NYSb2x0F71DqeDHz3+jUgvg7Bs4RNV8vcPyGv88ytndQU6ciWHEYsGNiXoUnxUHcKFlJSbuUHb18nQO2jipXBkfqLx0eiQsWsw9vIEhO0O016OGv7+6H+Kq6Cjh6j3enr/ewI+uKNSjW7Nu5dZ/glmdcuImqFTmmJ9PdAhNwfBv+b6pOnnrDw+2HMEDGF5JHVKff7J8BdsZPRHzMwFj9CkniJ4zjOGfDIebwcP00UTCwXUOzxCkVrHGYUmBGmp247SZ0sKri/gAPSy6emDBPh6oFa8U8pSBR21JiEWniI4g2YaO9NxdhTJo8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDGuRcCwXaSYneyhRRMJNfHEPJ/PZx6nPKO5KsLnoyw=;
 b=oQphW4Sh2qeSieD9subGdk0/q1VN2RUoADzqCOLYqtY6bva2nGZE42A6UTSVPWhmYoxxPFPjWXQaF481Yi8vqcwV+fY3wRT1j/lCRXiP12D6WvZSyOnLZIvFPWtguvNojjdr3qONKwsCzOZ0ZHv/DhdG6h9amSN3iA9182fEj/SKF8exljnif3mY+SclrauirnnPpe3HbfxuqSJazzqTjuevJKmHJAHf88KHhycj7qEdk/CLgxsr63yZjgWz9QR/l2rhlG1ytzww7VzloZfFynmxqz8oZbxUBP3tItOxtdexsfx/Mg+tPBjagBoA4hYirbcDqN3eRYCbWHOTufkgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDGuRcCwXaSYneyhRRMJNfHEPJ/PZx6nPKO5KsLnoyw=;
 b=SrgseI7GMkHjR63++Xvx3XbQgpwAdn7sdWsj2g9W44Q3cx7Unxz+6UCZa0TGsA+FhXj6zcSzwljykWy6MnkQl0FPhXcsrUOoPgSkNKU8qIM0acL616H+uiNxcJsRGqlXyaBOblBZLtYVmC1KjqbGuCPj+Z3Ab2VInVcpE5DTXCs=
Received: from DM5PR06CA0085.namprd06.prod.outlook.com (2603:10b6:3:4::23) by
 DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Fri, 5 Nov 2021 19:58:48 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::7e) by DM5PR06CA0085.outlook.office365.com
 (2603:10b6:3:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 19:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 19:58:48 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 14:58:47 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: convert misc checks to IP version checking
Date: Fri, 5 Nov 2021 15:58:05 -0400
Message-ID: <20211105195805.2275921-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105195805.2275921-1-Graham.Sider@amd.com>
References: <20211105195805.2275921-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e64b33-3f7b-4517-0c74-08d9a096aec8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5230AAA3D4EA9477F41CB2658A8E9@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqNyqKXpGjkcDbQsO9BDyWizNpJ28uX5lUuam2YcncyUNbQDPJ0DHYRw5xRd2hN1Vj9OXX7tVWxMF7ku6xYmuoXzQl0PNcTqKxIz3Q7IV7w3vgm4DIjcYMlot6OYGQWO9vwFLnXKy6uMSo1v6kP8obiYFLEaVmuFQ48JhA6yjjtDce/32XlHouBG7Hz0B/cCvVw0mS/1OqgjXgoCOD/PzcbBA5PFEHipW92jRQe4Z7KvTlvX6bnyd6uQLREvkpY6ypPrI+K0k4TWW5azqyKOuVzUY8wPFzzHncSNRpU05QMY+L+H1wz39M/tLbfh9KkRuWgLYDbdeOzUSQQUm+fxeh/iHwzA2JgAx/2dEmE8r5BjXbd8hfPWy9eanI6DERp98X52OhgWYUD1DYZgSB857Y2UhEBefRI0QLzxke8Bc3+TR4VqTlC/IHloTqqSz7p5cegqoSC6yGg3tW2Jtlw5iZ6TQMDfVoic4JJyqGnwQrYyIql2W7gNlg8+MP5q7dc72pNkBArnzoFz+Dr62IYG3fhEVBBnWGoryR1MkByy8V3V7z698ewWmTp7ZlO90dhHBmhuw39ZpcJmmvxds37YBT+Cq8I44Hhjq/7TqsNc7OkI2HWSwhA5nswPI0j2bOpiE7IDT9U9k416OEIUBRMOmVXrl9qeZGj3rQO0ax1oGfdbNV+/U5JR5SNySb0q3icJcfvyZkl0Ilzw/ndPtmJJeRdMiO41RfATu7FP7232tPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(336012)(54906003)(2616005)(8936002)(26005)(16526019)(7696005)(4326008)(36756003)(186003)(508600001)(36860700001)(81166007)(356005)(8676002)(47076005)(83380400001)(30864003)(70586007)(82310400003)(2906002)(316002)(70206006)(6916009)(86362001)(426003)(6666004)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 19:58:48.6660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e64b33-3f7b-4517-0c74-08d9a096aec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 ++++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  8 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 ++--
 11 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2e3d74f7fbfb..f66c78fda5be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -321,7 +321,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	/* Return gpu_id as doorbell offset for mmap usage */
 	args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
 	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
-	if (KFD_IS_SOC15(dev->device_info->asic_family))
+	if (KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]))
 		/* On SOC15 ASICs, include the doorbell offset within the
 		 * process doorbell frame, which is 2 pages.
 		 */
@@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
+	if (dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 500bc7e40309..b41e62a324f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->num_hops_xgmi = 1;
-		if (kdev->adev->asic_type == CHIP_ALDEBARAN) {
+		if (kdev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
 			sub_type_hdr->minimum_bandwidth_mbs =
 					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
 							kdev->adev, NULL, true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b752dc36a2cd..29f8fcd4b779 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -844,23 +844,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
 	if (cwsr_enable && kfd->device_info->supports_cwsr) {
-		if (kfd->device_info->asic_family < CHIP_VEGA10) {
+		if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
-		} else if (kfd->device_info->asic_family == CHIP_ARCTURUS) {
+		} else if (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
-		} else if (kfd->device_info->asic_family == CHIP_ALDEBARAN) {
+		} else if (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
-		} else if (kfd->device_info->asic_family < CHIP_NAVI10) {
+		} else if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
-		} else if (kfd->device_info->asic_family < CHIP_SIENNA_CICHLID) {
+		} else if (kfd->adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
@@ -882,14 +882,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		return 0;
 
 	if (hws_gws_support
-		|| (kfd->device_info->asic_family == CHIP_VEGA10
+		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 1)
 			&& kfd->mec2_fw_version >= 0x81b3)
-		|| (kfd->device_info->asic_family >= CHIP_VEGA12
-			&& kfd->device_info->asic_family <= CHIP_RAVEN
+		|| ((kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 2, 1)
+			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)
+			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 1, 0)
+			|| kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 2, 2))
 			&& kfd->mec2_fw_version >= 0x1b3)
-		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
+		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)
 			&& kfd->mec2_fw_version >= 0x30)
-		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
+		|| (kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)
 			&& kfd->mec2_fw_version >= 0x28))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
@@ -959,7 +961,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * There can be only 2 packets at once
 	 */
 	map_process_packet_size =
-			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
+			kfd->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ?
 				sizeof(struct pm4_mes_map_process_aldebaran) :
 					sizeof(struct pm4_mes_map_process);
 	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 8a39494fa093..7cadcdd9ffd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -157,7 +157,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family)) {
+	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0])) {
 		/* On pre-SOC15 chips we need to use the queue ID to
 		 * preserve the user mode ABI.
 		 */
@@ -202,7 +202,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	unsigned int old;
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family) ||
+	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]) ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		return;
@@ -250,7 +250,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 
 	program_sh_mem_settings(dqm, qpd);
 
-	if (dqm->dev->device_info->asic_family >= CHIP_VEGA10 &&
+	if (dqm->dev->adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 1) &&
 	    dqm->dev->cwsr_enabled)
 		program_trap_handler_settings(dqm, qpd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index b5c3d13643f1..0f7471796667 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
-		if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN) {
+		if (dqm->dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
 			/* Aldebaran can safely support different XNACK modes
 			 * per process
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3eea4edee355..20745086308e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
 	/* Workaround on Raven to not kill the process when memory is freed
 	 * before IOMMU is able to finish processing all the excessive PPRs
 	 */
-	if (dev->device_info->asic_family != CHIP_RAVEN &&
-	    dev->device_info->asic_family != CHIP_RENOIR) {
+
+	if (dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 1, 0) &&
+	    dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 2, 2) &&
+	    dev->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 3, 0)) {
 		mutex_lock(&p->event_mutex);
 
 		/* Lookup events by type and signal them */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index aeade32ec298..c376c43a6c16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	void *r;
 
 	/* Page migration works on Vega10 or newer */
-	if (kfddev->device_info->asic_family < CHIP_VEGA10)
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2a5b4d86bf40..013678fabc0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -183,7 +183,7 @@ enum cache_policy {
 	cache_policy_noncoherent
 };
 
-#define KFD_IS_SOC15(chip) ((chip) >= CHIP_VEGA10)
+#define KFD_IS_SOC15(gcipv) ((gcipv) >= (IP_VERSION(9, 0, 1)))
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f29b3932e3dc..f260f30b996c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1317,14 +1317,14 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * support the SVM APIs and don't need to be considered
 		 * for the XNACK mode selection.
 		 */
-		if (dev->device_info->asic_family < CHIP_VEGA10)
+		if (dev->adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
 			continue;
 		/* Aldebaran can always support XNACK because it can support
 		 * per-process XNACK mode selection. But let the dev->noretry
 		 * setting still influence the default XNACK mode.
 		 */
 		if (supported &&
-		    dev->device_info->asic_family == CHIP_ALDEBARAN)
+		    dev->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
 			continue;
 
 		/* GFXv10 and later GPUs do not support shader preemption
@@ -1332,7 +1332,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * management and memory-manager-related preemptions or
 		 * even deadlocks.
 		 */
-		if (dev->device_info->asic_family >= CHIP_NAVI10)
+		if (dev->adev->ip_versions[GC_HWIP][0] > IP_VERSION(10, 1, 1))
 			return false;
 
 		if (dev->noretry)
@@ -1431,7 +1431,7 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	int range_start = dev->shared_resources.non_cp_doorbells_start;
 	int range_end = dev->shared_resources.non_cp_doorbells_end;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family))
+	if (!KFD_IS_SOC15(dev->adev->ip_versions[GC_HWIP][0]))
 		return 0;
 
 	qpd->doorbell_bitmap =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 065fa2a74c78..3be0ccb7a880 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[GC_HWIP][0]) {
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
index 5353f43c67f3..27c4d2599990 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 		 */
 		if (inbound_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
 		    (inbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
-		    to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {
+		    to_dev->gpu->adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0))) {
 			outbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
 			inbound_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
 		}
@@ -1487,7 +1487,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
 		HSA_CAP_MEM_EDCSUPPORTED : 0;
 
-	if (dev->gpu->adev->asic_type != CHIP_VEGA10)
+	if (dev->gpu->adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 0, 1))
 		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-- 
2.25.1

