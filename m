Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133CC3DA70
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 13:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D3010E993;
	Fri, 26 Jul 2024 13:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQEqnAsg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0053F10E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdfWtw8ASh4PNpGMJsmbgKXFqr5sOGm8DI0flXS8g0FCoAHzHP4XIo7Ut9h6KRbfk9xAlT+ECIntkzb7Oc8AXQUJuPDYvJVERB6X9WftSdkwKZFMXnLdjG7dROxwAxrpH8PmXB2wpPGcXX5ALmgvDDl9BeIXbTS3PZt8yi46urI+FH4dF4hiBjK0R+kTTt+GcG2T07lLIjZtnXQuyu+zn9OIFJJEQ4llDtn/2zUhUp5AomlMeLsjJ0Ie6ZPLrXbxXFthMJh6jF9M8NOiLVQ1bQXW/PwPYzlxn4vbjOeOd3tdA8caMcX8KyAUC5EK4m5ejXWOpP8eZQ0xRiBdfaX1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6qWkNrC7XD8aHWlsRNCm9+EoCzyvBabV1kEfMbu2ig=;
 b=RTtIX+qmGW/8z60KgJ0he6Xkxsq5POT2Z302+y89tg6mOSzMgvSBOIB99cAt1DLa9pnvswJ4p3pYboHhBZx0EoRG+2Q4yglIWH9OW/9ABXAualUXevo1w366p2Mu1n9j7LSWF4DBuChYZQBUPp4Ev2OAxlR+RE0NDudjXdRgTk/vBVyrDP13sAg4b2r89mNH7UOJZT6+1J0pqbN3tgCOxZ9faNNZKUvFTiz7OrNvqYR8RFDRNqaouIaQgOA3lTbAxFPGnIrdQW4X5MKiDm5duoiU7nIET4TXtSL5Q3RdzzLFHMQQ7CDz0LDJA/NTkbM2bNlDlVcifZzLIR5HEgHIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6qWkNrC7XD8aHWlsRNCm9+EoCzyvBabV1kEfMbu2ig=;
 b=cQEqnAsgIYdZxzr09O7rC5KcGuBMdDjZs2tSRmXCqaBNj5BScrU4VWprvdWIErH5gtM72e1cqq3qJUaT6B3jeE377+VQ8W97dGTsXG+5/itcL1zfBTrGnc+uNc9S4IBZsLbwbmitG3At30UrI+tMnYUEV+Q1NJvlu7/Q3zqzGJY=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Fri, 26 Jul
 2024 13:41:29 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::75) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 13:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 13:41:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 08:41:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM allocations
Date: Fri, 26 Jul 2024 09:41:15 -0400
Message-ID: <20240726134115.36802-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: aec6efa4-0c47-44eb-f815-08dcad78a713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZxxIKUsvSzGf+HqUEuDCVXZbAIHzCDAqr/Lb3FtUt1uJWOOAaiTE7AimoGxE?=
 =?us-ascii?Q?645u7ACiNbzrTRz+/IVGPe9IaWfqqnu3/OWtccK/KIPJUngdcXxNEgcoH6zW?=
 =?us-ascii?Q?8zNTGOCHGXxIejueuwXZAzXuPgfk+3b/bFmAFgno02CiQz8Z5OGKt80YCnmw?=
 =?us-ascii?Q?3cLenm1+Yb3xMrsFIqnjA7S9aGhle2s7cX3yDpAwiNglGp4v5nW8dL2IBMd6?=
 =?us-ascii?Q?schPpCAVD7LluGHNkhA5MIvXTb+YOTqtoESAMzDtQRWN3JdlhGz3LrX1DF79?=
 =?us-ascii?Q?19mOlLwrleSsNIcnNb+f5ySczi2V3El08qjf7fAL7mv9Kn7AZQnfoDGjpeeD?=
 =?us-ascii?Q?OWKfy4GOAeeK7UMNGnRXQN3gv1qJ/snFzyq0JbL2Zysxm1cdS4HQcLj21WzM?=
 =?us-ascii?Q?Ksr0AwhVbW9v4w3GJCUXDFUMxxRwKMcydfaWgS8YCTdoyDw1910hdArveveV?=
 =?us-ascii?Q?SvEBrrCTMSbvVCRM+EFeR/tXqxaVbpE2A0LvphP1zckhlGmsGHftZoNaEF/E?=
 =?us-ascii?Q?X4O11wMkM96wbOxbjGJPqDTNzZQ+dk4nXco6DMbjRJ0xgxTFmC0IKKoPqS4A?=
 =?us-ascii?Q?fDpmfvv3iL6EBfU9AaVjqqw3bdN/8ldAs76hAriXwazVpK/z5VyhS2e+/f1y?=
 =?us-ascii?Q?VA7/JDuRpewzRCQXYyiLEHLxuDtZ0IM++5AohE2VecOv3lv1h7/k8x0U64nN?=
 =?us-ascii?Q?aTYsBl5Lxp7bj7XaLHugA6wuAoFrMxr5X0vJJPjpLUvPYaTdRkYVhxL4c8uQ?=
 =?us-ascii?Q?s3X0YFhYIPQmTZEFuZbkXKSnmFk7I1F6q/svTW8QLDGrIH9HpPCgYijY5XQ8?=
 =?us-ascii?Q?MClF3wDq4onG6uwLv6UxeGDDYk5O2J8A6rBVLyRFhq8flEeRRzxS7egzZUkD?=
 =?us-ascii?Q?5hzUyH8CY6zca4RcteidfHuxm4YqxP5VA6Ngkvwg1+phFbqaV0YpWvijUWA7?=
 =?us-ascii?Q?RaGBTRu/Vaaf5IkesnpANi1MOL8THSZAYCBryMd7UxIGbrjA8jHZFHRLG+x3?=
 =?us-ascii?Q?qwcVINV7Zqd3yLUNwPMBIeDU9SHYDfMRdOCg3uIZdlRtwB95qRCQdioamDnu?=
 =?us-ascii?Q?PMkruULZNIopFbvmoKOSfZzWXQOIU1CcE0PfmyVFwUT+3O4JtREtFPqVf6Y3?=
 =?us-ascii?Q?5OUQ+Ye8CkFfWSYp2bnWJyr9KcSWs2+B/Wi5bBay+wokqjaqfdpBPcT0w6rR?=
 =?us-ascii?Q?kB571w1Y5AV46ZuJVIqflV+kGNAGvo2BEf6FKxfRMq4eFCKABYLFasaUSMKM?=
 =?us-ascii?Q?bJJ3cZGPE2EoxUblgcSE8DkebL3lyJ9DDqWU7shn+9cXlTYhrkCKP3yb3ckU?=
 =?us-ascii?Q?7wtiLFPW2LkcMGhY+40hABZFCuE0H8reGPnJEgQTqQTYuJ9uHXNIpEdHzAWZ?=
 =?us-ascii?Q?FQaDN1rH/x0yPnXMXuJEDuP3A8/lPjVikQDNDfdLIwqIZbAM6RHS3rhoX/wv?=
 =?us-ascii?Q?C84NSKc83MzgM/ivq+h4QmpLgPnQ/m/c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:41:28.8677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec6efa4-0c47-44eb-f815-08dcad78a713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ebb3f87ef4f6..768840e8937d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -347,6 +347,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* always clear VRAM */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
+		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.45.2

