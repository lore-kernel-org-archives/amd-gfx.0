Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5614DC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED4310E099;
	Tue, 14 May 2024 06:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P5+sE80H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE7210E099
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlQrhw8Fpm4jOHbpe2LbjNbSoPlD0u40x0RYxutp1re4nyPX3ZEkrJ/ywcyot6B8NrhX2w2eFp9rFnU3DF73sNIakPSWTjKFxsJcuNqm8bKkv0lHPr9eAL5jI69ezfC+OpSC5cle+WdrT4YfF4pNGIYEDTpAdwMn7XgmWB0mbO72dxm/LsJ96Jp401H8eJAB9jZDN9eFGVxskcMvtzvZY2LZf68ncVCQ4nGwzQ8boXwGdX7QikqmoyKuxw4FeDOWtgW0Dto3oWaF7H8pEoq/5usULe+xAc8cIqxhM37zVGysj4rst1ZhIJTU8MyhW7Sd+0kZmc242jyO1CigHioKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TptBqjnftozLtzSA9jxp7UUm4XKV/o/urfzybkCAN44=;
 b=F8EVDWHfJ1dpn8RCquFytZpiO9bIPY0j8s9Vs4oR5C6uc00wv/rw1x2jEL9dgdc+ggjOZYKw1H8CBZrNgXYdOCjRQGnddEj/niw349gL0wLW4EtIEcIMBR76ZV1cxmezENi5ulYNZdRIR2qnD71RO9gEuzq308SWJTKGHZgb5b0Cy3xvjXqL0WKtuV9W+f8x/hGLv47jHI5UHk4WDQStkP/ocaIriLbkq1dW5F9vk1UpbtQ+4byja4teWreOPS4kAWXbEX6ClYHSVUwLRFZwcV87ogRB8A6+QmgPhXe5Y8X9NekxYfuTHwiFP27v3YH/uXQ52garEfJRtTdKggLwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TptBqjnftozLtzSA9jxp7UUm4XKV/o/urfzybkCAN44=;
 b=P5+sE80HtEgb2Du0I/qYPiMwKlb4BhG8UTxC5ISnCKKg/A2iF7IKzfK6awXpWoNLzMF3No8Uan74PMjAUaXESBwI1tVkm9U/baf812oUZJuHJcc9wGRz8N6+g3YDJEvCvyHxA2R7GgBkMfi6sXXcGk/AZqz/uzjxzqN1npR0Vnk=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:04:37 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::b9) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:04:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:04:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:04:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 01:04:34 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: check specific index for smu13
Date: Tue, 14 May 2024 14:04:34 +0800
Message-ID: <20240514060434.3649854-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff32237-d421-4de6-e519-08dc73dbbc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+oBp4qCGgvkSGucvQhJRCakEj1VwABse45wCAFEP3pAWwNuWy+VgLhn7rL+?=
 =?us-ascii?Q?lSnz/gEwJeavzCkXgYwb4K8WKFyXe6r10TXuwEsClwZN2dZdWTjg0v1zAhcs?=
 =?us-ascii?Q?TXS2lZJu9jcfxVw4xcaljTda1d53GO/SJeBqAvWJaaWld7RDLOXIJMbyNZSA?=
 =?us-ascii?Q?Q1Suc3JMteLaiEkMKSHlrYqmibVw4TPBzbBQxuK73ph2d0NVnGx6pwX+NEcu?=
 =?us-ascii?Q?kWzeqtUcvGrQI3FHDqyAZVhBIhLdM7M6U5jw+bOJa6jZqV7oadMr/WOzFdZy?=
 =?us-ascii?Q?CUkaEwd93//PeXKv/wPo1jb0liIOrbqhAb0UZlJA8hKrc0bidCw46yTvZ4nx?=
 =?us-ascii?Q?/4TMGBcWS6Zti9OQS7qY3PVpOVKCpJGRJvwNSeTOsTK7PyVFRc28LxSto2aS?=
 =?us-ascii?Q?zO2NEC/i4rUAKhDywUg2/BNQDf0Lxv1EwMhsODzPsqMxOE4k4ZFHyb1H72xB?=
 =?us-ascii?Q?JkGIiwJc0h/2DQeL7scVHcKe/pWsLCNeur027m4IgqnhzEUtf0rwhwR+WomA?=
 =?us-ascii?Q?I4CQMijNDiEbsQCPK6BWQuqpWnsFlJFWtUWAW9nS/mMzp+aWkmfveZ56LuJx?=
 =?us-ascii?Q?E4eUSwHqOZmKe200TKQh2vLPYHBBl05W1TeQDagg4kz08NQ5fASC9R9U5kpi?=
 =?us-ascii?Q?4FYHetc98q6zgWSQ2mMtW+eWw4ygNqHAMzusca1FEq+4TiOQZxnTf6a4hNWt?=
 =?us-ascii?Q?ox/BchxcccWzZsFH1GSRUft7LfLHMyPGmZQAqHeyXwy8xE/IOXjM3i3VoUSW?=
 =?us-ascii?Q?kMHFDvM6xtpK7iO1CB/KToV++0vAzIBhtH0IxE9R8LaCE8Y5IQq0WEYHz/C6?=
 =?us-ascii?Q?GHzV1TaJ9Jw2xU1qI4qHJ2Wvg/iKdv5UyLg+Kbquj8YvIPcY7NJ77CI7Ru3y?=
 =?us-ascii?Q?smso7q+w7mVzjHKFwHm1VjFocm/SMfbwzbBA1IVOTOmIhti1Mm80EH+Wo+xF?=
 =?us-ascii?Q?FnyguR0hrLwH4z2+3aOEYIFDV/PZSdUQXxDSxg6zv2sH805qfC3ueN2Vwx9N?=
 =?us-ascii?Q?FnzyffnwR1/3h6B8XJi44FHJyvm7JiqrkrovQaHKSOzSAtokjpuOjHUEWEcd?=
 =?us-ascii?Q?cYishs66GEQlkJPVXi5cxW2nS4a0FzBf4ZPlfEeILByL7uGy2An+XmFaTQaI?=
 =?us-ascii?Q?o6EAiW2Bk0zwPoQ4DUB9iFQEdfQ6oopddpCKTlsmEDtwaF1UnoJx9O5T7UaW?=
 =?us-ascii?Q?Tzi4/eAtygeaDJ5EecEJRukwBYSBXdf/FFAXUHNJm/KdkcVgPydkgidmMked?=
 =?us-ascii?Q?CGLlcjVzv4F+HmxfiZxo5vCBZXL38qNasAzFkzcoQaS1PGUnx3X0EE5C1bwE?=
 =?us-ascii?Q?xTYzsNbsqyvG5RrXdKG5Ize8s0qJYq5eJD1iVAhyGcM3kshv+S6AiJ+BQqXi?=
 =?us-ascii?Q?2UxfdvJJDkuNNxV8lcWVKN5CUVZH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:04:37.1929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff32237-d421-4de6-e519-08dc73dbbc39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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

To avoid warning problems, drop index and 
use PPSMC_MSG_GfxDriverReset instead of index for smu13.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 46ab70a244af..27ec95a4e81d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2330,20 +2330,15 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
 	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
-
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+						SMU_RESET_MODE_2, NULL);
+	if (ret)
+		goto out;
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-- 
2.25.1

