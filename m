Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19C8C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 05:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8309010E71D;
	Wed,  3 Jul 2024 05:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlYNk2N7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6879A10E71D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 05:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0O4UdBgI/P6JRfKT5OGsCrdx6xLEiIAsacnkqn0BduHIF7fNv4OWDgyIBOyQFErKX4bhBnNyrB0HTq4hBj2F6H2eSTj50ZllbN1ryVC2Mm1Uh3LAYYEt4Fq+DwusqYtWaVXJYNLnFmbvMSf3C5Im4twvHpz93BaVDdMA+xlwl0fncOEsExgZWqKk7H80DxQt+PMIZfZWbSA2zSkDAZ7ZoRH1S0DY4XhO3MiF89rLa+JXDUlf+ZWV27WhHGv0+gu4vVR3P//4vko9zd0JOL3GfFrzz6o8AHgiS8G1oEvsH7BCLGCcmnxwhHZdSrayyJvTWzMT20JhxCUW5kiorhYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i4lYUXsmhYrDeUow+GxC+49rWxhudGU32RS6kMObzk=;
 b=O+5mcOz4ErDJDSKKa5W2c7L1p+VwcS7LoElLwFsKA+f5XGBYRV3QI5cov+IZt6AogojGOs+8qj3YbBBP0VIiWKQTF/cRjJGZyeEloLaoNSA2VaqDtrVs9Q38pD4kbudMUe5SVRuXpYKey6mRenU5x3xVf3DIiHXcxDVU7+EyUAT6HiTi8zF006n63o49ta4a7AJhIrDVtu5MjD1KdK/2rhpgeGxxYF4dtGUPqN/cpq7fXuYvOOIzKA/Y6HYNQqQf//kU2CnhS2CAQIgfp1FjMUOHL9jzO4QKx/1lXqiJerWBq3s6Co0v088qjHo0O5KyEPgqdnDaNopVnoALpEi2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i4lYUXsmhYrDeUow+GxC+49rWxhudGU32RS6kMObzk=;
 b=qlYNk2N7gIZqG5DAHDbGJE30K97Z3IvSz3slruclZizrHTHM942kXmO7+/nfOuu4RtyIp2f5PnNV32PfgLXA1iCterhppvNZ7u7Sz5PbWREyz2zAbhjsU6YSvC7tK3/gwwNsPGDkbJaHX5qnYFka8+bW29KkKj6F8C/iCzh6XWQ=
Received: from PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::30)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 05:52:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::bc) by PH7P220CA0013.outlook.office365.com
 (2603:10b6:510:326::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 05:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 05:52:17 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 00:52:15 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add ras event state device attribute support
Date: Wed, 3 Jul 2024 13:52:00 +0800
Message-ID: <20240703055200.1610956-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703055200.1610956-1-kevinyang.wang@amd.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: dd144093-f534-4997-b610-08dc9b244c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?owABZRWM20GxeN5UcHZmyjncy8TGD0j1bnFmTg86f2UKjnhw7vUgXX/mrGIP?=
 =?us-ascii?Q?wue/bkptxfze2hDdP6iIJRVg57DkIIT13wmcozJ5jqp7rMksLkmMXfMaKiwf?=
 =?us-ascii?Q?428xGFIEUBILlqYZJizZcGV8RS9r95cw7r03O8/ZdAHHruhP9BmFMJY4b/BA?=
 =?us-ascii?Q?rW6i5rz7mfnfLAjjnjbWYxY9kBwqxLhW4DXcca+T3zcqx01qtt+MFBg3lYgt?=
 =?us-ascii?Q?k+TqheXQHgXb3Eyx8InPlcVEBhWRv8bpQwbLXvSJA6VCe8n9ngIb9xLKbPv7?=
 =?us-ascii?Q?jzvUqcXqMKDqLufcH90O6V7go029RHU5QBfs1xV2LtAFSDiydDV6zf0Mp+AA?=
 =?us-ascii?Q?jEoMqRg14/wHwtU3BwNA7wOLdVZVWaIrjjiEhZJmGAauom90ZZQepRbJPoU2?=
 =?us-ascii?Q?hcYHVhkEyhdrO4RCttYdgEaD2bt+2Yn1OeScxu1EZ2w8joLc/7vCY04dZjNK?=
 =?us-ascii?Q?ldcP99CXphFpd6cby+SqxC9Sz9E13Ir+uKAJ1mLGb0OW4m/cuksMjuDGfgXD?=
 =?us-ascii?Q?vQzSsblX6EFowhEuMYKQ1cydgbP1TJcudDhDgr9Sy8TJyVsDI5kwsYYdW1RS?=
 =?us-ascii?Q?26/r9msx8K+JxBimmn9+EN/Vi9QucRj7kbEYmw50qDwzN/CoCfoCe/Iuvhrs?=
 =?us-ascii?Q?vIwlAgADUUICSI14w0BNBTiUWCiRkDN5/DWYYjIqXNMDm5mASzg8Z19J8PAE?=
 =?us-ascii?Q?8S5i8PVk4A7SZxDfKHSlQUC2eFgdkHnK0nj5OdykboFJcqmDnWhlWqtBtQxb?=
 =?us-ascii?Q?0dUF56sT11+fGY8ttp3eSXQsfag83bAIiWv5H2aZUPMPRqtw8I8Yp4G5YBHC?=
 =?us-ascii?Q?To6j1Lz3pjOSBEKOTPjKg0+zGeGYJ11FRSBVfjnpe8EkMQScRwYslCStvH/t?=
 =?us-ascii?Q?GPcsc84JNmxnRfdD9E9Y57R1xlLmYgOkkLnoGVd0UOKXbiSlZVrbFqXwVcVs?=
 =?us-ascii?Q?UEet5RklWfWf0NJhMJnQt/fNPQ8AiiFQF3B6H/b92eDUo5BFc47YB8KIvkHS?=
 =?us-ascii?Q?LfvrKAV/N+pVa7Lvt5DBwG8o0YmZvcJnNqJwMQmu+CA61Od6wx1CKAzBwdQA?=
 =?us-ascii?Q?VAW8kHkEDnmCsN9zvwx1jy2YtfFRsiIRherjMPFZNcjD6VuaVw1QkkTXd59V?=
 =?us-ascii?Q?+eZE7Z0nTQKy/fxLCxYo99OOBoPbuBO62DlOeYW+Xy3sgi9t0k7f0v/8tqZ7?=
 =?us-ascii?Q?EA0a29hqUM1Jre/lJ1OhUwhXJRCYOSCytpCdp7tKf9otnNx5JQwvzGLxGkn9?=
 =?us-ascii?Q?XGS3mmhV5gIMvZpK0rz1tpSGKXZb/iICqapstBNepnYf+RyZ5eX2fnwhthRj?=
 =?us-ascii?Q?jW94zA6cKXvDM/sHAl/Ll/PZJcrjnhXvL0WXQdR2oW4u7zqWSIFm7cxAyOe5?=
 =?us-ascii?Q?eqFUCdil6ikoWdGYsQrtCe9C0zeFTqwI8PWTEI7yTJqGJdOq40T/A/uWGmWU?=
 =?us-ascii?Q?BaRZGKYQ1E1jfyZk/Bw8B+GXvZEcY6C9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:52:17.7447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd144093-f534-4997-b610-08dc9b244c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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

