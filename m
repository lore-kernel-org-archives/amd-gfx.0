Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD9C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5012110EA6C;
	Mon, 28 Apr 2025 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oyvqcIuc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BC610EA6F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xadfno1jEgxm0nnNbEb5m6L87yeO0SgARO6/p2dNnYYpE+lOVMtjdlb56fyYgH4PcifZGfnbPtoNpcrId5T2HupWFtqsy1oYOxNNNgX1qibfxolFnS3GOVLbCESAYEJPN+X279AH6fnRTEkE7B30M55vJ2NTpBNrUeGUmjpq15JYj9fFXEaI1B5tdzF4gbsU8TEPLFZrBLkKZRbhrdzqoiOE/HLso5SZoQVose5Y+W2tKN/VV1b3jBR6OGlAMQ0rIglql+brLgSAOnfOHA5U/p8GJ+uCbLQTlLQctviaZLzfIS/rFR433GEd6htVY9uWc8oqoOO7AUrpWWiqa0a/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R3ZfAxBmGO9HNlGTb4upMOKOUCt/4ITtjUqXAOdh+0=;
 b=RjvX63Za8+XMnqjze+lqscfITUM63caVHHnjyyohsXO/dMQKSmmwyj0tDsoO+EdiU093GsPO9p1W+w4obm93qd2IofRrXFLQY/63tcGK/jaasfrrMgG7m17yHKKZHDpvK5PjvSaWXNBC+wjJdEApGV2kmRzLmPNO2KNvgG3wqZPAc7RoInU6ooJECUjjVsy+O2Ar170BOtab+oDJAJpiJNfdtlPBpTxVY6goNqYl90Gfb2gh1r3YQ6e661O7pHJx9n1+PRVlXNhEnjLQlfy/+ADmD95rRP1/7qXprjRJanIdvCj67USiwBEGXHuGfqzwuRRAZOSKj7C+cRlLfIy7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R3ZfAxBmGO9HNlGTb4upMOKOUCt/4ITtjUqXAOdh+0=;
 b=oyvqcIucqPZAKlUvEcHDkjFt/DP/zIKq5dDS3PoR5nGQMoqt4zNM/dVP5DqsypfexobINGgpwUtvkXVFny8LT6xNjF97ZVEXqV6QmLlDN99/box3fkwFtqJdBarArmsDzAIskOUZpdLWF9nMJMSHLKsOVxMd/lXCwndJbwVaEC0=
Received: from BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 21:21:14 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4d) by BYAPR07CA0105.outlook.office365.com
 (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/userq/mes: implement set gang submit
Date: Mon, 28 Apr 2025 17:20:49 -0400
Message-ID: <20250428212050.1098434-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 820195d4-af17-4273-2f72-08dd869a9aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRVrUSmLpaLobE1wijh3ZQKFOj8QLvoPMMVEcyy7/K2wb2ljX6RpN3tJxGyo?=
 =?us-ascii?Q?fOjbhA2h8CxF6gc21J07uxihdKbK1Dn/rodihIHymDrOmjq+k/ZvvDHX4QTS?=
 =?us-ascii?Q?Kodq2VA7xsCFCAwk+m6YtOofnaWsHrjxPfm9/+ce7JX5c0AE4qGL7xCuo8it?=
 =?us-ascii?Q?p8FcEgCT3yobSa8jpJVdVb+HA3VeOOjTU9TuBjyZ4ulLZM1j+R/1/8EXyLHu?=
 =?us-ascii?Q?nFxBMcOKeydP8C7XCarCXQ54o5OkbDwpETXBqpSkb1gciiJ7TVW2r4BKqce8?=
 =?us-ascii?Q?0OM2z46PfAwwvp017F1kAQnGJFPRRctMpu/vQ7n7EaLldN4ExDxX7Xea1wAn?=
 =?us-ascii?Q?mduQI/S2l/N/20BwUPrCtcweSfhVaHRNacCBykWGVjLBaTEDfq5I+cwoAphI?=
 =?us-ascii?Q?xpURbGQV9ZrJCfCPGKcpzk9UAgWjrRU8bFsLELNj2QhP2Uozbo7tCajbIbkD?=
 =?us-ascii?Q?a3ghpc+aim3Wx3sBntkmKxf/CPS4+TE0uyFc4Nr+AuRUqcS6Umvq30mRVDNx?=
 =?us-ascii?Q?9U6WiejST5OLK5ttVE7CVzft7MKvw745btZtZh3RqwNypOD4MQwoFwLFvmGr?=
 =?us-ascii?Q?um+/y1Evqq5HcEbrB3vn0o3aWCPxHsxjSIYdwZ1LTswh1TUHk5xCVGaAFtH6?=
 =?us-ascii?Q?arDDo6nM0TGnOV5OY8Zskf7IOofPnYQSmYeYveAbxYNYkHvX0H4FFRPZ0kHY?=
 =?us-ascii?Q?Mjscj1woAyuAigH/phk7qjObtiHatyC+E6A918ODOsaoAIngBhQXUGwMJ3yE?=
 =?us-ascii?Q?+HOL5eOQtj3hGlsFE7CpWY5bapuddR6YQ/KN26v3klrg5FxMKXldoQUJklOc?=
 =?us-ascii?Q?5xD/sqr9ffx8o/S898hcz3s2K82WY6iv1D2Id1JH8BCkUwgcboVqh1zkiAUA?=
 =?us-ascii?Q?AXRFV+52/75e3z9BcEc79BjepZeayM9nFVkZzhEAE3bJedJ6fPurLyYueUzk?=
 =?us-ascii?Q?rF04+GLL3mrb8gY97hjfFE1MJxkaqQiJqYgqJG2+78O87/u94LQi4bFO5DB9?=
 =?us-ascii?Q?XD2k7iRt16XHeAGf2fquodP1KVj9XvK0afsQ3xmaeLV1T4+Sbn7A20pYduxF?=
 =?us-ascii?Q?FhOQQxQQaoj/k/okWYtfYb3EHNgHGBo8jEOcj++A2kvp3mOTfk3dftJ6rgeY?=
 =?us-ascii?Q?E72zbhyMDK11G/C0dbQ/Mn80Yw/+p9k9G5ccQ1zlM9MdoCPy4scTdjqECpjD?=
 =?us-ascii?Q?c7+hd7+qIbhSyYKqa/mExdlKHZUsRo/q9yOPiQ9mJRMyVaUVL4mrq2FPKxPM?=
 =?us-ascii?Q?f5idVCnMtKz6LbNXxdBvwT+sGOrUIw9LYBtwjoUC69fsv80zw2R6rRxYZtk4?=
 =?us-ascii?Q?OTe9QeNg6asOLpYBS1m3EgRIEuVT4P1lo1XpCcUo4hkID24hNcvKiTHhrT9O?=
 =?us-ascii?Q?Aj8H/M0ci1Z/4V1cpko3buoMcGY3g7rqVFlMWZ9MRdJl1txWiKAsuPFRKjH2?=
 =?us-ascii?Q?Sj2ABksH95V/z67QuMf3LRgzmxoYME0cyPlh9mgPOSI18Uv5BESVvMFza0JB?=
 =?us-ascii?Q?nlMvaRi2ZHwymnCQq9+8YJMpXoLVzy3ZG77H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:13.2645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820195d4-af17-4273-2f72-08dd869a9aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

Enable the userq callback for setting up gang submission.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 650fdb68db127..98d08bda5dbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -367,10 +367,36 @@ static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static int mes_set_gang(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue)
+{
+	struct amdgpu_userq_obj *primary_ctx = &primary_queue->fw_obj;
+	struct amdgpu_userq_obj *secondary_ctx = &secondary_queue->fw_obj;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_set_gang_submit_input input;
+	int r;
+
+	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
+
+	input.primary_gang_context_addr =
+		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	input.secondary_gang_context_addr =
+		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->set_gang_submit(&adev->mes, &input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to set gang submit, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
 	.reset = mes_userq_reset,
+	.set_gang = mes_set_gang,
 };
-- 
2.49.0

