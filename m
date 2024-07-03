Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70952C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2379810E17F;
	Wed,  3 Jul 2024 09:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgdEvHm1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B3C10E17F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBuTo+pJXql5zddiANYFWSrORHfPfLvhmPoTfdjb6E98drzClA9pHZitfcnKl1k0wiLBJNfDDumpiHYRme48eAbAe1t+MDdtLxJWWSSVBfib8YwLLXOmiyEofft/x6F6srOd5mvV0LkQc+XA5GllhfcDng3HZC5i1TgzbdZNzcZ29/6k5DJr68BRWYr53/NFW/hEOU/+rK7hqE2nlx7klNOdTIBgdePhfhBoouKObLScn7y7Wj3+POBRApCy2H/cr361hHA3cJMGXVcEJ246trDmoXzSI3oNs/meBOqoigtgh/S/SXDDD8P0nrW8kjuJYuFtiFfAhOauWUWCA9fPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8667EcBPja/IWkbsXgGg/E9ummY1PpOlXfOVtIarYQ=;
 b=JHdUMZ7/NmEmnhsjxkyvgY3my6hBqewTesqoPIi3OuUePtaURSq2FFkIG2skTNkON31V5eDFK4NBzwc7p70ADdMP7bAMx8WI/nkwsvYaBmPMD5VyVgZztJ4ZwPtIC/T3rUPBfF5UUzstyCLLtLpJ/HL9VuSX7tunebCt2FYteB0R5FqnlEZAEbrJRXvzGCCqHcGG28Wi8dsANhFhzFwh89ksbEK6BAkpwZMMZUCPBjpF3Qpe2q0oLpBW7vVXt/hS7OrTp+WjRrx5466f3ZTQhYFdBUHmMheGoTDUThkmdI2RRpEn4gcCET3gNjbjWRNMmjRFcj0vIp+sNSutaQcnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8667EcBPja/IWkbsXgGg/E9ummY1PpOlXfOVtIarYQ=;
 b=dgdEvHm1IV8k7jJpLYprXDZu/+r/AwIRekmiJ/8Ayst5qhcSLTyUNsZZtfa5g3hRiyS1iFC+1hiT4EdgtOG/01PhlpzT5jCp+VwdyeRHwyoK796hPx1M6b/1qEC+oiVUpAD3zwplhEzg+B3YHrpEyUPnVSSMJ8pn/8DVmyp0Nj4=
Received: from PH8PR21CA0007.namprd21.prod.outlook.com (2603:10b6:510:2ce::13)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 09:03:30 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::c8) by PH8PR21CA0007.outlook.office365.com
 (2603:10b6:510:2ce::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8 via Frontend
 Transport; Wed, 3 Jul 2024 09:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:03:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:03:28 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2] drm/amdgpu: refine amdgpu ras event id core code
Date: Wed, 3 Jul 2024 17:03:13 +0800
Message-ID: <20240703090313.1659512-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703090313.1659512-1-kevinyang.wang@amd.com>
References: <20240703090313.1659512-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2c1227-c332-4cb4-1846-08dc9b3f024a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Wut4Ff5xqd7s7QTLfpFvdLqKQIEyuK6w6gxXqq+0wRrs4q4WORkLvgk7bft?=
 =?us-ascii?Q?mkwCcrTDtq9jhIUpgUCh8GDkxIli0xsEq4g4CrJ9oq7kI2lYAxJjvLiiAXJj?=
 =?us-ascii?Q?cuBcQTp+8pHADXS9zjTNYraBOVQudFn1BHwdJnM/08AENWgYU1kTavZ860Gu?=
 =?us-ascii?Q?59UYAuzTI4p1KOAxml85+cFY+7gQ+kzHJrX/1UC4cUswCobjEUg2fqQV2B8N?=
 =?us-ascii?Q?7ewrPel2f5BhXtYzbwealHFIf4cq3mPUg0qKUb7yaXs1O+CmaTwo0Jfm/y85?=
 =?us-ascii?Q?8/6EFp9JUwGyy8sMLpHZEOrcy39OIBdKl7Y7OIgrLQpS5EoS2izend8UahPT?=
 =?us-ascii?Q?QUJj78eZ9logzg3KZcBpSNsPu0c9goWm0igfuwaEqrx74F2KYxCPWE/2VLNq?=
 =?us-ascii?Q?Zy8TDjXo1lnAurB3MCfEPDFn6zGq4wpeyOqLzeGubxGC8WN4ix8+CahrCQoa?=
 =?us-ascii?Q?D0efaYFeFaS9ByCjO/cS4GQ4cdGhI2DUH25oYWKzPaQhdvEQ4Ad66noR0NkG?=
 =?us-ascii?Q?kOE7BK/P5ffenOF36nvu2LoFLfiSGsxocuEH1KVGjrIUziLWHyGyIAtt3NK9?=
 =?us-ascii?Q?AhaqIELC1NhhiEU3WYGwUCfEfezKPS/dPsWc48PRCekRVGZQKii7xf3N7+CQ?=
 =?us-ascii?Q?SjehxkBR5JidvFWK8VCgZOfGgGAXbO9vHTiGK75tXTQqp771IHbTto90o3pO?=
 =?us-ascii?Q?XYaAgBMShC3oWiVNzpFJEB1guFt6P0yxLvjtiXMPImBnfEdLXGJutiAQY6NS?=
 =?us-ascii?Q?ofk8sK1FEGTDtWFoLrxas2jCGq3WrjFtFRB3q4VglHCEcXB/j+fxlXUf1jSI?=
 =?us-ascii?Q?AnmI3lStxSYjkcgraFB35ysd6j36vefbP3tnDUtNQwOCORcr4h1029LZ5q++?=
 =?us-ascii?Q?P3v5BlomFgJdPOPZEN9CLns27TucvEFquVlbEkKmyI0d8JfdLWDVnDQ9aMB/?=
 =?us-ascii?Q?h+42Y5snmBz6K1OJJ5+hsLHAtW3Qrrkw3EKTNa7nhTEgVnNVoXxfhtgPF32m?=
 =?us-ascii?Q?fV1vLt+CcFwYoH+kGItE7w3v1v5wMHzQ20+y69MOKtoqFLbnxDEppxg/dpaM?=
 =?us-ascii?Q?tKsGbm3GiaaXHkOrMB02ra/RvZTpCYq7hMTJ53cVvh0MwI/+zCkcW+Q+G3WC?=
 =?us-ascii?Q?Su7fmIVabmRZ4yvlbC0j0dljs336klffMLzAql+IDUCmPxUQqncvjC38HQVI?=
 =?us-ascii?Q?VjQlO8q+PbOq4zObjpya7iebjjMCvLLcAmXRreQWpkuIyKD4D0qL7xwhcbYO?=
 =?us-ascii?Q?eHQxbg9nIjq8ykP1SSU3DTWaTnBX/DknAYxd8cKs8RDh4EwhIIH/iH9ySuvf?=
 =?us-ascii?Q?z01Nx3odn9ObTTX5T6T/Xrn36pZoq9UtD7RMEMHrO59Vqxoy2Gx/iDDuY9gO?=
 =?us-ascii?Q?rIWeqQyAjZK9PgW62cVf3c9hsSebUz7CAHZUgKFPHSa6drpMsVeYzjkaczPM?=
 =?us-ascii?Q?VkR86dZpRFSGTiDS6GOnpUvt1tN3Anfh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:03:30.2173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2c1227-c332-4cb4-1846-08dc9b3f024a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 99 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 21 ++++--
 drivers/gpu/drm/amd/amdgpu_ras.c        |  0
 5 files changed, 101 insertions(+), 25 deletions(-)
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
index 53b5ac2d7bed..9ef897e9f7d6 100644
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
 
@@ -3934,7 +3993,13 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
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
@@ -4668,7 +4733,7 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (amdgpu_ras_event_id_is_valid(adev, event_id))
+	if (RAS_EVENT_ID_IS_VALID(event_id))
 		dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &vaf);
 	else
 		dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 0fa1148e6642..f5edad432316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -68,9 +68,15 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
+#define RAS_EVENT_INVALID_ID		(BIT_ULL(63))
+#define RAS_EVENT_ID_IS_VALID(x)	(!((x) & BIT_ULL(63)))
+
 #define RAS_EVENT_LOG(adev, id, fmt, ...)	\
 	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
 
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

