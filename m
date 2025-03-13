Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D06C35FF4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E0F10E8BF;
	Thu, 13 Mar 2025 14:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TK3/KZ4C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5260110E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxer2PS83Qvxm61gCS5nAtYdaJmB2pZ2C9aN+HsfqsKdT6V8jy12tXzWMGK2PhbpslqcGYrTfdbmMal0q+Q5MMoYbJv9MEtP3X4x4w5VNg0tWcs5Pm/eezg+OuIKiDFcr1lxBzWai8cmZHddlF1/dKOLATSpt0mRZbvY1zxPp+OWirJYuny20JgNLYiN12OqOCegQzOHTaNdo2RfeUwUw1zJ3dD6NJ0x3fBD5UpkJ6xvbKlQsGOaaFc9chjqebYrRVBjGEtV2kn1LCrF5oinfx8mztgx8PmC6npygUACrTh/kyPq3fOMlDnPS6yfAu5UqOeIHEPMWqc6HBVkjc6dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o54aIPEtHSjU3Z0eCSAbQko3SkxHkrasq+bXzBdqzgY=;
 b=phJ0e+p+Sp7UOaaJuAIj/u1MdE83jtdhXEs8QBcAmp0sV88zgKqFITt4k/8n9q4Eu3+COwidLUZzb4HHh5pyxO6re11JuFtku+ot6sUcA8qVjkFL7BoKtcIboMk1HB2l4QukQO3aTJ0ytOUG6bJ8jPYNwVdDi9rGqZI4fWdQriw0rUaI9fcekAjuFyr/cpWLaL+o0MjPNd2FMebltvfszukxsLBRBy7WLKG9xI0DZqmOp+W1Ao2WjIGUWJ70I4VzkAiJLQMZmdQApEeS6W9J7fyjiSkwVY+kJ0z3ozwsRWIIsoYahIchq8K85SFSQg79t2qx6aePO3vYn17N6f3bWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o54aIPEtHSjU3Z0eCSAbQko3SkxHkrasq+bXzBdqzgY=;
 b=TK3/KZ4Ca/B+J/6UUQ5sTbEF8rfOtoobsr+GuV2k/7cJi5/SamqndDU715FvXLx8/0JXeS9bPSrNl3s8l03Tg/Uf1poQjRGtu/J38I8btDcElbViLoUmFk9zDkvqjSVnQ2JGiF/G57BpYVZ4t5nCacTA8sZzgshG56cu+iFSnbE=
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 14:41:55 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::fc) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 14:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Date: Thu, 13 Mar 2025 10:41:28 -0400
Message-ID: <20250313144136.1117072-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9b3850-4bf4-4c26-24a6-08dd623d3345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?15eBGvpWuzzc9fV2rucYKJ7L94NPeQ3pnWjgCG1YE4XxA1mAYDpJpjE8RDhY?=
 =?us-ascii?Q?jyuqsTJ4FCVKU0JQSQDeaI/ExL4OOCP3lm6gx1D1O3OXX5vQzSQXAOdQeIP9?=
 =?us-ascii?Q?8DYLp9Hh9PC1C8a5OWjCl/oaGHbPIOzo+DqvllBoDmClbaBih7WNtu6GJD4z?=
 =?us-ascii?Q?TfIyW8ZAkXn6lydoq3Ko9/c2A6QkBtWn1A37loWrMkx7/WeoWMIL4/8Qqh7z?=
 =?us-ascii?Q?xUB3zPtt99KNQAgAMdypYJ86l0bjWmmTwu6o6Whbd1VqTjf9N4qefkugJLfn?=
 =?us-ascii?Q?jPPo7l4v16Ggzgb9whC0r3jcNpV6WlSXCJg6eMdkyTuKBs5Q5T+u/rfej14A?=
 =?us-ascii?Q?0HvFzf1hz+XuqxzaeJwEWeoLaVwSUgLgu9jyRiC1XCCKoE2eAXu7v7yPZJB7?=
 =?us-ascii?Q?RXjo3s4wauY7CbrCC36t/4M7HsGcqAGaHn7GJvcO1mrTuZsGF5E7e5BPmsMM?=
 =?us-ascii?Q?F3x+ePyU5crlOyWUrl50dUc3MHDfuoxc6XKPdtEbVvk/rK5ybtVvhcqu+X3o?=
 =?us-ascii?Q?qxJQPUcVMiuPSA5Hl5ybUOojy2hT7KJKunEGC9jFOUXmS98c2bj+hWYUIQ3t?=
 =?us-ascii?Q?ogOS6pF/HfLVpw9rJXRe6mjKFx7fomICpvAZCsU8HA8MD3Xon4WlFldSXC1B?=
 =?us-ascii?Q?g9GvDLz+c6aPY/utTO24aJXRCsXtBk4AADbAJPzxRBqnLzX9ZRE4AS56EJuU?=
 =?us-ascii?Q?Xb6q+oGq2kIZ1HDLcwE5GV1aM0esrR3R9EMIxzA9oyLsWGqcjX7Rt0R28YwX?=
 =?us-ascii?Q?Baiu698DvT3j6wEXyVUSN9ccoV9iajN7vgs3VRE2a7b0goA/AQAlvuRRCNmq?=
 =?us-ascii?Q?5lwPOixr8gAMFWZtJthAaIYLgX2RTdtQfpss4IAVj8+ExAWP7hyvS4LuOJiw?=
 =?us-ascii?Q?/cI8+w8fmxDqTFR3a/1jMJjrDCzmWUzxrUAOy7/d6uqdHQ3q7kSniZux8m8R?=
 =?us-ascii?Q?NmElrdvWlejtZ/0w2gHWyfohOEbACp08a/qcOSg60rXdTnePNFTE1qhd4PLa?=
 =?us-ascii?Q?sOyjen5SDwzhGoe4VaZWmDMHj8p4Ag/0XPmw/0/6h7ZaJ5g1nnRrXtvJV0Bp?=
 =?us-ascii?Q?mGBgfM7LZ1DbXkUf3gMiLn69rVKZJ0NXZst7j58+BWfOgBRwNzxyPuzgvvxg?=
 =?us-ascii?Q?pwtf40pvfMyMYnM1XIWNdKeIszDyWID1267F0os+w56KucwKqodLdNFfbQzS?=
 =?us-ascii?Q?2kHPpyPLN9oSZT4uCcBpImeywmcz8VY1r09WLdZ74UJutMRaTqcLiUPGrBPt?=
 =?us-ascii?Q?EiWTywuQUq1ae9VwsZ4WVuOjwckBJemma4M/NS8UGbi2OU4Fxql3Xi7lvbKu?=
 =?us-ascii?Q?f1uivTGmVDbAVndkApV0UXe+LjzWt5wzITBV/TdTPcHr3TiyLzo9BdGd7AqK?=
 =?us-ascii?Q?aEj9eUJ8PEWrwOLTe9pFRyP9AmTRaTqYywCClwyAaZ+hinVHhFHi7gVPBejn?=
 =?us-ascii?Q?wO+XH+UQFfSvDx76C/XofzWMrANypKvXqla6L/CDKHhs8lMtUQoxkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:54.8706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9b3850-4bf4-4c26-24a6-08dd623d3345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

Add proper checks for disable_kq functionality in
gfx helper functions.  Add special logic for families
that require the clear state setup.

v2: use ring count as per Felix suggestion
v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 984e6ff6e4632..a08243dd0798e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 	}
 
 	/* update the number of active graphics rings */
-	adev->gfx.num_gfx_rings =
-		bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
+	if (adev->gfx.num_gfx_rings)
+		adev->gfx.num_gfx_rings =
+			bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
 }
 
 static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
@@ -1544,6 +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if (adev->gfx.disable_kq)
+		return -ENOTSUPP;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..8fa68a4ac34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+
+	bool				disable_kq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

