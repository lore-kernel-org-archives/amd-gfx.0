Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFFEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 13:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EA910EDF6;
	Tue,  1 Mar 2022 13:30:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5920410EDBC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 13:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knDYFUO9scdmE8vy6utvEkS9O7U+UcQIopr6wJFZvDLMdu0Ue8jafSbHmJJvZBwJw/PEMT6n/Golh8bdSw4Pwa4Qtmx1uvEZoqVWH70SrkcsSymPGRq8zOarMIy9bWA/+GYBEFFEM9VqaAg5H+J9XWUUFak4DBmYY1+QsF2RugSjLwfu9LWS1cxo0MXYIlKJFkTe6E6vJyh5vv/hGDz5/05ji4aHOx6kNIuugaYibN6KMK3ao5k2ro5J8pP4JvA7JB52P+PdN2xligTxhrZpyusLGI3k9Kh/BYMm4iIwlyi+2kJ6uUWiG7KVSJ/s8b6WnAGuXZOW9ZagEEDSK4tEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmaiaNHATicyXrorgM+cuNIxoqINmNxvDgYO0Nb/BDU=;
 b=N5T7lJn/9ZKJzvMeUOSkzhIVsP8n6mqAkC+ProMhMkZz6hmQbQizTknk9sX8m28eRlKYw12zyjC04XHG7pQnh0FqYz7qN/b3GvNMsokFmExRbfb28zpmz8SNbJIvuFkR4vlyUUfrubV8713zjMN67WSq0BnIEnaHtb7xECYUrVnkYFNN/YcA8J40DYwKoER9+36uhBidxLkJGkSSee/OZGfc/lVDa2DkFP0gzueUrWgl5d/YLXvxqtOAtaiEPyGmNKx+cGZj1R+KqQHnfAaw5Dhgs9awsxX0TadMaEZ4rzLKfW/F4yT/f1yfeFpurX9RyrSt2w8OpU5AjoaRkk04JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmaiaNHATicyXrorgM+cuNIxoqINmNxvDgYO0Nb/BDU=;
 b=QPn4pKb2dbKgSi7MnoqekXUzWjwR1IFexB6OE8VUEXPRyfTutC3vXaNn0tKFfvuWYrOZOERulJRo1WY26omIdASpi0MXcfYWqkFEEsj+Dhx87MIhltbrfUv/i83dOPEG11e8nsSw7dFlHQeDzIv1k7AWlmeAlVUqb3Jv2rvH8gE=
Received: from DS7PR03CA0118.namprd03.prod.outlook.com (2603:10b6:5:3b7::33)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 13:30:27 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ba) by DS7PR03CA0118.outlook.office365.com
 (2603:10b6:5:3b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Tue, 1 Mar 2022 13:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 13:30:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 07:30:25 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 1 Mar 2022 07:30:24 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Maria.Joo@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: support send bad channel info to smu
Date: Tue, 1 Mar 2022 21:30:22 +0800
Message-ID: <20220301133022.17602-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ce333f-2399-4433-8acb-08d9fb87a58b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45788590C0E26C393C11D7579A029@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hbawumyRO/dW90C9h4vV2svpqCRV+PS0OLfWYDonr/X4fIiGRYpvseDZqbfp4e3VJ9Lz1rX0NZxCGEJolDpTtBrb5An7ThN7UXl/qnLPaSH5DCpCX+1Xe8RdW0IeDMBYFHK13Df0/1inF3w7cxo6qWgMjSf/3S9xYD+IqaoSRnx00ZoPtrb1CpqQMNyc2YB+PK5X803YuwuCLZvYHvc44T9Jdg+SLAJ5g9Ne1HaqDIBnRXCaoOJzMSMP07mvuj48bsfo/m/f33bI9ZnylQvN69kqigV6Vmst6hfra7AM7+P4vH9n0wGjMaRP819vYstHH/0IOC+krkAW5GBU5EXzm8eIcqUn3MHtZNnh5EQiEjjGne4tbFXmOnZs6fOHGMJpfRcZRQp/c3A02otmFYEKvhCXU2C46fMzP97iZ0P1W/uxyrGEY+VYaAbA4kUSvDOWPNpy0vIxavMhwQEVkw+4iyf7MLDJP6lahRgL5sncTJcZu2SMRbIzQmPc4/6u85bHpsiRpNuIX2KaH6lze4NUuwwfA0fHcJH15mBrskJ1h6VaFyFdgXe4D9pcfFqE/vjwqlKKq8NN9UWBpjsDAH+SQJGqE/h6XGNWHze3kWJzy1V1bhS2bTGdxfFIJ71nt/bOrHitDrPH8MLn7fWvUAIS3jpcaMqzYnxcvDQKsydHEHqiHNapSNZtZ/GUiAhdBLcnbZOIq/BVA7nquk+kXnYVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(4326008)(110136005)(6636002)(26005)(36756003)(1076003)(70206006)(5660300002)(30864003)(86362001)(8936002)(316002)(40460700003)(8676002)(70586007)(36860700001)(7696005)(356005)(81166007)(2616005)(82310400004)(186003)(426003)(336012)(47076005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 13:30:26.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ce333f-2399-4433-8acb-08d9fb87a58b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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

Message SMU bad channel information bitmap to update OOB table

Change-Id: I49a79af64d5263c28db059ecb8b8405a471431b4
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 ++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 12 ++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
 .../pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 43 +++++++++++++++++++
 12 files changed, 119 insertions(+), 4 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1d63f1e8884c..9a892d6d1d7a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -507,6 +507,18 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 	return ret;
 }
 
+int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_send_hbm_bad_channel_flag(smu, size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ddfa55b59d02..3e78b3057277 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -412,6 +412,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
 int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable);
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size);
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				       enum pp_clock_type type,
 				       uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7e79a67bb8ef..f1544755d8b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3052,3 +3052,13 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size)
 
 	return ret;
 }
+
+int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->send_hbm_bad_channel_flag)
+		ret = smu->ppt_funcs->send_hbm_bad_channel_flag(smu, size);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fbef3ab8d487..ef57b6089c69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1292,6 +1292,12 @@ struct pptable_funcs {
 	 * @set_config_table: Apply the input DriverSmuConfig table settings.
 	 */
 	int (*set_config_table)(struct smu_context *smu, struct config_table_setting *table);
+
+	/**
+	 * @sned_hbm_bad_channel_flag:  message SMU to update bad channel info
+	 *										of SMUBUS table.
+	 */
+	int (*send_hbm_bad_channel_flag)(struct smu_context *smu, uint32_t size);
 };
 
 typedef enum {
@@ -1428,5 +1434,6 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
 void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
+int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
index ab66a4b9e438..0f498baf6838 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
@@ -103,7 +103,8 @@
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
 #define PPSMC_MSG_HeavySBR                      0x45
-#define PPSMC_Message_Count			0x46
+#define PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel	0x46
+#define PPSMC_Message_Count			0x47
 
 
 //PPSMC Reset Types
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index d787c3b9fc52..9f6f306eeca0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -232,7 +232,8 @@
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
 	__SMU_DUMMY_MAP(Spare0),                  \
 	__SMU_DUMMY_MAP(UnforceGfxVid),           \
-	__SMU_DUMMY_MAP(HeavySBR),
+	__SMU_DUMMY_MAP(HeavySBR),			\
+	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 890acc4e2cb8..e5e249968244 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -82,6 +82,12 @@
  */
 #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
 
+/*
+ * SMU support BAD CHENNEL info MSG since version 68.51.00,
+ * use this to check ECCTALE feature whether support
+ */
+#define SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
+
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -140,6 +146,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
 	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,                        0),
+	MSG_MAP(SetBadHBMPagesRetiredFlagsPerChannel,	PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel,	0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -1997,6 +2004,41 @@ static int aldebaran_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
+static int aldebaran_check_bad_channel_info_support(struct smu_context *smu)
+{
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret) {
+		/* return not support if failed get smu_version */
+		ret = -EOPNOTSUPP;
+	}
+
+	if (smu_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
+		ret = -EOPNOTSUPP;
+
+	return ret;
+}
+
+static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
+		uint32_t size)
+{
+	int ret = 0;
+
+	ret = aldebaran_check_bad_channel_info_support(smu);
+	if (ret)
+		return ret;
+
+	/* message SMU to update the bad channel info on SMUBUS */
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetBadHBMPagesRetiredFlagsPerChannel, size, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] failed to message SMU to update HBM bad channel info\n",
+				__func__);
+
+	return ret;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -2062,6 +2104,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.i2c_fini = aldebaran_i2c_control_fini,
 	.send_hbm_bad_pages_num = aldebaran_smu_send_hbm_bad_page_num,
 	.get_ecc_info = aldebaran_get_ecc_info,
+	.send_hbm_bad_channel_flag = aldebaran_send_hbm_bad_channel_flag,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

