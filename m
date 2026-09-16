Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45851C982C4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 14:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DDC10E3BD;
	Wed, 16 Sep 2026 14:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ClwEoX+c";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2D310E3BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMVPuQFolR3QbrPrH5tbuX6KkRmBfEP7HSDVvU/K+RdoQy8I4ld2c9gKAPV8dzCFysgW37xY5DSoP5eBVM2QPFLq6KoWMwEY8iHCxUlL9m8sFJXanfnHwZAIm06n55mSaiSt8EjRC4V9fY8b5m0EPga8LMiwrz7lHwT1ZApNmw87zpRh/tLYGQCZaTwUxP3r5hB13cnFMNA28X93vwZJ94nvvZUw1fSsMgqzVeD0ScqlqfsggZD3tscJp2l+FrMMOostT54RP+OjuSNjouMZPjFa3JyNvQfWEwifNTx0AsjQWC2n4ytFGLsT9vZNLVU5rzIww6ZQlmLGWKznHHbf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpAcvmkD1g0E9snJeJQuGRK/pNuU+RwiRYrTSRCQZpE=;
 b=Sq3rSUBU6rQXTxubVYQ6ePEC3oP2kfJPpd+K3861PQ+nQ/BK1Vrqy9kxlGkcA6DLZsg3mlWdLTD973OAhKZ0Ot1VJp18zoMRpAXcyAg8EsuVtmajgX17pVFp1sF92fBPj2HANaJ6/iG0oxKkG2RiBT1wBckJgEHypeE9zds6v0UwtItL4PAcYbyb1OHv043oKYSCpDE0STaLZef2kEm3SPRNqarw8YkqgJxS43nEqEiOkTcQ+aYyvvCQg8KVuNUszOod0643IfRtYwpZSCSBPf6dCxG1cjcVl6DRxq+55pgvtjQJC00xLRyMSM4tNQfDSaolemKwBgnoRgfGAotoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpAcvmkD1g0E9snJeJQuGRK/pNuU+RwiRYrTSRCQZpE=;
 b=ClwEoX+cxrZS6xslYvhg5QVXCnKpxhfHdAzwiwSWs8a3V7biZf+6b/nK2TwpQ0iUJ6hxfar/qR0A1/dQedIA7ehtz6mW7IA+eUMDN9KQ79iTuTf+Wb/ZWqGESHGzhfHmUHhj6VchNt2ZA5yvhR3HT8J1We5vz5EjVVaLGaxwFt4=
Received: from SJ0PR13CA0150.namprd13.prod.outlook.com (2603:10b6:a03:2c6::35)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:23:24 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c8) by SJ0PR13CA0150.outlook.office365.com
 (2603:10b6:a03:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 14:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 14:23:21 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 09:23:19 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yunru.Pan@amd.com>, Victor Lu
 <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Check for PCIe atomic ops support when reading
 pf2vf data
Date: Wed, 16 Sep 2026 10:23:07 -0400
Message-ID: <20260916142307.94158-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb41246-d367-4c06-bbe0-08df13fe0fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NQgqNw8HUCIjSyveCBQ80WA0X5ThGIQoczRezPOGAq2jYocR8Dyra4kPInv2wHPBdCYMjt6VorCjaOWOWmsZrKcINt13dyWOLANss5N90on4R320z/sZ7XsEb+VFmIWfQn/WC6sIIOp2QFZQCMLz4lHDSWopM9dM5VdquthM16jIddmXWR8ev0/twCXIx7quNAVQBDiWyGT28b8h7s9h8X76GpS8D7JKRrpG2CvFQicgPAQXlw8GReyHI41CZNtr+K8wKtXF0G0uDZIJ78zwBCB+eD20Zguvg1WYZIkfOyBqP/SCyYKbPDErUXHi8RhCryMT/IwJUpo6ZoN/1FN5Vjb3kNrVx/ng6QNWAIHthtI3lCzuWv/infSuLgcEYZ2lwMYQXjxhtJ9RBh1B0KpgU3NEbGiuYtdt49InXyZCcbN3qB5Oz8EP9esZV69nQjVNoWcJS51iNWqsOybqL46YMc9apytAMs8F9ONtr+XOPa96rWcU+a0RvYxvczmubfUW5a8BXUUpW9C4oDfGn0Q5ywqmwu8VN1i+6by8ctbczCZYp4q0lgVVXPkLCQzyRfCIjRxWrClkpUybq9XD7gYZjZYK1ioq9MXuK5kO9vwFPKh+2/c81R8nKzHmy3kSHTzXbOkeTOzv6XQ4+Y6YNHN/Vmoct0DNzI3WOg75If14zIxn59jJPQHu70La8/mWgHm7a50+bgY6hVk82ejLvb5w+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Wy2mvV0YOeVzb2pDo/i57VeaZiu8wrRHZZk5cX5qgLzT4oKzZ5CGQoi83UOF32p9v/gEK7CeZuneu9WiNKTnJZWRzyv7YBiQrCQ6lGCdVt3WrAiLuf7DSSe3HpM5Omvmr563w7R0CH6V8XRaz/b2XGN6ifCHNd4ru6titwEwLGzVV9JAV9kJ7k9w4fLbLuQ+/vtd2PkCVEpZGjqAOUMkJ9/rPQhI3Nl4Oo+VOe/U0MZs5Qd/9vbOw+m0SaAPklzyuDLwGECOfjoiDQWr5SCaVetmDF5+WBkq/eH4iQtHtsk2ecUu4zGlwZAjZuXg8XUed3cwaArq3xYu2AlmbO98r0EfkdYQuXbU34cSiFodT/ON+t537Ju2xaN9yExuGU2gOZNDJf4nN1e4AF0oMk3zo3pDm6Y2iIX0WY20ZTkNPTH8OyhwWNzewgkLv52CMOD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:23:21.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb41246-d367-4c06-bbe0-08df13fe0fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

The critical region v2 patches clear the fw_reserve.p_pf2vf variable after
pf2vf data is read the first time. have_atomics_support relies on that
variable to check for PCIe atomic ops support.

Move have_atomics_support check for SRIOV VFs to be when pf2vf data is
read.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  3 ++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9..42704dd8d790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4012,24 +4012,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	/* enable PCIE atomic ops */
-	if (amdgpu_sriov_vf(adev)) {
-		if (adev->virt.fw_reserve.p_pf2vf)
-			adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
-						      adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
-				(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
-	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
-	 * internal path natively support atomics, set have_atomics_support to true.
-	 */
-	} else if ((adev->flags & AMD_IS_APU &&
-		   amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0)) ||
-		   (adev->gmc.xgmi.connected_to_cpu &&
-		   amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0))) {
-		adev->have_atomics_support = true;
-	} else {
-		adev->have_atomics_support =
-			!pci_enable_atomic_ops_to_root(adev->pdev,
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
+		 * internal path natively support atomics, set have_atomics_support to true.
+		 */
+		if ((adev->flags & AMD_IS_APU &&
+			   amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0)) ||
+			   (adev->gmc.xgmi.connected_to_cpu &&
+			   amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0))) {
+			adev->have_atomics_support = true;
+		} else {
+			adev->have_atomics_support =
+				!pci_enable_atomic_ops_to_root(adev->pdev,
+						  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+						  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+		}
 	}
 
 	if (!adev->have_atomics_support)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 73169cb775f9..a454c6f12d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -652,6 +652,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->virt.ras_en_caps.all = pf2vf->pf2vf_ras_caps.ras_en_caps.all;
 		adev->virt.ras_telemetry_en_caps.all =
 			pf2vf->pf2vf_ras_caps.ras_telemetry_en_caps.all;
+
+		adev->have_atomics_support = pf2vf->pcie_atomic_ops_support_flags ==
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
-- 
2.34.1

