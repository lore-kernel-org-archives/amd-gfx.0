Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5136BC25B5C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EDB112595;
	Thu,  2 May 2024 16:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ihG7OWdE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62514112587
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEgWJ5UZ7VmFCPy/7ztp1cEO+2CA0flnI9xwgmimuLXI7Fb8Mf5lWXTIcbKUEFIFDeJskhzy1H4HlZP8T/xVA0I0iUVxjK7NTuHiLDK2Si9yC6K7o0yS4irmnRrsbWUiQJd++xcWOt4va5uDQd/WQa7QZw7ox2o6pJzoavkWHPpvuEDjUhOvwa386aLBbpAePmpxx3qljDad8cROTZsSu5walXQiOZ5BhD4hqxq4fLcC8dBuZe/Ac2vgdqhqinTyVNMcuFk3LZQQXcP/aTEXmU6cBAlhnITtfKmcn9nzCOEbM6pjl/PIIrtkGkihbS9nPRl87JpYBV/RQZcdvkh1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZzJl09Onq5bQqpg6Uj1N3buPI1mxg/TBMpYCupnhns=;
 b=m2qHt1yOdFcTi25Ojs9CGF86WgyhgVtAx61v8l22WZDUq5ld7tJOgRL29EXkpdA7cd3uZPN7o0tnYhx9f4WvgHtNPj7+b38FsVU775pcyuY5g+mUn7rSetNwW2cwds8QpjxasunmKhZZCCPGnrsB/MbnmFgcvIqCEPN2uGmiIagxJTkNmznZquUCMFAYY/42Bla0/HNpM8RJIxIIuPAtjKuKC+ymgHdFn7s8p1tMl+1TSQFuy8OufFFSAAJcU7U7InHjSvtaUDQ1gJ1owXBX9/fvV4XgJ2zr/O66CzIBdK7b7OSlBLqiR0iQodifjDErPk37xL6mmR81DC9k/2QZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZzJl09Onq5bQqpg6Uj1N3buPI1mxg/TBMpYCupnhns=;
 b=ihG7OWdE4U8/9nelR3qV0OVyFDYdvD6u4/Pho0XNixTiVLYXipN+ssaOXOaWISCrkR3ZX5QJ+Awz04CXUnNcZj7pyOgceNP1yzPjvslrI5pbcPVWJvhwHECGO5LoSad5i6liCMc4jLX6CXF+7IFRo4gPoWtrvWgpxdVpovp91og=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 16:32:43 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::7a) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:42 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Bas Nieuwenhuizen
 <bas@basnieuwenhuizen.nl>
Subject: [PATCH v10 10/14] drm/amdgpu: cleanup leftover queues
Date: Thu, 2 May 2024 18:31:47 +0200
Message-ID: <20240502163152.1382-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: de329a07-1fe3-4331-3e07-08dc6ac57d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AoOxoLEQz3o+jXr4hi5pV+kD1B6BA3ECbdgG4g909WNTsP0vTPKi7EmMSbO8?=
 =?us-ascii?Q?vEa3r1xqp5Sd86Ccs/gT7IGEsmmWGY8Bwjnmpp3mAkEa34r7aTL1k7GFlvgN?=
 =?us-ascii?Q?xqBunbb+MAf3gFT9OB+gcoj35v/ct3H7BUfQBEZjIiSmMOrYGX7/8V4FE2Vg?=
 =?us-ascii?Q?oDmQ3jCqI63BRsW38D5G3NpC4cNI5vaXCtt5+pNShIE23EOK9jnmpQfQ9KvO?=
 =?us-ascii?Q?yzIF5PcfbQPUBrtKia/u1NDdsbOTeJPatH7+HWhGjZ0R+Q+AEjUy1q+sv5yJ?=
 =?us-ascii?Q?3ViPvR+AzEXVqFMACHvwBOugh02+bf+oK0/ZH2JIZYQGngm1lmYMJIYNYFRp?=
 =?us-ascii?Q?f/QQwqgqGeb90M5BBXuqU7EdDAP7U976j2tczmnuIHXt2hvLEewsBI8zPDr+?=
 =?us-ascii?Q?MxOPX3Nj0rVQ8NPbQH0pwreFO3StdYlNpaSk30F7xvrL+oJaCYPB9LMfMPbI?=
 =?us-ascii?Q?JnapnMylHLI5zW3UJtYT52CMNSXaROM1MCoOJ/L7DMuBq6oePbpI26gl3aYg?=
 =?us-ascii?Q?d6GhwFbKgTVCV0mOV5wwEag/Kszpv7l3ifz6UfwgeEeVEbX4sEl2UoNTEIZp?=
 =?us-ascii?Q?2qFSdisHW7212xPExMjc4o2I+BNFSEqHb19npcbfAKx9AfFIAuaWm6dneUsA?=
 =?us-ascii?Q?ltEMIrtJBNu5hr5oeLU+CfhQzSaupPFCd8ab1Wacrs73wDxTIS9NQIY0dLfy?=
 =?us-ascii?Q?wRsYRVEtp1ZvNl+6rmeygGnGkd6X8rO1sBgIxu2D2ZQKqcMLbZhH+K3EDR5e?=
 =?us-ascii?Q?d8f0igw70hv2I7vyotokd5jvrQqAVJMez/R9P4/zGFSBsUptDiw4k3WKJzca?=
 =?us-ascii?Q?/QVHK596Mj551v5VScC2pNFEOWyAn7AFf36Jl5/8QEl1eS/9NNf3ukmq2lc+?=
 =?us-ascii?Q?LiGjLTgCE+ZG29NDXKffT7CFDv5wueQpSJKOOYD6yiQOF4Qd5rKMIXdei18s?=
 =?us-ascii?Q?vQLxWasOb00+8G8mH71wpgFJNRYDUEVopbzurtdE2rAVPz6mEHoE3xeH0UgE?=
 =?us-ascii?Q?DvsV+fSV9Xw5fcYt8DNg4u+WwWC3gvP7OTiEshaRVtqGr9fD3oWR4lRE8Xgx?=
 =?us-ascii?Q?TwTf3xauJKqGq7dUzPioXFDE8/cQ0gVSpf5Jmy/Knq1Bdr2KWZBt8D7Mh1j/?=
 =?us-ascii?Q?p4BhWSktffhjraVkw12nPtsH2HJu2dluRVP3Z3etstFurLoMDzT+Hoo3ifYc?=
 =?us-ascii?Q?Rj3vWy6fNdk+gU2+ELRkbcokL2TVU36U14SHGrVEWJ+lmSrhsb0m//g1OU5+?=
 =?us-ascii?Q?HMcOV4CHNtVlXaGRNbHnychfSPfVMovbkXx0/XWmhxjLjLoXnE8GmnWiB7i3?=
 =?us-ascii?Q?skWCpY8xxJoriRiQALKm2mPhDfdvO3jhRzTEj7R1/TVMwNziCAFt0X7aQS3Q?=
 =?us-ascii?Q?O8Es9o8HE8xXPQ+FeV9fYSgmp0hq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:42.5276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de329a07-1fe3-4331-3e07-08dc6ac57d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

V7:  Added Alex's R-B
V8:  Rebase
V9:  Rebase
V10: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index fbf6235cfea0..df0e74a3ec8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,19 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static struct amdgpu_usermode_queue *
 amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -146,8 +159,6 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -159,13 +170,9 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 
-	uq_funcs = adev->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
-
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -277,6 +284,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	uint32_t queue_id;
+	struct amdgpu_usermode_queue *queue;
+
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.43.2

