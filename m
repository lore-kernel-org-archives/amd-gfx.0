Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E20C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 03:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38C610E62A;
	Wed,  1 Nov 2023 03:05:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB3910E030
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 03:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcfnPRgq3IPIVvTCXRP0VAOelEGiU3/eEwuXjZT/e8AuC2LviwQtF/dsfmPhfkd3vlWNh2xAYouPcS1WHnZBbBKXMLWlepSAlh8LnyBcBpGyHY4WoLRoRnVkrz4aeCjV/m0BVOMKMorvDgcy+UCzGsNDXQ1pXMg8u1IpbFsQf571E6d3gy3U2nL5vz9JoXmEFtN8i3FeJU9j8Q8vu0cTr3kPf7NRZcHPexIL9h/oh7w/zIe/CWR4XNTBazcQaPXkty4CRAs390fVPqxDYC3Dtn2E3g7nW5pLH73LozaKGB1ej/ZheuKr/sfyTIqbfgqRYMXt3JEA9i5qB0i2lQF5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esSHvsilzLXIsPki+u5GCy5/c+sCr3JIngmzgGoHwww=;
 b=oAM6T9d2nLfKgrADO0sV4tylpaf1bEKk7AWy08m487nPkitwHWKXJlNDrDq67O17UJO3qcZu3eHjQ5R/5IoEjZ1a2x9TwlClW6XDp22a2JTydYtGbggYAck2+axzvlyt60WLSPbYaCyf/E1TC8VtXw2oshmQXElMkiMDsXg8vgcd1q1RVGJ9bmEf1CjvmXlMGBqXczEdC8liB51Spz2VpFfsdyXnG5Zj3QfAlzv7X4bwV02rUaox285rnLV5HeqSHxV3JpyPYMPaX453iTrs3VUXPIeAtVXuxRWqqKvEXjebnPeFuq1KYIzzFctku8uzNXbeMA/3yz3Qy6ZxxFvPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esSHvsilzLXIsPki+u5GCy5/c+sCr3JIngmzgGoHwww=;
 b=QAxw9Oz7Pu17LaRCCIrwuxYTOvAM4igprM2pIdF/EBOrEblmjdU6jTS5VkAX441AeIRexT0G/e9iEB8ElHhAQGipfvgZ0/8NA2wnhKMN8IThDCh9VxcRke3IwguF0uNgyFyY9Yq0n9y6/sCos6rvBoU2E7yg5REEUiaVcFGg+4w=
Received: from BL1PR13CA0275.namprd13.prod.outlook.com (2603:10b6:208:2bc::10)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Wed, 1 Nov
 2023 03:04:58 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::53) by BL1PR13CA0275.outlook.office365.com
 (2603:10b6:208:2bc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17 via Frontend
 Transport; Wed, 1 Nov 2023 03:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 03:04:57 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 22:04:56 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Optimize the asic type fix code
Date: Wed, 1 Nov 2023 11:04:41 +0800
Message-ID: <20231101030442.1988771-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 0666a542-08d6-4d9a-37db-08dbda875494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqYVpoineaIHwS8DM24KVLrxCSXSEXrwUx/x7CIhoPZp7cUR0cUkIo7YF9GXDLWP3UVozcB04sZT7aB/wgjgQZ0cVWVVfGKdOWa1J6lFaUwkdhyntkdQaXyxJH0htdBpODuAWCEAUpC2mdUx6B1n/umLip5wEmXhU7/Z8WJ2C6BxfCT0oDVGhAjcdQuviRZcfgsYLsmWAKpGpPD0zTxoMR+OzbQbnfPsFDWmylmgYcjqpUwdiSy62s98+reBM1V7bl/SHJjO/fe1v56AalpX3SI1NVgfzXeS/X18zQqtxL02J3GDclK9ydV3Holp4cg6FoPKogp8WJqTEKw6y1d0fvnCtvNlywHWUKhUuXHwl9izBDjp49imWStWRghinh3NX3c7fsVsNm6UdLDUXG+0TgZIG4vb0uOC/+ewfd8L5OBc1Fc9vuPDguKiiYZ6W2h8wh7p4mmRZUkmOHZrK8HevapoJ9iYlXkdkrdArWlp30r1PBasLGYRALe9iA6asKHXubn/1VV3l/lO1UaurTqQH+jo6zPfrpzODy4eFx+SNchEGb/GpHkhhiMlRloPlAPLnWvdodCyyfFavx3uTXJ61EUxAlP1xV9B2azYKa6w4WiztXudzKoFsiMDIRspWNbzqIBZQHKg9sNjeJPteCuBp4Ff1YfpMGp099AC+nqVXtKidvdhFHDRrNb6Dr8iM/5Xuse/Lweg6d3c2ervxt8KhSL5dIF7+RgcZe/+SW71pbanbNwQ1X2l9kWqL3Vtz7sLXXLoOM5sER8nsBGUIdcnnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(2906002)(478600001)(7696005)(70206006)(70586007)(110136005)(6666004)(16526019)(426003)(26005)(1076003)(41300700001)(2616005)(86362001)(6636002)(5660300002)(8676002)(8936002)(4326008)(336012)(316002)(82740400003)(356005)(36756003)(36860700001)(83380400001)(47076005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 03:04:57.7028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0666a542-08d6-4d9a-37db-08dbda875494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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

