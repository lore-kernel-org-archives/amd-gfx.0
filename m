Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95807D262B7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F3D10E689;
	Wed, 21 Jan 2026 03:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ji/XrfM9";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877B010E1ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkgIepFTk3ljP7B2EpKywMkaGFj/7WUD84+EOpJTfKamrClN0mwwFfWw4N/zwbGpuEV43oj+RcTDWEQsmSSGoIWTYTdaG3zjV6C0FwJa+gTn3WmTIBOdBCB6YkrnxXnYjCI7T6B3TrZTOjaDzLMlFuMNQeMlxm/uaJ3vmts9+dm3LT3Dvp/+87A9ADFoB73M9jHkZb5ApCntvwgFQQJDhuX25TeHGieJ6LLZOmprhgtcyi80hEd+w4UbQudw1hpe4BGH6pzakzy9QSwiFuwCQ+8Mto6x3V1tZa4QlbrzdaKeQLA6qqlDMwcqDvVJfUD+HEI8QaM9kxdkeMuRgTMyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX8UwwivK6sZb7ssCWzZ9STgRpW8u7EWikwsnfyHut0=;
 b=A7HqNHfikNwOB1v/Zee9nR5XspcK/6+EzDDUdIPsBWhw8WBwEn7w5lq1EfQTSMAdw812Qfkjm7NfY0cuI6a8do8H/XvqpMWZoszTwpeZ6NY/raqr2QXat1ON/QUB94gACc4ak5FnFsEH7xGmOCaRDF9g6YgdJVQo7hjw1tTeDTYT+9m8+EB7x9+AcvNCvG4PZCGaMHvr2POZSRJcYWo9Qkk8r8YwhK4kKXYBNx5EXoYI+D/QCJcZmSPrEQtumnvWTgwSlv/EfKa2fVNks3053R3AfEpf2kvKrO4APLu6f42vMTFNvQpFl9p3TN3nu9oA+/5WQ9yoPy1YXqE5D9m1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX8UwwivK6sZb7ssCWzZ9STgRpW8u7EWikwsnfyHut0=;
 b=ji/XrfM9qEbnqoAQ3ISuK4xOCrtEPZDCpMdRgnQqLsyrkhHrdUsx8bkly6as8VGwmnb4KO42ZIu+xPxYpxwMOsQXBea0ytmDjDzluqxWomyjV/fgXbcvur76Vprs7CcxTFZjWOlvWxfK8uHVaGGxfXxZ49/6GpcNyiluWBQ1ds0=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:01:14 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:07 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 19:01:07 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:06 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: re-add the bad job to the pending list for
 ring resets
Date: Tue, 20 Jan 2026 22:00:48 -0500
Message-ID: <20260121030057.1683102-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d67f0dc-0972-44e2-60ab-08de589955f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gxB2gBowR2lMbnlM10OdEjSuapidVb6IbAXG/ukrE3o5XQhLG9N3F7hne6nq?=
 =?us-ascii?Q?4N/DfsIMZ/1OTT28esN4fcUJoxR1ePPZPvfzNs9Blr3kLMaLGUlpTmGZ+FqR?=
 =?us-ascii?Q?HQtRUDbaXsEDYBTVBmLv29wlHQuocDl7fheIpd/3md633fttlMHF8OYEF5iD?=
 =?us-ascii?Q?aCxes/8w414PA5b0w69IS0BDKjK1N0I/kPMpkUVIuvCifVwN+CHcwML6kGNu?=
 =?us-ascii?Q?U8uFZE5dD+lWKW0xxCrCIJ/W/z7yeGJRiLDmC19GUTZ0NR7BC78l61I4vKpg?=
 =?us-ascii?Q?00/npJHUvJ4JQW4CPS5KpNadKRqpE7N+vDebEqRKr3nKPTON1Dgzn1gEK1Pt?=
 =?us-ascii?Q?/c1D8GRjxsbpOT287wkxe1qvzF/rTVHXoJGkQ1FNKFlvTSDl8juiuwubLXzE?=
 =?us-ascii?Q?ooLeX8B27wT/lg2SLAQ6FFc/wimAUnAC7WAgSiBiWLTBmrn0dDbFJbR0LF70?=
 =?us-ascii?Q?UmvKQuRkCJ4iJGwxVx1BFkkfzdl7Dmveu18473ui10btOa3dieSG+FkIMgIa?=
 =?us-ascii?Q?kR4EVaFFB67cZZGHcXKwG5kKiE3dr0S01c8crOZyCkAVZ2HkwOpfKbtrnK9D?=
 =?us-ascii?Q?cTtmxxLKKQB02ONClY2wAKt614n/1P910nmA2jD1zwk08ClfCbE9QT2Daf0a?=
 =?us-ascii?Q?7E2LJUCWdNdUoT3md/vHvj6lf1m3sE7kFjyJqo4OeYD5XthiFT5Nv47/8u3C?=
 =?us-ascii?Q?ZdWGOIpxjyF70TNf+rdqVt48Qo0se+S6BkP5ysHB31ZJDjHMesrCQGz4sP1C?=
 =?us-ascii?Q?Z60breFgUkCdSz3fGQz467l4yDnXZJE7vjosxd5IOuuIR/wlmhh1Qz2Cwm6+?=
 =?us-ascii?Q?P63Y9oiqUDtcBHaDwMv9hTJc+tqRw2RFbIekNowOiEbWRzBPE1B9J/8J4plk?=
 =?us-ascii?Q?lfcroKH7LqYB8KYlamWySaMl24xAi2mOcwOAIVk5xUSraihYQWHl61aO83kQ?=
 =?us-ascii?Q?kgGCzL2ZxOVpbXazSmEsanM3dPEPuTVh9n3lPdbIecxSzHlr0DMSR7l+sU7e?=
 =?us-ascii?Q?g9o3VmkoRb4RekLVTF9KhzhvKOYmjjNRu2Ut8nWOdMbwPEgR1xsOrtHWWl8E?=
 =?us-ascii?Q?Pm62C2Q5/axQPX2fa94Ox/S6ULLHAUt3GKQd/VAUu2y+UWwf7CIl3HQ9FH6F?=
 =?us-ascii?Q?JBheY54fF+WC1Q+Qc1iupaH/c/5HF5L3qG9365mzNr8p2jHt7Ugub4+Hh4oQ?=
 =?us-ascii?Q?X9cP14jtM933oXBOCgWjSL+G+ITUJpW+Xu1zqORhpIcA+anprPjPnsd+zYgi?=
 =?us-ascii?Q?zDe73olU9EOMNObTdim5xISI3W5FjDVBYPisLeUOVkcXZY4gj28LdkqRoSeV?=
 =?us-ascii?Q?BAMKg5juDY+qgTsuTI9z4/bafTnNjgqL7utEZoO9VIfGI4cBSvVo9AHeaZDg?=
 =?us-ascii?Q?zZyCgzhSBcEQQOnup71uCYPhpTGi5zL5/f013Abh44y3k7yoAEwkKEinbaEa?=
 =?us-ascii?Q?6GZsH9T2Aj5Myeg1E4tFzFRGoXVyPDNtTyis2umnI6RhDVYXoK4+TQlUfuop?=
 =?us-ascii?Q?ndBNyeXWvPB962RyBy3WPKMVfumLT1NbMo45Kaov5sewXQrD0LIvaou3Cy2Y?=
 =?us-ascii?Q?NmSbV0fqN/zONqbk3Mz8Isjar14AFMnltwJSKCcxQxs40TV42jFLpyJRbPMB?=
 =?us-ascii?Q?bgrra04PVpKkk5bY0yNMqz8LfuV5+bESrdEYVhlr/2tGgvdgq4gfJSG1gZfT?=
 =?us-ascii?Q?vRJyiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:12.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d67f0dc-0972-44e2-60ab-08de589955f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

Need to re-add the bad job to the pending list before we
restart the scheduler.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1daa9145b217e..ec8d74db62758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* add the job back to the pending list */
+			list_add(&s_job->list, &s_job->sched->pending_list);
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..129ad51386535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 }
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

