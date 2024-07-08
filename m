Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98FEC3DA41
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 03:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE49A10E201;
	Mon,  8 Jul 2024 03:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSUFPmCE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28A710E1EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 03:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLlPdGQvmNzn+s1+muSkcsGHEwYD1jYyxDq72vzPkvNZvuTCNIdMNxKyNIMgg7G8GvJG9YlwYxJpHS7TxK1A6EV6T4T0n2zMToRkQAdgMKOJ8YOETXzYRWsYsibjVv5RDAo9CQ/8Vkw/ujBfpFQmWhVdmdllCv07muND9o7RhTh+01gB5/vL6Si/TkUXUJR1cVjTnS+t3M7sbEYmJxCOrWEGF84wtDU//E/oG4Fw006hsQvt1saJQIrN2LqwdT52iuz2YhHF849gqyPpq0JuiwPJwrWTvvYjo3PDFGImug6qgGSx96n5AEG9p2AYqxqQgOL1AhgyJbGSZ9gg7LaVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kyCk3xSqKUCtYviV2EVavFs5aICt1yagTF8Cwt02TY=;
 b=S+SG1Hmgy+Fn8VOplQUB4RdgZTPUl6x/tIdypcrBq+HstjkN/Qr0USzeDRlAAnh2xxpD/AZ1ujiETS8uhH3aEzJzOnFTnF7Z+4NXqSct1uJCJFzBvAbbI5ccPSg4/w2s5mgzOX/bA+skcUT5xWT1AbOmdgp655tbr6brN88lBnsPtn1GtFCOGPiJBbXdYvF8Llum84tAWDEDIK25p3LbLwuR87m6+FBg+Y5lWZhtiyLkUSngDaBI87stPIlredLa4DGU1D7hAatwT5Am3pw5uua1rZMNbrtd1OuowhrDGYEkGSAUWuBC3e6XKk6L6SvAJuRrYtinhPwct4wU3Ls2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kyCk3xSqKUCtYviV2EVavFs5aICt1yagTF8Cwt02TY=;
 b=pSUFPmCEEa79iPCiyT45D1AHNOLprQ4bqrVemEN/QQ1vXG/9/kHwJuFiUm7wvcp1f21o+1v9Ly0Zaj56dEWRmv/aqDIx0E2t3soxx7/RyQH+os4wQ8jvI4L3s5/tiguGAJYOCznvcELWvXXZjvjvPysZM9LxDq6nx5DnNsppQRQ=
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:24:54 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::90) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 03:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 03:24:53 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 7 Jul
 2024 22:24:51 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu: add ras POSION_CREATION event id support
Date: Mon, 8 Jul 2024 11:24:37 +0800
Message-ID: <20240708032439.2944714-2-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3e6710-22f9-4247-9b10-08dc9efd888a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/yLLzPVVr1OoCbskmorApPv+QClbf4AqUzLx454oNqxoKDGcE6YnpZRpE9WF?=
 =?us-ascii?Q?Kw89yXM+4hmdPPfzDsBRPJC5ZIy4QqNR/JmGK80Et3g2orGsmjwgZe0W/IaW?=
 =?us-ascii?Q?Fkq+nmNpabuXo45As78PWzCn5Gar0HMyeA1RGiEB/c+ZnnMqKT/5KvZVxnwj?=
 =?us-ascii?Q?/0MuCASN5RSPmkgjxMqQATv+VpOnPpsmduhoFgK572x1I9ui4CYfhFoFv35O?=
 =?us-ascii?Q?lENPWBFEHaEE3ofIefHxnVBsgSXZtWvJ/mBvhoSPaIUXTE2DV6WsGDFyzUB6?=
 =?us-ascii?Q?2tnlRIhFKIz6TE3vIJQqspnnysmpD6LMF9f0vPQ/cGvrvhB00+6EQTQNGKFJ?=
 =?us-ascii?Q?CA2YI9Rrr3OwTgN7ZwycTWxW8Acgb2sY5li03ACW0LRAYu4LaNw9c/ZVDItF?=
 =?us-ascii?Q?ILIM1bQzdPnDPwZUF3YHLWG5yqQFuEnAJncOdkASrQftkN1nOeVjetNI9AsD?=
 =?us-ascii?Q?RBKMcE2KxC8EF9k1w0B6eGqotGr50WMBvfnlMJ1mBAKSViMOyL9qVTuNvf75?=
 =?us-ascii?Q?ftCEc3iWF9B9mHJH/klvT9yGO7D/PbnnVqyT8mexktzu6yJTmsoDmuIKQLSs?=
 =?us-ascii?Q?Q8yZ1GIhoFcGhkV+jvMuPz0o/myObk+pkOYWOJi1k9UXoItnTBGYaih0yj6A?=
 =?us-ascii?Q?VwrVtNyGYHYpe/99quXkRfq86Rmw6HU6GIPhumSpCJk9FGokyV/pFUMrFhCE?=
 =?us-ascii?Q?Q7LJKnc2JKOBJgjdAMluyWL8tLZg6vLyo+HWtuPPHSxbn9uUF1/DJjnQ4W4D?=
 =?us-ascii?Q?raPzkldG/pcEdmCIWtf2QCSSHt91zbVQoq5sU/UJ2/X/S1kc/ySUFXS1CVEP?=
 =?us-ascii?Q?tNbGRnbnZm0lskztl8t9zrRzy9ogR+ayDxX9FrtLLRnYtNAt7UcnnN6DQ3WE?=
 =?us-ascii?Q?zB5kqbiGUGCK+EGj/2z5+TTThOvrwlKDms0vgYlwFlrURJ+VP1uiAIedzbPJ?=
 =?us-ascii?Q?lDgNxe8KD76QM+kuHry3YRMhVMuD1DRrIOKBYNCDpPsNBksYasmi3qUbey/+?=
 =?us-ascii?Q?wjmOPceIeGeYDRxNr14ONcuLXQ/SueiXfxvQrGZJ2ngs4xMwzhccNnCDghlo?=
 =?us-ascii?Q?xRELQUP6Wwxk11/QBE8qSRGX5XHJwjGJiCBUcXrsh5IxIMOprsfPnjoNBPf1?=
 =?us-ascii?Q?ih6Q7Crv1yuQpoTeecFoyKQs+xSjXKVt+dmKNkVzqBfJA+8s4sd52rKbPYBJ?=
 =?us-ascii?Q?4D934fR/6z+Onu5uLWZxO4G1srDdOlutWlnKU2hAOFYareu3XHk03Sm/+jed?=
 =?us-ascii?Q?oLv/zzJi1Umtov9CWt2z0TXH6P86dsMixkWagNOCRlw4a+l8d8ngCcCuEe30?=
 =?us-ascii?Q?hSHePIbIqq7S+u4nbU84Sg9WCoBNzUGY9ZFu+QjqfYkUnKJN3PQSq5jbGzP8?=
 =?us-ascii?Q?EJNQybN5XBCZ/Arq+rM/N6XH/FzrWv73cizlNqN8mZAlABUxpLL58IJNPnMV?=
 =?us-ascii?Q?eUCisCx1Wz7ZURj+2ctFckALzqVzGrbx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:24:53.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3e6710-22f9-4247-9b10-08dc9efd888a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

add amdgpu ras POSION_CREATION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a40886d0f507..c7e68c5e90cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2116,8 +2116,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
-	dev_info(obj->adev->dev,
-		"Poison is created\n");
+	struct amdgpu_device *adev = obj->adev;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	u64 event_id;
+	int ret;
+
+	ret = amdgpu_ras_mark_ras_event(adev, type);
+	if (ret)
+		return;
+
+	event_id = amdgpu_ras_acquire_event_id(adev, type);
+	RAS_EVENT_LOG(adev, event_id, "Poison is created\n");
 
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
@@ -2889,6 +2898,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	uint32_t new_detect_count, total_detect_count;
 	uint32_t need_query_count = poison_creation_count;
 	bool query_data_timeout = false;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
@@ -2896,7 +2906,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	ecc_log = &ras->umc_ecc_log;
 	total_detect_count = 0;
 	do {
-		ret = amdgpu_ras_query_error_status(adev, &info);
+		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
 
@@ -3974,6 +3984,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 
 	switch (type) {
 	case RAS_EVENT_TYPE_FATAL:
+	case RAS_EVENT_TYPE_POISON_CREATION:
 		event_mgr = __get_ras_event_mgr(adev);
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index fd6a4c55bdc9..69eb5fd4640f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -435,6 +435,7 @@ struct umc_ecc_info {
 enum ras_event_type {
 	RAS_EVENT_TYPE_INVALID = 0,
 	RAS_EVENT_TYPE_FATAL,
+	RAS_EVENT_TYPE_POISON_CREATION,
 	RAS_EVENT_TYPE_COUNT,
 };
 
-- 
2.34.1

