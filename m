Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C549BCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6621310E489;
	Mon, 22 Jun 2026 04:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICjHgmr9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A867710E486
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJWGySgsGaxWouFgtfF7UHGzBxtaY8fZeXC257YY7ooxnuonlnkbvHpCJZVEAwW03LR1XiEISJKtHorKmSFrIGCCCNQcV7CY34pg6iZk+x75IKd7IW6BLgwixuGyFV7CgsJalE2fgDfjqq9Ohk87h1oVnll/4tsSls1ZOp6dx3tqP3XFe2kB5UECXsg7nQaTSQSLAbHBkLwXjPBAKGk+exxixZBlzqZiLYxGAfY17Mx/tdbgYxeiNKy2kIAJ5aWiT1jPPEv6OhwFxuu38NAAreDVmdoBjek5kLpZRy4Lr814uvaT8NeJRrASIv2yteEHoZ9uah/YuQWSBbldYN8k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjfvD9OeVpbEF0cJjzg7aiftdiw7Kgp4Raw6i7mc0b4=;
 b=FiuTO3lVFNclNuGfEaxxEnf7uikvxt9eg4AQrcvDRmNkKfLFMKhpNtRVNMh7fChjyb6BUEq7yjBvGV7/0TXomwaGHj/svQi4TlwrYyWnYqkTH4PesCRXlLch+fo+RewCm3c/V1O0aNCfKUBZltDugWuTXEt4PZd25Sj9g2fQS3mIvBCPUBPqk2BqMVHJp/ddkP4CfF4a66LmiQKtN4IH0Qqt7pcm0gOxe0zd+7fMQJgOh2udmIT171dmuq20xpXqsNoy3BvTavEy5X9kt+CBpscnIlAfBhuOUKaZVO6Ittn0Lc+l4vJaUP8Xi7jbpBz1RDkfFc150eDOL/6Jt9nzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjfvD9OeVpbEF0cJjzg7aiftdiw7Kgp4Raw6i7mc0b4=;
 b=ICjHgmr9ly3Ur884JdR/JYOA0wvkb26St5a4pbij+0n3Ot1oi1Y7Kw+xa8dZkS/QzMvQqVFffaaaoeqJGSlWmDdoQ4rs08+MEHMvEAHODCkXsLykdDFetaqnoT5AAluAS3BaHrp3bfV8FSCXTAl/yv5kLZC5iY66wElsxaJOWNY=
Received: from MN2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:208:239::34)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 04:43:16 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::56) by MN2PR08CA0029.outlook.office365.com
 (2603:10b6:208:239::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:15 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 40/48] drm/amdgpu: retire legacy pmfw eeprom support check
Date: Mon, 22 Jun 2026 12:40:29 +0800
Message-ID: <ce15bf8d49d592bf81e92b7f6bbe620b06de53ba.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ba7dcc-aa47-4f95-9d2c-08ded018c654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JBP8BdDlMPyQNYWLFuzLDpCBXGEfDT1cKG9F3Q05oFZoHXmDohqHLZG4HKczOePYEx+kNtUKvbAo7D3MfxT6GYhRNous0lpf/gW0qlYNQ7/Yrs72kVMezDNle4rNNR2wVcOdkcN3akN+iYY2Who5xcnehWjN0g8d2WLm+uXTizWX8S315HwWfgd+H8AaxIFQsdfpjT4YdLbCX3J7l4+MDnVq95rdGhuYHH8xdbbWARaqDLdb8DOrO1+pw5VGHvW+3TrDGkVEJmfnFdsb2+xKRxEsGzqtSlEkl+opr2C9DR3IosaDUUCqGDO2ysoo3d3kvmUQ99E56KJx/3JXyP+QEElbz4x7ZRrzWJSF00egTotBhxwimecDzUavMvHJCyACn/Ek1MoydO26jsHb8wQFqa9cd+LK6w0skJw6Wj/ZoZRhKOoxegRmENVKLBb0lO90Sw4Pi+m8Lc+2frJxXwHjFVOO/pHYfrLH1BeFPyzFASog7LREjo02zhXiyFnyu7cZ1q50UZOJ2Bbxyb8kXCRLKio7Y7WA/gz5RU3mxpRt7WeAgx5luAf7BVnt/iz8Km3VRa25j1TOjT41c+SozHE8O01Lo1Pil02/hI+IJ5jZLkvOZQSYQ6s1VG8YF8PQjfbbg1H+bJHrltLtSELDcUsNwihsYtNF+6khH5lMzLIHmOdHZl1ZTTERx/aEN68LKLBBajuiWWzYcwl3wCFXcSUrUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 16F+V8I2CJ2vjxQgR9/CNQyDmoTL91ZqkdhSwbFOfMhS+rn5cV6IrAj+UfbqLR2TMIueS1ruggvv+GJ/hVut8Pw8VPUfKzomrUOuXU3i433r/saz89Zv/aU30j06/ttJHim+TUk8fE9vi26a828U/WA4lwFHPicvJb8AGTM3wvyGqm9rU7cg+ZCaov7dK/0K9gQwjZB6LfcCYsCNcssesq8jeIlILPKh1AQBhG3qzEARobAUHo30B+CtTiUTwOY3zzA4KaEZCsUQwbWQK8TUf6Zm+eoQB6TkEXbTkInsQaljfkHMu4CIJYTDxICi9oQ1PFLVTcVQF+/wDGxxNf2VnSaxLDO/TmFLCozg3hs8dlGdVCIFaCAEXwZDvoqGiia+p4QdgJRh6bZ13VuJoriGDi7XsimNxMOcifKqPcto3RsYOhfbbiedXG0Bhbwj1+se
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:15.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ba7dcc-aa47-4f95-9d2c-08ded018c654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the legacy function to check pmfw eeprom support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 48 +------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 4 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 996152dadd86..e9583e8f0863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3198,7 +3198,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return 0;
 
 	control = &con->eeprom_control;
-	con->ras_smu_drv = amdgpu_dpm_get_ras_smu_driver(adev);
 
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8c398c2e6709..95468b9463fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1156,10 +1156,6 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	int res = -EFAULT;
 	size_t data_len;
 
-	/* pmfw manages eeprom data by itself */
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return 0;
-
 	mutex_lock(&control->ras_tbl_mutex);
 
 	/* We want *pos - data_len > 0, which means there's
@@ -1676,8 +1672,7 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control;
 	int res;
 
-	if (!__is_ras_eeprom_supported(adev) || !ras ||
-	    amdgpu_ras_smu_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !ras)
 		return;
 	control = &ras->eeprom_control;
 	if (!control->is_eeprom_valid)
@@ -1699,47 +1694,6 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	return;
 }
 
-static const struct ras_smu_drv *amdgpu_ras_get_smu_ras_drv(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!ras)
-		return NULL;
-
-	return ras->ras_smu_drv;
-}
-
-static uint64_t amdgpu_ras_smu_get_feature_flags(struct amdgpu_device *adev)
-{
-	const struct ras_smu_drv *ras_smu_drv = amdgpu_ras_get_smu_ras_drv(adev);
-	uint64_t flags = 0ULL;
-
-	if (!ras_smu_drv)
-		goto out;
-
-	if (ras_smu_drv->ras_smu_feature_flags)
-		ras_smu_drv->ras_smu_feature_flags(adev, &flags);
-
-out:
-	return flags;
-}
-
-bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-	uint64_t flags = 0ULL;
-
-	if (!__is_ras_eeprom_supported(adev) || !smu_ras_drv)
-		return false;
-
-	if (!smu_ras_drv->smu_eeprom_funcs)
-		return false;
-
-	flags = amdgpu_ras_smu_get_feature_flags(adev);
-
-	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
-}
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 5e5275ae7aab..6e50b9f0569d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -163,8 +163,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
-bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
-
 int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index eb8aff637eb1..537813482781 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,7 +186,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-				err_data->err_addr_cnt, amdgpu_ras_smu_eeprom_supported(adev));
+				err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev,
-- 
2.34.1

