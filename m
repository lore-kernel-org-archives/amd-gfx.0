Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90277C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 06:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A9C10F568;
	Fri,  4 Mar 2022 06:51:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755C710F568
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 06:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCtY2M9N64UDDhiRBbvQihtbxFQ18GwW7phTuib/7cNqf92Kka1a/wqnZ2R75kmYNUXdOyI7mZh39TyTfjPSTCE5tH3KdmlUo/OJ+qDx8z8geGjf5Laxfm+3TPVHS4UopZpwioSMpHzqNk33VHaDRvUzWn2Fs3fH2w77w4jctvQI6PfBKQ2mg4bI1/3gMo9FwyM/QZZnO5W/PQakAFOuiE7/AcnE3hC9dhYhnc9lsxJhvG185LSpph1bgXFer1zjUp2LoT41WN1HC/Bu/50n6o/SM5upYVj5ogXr0Z53bcvOcnqBn0YZRaq0ZkN58eOaH1uvgMF++bHWG8SPWICCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ncIp5OnTV74L7f+WeipsJw5Db24aAZ7nIOaXzOruFQ=;
 b=lXStYZg+aob0ybVM4ToIi528PoVqoTC7+PWOUCTANhkOxhAdUh04DVjuITUl5xhNIUJtaYilLFbJMHB+6bawae6hYoyQgsxfPvHMjKr7OGzYgU5ACGNOIWM0H98Sf61YvTdZ4woT3reB2YpuOhJ/5Phfb+AIUMK6iWGhThJUPx+dlFfl4jtpAsOzLYl+0ChvT9/c+PZ+V2bBVDjCAYRCqG0Pl2KrDB9rJfpbvdjvY0IKbe6gUE4PHFL+QfdQYLL1D1fwxeyGW1vL6niNNHGYls2ShyBD1CHkAeE+BR7jHdAcK3cmcmTS1SZ6YsHNyGRYiANq3LslojGPGYSZeoLWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ncIp5OnTV74L7f+WeipsJw5Db24aAZ7nIOaXzOruFQ=;
 b=ZDMx+g7BwcMTw7/sagtLdpqo6xtS3p63qDd/O//3fMblS87MrJ5TaEpzGs7BJJ9aqgxBpALI98P8//TbLgf6SAfwLlsFKk0FjRWSwsz3QPO2E7RIfkpCtK35PFkJ15jnTs5oMlI1BZULIBD5B4xiuPEAm+q+3YhID3xw4P1sHTM=
Received: from DM6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:100::41)
 by MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:50:53 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::df) by DM6PR03CA0064.outlook.office365.com
 (2603:10b6:5:100::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 06:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:50:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 00:50:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 00:50:51 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 00:50:50 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Maria.Joo@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: message smu to update bad channel info
Date: Fri, 4 Mar 2022 14:50:37 +0800
Message-ID: <20220304065037.1050-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304065037.1050-1-Stanley.Yang@amd.com>
References: <20220304065037.1050-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b025d0b-e1b9-463d-dabc-08d9fdab532e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB153667001C2ED071FB2314529A059@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIAwbTQa4BOqegwPwtPbFnoLXKOYQhTvv5T+ThBdggUluTTkL10G9hDsFlunRMdtGN8xKCvGyS6Um+GDwZRXTxoj2IMGvbPixubIv0/ULE9gNFO5lmO6k5egpr7nC3Y3vkaNu+WxpzyklmERLunym2es9zfsB8eAtrQksTeeuWkLY9nNzRGp22QxDQ11HiaayMlMKwYeuPraFf4NG1Bj+mDpRQmwgrekYXrM1L9wE5vTzYg8tkqvv+vjNDSYPUIQRCCqAICs+ebSF8s6VJ1ERwdFup1KwQXF0CHjsc3mZQ5s9wj5EWnIoMByO27/LgylNRjjdqCEuNMA5bSmUGGPk22qztSmXzUYclrLvsR4tImNgL+dVyS2pQNAS5rdfU9GA2l/gPLf+2n7+IAhSlOg7leZA7Mpl663FOxxpk0sU+9NwA4v3aFI9+rsuM+zePOgz3XejcQRQeN7NM9zb8z4ynm5IrQEuegLj9zM3fQz+Gl3Q4bvBivGaY5CbguRkgnZzlynBEDWvqWtH1OMTn8Zjk11aikf/mRGwWOt4XrdMBIvDF2Te5SA11VOpZfM7jiCyoawYrJVZ2fInmAx2VLOjMOFUO2rQYQIcDKt2dz6F/5iyBxhJ0wYdUYe1n7mOoDVg+AEA+msWT0dv8rUdzic4SrBoGRtVJAwC5zKAC0ZKoQx90aTUJ9LQWICXUGmlfZoa/hvYxlul16hDfVM9iOlBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(15650500001)(81166007)(6636002)(40460700003)(7696005)(316002)(8936002)(6666004)(36860700001)(426003)(336012)(26005)(186003)(47076005)(83380400001)(86362001)(5660300002)(36756003)(2906002)(110136005)(508600001)(70586007)(82310400004)(4326008)(2616005)(1076003)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:50:52.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b025d0b-e1b9-463d-dabc-08d9fdab532e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
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

It should notice SMU to update bad channel info when detected
uncorrectable error in UMC block

Change-Id: I2dc8848affdb53e52891013953ae9383fff5f20f
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 ++++
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d3875618ebf5..f9104f99eb9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2068,6 +2068,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
+	con->eeprom_control.bad_channel_bitmap = 0;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
@@ -2092,6 +2093,11 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 			goto free;
 
 		amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
+
+		if (con->update_channel_flag == true) {
+			amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
+			con->update_channel_flag = false;
+		}
 	}
 
 #ifdef CONFIG_X86_MCE_AMD
@@ -2285,6 +2291,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	con->update_channel_flag = false;
 	con->features = 0;
 	INIT_LIST_HEAD(&con->head);
 	/* Might need get this flag from vbios. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7cddaad90d6d..9314fde81e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -374,6 +374,9 @@ struct amdgpu_ras {
 
 	/* record umc error info queried from smu */
 	struct umc_ecc_info umc_ecc;
+
+	/* Indicates smu whether need update bad channel info */
+	bool update_channel_flag;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2b844a5aafdb..ad5d8667756d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -265,6 +265,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	u8 csum;
 	int res;
 
@@ -285,6 +286,10 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 	amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_recs);
 
+	control->bad_channel_bitmap = 0;
+	amdgpu_dpm_send_hbm_bad_channel_flag(adev, control->bad_channel_bitmap);
+	con->update_channel_flag = false;
+
 	amdgpu_ras_debugfs_set_ret_size(control);
 
 	mutex_unlock(&control->ras_tbl_mutex);
@@ -418,6 +423,7 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 			       struct eeprom_table_record *record,
 			       const u32 num)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(to_amdgpu_device(control));
 	u32 a, b, i;
 	u8 *buf, *pp;
 	int res;
@@ -429,9 +435,16 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 	/* Encode all of them in one go.
 	 */
 	pp = buf;
-	for (i = 0; i < num; i++, pp += RAS_TABLE_RECORD_SIZE)
+	for (i = 0; i < num; i++, pp += RAS_TABLE_RECORD_SIZE) {
 		__encode_table_record_to_buf(control, &record[i], pp);
 
+		/* update bad channel bitmap */
+		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
+			con->update_channel_flag = true;
+		}
+	}
+
 	/* a, first record index to write into.
 	 * b, last record index to write into.
 	 * a = first index to read (fri) + number of records in the table,
@@ -684,6 +697,7 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 			   const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int i, res;
 	u8 *buf, *pp;
 	u32 g0, g1;
@@ -751,8 +765,15 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	/* Read up everything? Then transform.
 	 */
 	pp = buf;
-	for (i = 0; i < num; i++, pp += RAS_TABLE_RECORD_SIZE)
+	for (i = 0; i < num; i++, pp += RAS_TABLE_RECORD_SIZE) {
 		__decode_table_record_from_buf(control, &record[i], pp);
+
+		/* update bad channel bitmap */
+		if (!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
+			con->update_channel_flag = true;
+		}
+	}
 Out:
 	kfree(buf);
 	mutex_unlock(&control->ras_tbl_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 6bb00578bfbb..54d9bfe0881d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -80,6 +80,10 @@ struct amdgpu_ras_eeprom_control {
 	/* Protect table access via this mutex.
 	 */
 	struct mutex ras_tbl_mutex;
+
+	/* Record channel info which occurred bad pages
+	 */
+	u32 bad_channel_bitmap;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 85da6cbaf3b7..aad3c8b4c810 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -97,6 +97,11 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 			amdgpu_ras_save_bad_pages(adev);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
+
+			if (con->update_channel_flag == true) {
+				amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
+				con->update_channel_flag = false;
+			}
 		}
 
 		if (reset)
-- 
2.17.1

