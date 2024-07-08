Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F3BC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 03:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F2910E1EE;
	Mon,  8 Jul 2024 03:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xtQLWM7+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EDF10E1FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 03:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDm2oboK5goLwWGlwYmWMX+AaGLpWNj2ZVS6APhSB6J/rexnTC1zGMM/nvyDAh+zGRQn/yr96G5qupVNhJzCZuBrxJLJaldc4ridMGBt+KKOKdKB6Pu2WdITKFtJrwGMZsDbZLKF1113l2OFjX1xdPKrfrgSLIN719NDz9qUOgNrTVmpJRsCAazwRUinDlnSS6Taq7pdL+vMMjk5WRmR7SR39EmLT/mh3EpPsDYRfNn/bbYbglFZz95Od8xQnQ68bwJjoX9x/31QQn3X6uUyUe4O5W1tGKOlPXz7kEivbzjgD7JBZ7jjOHkC+qhEtN7gBN3R6iHIgg9xAyKZHzjb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqdq29ADL1RhCwyhhfmYWsRj8dGNRzfCox/UvdiK6vQ=;
 b=LYIzqOJu3XKpPNr99HfWwszcTcmKYqz3zLK7okXuqt3DHzUTMiBwvZhmgaqaekT/N5gTX6N+LSe065c00ClZnLT9XOIGuFSfXDeKQZE+G2zwio94PwWJ/vQscRB0S/MVe+Kd0z+fnGz0j/uLkCpQZaNk8NwfLNnG9njruIV4JFYuU+2UNB+1KlnXZR7DVoQhP+NKC2+gu3dDE82yMX0Dfnlm/mY5Ud24qhGDskolscZ5coo0HWj/7DD+K3tRX8PqyG00JVT2c6qPTlhWOjDbk3IPOgC0N+IQFRTaCKiCEYuuux68Rxpk3yFbjObyaSW4FOTs2DBOz51zCaLZnJERQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqdq29ADL1RhCwyhhfmYWsRj8dGNRzfCox/UvdiK6vQ=;
 b=xtQLWM7+KqE8jRhL0U53mXw9PXCuuYBh+OK7YpoA/GhK466yGmyiAfVz0rHhOYgnJvgofcZErJKdMcVjkZL7eiRGsGPliev7T8XJ23iXKXe4ad1m2fRjibCSwi8HFNE7hB1Zs2IljAVi1S7699IO0Erg0cEfn3Wa2/ZddcLYAeM=
Received: from PH7P220CA0130.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::14)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:24:52 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d3) by PH7P220CA0130.outlook.office365.com
 (2603:10b6:510:327::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 03:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 03:24:51 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 7 Jul
 2024 22:24:49 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v4 1/4] drm/amdgpu: refine amdgpu ras event id core code
Date: Mon, 8 Jul 2024 11:24:36 +0800
Message-ID: <20240708032439.2944714-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3baebd29-96c6-45c4-69c6-08dc9efd87b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i17jj9zvhvVopylD9ySMcWL/af1dcAluCbY5DIE8vK091KQLDni3g+yCnfVX?=
 =?us-ascii?Q?cL9iOy1h/FALfm+0+dvDBhGlqfMmZDjQGCBwRtYkd+CiILzrCw4tzdYISYzl?=
 =?us-ascii?Q?qlRiCDFCppWmL+zaFQeSHyw0T+nUevh1IkIl8pOJ9a1wfp8mDJNtKamovin6?=
 =?us-ascii?Q?NzP2CLsq8BmEcUv2gQSgtvbXY85rNl8weqavdtPtKyPfdwSyyBh2GtVRUm+u?=
 =?us-ascii?Q?dLqbm98Hba+GaGkbWzheS0bNFVYyjoqH6M20PMsA3vj/qXlR6WFm2Oq/96lU?=
 =?us-ascii?Q?6XvzApYkf0aNKp+YdyJZ8jlTxdvUTKODZp+TMD97FyFS+kObKykLYyPE0OC/?=
 =?us-ascii?Q?QIQOgCCMifshLtvbcbAV0wYMINLbApB4PA00NCbEJ3IDy4AXmDctRVLsrReW?=
 =?us-ascii?Q?qf+tRpfpyhq4TRqCWzdG+Hek4bblXhXmMKmAhBF61jgayANYZA3PmJWLl2Fj?=
 =?us-ascii?Q?ctwrljTooL+0VFAU7d57jUvVKc9ocm95q1PIXF1DPvsRzOChQzJUL16BFwKW?=
 =?us-ascii?Q?B9CbZ/eJslVmQrypnmXgL9vyWhFo/aoPypjXV4P/3afQ106F1qj254GJrOTx?=
 =?us-ascii?Q?gr6yJA6Hh4rkuIoSj5GLueE1O6EW9aQ/C3owSPuuVu/ZgL2BVan1VFpPVsLU?=
 =?us-ascii?Q?svaSqDfq8lFlRJj/Diq581zR8LGfgRuZ8qS7c96KaHYoWxTDBenVEtMsLduW?=
 =?us-ascii?Q?9Qt5msnGrNoK70mwhbd/f9xbdriTRd3fYUYUkg+kQyL1NoW8B7dce+tj0maw?=
 =?us-ascii?Q?G/7DbD2spezZZi7/2ynUrHSyHXeoMR4osBGShkdtMWZSr6bJttkRWztJyFSe?=
 =?us-ascii?Q?Ao7aG7fwE5iD5+no+ceZNMY0EZ7qMI9ZrL9ATpcq3wleY9WlNisTKLrb2jLB?=
 =?us-ascii?Q?WunndrokWB6Ogo9DqijGLewshzpnzs50F4Um6Q9Mag7RXX/aJV0nWIUXCGlC?=
 =?us-ascii?Q?J6ucJdlA50lnr27SgWDf/ZJFJUT3FyGtotSaF/W7RwJrhQ5/6xYnzTVIWKFa?=
 =?us-ascii?Q?B8koQZZkqL3OYzZc6MdwdCZPG0Tp6M2Xe8jkXEQWXhnaHNdgYYMuJ+Z3LKFY?=
 =?us-ascii?Q?CCj7Lrrom8K85PLtsviAg/8YgusxL+75sECE/qOUL5G5o8H8lRWTIfDXQgw0?=
 =?us-ascii?Q?vQwagbaHn0rdsHmB57ZlcWu6t7Dpc76fkotNBhv7SnQ68W8p2Od5DzGyvQhg?=
 =?us-ascii?Q?pO0qBwXW1jg2XekbbXQv/uhkpE+HpFtMPDK+njrg27zZTRo4AG/q4xXbVxZz?=
 =?us-ascii?Q?BBPQEGY4to1LKs6teQnBOxJRn6uW8+oo8KHMxFnQiLFJQ9Iq3+/ntZP3Y3h8?=
 =?us-ascii?Q?9N+4GQjKDAOhbGVSGFVJbAsAOCgNve9A6p4WO8zIRoyAZ8SpjETkWBc777u8?=
 =?us-ascii?Q?fytWRhmkBSHiJKTOMeniKlz4V/5dvAk8tXhBBaHcuz0DBjY6UsSQPkwbXFOO?=
 =?us-ascii?Q?trhuBDx5XazNEnrJcwBk4Ru8yoJE7C9S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:24:51.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baebd29-96c6-45c4-69c6-08dc9efd87b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

v1:
- use unified event id to manage ras events
- add a new function amdgpu_ras_query_error_status_with_event() to accept
  event type as parameter.

v2:
add a warn log to show the location of function failure
when calling amdgpu_ras_mark_event(). (Tao Zhou)

v3:
change RAS_EVENT_TYPE_ISR to RAS_EVENT_TYPE_FATAL.

v4:
rename amdgpu_ras_get_recovery_event() to
amdgpu_ras_get_fatal_error_event().

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 101 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  21 +++--
 drivers/gpu/drm/amd/amdgpu_ras.c        |   0
 5 files changed, 102 insertions(+), 26 deletions(-)
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
index 53b5ac2d7bed..a40886d0f507 100644
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
 
+static enum ras_event_type amdgpu_ras_get_fatal_error_event(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_intr_triggered())
+		return RAS_EVENT_TYPE_FATAL;
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
 
+		type = amdgpu_ras_get_fatal_error_event(adev);
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
@@ -3907,23 +3927,62 @@ void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
 		atomic_set(&ras->fed, !!status);
 }
 
-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id)
+static struct ras_event_manager* __get_ras_event_mgr(struct amdgpu_device *adev)
 {
-	return !(id & BIT_ULL(63));
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (!ras)
+		return NULL;
+
+	return ras->event_mgr;
+}
+
+int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_type type, const void *caller)
+{
+	struct ras_event_manager *event_mgr;
+	int ret = 0;
+
+	if (type >= RAS_EVENT_TYPE_COUNT) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event_mgr = __get_ras_event_mgr(adev);
+	if (!event_mgr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event_mgr->last_seqno[type] = atomic64_inc_return(&event_mgr->seqno);
+
+out:
+	if (ret && caller)
+		dev_warn(adev->dev, "failed mark ras event (%d) in %ps, ret:%d\n",
+			 (int)type, caller, ret);
+
+	return ret;
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
-	case RAS_EVENT_TYPE_ISR:
-		id = (u64)atomic64_read(&ras->event_mgr->seqnos[type]);
+	case RAS_EVENT_TYPE_FATAL:
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
 
@@ -3934,7 +3993,13 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-		u64 event_id = (u64)atomic64_inc_return(&ras->event_mgr->seqnos[RAS_EVENT_TYPE_ISR]);
+		enum ras_event_type type = RAS_EVENT_TYPE_FATAL;
+		u64 event_id;
+
+		if (amdgpu_ras_mark_ras_event(adev, type))
+			return;
+
+		event_id = amdgpu_ras_acquire_event_id(adev, type);
 
 		RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error"
 			      "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
@@ -4668,7 +4733,7 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (amdgpu_ras_event_id_is_valid(adev, event_id))
+	if (RAS_EVENT_ID_IS_VALID(event_id))
 		dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &vaf);
 	else
 		dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 18d994c98a25..fd6a4c55bdc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -68,9 +68,15 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
+#define RAS_EVENT_INVALID_ID		(BIT_ULL(63))
+#define RAS_EVENT_ID_IS_VALID(x)	(!((x) & BIT_ULL(63)))
+
 #define RAS_EVENT_LOG(adev, id, fmt, ...)	\
 	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__)
 
+#define amdgpu_ras_mark_ras_event(adev, type)	\
+	(amdgpu_ras_mark_ras_event_caller((adev), (type), __builtin_return_address(0)))
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
@@ -427,20 +433,25 @@ struct umc_ecc_info {
 };
 
 enum ras_event_type {
-	RAS_EVENT_TYPE_INVALID = -1,
-	RAS_EVENT_TYPE_ISR = 0,
+	RAS_EVENT_TYPE_INVALID = 0,
+	RAS_EVENT_TYPE_FATAL,
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
 
@@ -947,8 +958,8 @@ void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
 
-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
+int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_type type, const void *caller);
 
 int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
 
diff --git a/drivers/gpu/drm/amd/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu_ras.c
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

