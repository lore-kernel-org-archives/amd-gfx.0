Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CCAC7EE43
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5DB10E43E;
	Wed,  7 Jun 2023 06:48:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CB410E43D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdU4irZAOXvL5W3YaQqI0xg8PNTjEBtfJ4trO3M8+hNN6eJDFS3NYuCorp6LcXCQf5fXpX7B82uUSpq2PQNiIA6EHgLt8cC7WvQygKAJivVFrwxRdmorc2i2TokekJzr78zWu6Z+LJV0+p2d6+skOTs90LvenGlmhnZE4P84l5HGMg68mQwtRWi+73S3Ter+6ifOGgPj1MP+FClisHkW29Dh5Lvgn2uNfBSSZrLc+fzxKm1jd9xeaEXF/dOYf7F1kN7Ij2L/MyxS3OSx5FWbfgTde4sqiUaS2NjZXvnlcAs63f2m1j1mh7kMSO4oEu7W3cr4sC/vGRArM6MFyoQNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBgk/lu4s6MaX6Ztkv7iYJiXVQFb19937p60a97hru0=;
 b=ZefIX0zrOv0ZZOuyKB592sKrUBOo4ezl0JokbW83qInGdhC9jO6Woua33R0vDUDXih+0QYsjz1lG3GA+ZWRBsVDaKZqot4U14m9oJeID0iJrgCLFuJdaRH0TUz2FjFufFaI9AzAPW/iftGUsDGFcrRfclO8oDNB8pJuCD/UcjyqMQArunv6jb8sxjKUOuk9h81zw1xhvvb61Eydr4UYboI939izrij1gBs9BPYjdy7aMLTEhiRBBdF+pa/4BW18VRYe6JR1e3lI5YRL2ZZjFuZCC+bBeJJIhYfgX8G3+RTpeXNFkZqxZcYD4p0ODhCUz01alY9wYgjN3OY4nSFnUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBgk/lu4s6MaX6Ztkv7iYJiXVQFb19937p60a97hru0=;
 b=bWrHLEBnzjjxzEb3FUBuVkRqXwQrtNF+1SGNgC1XDzSqZLaUuJfuMCQo4ml0sDFCIO0l2MmOhMa1qrTyG58PxkqJU2vN7cVdKLSSctUL7mE+yFsOeq5Te5qGwpeRW6pvpzXXUk9uZ6aBthcjUWs40TVBipoE7Nje6qRhhDx2TWs=
Received: from DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:48:30 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::a7) by DM6PR11CA0060.outlook.office365.com
 (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Wed, 7 Jun 2023 06:48:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:29 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:27 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 4/6] drm/amdgpu: Add support EEPROM table v2.1
Date: Wed, 7 Jun 2023 14:48:12 +0800
Message-ID: <20230607064814.27226-4-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607064814.27226-1-Stanley.Yang@amd.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 49512d43-ea4f-41d0-6530-08db6723342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2guoM5VyTbxVtlDuy+1IiT+FcKMz4JIjDPgWLWbm4Qtfs40EvbmywL5+T3l9HSZcddNJJW+OLWTWfSfuazvgMf09c52pHEqIgvexAvlBnsWw8bIgNCOwbHkVzdTLf+86ASejABBQC66V2RqoL8FMtADNEdHR9t8+gydvJ8HOFypdF5bxm3JwrRU9WN7AudkLAQ53lTPT7hTjYe/EO7Y1q0JTTvtxUjmL7kK098fB+t/huvOjacXLDor5cyxLhcVFz8pj6ZGo6x9RmmLIxdvOEI8FJFxPmKLFiDNXN+YvRpm9d1C3GrAtIDT9UetiW3CxHtIw0afBctKCqVY6Dq6hKAOrB7YbdDbSaFJd6qpf/W3A9yEHDyoZ0HQk9Wp5pSwo4RH7aSw6YAwLpmR9PKse1kwM3ABz6gzDe44IyOSnPCRch3eTVE7ckljPMPYrmWnu+wsGD0tVuVKeudnWXKQe+0tCcqXj3Gm/xLRmDUPO/uIPOidDJa/j1ghlLpkq3c2dEX70jBTOingzfVbqLyALwXxb2gRR17GsFX8WP9rmeAbEPz92qB+bXBBfvGeDGtDzpCf9wygCUJ1K+qREiRFbkwoZvCGpBvhxNOlGNJ2VmTWnQjby6DkUYIUXf1oDNEoMXmFy78Y5gpaRObbCJ7IBnwXqzF14t4sH4gEOowvXfvSgb2e3EuCrzG7K31Fs35QlEaITVRYOig2OHWcINWc0u+ajhBvgs3NEAHBLhNsk9ZtH586UUQfF0DVE65D3f8nHEM/b9Pt4SecZXdT6/Tn9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(26005)(1076003)(186003)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(2906002)(82310400005)(30864003)(7696005)(36860700001)(8936002)(8676002)(6666004)(40480700001)(478600001)(86362001)(5660300002)(82740400003)(6636002)(40460700003)(70586007)(41300700001)(70206006)(356005)(81166007)(316002)(110136005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:29.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49512d43-ea4f-41d0-6530-08db6723342a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
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

Add ras info to EEPROM table, app can analyse device ECC
status without GPU driver through EEPROM table ras info.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 204 ++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  12 +-
 3 files changed, 203 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index cc0b6115e530..617a05d80b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2314,7 +2314,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
-	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
+	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
 
 	/* Todo: During test the SMU might fail to read the eeprom through I2C
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e835f68d1ebb..7f134c3b0b14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -72,6 +72,20 @@
 /* Bad GPU tag ‘BADG’ */
 #define RAS_TABLE_HDR_BAD       0x42414447
 
+/**
+ * EEPROM Table structure v1
+ * ---------------------------------
+ * |                               |
+ * |     EEPROM TABLE HEADER       |
+ * |      ( size 20 Bytes )        |
+ * |                               |
+ * ---------------------------------
+ * |                               |
+ * |    BAD PAGE RECORD AREA       |
+ * |                               |
+ * ---------------------------------
+ */
+
 /* Assume 2-Mbit size EEPROM and take up the whole space. */
 #define RAS_TBL_SIZE_BYTES      (256 * 1024)
 #define RAS_TABLE_START         0
@@ -80,6 +94,26 @@
 #define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
 				 / RAS_TABLE_RECORD_SIZE)
 
+/**
+ * EEPROM Table structrue v2.1
+ * ---------------------------------
+ * |                               |
+ * |     EEPROM TABLE HEADER       |
+ * |      ( size 20 Bytes )        |
+ * |                               |
+ * ---------------------------------
+ * |                               |
+ * |     EEPROM TABLE RAS INFO     |
+ * | (available info size 4 Bytes) |
+ * |  ( reserved size 252 Bytes )  |
+ * |                               |
+ * ---------------------------------
+ * |                               |
+ * |     BAD PAGE RECORD AREA      |
+ * |                               |
+ * ---------------------------------
+ */
+
 /* EEPROM Table V2_1 */
 #define RAS_TABLE_V2_1_INFO_SIZE       256
 #define RAS_TABLE_V2_1_INFO_START      RAS_TABLE_HEADER_SIZE
@@ -242,6 +276,69 @@ static int __write_table_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
+static void
+__encode_table_ras_info_to_buf(struct amdgpu_ras_eeprom_table_ras_info *rai,
+			       unsigned char *buf)
+{
+	u32 *pp = (uint32_t *)buf;
+	u32 tmp;
+
+	tmp = ((uint32_t)(rai->rma_status) & 0xFF) |
+	      (((uint32_t)(rai->health_percent) << 8) & 0xFF00) |
+	      (((uint32_t)(rai->ecc_page_threshold) << 16) & 0xFFFF0000);
+	pp[0] = cpu_to_le32(tmp);
+}
+
+static void
+__decode_table_ras_info_from_buf(struct amdgpu_ras_eeprom_table_ras_info *rai,
+				 unsigned char *buf)
+{
+	u32 *pp = (uint32_t *)buf;
+	u32 tmp;
+
+	tmp = le32_to_cpu(pp[0]);
+	rai->rma_status = tmp & 0xFF;
+	rai->health_percent = (tmp >> 8) & 0xFF;
+	rai->ecc_page_threshold = (tmp >> 16) & 0xFFFF;
+}
+
+static int __write_table_ras_info(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	u8 *buf;
+	int res;
+
+	buf = kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
+	if (!buf) {
+		DRM_ERROR("Failed to alloc buf to write table ras info\n");
+		return -ENOMEM;
+	}
+
+	__encode_table_ras_info_to_buf(&control->tbl_rai, buf);
+
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_domain->sem);
+	res = amdgpu_eeprom_write(adev->pm.ras_eeprom_i2c_bus,
+				  control->i2c_address +
+				  control->ras_info_offset,
+				  buf, RAS_TABLE_V2_1_INFO_SIZE);
+	up_read(&adev->reset_domain->sem);
+
+	if (res < 0) {
+		DRM_ERROR("Failed to write EEPROM table ras info:%d", res);
+	} else if (res < RAS_TABLE_V2_1_INFO_SIZE) {
+		DRM_ERROR("Short write:%d out of %d\n",
+			  res, RAS_TABLE_V2_1_INFO_SIZE);
+		res = -EIO;
+	} else {
+		res = 0;
+	}
+
+	kfree(buf);
+
+	return res;
+}
+
 static u8 __calc_hdr_byte_sum(const struct amdgpu_ras_eeprom_control *control)
 {
 	int ii;
@@ -301,14 +398,27 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	mutex_lock(&control->ras_tbl_mutex);
 
 	hdr->header = RAS_TABLE_HDR_VAL;
-	hdr->version = RAS_TABLE_VER_V1;
-	hdr->first_rec_offset = RAS_RECORD_START;
-	hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+	if (adev->umc.ras &&
+	    adev->umc.ras->set_eeprom_table_version)
+		adev->umc.ras->set_eeprom_table_version(hdr);
+	else
+		hdr->version = RAS_TABLE_VER_V1;
+
+	if (hdr->version == RAS_TABLE_VER_V2_1) {
+		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+				RAS_TABLE_V2_1_INFO_SIZE;
+	} else {
+		hdr->first_rec_offset = RAS_RECORD_START;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+	}
 
 	csum = __calc_hdr_byte_sum(control);
 	csum = -csum;
 	hdr->checksum = csum;
 	res = __write_table_header(control);
+	if (!res && hdr->version > RAS_TABLE_VER_V1)
+		res = __write_table_ras_info(control);
 
 	control->ras_num_recs = 0;
 	control->ras_fri = 0;
@@ -587,9 +697,13 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 	}
 
-	control->tbl_hdr.version = RAS_TABLE_VER_V1;
-	control->tbl_hdr.first_rec_offset = RAS_INDEX_TO_OFFSET(control, control->ras_fri);
-	control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE + control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
+	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+		control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
+					    RAS_TABLE_V2_1_INFO_SIZE +
+					    control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
+	else
+		control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
+					    control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 	control->tbl_hdr.checksum = 0;
 
 	buf_size = control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
@@ -629,6 +743,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	csum = -csum;
 	control->tbl_hdr.checksum = csum;
 	res = __write_table_header(control);
+	if (!res && control->tbl_hdr.version > RAS_TABLE_VER_V1)
+		res = __write_table_ras_info(control);
 Out:
 	kfree(buf);
 	return res;
@@ -819,9 +935,12 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	return res;
 }
 
-uint32_t amdgpu_ras_eeprom_max_record_count(void)
+uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *control)
 {
-	return RAS_MAX_RECORD_COUNT;
+	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+		return RAS_MAX_RECORD_COUNT_V2_1;
+	else
+		return RAS_MAX_RECORD_COUNT;
 }
 
 static ssize_t
@@ -1063,8 +1182,14 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 	int buf_size, res;
 	u8  csum, *buf, *pp;
 
-	buf_size = RAS_TABLE_HEADER_SIZE +
-		control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
+	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+		buf_size = RAS_TABLE_HEADER_SIZE +
+			   RAS_TABLE_V2_1_INFO_SIZE +
+			   control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
+	else
+		buf_size = RAS_TABLE_HEADER_SIZE +
+			   control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
+
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf) {
 		DRM_ERROR("Out of memory checking RAS table checksum.\n");
@@ -1092,6 +1217,39 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 	return res < 0 ? res : csum;
 }
 
+static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	unsigned char *buf;
+	int res;
+
+	buf = kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
+	if (!buf) {
+		DRM_ERROR("Failed to alloc buf to read EEPROM table ras info\n");
+		return -ENOMEM;
+	}
+
+	/**
+	 * EEPROM table V2_1 supports ras info,
+	 * read EEPROM table ras info
+	 */
+	res = amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
+				 control->i2c_address + control->ras_info_offset,
+				 buf, RAS_TABLE_V2_1_INFO_SIZE);
+	if (res < RAS_TABLE_V2_1_INFO_SIZE) {
+		DRM_ERROR("Failed to read EEPROM table ras info, res:%d", res);
+		res = res >= 0 ? -EIO : res;
+		goto Out;
+	}
+
+	__decode_table_ras_info_from_buf(rai, buf);
+
+Out:
+	kfree(buf);
+	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
+}
+
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			   bool *exceed_err_limit)
 {
@@ -1114,8 +1272,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		return -EINVAL;
 
 	control->ras_header_offset = RAS_HDR_START;
-	control->ras_record_offset = RAS_RECORD_START;
-	control->ras_max_record_count  = RAS_MAX_RECORD_COUNT;
+	control->ras_info_offset = RAS_TABLE_V2_1_INFO_START;
 	mutex_init(&control->ras_tbl_mutex);
 
 	/* Read the table header from EEPROM address */
@@ -1129,12 +1286,27 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	__decode_table_header_from_buf(hdr, buf);
 
-	control->ras_num_recs = RAS_NUM_RECS(hdr);
+	if (hdr->version == RAS_TABLE_VER_V2_1) {
+		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
+		control->ras_record_offset = RAS_RECORD_START_V2_1;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+	} else {
+		control->ras_num_recs = RAS_NUM_RECS(hdr);
+		control->ras_record_offset = RAS_RECORD_START;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+	}
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->ras_num_recs);
+
+		if (hdr->version == RAS_TABLE_VER_V2_1) {
+			res = __read_table_ras_info(control);
+			if (res)
+				return res;
+		}
+
 		res = __verify_ras_table_checksum(control);
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
@@ -1148,6 +1320,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 					ras->bad_page_cnt_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
+		if (hdr->version == RAS_TABLE_VER_V2_1) {
+			res = __read_table_ras_info(control);
+			if (res)
+				return res;
+		}
+
 		res = __verify_ras_table_checksum(control);
 		if (res)
 			DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 069249249c76..3c5575c19bf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -46,9 +46,18 @@ struct amdgpu_ras_eeprom_table_header {
 	uint32_t checksum;
 } __packed;
 
+struct amdgpu_ras_eeprom_table_ras_info {
+	u8  rma_status;
+	u8  health_percent;
+	u16 ecc_page_threshold;
+	u32 padding[64 - 1];
+} __packed;
+
 struct amdgpu_ras_eeprom_control {
 	struct amdgpu_ras_eeprom_table_header tbl_hdr;
 
+	struct amdgpu_ras_eeprom_table_ras_info tbl_rai;
+
 	/* Base I2C EEPPROM 19-bit memory address,
 	 * where the table is located. For more information,
 	 * see top of amdgpu_eeprom.c.
@@ -61,6 +70,7 @@ struct amdgpu_ras_eeprom_control {
 	 * right after the header.
 	 */
 	u32 ras_header_offset;
+	u32 ras_info_offset;
 	u32 ras_record_offset;
 
 	/* Number of records in the table.
@@ -127,7 +137,7 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     struct eeprom_table_record *records, const u32 num);
 
-uint32_t amdgpu_ras_eeprom_max_record_count(void);
+uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
-- 
2.17.1

