Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC78CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 07:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE1D10E3B6;
	Wed, 18 Oct 2023 07:28:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBD910E3B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 07:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr/gxaeob7j69xefhn9kYJEGmQONo3BLPEOVr8I8VCPcP3paMOzC/6622cYXA1pnqc754U7xFL55I3ak+GFkIyaia3aoHR+u7YpSUt1nMaDheDVNfJmAFXsW0IkrllTT3KCDVYseo1TzcjZaPIDZNJfxCGea8qf8HQuOP73owin3h2H4YO77Fu7CK5PnH2/4KJVDZANTdGOneHaEZqMCYzhqBOKN4KRmUofqH3sCiBrkPGOh3601NgDlVx7Oyr/9DsqDgKv8H4Ci8wxOdjK50hD2OZVmSgzNoMkXEGzzV4mKFI0QfAHEWjnmGBYXWl0KC+kvoDBR4X59xdod97AUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhL4tEwAbTJDdn1eiIkOuP3kgCm+0t94reMkzzetURM=;
 b=Bgu6tvCNr0TT6PBxqQF9J7oRNs7hyMvD2EVVD1H0AVWZPdMjHuqzv+3dZFq6Zh9m3HSKxcy7BL4XSmkM3SQn3mDHFGblSIEFKLjwwTFp9KkW/VoDQRmDR7SYVVNxTF7v2lfl24ADvOBIyhe5ySFHyAyR/eoP8IjRP2OENOoqUR3wfm51T2ZPYRctHPyQK0azEfSTkA/cNZ5sTPq5D256OQTcvezJCKdNYFlQq1kD/bD1XAVBkRjRVaM8p5j6QZN8NnOeHZxbt/NTdFIW5JrifrYllv2Vmfo05wz0ARi4LLMBF+w9yPJ/WuuT8QXa0zX25vpdl+/zGMYZzFr2LRlrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhL4tEwAbTJDdn1eiIkOuP3kgCm+0t94reMkzzetURM=;
 b=d0GHEu7Ktwar3xavZV5/IbWohkurBRIGbWSJtAaLBzUKByhwYWViFBYi+FBdtAHImbrbwIa/xHnHMnm9nkjdi3XNH5nsE5Mc9sPReQFhMXczgxZCfgWqsECZUH2goqvZZlGz7PZh/2LuS5wfxao84LlibqUS2BxtIrKVWi91J3E=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 07:28:41 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8a) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 07:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 07:28:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 02:28:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: support saving bad pages after gpu ras reset
Date: Wed, 18 Oct 2023 15:27:10 +0800
Message-ID: <20231018072710.261899-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 575f995c-4e42-4ba6-014f-08dbcfabda6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIXxm1IXMsdR+IW3mwpYyJ/AcgLPjAbBftrf192Y7Wm7+Z0k2JhLIpfiEH9pLNi8dh6CmD1ziC/X0j5pSTDfhO62CBhicWd5MgrXaJwWzRT3MWlOAiTX+T7OYtX5QPrSu5rWX+CgkV8SKkTNiI/QK0dHgGX0E+o5EgNN+qBQIMHnkzuE7Ff1rMJsNuSg7kKcFXPUQnoWmLaEHIPC4C/fohPaZaSovJ6pP56CY7SrvnfwtgTgI/1hQe4+kHpO+1/poDOlqJfsNEVyAai8WSerIVQUEey7/XLDKpJ39x0qAe3rCKC96e9A9R8BaQRVXW/qlxi3FdBHIMBwBZNZUBGJLpu1tv6JdBxFEAc0xxRhMrgF0vi2rSGhtimpS3+HbGLxR76kFLJr3T+mKCn5kkJN4TPr9tUfhGX5AEim6DZlVlAIFsGsYpDc1I0bCpsPqC6cQSjG3mAM1FG1sQCDcedQIjkmt+hmi67EvJtb6xiLGgqhyT+EBlRK5Tx/PirDAVGLds1FjLRSR3fNAjVPKRSOYmxqXduMg99gF0dlW+2e49bx34kogkSIikPD71jfMuEWUaT0F2hOoxGexiPVbNik7fHnKgZro2Klru3RJRs8/JNRFwM1I06RTFCRV6F27rfR2jE/1ChfqSziN47fYv+dIfVWup+j59+VLBocUOWTcpKnvwY01E1rp5xBngaJuWweBdqooofGzejUlXg9tNJ2L4AqihWgBsKZQg0mvcAqOhrAJUNLqfGf4/eOX+5TlLNergrecO2JUg87UF//KZ8Fdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6916009)(70586007)(70206006)(36756003)(316002)(83380400001)(336012)(426003)(2906002)(47076005)(6666004)(7696005)(478600001)(82740400003)(4326008)(8936002)(8676002)(36860700001)(41300700001)(40460700003)(26005)(16526019)(356005)(2616005)(40480700001)(1076003)(5660300002)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:28:23.0958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575f995c-4e42-4ba6-014f-08dbcfabda6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support saving bad pages after gpu ras reset for umc_v12_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 40 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 35 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  7 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 29 ++++++++++++++++++
 5 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4e4ba2149595..c20c9d6df149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1026,7 +1026,15 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
-		amdgpu_ras_get_ecc_info(adev, &err_data);
+		if (info->err_data) {
+			struct ras_err_data *ras_err = (struct ras_err_data *)info->err_data;
+
+			amdgpu_ras_get_ecc_info(adev, ras_err);
+			err_data.ce_count = ras_err->ce_count;
+			err_data.ue_count = ras_err->ue_count;
+		} else  {
+			amdgpu_ras_get_ecc_info(adev, &err_data);
+		}
 	} else {
 		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
 		if (!block_obj || !block_obj->hw_ops)   {
@@ -1889,6 +1897,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
 			.head = obj->head,
+			.err_data = NULL,
 		};
 
 		/*
@@ -1906,10 +1915,13 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		 * info table failed temporarily.
 		 * should be removed until smu fix handle ecc_info table.
 		 */
-		if ((info.head.block == AMDGPU_RAS_BLOCK__UMC) &&
-		    (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
-		     IP_VERSION(13, 0, 2)))
-			continue;
+		if (info.head.block == AMDGPU_RAS_BLOCK__UMC) {
+			if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 2))
+				continue;
+
+			if (adev->umc.err_data.err_addr)
+				info.err_data = &adev->umc.err_data;
+		}
 
 		amdgpu_ras_query_error_status(adev, &info);
 
@@ -2020,6 +2032,18 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	return ret;
 }
 
+static void amdgpu_ras_data_save(struct amdgpu_device *adev)
+{
+	if (adev->umc.ras->ecc_data_save)
+		adev->umc.ras->ecc_data_save(adev);
+}
+
+static void amdgpu_ras_data_restore(struct amdgpu_device *adev)
+{
+	if (adev->umc.ras->ecc_data_restore)
+		adev->umc.ras->ecc_data_restore(adev);
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
@@ -2042,6 +2066,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head) {
+			amdgpu_ras_data_save(remote_adev);
 			amdgpu_ras_query_err_status(remote_adev);
 			amdgpu_ras_log_on_err_counter(remote_adev);
 		}
@@ -2080,6 +2105,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
+
+	if (device_list_handle)
+		list_for_each_entry(remote_adev, device_list_handle, gmc.xgmi.head)
+			amdgpu_ras_data_restore(remote_adev);
+
 	atomic_set(&ras->in_recovery, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7999d202c9bc..9ee53910a2c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -513,6 +513,7 @@ struct ras_query_if {
 	struct ras_common_if head;
 	unsigned long ue_count;
 	unsigned long ce_count;
+	void *err_data;
 };
 
 struct ras_inject_if {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 24fcc9a2e422..7542606e10fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -76,6 +76,27 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	return ret;
 }
 
+void amdgpu_ras_handle_bad_pages(struct amdgpu_device *adev,
+		struct ras_err_data *err_data)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!err_data || !err_data->err_addr || !err_data->err_addr_cnt)
+		return;
+
+	amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+				err_data->err_addr_cnt);
+
+	amdgpu_ras_save_bad_pages(adev, &(err_data->ue_count));
+
+	amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
+
+	if (con->update_channel_flag == true) {
+		amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
+		con->update_channel_flag = false;
+	}
+}
+
 static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry,
@@ -144,18 +165,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 				err_data->ue_count);
 
 		if ((amdgpu_bad_page_threshold != 0) &&
-			err_data->err_addr_cnt) {
-			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt);
-			amdgpu_ras_save_bad_pages(adev, &(err_data->ue_count));
-
-			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-
-			if (con->update_channel_flag == true) {
-				amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->eeprom_control.bad_channel_bitmap);
-				con->update_channel_flag = false;
-			}
-		}
+			err_data->err_addr_cnt)
+			amdgpu_ras_handle_bad_pages(adev, err_data);
 
 		if (reset)
 			amdgpu_ras_reset_gpu(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 417a6726c71b..447d8785008c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -66,6 +66,9 @@ struct amdgpu_umc_ras {
 					void *ras_error_status);
 	/* support different eeprom table version for different asic */
 	void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_header *hdr);
+
+	void (*ecc_data_save)(struct amdgpu_device *adev);
+	void (*ecc_data_restore)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -93,6 +96,7 @@ struct amdgpu_umc {
 
 	const struct amdgpu_umc_funcs *funcs;
 	struct amdgpu_umc_ras *ras;
+	struct ras_err_data err_data;
 
 	/* active mask for umc node instance */
 	unsigned long active_mask;
@@ -118,4 +122,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
+
+void amdgpu_ras_handle_bad_pages(struct amdgpu_device *adev,
+		struct ras_err_data *err_data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index c6742dd863d4..1fb78561f0fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -351,6 +351,33 @@ static bool umc_v12_0_query_ras_poison_mode(struct amdgpu_device *adev)
 	return true;
 }
 
+static void umc_v12_0_ecc_data_save(struct amdgpu_device *adev)
+{
+	adev->umc.err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+	adev->umc.err_data.ce_count = 0;
+	adev->umc.err_data.ue_count = 0;
+	adev->umc.err_data.err_addr_cnt = 0;
+}
+
+static void umc_v12_0_ecc_data_restore(struct amdgpu_device *adev)
+{
+	if (adev->umc.err_data.ue_count &&
+		adev->umc.err_data.err_addr_cnt &&
+		adev->umc.err_data.err_addr) {
+		amdgpu_ras_handle_bad_pages(adev, &adev->umc.err_data);
+	}
+
+	kfree(adev->umc.err_data.err_addr);
+
+	adev->umc.err_data.err_addr = NULL;
+	adev->umc.err_data.ce_count = 0;
+	adev->umc.err_data.ue_count = 0;
+	adev->umc.err_data.err_addr_cnt = 0;
+}
+
 const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
 	.query_ras_error_count = umc_v12_0_query_ras_error_count,
 	.query_ras_error_address = umc_v12_0_query_ras_error_address,
@@ -362,4 +389,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
+	.ecc_data_save = umc_v12_0_ecc_data_save,
+	.ecc_data_restore = umc_v12_0_ecc_data_restore,
 };
-- 
2.34.1

