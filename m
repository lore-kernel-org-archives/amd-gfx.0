Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE839C3DA42
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 03:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB8210E1FD;
	Mon,  8 Jul 2024 03:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhxWnl2x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124710E1C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 03:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQcWaTdWhCffUM5iXTBd6B13XQfBnyYtAobvaxICzE693myshJDrJFuCiIsLVMD2eGo5kU30LFF2PzSuK3x8V+DMvynoQXUKyGv5qkD2YfBAlY0O6i28x0y+Dfp4O6ZCITJTpvmc5ut2K3t0Hv/6Xz+0B55WN/KqUvVZE7ZOeEMCQs3ogbH9Irp0IkFkHyps9UEugVkDNMjjI09qxg8Ew3Wb/q5uKaD7abgxVr/b4yLh0OpS3TlXlCMDOOxBXAmJ015mPt1w5TrSpVncw6fjtsrjvl1491mrlJGW+7b21jIiFawErR7uoZsnlTo3NKIk8oDPlCAz655dgMj6MRyeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4egOod6uQQfTtb3bRRNQDKBuN3EXaS9t57nwE80xGw0=;
 b=kvD8XhlkohGCN9ex9wzOdHZ1on8WmG2wJii/jNSRdXcvcbeIoFLl3OxAk0gkKC9vzV8qWAmtzzN0LsnzmHiWdFe9YQKsXWXFECtvZc1jkSEbRpbDY07RZzQdpR/nP5ynuHr9sUHmf843dRomx7YTnZw/C9CvvOPvJp1fpkhivdRfvZgapO50wZpOelkP7QNyNBaP3b7T0tBXPtXf76g6usyCklzGZL1HwRjB/Vf/E/+RuD7LU/ClWOcp1hRkSJiTJ3sUFSO8DLmGbqNGszEwLWO+aBquhe9WhAeBuTAUCR5mERAQMdAP7dxTHtQx/yRBNCZCh4BfLD8rAZnbwQsecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4egOod6uQQfTtb3bRRNQDKBuN3EXaS9t57nwE80xGw0=;
 b=XhxWnl2x4VehwQ5CrtGoQkYFXGBVuPDM2bLXpt4rma76J3a94rycE+BwKu+tUGUFwu8H1Gz0qc+LuZN+pVDQlre9rw7fkczQ2UftjwCDE1Rx+J44hT05Jz4kUADrP5NwyLHpEm08QteKodIWGoPfRHHZVpnKp6I80PPlVJRK3bg=
Received: from PH7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:510:339::30)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:24:57 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::d2) by PH7PR03CA0004.outlook.office365.com
 (2603:10b6:510:339::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 03:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 03:24:56 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 7 Jul
 2024 22:24:54 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu: add ras event state device attribute
 support
Date: Mon, 8 Jul 2024 11:24:39 +0800
Message-ID: <20240708032439.2944714-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708032439.2944714-1-kevinyang.wang@amd.com>
References: <20240708032439.2944714-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be304a3-0aa7-4061-1f62-08dc9efd8a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a0r7W5Ev4AbCju/ufNUTN6a/7S67WaMj4IQnHO9vOEsBR25gUJkwinu/X3PW?=
 =?us-ascii?Q?h/GPll04td347lZT/zSichM+pVHHSltO6YOghVRsfSXa6XGHjWbYjBde1Ofb?=
 =?us-ascii?Q?1tUduq6lgrnjDjYJkDSoopF+bvNN4NBnBGVxeyJVnJsQNRMWDH30A4OYf3Nd?=
 =?us-ascii?Q?JqvoPuWDAtEg+Ygzie9m3cLMYxfLwpG9ZGFcfmUhJAv/ICzzYLrQ4lfGp/NI?=
 =?us-ascii?Q?pqizcRlCSCSV6Q1/FPHo0ffYFEFcXOeRwHfQmFqk4vHerEFXpot0Np2HtJpc?=
 =?us-ascii?Q?yIw3VHiAMiWtYnxSmbbiQoN6S9ethOZZEthtLaDg/OPT3CoFeTi1HTcL+mI+?=
 =?us-ascii?Q?ct4f9jyRxP/R9WrS+Df3kzVKp/FapjmOLYfLItqFYWpNWt/NsIWMnywQUkAI?=
 =?us-ascii?Q?po0Lwh+orw5gAwslq7zQNewNwdthky040ALYL0LlvU3gYr74iPOvEGz+asBN?=
 =?us-ascii?Q?/UqWWsyVCtkJ5phYRwLVncqRKXuskX09+FLal6s7O4T1X0QMyog9jvItxcfd?=
 =?us-ascii?Q?jkGrT8UhBPltDDBfksAESwiH/VvmSMReMlUcS22UfrSnKbRr2Bv0J9krhJ7U?=
 =?us-ascii?Q?BtQrSFzjmJaVOTTPFC4diFQ+jJwcs1dDbyrPeMA6qHj/8liR2memxvGYcPZV?=
 =?us-ascii?Q?xt+DW45sbla8RDIVyXSKcr/jSmVLRH3pOfzX8QiD3FRPnoZj6wBtp/JKFCeI?=
 =?us-ascii?Q?l8QfPZp/kcfsDIYRXumTvGSR2OWcWuS/ln6E56n28JmHuNcsEvjuTZCMhru7?=
 =?us-ascii?Q?g1Z2HcrJnyYbqXKNQTSoNnHAF97OPADE1x/0c24n32fe3GzFyf8ZYEeZ/fOr?=
 =?us-ascii?Q?ncaDQ+fwJs4hClabfDW0kBGBAyyPxP1Ko1BTI/njgfSk+3vj2nZwqiDmmem0?=
 =?us-ascii?Q?NTJdS3MaGl5+SOxWiYX3L2xkWgFPDYOEaK6XB1IfenXzIbwCbprvZAfvZrFU?=
 =?us-ascii?Q?3jIQ7I1hOzyUpJOA92vun+eWIsnRc+JKPKb5HmmxT19zxRW1NKjAb5LYPEJz?=
 =?us-ascii?Q?vXPpIJG24+ZOQN5sgaZJR1AWZUolViIBhBIJY72hYkGnwQJ24+NSzlQPApct?=
 =?us-ascii?Q?4WU/2XWIz3h9IAZYNYh/MY6RJSSVvi8HlOMgK8DtVg/SEkj5dKysmg2Cf0Xg?=
 =?us-ascii?Q?bXNn508pCdhGjGdjC/aaRBOk0PsqlbyskMfBesQekqqF+R9CBiNHlT08tgVb?=
 =?us-ascii?Q?PZ3LmMUE+fCpf4xL3QMbfWj2iDMkZ1Ju9eH0KVZ6CHBRXnQZilf+6jYlxTmp?=
 =?us-ascii?Q?0oysKmBGU+IiaXLrLtU7qSFWqjt0ldVf8x6/1pQoUtzatRfw09DowU+KC+sF?=
 =?us-ascii?Q?MZ4e9J91JNW+OYB/aWxscA4T5BErnqezMPYcN5NfRdtixVDeKUYi2v0SSvMv?=
 =?us-ascii?Q?HbrXuYkj8amGJ6vihwGrlFDkTJtJLpSR3VSuVo9IAsWpjqucI6Vb4Ky4U2Sr?=
 =?us-ascii?Q?PGC961pTGC8V6f5qiuKUELHyfFv3xZWk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:24:56.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be304a3-0aa7-4061-1f62-08dc9efd8a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

add amdgpu ras 'event_state' sysfs device attribute support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 56 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  7 +++-
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ca09316fbb6a..be053e168b64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1731,6 +1731,39 @@ static ssize_t amdgpu_ras_sysfs_schema_show(struct device *dev,
 	return sysfs_emit(buf, "schema: 0x%x\n", con->schema);
 }
 
+static struct {
+	enum ras_event_type type;
+	const char *name;
+} dump_event[] = {
+	{RAS_EVENT_TYPE_FATAL, "Fatal Error"},
+	{RAS_EVENT_TYPE_POISON_CREATION, "Poison Creation"},
+	{RAS_EVENT_TYPE_POISON_CONSUMPTION, "Poison Consumption"},
+};
+
+static ssize_t amdgpu_ras_sysfs_event_state_show(struct device *dev,
+						 struct device_attribute *attr, char *buf)
+{
+	struct amdgpu_ras *con =
+		container_of(attr, struct amdgpu_ras, event_state_attr);
+	struct ras_event_manager *event_mgr = con->event_mgr;
+	struct ras_event_state *event_state;
+	int i, size = 0;
+
+	if (!event_mgr)
+		return -EINVAL;
+
+	size += sysfs_emit_at(buf, size, "current seqno: %llu\n", atomic64_read(&event_mgr->seqno));
+	for (i = 0; i < ARRAY_SIZE(dump_event); i++) {
+		event_state = &event_mgr->event_state[dump_event[i].type];
+		size += sysfs_emit_at(buf, size, "%s: count:%llu, last_seqno:%llu\n",
+				      dump_event[i].name,
+				      atomic64_read(&event_state->count),
+				      event_state->last_seqno);
+	}
+
+	return (ssize_t)size;
+}
+
 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1748,6 +1781,7 @@ static int amdgpu_ras_sysfs_remove_dev_attr_node(struct amdgpu_device *adev)
 		&con->features_attr.attr,
 		&con->version_attr.attr,
 		&con->schema_attr.attr,
+		&con->event_state_attr.attr,
 		NULL
 	};
 	struct attribute_group group = {
@@ -1980,6 +2014,8 @@ static DEVICE_ATTR(version, 0444,
 		amdgpu_ras_sysfs_version_show, NULL);
 static DEVICE_ATTR(schema, 0444,
 		amdgpu_ras_sysfs_schema_show, NULL);
+static DEVICE_ATTR(event_state, 0444,
+		   amdgpu_ras_sysfs_event_state_show, NULL);
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1990,6 +2026,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 		&con->features_attr.attr,
 		&con->version_attr.attr,
 		&con->schema_attr.attr,
+		&con->event_state_attr.attr,
 		NULL
 	};
 	struct bin_attribute *bin_attrs[] = {
@@ -2012,6 +2049,10 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 	con->schema_attr = dev_attr_schema;
 	sysfs_attr_init(attrs[2]);
 
+	/* add event_state entry */
+	con->event_state_attr = dev_attr_event_state;
+	sysfs_attr_init(attrs[3]);
+
 	if (amdgpu_bad_page_threshold != 0) {
 		/* add bad_page_features entry */
 		bin_attr_gpu_vram_bad_pages.private = NULL;
@@ -3440,13 +3481,17 @@ static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
 
 static void ras_event_mgr_init(struct ras_event_manager *mgr)
 {
+	struct ras_event_state *event_state;
 	int i;
 
 	memset(mgr, 0, sizeof(*mgr));
 	atomic64_set(&mgr->seqno, 0);
 
-	for (i = 0; i < ARRAY_SIZE(mgr->last_seqno); i++)
-		mgr->last_seqno[i] = RAS_EVENT_INVALID_ID;
+	for (i = 0; i < ARRAY_SIZE(mgr->event_state); i++) {
+		event_state = &mgr->event_state[i];
+		event_state->last_seqno = RAS_EVENT_INVALID_ID;
+		atomic64_set(&event_state->count, 0);
+	}
 }
 
 static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
@@ -3960,6 +4005,7 @@ static struct ras_event_manager* __get_ras_event_mgr(struct amdgpu_device *adev)
 int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_type type, const void *caller)
 {
 	struct ras_event_manager *event_mgr;
+	struct ras_event_state *event_state;
 	int ret = 0;
 
 	if (type >= RAS_EVENT_TYPE_COUNT) {
@@ -3973,7 +4019,9 @@ int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_
 		goto out;
 	}
 
-	event_mgr->last_seqno[type] = atomic64_inc_return(&event_mgr->seqno);
+	event_state = &event_mgr->event_state[type];
+	event_state->last_seqno = atomic64_inc_return(&event_mgr->seqno);
+	atomic64_inc(&event_state->count);
 
 out:
 	if (ret && caller)
@@ -3999,7 +4047,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
 
-		id = event_mgr->last_seqno[type];
+		id = event_mgr->event_state[type].last_seqno;
 		break;
 	case RAS_EVENT_TYPE_INVALID:
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 49ec8edcbe39..88a427a1c8cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -439,10 +439,14 @@ enum ras_event_type {
 	RAS_EVENT_TYPE_POISON_CONSUMPTION,
 	RAS_EVENT_TYPE_COUNT,
 };
+struct ras_event_state {
+	u64 last_seqno;
+	atomic64_t count;
+};
 
 struct ras_event_manager {
 	atomic64_t seqno;
-	u64 last_seqno[RAS_EVENT_TYPE_COUNT];
+	struct ras_event_state event_state[RAS_EVENT_TYPE_COUNT];
 };
 
 struct ras_event_id {
@@ -496,6 +500,7 @@ struct amdgpu_ras {
 	struct device_attribute features_attr;
 	struct device_attribute version_attr;
 	struct device_attribute schema_attr;
+	struct device_attribute event_state_attr;
 	struct bin_attribute badpages_attr;
 	struct dentry *de_ras_eeprom_table;
 	/* block array */
-- 
2.34.1

