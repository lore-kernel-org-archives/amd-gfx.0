Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475CECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 10:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0485A10EAD3;
	Thu, 15 Sep 2022 10:34:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D03F10EAD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 10:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A97KYBWfSd238ODt/kNq2noyfM3APKP5uIoPEf2R83PyL3QdQhdYE2Jql2mwvEmoG+n275VD5WAhIuqcDSERJ1nWXAEJoUR31mmtqWUYER8hRmYw5Tvf/QEzWRkyVXCGe0Ue7y7eTTNc/04+C8ShrWirUmfl9jCtIxw7aVDdhLh0wSq44jjrNGuWdH/vjvnUu34SlZckK4zUkRBp1/hvxou9Ahi1W91cgaB8iLych0zlEcbsDsF7b7H2LKrF5ckzGgyc7xPgDKZUMMMpSsnmN5szaVoUnq9MiIxdcPDsFIoRBMeVHCrm/UwKyd+5PVlyMT4nT0Ma21o7jmUXmrt1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlk6+QJhBiq5nYX7Okar0cF11/7WD2FwyiDgZdo6gtI=;
 b=BRBG/6jiYVUv27rSEHx/rDQbAUla2dtDPfIpQ33EBourfu1XBxSQqfi0IfbSs964HPMIW61xTf2JW+doeNdSf4Wh7lUS/EBKBYhlkoZWNm3tWkxnCF0p41D8LvXGA5sGFEdgLbyaGTgNVkYlb2UsUznfqLmSgmQ8g5iEqkPPsH3+Lw0fZmSC1GHMsoEwFpYCbWTiMtk5SArmSeRgDpeq0s9Mj1F7K/RGezYXzhMVrn0Y6wMcxF9w8lR0U9Q6Fwq6hlzn03tR7c3vfLD6knY+VLV6Z6/PJXnmNzY+hTQ/gIvxKrlnKb4Cd4kRNCUQ/rPPYpqpWcwLl7xDcfq+sp8v4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlk6+QJhBiq5nYX7Okar0cF11/7WD2FwyiDgZdo6gtI=;
 b=heh+jqJm0EGlU0HYMd0ApapDhARvZK1wIhHadSs3FT0P9Mz3Qi5lwV7PESE3PffZGk4CT0vxo+kr/91KNUaz7ufoohtl8kH6cRuTvhzla6RTXzOPFSjvUbBQ+mV6x++SKb9QWZt4ZxWqordPnuGrzDbwmExGyrluNBRemLFpmOE=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 15 Sep
 2022 10:34:39 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::40) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 10:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 10:34:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 05:34:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 05:34:37 -0500
Received: from mark-SkyRiver-slmb.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 15 Sep 2022 05:34:36 -0500
From: Rui Ma <Rui.Ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drivers/pci: Decrease VF memory BAR size to Save host memory
 occupied by PTEs:
Date: Thu, 15 Sep 2022 18:34:35 +0800
Message-ID: <20220915103435.52137-1-Rui.Ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 4301a70c-a27d-475b-5679-08da9705e448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4FMnplBHgZ+gRQCQp9Nh09cMn6KmMMCRsA9CDBpGOgVtQOsXe0coqQyGvkxffGMHLZ5/g/Wj8h9IuhPACKfP9q21HMW89cNKR6wwyZrFPteG2R2YKDfa6sRf7n4ee3+lNyYkycN9hUInq+bv8Ncvbfb+OGeBZok5OR1TQ6igEPnxhgwQ40Np1Hwf8JmRb4PPEUZYrMR9tsZjq+WiZuZ2xMO51+3s8EXDzfzWuu1Le8a3UV2bd11XrC0rsF8wLZ/a6msHXF2drVa0jTQ67ToDae4Ip4Z4atyOUx7gAfM6DhkX2bJzDx0f11LiOX1oYpXWbdYQ2ohfoecyvgIGKPR0US+gpNWpEcxkNHfr/3373UUGTu85SdRmscyscEv/gaWFSXTLyG1Ar4L5Ra5jskZmAGDiK3iFS95ADja2SvjjR/53pbUAX1gz+mfm2owUWJMzxAslu/AMMJgQ5wkkbf280c7IRJAfpHQ+VqapaH89MMvaMHdSW2nw/69fOOxPhhGm8b7iajwjcaPxEatkIz8Y21uwUfq0vu88oAre3OIpu66xBSEcwNiDFflhjoDtOMBbYMTdXpymTPMnZj3Y+DxWBFx0uxXYrVoZY6tzgzbi9Dn0TSPtSY/M5d0gbdU3n3G2s3eEFBTTMNQKASu3L3LDUCqiIs2lRZBiGURbnjMy0NCvzGr+LVUwDlOtU9mJeOkycDQH33ALZov9XNWxuZZaJWv4wlvNZo0qewAMyhAGVz7sBGlSQMEODSiR+EaygUSSoUmPV0ncSEaHZAPRVB1HEqibjoaxl5QmjvzaFzEb89bKllt+8nhLyjXEBuBz1uK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(70206006)(8936002)(83380400001)(82310400005)(70586007)(40460700003)(5660300002)(1076003)(336012)(186003)(2616005)(47076005)(8676002)(4326008)(426003)(36860700001)(2906002)(81166007)(41300700001)(356005)(82740400003)(40480700001)(36756003)(86362001)(7696005)(478600001)(26005)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:34:38.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4301a70c-a27d-475b-5679-08da9705e448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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
Cc: Rui Ma <Rui.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VRAM space is fixed, as the number of VFs increases, the actual BAR
memory space used by each VF decreases. However, the BAR memory mapping is
always based on the initial size of the VRAM. So do not map this unneeded
memory can reduce the amount of PTEs to save host memory.

Signed-off-by: Rui Ma <Rui.Ma@amd.com>
---
 drivers/pci/iov.c    | 11 +++++++++--
 drivers/pci/pci.h    | 15 +++++++++++++++
 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..d623f46669b6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -295,6 +295,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
+    /*
+     * Some SRIOV device's Bar is too large and occupy too much rmap size.
+     * Resize the request resource of VF.
+     */
+	u16 shift = 1;
 
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
@@ -328,8 +333,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		shift = 1;
+		shift = virtfn_get_shift(dev, iov->num_VFs, i);
 		virtfn->resource[i].start = res->start + size * id;
-		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
+		virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
 		BUG_ON(rc);
 	}
@@ -680,12 +687,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
+	iov->num_VFs = nr_virtfn;
 	rc = sriov_add_vfs(dev, initial);
 	if (rc)
 		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..befc67a280eb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+struct virtfn_get_shift_methods {
+	u16 vendor;
+	u16 device;
+	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);
+};
+
+#ifdef CONFIG_PCI_QUIRKS
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2);
+#else
+static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	return (u16)1;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..82502c5923e4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4085,6 +4085,44 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 	return -ENOTTY;
 }
 
+static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int bar_num)
+{
+	u16 shift = 1;
+
+	if (bar_num == 0) {
+		while ((1 << shift) <= num_VFs)
+			shift += 1;
+	}
+	pci_info(dev, "Bar %d get shift: %d.\n", bar_num, shift);
+	return shift;
+}
+
+static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
+	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
+	{ 0 }
+};
+
+/*
+ * Get shift num to calculate SRIOV device bar.
+ * Sometimes the bar size for SRIOV device is too large
+ * and we want to calculate the size to define the end
+ * of virtfn.
+ */
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	const struct virtfn_get_shift_methods *i;
+
+	for (i = virtfn_get_shift_methods; i->get_shift; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID))
+			return i->get_shift(dev, arg1, arg2);
+	}
+
+	return (u16)1;
+}
+
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0)
-- 
2.25.1

