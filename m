Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F8C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008A888FAE;
	Wed, 15 Jul 2026 07:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d4V/z44L";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36A088FAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR3u52ueZVx574hZGPjo3x/H78Rgp0lnTMAN7z3FnH8vfvWCrx4MAUW0INjffCAeeUwC9uMPVEGFABmC+TorgJ6Xpjm91M8dhMfmxP+k7uyc2tzmO1F9Lg0JTjmzTVAt5zueRhVp1ZiKjm8HBG9EXTNAGTMOLIcc2VipYreHpl+2qNh+nspMth2Gtkg5GC9BDbVhJ+aJslplBD2x6YFm9uYz9/s9UpMA1JDSjPu/XyUAu6kX93tL7hHmINgtUMhEf2mlrjryjMLIXvw42RPdNA7rv7Nr1J4tBJ4G38DaFH16liS94vecocyyNuyqjd+BIKUydzBcl6B7Gbq7loEDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKOpiahZ2WBsDl6vk+0nZ3V7cC3og1OehE6c5xbvBIU=;
 b=Ku3GMXpJDEcHSbkdBXLE9iKzP5Z/xWkmeKCJ78EVNDAUq6KmdBLeqL8gSBt+78Kmbwn98Tgo6LkvutW2OCbtJQENnjq57N0G42PzfTx0wsYCKMdSxOETSR5GMSVv25VWB9EJZ9LVBs6YLhsVGnsc+qK6h322TXrqWwg1MoZumSDXrXMrPf0+9mym7eqnpnmh4N+TanJnATtGbKrN5uJG3wk4ragihax9EZRiJ76l0r0ijymcQHXUlyNg8wQHtSmpyIdTxfUXbljUiq4/ajR0SLJBNLXtxU7XecOKGBkMbPCDeZPLuhaqhbnKImPjmSTVOAsOnAS6Um+NQYUDvH6ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKOpiahZ2WBsDl6vk+0nZ3V7cC3og1OehE6c5xbvBIU=;
 b=d4V/z44Lnf88TLJeMWAkMn+tdvp9Qxbu3/JZwA0DP2aYCO0FwIkDgQ2iHW/dTj3TYjkUTYbs8Nd11o5Hkv30rQxBS+y+dnPC0nSEg/GZc9+RU6kkIoAOh0ijmfXJE2NPS3+SvD1UBjVXG65Y7af+XwmZ3lCAEEn3hD63WIMk81M=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 07:06:37 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::1a) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Wed, 15
 Jul 2026 07:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:06:37 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:06:35 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Date: Wed, 15 Jul 2026 15:06:27 +0800
Message-ID: <20260715070627.1052215-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bef90e-fe69-4c0f-973d-08dee23f9caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: HB+hP7xuZtyZkH1je68YssIfGEmYsk/FA1F8PRUoXKXlY4ii3q429vVZCKB6ZsS4GDJlhOpWXWVu5T9VJT/ts/kdLPAqRLCitgfx46fffxFsW7tsNoE4G0Kvs1o6QI+trG6kjCTSL6kCBUJ6Ic7ix6a+tQazJs2Pjpc0ffyvfOZdEVP+9FFWfVSIIAyvGOE5qHDYWrQtmRPH8WCC+1nd4p9EnMN4wKax5hxVEA7kG/FvV1UVBpxu4/2CUzY+myt6Icxq2rp6p9zk4fCzIzQV3+j30UUJsnhIe/DZuA4Tz8QmSFgb+O/YmlzeZFsnhacQb/LqjdP5Qk9qv3747QPnlkgQHlVW4DQVUgetg/X36kSj4vZg2PJbu6eFGzRmghUZuJW/FZbgVJALfiQMbZ7BS9JjqjQNCT+KhmdNR/81c696azaogGpz6/UUJ46lPVAR8kSGhYCLSqYhhMklOGT6HrBufPXp+m7Ii3HoMdem1BQvSnrNzD28b0Eo74jWzO0qTJuEjw9iPrxIxycTt2lbGkYHQS/Fe/Sqhbjt8uLXhtSji0VkkP1E1G+aJl0YeFYyvwDCp0I0ggmR+F5BUc+3dhWd4WfrK1UBrfyfQmw7pQKPAI2hya1UI4mrzGmU4RXI5MpUZ+o1JiXz6mZCVzKDaWDAB91FrDfWAH2IxSHC8y/eJhwXLTSrbXY1klLZB8xugzBua74Wbu+VywWw5j+hyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nQozlAQglfFKrh4aau0pC6+1YIgzk4REDj66gbDllvv6epvaQ7o3BR6XuP7P6pUVrDpVt03E3+xUXwVmg3H8mx8+XBKh+F4jULbTrvPDvQ1NMBOGUUDAYu2/xpNkRYtOFa+u2IoOZfOi22vXMEySFBOE3LW1osmikUhTVxVmozlDXES/XHJEOwTL6arJmQajYKgJlSYnAwFXIt9itrRXldNHIdVjfuIKOFCY5LyMPFL2aYVbOJTzDzBH+SjqjfPnC02ZqkR7CLQSOneYPl/0ETomMG2Ij63TkRi5V/8VA1v/I7r+ug8y6hMALZJDKSrUakoxtrhTBBcmfbo/ItY3GRTv1QKVM7Ruu119T83PGkM1wJWKx9+7prz7xXdIyQNl1io4TBAp55+5jvERSsgx6rv+Xn+8La6mmcPVPKT5AtosNWu6yQZhNVvDlcq7jzWX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:06:37.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bef90e-fe69-4c0f-973d-08dee23f9caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

Add debug mask to disable kernel logs of RAS correctable errors,
including both ACA and CE error counter kernel messages.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 12 ++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c        |  7 +++++++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 10 ++++++++++
 5 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..bdc9d9583bdf 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -437,6 +437,7 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 	ras_mgr->ras_is_ready = true;
 
 	amdgpu_enable_uniras(adev, true);
+	amdgpu_set_ce_log_state(adev);
 
 	RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
 	return 0;
@@ -510,6 +511,17 @@ const struct amdgpu_ip_block_version ras_v1_0_ip_block = {
 	.funcs = &ras_v1_0_ip_funcs,
 };
 
+void amdgpu_set_ce_log_state(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	bool disable_ce_log = !!adev->debug_disable_ce_logs;
+
+	if (!ras_mgr || !ras_mgr->ras_core)
+		return;
+
+	ras_core_disable_ce_log(ras_mgr->ras_core, disable_ce_log);
+}
+
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index a20bb8fdce87..efbdb25241a3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -63,6 +63,7 @@ extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
+void amdgpu_set_ce_log_state(struct amdgpu_device *adev);
 bool amdgpu_uniras_enabled(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);
 int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 878dfdfcb18a..0c362f9e25d6 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -346,6 +346,7 @@ struct ras_core_context {
 	spinlock_t seqno_lock;
 
 	bool ras_core_enabled;
+	bool ras_core_ce_log_disabled;
 
 	u64 ras_fw_features;
 };
@@ -403,4 +404,6 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 
 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
+void ras_core_disable_ce_log(struct ras_core_context *ras_core, bool disable);
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index 67a35409ff0e..7219a1008dea 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -99,6 +99,8 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 	}
 
 	if (ecc_count.new_ce_count) {
+		if (ras_core_is_ce_log_disabled(ras_core))
+			return;
 		RAS_DEV_INFO(ras_core->dev,
 		"{%llu} socket: %d, die: %d, %u new correctable hardware errors detected in %s block\n",
 			seq_no, skt, aid, ecc_count.new_ce_count, blk_name(blk));
@@ -114,6 +116,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 {
 	int i;
 
+	if(ras_core_is_ce_log_disabled(ras_core) &&
+	   bank->ecc_type == RAS_ERR_TYPE__CE &&
+	   !bank_ecc->de_count)
+		return;
+
 	RAS_DEV_INFO(ras_core->dev,
 		"{%llu}" RAS_HW_ERR "Accelerator Check Architecture events logged\n",
 		bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 08e17a83ad5b..76cc98e0abc5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -545,6 +545,16 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
 	return ras_core->ras_core_enabled;
 }
 
+void ras_core_disable_ce_log(struct ras_core_context *ras_core, bool disable)
+{
+	ras_core->ras_core_ce_log_disabled = disable;
+}
+
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core)
+{
+	return ras_core->ras_core_ce_log_disabled;
+}
+
 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
 {
 	if (!ras_core)
-- 
2.34.1

