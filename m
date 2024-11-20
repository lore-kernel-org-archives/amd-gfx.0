Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D6D60D14
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 09:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EF210E139;
	Wed, 20 Nov 2024 09:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J4YEaebw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7E310E139
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWKqCqYNVmu970CliSxOZm7Z+LRdBWD14gA9mWUHHC21DkLXwYwG5EkfvwGDC0dFxrFEY7O7P+17g7E6gz3JSkmf+Eu6M+WpBsKnZyt0WymnNnrW/y5KYOMsOPb9SrOz671hCpHJoUx33ALMpxwuiBFQcWZeBzKEcWM/JjVF47ljGR81BYUmlliK/0eBD2fb+wI9FaaxFz7eEfVYR20ZH4pnIrcOdjvfxqV1uplPud2gGle73V8hprdxFH7CB+I9gd9Qy1gtEoo454/99KZBgZ7jxAeNZd2XqbKWG0evy0W9nYf5xaglhQJyxahC6eqo1RRSF2pqm52efT+6j6NRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=R3kP9uUg7uNmMIyDqksQZ4aGXn70PxiA8rol5XNMGvxxU9DXKvz2A9wPpgMYpoMueNOiostGVWrmq+SOWxrXkeNd8pxVmjoygDeRvaOefnDuLoGCRvlUXYREv7cx0DdPCV+WtcuLfM1sk/Tn6flDSRxf06Dp/7wyuFiOwF2ab9ROniDdaTYkEIsAiERiK9DkgpN1KCzbLayAbFMEsm/9MsgAzX43elmNq4auEFWj7/vDpMcTAaDsYS5dbBOEM8gRI1/S+5J+VmooRCuaY8IqllYi7xgxAaaGWkbuf3gi5Cf6J32WFGDAdUO7II6Fcr/zEx7tNr3n0Ja895qf/d2arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=J4YEaebwxHn4qOtLiN7JKYBXMhgrBNF9bQMQT/y5PS+bWZ9tjQEJwW0WTLkpcqaGG4kLUUuG8HNrdp6FUCi1sjcmbuhZDmVu9JdS+aGCM5Dpn8uA0F6W5rZruMOsIyJSbfle+wsj7Vk/fDQ/PBnZTWyFbfkeL9t05HqwBtaA73U=
Received: from BYAPR06CA0001.namprd06.prod.outlook.com (2603:10b6:a03:d4::14)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Wed, 20 Nov
 2024 09:26:27 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::2) by BYAPR06CA0001.outlook.office365.com
 (2603:10b6:a03:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 09:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 09:26:27 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 03:26:25 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add NULL ptr check for non userq fences
Date: Wed, 20 Nov 2024 14:56:09 +0530
Message-ID: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5c1112-aaa2-49a8-1fe4-08dd0945691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EGJjzvsu8CUzNMHHe3ZkCcl1s/uIv39xLhqtU6BST7nvqL1Hc4DDsmUef0Gn?=
 =?us-ascii?Q?QuAlBqlyq20El5ad8VEvbhLJ9z9Dug2accHrqnAlzgb16Z6Xiwlz8q9Fs+p4?=
 =?us-ascii?Q?UumMjj1ygMJCenaAYsVhxzNJwkcXbI+gL+GMsg8ggOizo2rD3sks7NE53cxL?=
 =?us-ascii?Q?vDIJ3S4JM39J9JmWhD89316TYJ6E7jSiTm4klTp5a4ycfB2NluQlLT1ZpIL4?=
 =?us-ascii?Q?jVQ6UOvInFYBtH8pQLH4KYj35tH3xhApbtzFLesl39cF6HrQhYT2DX0wKByo?=
 =?us-ascii?Q?Y8N5L6h/HDJmSUfH+bnF9SjWVg0/oWwjf6a/d2DoadoyGGeQWxbK+zu/Fmkw?=
 =?us-ascii?Q?7KFX8O44ZtQtlsgRhVgDH32ioaBOyTYrFoog+r8BVDnd3UZ71Y1QyEZe3QLh?=
 =?us-ascii?Q?XtKYi/94Sggo3josyyMoZPX+4YN3FVH+cjtZZde0guX6uL4Tjofk2z53l00h?=
 =?us-ascii?Q?7TJpWsk5wXIzk9X5nlNAc9bpSTR+OrA4ZNhOOYNnfXggiO2qRS3GZYMkk5Pb?=
 =?us-ascii?Q?AYz0aH2EZsYsczCSL/du4VIF6u14k18n9vgECsQ8YYWCnnlvCafkkS+VKRvn?=
 =?us-ascii?Q?zRZJpXVxBZp8R7++coWfoZMVq9b16vDZLU08FxGoNr1rybUPfwVPQeMKd8wz?=
 =?us-ascii?Q?sbZLwWGCloSB7e6T/REQdAZgPUuh4RyfMUAHK9N750jGtRVmOTjXCXEbYEMb?=
 =?us-ascii?Q?uPA4aZH8RCN4m0FLMdpM97acRYpk6GMq/3MLQrq7e/UGKbvAJTAvTZ/8jbfd?=
 =?us-ascii?Q?6zBcDZ4zBC4EXFM1TnZOsVeUxqWdqMP1hmfn9+WtaKboCDuC+psVvmquUl3I?=
 =?us-ascii?Q?nZo14mjl1xbyw5Qa54FNchn9xpNzdf7/k5LOQY1BfE110HH5jShFnoNutCli?=
 =?us-ascii?Q?PL3NrK5rPDmfMklhWalTPmGwPPSbya6HLjrr9E6fZRwkCZ/8O1oEbBQ30Bhl?=
 =?us-ascii?Q?4DEYqoV79t19SNIKJDbRDiv9uk1aGspsQmNXa247j4Wq/WNgAXdQ4aVYB00O?=
 =?us-ascii?Q?3/AFGLY/dg7sp4Tgd+ZCThabBAdDw4DSVKzkvzADko4RLUmBLfWzwLdPA+ZA?=
 =?us-ascii?Q?05UPMmKE4W4x4OMIka/BCNrAadzXgEXYdFiAjFrpAxrZLoVNzr7jv0EnQ70i?=
 =?us-ascii?Q?2ypy8myEscYXH1JTEwSmewjlEJKnUVoliMr2QR749CmgUPnQPkNSnZuNN8UL?=
 =?us-ascii?Q?LGdyGmHRAdm6g2iveekWrKDFI3PJWy4yfuux5q/EMKByfrmN/K3PAqB1udfN?=
 =?us-ascii?Q?FBuHrVCBxYaUb7gS8NMsIn94zP8IKzMWjsOCvfS3FZdX5qJjf8uqfFCt36Rj?=
 =?us-ascii?Q?C7hgefWRiwHYQQMAgAyv053QyNjBhUDkXcbmaki3uUo2tAWHoCPODm3+4x+W?=
 =?us-ascii?Q?lfV++e39SI+v47VNaZhJhny1M8ZCSDDZMr1IMXQ+cAW/Agi9+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:26:27.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5c1112-aaa2-49a8-1fe4-08dd0945691f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

We are observing a NULL value in the non userq fences,
thus added a NULL pointer check just to avoid the
NULL pointer dereference crash.

v2: Moved the NULL check above the non userq check.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6157a540c929..76f7babd7a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			struct amdgpu_userq_fence *userq_fence;
 			u32 index;
 
+			if (!fences[i])
+				continue;
+
 			userq_fence = to_amdgpu_userq_fence(fences[i]);
 			if (!userq_fence) {
 				/*
-- 
2.25.1

