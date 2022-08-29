Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAF0ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDD810F32D;
	Mon, 29 Aug 2022 14:31:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D679910F30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZFnLLN99fZapSAXFgxeqDo/GBJt+DpNK5I0Ret+zOIvInLhsK1OsnaRN8vF5LOtJ1ZpwowXNNx1H6NOE5JrvUGjNunvbhlx/ckJ73A3rEf3LmeujYK/dmzb4T3amtPOvzyboRQm45YzqODXBT0E7NB1Eb8bNuo7rSFPpyT+3QKjZjYTs4GmRJBnfUTSaY5fv1ct/uX3C0BxOlR0rR+ZsxhTDI7++tRpt/8H+5FBsydJnTX/MFUnCXK7hNOzpKPq8poZhMJPe02VM6QpJnimsKHj0apehR6fKl1RNCdi2vc3d4N+ttIqOlhi1TdCaPAt4L3T1GzlmHJjORYDEhK2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+ZpmRNacIpw19s6pBb6amAvLMZ3m0UqvKMoVg9uvBE=;
 b=AWjxMnidF+bfTTfP2u679UMTrfI4f9hDsSEnL6Ol8sDpJmZEcS875owIUkEuPw55aYYDdoOsl8yEf6BUSQdTQddN2XhnYaihwB2CYnciqpVjAfmbHs/SwSnBwvGtX/WjUoOeqN5xYPFfjxKlpR0O+C+QE+psZIHqcS44iSHbWEPjvDv9H35kxnHwbNSFfQPMKydZx8KN1Zl4dbH+UU29gf0+vLM+fVv8PY9QEIoYZAkrefm9mbkZ8ZPTSDDhC32BXs9fjHwRqoyl61J7VHD9BMX1Im9I/sSo+okVms+EkDpk9MUJz114aWAUrbuYImmQEnl1vAQKm7QDuVigcoqWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+ZpmRNacIpw19s6pBb6amAvLMZ3m0UqvKMoVg9uvBE=;
 b=00cx4CSsxfB/Z5SfBrfp7TMj/6YIc1YV+wBrPMgjXAcPW6wt66HlHI6JeQ6vSJs9aS7Orcb6OZZBwQkhCErb9Uy9HnFT0OyPzYaBi8tXgLzQxLb7jGfJ7O2vItBSH7crROhc5wXwHbD6A8Rt1rxAe8d7I7AiVs4T0VTDOKnhIAg=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:30:45 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::be) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:44 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:41 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/29] drm/amdkfd: display debug capabilities
Date: Mon, 29 Aug 2022 10:29:59 -0400
Message-ID: <20220829143026.1509027-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d91ecd-ca11-40da-3a1c-08da89cb0f23
X-MS-TrafficTypeDiagnostic: BL3PR12MB6522:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3B2O142KPsyfWKnDRgGflDASud6ksMpfh/EC66ojD5CrrrRdISiCF+21/cv+XGFRJl0WXCwYh8VuhuJcP9b+5/9ZyQRKz6VINv+v11aAsGeivXdnrGadmWQtW7Ec7W4d0loSa/0gYLdsCJIBoU7yv9RQ1Vsx3lft3ZKAfJcYqDJepfjn2U6hhQLzkCOc5spQ9YpZIJdWVNFysE0WG6m0V5FVuoHQy+M/NYUqfylMlcIxGgvls3QOGayFQCCM9xOcPrwzWL4GAzCsWga2LCLsnXIAyfq527C/MBimHoFyzmW9bM+UyHpK1T4SuWIJ3q2dv/o0GVCw2dmyyulCAjGG0qsUopwQEfJxoX5+z2Ue6gH0c4WAU3ua1nCUsnfePhMJxonNCmQZFDXmx/Ce0XXcOPhGPAldjxFb1R5AN0v0DS2OjimD044mo7dxFnbYKz7noG5mTjOnbTUbyJyU0Mby/NFb0RTRNN+EiAQnnZ3pr3hCkdV7pKoy9RkUuC4ztvLKunBTqL0AW4WWsOP2M7CBEXK0YjXKLToeAMURZ9mJwc4n4dUbi0EPABL4O97nqw0fBBJKXZKCET7os0+IbLQMTZvDpRen9iUyjkzjpVtZFwmCD2c2tQjzrFoYochI8n2L/Z3wv85FqHoCK1uUUf6vbFfd195ZMqy5SRQW7132jHi6HLEsgPsU6MzlsNYFhZyhatbpv1u/x4l2h+JodrpG33qufzOFuxF1wwZqEQ6sZceHUEGhswO0h3BG+e2Nzk6NfKZaU8pa/tFp1hsqoGN/UHmB8ctIpD8mSEF+mRTNJKzeW+zbHM5ulur2M7Gxyc2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(83380400001)(81166007)(426003)(86362001)(47076005)(36860700001)(40460700003)(1076003)(186003)(16526019)(356005)(336012)(2616005)(36756003)(44832011)(82740400003)(5660300002)(6666004)(4326008)(8676002)(70206006)(70586007)(2906002)(82310400005)(40480700001)(41300700001)(478600001)(8936002)(7696005)(54906003)(26005)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:44.9961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d91ecd-ca11-40da-3a1c-08da89cb0f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose debug capabilities in the KFD topology node's HSA capabilities and
debug properties flags.

Ensure correct capabilities are exposed based on firmware support.

Flag definitions can be referenced in uapi/linux/kfd_sysfs.h.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 88 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  6 ++
 include/uapi/linux/kfd_sysfs.h            | 15 ++++
 3 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f0a4a415907..cd5933a594de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -551,6 +551,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->gpu->mec_fw_version);
 		sysfs_show_32bit_prop(buffer, offs, "capability",
 				      dev->node_props.capability);
+		sysfs_show_64bit_prop(buffer, offs, "debug_prop",
+				      dev->node_props.debug_prop);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
@@ -1593,6 +1595,84 @@ static int kfd_dev_create_p2p_links(void)
 	return ret;
 }
 
+static void kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *dev)
+{
+	bool firmware_supported = true;
+
+	/*
+	 * Note: Any unlisted devices here are assumed to support exception handling.
+	 * Add additional checks here as needed.
+	 */
+	switch (KFD_GC_VERSION(dev->gpu)) {
+	case IP_VERSION(9, 0, 1): /* Vega10 */
+		firmware_supported = dev->gpu->mec_fw_version >= 459 + 32768;
+		break;
+	case IP_VERSION(9, 1, 0): /* Raven */
+	case IP_VERSION(9, 2, 1): /* Vega12 */
+	case IP_VERSION(9, 2, 2): /* Raven */
+	case IP_VERSION(9, 3, 0): /* Renoir */
+	case IP_VERSION(9, 4, 0): /* Vega20 */
+		firmware_supported = dev->gpu->mec_fw_version >= 459;
+		break;
+	case IP_VERSION(9, 4, 1): /* Arcturus */
+		firmware_supported = dev->gpu->mec_fw_version >= 60;
+		break;
+	case IP_VERSION(9, 4, 2): /* Aldebaran */
+		firmware_supported = dev->gpu->mec_fw_version >= 51;
+		break;
+	case IP_VERSION(10, 1, 10): /* Navi10 */
+	case IP_VERSION(10, 1, 2): /* Navi12 */
+	case IP_VERSION(10, 1, 1): /* Navi14 */
+		firmware_supported = dev->gpu->mec_fw_version >= 144;
+		break;
+	case IP_VERSION(10, 3, 0): /* Sieanna Cichlid */
+	case IP_VERSION(10, 3, 2): /* Navy Flounder */
+	case IP_VERSION(10, 3, 1): /* Van Gogh */
+	case IP_VERSION(10, 3, 4): /* Dimgrey Cavefish */
+	case IP_VERSION(10, 3, 5): /* Beige Goby */
+		firmware_supported = dev->gpu->mec_fw_version >= 89;
+		break;
+	case IP_VERSION(10, 1, 3): /* Cyan Skillfish */
+	case IP_VERSION(10, 3, 3): /* Yellow Carp*/
+		firmware_supported = false;
+		break;
+	default:
+		break;
+	}
+
+	if (firmware_supported)
+		dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED;
+}
+
+static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
+{
+	dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
+
+	dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_SUPPORT |
+			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED |
+			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
+
+	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
+		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
+						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+
+		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
+			dev->node_props.debug_prop |=
+				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
+		else
+			dev->node_props.capability |=
+				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+	} else {
+		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
+					HSA_DBG_WATCH_ADDR_MASK_HI_BIT |
+					HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
+	}
+
+	kfd_topology_set_dbg_firmware_support(dev);
+}
+
 int kfd_topology_add_device(struct kfd_dev *gpu)
 {
 	uint32_t gpu_id;
@@ -1737,13 +1817,11 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
 		break;
 	default:
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 0, 1))
-			dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
-				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
-				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-		else
+		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 0, 1))
 			WARN(1, "Unexpected ASIC family %u",
 			     dev->gpu->adev->asic_type);
+		else
+			kfd_topology_set_capabilities(dev);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 9f6c949186c1..c089c26a0e77 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -31,6 +31,11 @@
 
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
+			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
+
 struct kfd_node_properties {
 	uint64_t hive_id;
 	uint32_t cpu_cores_count;
@@ -42,6 +47,7 @@ struct kfd_node_properties {
 	uint32_t cpu_core_id_base;
 	uint32_t simd_id_base;
 	uint32_t capability;
+	uint64_t debug_prop;
 	uint32_t max_waves_per_simd;
 	uint32_t lds_size_in_kb;
 	uint32_t gds_size_in_kb;
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index 3e330f368917..a51b7331e0b4 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -43,6 +43,11 @@
 #define HSA_CAP_DOORBELL_TYPE_2_0		0x2
 #define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
 
+#define HSA_CAP_TRAP_DEBUG_SUPPORT              0x00008000
+#define HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED  0x00010000
+#define HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED           0x00020000
+#define HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED  0x00040000
+
 /* Old buggy user mode depends on this being 0 */
 #define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000
 
@@ -53,8 +58,18 @@
 #define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
 #define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
 #define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
+#define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED   0x20000000
 #define HSA_CAP_RESERVED			0xe00f8000
 
+/* debug_prop bits in node properties */
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_SHIFT    0
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_MASK     0x000003f0
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT    4
+#define HSA_DBG_DISPATCH_INFO_ALWAYS_VALID      0x00000400
+#define HSA_DBG_WATCHPOINTS_EXCLUSIVE           0x00000800
+#define HSA_DBG_RESERVED                0xfffffffffffff000ull
+
 /* Heap types in memory properties */
 #define HSA_MEM_HEAP_TYPE_SYSTEM	0
 #define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
-- 
2.25.1

