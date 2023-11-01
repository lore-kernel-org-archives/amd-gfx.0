Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA69C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 10:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D9810E6BA;
	Wed,  1 Nov 2023 10:35:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B2210E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 10:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE6GOg3PC0SCsX/wmXRTqPI5w5Yw0+1uN90r+f9GmudQmAJ5D0liEq5h/u38FWg/+rOZZ7hITfJjyrD/uG2B6tdvX+NqQJkK8lVRgsM8Repa5+72pbZ/D3IIRYO6m0+aSSwFppIa2SO0z7en4XrSryl5Y0P6sQ5URGzwUVKkFLY+EL8alXMByj3ikteNongKqXJJMTSB4kUVl+nI2RrWObVt3/9O36Zyb20nDbMI1AqFo2t8onPWGPqwNUZSA5mg+APqpI/U6EkHvhFimW6WRySimmMK2sdtQjfYDVHU9ph4UnvBl6N6qrUUJdTIFkaacMtUpRmRy4c7zimEy5hJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmfHIU4tvmQS01xbp9HW83mDeGQQ0xt+gu7EVW20Rqg=;
 b=VS2RZ+vuUqmGUd6mvexbXNoMbv57+dqh9Aloo1K73lTNnmHdtCrr9340nqG8ecVwvNWviG/Y6Ow32qLV4CMVmNIvHzDdbNd+kGv+jU8qPXrNJHHNi4He1mhloCR9w+/BjF1kpvJb92LpeaFmdbDh8a5nbnanotAW8zbwbqnMZBPSke5MCkK5C1Chq7p20ZYM+CPy4YNaylTakr9kS1OIwri+rXUR8UyWEhIt33j0RjGenZpH6J7Cfpl4RQHkdjxraWURfqid7o69am+Df4EO/uD3IyMAlI5idqWEjqQpB5kE/xvo3Yxg/zKvB/Pyu6ePd7o3YLecuag0WjlPwYcCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmfHIU4tvmQS01xbp9HW83mDeGQQ0xt+gu7EVW20Rqg=;
 b=L5VU/Wti6yqjyg41/TMFi2Q7Qtpy6FIYP2qquNGmE4CfKmZfI2SqzBcddv4xmBVdc58KZsQAZTZYChZRA4yFqVrfz3S0WB3nSCCR7NZGEDY9GRqCC0cH7RxFdFIlxQIYuDgREypgIwr2XcNfs7iqbxDDiIN7lkY7RiGIC8FyqRE=
Received: from PH8PR05CA0016.namprd05.prod.outlook.com (2603:10b6:510:2cc::17)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 10:35:03 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::f6) by PH8PR05CA0016.outlook.office365.com
 (2603:10b6:510:2cc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18 via Frontend
 Transport; Wed, 1 Nov 2023 10:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 10:35:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 05:34:57 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 1 Nov 2023 05:34:56 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Reset vram error data info
Date: Wed, 1 Nov 2023 18:34:49 +0800
Message-ID: <20231101103449.3657664-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ca3798-3ea5-4969-815a-08dbdac634cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v2FqdRn40pFBKJAH1KQxKlamHzrd90OgrvDBTxv2+Nt2WHHQ+AxOYwnn1j5UXAymM3TQF9an3EoeRdmWUHiGC0uHvMx/+1tms44Zg0/h1yAbUViA/8WisNtpANNU0aZLNhdZ24VjA7ZaZ2ea8VC4Bki3vU7kldPFXiyMNNy5mOXMcKXgZxAicBfXr1OS5ANo8i6BTsA4952MmehB7fTmEXtzlMeAxb9B+2mNUXLZ5GXKiklSTF3TGg0fAI2EV07GLI7aDOZRxlSXrErjnnUxO3yWOYXiNXd9BqFq6Rs/yPJIfnY8Tw59zf9PJXW+Sl7ce+alTKHOQFvLzifABpCAfNs1wPeKrAME87KtTSMhZKmXmmO+Nw497SA5tIryAcaAoxm+fL32+NiFtVKvOPg4WkE3HCehnCzxJUC7LVh82feGUkwncmb3ZtgzWFiDk+wckhR70BBxD1ondtzKO/hVENMA2L7GEvn032RavpSKH+O6vH24kVYP9uRmc2UJHcwFLwTTg3SbzDtpHqDVoQYa5DZylEuehFmDJm0TwwMdR24l6ojB6MCnQX4HCzce6DwdfdIKO9T7AAEqHpBBUG3/GFF13ZKqZ7hNchfz+p2IRgrcg7U/C/7MzMS80oQL+NXzWEpbKVTuMb08qxXnrgdS1pHuTYKLRMWGY+Pyw9StafEqURLnB2GtOEBvkQ2RKq1aB6wERVSBJ+bj4J4W4KWukrGuKsCunmcLy14RRTqcP9hdvPIGA64AUAgUpZ0Jzs+QcXEUykMstT+Ht4hnq80fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(40460700003)(7696005)(478600001)(40480700001)(47076005)(41300700001)(83380400001)(5660300002)(4326008)(36860700001)(2906002)(8936002)(70586007)(6916009)(316002)(70206006)(26005)(8676002)(2616005)(86362001)(336012)(426003)(81166007)(356005)(82740400003)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:35:02.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ca3798-3ea5-4969-815a-08dbdac634cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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

Reset error data info stored in vram  when user clear eeprom table.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 97 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  4 +
 3 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 753260745554..9c1072ea5760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2336,6 +2336,77 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_ras_error_data_init(struct ras_err_data *err_data)
+{
+	memset(err_data, 0, sizeof(*err_data));
+
+	INIT_LIST_HEAD(&err_data->err_node_list);
+
+	return 0;
+}
+
+static void amdgpu_ras_error_node_release(struct ras_err_node *err_node)
+{
+	if (!err_node)
+		return;
+
+	list_del(&err_node->node);
+	kvfree(err_node);
+}
+
+void amdgpu_ras_error_data_fini(struct ras_err_data *err_data)
+{
+	struct ras_err_node *err_node, *tmp;
+
+	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node)
+		amdgpu_ras_error_node_release(err_node);
+}
+
+static void amdgpu_ras_reset_error_info(struct ras_manager *obj)
+{
+	struct ras_err_data *err_data;
+
+	if (!obj)
+		return;
+
+	err_data = &obj->err_data;
+
+	/* release all error nodes */
+	amdgpu_ras_error_data_fini(err_data);
+
+	/* reset error data and init */
+	amdgpu_ras_error_data_init(err_data);
+}
+
+/* reset vram bad pages data and umc ras manager error count */
+int amdgpu_ras_reset_vram_bad_pages(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_err_handler_data *data;
+	struct ras_manager *obj;
+
+	if (!con || !con->eh_data)
+		return 0;
+
+	mutex_lock(&con->recovery_lock);
+
+	data = con->eh_data;
+	data->space_left += data->count;
+	data->count = 0;
+	memset(data->bps, 0, data->space_left * sizeof(data->bps));
+
+	mutex_unlock(&con->recovery_lock);
+
+	list_for_each_entry(obj, &con->head, node) {
+		if (obj->head.block == AMDGPU_RAS_BLOCK__UMC) {
+			amdgpu_ras_reset_error_info(obj);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * write error record array to eeprom, the function should be
  * protected by recovery_lock
@@ -3556,32 +3627,6 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-int amdgpu_ras_error_data_init(struct ras_err_data *err_data)
-{
-	memset(err_data, 0, sizeof(*err_data));
-
-	INIT_LIST_HEAD(&err_data->err_node_list);
-
-	return 0;
-}
-
-static void amdgpu_ras_error_node_release(struct ras_err_node *err_node)
-{
-	if (!err_node)
-		return;
-
-	list_del(&err_node->node);
-	kvfree(err_node);
-}
-
-void amdgpu_ras_error_data_fini(struct ras_err_data *err_data)
-{
-	struct ras_err_node *err_node, *tmp;
-
-	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node)
-		amdgpu_ras_error_node_release(err_node);
-}
-
 static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_err_data *err_data,
 							     struct amdgpu_smuio_mcm_config_info *mcm_info)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 665414c22ca9..64710517b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -622,6 +622,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		unsigned long *new_cnt);
 
+int amdgpu_ras_reset_vram_bad_pages(struct amdgpu_device *adev);
+
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 65aa218380be..40060f1b8ad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -462,6 +462,10 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 	mutex_unlock(&control->ras_tbl_mutex);
 
+	/* reset dad pages in vram structure */
+	if (amdgpu_ras_reset_vram_bad_pages(adev))
+		dev_warn(adev->dev, "reset vram bad pages structure failed, need reboot system\n");
+
 	return res;
 }
 
-- 
2.25.1

