Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D15C02193
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 06:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9E610E25A;
	Tue,  4 Feb 2025 06:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJVyEMmi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5C010E263
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 06:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6Na6IFbEfKK90utQ2bsMKUhIBj2aFYgGtVW/PbhnVELHzjHs+/FTxgPpLu+lFD/s+99QAyKwMHqSkQwqE1U6VcxDmj/0EOe0aJ5Qj5hiE53JzogHNofW/N8uMwIbLYVQYVuRd/TNrrHxim0o+zUt7lGlb3Ozc3KlIwfa0Y5iNtNEmil0hZkK6IDu+RL0Aq8IMy+0/iF4gYPsvRrJMJzLJB44fc25g9LUxFbbNzzdtH1RaGITx1rwGiurgMDXX6hALO0jHXguvIXQ8bgfcRN3eOPSgbbKd/ZrUZFhETbMUVOFgJK00jFDvynvl7G1Pr0SkRGrudvwFUfCHLCz5MARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD+1rXjoF4C9MuHJAQfl2w/hVVUrW1cG6saL+36a8LI=;
 b=lfaf8NAbDWQk+4UDLro0XommZ5r8xLtVsy2r9KWIqbAG8scpvo7Hu2emfTVlnC+mk5M0T844u2Qhh/NyPByvOC3sYSbSv+7wubwXVkMw5tWF23S3NBn+wTOkyaSBpDzsfM1t66Tq1Ymmy5jX7E8mSjQ5f0fHb3B4YSq+/JaxjuCk3P25bAa4R2poIEpvVR/HEPbMJ8asqBZzYB8+zrH9yvaqE1PZq36Pbh67w89OfVg8mzpG94HLbtQuYG7o+XCYLOdvs/dInnU/QzyvAocFQW8x08KKnTaFssq8YqNvxCKXKld80DCkaEuIV69JcBwUq/LeDWlXPuj2cwzp6bxnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD+1rXjoF4C9MuHJAQfl2w/hVVUrW1cG6saL+36a8LI=;
 b=fJVyEMmirZh5CwLLvhM+wr1v+hvxaJq2JC0G7LR7xl3xatEHEZq9yn+8fqKMUjxe43nQLREwTLwfVM4gKTPhrwXSELZ5n+IPEwMVRw4rEdC4W1r64RJrRIYN1sfE8TROTOBvcQD5GvRDBvYp91rSd9mwnof5YZZxOlB5IBcGqI4=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 06:38:43 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::9e) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Tue,
 4 Feb 2025 06:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 06:38:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 00:38:40 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kenneth.feng@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Remove unnecessary device state checks
Date: Tue, 4 Feb 2025 12:08:17 +0530
Message-ID: <20250204063817.1865562-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250204063817.1865562-1-lijo.lazar@amd.com>
References: <20250204063817.1865562-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 50119c52-f2a0-49bd-6ca7-08dd44e6919d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AM74DHZOw3QAowKUg0A5mAFDe98CuoYG7N6kDqVd5bOMGGMjkflBJTXGj4j+?=
 =?us-ascii?Q?9WKB2sWEZYbtsbuqUrIzVLAcMTMe4d4YErlgyzDEnQ6xfH5hEksbcgVgHSQ3?=
 =?us-ascii?Q?5DkAyrYhSqQOFvuXskSV9+xL72NiMpdsNgZXUw6lojs+k7vNv7i/tJVx6xVv?=
 =?us-ascii?Q?10Aw+SaAGaRqXoBkfqjgPU+tp4uYek3IN+8ES3Thjr0/iLLKjID0w9qUcWpZ?=
 =?us-ascii?Q?f3X9UWVbgUEyJVRTR6Lxyw3naQwb/86csEluJD9QEkqNYaWDQ6IuvIj+W2ZX?=
 =?us-ascii?Q?dcT1/rUiuq7i+SL6Z5dUzpxE4UItllsCKeQS2ZL2uVktExVHd5Aag8uLT1AP?=
 =?us-ascii?Q?H+/4178H4qDyDtGoBHp2g74WnNMVYVV+7rxxNKJ9ciTEPTurmiRSpXjDJdQ5?=
 =?us-ascii?Q?AcYnYndtc8plV22nw+7KD+ySvmc2re0ub3Q7FJar4601nr+8ISeOplFbgeB4?=
 =?us-ascii?Q?Fz6jNBmBK4egOAzy2XjbXSq/HD9QDF2ejAWin0CLkh2jNfPb0BJdmTUFKTOA?=
 =?us-ascii?Q?NOQw0QcZIAwsHoL0aB2+WgF3Yw5FlPV3M/skEMakqTgA+6S3R1fv+9BzLCq0?=
 =?us-ascii?Q?zwozrrfX3KCIeEZBf4sVroCuDzaXZRTsyIFybrMoDBI8WdGoWyIDL+p6rpCv?=
 =?us-ascii?Q?HgtiXuFpMqsEKFXgeR2AbRZOGJJRUQn04u6762L/lqSFHRk93ZERO/ZHVkKi?=
 =?us-ascii?Q?gyDX94KxKmJbd3GyK2Q9kqf2QvcRvy7sZoJUzgsGbXRIpmjjiZ5bIekCQx+Q?=
 =?us-ascii?Q?aYBXrPBQYcIKtXgSMICCsQG2PRxjw9u7qLcHXhBv9nzTDnGEChaSBFwzPq6Z?=
 =?us-ascii?Q?quu28FP5qAp685Jky1rk5pMqm0GCYgaNftOQaZNvYWz8TSmaF28fGemGvC04?=
 =?us-ascii?Q?T4Fq+nzaFfj6XWFNgmtC7u0nchN/ToBNbQ0Ugk4B8NgsUC1oZ1/es5Buc+w+?=
 =?us-ascii?Q?3rrXWi317xczYDKflm0aX8xGoxoW5H9gG9j0CJETKQy3eKHqiSpcFQCUDhQk?=
 =?us-ascii?Q?iE2WQz5mGh4xCbkfqWqIvsbcyIGLZai64ws15ajnbAChycVPOjnKgHwuTxim?=
 =?us-ascii?Q?NcameIRpeSWrDnrVVhUuKY5I4BnRKsp7byCAzOE1Wqp5inu+B7ojW3l+4LUu?=
 =?us-ascii?Q?3jmTj5HC7sDjZGwODQfJ6Zv+PqLqPyRyWtYDWzrMIEf9Gryc6QkXQD5J4gur?=
 =?us-ascii?Q?K9N2vJ0vbOgcZXirXpyOjIKrqiicTmv1090tq+aAHC3Srn1UnzX5jDehcACL?=
 =?us-ascii?Q?bzITYW3xMkhQvfx40qtRHgfBywsAhhAt79vu7FSm3CRy3iN+cmYwHjzbHP2l?=
 =?us-ascii?Q?S66RMRuL3um7jnO583g5DHmdMQXGV0bf3UEHOt4rx8OPODwgQMpsdcsbRbAD?=
 =?us-ascii?Q?+hJtJVghR6FtSqWYT6Yk+PsvY+i5aL/PcK+BwMa2xwwkURmWAIY6EWmFIr7b?=
 =?us-ascii?Q?Oek6LNE9HMIT7e46likYCkTuHd0dKl/tJRieDgF5/P1/QmzXt0ZHfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 06:38:43.2033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50119c52-f2a0-49bd-6ca7-08dd44e6919d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

For amdgpu_get_pp_force_state, amdgpu_get_pp_cur_state already takes
care of device state check. In other cases, values are returned from
driver cached variables and are not dependent on device state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e4ab28785bd0..1d04f1b79ded 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -475,11 +475,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-
-	ret = amdgpu_pm_dev_state_check(adev, true);
-	if (ret)
-		return ret;
 
 	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
@@ -1568,11 +1563,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int r;
 
-	r = amdgpu_pm_dev_state_check(adev, true);
-	if (r)
-		return r;
 	if (adev->unique_id)
 		return sysfs_emit(buf, "%016llx\n", adev->unique_id);
 
@@ -2153,15 +2144,10 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct amdgpu_pm_policy_attr *policy_attr;
-	int r;
 
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	r = amdgpu_pm_dev_state_check(adev, true);
-	if (r)
-		return r;
-
 	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
 }
 
-- 
2.25.1

