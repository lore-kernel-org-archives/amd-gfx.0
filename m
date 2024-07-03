Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A02C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA4310E1B9;
	Wed,  3 Jul 2024 09:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfdsJHde";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342F810E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6mNEmfrbTaxpLJ9QZR7Y1DkJXjxNSrLym2/2WF231ZhjUQjd2jHxOeTP5fOycFYVlHh4wscoMAeqT1Qdo5IHtWUridVIPiXwCXfY8+RSPlCDiz2nFllEH381aEuqxwihCMMqWQ0YwIvR8xFf1Y0xVMFv+JWbj+BHkDCIs3LQa6gHZbZtmkJZJYYSTaftDIwFgvl1wBgyeKAxI4mGXUrJM1N/BHkCy9oUuW4OGSMcHU2XZjKFcCdzp/+p1tlE7A40Wmuoi40rAJK5EqI392EhEH4oyabyu4vwtURYQ4nNFUT2TJY8rfwg6XLjB1DdnshkEmgi4OUTp7xuYFXCIBcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i4lYUXsmhYrDeUow+GxC+49rWxhudGU32RS6kMObzk=;
 b=nc9ywX+4DL+Qci/VlF1GmdiSsl3lUGHswt8pqc4+lESsj1zLF0YoU+J4BiapCw77GUUNO4ta3crnzSUcBVaNjtBBqcJN96p5btrd6cDnFAaX3AFOx01wpVPqBMQzr2hLGsbE4/LjaiQqzSM1HyKtZ4t3p090CmFj3aEQOOHpJPsswFNugBi7LjUOfUpaRsXO15981Od4wPyKN64tlVdqeqpJfPJT2FXrLEjoojUb+fWA+lWPzeAjZvr3ZtwFw51mVNdm5sIF7t6e3K2kBYuOMAYxXHKJx3KXq8a5yQGaz4tA0TpeBr7Sq6C+OdlzPMQEa6gj0Und0xLk+lr7IbxNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i4lYUXsmhYrDeUow+GxC+49rWxhudGU32RS6kMObzk=;
 b=UfdsJHdeBpo4uMtChSZP13bqA6x9v6/5hCVm3BlQMom+hpqCPwICgcsZiAYI24kz2JLQtiIDMmYVbn8qkfb2FNo+nxbBVA6RYpmrdvm/3k6b0ZxxYYrUZcZOQWQhP4384vomyWENDm2rxy/E+4yZOf+vFiXnObYxs/l6/mNwV+Y=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 09:03:29 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::5) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 09:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:03:28 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:03:26 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add ras event state device attribute support
Date: Wed, 3 Jul 2024 17:03:12 +0800
Message-ID: <20240703090313.1659512-3-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf4d03e-ce29-4d8e-b1aa-08dc9b3f0153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KVtqEJOkny3+4N8+eXlHgOG3/V/etjk/SDDotDNHqOJQEDrMcpySHKvIwySH?=
 =?us-ascii?Q?vY8NCmEyoEF8Kki21zDx+6hQTjuA9i/gjNc22aT8HgtIlR6CVNRO5489RMc5?=
 =?us-ascii?Q?rcwzwiIn/GOSjcMSjntfoLXF05o6Gvpu9s+aC9iwOmLMgkNmKK/LZJerK2go?=
 =?us-ascii?Q?6FJMRi/yrVlGp0YPmzTU6O/TPN8w2Ipjw+mZlLEGK3CkbE+4KcBDezLHL/yt?=
 =?us-ascii?Q?0T+stm0jwkzWjSBrDxwCDedm6MkV25Q7a/UqWMeDUdohK+kaBtvsg3PUHMVD?=
 =?us-ascii?Q?Wiz35LN1wSK+79cYnAQrOHfL0iJClxo9Vgs2jQDJTLjySkWM9Smnsx1aP7Kb?=
 =?us-ascii?Q?V1qWAav8vJF08c39f3BlFEFqC3xsFIAvQ76fp2ZtJks9WIrpJbv4MKbkrwpP?=
 =?us-ascii?Q?chNpoz5Xlum12c8ljtPgfNXXAqCzt3Ldk3caFonips2z6bROjSPQzNTNNw3B?=
 =?us-ascii?Q?U2ZYxgDATGEFDgLusNQtBGs3MUlKnKlcHUD6NxCgEIfEj1zM6Br6PEObiBD9?=
 =?us-ascii?Q?utWbeL5p59RV7nXD/ENHvCpyWamHfg4gnO75SBndhBhKEa6t0Wr2wwGOpQyF?=
 =?us-ascii?Q?RvGkGn5Q5MKnzgki+Ax1F/YjpRvfRWxtspGhIOClENuhEDnM+2M5SZbjd5oT?=
 =?us-ascii?Q?JEtM0Ni17ebuz+Q5yUJuFKZBHiFWjOnnq04s51xPE6yEyZ8WWU2Ekw+kjVl6?=
 =?us-ascii?Q?3mRiRQmComKU0fknJz3zFzqrXp+i26h+I4EeSSl3PtJxktSXKnD2LOTZ8nJy?=
 =?us-ascii?Q?5LW9sW8guJKDhYN8wW3NgytyWf4NvpvarU/CRTNkV0QgCirlgtWqWedzlp72?=
 =?us-ascii?Q?KOOc1u2UqvGJ5r/66S5o3/y3yYEDVyC8iC2zZtlSig8u/rlZimC8OVQRLW8p?=
 =?us-ascii?Q?qUczEOW0tw6wg6DE/xI+7/Ku/g60nmn1/uYxpl/ZPcNcOcA6lvxQfrKGHQNl?=
 =?us-ascii?Q?SByFuoR02/yixbWxuJcmzY8kFoH9EcFyaGRvrnelo2l7OgwEi9d1ruhLIrt3?=
 =?us-ascii?Q?rHJgJw3r16gC0ETHD0mxVedGu+nhD6ozJIeyYLh749DgHwR2GGuW4cZSqCz+?=
 =?us-ascii?Q?M7m3jl2tFE+nsnYT2p101qcQPI1wybUo/vb90Uy7++g55ARu+e21p5c5KiB1?=
 =?us-ascii?Q?2+cneHZgk95mJIGY3I1movz4xKXCD/qSHpubZZRw9vEwepayKJWUugGtC0IR?=
 =?us-ascii?Q?jjg12d889y1mXlOkEVvNYpzIL1tymcGkSUG06/X04EhzOQQPvA9szk71ijgz?=
 =?us-ascii?Q?BDnKM41E7nh1gOEVNAFaC821uVQyQf2RHqeLYtGOyBOuoCXx7GbxQkElInno?=
 =?us-ascii?Q?tVA4qM/818y8YuPl92p+k30/O5DlZ43PRORDDox3eGPpF/6KU2t5KtAmw8Lj?=
 =?us-ascii?Q?h4I0x+Baac9zR9HHnPRkhgqf242xP8GDaaXB3k/CB2e80NEzw6fCyyhQZnCm?=
 =?us-ascii?Q?bj15J9gDGZI1NpYBmu9Y6A5HxUwkI1hq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:03:28.6023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf4d03e-ce29-4d8e-b1aa-08dc9b3f0153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 56 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  7 +++-
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 11f8c37a97ef..d84e4f841ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1731,6 +1731,39 @@ static ssize_t amdgpu_ras_sysfs_schema_show(struct device *dev,
 	return sysfs_emit(buf, "schema: 0x%x\n", con->schema);
 }
 
+static struct {
+	enum ras_event_type type;
+	const char *name;
+} dump_event[] = {
+	{RAS_EVENT_TYPE_ISR, "Fault Error"},
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
+	for (i = 0; i <  ARRAY_SIZE(dump_event); i++) {
+		event_state = &event_mgr->event_state[dump_event[i].type];
+		size += sysfs_emit_at(buf, size, "%s : count:%llu, last_seqno:%llu\n",
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
 int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum ras_event_type type)
 {
 	struct ras_event_manager *event_mgr;
+	struct ras_event_state *event_state;
 
 	if (type >= RAS_EVENT_TYPE_COUNT)
 		return -EINVAL;
@@ -3968,7 +4014,9 @@ int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum ras_event_type ty
 	if (!event_mgr)
 		return -EINVAL;
 
-	event_mgr->last_seqno[type] = atomic64_inc_return(&event_mgr->seqno);
+	event_state = &event_mgr->event_state[type];
+	event_state->last_seqno = atomic64_inc_return(&event_mgr->seqno);
+	atomic64_inc(&event_state->count);
 
 	return 0;
 }
@@ -3989,7 +4037,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
 
-		id = event_mgr->last_seqno[type];
+		id = event_mgr->event_state[type].last_seqno;
 		break;
 	case RAS_EVENT_TYPE_INVALID:
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6086da67fa4e..189e2bf53a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -436,10 +436,14 @@ enum ras_event_type {
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
@@ -493,6 +497,7 @@ struct amdgpu_ras {
 	struct device_attribute features_attr;
 	struct device_attribute version_attr;
 	struct device_attribute schema_attr;
+	struct device_attribute event_state_attr;
 	struct bin_attribute badpages_attr;
 	struct dentry *de_ras_eeprom_table;
 	/* block array */
-- 
2.34.1

