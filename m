Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1BACD6E51
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 09:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822D010E4CF;
	Wed, 11 Oct 2023 09:25:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7827610E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 09:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esjHCw/PG5d1ZFv122KoKP5kHgZvIYs3Spfun/T5iwykEnSqBeIR12nSBio0+zofEDQY/nUtYoI1Bz+s1adFqbql5XgMCNVcMMqJ9heqtOzUTJvFTlzU5E5R3vO/JU7LNaBlST7TZS360kt2you7Pe/HizJcbgeRpjnX868MNghpG4cCtRw08eTVpCMNllFvUgJCoXJjOLZobguNKpavnfsDR5vg20uyREvagqXJnAcvxRXLkeSAqzb5+Slzhi7PIR5OKeGDemu8/LLIs6WaRH6nQZUyDlFELRWEgjmXMUhQrx1eBgJz1NW5v8XVQPykDxDK6jnb+Ji8AsUqrxXZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DCY9q8tv6l8F4Ved3ogBwLdeU8DMB50/TS1Ja2BDxM=;
 b=ZFWwh+spvGaaEv/xvSo/efJwRROlKKO/P8OzPjEXbMfdnCPUWgAJJF3x4ZW5/fclJIt9XPMRbr2d6IEAjH8F1C/r/w8z5ZErOfvlzItr9lMtSjJO2nEfEYkmrDjwt0z5xIG3FmJ8druUiXpFpexNrfSGJpxpatrULLQvNy0W3CTDdnOfFlRmMn+B+Cu9zuJMOjatF7U2MJA5xaHEHJDav5jB9Zz4YPUxSp+xslmeHrpxPnCHJe7e6HB5mfDmU0uj/xuteWY0TTxkj8OdvVg+a04gRrloQ6n9v4dbTwJxg5uf2gp1XtxttKDNChNxfRHdw8BrDCQXvchB91YUtfzIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DCY9q8tv6l8F4Ved3ogBwLdeU8DMB50/TS1Ja2BDxM=;
 b=swx0xw689lPW/fFes4aBBHzLZf0pO3k+froSfuqbIaPzCbWgJzadIRGiQ3n0+cAtqSq1bwlEj+bnuKUnktilED9PJ3S3K9yVoT15GRLxDhMDmMuhPDQuIzaEO3EtfJLz1Rt/b5jkt2BAf7okLZ24dfHaZSy0FmaClK5OGPfYzvA=
Received: from CY5PR15CA0054.namprd15.prod.outlook.com (2603:10b6:930:1b::20)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 09:25:54 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::f9) by CY5PR15CA0054.outlook.office365.com
 (2603:10b6:930:1b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 09:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 09:25:53 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 04:25:51 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Expose ras version & schema info
Date: Wed, 11 Oct 2023 17:25:32 +0800
Message-ID: <20231011092532.628919-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd869b8-6088-40b1-1fed-08dbca3c113b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiLI7HQokemqWnSDSEhGlIpQw9l5KSD6kV4fNmuvZpFnHVUMu9kGOVOOpQzq26kYhvi4l+s08x+IevoByraGBC0KefKgzBQ01G9IbkriK0FtCAqR/fgsIZweLWbD2AOKRYy71mRiAHw6tUvxwuHtUY2YS9/03lMj3jin9Me1FIrSjnt9bFswLnEx3vY1pHXPDLMvNLDIOcQELaVatPehWCULB5n1+xeLvYozvJqFEXavcgYEKt2yEXzsapslHCDjjrYYLG3+44b2ye+aL68FxtN6JUllsJsfLjq2Ikvap+wcsbHHdYiGyG7bE0+iPNQztLdP8DtQQ6L071Oqk2UKMjRE63XgpNxGDPfLBnnhH0vl9ulRinkCJD3qJe9riB8RwjADpGyp7nVqyQllSfO+TDXGUH9B4ICtbKBdjaDKap8a8jKVH5vrf70Tv92HEDKUuW5NVnSSSNT+YdvfAnmjuMjQD/iKWfQFW6s3BiAn4zXya7jaoX1VtJ23Ee/2AX1ckUjcZrKeKd+taM1Xu95u9rbCIacxf4rRgx8ao/G4gR/WfXmG/k3hdom16HFSlZBmGjBNhfBBncpMTa+W64WYu86zxldpJgmDKSH162vu//lhxIVkoHUfXIFARTJxmJOaUTeL9/ZEcJfm7IqQR/M36Hu31zDHtQN1NPfozfvQwJgvM7NThzgSXOR+p4RjpfejSEs8JJwdwDbmVT4oolZErWTKCZxKTffJq+HllaXwKRRw6PwyP5QB2l6v6KAzcv+j9GeMZ8zsD2dv1GTGeUwNvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(16526019)(47076005)(41300700001)(2616005)(478600001)(6916009)(336012)(1076003)(426003)(40460700003)(36860700001)(26005)(83380400001)(54906003)(70206006)(316002)(8676002)(70586007)(7696005)(6666004)(5660300002)(82740400003)(2906002)(44832011)(8936002)(4326008)(36756003)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:25:53.7899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd869b8-6088-40b1-1fed-08dbca3c113b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose ras table version & schema info to sysfs

v2: Updated schema to get poison support info
from ras context, removed asic specific checks

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 51 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9c8203e87859..cb9e48fb40d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1370,6 +1370,22 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	return sysfs_emit(buf, "feature mask: 0x%x\n", con->features);
 }
 
+static ssize_t amdgpu_ras_sysfs_version_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct amdgpu_ras *con =
+		container_of(attr, struct amdgpu_ras, version_attr);
+	return sysfs_emit(buf, "table version: 0x%x\n", con->eeprom_control.tbl_hdr.version);
+}
+
+static ssize_t amdgpu_ras_sysfs_schema_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct amdgpu_ras *con =
+		container_of(attr, struct amdgpu_ras, schema_attr);
+	return sysfs_emit(buf, "schema: 0x%x\n", con->schema);
+}
+
 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1379,11 +1395,13 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 				RAS_FS_NAME);
 }
 
-static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
+static int amdgpu_ras_sysfs_remove_dev_attr_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct attribute *attrs[] = {
 		&con->features_attr.attr,
+		&con->version_attr.attr,
+		&con->schema_attr.attr,
 		NULL
 	};
 	struct attribute_group group = {
@@ -1459,7 +1477,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
 	if (amdgpu_bad_page_threshold != 0)
 		amdgpu_ras_sysfs_remove_bad_page_node(adev);
 
-	amdgpu_ras_sysfs_remove_feature_node(adev);
+	amdgpu_ras_sysfs_remove_dev_attr_node(adev);
 
 	return 0;
 }
@@ -1582,6 +1600,10 @@ static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
 		amdgpu_ras_sysfs_badpages_read, NULL, 0);
 static DEVICE_ATTR(features, S_IRUGO,
 		amdgpu_ras_sysfs_features_read, NULL);
+static DEVICE_ATTR(version, 0444,
+		amdgpu_ras_sysfs_version_show, NULL);
+static DEVICE_ATTR(schema, 0444,
+		amdgpu_ras_sysfs_schema_show, NULL);
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1590,6 +1612,8 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 	};
 	struct attribute *attrs[] = {
 		&con->features_attr.attr,
+		&con->version_attr.attr,
+		&con->schema_attr.attr,
 		NULL
 	};
 	struct bin_attribute *bin_attrs[] = {
@@ -1598,11 +1622,20 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 	};
 	int r;
 
+	group.attrs = attrs;
+
 	/* add features entry */
 	con->features_attr = dev_attr_features;
-	group.attrs = attrs;
 	sysfs_attr_init(attrs[0]);
 
+	/* add version entry */
+	con->version_attr = dev_attr_version;
+	sysfs_attr_init(attrs[1]);
+
+	/* add schema entry */
+	con->schema_attr = dev_attr_schema;
+	sysfs_attr_init(attrs[2]);
+
 	if (amdgpu_bad_page_threshold != 0) {
 		/* add bad_page_features entry */
 		bin_attr_gpu_vram_bad_pages.private = NULL;
@@ -2594,6 +2627,14 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
+{
+	return  (amdgpu_ras_is_poison_mode_supported(adev) << (ffs(AMDGPU_RAS_ERROR__POISON) - 1)) |
+			AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE |
+			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE |
+			AMDGPU_RAS_ERROR__PARITY;
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2636,6 +2677,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	con->update_channel_flag = false;
 	con->features = 0;
+	con->schema = 0;
 	INIT_LIST_HEAD(&con->head);
 	/* Might need get this flag from vbios. */
 	con->flags = RAS_DEFAULT_FLAGS;
@@ -2691,6 +2733,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_query_poison_mode(adev);
 
+	/* Get RAS schema for particular SOC */
+	con->schema = amdgpu_get_ras_schema(adev);
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7999d202c9bc..728f98c6fc1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -389,9 +389,12 @@ struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
 	uint32_t features;
+	uint32_t schema;
 	struct list_head head;
 	/* sysfs */
 	struct device_attribute features_attr;
+	struct device_attribute version_attr;
+	struct device_attribute schema_attr;
 	struct bin_attribute badpages_attr;
 	struct dentry *de_ras_eeprom_table;
 	/* block array */
-- 
2.42.0

