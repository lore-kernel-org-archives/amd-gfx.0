Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B412DCD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 09:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4486E10EF44;
	Wed, 17 Jun 2026 09:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rzj5DzdC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D3110EF43
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 09:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKLVbpue7f+5FHUFR5P2eIIVa7FV5wev1NX7SGwY8hK+2IR7UL36gYtava6qXvpNy5fLoWPmD7Qk8MuGKAYLVryOvm6Op16TBSa1MnrN81otyQ5kpDOLtm8QghfdSGIC6s3sHh2Cbs3uesSBJCje3rj7sc9D//gZ92rbq9gRAser3P+UjdI9z/xvSQYK+IxHApgBWgfuztnrdO8d3qrmg1KdVYQlllEhQqxHZ76XiaFC/gfVybbcHLn2azsd971+Eb1oH6YhTeY5lNXljEu+PYBsoInDLCtbRmM8FQl2HchhUU8+AYsrj59NGxXHKJy5bJF5Gok6Z2KRSicyW65OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCCL7Vh7anZ9trV5kLl6HjhbHuyoDQ7fDdrnNusfc/0=;
 b=LTvmOmqSOWF8jDH88xdAPBfd8sso2wNCSJHG9Uv5uso7b+eTQMfbbhivdXYPlahsXk2+3pfbBUtrSTuHTIFWX1u+D4uqlboiVixxQVcLuuNMah8P0/QHRD9TTLmmCqbc1npN1PIkpkIm668qupnLi/z1R2ejLB/WwNXxBDpmcUa80nSb61WIrv+C8VTse0XS90q2QGyO1qw7YQJFk3I7z7YpyJWFzYvfIwd3rIzAE5H+fSADVHlXqVegmkm6FtNi2hg3dX0I8PSJOTMkR6XLUDzaRvUJeDNUqz1Vr0bGLrfhDayGG5ZOv9bp20pUM9t+cs1D3hq5F5+7bH0fCdgSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCCL7Vh7anZ9trV5kLl6HjhbHuyoDQ7fDdrnNusfc/0=;
 b=Rzj5DzdCuU5UQ0C13tNADXXfUrg6iITaVISO1+f0w/Q+tjsY2KpKgDgeK6X4yZbiacKLcrMXmzksLnJd9StKwklySYhrMQwar4cHhjxLXfKyx0a8mtv5dj6hnpZmcif4UEXmaTUIJTyHmQik5jYuhdsyxyVDXGfDfehaxgVNIRQ=
Received: from CY5P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::36) by
 DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 09:35:36 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:930:b:cafe::83) by CY5P221CA0030.outlook.office365.com
 (2603:10b6:930:b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 09:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 09:35:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 04:35:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Guard reads in pcie state readout
Date: Wed, 17 Jun 2026 15:05:18 +0530
Message-ID: <20260617093518.753118-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 796abf6e-1047-4fb0-e413-08decc53c933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: qnRsmXFGeugFrz3PqAWm2rtH03IOBDABetkYm7E/2oACSjKt+P89TRnjBXmMI06JjGygNOtieTQhh2LxbI6ZN+Dxf9SrxLn8zSyKfhyaYhcPSAUmX763yqwjGj/rk2c26+6v0/ffrQtN8/yr3blmxO279hjJfOcve3TAm0VaHeT69H7rdCwoi5+TTi0rsfz0JK0kZvPHbMh3OKzOdM31fOQ6Gmz6E7phyPVVZ0RVlb8lz0lJrXLViWXa7K1pV6cQ323E4nwvlCV+H086z2XcX2Z/nHaoEgL0fmd2N21vDzJAE6Uf61jaG1SLMdbMtt2TtcoKN/v0Ak+7+UBX6ROpeOQoYPeEcbNptunxTvrbRLviK/nNpjXFam+lqOoimc4NCpG74l/nyCGcUxyUa6XYpYlMXf50Lmtp27SGc877gFbTMbRd5k+BRLOiKPKh/Q96pJMTN4D2CkqyiR8cSa35E9oI5cw7M+4iAWHND+Jnx3Vlip9BQN9l60KqQ46TR6pcXQ2+t3NSYL2YQc9OULifdkJiSDqSRIWR67SW0ANpTx/uxef0DRAQnDBqKw+kGNRz4Nt00+buGg+Zxp0j/5r6o83BV80JxWxGnh2cOlpYxJJpc212/0dn6pQv5ZHmUdQ14fCNoTSFUCT4fn61Ot94owttPe0cdCjyq+lc1AIGeAQd0mR2BZ2qgBF+eGnpGfI1f7qbTcmTbF6xUOaCz68JVXP34hv1+HnYACbGdFUOTdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hyNv4WWdhawK5n2BeZ164lfKEkHGUI8so0Rf/cW77N5uuGx1Wn688j8iL5JSUHKquW9ivfUcZRp7b1ChfGNmiz1gD7rlbWT3aKfofpRS4wHO+teUftimaZ8OGkRqWdxUuGzRj0pIQtpCccVuiGoB/mtsNfCKn3ROI3w00WqU/5ILuc6gqW0RJFpDg6JXtaP/ttIQFTaXAqXCorZ5Ck/CEnU7+mekBYI0CsgHIWUWun46KUGWaVkkp4FEX8jv0Yf9TZYAhBSHeMtkWIPIHswon6LYFXpSd1nfJ/L3gM+xW8+f0oNYJ/XDcUBlQZnPTsQMS3hsOoLQdimOmpnfwINrTiKbQXecAzDHtiRbTonTw0ugS5Ii0uFs5/c+5SJbKne4rNVNkEVynvOq5QsDq4o+vAQADEpqyqBXWV7XuUx5oIpQrdpgkoLIhulHYPZMAR8R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:35:36.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796abf6e-1047-4fb0-e413-08decc53c933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
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

Internal US/DS switch may not be exposed in passthrough. Guard the
upstream port reads to avoid a NULL dereference.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++-------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 72ea37dbfea8..5f1389901504 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -589,6 +589,29 @@ static struct aqua_reg_list pcie_reg_addrs[] = {
 	{ smreg_0x1A380088, 6, DW_ADDR_INCR },
 };
 
+/*
+ * Return the GPU's internal US switch port, or NULL if it is not visible
+ * (e.g. passthrough) or the EP is parented under an unrelated bridge.
+ */
+static struct pci_dev *aqua_vanjaram_get_us_pdev(struct amdgpu_device *adev)
+{
+	struct pci_dev *ds_pdev, *us_pdev;
+
+	ds_pdev = pci_upstream_bridge(adev->pdev);
+	if (!ds_pdev || ds_pdev->vendor != PCI_VENDOR_ID_ATI ||
+	    pci_pcie_type(ds_pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return NULL;
+
+	us_pdev = pci_upstream_bridge(ds_pdev);
+	if (!us_pdev ||
+	    (us_pdev->vendor != PCI_VENDOR_ID_ATI &&
+	     us_pdev->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(us_pdev) != PCI_EXP_TYPE_UPSTREAM)
+		return NULL;
+
+	return us_pdev;
+}
+
 static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
 					     void *buf, size_t max_size)
 {
@@ -596,7 +619,7 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
 	uint32_t start_addr, incrx, num_regs, szbuf;
 	struct amdgpu_regs_pcie_v1_0 *pcie_regs;
 	struct amdgpu_smn_reg_data *reg_data;
-	struct pci_dev *us_pdev, *ds_pdev;
+	struct pci_dev *us_pdev;
 	int aer_cap, r, n;
 
 	if (!buf || !max_size)
@@ -628,25 +651,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
 		}
 	}
 
-	ds_pdev = pci_upstream_bridge(adev->pdev);
-	us_pdev = pci_upstream_bridge(ds_pdev);
+	us_pdev = aqua_vanjaram_get_us_pdev(adev);
+	if (us_pdev) {
+		pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
+					  &pcie_regs->device_status);
+		pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
+					  &pcie_regs->link_status);
+
+		aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
+		if (aer_cap) {
+			pci_read_config_dword(us_pdev,
+					      aer_cap + PCI_ERR_COR_STATUS,
+					      &pcie_regs->pcie_corr_err_status);
+			pci_read_config_dword(us_pdev,
+					      aer_cap + PCI_ERR_UNCOR_STATUS,
+					      &pcie_regs->pcie_uncorr_err_status);
+		}
 
-	pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
-				  &pcie_regs->device_status);
-	pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
-				  &pcie_regs->link_status);
-
-	aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer_cap) {
-		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_COR_STATUS,
-				      &pcie_regs->pcie_corr_err_status);
-		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
-				      &pcie_regs->pcie_uncorr_err_status);
+		pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
+				      &pcie_regs->sub_bus_number_latency);
 	}
 
-	pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
-			      &pcie_regs->sub_bus_number_latency);
-
 	pcie_reg_state->common_header.structure_size = szbuf;
 	pcie_reg_state->common_header.format_revision = 1;
 	pcie_reg_state->common_header.content_revision = 0;
-- 
2.49.0

