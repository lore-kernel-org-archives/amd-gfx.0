Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CD2C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8D410E955;
	Thu, 22 Jan 2026 08:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1LmgkNDG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF9610E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO27S8vHcBeBUcwohAkwH77oNEOqrQnu/sZB1fdURLUgb/Waws51K2zBLQZQ0ud8O3iw40NAsCzElHaeoQoFa9iEDULlTdAJIzXkYMCZ9LRSYhyaD6W+sth8yEDmh38TzusK5j584HWJ932/7b/OYpp7Z4oV+90mcwax21HRFlCxyvnYT9giCqL6yfslJ5i2wmESkUBTNS05jitolvFAjL3ajHo7mKsM8lQ19IBb+Z1UQVK7ZYiuY2QCKpdZMEVL3IyrueXhzFJu8jSjFU2D3gqIuCfUET4XIJP+28DcdfTqmft2MEYZCwrlLvGpLlUYEz/ings4zQavRRayJjNv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNLIDdDUNQpx97A6xWlU+5HsmVLFUgtQ8mxijLIbSJM=;
 b=QVDgbEpeTsDLDKRE790A4FMVszBQR3AFDG07ZrsPtNWtsQp0bSfqGrF9wn9pdmS7eWzXFXoBHEsLaYNXD9Uxp5JmpQ5pvYsbDDw9ftUyjYHlKgGdI21IR0SaGgN6pCDXBI8andEm+jK+3LZAUpLSqS79Fec3keFJwc4evXrmC9GjysIrNVZiz3rd+MGHXmOZwnwmnL8Kn6276S/jLX70dWVwI2Q+mPVcB9Me2IUPfMyJy5p1hYx7HD43sGaa9ri6qoU2hLGHxKNf8TSC6apmzQCYrY4LiB6DD2uFy9lFuz7MO9NHn7IacCH7FiBN6T4GM3TW20SOD176B3XxcExD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNLIDdDUNQpx97A6xWlU+5HsmVLFUgtQ8mxijLIbSJM=;
 b=1LmgkNDGSuWfwu08Ib7GtEkuWEJp1eRUPJaw50mJBLM6uYH96Rg5uEhjJpcfspGW/6gmo0pvj8AnGGRzGsYMYnkr118QcpILOB5bVum0M574twM3GWKFdWrIu2FodSbmi/Ky6MLAnmuTbjcHZ02Og/uGevi1ayb/di1o+7wAQaM=
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 08:58:33 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::b4) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:58:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:30 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:24 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/9] amdgpu: Add MQD update functionality for user queues
Date: Thu, 22 Jan 2026 16:57:17 +0800
Message-ID: <20260122085738.1542800-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbb8760-2ed8-4310-a716-08de59946b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f1TTILPlE7MRrvFdt0ldza9KylrPDdDcZAONiUXRvBJ1vr4m5E8eMh1deCYx?=
 =?us-ascii?Q?yadYpcWLR+6v3E16rXvId3oksIwe1Jk0bJbivLQqxe3UnD7+PRit5/Z2XVkf?=
 =?us-ascii?Q?y1NlZJDhSmvK91n+cspwNG+TIPtdTQph3HfFNQKDyCXdU6GJS5kVfvvZ3Qes?=
 =?us-ascii?Q?TxaQBgKESLUuSxxOz1wQmtgA8dqpEep88cOWxZe9hy5WPml3osFnXTpYNdDJ?=
 =?us-ascii?Q?empJmaQBEDx165CyQAk7yIqFVvR6l5oWeMwJ4Cc42RLaYxLJdLqIYNjmPznC?=
 =?us-ascii?Q?97/q0Pq6irubo65stdTd7FzGylWkNYTAm05O1SkScTRbdPJKM+WhPt2cBX9d?=
 =?us-ascii?Q?VY3PAsB2hQXxeYDeWNTBUBMoVhE721CO3vyALVWJKZRyKDAquAnQ+sxJZhtd?=
 =?us-ascii?Q?zBFCjL8mawrhtvlQRdrixn+LNFtxrQWhiwsKnsg+Hc0WQvRRuVwwkqvIZmb0?=
 =?us-ascii?Q?7WJuQtjLcv3SuTNevvKeJqDz6198pETimYCNywnJIceSD1HYMqAwXR6DbbMr?=
 =?us-ascii?Q?FxvuGjcL0FRCjw1nA8eR3M3qWyQw1Xv2Ru7pT6e/L7y1krdA++C3juo5UalR?=
 =?us-ascii?Q?BKEZBqnLodUJCDAKroxozEXTmUBw6YWlSqr0LXxAZlb1XRdqnKqPKbHyGpz2?=
 =?us-ascii?Q?6WyN+yhco5FSFJ/Vyms9qLK5ezMAx0GRt8JRtgoph4szPOYjmNBwmc8imWIt?=
 =?us-ascii?Q?POiqpeoOWM+O4+v2ucd33iVlzulArJOFgHwRHN4PCHPXewKgK0QVXANn9CP6?=
 =?us-ascii?Q?IhVzBQSr10xhmGotbsQNZfVOEy4zDn3zH2FuXViJSSf0vGWPq/eLRqTiCfYb?=
 =?us-ascii?Q?LYk4DQqvWlRvtXMOBDWhnonnHkxs9mnPMd1IasW2LeuEMGL3iEnlN6U6ujIQ?=
 =?us-ascii?Q?8Auv+g+dNJky/OGCSrILmipnVV0xKFA98sivuzfeGJK+qPyhDDZmzrLMso65?=
 =?us-ascii?Q?01AruqC1oTL8npSL0chRt/Su+OP/wJuLz2OOn8siPGl1C5xuSoJmn8Two7pQ?=
 =?us-ascii?Q?PPQTqZWKbzLqxS0G0aCRh6PAhQ95lOHTodnooXTt65d/98vrqekPvLkgQroo?=
 =?us-ascii?Q?aaZja/Dl4xXBrqI2GVVIUJ80eKh5QEN7mXAypq5rHVYMn/HOG4u6cY0rdM1n?=
 =?us-ascii?Q?A/9NZ/UD41MGcw19+nTB89EEOf3ku0hWDadEWOMAmr5IIKM0ercLL6fsxok7?=
 =?us-ascii?Q?lP31sKWCOkmlP8OeQn2lGoHcELn8GKW2jKJ9IEqRYoI9AKhLthYdZaVzq9bv?=
 =?us-ascii?Q?K1f3KYID0/dBXHtnnVH6/KFIjAr0RvB6leMRzo8hoZC1u7JjtXQwJACVpZIR?=
 =?us-ascii?Q?UQ9SAVa+CHHtskU58Dc3MKkWhRIZ4hnZs5f+LyUx6AcEd1dqVwOP1ICv0Nnx?=
 =?us-ascii?Q?TuNiPwNP02N5NC2Ej5f7TeZ9xYpiEohlsf798/OvPHWsVSnvA8Z6fMAAwwV9?=
 =?us-ascii?Q?1sazGEJ9BhpoQjI/eRPWIHi5scXZOM3GJC1gGzZjWcth+IXwvfeuFZEv9W2b?=
 =?us-ascii?Q?X9xhnchum4EYT45stCHvS/Z3awPI0vuRJiLJ8+jKtOe8EnMdUs2nU4geKOU0?=
 =?us-ascii?Q?ojVDnlFXZK79+Mz95WX+kvNy7sgKXmC4hxYX+wWvN8KPV9jbzPXZtJh1Et2I?=
 =?us-ascii?Q?cSk+bS9CNU/SLEHWb1qV4eWi3Tqt0CIqLlfEDcSCngoSlOKfWyGJyA9itc5R?=
 =?us-ascii?Q?ti9GBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:32.0194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbb8760-2ed8-4310-a716-08de59946b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

This patch adds support for updating MQD
properties for user queues, specifically focusing on CU mask updates.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..ae221eaa5b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -432,6 +432,39 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+/**
+ * mes_userq_mqd_update - Core MQD update logic for user queues
+ * @queue: Target mes_user_queue structure
+ * @minfo: MQD update information (CU mask/priority etc.)
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue,
+				struct amdgpu_mqd_update_info *minfo)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+
+	if (!queue || !props)
+		return -EINVAL;
+
+	if (minfo) {
+		props->cu_flags = minfo->update_flag;
+		props->cu_mask_count = minfo->cu_mask.count;
+		props->cu_mask = minfo->cu_mask.ptr;
+	}
+
+	if (mqd_hw_default->update_mqd)
+		retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr, props);
+
+	if (!retval && minfo)
+		props->is_user_cu_masked = true;
+
+	return retval;
+}
+
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -513,6 +546,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
+	.mqd_update = mes_userq_mqd_update,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
-- 
2.49.0

