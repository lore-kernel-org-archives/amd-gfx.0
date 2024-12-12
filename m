Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B65E77182
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFCD10EDF6;
	Thu, 12 Dec 2024 14:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WVNl8OO6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7610EDF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGxJIOogHUBDLXu+8hriTSK8OwCVZNwsTbThkLw8y/qbRzAmMoIW7JF16c/DoA8AeTG08UB9ZGsLyXb62K+oEBy6KMDO6CjnrLacwvO9r7V6SuurZou3Yx1gKuuRNEY3jDNbHz0UNgyqsXo1WUM9vqqbiED71Y7LC3V0pKmtxTvEueZ3sffae7+ZCW191wFg+ovxlBOGLMSdSxJYUb3937M4lqqkyc78USpxCDG1ofG9looSj+2b02iTK3R9TNHI6tZmeNe3iB/cp6fyaKeD3B6o3FQ0qioETb2kpCIObNR1tB9c00KwKjeLu4Hq1jJ4iROq6UfRvYwPikcMGs4djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98tpz3xiMroEHiF6QkSZz0zo2kw6Pu3M8lEDIQQc+uc=;
 b=eZuErWfGriC2cck/7RxT/NqVlOA5f6mz2RF3sxkWG6wfg8JOZpwYYkFPyAuAJLjdAGjTdQZfGY6j9xt9+CK6I5gAoIvn8ZtFdJ5WtHn1v/2sWIl18xYlwEFXNY9Z8xqgA92SKXFdAMhl3bjFFQzOgt6CbFZjNA35BwvnRretna8aUr6MgYJtie9/pN63FOyOvKLtxsW+CkodJAhr+rHKIqVthCYobssPT6C1JZJeOa4vRYoQVNEbqM0UdfMUhXCw+N4qMk0/oQJk+KjsFOvkN6EoXxrDifUCVvqVTA1N5iVATKYUT1koR9JNysDnRBpoabX3gFcySQSXqLtqk4otyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98tpz3xiMroEHiF6QkSZz0zo2kw6Pu3M8lEDIQQc+uc=;
 b=WVNl8OO6wh8KwB2S8xJLZPFop5av1BcC2TxVVojb11zLyiNqjTkBeRwgJaR/Y+PPzS0pg6vcE0h7VtyMtB9Mf+p4Ss9fzAtV9KPWiASHBhhuZslQz9Dum+hmPrbt8PylwxLw34lBLCLElFd5eYlDRPljViwi0c1YYVJgyJiw7Aw=
Received: from CH0P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::25)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 14:25:56 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::81) by CH0P221CA0015.outlook.office365.com
 (2603:10b6:610:11c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Thu,
 12 Dec 2024 14:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:25:55 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:51 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: Fix NULL ptr dereference issue for non
 userq fences
Date: Thu, 12 Dec 2024 19:55:28 +0530
Message-ID: <20241212142533.2164946-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ed38f3-7010-444d-d1b7-08dd1ab8e417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7yHsZk1PmnbwX2quzbzN8Ux9TRNgvPLLrwtucbPcA59y0KNKOFkvOmCdALjO?=
 =?us-ascii?Q?YKWftNx8ypeG0xxwtjN8wZMke2uDMM5lABxN5lRq54wR3xmmTobZiTIOo6fu?=
 =?us-ascii?Q?6u9pbRmU0obQAGASII8QMWcioITEjbuEPZ00viVi1PHCn7Zz9I0QjGHJpzYS?=
 =?us-ascii?Q?dipvYEbP/HiSio/mz3odt1qb949y90HPICbAgbj7e5f4WkilNlDCDuX3f8A1?=
 =?us-ascii?Q?colDWjbB2HEwM9gPUEZNhJ/yHR6FVjkvAqXNY8W1v0pfkJZREVs7CWT2mFYq?=
 =?us-ascii?Q?wGpY9Oy/7hb7Ho8mZ2JsSi40iCdWb6bpoF6uRjvVWn45uEXfT/b7g7d4BW0s?=
 =?us-ascii?Q?M5+qtTIebobQJqon1oYxMVVON4sO06LjqgAo6BUqMRVVFJy3M/fFKmGRYqKd?=
 =?us-ascii?Q?zhECXVV/kG2W6kz0UztEXvHuhh3+y4r30XksNaTcoXS2VSS+U6zBaRpngEJm?=
 =?us-ascii?Q?etv6f6CnWC6EIaUw/BQvl75/OS5XXJkiUd2CX/cZQYw4OnpMHC7NuDDgm5EQ?=
 =?us-ascii?Q?yY6B5mXER1wdKJCymVndJRJr7AKzRWSQuTKp+3UgT27kC62cE7mKnKDTBJ+8?=
 =?us-ascii?Q?+RyZ3MN5GT8GERDw0PozXyUTpgPlkpzaR/0518jRtiUIQmsX7lKnIwaeIm/l?=
 =?us-ascii?Q?gzvtNBAT5Nar2f2I3IIZANLEJ11ETsOdODELo+huUtSPQBoGrBDUDj9ZPzyW?=
 =?us-ascii?Q?ZjBfZmBXRSeR5B9gvcmJxb4QL0O8IwNEi/LPH9h4Cb89AL/Z+uG/IcQqqeBO?=
 =?us-ascii?Q?3PFoJRaxUswyW19sSx/oR0qr8H3V/tiLKRfmAkFOOYfKBl0DVldNJJk6KDhj?=
 =?us-ascii?Q?/fOU04wuPPgJYD1Rcyw+A+Trz/23WlFrq3g+C53JbupTiyizMlixCfCI1SZM?=
 =?us-ascii?Q?6DGRSZ82IB5K6oPgqZRu51kWCgQ62mYewHfBdMLUwNxndmNDAVZlbwH3gI+u?=
 =?us-ascii?Q?UCETvnNJ5HomLh1a3SPB/wAPl43SoucA2F3op8cqmkj0OsunCGj/Hdejys9v?=
 =?us-ascii?Q?yNKF7uFWZltt+fs4XTgylRmtUtmAcPr/hirCGTG8e8541apBrE6p+IL0yvV3?=
 =?us-ascii?Q?UDZmSv4nRckf9Of9Afog13b6hwOpMum4NZYj9ZISAlpRJKHWzXdHlsIR673C?=
 =?us-ascii?Q?g2qYCH+d8oGlrMSkvvp/aJm9i06mUfyxrr/tRN54G1gjyoPQs6tgQKY/HpDl?=
 =?us-ascii?Q?TATCpK3bj5gPxY1FfCs1mycNtsQ29ycr8+TtCM+eVlWi1ZfiNtP7iMtOPYBq?=
 =?us-ascii?Q?hFeOy+w66MK/OgMMk2+CyKofVT4xH4/h4LWdk4ZLxLydE40dh4aIpXFaAPXr?=
 =?us-ascii?Q?OTn48BlnPALSrSPG+CZouR1mSN5pCQF/irYgcC/AeceFv57I31IRPt5DEw8V?=
 =?us-ascii?Q?Xf3X1IPXGpocI6p6QE/zZteo5XL9x9cLSTIofpXwDdzpDy6KKE3ZQ8M/iNRN?=
 =?us-ascii?Q?B6B6Hk0U0OYqWTkpqRi34mER87Xr+Qh4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:25:55.8455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ed38f3-7010-444d-d1b7-08dd1ab8e417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

Add the correct fences count variable [num_fences] in the fences
array iteration to handle the userq / non-userq fences.

v2:(Christian)
  - All fences in the array either come from some reservation object
    or drm_syncobj. If any of those are NULL then there is a bug
    somewhere else.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 877cb17a14e9..3a88f754a395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -825,7 +825,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
-		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
+		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
 			struct amdgpu_userq_fence *userq_fence;
 			u32 index;
-- 
2.25.1

