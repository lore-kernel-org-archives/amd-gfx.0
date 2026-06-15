Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA236CD98C7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 11:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2A110E386;
	Mon, 15 Jun 2026 11:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMMkeeG8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45E910E386
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 11:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6I2MwYJXBodlSsCgVy4evNfqix/6jeIbAtgpZy5uGUU8aCM/K6XvJP1XqlfDOgsRrM3zgcG5RemIF3l3QSlVgHRysbVDQGlLgE9kPajZ6d5NGtRW0gDzIz35mSwgnS+QOnrAd81+kchU7mHDw4LIubcD7xOdpsHJdAOij7/3pEecVrH2nYrzYbwAiojWAHqQ5b+XUS+/o7p1FM0hlPAYRmcKQ7/PBj1wzPfb5Y2revYPQH+WXvPqxqId7NTOEQNqdUbtBST8YcylCmOS2qziWXWmvI1WnLOZHT9c3w7m5epOufLmp20XrxMZdjQsFFAVtVT7YiiFwyLQE1KwxwVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS28hIKgNooGYSM9V+n7z5AkZQ5joD8CCU7T5BhOhKs=;
 b=cxOVXODz6s/lag37YX1QWTUXxWyfbJFmzwW4FchPJcDA7xoZ1j585FGzEYtbQFPO9AForuA1TmFmWtYs+DJ0WomI1wDevcq9VEOOrk6CoQNdPFFEy7+HnRtuz06UPFHTT1jR37dL/zUQ7ANpczXkYa7iS10XdDLEn2D4dbezFIysLNhsTGpnQ2ZtIk/g0DpZTxCm3iKZTfAlsHbwQQ/jMcFW9gOJcSrGXD6a8wJRVgsDJSBfrY4bP4zR83Wz96L0/A8jZhZ9oOU7ZdjJgLh38ZV9iHZa3fTWkvErxYjOiWXwaXBKXdWbj975cw0uvjr2EzxS8Jgbf/2uOeD0334gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS28hIKgNooGYSM9V+n7z5AkZQ5joD8CCU7T5BhOhKs=;
 b=fMMkeeG8iFTHbQrwREG2IDF5yesN83n1qEZvgpmomuN/fDVHbti0NdQoeB78eKkQ6aQBVqbrJI9Fj9owrLBlHWeWNlgdUwlTHsFViKioici1rv0KTC0w4fFTJsLwraKXf6KntSaSg7bhwaZuo28d6Iehs68+Q1OfTC1vVzkH4jA=
Received: from BL1PR13CA0141.namprd13.prod.outlook.com (2603:10b6:208:2bb::26)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 11:18:03 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4) by BL1PR13CA0141.outlook.office365.com
 (2603:10b6:208:2bb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 11:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 11:18:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 06:18:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 06:18:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 06:18:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fix SDMA queue counter read on non-gfx9.4.3 ASICs
Date: Mon, 15 Jun 2026 19:17:44 +0800
Message-ID: <20260615111755.3597404-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a310cf-5e4f-4bcc-69b0-08decacfc426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: q+hCV372xZdTn7EJXlo2UgF/qSqjS7wS1TPn/meFV7Q7/2aKpaXTycDPpKS0ZW7q0GiETk4MJp475ifZUHaphkk+ndudMA20CDy9hE9IZxy96JRRn0z1ckRH/pLoeep/AXGhh7VZj2sY/K7f6sYfP02CRBGc0E3cI4JgU2oflzzvTA60x0IupU9cB0rdlou8M8f9hUT616vaiV1tR0+lYnU9qlwyM6xsi4NPzuWoy4OBsrrRUcy+z+/TfyLTmt18Ak8mCWsj5bZD3LjROWeF+zuyQkZqhxZzBm/JJisqh3NYuTvOsZpwgy78uwvrLQWCJKaWvRoPcgIklzvVDtxna8hqOg93W6mLhwL0624+pwPG70qcwdi3L36KQnVeftNLrM4a/S6xr/osD5XKUPZdCnNs0pb1QFtYFBpBcs6f2hzbuLptDpXA9a5pe1GUAaWhwl7tmzaYf4jFYTaDx9L2kZyNcavCPkd+NFncmyE26EZVYhJ0KLRZgEBRmc252IyWt7YAFZmnkvYZ4f1NS0KP9I0S1ScezC248vyJGoX7CNo+T5bTTHDrW+lr3tmDFrkj2Q6UYnoWN5F78HXm9iK8A0KEv+d0/5x6E3YEwH+/ufM9ePgNnpaiI7WyeWOL1nozr9Kt1HXNJk0fSsgyZgwNVSr9KjF7pklNg1socz+WGLZvpk3c+yiDjLcjH5Hjy1Iqv6vTVnxRWC1ZArgdkj2ecmKYDkBJq2qaRDUZ0ZQzYcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8uoizfqEct8oXLL0UxJO8deDIG4Irt6NtUaT/t012K5MdTZ9N01LCS4wBs58CGZtYkkXSO3/DqLWBAQa6KpTF9Ol2Z4wI656LMfqrAZCVI0qzPoAOIifBLVIymu/OqVA5UO9LZqHTygpRsql2P0QOg5JlZDFyxEqFNQkJhMnz1XRLINmhaoMGsLecchVKfP8tJfFJtD+bDL1TeQCBg2Xzk3kLBC6USQR3nvrnSz0mQJ1GmoXxf5Dl7hXVqnO23MMJDbwd4pcxz188FZJr6lRXufXNkpEXHpweENHhdb5b18736Aatfk/aVG86rGycGgCRKqsXRwr7x4OnwmQTJe/GuvCnJ5mqMU+PLfdnsm0eyr+lsHG7ZVNpAWwjq/R1FVdToSaVW/7g0DZdK891fDAezWTw+L0ogHY/eDOfTLgCgjGgHdEtOIU/3ADz9vbb2bW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 11:18:03.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a310cf-5e4f-4bcc-69b0-08decacfc426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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

The SDMA queue counter read was dispatched by GC version: anything newer
than gfx 9.4.2 was routed to the kfd2kgd->hqd_sdma_get_counter hook.
However that hook is only implemented for gfx 9.4.3, so gfx 10.3, gfx 11
and gfx 12 fell into the else branch with a NULL hook and got
-EOPNOTSUPP. This spammed "Failed to read SDMA queue counter" on every
SDMA queue teardown and left sdma_val at 0, so the per-process SDMA
activity accounting stopped working on those ASICs.

Dispatch based on whether the hook is implemented instead of the GC
version, so ASICs without the hook keep using read_sdma_queue_counter()
as before.

Fixes: 0ee24cad5b35 ("drm/amdkfd: add sdma queue counter for gfxv9.4.3")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++----
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 53415317ad63..7ee10fb0a8fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1027,17 +1027,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
+		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
+			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev, q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&sdma_val);
+		else
 			retval = read_sdma_queue_counter(
 					(uint64_t __user *)q->properties.read_ptr,
 					&sdma_val);
-		else
-			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
-				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
-					dqm->dev->adev, q->mqd,
-					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
-					&sdma_val) :
-				 -EOPNOTSUPP;
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
@@ -2675,17 +2673,15 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
+		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
+			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev, q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&sdma_val);
+		else
 			retval = read_sdma_queue_counter(
 					(uint64_t __user *)q->properties.read_ptr,
 					&sdma_val);
-		else
-			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
-				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
-					dqm->dev->adev, q->mqd,
-					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
-					&sdma_val) :
-				 -EOPNOTSUPP;
 
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e0b885b2395a..f280c3e41ea6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -192,15 +192,13 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
 		val = 0;
 
-		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
-			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
-		else
-			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
-			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+		if (dqm->dev->kfd2kgd->hqd_sdma_get_counter)
+			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter(
 					dqm->dev->adev, sdma_q->mqd,
 					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
-					&val) :
-			      -EOPNOTSUPP;
+					&val);
+		else
+			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
 
 		if (ret) {
 			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
-- 
2.49.0

