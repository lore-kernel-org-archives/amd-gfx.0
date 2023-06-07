Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1731C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B3F10E43D;
	Wed,  7 Jun 2023 06:48:38 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48F610E440
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxSztJ+Eo4FvHS/IroxKE6LaHqfXuH/1NXO2EuVO3/SpsGe7R97XEeeBamie49PywDv86exRTjBOOZX/tAP1GhWpS0RLOqjcblJo9FWGVF5ULjNuhh2163Ixh5r2Bm/tzTtmNev4MwRUsWxw/1n3KukjrVvN+PLGPh/szJxxOTsL+y2IeZpGwcjtBuhq0Yntngf2WkxSazct9jMhvFAsGKpC36w9Sg5DYE5vs81cwHLjSsRcxOyuRB+NVIJpryoKqte+8+Yxa/m+XQ72eYvoxCBk6RjVFXgpfwoZ2s6Xn6mgP+fOjKZOjV6R2GqHl/IaL3ry9tdC6+7qqP3z7Pr6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyCyKrJmM/nULWAG1KEgyWqpjCcrB0x6W/rxoxJAS4g=;
 b=AmbUgkEYID9U+Y1WeX/njQqbb6efJbjb/LE4icCrjP/ORzKfIm76VZDPdfGaJX0jWLYsywdJVtnxlPd11FrWpWR3kGEd5y3aS2qVd/5hdN5MfPkfwppio+zOGfUwvN+qQY3+438ehZNWEeH4iESwaLuaYC7Q+NujnCxc7wqWgwAM51Bl+8ljbYX79UNyRhYwhT6vh5JH4zSNIIK9kqENfo9j/yGa5uztVALxk6auA0g0EASQg4/BuQiTW6E5nP+mmu+q7ynMN85Yh2NOrlh4FBwyFvuxgZL3gPDc0KR4c44GDV+fLGzu3hBD4bU9AaIwnVxHujUtx/sdN2YPnRgRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyCyKrJmM/nULWAG1KEgyWqpjCcrB0x6W/rxoxJAS4g=;
 b=h0eJAgCNAoUvoM1mxSepLQHRGd4aTStZ4tLM7GanvEI7yXiENFpm3vCe125E3TZutwMcyyp47v60gHh8DeSsmj+nczCXhtS5v+5Kc+5AyiSKnot/IbpaE9emXyB2Ckm0QVaITGlYqtWVqkPCyoPMuxp3MqxAfV7mdiawG9T2BAs=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:48:34 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::cf) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 06:48:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:33 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:31 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 6/6] drm/amdgpu: Set EEPROM ras info
Date: Wed, 7 Jun 2023 14:48:14 +0800
Message-ID: <20230607064814.27226-6-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607064814.27226-1-Stanley.Yang@amd.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e259d8-1c00-4792-e22f-08db67233688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qC37UndrnlS6UMkXt+W4dce3O7TtHNZ/3hdbbteZ9qGPUzr+soBFfFFQDDkRHz/nZK2fs3PQyGcvoNbstWdsD+xvBWRdyUH8SUxPZbC/9d94IeQKRKUDgwjDkXZG4E/9FX/3qyfZuzsRmTJsnqIN4QpSlcCSH9eK1sPuMDGSXdSkQoMoGlU3UCdFoqGtx9O+9cFdSYx0xGCNu9K1B5cbvNLeV7ibz+tbfCQIBogBpCM/VPGqazaW2cEyEepWE8WhYzkxBMBxT8y2Wv2H5KPk8sWybj81GYsOIUmh5LZ7kCsG/SBhNQSYy2ZGNCZZvN2bklDiUYsox3E96rU3BWhWLiABr3NptsxaQuPsd5Ge7ULAZ5FhuyynZLoziHTQ74KjHrASnWJqG5CRHFhmQtpg1lQqS49S3Npxj+P6Isa024yoh9qjghqe1pp1ez97CK9i8u3+t9lw37kewzoOW1G/WoDn6PaeqU93Hfqsm2urNLEG5E522QlACi11NBJzDhCU0lYkgdl+fw4pKg833bmobQpPoDPy1LzsvlUlUW2tI23lxWzI6Sq5zS/z4/Dopr8fNX8ckc9c+sZvGysd3g8WDCqoEMX90YDh8zpXWke1dRJJUbOiyWpqDylCxDmzIlcLOQgYEaKvGyUWxfy2rBl7fVWgX7wgufPsu/+kv5Delkv+NMZnNq5NTYf05AHTsJtzBOetGK8uSAQ6OJ5JTEdjrkNXzp068wYsmFEuzkpmKd507YW1oo8RdjIdx7Mb+yihpSyJSrIGvoV5wJlYV8/q3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(336012)(426003)(82740400003)(110136005)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(70586007)(70206006)(356005)(81166007)(5660300002)(4326008)(86362001)(40460700003)(6636002)(7696005)(36756003)(6666004)(2906002)(36860700001)(82310400005)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:33.8576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e259d8-1c00-4792-e22f-08db67233688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set EEPROM ras info: rma status, health percent and bad
page threshold.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  5 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9eceb3bc1058..c2e8f6491ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -406,6 +406,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	u8 csum;
 	int res;
@@ -423,6 +424,14 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
 		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
 				RAS_TABLE_V2_1_INFO_SIZE;
+		rai->rma_status = GPU_HEALTH_USABLE;
+		/**
+		 * GPU health represented as a percentage.
+		 * 0 means worst health, 100 means fully health.
+		 */
+		rai->health_percent = 100;
+		/* ecc_page_threshold = 0 means disable bad page retirement */
+		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
 	} else {
 		hdr->first_rec_offset = RAS_RECORD_START;
 		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
@@ -712,6 +721,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_recs, ras->bad_page_cnt_threshold);
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
+		if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1) {
+			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
+			control->tbl_rai.health_percent = 0;
+		}
 	}
 
 	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
@@ -749,6 +762,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		goto Out;
 	}
 
+	/**
+	 * bad page records have been stored in eeprom,
+	 * now calculate gpu health percent
+	 */
+	if (amdgpu_bad_page_threshold != 0 &&
+	    control->tbl_hdr.version == RAS_TABLE_VER_V2_1 &&
+	    control->ras_num_recs < ras->bad_page_cnt_threshold)
+		control->tbl_rai.health_percent = ((ras->bad_page_cnt_threshold -
+						   control->ras_num_recs) * 100) /
+						   ras->bad_page_cnt_threshold;
+
 	/* Recalc the checksum.
 	 */
 	csum = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 3c5575c19bf8..6dfd667f3013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -31,6 +31,11 @@
 
 struct amdgpu_device;
 
+enum amdgpu_ras_gpu_health_status {
+	GPU_HEALTH_USABLE = 0,
+	GPU_RETIRED__ECC_REACH_THRESHOLD = 2,
+};
+
 enum amdgpu_ras_eeprom_err_type {
 	AMDGPU_RAS_EEPROM_ERR_NA,
 	AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
-- 
2.17.1

