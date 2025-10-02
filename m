Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC96CAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 15:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319AA10E1B8;
	Thu,  2 Oct 2025 15:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgpGxBtV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748A610E1B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 15:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLYY7Qle8WieJo7XT+Fbtmf+Bn4K3VvY0NNGV+sQHPjR1sqI14BnpGHfw5t/KMDid4rIwNEMDuJUnIlnq/JaPk/cfdVf4UMtCo7+suTZ2Vl89+3qW87SAbfTFaF6xtQgWsnx6Au2UHlB/eF4f6EySi5SnteHo0DATR38kvlAU4H//s76vhSpz3BFT/euMNv4R75Dxss7DtzZjCKLF8hMzD4vceEUtImN1fuyBW0XELlPAg0sZTrO1UuzbIb5u4yL1189aScxODeLWgtptARplTJgReL9uXEVoq0lPr5J6AEMu9he6Oms0Vl4MB2xV0ng9lofHTsW2Klc+7N/H5Gz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPOUaOUo1MzsYrfco8p/3evgkqcWBtyAmSYUMkxh6yo=;
 b=E4ueEmDGWlWsdhQU0d/WrHQ5E82Tc+2ObmSPd1ekX6GJ3EJueoSvyVRMqmrNLz90h8QfEX85/ibpsaFS8jD0pXrfhlU6meToxtj3aXTzwlqnMnr7WMdG1A7WvaVQ6XqCD06Ysb86qpXV7kUJ89nUyT9RIoogJuPVfyiK0hXiymNCYHiFQ1lPWHmBuQ8eHQKUFzD2hfll6r25L/q7rd1ykfa9FLFT2d4HjeTMfa/G8hQi1E0rrsT9rgnB2pL0l20OUTUUdMuS7ZbP2FFDW1JUe2kLZTjiW0KP/4hnH3VJB99pCWCr9r2xx6VnoEWPnpJ7YmxwRQoJwQxDbbg9ew16sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPOUaOUo1MzsYrfco8p/3evgkqcWBtyAmSYUMkxh6yo=;
 b=YgpGxBtV7yjfRAFP+V2zknEsfyvtgkNFU0INc/W/GwNobsBB+RTZmorZ4SWn1jc/ad7qhaPvoLmRLz2xUG2/jFqmNFWdk7hyav7aVKxT+2U3qWCEyLKKztNZgFN2KHKRonOmE6VkK3u7Hn72inrNnOAkBUzLA6otGwwh8vZipeQ=
Received: from CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::28)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:09:58 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::fd) by CH5P223CA0023.outlook.office365.com
 (2603:10b6:610:1f3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 15:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 15:09:57 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 08:09:56 -0700
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/sched: Avoid killing entity last used by parent on child
 SIGKILL
Date: Thu, 2 Oct 2025 17:05:26 +0200
Message-ID: <20251002150524.7552-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 536180ad-9336-4f3c-0d3b-08de01c5c04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IqUEdoALwOIcoiWeAu/UYMWR6hCopZMxS0gqkoUGqNZhKgPC3fmj1DPqayXN?=
 =?us-ascii?Q?tcOgAAxbKdeC2Y0wKUBpRK3ae8PGyhKaLS7u/ENdj0GNBIYeVkJVByEdPRhG?=
 =?us-ascii?Q?BYPw1IZRymNbav9EdRApbBhBHU7Izxy5O5XueaUL78FMAH8ccuHONlX5RwPN?=
 =?us-ascii?Q?MUKUaZrCPfuSpwgeLfvGFOQcfAWp8IxNX50Dyo03gqosEMpoaXRiuPg6eiSc?=
 =?us-ascii?Q?oBVUdBW0GW7MT5fFQ2HIM4UwzZIQL04nfB2mbh7rAzVWOG9M9x/J1byZDHjK?=
 =?us-ascii?Q?8mUsB+hEmTB6pDiH+OTz6L2doIIPvKvX7Uom8WRfdgCq4tcJBLer/tP2VaZo?=
 =?us-ascii?Q?j94c03h0Z5gg2LP+5BkB8bHejK5YKWvtdUE5zLn9r6uVnEypzKCovQfchD9P?=
 =?us-ascii?Q?YtHTCOJzOBGZaiCX238P2jQbqOEsj09HGIqBqyMJiuq/XDfyK8awUESFxtLR?=
 =?us-ascii?Q?smm8ewjEmN7EoAnZHbs45KLJA+2jwrzUasudi77wnDqla6uof++tvZBF7Sb5?=
 =?us-ascii?Q?aNRF0M8LSQNkEONVp6qmZrpLbe9sG3buCQfqk9bZShdQEyJ6PWebAb6zTVDj?=
 =?us-ascii?Q?UcSsFqidiag5sYG6FmQ4Dc6GnB6AAbabd3huQxH6oo9d6YXsQqUYVj8eUaCu?=
 =?us-ascii?Q?EmNOjxRNjIzSeUOhwk1H5eB0mHp2xH006oGqA0wA1caj2OcjlrESJ0S6XpKu?=
 =?us-ascii?Q?qq+aETdTMPUPeGDlP57t3OMdt4Wa7LaxXBcH5t64pp/ni/8LrBVOdRyR1mSH?=
 =?us-ascii?Q?Bab3acMNwIB8AkkHg8Ox8GLqcoMHlUa93etJo8vmkGBsc/AqKks4Abw7nui/?=
 =?us-ascii?Q?tdHxJzeo99SxIBeOxlWQxtp7uTWLGmo9u/1fXCBXrgBiTH46E23kuYfQFjp6?=
 =?us-ascii?Q?GuJCc2375vZEVK7rqFljgoJbDxPSSfhkLz2OJew4NoERgVkwBIzi3ZJp7GuN?=
 =?us-ascii?Q?/Sra8mskdM7aHf8yEdNMFZSxJbtOKfplS2kBdAfquWt/+NPeNOh1O1siJOxW?=
 =?us-ascii?Q?AjO8KJf8jSutRnbaQo0esJMp2VFC+Yh9I7r46r1iDuyZD8KbCsV+5jhIbPmc?=
 =?us-ascii?Q?7DJJdL7FMN2zS76d7KhMztbMrLmDRVRbd9lE+nUrQt1Rrvu/OA/akCJiPI6y?=
 =?us-ascii?Q?VSN1YBAOkgdruXil3Y7qobGZ7qDg3qGS9TBvRxggE3TPIMNhIY3QcibRsclr?=
 =?us-ascii?Q?3U8lyzQpQHKurrMrCFtuqBMKl4g5I3oEdz+R39NWPeOBLDlwdG6dO8oyYm19?=
 =?us-ascii?Q?VqeySrBylg4fD2sf1RQ7CqCeoblTCA/ED8cYrBsxm8F1OTXyiQWEUBQhG5lW?=
 =?us-ascii?Q?+sWekV9pnhCQWshzwvX02LtMiOPp/A91Rniilshg895rIlcCIQSA+/wKC3RJ?=
 =?us-ascii?Q?8OaZoSKDAzAdXffXcJIPoI5AjFYFv7BXUa/CHgU4mEgGXGrJex8tPF9aXruk?=
 =?us-ascii?Q?v/bTdQb1kxuEf3XTPSQo8BmtOU+Tpu+wfzoceb2Y+YjEOd1OHWfF2x95hxQG?=
 =?us-ascii?Q?Q8B+CJJxc12kZXCmFvcXAcnsKVNvA3+9KBGtNORhheiW3PWukTwVIHWIliad?=
 =?us-ascii?Q?mO5UScCRUL2ZWoh7IOk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:09:57.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536180ad-9336-4f3c-0d3b-08de01c5c04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

drm_sched_entity_flush should only kill the entity if the current
process is the last user of the entity. The last_user is only set
when adding new job, so entities that had no jobs submitted to them
have NULL last_user and would always be killed.
Another issue is setting last_user to NULL from drm_sched_entity_flush,
which causes subsequent calls to kill the entity.

Signed-off-by: David Rosca <david.rosca@amd.com>
Fixes: 51564e9f06f0 ("drm/amdgpu: Avoid extra evict-restore process.")
---
 drivers/gpu/drm/scheduler/sched_entity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 8867b95ab089..a325e4a59990 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -70,6 +70,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->num_sched_list = num_sched_list;
 	entity->priority = priority;
+	entity->last_user = current->group_leader;
 	/*
 	 * It's perfectly valid to initialize an entity without having a valid
 	 * scheduler attached. It's just not valid to use the scheduler before it
@@ -278,7 +279,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 {
 	struct drm_gpu_scheduler *sched;
-	struct task_struct *last_user;
 	long ret = timeout;
 
 	if (!entity->rq)
@@ -301,8 +301,7 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 	}
 
 	/* For killed process disable any more IBs enqueue right now */
-	last_user = cmpxchg(&entity->last_user, current->group_leader, NULL);
-	if ((!last_user || last_user == current->group_leader) &&
+	if (entity->last_user == current->group_leader &&
 	    (current->flags & PF_EXITING) && (current->exit_code == SIGKILL))
 		drm_sched_entity_kill(entity);
 
-- 
2.43.0

