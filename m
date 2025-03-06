Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98857C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4087D10E122;
	Thu,  6 Mar 2025 18:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcZgNpO1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE9610E122
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAXN4qpj/OUju3d0nwxjlmP1XODXcYQPfQ+kfhY1Zzm+qAsniE84m/5qTP2bVjAR5BmhpOZB4PmnlTMi8KGtWhROg3SlJaPNmBiGts61+ADqGyGigdl470w1fln2H9VdRc97sYrebOUWQofEZ2NLd8ivqV1XfVwE3kivmPOCJDivZUuGNJs8I0uurHc+df0aeNkJcAWhcJ7CqIyxXW+D6aQ9X4eCUu2D7b9zxOFUznLER2tkEaLmiiwyyPaPJeSWZSENAhu9X0NNqPpdXl2qwBiX29R66EXO1aIwEiFx+eiPXR2N9xrQZsVDWpQwX8Sty7Jtr3WMz4U6LLhUOVKOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcZoMw9vCEYGb255reQ2bcFP76pVgK769oAOoPVYwtU=;
 b=EwY+qocQN09ejwyNjyNxQBSGLwYYkjmC62ZzydkKFjriJnIeHWEo8t3QbGS0DWEGZgGRiqE3M5sZKBTylrPlc7BRhylykWYwQTzUqH+p4BVmpWJTjPXAnZiF1ORSeCH7XFQ9xnaHADLr+oaz+cZohlEp6GUGfh/6egcWwaEcAMW76NKxqqO/BwNy4L66YcO0VEd6W72nOmhRbU7JoxVHNLJxSbtzAFgkejWT9MwPjjP4D2CqQ9JZkp/ifYjzHkSIW13+ftHXdJz0TVmXnyA/DvAWwlmMjvsDEtrCc6M4CQnkDMmo3i8uvMOtHHi1ukKh6+7j4EoaC/qlj6jYz1UAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcZoMw9vCEYGb255reQ2bcFP76pVgK769oAOoPVYwtU=;
 b=NcZgNpO18JQ+0wIrh5V1VI8erw2IGrX/B+IAx0dNBGKMv2yp1r0+hDmciRra5o6e3hdJcqnO9gL+GCJMZNxr2XwAQbSQr+zhRcVEzUq0rf+KDLG0UnxkhPu/ZG4TXQ7xbaXlf6oEhvsuUBIdJGsmnIS48yX2MOviTj6SGHaA8gw=
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 18:51:42 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::3e) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8549.1 via Frontend Transport; Thu, 6 Mar 2025 18:51:42 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:51:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Xaver Hugl
 <xaver.hugl@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH] drm/amd: Keep display off while going into S4
Date: Thu, 6 Mar 2025 12:51:24 -0600
Message-ID: <20250306185124.44780-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a82eeb0-3946-4aee-12ff-08dd5cdfef7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Pmw9POu285Ei4JONCcFGQP/yaaKYJ8w1PVYZTIUhZYTLs/opW4bFfk2Y5+x?=
 =?us-ascii?Q?6/nVH0y87NcE3KWSChL8YyRVattVNhYTEg+f0zhccJntkA1qURB3pRBchl0X?=
 =?us-ascii?Q?QWn1MSZvFv2RkiILLkZ3AiVcurUXJ3ViWZwbWsse1E5A2MPqOYbt5ULDJY68?=
 =?us-ascii?Q?K4a6+oOYP/jpJQ12V0rF9wQB3r/NaJGiAh7GxTF+rI6sgNU/+WN8T6IAL7Bs?=
 =?us-ascii?Q?MIWohYXuBKXhahWY0aUvGKYLY9av30vw26A1WWBOUq/qjy4xr7ZZI6YNxYiu?=
 =?us-ascii?Q?fEYUyPx57aRK7iMXH8kg8qdFvOUCD3FVIU/EzcWDfDCNxOBFMWp+3FOOgSz+?=
 =?us-ascii?Q?tB/ufBFq4e8miRLW/RyKkacsNaevQ0es8z33iUuNyw1HkrdmHBuv0NPXf0FP?=
 =?us-ascii?Q?gAiMZWBXtdT+tImcMGOia9p0HZFaRK4jLfOsWOvaPo7yOFsuhmA4g4z5tpoO?=
 =?us-ascii?Q?CHdWGWY2CnZt2d3E4puE+cca5+ej7Hj1iU2bZgQvsbljvPfmoSHbYYdKuybN?=
 =?us-ascii?Q?bJc/jDhQ4NqIfIYUemVkuwuyanBZ/7K/RJyg4vXMltfgV8aSWZUvDY5FspJM?=
 =?us-ascii?Q?nsSF18AGYYI0kYFtbISJ/edZApMm/0630fvwMlKLk5ecvnvMpRXpCoeHkgPJ?=
 =?us-ascii?Q?ZXm38qoABBj5eL+SEAURKRBCdYlaGxwK9lk3DrRt29iEOAqxD22S8MHXXygV?=
 =?us-ascii?Q?S/46KOW6e4ZDa7J8nenmIbUrEPwLSljua5Q8VRxPxZQsaRCqDzoMZV4lxxLv?=
 =?us-ascii?Q?lKN2xa87HHWxG1jKbOsQThXl7lZgW44otdD3//U9Kgztf0eN1OxX9Ct8eoPm?=
 =?us-ascii?Q?Hwe1Awy+7y4LtkeQSNvZGonoHvWCB0els86WKF1cf1VpeWWq4JmThfOgCmEk?=
 =?us-ascii?Q?EucKeLqhzi74YBb51lMYF2wiUvQRrA+RFhhmkrky394pJKTgYOyV80yhFHrf?=
 =?us-ascii?Q?UIe+w0YVRmE+JvZPuICqVq4CXwyh5t0YReIg854q9HgicA66/s7/0A/R+RKf?=
 =?us-ascii?Q?4B2zlosRIPPQ1AUuLgvj6ISyIknnKZpSP2NnMP/8WZUFJwo/bZY48Rc7wNmY?=
 =?us-ascii?Q?6wCrWGC3Dn5kK5+JujcgS6ozTEAVRtsqHcdSa9tt2O5Nmca/gV09aIY/3zLK?=
 =?us-ascii?Q?CfX1I7Ohga8b07HEPiUs/z8YXrcG/2r8z1yJmSZ/SvHpmXVrcb2mRKBlJfj8?=
 =?us-ascii?Q?NmC7p7y3ydmnIC9i5PmMqLVhQTJO9Guu+wamSdDXOEFLnpFl3HtIrv13aUts?=
 =?us-ascii?Q?PxMhc8sFbCC09+UhEuBd4gxn0cDbeGzcYT96rpVzo2anJmVz28pmiuAYZA1S?=
 =?us-ascii?Q?b6CaOsVM657Zh5SbsthsZb2TuJRrgcXOXnE+HX66ZZSCwKHslAForGGqy12I?=
 =?us-ascii?Q?bNsEN6QzkGh2h86xD5TUoHE2FTQyU3ca92ESrrPvWLK8KDUXwzoIzCzQvc69?=
 =?us-ascii?Q?3atYOGHkBOo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:51:42.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a82eeb0-3946-4aee-12ff-08dd5cdfef7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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

When userspace invokes S4 the flow is:

1) amdgpu_pmops_prepare()
2) amdgpu_pmops_freeze()
3) Create hibernation image
4) amdgpu_pmops_thaw()
5) Write out image to disk
6) Turn off system

Then on resume amdgpu_pmops_restore() is called.

This flow has a problem that because amdgpu_pmops_thaw() is called
it will call amdgpu_device_resume() which will resume all of the GPU.

This includes turning the display hardware back on and discovering
connectors again.

This is an unexpected experience for the display to turn back on.
Adjust the flow so that during the S4 sequence display hardware is
not turned back on.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2038
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b161daa90019..b54c4b2f3f7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2565,7 +2565,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	int r;
 
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
 	if (r)
 		return r;
 
@@ -2577,8 +2576,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->in_s4 = false;
+
+	return r;
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2591,6 +2595,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f9331fe91c3..5939796db74c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3431,6 +3431,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		return 0;
 	}
+
+	/* leave display off for S4 sequence */
+	if (adev->in_s4)
+		return 0;
+
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_state_release(dm_state->context);
 	dm_state->context = dc_state_create(dm->dc, NULL);
-- 
2.48.1

