Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F32C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 05:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6786610E717;
	Wed,  3 Jul 2024 05:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1w/bXXt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A0D10E717
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 05:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfZSKhrt5jvBhdhLqKhbtsND0TPDBmP6IFVuqV0fWMCyEKXred86tDOUoNvSmyFJOUL6Lvb5Kp4NYbtRXvHVIDNlrHdhDIiibvGxYAlETfewZR6gfb5BzFGwuB/2cXG6kRKW5+3RqsJfQBb/ja48aVt2tOi4vU8cA2neVlCjYWiwhhFVzZzlckdlwY06mn1YzqSvmKO2x5V0fLys+KXJwnV5EW5OP+KOkm3mqHBAkFdm2YXXQG3gWsefBpnHRttyHY/7PrNNUbU4IIF5UFdCw9tk2BxGI54zYhTbJcRJC9WMiNhEAOwFKBWxXe1raFu8sb7SBi0ggV/mqst8Rg8U9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shAd2oZtfLZTmLceb1k+7U/cldR3nrWUR5/F4KHGlvc=;
 b=ApBEqjinMVxKbB+FhSALdbTingnH2FuPG31UvIDPwnI/73mxkbqg9NPI8PX3hT7lkEsGWHbRGQJAu1aQjbMtCOtMvl8qyakFnVDp3OTwHRNIXDufSzJ4AiixGpXoJ6U37VzQ9Zx+uIVv4Yao+ZzuLSn/eMyKnKm6AqRoydQwLaEajREKiCErhIliIWjW56Op+cZcK+/66HRUFQy9aGq/9YJ0hLRIkTna31ex3D3HexFZnfY0COFJqeyp78fl2uqym1OfAsTDOiy8/ijX0vkfzNq5eFmEYoFgpi+10jwkU0TfKpTBYyfeV2Z2MTIbeSHTKeeoVEJiWkHK/h4ZEuvB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shAd2oZtfLZTmLceb1k+7U/cldR3nrWUR5/F4KHGlvc=;
 b=k1w/bXXtr39uMs23u9qjelGb6sff4oOX6jvS9mZRDT1SMcQNAjfCY8fodqgjVkDlV7ED+gseeBiYLPv6zWcw3bhlAReB2ALizQ1WmpKxdEzhLeiBMCGvKSMRKU9nC1k1ExZFGwQYJZ6mdZz3Y4jmzvm0pfDM/S/3xrHPwmBMCLM=
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 05:52:13 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::a6) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 05:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 05:52:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 00:52:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: refine amdgpu ras event id core code
Date: Wed, 3 Jul 2024 13:51:57 +0800
Message-ID: <20240703055200.1610956-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 283496fb-1b94-4180-4d0c-08dc9b244957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7rJd9ACpf3Dgkv7XEV4W6VHDR8tBseLsIOY7xkSXhViSgM87qnVIQCqMo538?=
 =?us-ascii?Q?rxCPWhrO3PXE7KvXkGRgh1Xi86tH541EUcb7FWpsM3hH30EU73maYQ3FldLk?=
 =?us-ascii?Q?L+UvoI2TD3LbrVVG47SnhDRzOOIfw09iADxhObCD6uLo1WaBVvOO3tm39xuH?=
 =?us-ascii?Q?xzZVJZZZhfUI0af5bRNLi17jD2wB2y7eMFELp3F8cqSbqu9cHQJi9FzBlSSu?=
 =?us-ascii?Q?fX8WhiugPqAbcDyUkOeeSDAlZQvDXln6f0W2zQUIwVk3n83lofp4oz1dRaHW?=
 =?us-ascii?Q?uutqiw3jpmoA7Hg+/0ZKhAHYYqSFDspm8/OwSeF/KG8YYnZT0rTzAj8Yz7Kr?=
 =?us-ascii?Q?hml1UJMFEKR3qDQ9bVMeYzbDHa02f/AJ25qqbRNbDSpetYH2hvks53IqSvEt?=
 =?us-ascii?Q?Anp9CcilqyDZihwGk0QdauIwXnXo6VEFIROsdfTyhUd3O6V/yCSh0xDUSINI?=
 =?us-ascii?Q?wz5PIHYz0WqJ3aAUR5vLKo/Yp2iT6Kg87S7CC3teDtadpOzpdNRLVE8N8TAd?=
 =?us-ascii?Q?hQls53JV6mBGvWec+yaJrAjg1mwtIuF3aW2w6e4fTvvLNQqc8NprVW9ozwqO?=
 =?us-ascii?Q?WfXGbaJ+ktDXkMgqkE3/EMoCBazzQBwggzQi4+x3bj9TlUlQ1RCZkwm/Zamg?=
 =?us-ascii?Q?p1Xjhx2n0NwfHoq1twvqe6W119ObJoqnwc2+4Cyr+yuO+HgfDLGDr1GdFkrJ?=
 =?us-ascii?Q?HAI4xUwx1PcRJuQKjxObppKiXn0hZ+nFE5lSkasOkdEv2MhwuZE2tkFMHeFh?=
 =?us-ascii?Q?2l51jP5q1vGX9xRePkpORj9kei23bhkQlydUkDdRustictnAeBPv5bkKTxXy?=
 =?us-ascii?Q?1Jo6U9JMspCYRcZ+ShOQ+tve7jhW1D9Z0nOPXtZDhRxAFfHAZaNRSpcM3IDQ?=
 =?us-ascii?Q?5JlwOvT5JsXcFBqhJVAaQ6JRWDx66JJWiNMxoiVo7YqDSWJ1jEJFPqXRVBnW?=
 =?us-ascii?Q?fJRDFH6+Z1LGNoA06LNW+wbPSMoYT/m39VyoMG6bYLlJ3H2rMtfC3xDipT68?=
 =?us-ascii?Q?ZDhBJl5Ou/SgvkxrjyU+JKcZnXYs9P5Z5Yw1N+jluOn6vYqX4wipa8zU7RaD?=
 =?us-ascii?Q?SbRDcrxKcS6Xp73CE2vZPN7nsrD7FEVNPGUbT2jvAluQ5SEMCLbm6zL0EmHP?=
 =?us-ascii?Q?F1/699Zcgco37NBlZCZ7T73eIaD7oXRLF7v/iNtbE3mCIn5RUc/PCklBZmbr?=
 =?us-ascii?Q?5CUqVVGIp5Q/0yXGbSfeltSGgcGpgd35ARJx3HWNs5NixzpC/u471eDhHLX9?=
 =?us-ascii?Q?E/Xj25QBPaH/0CBhp1mTeNsPqVZN4NhVNCacBzLQrJPEm6yvljK4PaXbEWRY?=
 =?us-ascii?Q?wrJnOZY8jSicxsOGqgm78/Z+1rugzxLMpC9afzCaFfHFdhStNlhg9GKLbrV4?=
 =?us-ascii?Q?lk/hD5BgPd9Qx9vs7h55fTQdWKdZplleWs/UIIxsOl3CBCfMmLOHGnj0T06p?=
 =?us-ascii?Q?alekRwzt2X8hWDlu3E2Xf8PVSvusrb2j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:52:13.0103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283496fb-1b94-4180-4d0c-08dc9b244957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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

- use unified event id to manage ras events
- add a new function amdgpu_ras_query_error_status_with_event() to accept
  event type as parameter.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 89 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 18 +++--
 drivers/gpu/drm/amd/amdgpu_ras.c        |  0
 5 files changed, 88 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu_ras.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 7945173321a2..19158cc30f31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -119,7 +119,7 @@ static struct aca_regs_dump {
 static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank,
 			      struct ras_query_context *qctx)
 {
-	u64 event_id = qctx ? qctx->event_id : 0ULL;
+	u64 event_id = qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
 	int i;
 
 	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 9d3a3c778504..2542bd7aa7c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -274,7 +274,7 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry,
 					 struct ras_query_context *qctx)
 {
-	u64 event_id = qctx->event_id;
+	u64 event_id = qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
 
 	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
 	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].STATUS=0x%016llx\n",
@@ -543,7 +543,7 @@ static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
 
 	amdgpu_mca_bank_set_init(&mca_set);
 
-	qctx.event_id = 0ULL;
+	qctx.evid.event_id = RAS_EVENT_INVALID_ID;
 	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, &qctx);
 	if (ret)
 		goto err_free_mca_set;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 53b5ac2d7bed..45ac82a34d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1055,7 +1055,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 	struct amdgpu_smuio_mcm_config_info *mcm_info;
 	struct ras_err_node *err_node;
 	struct ras_err_info *err_info;
-	u64 event_id = qctx->event_id;
+	u64 event_id = qctx->evid.event_id;
 
 	if (is_ue) {
 		for_each_ras_error(err_node, err_data) {
@@ -1140,7 +1140,7 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 {
 	struct ras_manager *ras_mgr = amdgpu_ras_find_obj(adev, &query_if->head);
 	const char *blk_name = get_ras_block_str(&query_if->head);
-	u64 event_id = qctx->event_id;
+	u64 event_id = qctx->evid.event_id;
 
 	if (err_data->ce_count) {
 		if (err_data_has_source_info(err_data)) {
@@ -1366,7 +1366,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 }
 
 /* query/inject/cure begin */
-int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_if *info)
+static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
+						    struct ras_query_if *info,
+						    enum ras_event_type type)
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data;
@@ -1385,8 +1387,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 		return -EINVAL;
 
 	memset(&qctx, 0, sizeof(qctx));
-	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
-						   RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
+	qctx.evid.type = type;
+	qctx.evid.event_id = amdgpu_ras_acquire_event_id(adev, type);
 
 	if (!down_read_trylock(&adev->reset_domain->sem)) {
 		ret = -EIO;
@@ -1415,6 +1417,11 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 	return ret;
 }
 
+int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_if *info)
+{
+	return amdgpu_ras_query_error_status_with_event(adev, info, RAS_EVENT_TYPE_INVALID);
+}
+
 int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
@@ -2305,7 +2312,7 @@ static int amdgpu_ras_interrupt_remove_all(struct amdgpu_device *adev)
 /* ih end */
 
 /* traversal all IPs except NBIO to query error counter */
-static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
+static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev, enum ras_event_type type)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
@@ -2338,7 +2345,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		     IP_VERSION(13, 0, 2)))
 			continue;
 
-		amdgpu_ras_query_error_status(adev, &info);
+		amdgpu_ras_query_error_status_with_event(adev, &info, type);
 
 		if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=
 			    IP_VERSION(11, 0, 2) &&
@@ -2477,6 +2484,14 @@ bool amdgpu_ras_in_recovery(struct amdgpu_device *adev)
 	return false;
 }
 
+static enum ras_event_type amdgpu_ras_get_recovery_event(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_intr_triggered())
+		return RAS_EVENT_TYPE_ISR;
+	else
+		return RAS_EVENT_TYPE_INVALID;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
@@ -2485,6 +2500,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	enum ras_event_type type;
 
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 1);
@@ -2512,10 +2528,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			device_list_handle = &device_list;
 		}
 
+		type = amdgpu_ras_get_recovery_event(adev);
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head) {
 			amdgpu_ras_query_err_status(remote_adev);
-			amdgpu_ras_log_on_err_counter(remote_adev);
+			amdgpu_ras_log_on_err_counter(remote_adev, type);
 		}
 
 	}
@@ -3406,8 +3423,11 @@ static void ras_event_mgr_init(struct ras_event_manager *mgr)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mgr->seqnos); i++)
-		atomic64_set(&mgr->seqnos[i], 0);
+	memset(mgr, 0, sizeof(*mgr));
+	atomic64_set(&mgr->seqno, 0);
+
+	for (i = 0; i < ARRAY_SIZE(mgr->last_seqno); i++)
+		mgr->last_seqno[i] = RAS_EVENT_INVALID_ID;
 }
 
 static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
@@ -3907,23 +3927,52 @@ void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
 		atomic_set(&ras->fed, !!status);
 }
 
-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id)
+static struct ras_event_manager* __get_ras_event_mgr(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (!ras)
+		return NULL;
+
+	return ras->event_mgr;
+}
+
+int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum ras_event_type type)
 {
-	return !(id & BIT_ULL(63));
+	struct ras_event_manager *event_mgr;
+
+	if (type >= RAS_EVENT_TYPE_COUNT)
+		return -EINVAL;
+
+	event_mgr = __get_ras_event_mgr(adev);
+	if (!event_mgr)
+		return -EINVAL;
+
+	event_mgr->last_seqno[type] = atomic64_inc_return(&event_mgr->seqno);
+
+	return 0;
 }
 
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type)
 {
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct ras_event_manager *event_mgr;
 	u64 id;
 
+	if (type >= RAS_EVENT_TYPE_COUNT)
+		return RAS_EVENT_INVALID_ID;
+
 	switch (type) {
 	case RAS_EVENT_TYPE_ISR:
-		id = (u64)atomic64_read(&ras->event_mgr->seqnos[type]);
+		event_mgr = __get_ras_event_mgr(adev);
+		if (!event_mgr)
+			return RAS_EVENT_INVALID_ID;
+
+		id = event_mgr->last_seqno[type];
 		break;
 	case RAS_EVENT_TYPE_INVALID:
 	default:
-		id = BIT_ULL(63) | 0ULL;
+		id = RAS_EVENT_INVALID_ID;
 		break;
 	}
 
@@ -3934,7 +3983,13 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-		u64 event_id = (u64)atomic64_inc_return(&ras->event_mgr->seqnos[RAS_EVENT_TYPE_ISR]);
+		enum ras_event_type type = RAS_EVENT_TYPE_ISR;
+		u64 event_id;
+
+		if (amdgpu_ras_mark_ras_event(adev, type))
+			return;
+
+		event_id = amdgpu_ras_acquire_event_id(adev, type);
 
 		RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error"
 			      "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
@@ -4668,7 +4723,7 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (amdgpu_ras_event_id_is_valid(adev, event_id))
+	if (RAS_EVENT_ID_IS_VALID(event_id))
 		dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &vaf);
 	else
 		dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 0fa1148e6642..88df4be5d122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -68,6 +68,9 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
+#define RAS_EVENT_INVALID_ID		(BIT_ULL(63))
+#define RAS_EVENT_ID_IS_VALID(x)	(!((x) & BIT_ULL(63)))
+
 #define RAS_EVENT_LOG(adev, id, fmt, ...)	\
 	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
 
@@ -427,20 +430,25 @@ struct umc_ecc_info {
 };
 
 enum ras_event_type {
-	RAS_EVENT_TYPE_INVALID = -1,
-	RAS_EVENT_TYPE_ISR = 0,
+	RAS_EVENT_TYPE_INVALID = 0,
+	RAS_EVENT_TYPE_ISR,
 	RAS_EVENT_TYPE_COUNT,
 };
 
 struct ras_event_manager {
-	atomic64_t seqnos[RAS_EVENT_TYPE_COUNT];
+	atomic64_t seqno;
+	u64 last_seqno[RAS_EVENT_TYPE_COUNT];
 };
 
-struct ras_query_context {
+struct ras_event_id {
 	enum ras_event_type type;
 	u64 event_id;
 };
 
+struct ras_query_context {
+	struct ras_event_id evid;
+};
+
 typedef int (*pasid_notify)(struct amdgpu_device *adev,
 		uint16_t pasid, void *data);
 
@@ -947,8 +955,8 @@ void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
 
-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
+int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum ras_event_type type);
 
 int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
 
diff --git a/drivers/gpu/drm/amd/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu_ras.c
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

