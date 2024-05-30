Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83019C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79F610EC2C;
	Thu, 30 May 2024 03:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gb7pwEqQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D883910EC2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzrgK01Ovhho4E41V+YYtltAt6h9KfdkEayIdNCGDncYAcXAr2gg9e7bu9FElE35+7639E/VPgIOJRK5+yYfObjGM9zAHhTTGKnuvkg6l2sD2M6zANsZre/Vh9hz0Vk7XTOQY8HyfMB0s10Jd9EfywFCymg0Lu7tMYlxoMRrgGKZreS2PfRHF0QuvoQh3AEX82+Axi4ZEkOVxR7AIB3JzHkqedUn1x8J7KokyVVEYZXJsYQNeyNU9MstvvbVN/UvCv2n5SA2muNx5CviTOz8aDuIwo+AXYB0eq2jnMOO4q9g6poAMkXYnFT9iMcr0OOsnEzOFhOfFPzvC6ZrBfIv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEiOpKr7MQvqIj5e07PEpm2CQ86G6EgzVj+qHme+pJo=;
 b=l4Eo48EJf76I+UYtN/MiwR2ieQuf7OP2TrMiSOFbfnIsABrwxyvnN1pKPUV9Rnr92smIQfT5gMGhg+lZ9obXPUBzLh0eHBibFjk/elcnV+2OLr5sjbigXx3QG0L31NiHg9XoFOWJTEWGPQG8wvrMQIZUil8u6gNU/9FH0dN3nzdl3lDPQB74GrCO+MR6y/3EA5FQbtaU5RseJGBgQywSYE30bgsPonioOaxwQVUaQrGRkzdTq6LE85Uj6p3qOV9HMQl36T3WBYFdbvX8E4uvPCKorXxhh0lbC6TZzbfCv/x0R+Kk90Dmr9+LFVuvYPnl8s581RQYMfB2cRPvvR+QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEiOpKr7MQvqIj5e07PEpm2CQ86G6EgzVj+qHme+pJo=;
 b=gb7pwEqQh9HFqwRjO02yGV1yL2qXDnMIalgz5NPb9azC9zar//pFYP4V1PxHh7Liz/snDa8OjTScYKeoArDttmXQUOv5ffW8UC7cMJ49bphJnhmu+/aA2HFSuxZGmBbUXOHi7WsN3trenG4GjLN/LkssFawBHLorgJ1QO5ruZLQ=
Received: from CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 03:50:32 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::1b) by CH0PR03CA0258.outlook.office365.com
 (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 03:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:50:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:50:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:50:13 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 7/8] drm/amdkfd: Comment out the unused variable use_static in
 pm_map_queues_v9
Date: Thu, 30 May 2024 11:50:12 +0800
Message-ID: <20240530035012.2341573-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaa0316-d300-4b55-4b84-08dc805ba75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?epnGW3IqsIccGBchDpdSUnCZvKKwWUVOkQBqlSXB3Ww73U7j+36cfxPi+2o4?=
 =?us-ascii?Q?C+pFUBiQBmRc2tHLyBuarvACBtycNYgtDn7rXxjx6qq6tiY5cv7cp4+f41B/?=
 =?us-ascii?Q?ryh+K+K4QQsuDFdJlZtzhzCEkO2EvJxtyEwFIcmao339c3TajYkbhPj2MVTv?=
 =?us-ascii?Q?oz81THarW84IcW/bE1oCCvYRsuzh8N70s5nd1Zmoh+nqEp66gmUwHvYE+jf+?=
 =?us-ascii?Q?7G0fsD7ZJRWJPY3TfZK5annLuNcAKJdkkvleyzl0LF1ENBEcIqe+MtAaoE81?=
 =?us-ascii?Q?wf5TJvqgfXnN7bXou80vbo/Zu0QFOE8/oWgRSgK4pVArPdyNZmycpSlxDl5p?=
 =?us-ascii?Q?YMxKVPk5ppNQF/nHRNn9s3g9GoXgBMXDYQWAaQZL0jq3zDClOH+dWg/qD1Cu?=
 =?us-ascii?Q?CeOWIJ476yR/pi12q1wKXMrxw8B7GHKdiColUhfHMCcaHchJHysVsY6pQx0S?=
 =?us-ascii?Q?rQ4Srgx8o1ZKoo+ZIYKN2ccOQppj4Sm1rog/QXg9FiPXRoawc07q5Ax2IyGA?=
 =?us-ascii?Q?Np6QqKIxy61sR34sU1wySn8gEXm3XdosxIa3XCk9HG7497LW1Nntj6eDiKGz?=
 =?us-ascii?Q?1mCtjLcmP/XOMHReLBGpWTHoLt8I92tWxLdw8Cy9tEIcjIOXiVG2B/3GYWKk?=
 =?us-ascii?Q?WUlqcaoPMakHwybNAORDGsLxrkezN8bGxrKWby9yEkzOb8Jh/CZECKBo9SPj?=
 =?us-ascii?Q?brXeWWqt5ESv4dx1UHgprolZKNpmmekOBuSAty42wtBGktD7cpcEVEhw9cqH?=
 =?us-ascii?Q?NUm4rtnEx0UOSGsxbYjocuCuZAzAwuWgq9C10HFIvHvhf/dcFybR6zOimV1p?=
 =?us-ascii?Q?KHs3ieT6KNCpMXqoXUEB6DhK9454qsmEfaknuZAIwRHns4OKNNKF4/evo++m?=
 =?us-ascii?Q?U95Wn/OkGl704mbhr2xyF+ZxzMjaXKToL2XNzATSaO8f1KNuXdlTPixroPTH?=
 =?us-ascii?Q?+69RQmW7ZCQldxcVnQEgaSF2fz62ltojcAMxMwBWBpmnSbTabw4SE9x547UQ?=
 =?us-ascii?Q?KuxGbsSBU+W8KGJj0IbZyJWxoG4G+xKRhO+nkFn6oyvrtf3ulvDgXiISYsCn?=
 =?us-ascii?Q?wND5YctHkPBV7TixDTftDkXMuE6PylOVk1MNlz8SHcIJXjwNARN8ZzApupRN?=
 =?us-ascii?Q?ABGh2ZClmZ7uomknQH3a1GgB4cPPnKJuUF1+RmZdfbj16fQ/QUNRShFINcD5?=
 =?us-ascii?Q?uhPVqMoTeuc1PvwetCYAGpVOrCGBTt6F8oqCQSCgH8ht4+siw/z56SHSljug?=
 =?us-ascii?Q?1ywAeiycxv/8yUSBoXgSibpqlyIEJ2NuW40hXUJb+6Hb4FG8Dd49C2HcA4MF?=
 =?us-ascii?Q?SMaRIilLee0I4mfCA449AFTn3A6bPYvE/Ves9mHUqr4Ce1ocSZF6ceIp/4mM?=
 =?us-ascii?Q?jau9RrEBB3sd+/8KR7kmpmvL5jT2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:50:31.7365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaa0316-d300-4b55-4b84-08dc805ba75c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

To fix the warning about unused value, comment out the variable use_static.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8ee2bedd301a..c09476273f73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -244,7 +244,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		use_static = false; /* no static queues under SDMA */
+		//use_static = false; /* no static queues under SDMA */
 		if (q->properties.sdma_engine_id < 2 &&
 		    !pm_use_ext_eng(q->device->kfd))
 			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
-- 
2.25.1

