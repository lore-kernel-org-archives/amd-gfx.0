Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E2E81E1A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 16:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0392C10E53C;
	Fri,  6 Oct 2023 16:35:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E77210E53B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 16:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg1DrIQq6V9mTxiqxwDyJkiuPOXB5I3JgcDaAxunrTJ2XLCh98sBJro6MI0sfWy4Icl0QpcsMpKiCMwQ3FzTdR7ieVNRfNJQM8pOGvHBwlY4Jx2vW4x1Oy2FZXKE/T5WflCSSM+q2yj5uVfneS87T+mlVtR9UzVKMwsJ6WEbNjbT+v829tLK4fo0VuYPoi6F4OQfJAM336oDXmy86++ShJaG2bFDl16Sa6GpXFEzeRFfS6FKkO0bQdaBclbx4glzCHTgi+GmZq0fwP4LkxoFO3vYcapxnKRPnfPd8NriiecOEKF7hxX+Qyxw0+qHMdEi3nz/b/TwEks8QubsvZ0c0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3np9L/I7EP1Iohpsnl+bKmlVeQOtdio5I7cs8YGGMcg=;
 b=lWmL+L69cUE6mMBKZ6ZWthxc2UmRpIR/VxgF4qYrlVmLQ/xYcUOAAHPIRcGqncG0teb9UTeFPRGKArxlUYOHMFvB3WWBhxRkmni4sCXwNKTTgDEPbb1WM67JYiK6JJ3JPo8IGr0eh+81aAU1UGMih3S+dN5g0es3loAOwhBsBxZTMavHBBw1ToxlIfrEYBZ7RCtKXgjcMjrUnaTyM7PjK6z+YmIjIu5dNlbzFGL+1Eec+UWATA4rcm8sebDL1Idq97oOfnTDEXRQfk/RgxG5ahdl6IbpCi4h9xWiZXhtygzr16mzQ5sQwXDYLIeuxiWdIKfYolRGne+E7AMp9Q0LnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3np9L/I7EP1Iohpsnl+bKmlVeQOtdio5I7cs8YGGMcg=;
 b=saXAvLe0A/6lSxYOcWNTn6l7CAktYLfUoucU4VfK/wjb1Z21nzwmLQevoYRckSxQMnPIeWXff64G0fseozaTAdxYEpRdA1Ac5S1M3C0dV2yYwSeivJ16qzvkXWhTuSXIQdzdtKwLS4tVCmcwOj5KggpEz9IIMEltUWoIwotk1i0=
Received: from BL1PR13CA0070.namprd13.prod.outlook.com (2603:10b6:208:2b8::15)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 16:34:57 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::6f) by BL1PR13CA0070.outlook.office365.com
 (2603:10b6:208:2b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 16:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 16:34:56 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 11:34:54 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Expose ras version & schema info
Date: Sat, 7 Oct 2023 00:34:41 +0800
Message-ID: <20231006163441.566840-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: a054f33d-4a68-47dc-9cb9-08dbc68a2cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8JQVJH2XrNvKlEiAvkI9FDFdNIace7YBRrNdWg29Z3+fhw/iP6IQiHdOErnZi+srfEhCIL/9Yk0IjC++iWrrpskEDiiyTQkHcS8RRGffDyCjgsD+o/eerfD5PbVkX6YbViTcKKD1k7rPlQ6rTmQQ1I7Q0TCp0UnZYiopCesVhADY39kAPB6p1rT/7nCk3hTW2x1g5TK8cOKO3VW+FWjXp5TjiBEWeUrGu+ksWoI9uGyxjTqo4v32onctZLWOLsCcRN2c2E6tmSBybwMGoRXxnlGFChHGsAS56+WtKq53xJu8Yrw+5Yhe1oCuRAEwiewSSEf65TGC2xvnRI6iVCLlXfsInbpG8qOqTpqDNkHrbP5eFbgSly5jKsSq8XEqFl2ceqaAy+xwpl5BthqKRbu9I3Aii6B1teGLxZXzsHegFt0eX/0YOtLYqrMme+jUkKp9BukQv90z2XZg3uAhkFxmIecr3sFpdcEE2uYpTKPi839Bm7tkJYSbGvmbzmIXBSWMyyiLIU9kEodgt7cg2Dp2xMSRTiRlJdHn5T+uOzM/7DbGpV1iS+kcB6/xNUyiLxEZF15kTtheWss5KwCrVFNQtgtSWKNZ9RI1+OnHM5hjw5jjMo0RscaxMxNceaqlJnukhv2CnCwBakum38GxvVvxczediE/TKDAN/yIAheb0RRX2f9IjgsoDRLDgBAwogid6Ntil0vd9rccZwkLd0Bmy7NSMeFf6mLqCYVZ7wpdDSYIykFIbUpoCyl0l77TQPfZj6iF/1T7yjeAwvMHJxFGyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(8676002)(54906003)(16526019)(70206006)(40480700001)(70586007)(316002)(426003)(26005)(36860700001)(336012)(2616005)(1076003)(6916009)(5660300002)(40460700003)(44832011)(83380400001)(47076005)(8936002)(356005)(36756003)(82740400003)(4326008)(86362001)(81166007)(2906002)(41300700001)(6666004)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:34:56.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a054f33d-4a68-47dc-9cb9-08dbc68a2cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 11 +++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9c8203e87859..362e32350af7 100644
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
@@ -2594,6 +2627,21 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_asic_supported(adev)) {
+		switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+		case IP_VERSION(13, 0, 6):
+			return AMDGPU_RAS_POISON_SUPPORTED | AMDGPU_RAS_SBC_SUPPORTED |
+				AMDGPU_RAS_DED_SUPPORTED | AMDGPU_RAS_PARITY_SUPPORTED;
+		default:
+			return 0;
+		}
+
+	} else
+		return 0;
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2636,10 +2684,14 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	con->update_channel_flag = false;
 	con->features = 0;
+	con->schema = 0;
 	INIT_LIST_HEAD(&con->head);
 	/* Might need get this flag from vbios. */
 	con->flags = RAS_DEFAULT_FLAGS;
 
+	/* Get RAS schema for particular SOC */
+	con->schema = amdgpu_get_ras_schema(adev);
+
 	/* initialize nbio ras function ahead of any other
 	 * ras functions so hardware fatal error interrupt
 	 * can be enabled as early as possible */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7999d202c9bc..ebd53736606c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -38,6 +38,14 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_INST_MASK 0xfffff000
 #define AMDGPU_RAS_INST_SHIFT 0xc
 
+/* Bit mask for RAS error types, SBC=Single bit correctable error
+ * DED =  Double Bit error detection
+ */
+#define AMDGPU_RAS_PARITY_SUPPORTED BIT(0)
+#define AMDGPU_RAS_SBC_SUPPORTED BIT(1)
+#define AMDGPU_RAS_DED_SUPPORTED BIT(2)
+#define AMDGPU_RAS_POISON_SUPPORTED BIT(3)
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
@@ -389,9 +397,12 @@ struct amdgpu_ras {
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

