Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07D5ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B241810E2E1;
	Mon, 31 Oct 2022 16:24:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73BA10E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1LzS54rQx9kRyBQcMXDbp/M+9chIxErUknDmQFZiPhe8EUkOtFzdP/mjULvaCeTRgD9L0iLwyXR6a6NfNfbDJLxrz7dd9HF0Sg0rbF82ShAsVOpO+IO3biGbf1NICigDGtSxmVakN9aOBsEAseMqzIEPQVN8TEg3w5oqmDJV/TBs15APTxrIIPe1EVbt1NdwzAYQxZnKsgDlHcyGazCkgBT7RhtLPqtxntgdyD6/XX9n5koUZUHWPN3Jh3UwJk36JgcKLW0fLPdvbp1/PU5dJBAzPLvMPfJwIV5WFtmZ/K14GkZnyWAW5U+CigXyEhRup3AoZhWEqWO0Gmju/aBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+ZpmRNacIpw19s6pBb6amAvLMZ3m0UqvKMoVg9uvBE=;
 b=EPqIjF3we7relgq/2IDk04laLPFlEgXzzRgN0jHpB9MDGxfhv/rQfUqUJ9Qrb9MXPcxRurOE/vJkKJL9F3jj7ndBHidwe8lmCEr/XHzKPvYLoTksgirblCCntNAX3klyAq9iP0M0BKF79TLjNA8pmN2ktDC0LSvqn3i1XLVKOGaVKspnNUiStKPMs8yIO/Qmsks88/NyEYYCJPrQMzVDGUnwqVWOXhsUpbjj/BZq8c6nXmPYSALehPvo3mMbmn5mDCO4MBpXCSzgXt6NjhjMp88/WQM4naVCA9pdxB5j6n8z3yWHVQGrNqtqoCQFVd4+o96LJ4b98pBsCXa1pB5pPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+ZpmRNacIpw19s6pBb6amAvLMZ3m0UqvKMoVg9uvBE=;
 b=KBjlJ/6DOgVBWLESKxFcjEkcY9UaflcJx44Z/HmnVhR4NvkHEsrWyR3+sml4WG8KPsAl5p6B4FX+9wgNqRJ2jXcTvHUyxAAgoQ0+B5QrPX3ujm11Qhr1m7IMmvzaugyjPorO21jneFNC1HoJYKXR+Qb11g7Vnf/A34sZHf0NW20=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:24 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::9f) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:23 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:22 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/29] drm/amdkfd: display debug capabilities
Date: Mon, 31 Oct 2022 12:23:32 -0400
Message-ID: <20221031162359.445805-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b0eac5-d9be-48e9-a66c-08dabb5c5f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nnumw2IAjvKqi2KQoR9brzkvxBDJPMIoWDJ2OUqmwdfqpPGF+6gPshX5u/2BDrEUIO4b0LPplQX8GST3V+a44xrLD5gIqxb/LL2JNjks/Ao1+X2fvVStWMNRaa07ZdKzGTgcoN4iPALouO+Va7/etNXr4GoBx0tLbpJ+16kqhPdN930OAqSjXf1aLQYbswcvycrxZ9K+8r8ejMp4LLF+qTeIaD4EJ5Qc7vyrua7Kcrt3zABSadPTzOHSpC3YpL/Y3B4M+kk5AaF2FAQxQibzOqcE6zPkFEvTKt9VScXeyx27iHwQvIrnTwIFWJE+2+wJSFDx186JWTnm0duYK9admEvd6doiJarJlM43WavKU7P31xUekuY79/cOuiNFM0p6G2fGx6p0Z0wJpZE64/RggGBV4Mn/+bVlP89cK2hh0uhoP1wNrIQHlPxSTECkW3ADmohSBnxH2BLIkr7ii5+RBNLTHILyVzvm8sEdJFtRpr2bcqizLslNfPXV7wSKVvezQZCU7el7dnFfQPpfLAsOXNVrRsc7oT43PVfosAbuBOfbbpMZ9OxQn/wNbExv2wOqlGZsBEOMtiABNr6G12ndSHPgeOQKHTXGm7BxodZCBafpQMSyAQf+nvDfQ55m1M47EBV8Rndu8trIGukCIEjgNmSjVnxwNPLkyI/w8ILB+tqWiIMY2L/OaXNvKqlTDcSArmmEU0+SlZ3rHrFG+tElqX1Ij/rcJu+f/HATJKgvJIWMpZB4wIVoP6B08BAK0Vaa/1ihv58JdzG5nt7hcuhvEgBWWg0NWbhG61jEf5iticZ37vgXq6B6rB+zHjNCSfk4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(86362001)(82740400003)(81166007)(356005)(1076003)(336012)(83380400001)(40460700003)(40480700001)(2906002)(44832011)(7696005)(26005)(2616005)(6666004)(478600001)(36860700001)(47076005)(426003)(186003)(16526019)(82310400005)(70206006)(41300700001)(316002)(6916009)(70586007)(4326008)(8676002)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:23.9051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b0eac5-d9be-48e9-a66c-08dabb5c5f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
Cc: Felix.Kuehling@amd.com
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

