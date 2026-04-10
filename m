Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93B1F36BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 06:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8811B10E132;
	Fri, 10 Apr 2026 06:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHn+uYZc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FA110E132
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 06:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPitnTUsBbDgMUXRYDUIzx1VYf5U5K+r6DfCrmbZEjX6COmVZYMIBve9KD1hXYl0fIOuvkFyFvTXgr0PekKbyx9bmZD+J9Gyuzy7N1HHPC36ALE1Mqq0YWFiTGb0c9//DR3umfZCOjdqD6sIcqMOra20pAxf/F45Y6ZCgjHJ04XVaGzlma5Fh4a4bmwEfu55F0uf2mzuOvbi1R0yGdk61av5bZzqAvlgNW0CXeV2GTmG7SuieqhKYoW5brw9O9vyssSziL3vBLjlVhC41W/LxgFgcZHK9oi7PnH4lE6VYfD4L00a8aj54tJMWxouIHhN/M2/a5xB5QeNFhVzRr2Dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXWczgCWMfozbAs9KjrieH2NBJ8TDwMghdY2pbGZBtA=;
 b=xA1ycY3RU/QlCLWOf/PO3tMgsm/p9EUmvNw+vApq9QU6DvQJ+OoI9i7DYonLHZgO99xv3yaRyaITfUKQhagUvpDq4pX6zOflkye4oMG+WPQqbxlaL6SRUJuaZmr5pQC0VBNDHisPNxwP1r3vvrBmVykYKyM9pzBIh0q+ju66EEKgJYO9+rKiMkSxOlXpzP9zMxKVMasVOr12WFvLF+tKP8mNax9vm3m3BqMbkePRKJlBJWRoY15fb4iXJQcBiTSzM20vY3sHt25yxv3Sf3RF2+JUcaiwWyPxiYzPx/033+miKHs+ee13xwOiR2OjNUJcNU5Dt3iF1tjxwGAxpFhkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXWczgCWMfozbAs9KjrieH2NBJ8TDwMghdY2pbGZBtA=;
 b=LHn+uYZc8GT8r3lrlfHrFMGP4vjH5Wyj13l1OwE7sLQ1eAkTW9pTkYTaThlLuxiquzaR51TS8QD8LUtDSDw57VvrQPPdjvTiQCe8kaOTPaXyi1TS9Pd5pImmH1JbwdDHFgL8MVlCY2KO0QEF/cZ2KpkdNu+ZhDRVkxr4z0gOocU=
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 06:10:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::c2) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 06:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 06:10:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 01:10:45 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 23:12:49 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
Date: Fri, 10 Apr 2026 14:10:35 +0800
Message-ID: <20260410061035.2224955-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 96204a8e-3654-427a-ee0c-08de96c7e7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nlFoa8u8wpBLzhuLq0JYjrDrE9TsRQAvmTGSprRaB73n0+ByCcrcUIZYDku713A9ZTP9+M65aMOcDQVgn3XSVcL7CwCAt7vzI+zVt17P+jVcUJoHJmR7qH6s1brQsuScs0ym7SJadSQuiUuFDs57HHK3cEPiJlz5Vr0GmGBeJk+BVIcK5PS6H2WUjGT/XlTIGRyNAMZBjkoay1iCqmdXQsP2mwnBb1RJrMRL2Y4Odrv6rCJsKjsN5XuugDgKDBcsuaPcBw0gRpOMs1egCJgysm+vsGXvIf7zh3uVzuAAX6qbQIhmiMlSmRZT513RXUw9R62559X89iVcL24RHB2MFWrCkfjaelRxvACVQErkkVsKFk2MPiM4/RPEOdusKO92kFkiknDyzixUuPXkeuVIi5yqMaLLPIED2hpBNVkjKSkQb6W7hqq9gaNDyK2c3cS9aOuF94U/Ynlj6tzYDubElprzZ/5kN53OmV2Jon7q+S51vDykf2pR06V+MAWATw5lO6XOGTjb1H9aJsuEg5xwt2kWomnoFDiQW+gNn885FWzEg2R+mnQpQE7xUEczTFpw8v78C/aLpi7ZbzPFDhAQG04CDbd5dNXxpcfnD/XTPMMCZ8TAPrkoB3JniPLOWS6FtTt1CXmBJdADoabbp+XTc5O3/zGdE0mszN/eFwySlBXLH27jnuHccNMwVkLHqa0Jdpn3RBPbgZBHE4ZjTkYU6QRn4BiOUUjeVToCsrKPIcVdjYwrK+4SAD+bW/DqC7BTUORfDmTwV3z39lREL4TP+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q6oBtTPIKuCHv9EG+/rpKqR6I+TukZ9rKFOtE37e7J+yXIbjGs3Co3sQFQ8z0+lhxkep+Ab0+PP/0ralsHcBGMidsuD3oM+swpZNYBKQIhfSI7O4IsY9QpqR2h6Pu5me7aDQbmL17WZmRkJ421CGdiT475L7Xr4TXrR31kuBQ7Hya/CNKKi5q6Y5HaI8+6JKYFPchyB20mVFU2wxItGHHYPQou4vk9tHEtXXpa+nXH5BIHEfz/InRj+s3CFmLJY+unvoXimGGb2cwsCmVARmAazHN4V8BQirb8RZNgQBHepBxk5zTQopXxvENS+UnF45ne3/XZaOJ65ePgz5xxEYjOxBSBCnyFcR62OHm99k9ng/I5UVxOwB4GbUXBWM6p6bQ92as0IAMJtXX5AAso8n59YGGDaq1K7QCDNvk7yorsAUX/P5g7iKR3DeyfM3GkV6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 06:10:46.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96204a8e-3654-427a-ee0c-08de96c7e7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
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

For triggering the dpc event with a single device, we still need
to set the in_link_reset flag and the dpc status.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index deb41c095b59..ecc6e96cb5e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5524,6 +5524,8 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 		if (!list_is_first(&adev->reset_list, device_list))
 			list_rotate_to_front(&adev->reset_list, device_list);
 	} else {
+		if (amdgpu_reset_in_dpc(adev))
+			adev->pcie_reset_ctx.in_link_reset = true;
 		list_add_tail(&adev->reset_list, device_list);
 	}
 }
@@ -6291,7 +6293,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 			amdgpu_reset_set_dpc_status(adev, true);
 
 			mutex_lock(&hive->hive_lock);
+		} else {
+			if (amdgpu_device_bus_status_check(adev))
+				amdgpu_reset_set_dpc_status(adev, true);
 		}
+
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
 
@@ -6406,13 +6412,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 
-	if (hive) {
+	if (hive)
 		reset_context.hive = hive;
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
-			tmp_adev->pcie_reset_ctx.in_link_reset = true;
-	} else {
+	else
 		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, &reset_context);
 out:
@@ -6467,8 +6470,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 			tmp_adev->pcie_reset_ctx.in_link_reset = false;
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		}
-	} else
+	} else {
+		adev->pcie_reset_ctx.in_link_reset = false;
 		list_add_tail(&adev->reset_list, &device_list);
+	}
 
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
-- 
2.34.1

