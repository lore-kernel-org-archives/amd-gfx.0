Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46223C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 01:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFE010E60D;
	Wed,  1 Nov 2023 01:49:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F91B10E60D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 01:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnh68WXF5d9eO2p4oRnfcq/3GpmU+xUY+opG5HdQ1WQj3BABDDr0SGOwMeVGhiH2P3JbPsaDLZSHaS9WiOXx/9gOCqioB3AUWgFdV8NUUKLjzrvjBKczrr+xW6l2nKxK5cRhBC1ABWKxZxhRs30VhG4GJUc/77PsIljCcRsjF9wT5xk61cz+HA5QNIukbBLshnv2tUrpl7QLFl9ebSXZga+eoYRURSIAkowMCdDsD8ttcH8W+Aj8dsXFnU5wyNRe2ttl8+VhGH8gHzrGt45JBwyB/vGrTjEUkXeYCja8gxcv/dnc/aWxFvJrlUKk6zO6LFNHBbBz1tDj9x/G+0dl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esSHvsilzLXIsPki+u5GCy5/c+sCr3JIngmzgGoHwww=;
 b=TZUSKHqZvpXLUaFavLa8DB8WmQWQ2TczqEhjSP70DCYZx/qfreGVnfolIM/+eB6yEsYdfoQQCGXLuYsn3bX668lhSCn6mnJUOmAnQQDnxzNQhLRyLR+K9uUsQEYTvYmsv7/2T9Axyc9cHGZpcnFhNnN6z3gRVrgCSoW4YFTOhz23KZoMffTCp4hO/pT0qfWV4lKsFkcXi5tin9OHkkQ9FDtVYlickze8hWcRckk1exg6o8XanYMVI8z14WUpmEadx8ZbDK6TJ1DWh63cTlpIYjYeeChllp3E3uJEA61NyGq17hLtxwW3WrREsY1M/7k9Q802hy6XXUSJeoftcqTG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esSHvsilzLXIsPki+u5GCy5/c+sCr3JIngmzgGoHwww=;
 b=ZmWy+AMiCZR2jtsRQtkPYuXiXiasdrFRHLM45vJP/gK1ofc4V6fzyicEJTWnX+/8ftHcoKDGfL01YF4CeDAoT/4oU9vDQuo0JTvDbz8pEZe/tFazWEWnrrxtJJKdAM2zpkdGbtRLnPH9LdJwjnkSvJxMvrdUjfRk/0kLukGzDIg=
Received: from SA0PR11CA0189.namprd11.prod.outlook.com (2603:10b6:806:1bc::14)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 01:49:07 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::61) by SA0PR11CA0189.outlook.office365.com
 (2603:10b6:806:1bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 01:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 01:49:07 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 20:49:02 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Optimize the asic type fix code
Date: Wed, 1 Nov 2023 09:48:44 +0800
Message-ID: <20231101014845.1979083-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2f71c3-fda1-4f75-d702-08dbda7cbc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgWGNTJ9/56amXNrhpfigNcfiWahudJ0QofPccIbdhv4B8QjxTA53Xo288cay1MnEh6qzEbuVB3SyBOUamam/QTHFyhkP/8Z6JC/VdzXBg4qrSuFGybMePpMfpBY4qPA1ywe5eEtfjnf93KEWmGOSUdpRNQbvM4zBuY7SkJll4Ob2os8QIBFBV1wmXuIeFYsAvkYKfF8uPIyBNZlFMI4V0Tc5S/6TsMuK64KYFC7MSC/+/WXH5MtVUK1YgEaEGctsI0U/cMSSNanmrz9koDvhtqSSncV+Gdi1QFBSy5UExg+qbro8ul+DJ6c1zW2+yj9YpbXCre3bHLOVBbI7P1bX2Je3bQ9ZvbbPwSXglTOWZccY+BVQ/4eXE76e3Kr4hTaiAAhb8C4fH56ukuSbwzNfuViD0lyhdvWkB7qg1ntQmVmyxVntaKTMGwvhgqvdpfIOhs3057qcVZaUwpr4vQWAkou6xOp8uNHUFIVqkAcZn5/5DHgEtBO3TL9pWnr46Fc75V1H+Wu2qV7Ug1zV4Rhg86fYfeDzCFgKK+EQxhPCTI4Wrrk/80lFSzMzRs3HOX/fZMddFXrQHE0af87qwmHma+y9ptr7mXkKhc5rlqRU3nJOmoqHq7FkDfqf/SKN3Rg/DSfkFussa8+n3Tuu9dwYBYVlfYhVeNr3O11ICnqEBqhbGx1jxntE5gn7wtK0aujl6Re4ARhv1/5LQn/Z4/pY+DGHqGLFdB9oIHRdEuU8oPW8GF/yENGZlSW2L8+doWnJMTpVd8YJaXKNZC2HcuAqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(110136005)(5660300002)(70206006)(70586007)(6636002)(316002)(8676002)(4326008)(8936002)(40480700001)(40460700003)(1076003)(82740400003)(356005)(81166007)(47076005)(83380400001)(2906002)(478600001)(7696005)(16526019)(26005)(426003)(2616005)(86362001)(36756003)(336012)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 01:49:07.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2f71c3-fda1-4f75-d702-08dbda7cbc5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use a new struct array to define the asic information which
asic type needs to be fixed.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 35 ++++++++++++++++++-------
 include/drm/amd_asic_type.h             |  5 ++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 84703e0a73bd..756cf49557a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2067,6 +2067,14 @@ static const struct pci_device_id pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
+	/* differentiate between P10 and P11 asics with the same DID */
+	{0x67FF, 0xE3, CHIP_POLARIS10},
+	{0x67FF, 0xE7, CHIP_POLARIS10},
+	{0x67FF, 0xF3, CHIP_POLARIS10},
+	{0x67FF, 0xF7, CHIP_POLARIS10},
+};
+
 static struct drm_driver amdgpu_kms_driver;
 
 static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
@@ -2109,6 +2117,22 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 	}
 }
 
+static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(asic_type_quirks); i++) {
+		if (pdev->device == asic_type_quirks[i].device &&
+			pdev->revision == asic_type_quirks[i].revision) {
+				flags &= ~AMD_ASIC_MASK;
+				flags |= asic_type_quirks[i].type;
+				break;
+			}
+	}
+
+	return flags;
+}
+
 static int amdgpu_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -2138,15 +2162,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			 "See modparam exp_hw_support\n");
 		return -ENODEV;
 	}
-	/* differentiate between P10 and P11 asics with the same DID */
-	if (pdev->device == 0x67FF &&
-	    (pdev->revision == 0xE3 ||
-	     pdev->revision == 0xE7 ||
-	     pdev->revision == 0xF3 ||
-	     pdev->revision == 0xF7)) {
-		flags &= ~AMD_ASIC_MASK;
-		flags |= CHIP_POLARIS10;
-	}
+
+	flags = amdgpu_fix_asic_type(pdev, flags);
 
 	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
 	 * however, SME requires an indirect IOMMU mapping because the encryption
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 90b69270f2fa..724c45e3e9a7 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -68,4 +68,9 @@ enum amd_asic_type {
 
 extern const char *amdgpu_asic_name[];
 
+struct amdgpu_asic_type_quirk {
+	unsigned short device;	/* PCI device ID */
+	u8 revision;	/* revision ID */
+	unsigned short type;	/* real ASIC type */
+};
 #endif /*__AMD_ASIC_TYPE_H__ */
-- 
2.34.1

