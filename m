Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C6C369B5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F4A10E56F;
	Mon, 14 Apr 2025 10:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xg76+kSg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394CA10E572
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJaZrVghEJsc9hFE2qN9hgSRI01KWJAxEg4nc5/0uerx1bKP/ZfVsGHmNg9hZvjhta126Da1rYNxdRV1vv23UxBV0hRZgejYgw8UqCB6HoMgzkp32J4GbS3wBnCV95aX2bPtpOpBoifle80b1eq0LU7QObBcUiKpFZ7VAVCoC+emw9omAWK6wTHKU4uur1/3yj8Ki0G0tOH0mAes9JadPz/mESEFXFSYqgeO5QPM9jMkDYfu6nZLGk22rb4j8XtlPoOtlbiDr4XM696Yn+NBTKcTV/5Nr9V/HyfbCcIc07XRi6A2sTZzRd0dzrEMJC7JoA6YNurUjBqCvRFpXlB05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbeam3VKSbWS/MAZOKu8qoDLuj6OLcsJi+i+JRNT31E=;
 b=gGwffasor8H61eSLXIaOjGnHmOk/+mfHhmF7f7+t3aFkAZmltSQJjxqDVC65Q7F782aKxHNV6QI5mHYqqe+WBdNo+Lol/OQ4Aw2YhkUAZv/AU0grw6k4nI98PNQ3foGVhsrlUOT4FzPJUhQgBgrK3Fa/oshFusQh1+HRfFynzwxiS9v0HjO5p4XaM3vTjr53HEO01bF9qGENXlR5QgCaK5OALM82Wk2z0DhRaumHVdPrPe2nNANYi5IMPLe87TU3k7SZAdAcQ8g5vwaRhqyqQFz9YBp5uW1YpSKL14vXuP1IlrknLklQtDBJIE4ORZNUVckqu0xhcRhg/p403BMkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbeam3VKSbWS/MAZOKu8qoDLuj6OLcsJi+i+JRNT31E=;
 b=xg76+kSg4eNhyvs9napMAJVLJXj/n0HNI7cBFENtIhKZNIOTsQ4sdIHX8pVSVVPBQFq6AqjIHUG6rcGdJacaPfHKTRzpTb91k7KCT1Zc6jK3Pj6YO1NIXjknQW3pFkRgnYu7TDWsSeP7cBZ3AcKHhVvEeRyuA1UrBqYBlGheZro=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 10:48:44 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::99) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 10:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:40 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:39 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: fix sdma ring test fail when resume from
 hibernation
Date: Mon, 14 Apr 2025 18:46:54 +0800
Message-ID: <20250414104655.336497-6-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: b57aa2fd-f04d-484b-964c-08dd7b41ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DG7a6fti488IK93uSEl7By1MxTmj8fBv0G5MiOMl7GD6JDc/toY8VRHWmyVB?=
 =?us-ascii?Q?MGPDZUZTjHQWCsMPO/pqtkzT85b+daOMrhBUyPURlg5X4DkAkiW3W8p6MnOo?=
 =?us-ascii?Q?eynDpWiTLmNbS0CVaCR/1AjqZxcsLiWT+gJHy4PB/WOGsZVoHYhyDjlH0CXQ?=
 =?us-ascii?Q?FMBteWyhs74fowwwXNoNMCbb9RwrWi4MU1QETfehm3NZ7h6wk5KyNM+bCNTy?=
 =?us-ascii?Q?BxHWLlKfjG94CTMkmQjM8XF4vBgmTbcFL1v/M4hnCIg8SR+B2q1jgQxBDXKT?=
 =?us-ascii?Q?7NuCbQB44BXqY2PT4ZYmYz9q+w0QKE3UARiUVAThVER8VWFgxkiat9l/ojde?=
 =?us-ascii?Q?FVlnCG35FiHycmzV70IveA41RmdeGvkWw8pLBFxv3oGqlKBzfThd8dyqaHML?=
 =?us-ascii?Q?9nZ6eQSvjNqgnqu+p6BNvW0RiluBEFY+qzw/0fPi9IWPEx0prUulK59kx3ZJ?=
 =?us-ascii?Q?qL0D1OJlWz4gfmfE+XQDXwSd8Xpg7/Q3aIga0qYKFf1S7JTXQGf/r2pQcuGe?=
 =?us-ascii?Q?TrRL13ehLnJ5kPbld11gPuUhZYUAaCN5kmBGV1ZIl3Auj8mwtOk3mpWE6B01?=
 =?us-ascii?Q?Nn0kc+3JjAcKrM1xgR8ScUGMHqsB8a7xqa8H9pQAi5fq89lgwb/GlhU/Bd7/?=
 =?us-ascii?Q?Dt9G93Rm38kDBFuP7EDJMIg5wMydpaotP3HfgzqHopkHjAddEelH7OSpOCG9?=
 =?us-ascii?Q?ndqaA/AefKeF45a0tyP3cdPMEyuVj1U3HaabbBSs0RC31SpcBzsnIy3XSWco?=
 =?us-ascii?Q?h1MgJYo2DUxf7Ad0mqxqye8T3Z6bEhMr56tmgLXvhdrlkAI2vRtMX7j7ySUp?=
 =?us-ascii?Q?HY9FwQs9S86CKnQNBBK1Nf2Hcr/LMDcfzLw9T1/vbdUZiiaQnmIN7W6a9tlS?=
 =?us-ascii?Q?9wq0pqBd7oL/6MW0AY3uOa3U4b9GvpAtONmwcY1eJkqlEfe97TIoUF1bmFeV?=
 =?us-ascii?Q?Ef/HHGX9stin9f0UmJq1rNq0t/eb/AZyQqQqvx3t2YbS9V7yvmJfWTQOdxS1?=
 =?us-ascii?Q?HJrmOfQFX+Ip8ApGyKm307HFsZWCZcOdJ78JrNYwS1U8xd6Y6PiRDgFQX3IG?=
 =?us-ascii?Q?LUueTPXU3KBA9QTHTWyTJ8IwhimQkTz+YWPTpg9iYfpMwQ8gLq801kjf+B6L?=
 =?us-ascii?Q?cKlyGm0USdx5wRUY/EIPOHNTq1N3jVGVsCmwhqAwXEdZ+t5pf0abjoxEoY9s?=
 =?us-ascii?Q?rLCsLWS3YshdPWkdUBHyYMtkWOwfNCNwDxeTEhH5btNf62RrMyjOmx6Uhda3?=
 =?us-ascii?Q?AdI0T1hWoHXh6tp/y4v8wf7udl5Lc1y0YjaV0b+EpMUVfFk3mP1pvlLOQ9Bm?=
 =?us-ascii?Q?+k1jZ3qt7x5w05clu2VmwlQda6ScXMNlujg6aV6cOtIJXR9pV/iAetNESsDP?=
 =?us-ascii?Q?HsMTBkT3LP/UTIYKbzDHXSMuPrhMyDgHD02MgHO2tLsa6LiWTRKXwPoLZLQb?=
 =?us-ascii?Q?EHM6+JETfUfZ2QmAdVBaP+HNTz65ZPYpdb1gcrtQu+MVk8KAQdu6cvtTKqzc?=
 =?us-ascii?Q?VqJecNOTl/YoYWef54sFrUB08CQMWglaJdi2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:43.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57aa2fd-f04d-484b-964c-08dd7b41ed25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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

gart tlb may be staled when switch to a new gpu index. this cause gpu
fetchs wrong data from gtt memory. Flush gart tlb at the end of gmc
resume to fix it.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: If2a3780319f5ecf3dcb0f1c07f85151ed65f522d
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 73ac05b9a1bf..0e7957b4389a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2543,7 +2543,7 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	amdgpu_vmid_reset_all(ip_block->adev);
-
+	amdgpu_gart_invalidate_tlb(adev);
 	return 0;
 }
 
-- 
2.43.5

