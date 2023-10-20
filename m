Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A9CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 15:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0EE10E5CB;
	Fri, 20 Oct 2023 15:14:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AF310E5CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 15:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1XoLZj9ZTLAEZp8sIOpLHiAul8m5Eg/3nkrqflpUcUZgub6H4ShGX8MlAlE6cHLXGI0xwRakLzphFSCsH5o+P6hDOgacNJ2L86w4H8Q9KGbuQCPguMsk0wbj9aaol6YxBUBgmVdB3smriWdwMa12v+foCXD3z/QSopsUNOI4xjKZck7bOYiqaDNG1/gKjrNzG6hTGQAlaM2KVQftld+OuxtNW8zk7T94aBx94Cz0B7n3ymUQi6VcKdCFCXhLhqvf0+aFj2ld+Io5kntPeJrk2G44kVWKWsUsUhSCSiUO3Fc146549zjuKKyZmTOMOQ6Q/AQpMaMOzxnuafJcg2B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFlDXOn2ta4ag8PTQYAqaSqF46yCMPNIZmYTYysv48o=;
 b=F0xkSz97J5ul9SCqgcbkVSN8F6yDfzf7dmmStTGYqU0klDlK0yC5ByJzX+EJQT0jNeoHT3SBelEN2g3HRgZ51JA3niaa7ynfDq05EvmoH0ok2Ntrnn6+/KdN7t2acY1FyAoZs+1xrvZk6Ty32wmaMDYhM5gXo7vUdBR6SP4bTioY1BWWJwaUZE5qjxVQzXvC2mVMsM8rEqFfbfcXWDgWo4d95y1AraVW94IjAo8f2VGq7a0SGq1bGoLnqaDCmUDLasFDs4jaZ9+alRF0FA33a+fv66RCeE6c6wj1WShwj3IFr2T/MqShBPaNnswjGWjrZvSTltO943/rcCY2l4N8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFlDXOn2ta4ag8PTQYAqaSqF46yCMPNIZmYTYysv48o=;
 b=Vf8RpnFK8kE+yOplNHPAS/0TMaEmdE15PgESzYxUL/FgasjYH0PErRGR8QjpDJIjVPZjtWEv+Oist8W/MvcwqY56knDSR2y9umcNQ0CGcttibDrdEq1pytNPw4WvAjzisp3l6Qfn+oXa5ZlfN50MHYLPRqNoZnHdyvCrHoQFFPg=
Received: from BY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:a03:1f4::29)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 15:14:44 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::5c) by BY5PR20CA0016.outlook.office365.com
 (2603:10b6:a03:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Fri, 20 Oct 2023 15:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 15:14:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:14:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
Date: Fri, 20 Oct 2023 20:44:22 +0530
Message-ID: <20231020151422.349394-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: bae2c01a-6f20-4c85-f349-08dbd17f4a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INOBlFXc/QVsW8N/Ye0DcFWJViV1OUmRV67bK1vyyUrPOYVRmQvgmR4ytYivEURLgyQCWL6j6pFwME5bK5Zb+fipHs2hAJlCjXf3nO6X1MUqbtyixN7ymra2lgGLh0zv9X+rPlogDwOcnVFq9ASrYfptJZ1Wi3euJu7lHMOalbH2ok7w1Ds+6t6g/W0lMXX+vUT4poAxQocvIwZuS/jhBkS0uqVCSk5UGgaHwuQgq2omP0kjeCFas+wlemMgEOJXX+aCwvCQb+8PXfj/MkX+P9Jvc/B6oGnzZ7L7GDF36KFIJ1tXNLVdn+crUNPLzLIJgmpS2kuSpHaGUYi4qwEki1Z/cxaJJYgscPIrZQycGlINxy7a4BfOPW8NGzIGXA3mfFceij6EoHRMFtS3oCAwX1uOygEESm3rM7H5zIUHYMpOMcmG2i8kBCc0V9ig5TqVJ1Fl81K7OuGIjQ9xBxrpgZScieH6t5x/lh8sEdJ1O/AgoTul4rI5tRRC/ke+usnwItKxgCJFe6vnhGcg5u8lFHCgvMOVdedn3631z8dzzhwdAu8992DA57VA+w7cwdbunY1kaKNRzWt8WoTj7JHrm3eyg0vqbo2Rwfy6dmH7ZTRB41h5aADKIPskeqapCkdi7aIuf39srxdOnBHr37a492ZQFsvYavPQtv8xx2GGr2+r1SWNBYXnYfNonktaOpORW0RdIkIzD6MKolzPqAPlzwTtJL4RbUCiwfwRHJbhZ4rNtmIXrYT0G90qxiZSU7Y7N4WcF/jvxNAyxGEmQ7ffzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(356005)(16526019)(82740400003)(36756003)(81166007)(426003)(47076005)(26005)(336012)(83380400001)(70206006)(6916009)(316002)(54906003)(70586007)(2616005)(86362001)(36860700001)(1076003)(6666004)(478600001)(40460700003)(2906002)(7696005)(44832011)(8676002)(5660300002)(8936002)(4326008)(40480700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:14:43.6244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae2c01a-6f20-4c85-f349-08dbd17f4a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PCI domain/segment information of xccs is available through ACPI DSM
methods. Consider that also while looking for devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 2bca37044ad0..d62e49758635 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {
 struct amdgpu_acpi_dev_info {
 	struct list_head list;
 	struct list_head xcc_list;
-	uint16_t bdf;
+	uint32_t sbdf;
 	uint16_t supp_xcp_mode;
 	uint16_t xcp_mode;
 	uint16_t mem_mode;
@@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 #endif
 }
 
-static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)
 {
 	struct amdgpu_acpi_dev_info *acpi_dev;
 
@@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
 		return NULL;
 
 	list_for_each_entry(acpi_dev, &amdgpu_acpi_dev_list, list)
-		if (acpi_dev->bdf == bdf)
+		if (acpi_dev->sbdf == sbdf)
 			return acpi_dev;
 
 	return NULL;
 }
 
 static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
-				struct amdgpu_acpi_xcc_info *xcc_info, u16 bdf)
+				struct amdgpu_acpi_xcc_info *xcc_info, u32 sbdf)
 {
 	struct amdgpu_acpi_dev_info *tmp;
 	union acpi_object *obj;
@@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
 
 	INIT_LIST_HEAD(&tmp->xcc_list);
 	INIT_LIST_HEAD(&tmp->list);
-	tmp->bdf = bdf;
+	tmp->sbdf = sbdf;
 
 	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
 				      AMD_XCC_DSM_GET_SUPP_MODE, NULL,
@@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
 
 	DRM_DEBUG_DRIVER(
 		"New dev(%x): Supported xcp mode: %x curr xcp_mode : %x mem mode : %x, tmr base: %llx tmr size: %llx  ",
-		tmp->bdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode,
+		tmp->sbdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode,
 		tmp->tmr_base, tmp->tmr_size);
 	list_add_tail(&tmp->list, &amdgpu_acpi_dev_list);
 	*dev_info = tmp;
@@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
 }
 
 static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
-				    u16 *bdf)
+				    u32 *sbdf)
 {
 	union acpi_object *obj;
 	acpi_status status;
@@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
 	xcc_info->phy_id = (obj->integer.value >> 32) & 0xFF;
 	/* xcp node of this xcc [47:40] */
 	xcc_info->xcp_node = (obj->integer.value >> 40) & 0xFF;
+	/* PF domain of this xcc [31:16] */
+	*sbdf = (obj->integer.value) & 0xFFFF0000;
 	/* PF bus/dev/fn of this xcc [63:48] */
-	*bdf = (obj->integer.value >> 48) & 0xFFFF;
+	*sbdf |= (obj->integer.value >> 48) & 0xFFFF;
 	ACPI_FREE(obj);
 	obj = NULL;
 
@@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 	struct acpi_device *acpi_dev;
 	char hid[ACPI_ID_LEN];
 	int ret, id;
-	u16 bdf;
+	u32 sbdf;
 
 	INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
 	xa_init(&numa_info_xa);
@@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)
 		xcc_info->handle = acpi_device_handle(acpi_dev);
 		acpi_dev_put(acpi_dev);
 
-		ret = amdgpu_acpi_get_xcc_info(xcc_info, &bdf);
+		ret = amdgpu_acpi_get_xcc_info(xcc_info, &sbdf);
 		if (ret) {
 			kfree(xcc_info);
 			continue;
 		}
 
-		dev_info = amdgpu_acpi_get_dev(bdf);
+		dev_info = amdgpu_acpi_get_dev(sbdf);
 
 		if (!dev_info)
-			ret = amdgpu_acpi_dev_init(&dev_info, xcc_info, bdf);
+			ret = amdgpu_acpi_dev_init(&dev_info, xcc_info, sbdf);
 
 		if (ret == -ENOMEM)
 			return ret;
@@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
 			     u64 *tmr_size)
 {
 	struct amdgpu_acpi_dev_info *dev_info;
-	u16 bdf;
+	u32 sbdf;
 
 	if (!tmr_offset || !tmr_size)
 		return -EINVAL;
 
-	bdf = pci_dev_id(adev->pdev);
-	dev_info = amdgpu_acpi_get_dev(bdf);
+	sbdf = (pci_domain_nr(adev->pdev->bus) << 16);
+	sbdf |= pci_dev_id(adev->pdev);
+	dev_info = amdgpu_acpi_get_dev(sbdf);
 	if (!dev_info)
 		return -ENOENT;
 
@@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
 {
 	struct amdgpu_acpi_dev_info *dev_info;
 	struct amdgpu_acpi_xcc_info *xcc_info;
-	u16 bdf;
+	u32 sbdf;
 
 	if (!numa_info)
 		return -EINVAL;
 
-	bdf = pci_dev_id(adev->pdev);
-	dev_info = amdgpu_acpi_get_dev(bdf);
+	sbdf = (pci_domain_nr(adev->pdev->bus) << 16);
+	sbdf |= pci_dev_id(adev->pdev);
+	dev_info = amdgpu_acpi_get_dev(sbdf);
 	if (!dev_info)
 		return -ENOENT;
 
-- 
2.25.1

