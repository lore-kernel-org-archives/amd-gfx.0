Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F1B61208
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50F1B61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB186E503;
	Wed, 10 Nov 2021 23:09:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD7A6E503
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL8eU8gWqJUGi4dEyXGEJSHFs8XXfm507urS+XRfaQ1bEyj3yhjjOYspmHzPrQn2sLUzSsiNC0qnyNwg/Ism7fYF8gmWkOh0lpOmQx4GRxHaN7v1xlZI96HT8FOXsy4WucT6sDOU45OJXbRDnJ05n+chjG9O03c6knNPxQ4KMpIV74NUNX/jLhP6LvdOTOyNAYdYroarCFMH+8a5UO5eDlX0DbRB9xjlGJtRTIKEGHSxvTNDdlsWFdDmTzzH3BOfyenYnvYWFP1S40Rgus3DWpr5AXUDYwLfDrmhuPx6ppj0gHiLZz1QUOS+a1kzSFlONlUMjWh9ZtWz9YBeCzGWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jrl47NDwnze2kWX55tb8bdiwZLAI7fmmbpKNojY3zo=;
 b=YJFRLFWKeOQJOtOiTs6D6y6IdBIVfFnlyQ7uEJpy6uNhPNRTJVZ8y1c2vKxumpYHK3mc3W1jE5hkkf7Gw6zyLDLy7ln9wKLqcBR29UJDmgEimtS7+pVRiUWYqjVwoqTiNbl7iWwZ0aZXeI9zpjNYXiitaEvyHMZ8PmgTwtrJDI1D4QYK9RuGe5I455YaRbiRvrSE57zoNuLvq2dXJwpEmXoGSjD53ct+QLw0j+phgBuw0WrmtZ2WyLK9QUjtVQPPVllJLQ6MEBHtca1hO9dl+szA5eoNgz86FVmC25sN5h+he9AMrcbURQRA8s1l/uDdejyQQUr/rQX8Dc1/EDFhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jrl47NDwnze2kWX55tb8bdiwZLAI7fmmbpKNojY3zo=;
 b=vK0TQLfRn+cWYtj8NningakxWbrtTEIc1zirxl1FKDNh8ADeCZFMiAy0DoYaxTUBnbW510IHN5V1W7ymCLV4NHUdivFnuMmo8hkA0p3MGr5ORtZZXOaZUBotFAYAIcLxU+fLeBDx9e0IvCBDpv40AGiT7ELFcYnQhKHmV3P2EEg=
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 BYAPR12MB4774.namprd12.prod.outlook.com (2603:10b6:a03:10b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Wed, 10 Nov
 2021 23:09:21 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 23:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 23:09:21 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 17:09:19 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdkfd: convert misc checks to IP version checking
Date: Wed, 10 Nov 2021 18:07:04 -0500
Message-ID: <20211110230704.3792868-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18efee03-414b-424d-c828-08d9a49f2129
X-MS-TrafficTypeDiagnostic: BYAPR12MB4774:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47745839386483BC2F39926C8A939@BYAPR12MB4774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3CT6CdOjuBJ1HnTMtZvheEtxxjqVDcg+w/gULmfuFqcrK2zeIoOSvsm5G4G5ivMqvGuXoJryLkfJnA/oIUJQzBAMFu1BwjLVBQbiJkhtj4kYnNvoeGgUQ+dXy7XPmvxCyG8PuKs8Bp72+FXS4KTzHc7yZOeeAnw0XF7SPSFS5vYIAYhsgN56DWpzJoitRpyzgLZ5f4rmIyX9eWMW/hXxR9iRSwiO3RbZkT4zaxtzXSNoDXAdlSImME/j50WJ3d2ZyWT9NXzDTJnH564FzlVbe1VuIMaZ0p+f6qV6dyp+ppctz0H4cyhrTWHgMaibMUf9Zy+FPYrM9KfNVQqhhsyLJhXtT1dEJfOfJ8E928MDfDcThgdCkihBhIKqho9wkVN9EOF5HMNFedC8oypKt95WrPVFjddTPmoHeeC1vsYQkPfzfUNp4g7650yaWTeVN2eXjVaUuv+PtzpNXlQ4thLg9r4WVI0VgL9Q99t0CmI8GFBrUrMhsrhUZJ+zI0miRbVUrAvACGrMDaNBQ1PhpJZ+xhJNHS5YXJTznaiP0ZxZ7qXsxmsw5gD1oAh/N6+Boys9VJ7STSkSOcsuZfQwuw479houWi2UuFtSboz1k08DZPiw0VLRJhky04t1OUH1FY17U6G8dC2yCikgsBo74HpfO4ZqVRChlDsXEkhZ1UcB6GBCc2AIakqdOYeD0MTZDWgceP559hxtVpzlcb7MenMaiHgmEbgy9pjKsgBEKWkDRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(54906003)(186003)(70206006)(336012)(426003)(6666004)(2616005)(16526019)(36756003)(36860700001)(7696005)(508600001)(83380400001)(356005)(316002)(8936002)(2906002)(1076003)(47076005)(8676002)(81166007)(6916009)(82310400003)(86362001)(30864003)(4326008)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 23:09:21.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18efee03-414b-424d-c828-08d9a49f2129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4774
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to IP version checking instead of asic_type on various KFD
version checks.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 34 +++++++++----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
 10 files changed, 33 insertions(+), 35 deletions(-)

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
index ee813bd57c92..feebd652a7a1 100644
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
@@ -885,16 +885,15 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 	if (kfd->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		return 0;
 
-	if (hws_gws_support
-		|| (kfd->device_info->asic_family == CHIP_VEGA10
-			&& kfd->mec2_fw_version >= 0x81b3)
-		|| (kfd->device_info->asic_family >= CHIP_VEGA12
-			&& kfd->device_info->asic_family <= CHIP_RAVEN
-			&& kfd->mec2_fw_version >= 0x1b3)
-		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
-			&& kfd->mec2_fw_version >= 0x30)
-		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
-			&& kfd->mec2_fw_version >= 0x28))
+	if (hws_gws_support || (KFD_IS_SOC15(kfd) &&
+		((KFD_GC_VERSION(kfd) == IP_VERSION(9, 0, 1)
+			&& kfd->mec2_fw_version >= 0x81b3) ||
+		(KFD_GC_VERSION(kfd) <= IP_VERSION(9, 4, 0)
+			&& kfd->mec2_fw_version >= 0x1b3)  ||
+		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
+			&& kfd->mec2_fw_version >= 0x30)   ||
+		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
+			&& kfd->mec2_fw_version >= 0x28))))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
 
@@ -962,10 +961,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
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
index fafc7b187fad..d4c8a6948a9f 100644
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
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
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

