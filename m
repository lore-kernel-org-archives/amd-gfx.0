Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6102103E19B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 05:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C879C10E338;
	Thu, 19 Mar 2026 05:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YCY9Bb0z";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAEB10E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls9JGdJMloVTPW2jbzPl8Y46/PyjuCeNomnK/oEVBiNONADRiYSerMZCnx+w8G5r6zwoT8HkFQosDTynAp25VEIfHIDY9Pa5xbinka55+5ek7PtO4EJreqPUNu5gJ3JutwKe9GZN4GuCLrMEwZUOZFNNmm2uOzimQ10meDie/x+cF8ncI2pUApWcUvUj+l1Wrg7+1o1I4m/xDYBUkAWSpwu/6M4wE1nZW2stXXIfBQ+Sw4nmJsETm+EMC4egU46ctiqSQIKJnBTVjgPiinlqedV7XhCafvL3o1GziIO+cZQeaz7KKbhfSyZERrsw7ECcBg1ia+w2wpqpEShWBclw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfcouSOCKGbw1po5hP7neZEdKoyPadpSa+FnFNn72zo=;
 b=DGY4847qGASSCvtSFirh/YaBl8fndUYi51tnqhmUrGGN52z4M3ni/a8d1aYhvLI50Q+s3dsG/MnuWhz1ZU/JtdtOcg2PgynWtLHIMI8YvGPA/v/Rv9coGMyQCtW9BPo4MUgma/o0t2fGnmCKOziU7pW2w+UTR6njPlbH40CX1mw5pQggP8bCvFuVepM/BDs3goSBpQ7lt5exq2t9yPQ5YqWDRb2spliVDDhMz11lcrXqRWkVL5njpmaKQa93ximyDu/jAwmVJeJdDjVjyXNrwUHx4jNrkiO4RUvTy8AG6CM9+Itqyaqt4pTuKiDXqDJRlJFhfdQGjwLXoGbpXRTq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfcouSOCKGbw1po5hP7neZEdKoyPadpSa+FnFNn72zo=;
 b=YCY9Bb0z4bAjnQPuOZ4ShT0VbLqJjSYLXqwNAYS9FtzyZCWLsgdv4NdgQUyuwqYH1Ai0FYbHjyvfvSdvj/Tx50UshcWm6jVwbm0oxk+8fRrDn97Nc2puqFYgtve6dNSqg2L/kUkRdxHSpdQHB2whld/HO1J5nrj/SesnJWZu4Fc=
Received: from BL1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:256::32)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 05:48:17 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::f7) by BL1PR13CA0027.outlook.office365.com
 (2603:10b6:208:256::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 05:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 05:48:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 00:48:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Add input pointer validation in ras core
 helpers
Date: Thu, 19 Mar 2026 11:17:56 +0530
Message-ID: <20260319054757.1987819-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
References: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 464b9493-9457-4700-a79d-08de857b1e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: P3ox9rT95ZrDKXzaP1GWbx2ftHfIrBZgHZZ5APTgx4xaklyOtQv90zD2i907tVY6YXM0Xh95d8bfO70jUmXQJbhP1VBCCIPA0VNh756UZ2KKlnBf/Agm5LibpfC7SDtOLi63PxxJQQxoSzFYeES5c5e7X7pTOr9nDkfLmbwwKS95vzz6ROavvgTTvkJlOjvo5aoctCRsW3uqRbalrDUW2txNlrbxjj67rPXKz5QAvNA3Z6rOb3iem5hEds3jNQWmA2Fy+suzsTzHoZ8jyI6jv1sQjFj7Yc0pSHtNqbBumZ6yNTe303WKeMAYvS7o78xHK2NszO4piSjkJhIrSjVkGx/FcZO/ksrNRB7Vozb05rg9RyD8NE1PNIdadgnH6DLuHMvwGCx0G/EsYgi6IlEnvx+9rXEgpZcpV9H50rlHvhbCNz2j7kd6LMLWUcBobnWB4IxOD9rXNPC9uL4Wtsn8RQs11Gyd1PHdmkp6fYcAfp9vZstLhRoZ30BShFc5tOuhxwRGMByTFYEzP/sSsEEsKiTo09ecclgj57ubWx/cnytZiQ11S/dRHQawHyvnV1E29qvdmxOmN4S7xVbs7cdm1yCLVUWRH8kmjERasvuvNYVarh6kh+0VI5bSneTALEDbADArOq12y4uH3FzUngGGCyDV7qomvTIweWRaGRb40ZtLsZXnyhZxug2SS2KUEPg60vkup/8CWCl4teNtVJq5iv01YLdg35U3Nf+zPDTIy+tx+rG82y8aSC8q8nMwSA8oq6TqqXpjcULl+kautO9v4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /9MUnurSOXk3ZiyF8IzsImdsosgR6bE6hic+zBH4E8HZgxVQ2zMq3/U7hwAfrbHefKEBvqa7LV7/vWHPAAfhyOHaFYE07VcJXAP16r9Hz17t3RAucKWYLMAKEItERPds3lAh1WUy5+uo09kifFsJ0RiFz2GBIaigCf38ux5pd42eumGp4+l/Ty6Ir6mqw0U286XnTYzheMdFchifqiyYg3KyHnEyli2IocMLMaw0BTnQAa1Zb+vn7ru+TbrzXd5emUWQqfEY2MKtOXX2ZQz6UxgIEel3dEe6z0zf0DUxQQE8lphNqGyHnwo5iGKXmWG/+ZyjxWZnQF/mc+L7Yfd/p/yvUn7Wd/CQ91mWnz8yhOBAi2zjiokXMhL/a8tQDH42vlLbc8knKn//qA1Iy1b5pVPfbOzzw+EMg1gctSNeOh73u2dh4GrKODBvl+6U3MQu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:48:16.8311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464b9493-9457-4700-a79d-08de857b1e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
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

Add NULL checks for helper input/output pointers that are directly
dereferenced, such as tm, seqno, dev_info and init_config.

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I71bb9aa19f96c108e9ab1f4b7b72fe341e4d14aa
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 5d5d2d6430d1..4e84220ef152 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -69,6 +69,9 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 	int seconds_per_minute = 60;
 	int days, remaining_seconds;
 
+	if (!tm)
+		return -EINVAL;
+
 	days = div64_u64_rem(timestamp, seconds_per_day, &remainder);
 	/* remainder will always be less than seconds_per_day. */
 	remaining_seconds = remainder;
@@ -271,6 +274,9 @@ struct ras_core_context *ras_core_create(struct ras_core_config *init_config)
 	struct ras_core_context *ras_core;
 	struct ras_core_config *config;
 
+	if (!init_config)
+		return NULL;
+
 	ras_core = kzalloc(sizeof(*ras_core), GFP_KERNEL);
 	if (!ras_core)
 		return NULL;
@@ -625,6 +631,9 @@ int ras_core_event_notify(struct ras_core_context *ras_core,
 int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 		struct device_system_info *dev_info)
 {
+	if (!dev_info)
+		return -EINVAL;
+
 	if (ras_core && ras_core->sys_fn &&
 		ras_core->sys_fn->get_device_system_info)
 		return ras_core->sys_fn->get_device_system_info(ras_core, dev_info);
-- 
2.34.1

