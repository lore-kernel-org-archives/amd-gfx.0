Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF84C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0071C10E0C6;
	Fri, 10 May 2024 02:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xDUCQ8ZN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E5310E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr2ck4ewKFyJqhQyPs7OE8gptOxJDc1VG/Mnve+hkfEpIzb5p2ruDFi+5YWtjCmm8DjFgGGUPoKaSX9GTZpoafnwKzuXcCD+uex/DeuVgfjdGR1vXzJuL4SuQctrNtQI5N0GpFm1ynK17gDs4CDKoXJULcMJWdwde+pMz8DZDpRACQT/JVnGsPRtOlLwbRZ/FL8XCRpRbB4CjzJVM4Q5JZ+yT6PTnXZFTjM7Lcia2Po3xNdrWUUGqti13MdVYD8iYF+r5lENaCoF4DlFb2YorNyp8jfkl2xEb9Hztu5zIfzq9yKJ9GQRD6R8DqX2qI0GT6B0iLdcl/fNJ472LoDPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2PhoJoqExWNWy0tPSQiv7V/yJq1lOXcqMY69LVImgo=;
 b=IgCmM0eflwxYNIrvOkYqrM7u/Wd5fb0KiiKOaL8zYSdy3oqREZEaiw6QVJLfsKRE1qvqH/2OeKt6I7+G8nar9NT3iMapH4u8ZuYKysVId64CNYo9dJ7SlKQhpmVT79fodn3mAL3Kp8a+8fJkX+ruLPAjIOg8oI3w9ebsPZ7MWJ6MLgu1ADWegHdmU4bOPhzvQu4MR1e5rSqTcSa4QKXlGZ/Zgg+jvJ7IIvj5Jb11YXAMmOeEAVkJSdZrE1yPW6qoCGnwn87Xz15ntdrIC52QSjCMtnPby1ZVYCUIsLVxmq8ENXM5ffQiryTPK6yPalG4V9D1kg+gCXmR37UCkU9RDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2PhoJoqExWNWy0tPSQiv7V/yJq1lOXcqMY69LVImgo=;
 b=xDUCQ8ZNnBTJXFCqIXGqSdLeVqUf9FHvI0h0l4nkTYJagdNY7cJ+l7eKXM2pWeKFunf3e0gI4NFrvKeQzGxh9XMIRAriz8k1pXeHqj+mTCj7j6mR5UvcHMciOY2uLmMYmk4UccY4aWyRt4jndqvuGKqTHhrZLv4U3fZJCkewWw4=
Received: from PH8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:510:2d2::27)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 02:52:23 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::ed) by PH8PR15CA0008.outlook.office365.com
 (2603:10b6:510:2d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 02:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:21 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:14 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 06/22] drm/amd/pm: check the return of send smc msg for
 sienna_cichild
Date: Fri, 10 May 2024 10:50:22 +0800
Message-ID: <20240510025038.3488381-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 696681e3-0578-4e94-f1c1-08dc709c374f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEXBUo+7m71ibUA45nCIJyyDYAO4KD+M1Y3UQfwgDvglxzNLaTVMMHfNkH64?=
 =?us-ascii?Q?SnCesBzENZajBaMYRw/TGNyqA2U4moglC16Os/QI6kuSDTG8hk6O/CZFAA2N?=
 =?us-ascii?Q?7sa+ihbcLkSgKXyma8FyaP2daypyeFoI8DNizIYEmCTXFP73/O1eHiABDowQ?=
 =?us-ascii?Q?KdqE3glMmMRYgmAlva19HTgWmnhzPSKNOIPQAXqdZllg+vGEZ5ZBIiNP5+0v?=
 =?us-ascii?Q?1ZBC7U+thimmkqNGQ6s6TP589l9Y5yVcRm2LHeZIwRPVq437rDb0+hn0w45X?=
 =?us-ascii?Q?0B2qcbPB+6gDyu1DeX4xaV77Mw6Kgi9BuYigHH60U8o89H32r+cheJiQiz5s?=
 =?us-ascii?Q?Bxl46fIvLOStbdw3O7uDP2JAhdX431CCEDbA78SDVWCWrr1HVczq1v0u7mik?=
 =?us-ascii?Q?vZ7phB1KoWuIsTWundzPCCIxYJebwYRpon4ftseeuByM/+sukN2Nec8c24ja?=
 =?us-ascii?Q?DERT3r0whHZlaOCR3yK2rXBTGbNW1A0kwbv9waDpdRo6nwXnC6jYdMgLgGze?=
 =?us-ascii?Q?hSewt5H6zoAyBJqZgo5jvv9dM0/ghK7Pa+kSr1rG1tIpTkV5BXO9A1BqlUv+?=
 =?us-ascii?Q?wmDUKnW07bcB1e59+P4SxoNN8adrNkCiEJ/8A2PWWezmjPlo1XBWQD91giQe?=
 =?us-ascii?Q?YR3sMXbiCQCZxOppN5qPmTV23tG6X+fsw8WE/H28sertCEhd1H0VRBNUQHDX?=
 =?us-ascii?Q?eFWBFFGAw8aK5KdbJYK08ad0v+o8xtSrIYTbMdO2Fi9tKMlhqzQcGKFpCaKs?=
 =?us-ascii?Q?gAjTyUr/5HBspuBKIVMR+g7V2jyhXLAT68ackSYvy7cGG13yvxzEwCYzJyA7?=
 =?us-ascii?Q?i/yHMDqs1lAfaKS12pII40MgHPI0hID3yDeerYTJckCKQd1AVSQ1v5Aw1LKR?=
 =?us-ascii?Q?egdbHDSYT8Dh0yoE6vuQi8d5jpFPeQMYs2rKmB3fKF5zP9FuPsGY8F1jHhMF?=
 =?us-ascii?Q?yWoHMiMM5XxK17sNmJYMhPtgTP577SZWq6DP+I6EAp78CxtR6JenrkvMrXG4?=
 =?us-ascii?Q?4oNn36P+3Ba56SKmol4Fjhk1DhIS/UxBC5LBNdRdNYsFHtjO1poUY/6z7Z72?=
 =?us-ascii?Q?EdkPOsi8U4IU+uEPf2/hKBJTE6MlkJ6DC5utTjnq3GvrnzX6KQruvIpSEYRE?=
 =?us-ascii?Q?Zwjz/bUbhxGIyZx5JoSuItkk7n/7gWAiqmWqOT36MDpKNc3gro2FCuUbUR96?=
 =?us-ascii?Q?alHdLojhpCB4b58gql9eZ5xH+jZvEwb8OAtUdKvpyt1m0x68yoZFYDC7cSPm?=
 =?us-ascii?Q?XkmLrH88nqfyYYgVQ84umIYkGC9qGKgG33LYLdOVEJyCyAcym6LTFzXBerxy?=
 =?us-ascii?Q?Nq8PM5emPFlMbi1TjpgiUHRPMwP7bTJh1dmarxYbABHHA8cn3/EY2wMy7wDN?=
 =?us-ascii?Q?h79ZPJo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:22.3713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696681e3-0578-4e94-f1c1-08dc709c374f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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

Set smu work laod mask may fail, so check return.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e426f457a017..e7ef8cb3a791 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1782,8 +1782,10 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
 	return ret;
 }
-- 
2.25.1

