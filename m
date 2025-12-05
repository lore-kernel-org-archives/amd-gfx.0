Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B11D32D96
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A4310EB52;
	Fri,  5 Dec 2025 15:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OALuFJd+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDC589023
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 15:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLCpnM4fSWTuxgfKYdvENo32sL+fQ0vFGjpCqFmcxetfCRtYjcUWZIK5ake146e83jThe3OjzINjYFlFszXT+vO2avOr1ukoUqjQMz6oKUabbbxRrC/RKV8tfVKOG/HW3GS1SrEUWbgpt5fjxVsPGPtrkSGx8G3k0HDDEqc2Ob7ENzUqmd+krNSXZpol012m42WVwxwjBwK3FEH3DPTlCPUn2xtqtnZvhPPFEcNhk6Wt0TUHslfSJ7Ayf1JuOha7bdJ0Fq9z3o8C+Q1gIiIJvvJyW/4Ibgy75p3Jc3W80rQk7SD/PNlFUUZj7659IRIX892xBvnye83tEBpxdgLR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWd1d70pQ9qUdsgtU9JSSiqTWSZ3PjsxvgTzzx93L7I=;
 b=AT+xxqUgD9hN1QEmoARc4PdOAko9k67egY+xPo7194zrppLXCGkWPL6FYBzKCU2Ba351IWZ9JFTz4RENFJchzROVuQByGPa69B3ZCEHmSUz5hcFZOTGraa8cYo3mgRX1FZYQRa3VS1lO6sQ9eAM8Sl7NNcnNr5kbgwmxX3ULtdifFwWRe9/12FmyOerzRyBsnfUeuwV+oywAPY1f/rasu6qX0RjK93FMbtrJlE5gDrZPz1TZWyMoZO1kSay5FsYa05Y53s+Ii4oqwlDjU1+wAlNmhsMRTJ6199Ez1bnV9JI8zPHZy0uDZ0yDku4QlFuT3Q0qK6745hosAA2OzFrJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWd1d70pQ9qUdsgtU9JSSiqTWSZ3PjsxvgTzzx93L7I=;
 b=OALuFJd+3zpNCo/NmRhpMvDK24c6WmEFeyizqePzSx7s1ZBOvy5jvUoBlAOZk/kSctQxKFfXlZcz+fIOxmG7PrkYt3Sb9TrW3yzNXOhipkuMow+vO18tYYWuyBADFvf/krGL83NWbEYl4socy9Qfm5N8/oEqEdBzmuxPmy3gEQo=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 15:19:54 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::70) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 5 Dec 2025 15:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 15:19:53 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 09:19:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: don't reemit ring contents more than once
Date: Fri, 5 Dec 2025 10:19:40 -0500
Message-ID: <20251205151941.7980-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 058988ea-d482-4645-c9b0-08de3411bde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?moePj5TkmYO38ApCgCCvVmYVdQVveBM+bMU3QkMWL977/p3VHbQBrO0jAl7K?=
 =?us-ascii?Q?GE6ehckhH/9ozbO45afL4Ghn8DR8m9YEmli/UOL8x/Ihlv4zox5RSQLLawfH?=
 =?us-ascii?Q?HaCNJFxDr5G/EpiPJo3B9EVof9bRJeX5zfWPNlE8+t7HMdyB1M6mJx09QkD7?=
 =?us-ascii?Q?56w4s2zmDGqC7lMea7tvEt98h4Md70JMmBy3AL/b8jGDg67+QFCpHbbUZ69G?=
 =?us-ascii?Q?7f+Z8QmTzg9gtW8COynLhDOyAWaevSPH23cPmRlE211sZEl6F6fKIee0wxSH?=
 =?us-ascii?Q?nbhi0LwuNrdQzOmLJ3Sice8tCLDvl90V+sCfjcpi7XzsNWsUM0sojlMQILSI?=
 =?us-ascii?Q?GlZhNWFY7u5Tq638AQPUTb1gRW0HdkdAwP/wIKkociSyRiEABRgO39phE9zU?=
 =?us-ascii?Q?SjZNY/JyFLlA1juDBELKXAG6opjJQo6ociT5ufqugNBOt6hCvtsDjocQ+hyx?=
 =?us-ascii?Q?kvmd9iobaMQYZ+bKm/bviGUNCwFiJ/Huve2jnNKIekaI/MK00cX/A/zJ1iQg?=
 =?us-ascii?Q?pGTesdV1R++5ddhq0jtvkhfxaNa0r+3DjA/sHgFxpHfVr5EWoh6rrTsAbMWn?=
 =?us-ascii?Q?1B1XygiMi5dPgCLfO0quINHR+zUtFyJPhKB9Gk2dhsdWyU08xja1Y5HvjuoR?=
 =?us-ascii?Q?s76ItVvO7PDIoUCqd28WbsMNe8BlHPyJOR0tyWvMWV5SiUXmD+pVSTMnVL2O?=
 =?us-ascii?Q?6i06C01nHyNshmCP1SP0ilFLawZ2gKfPsKm16G6L107KKFR/5LPuTGAE7pQG?=
 =?us-ascii?Q?VhoLolkPHEn5P9HWgd76w1bpqkL+SpG2B9uPDiLEEUFawJgmcVSexgKu26hu?=
 =?us-ascii?Q?PX/TraDo6fCU15hZZHWEQ8PPbegbt+LzyMrWYfQue4FXCTQ4MLCPi5hRcgns?=
 =?us-ascii?Q?u6srJqZWjQ55g3uHYP7/p0rHSj1ONoU7GipRzRusnYlh5ssFIw3AIHpWzSyY?=
 =?us-ascii?Q?2WdZ7JYQWCWTfvb6j3VVNEnGMixktmsQy+bINwna0fSk9Nd5/DoQpjvCpP9l?=
 =?us-ascii?Q?BLQz0PAm39gm5C63yv8GGcbJz6pd6OcF41cGxGuC9jfxrjxsRuU5PT99l9L+?=
 =?us-ascii?Q?tRSsCdoDy5NxgmDJddw8xAYQdgy3pbVgSqbiQ+7wQn/JnLRqbEpNK3rXgHxm?=
 =?us-ascii?Q?EMU9Sos1674J6YYQ77/KcC0HasSIHWTE83IqDqvxMDt3OQVAvykZ00wYkAE5?=
 =?us-ascii?Q?bgkkrAJrtbZJpoWsy/SLANabyvyKU9oF2rqS0Tjyr3yaLwOC9T/2WArDd4UP?=
 =?us-ascii?Q?yvR0Nw82cyDsa5qH7lBHTrugBLCyFiRvwCPGU4CwQxAOfuCbcRqCUK+4NKRZ?=
 =?us-ascii?Q?LnuZosBxoI6qtnoJZioavIdXELYasL2RpJKl6tOmtL//HE7Y7O59CUrOgW3I?=
 =?us-ascii?Q?JLk5Mr3HkxzdF5vW+ZYtYKPEOULcyajX+r+0p/09rnWhB0tscfkCUIx/ZcAe?=
 =?us-ascii?Q?20jWcP0sNFeI8n8L63Rq+I+Ac2Yr0hJFTDRDS0+xt20e7JLM5fDJ6btSwfaB?=
 =?us-ascii?Q?TC+Ypi9bS9gnxLt2ByLHnHusjN0rFcowuwXO0Zl+iOg0Xya98LmOMuSG/L5n?=
 =?us-ascii?Q?opltGSvttu0KBZ2tmkw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:19:53.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058988ea-d482-4645-c9b0-08de3411bde3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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

If we cancel a bad job and reemit the ring contents, and
we get another timeout, cancel everything rather than reemitting.
The wptr markers are only relevant for the original emit.  If
we reemit, the wptr markers are no longer correct.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1fe31d2f27060..334ddd6e48c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
+	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence == af)
+			if (fence->reemitted > 1)
+				reemitted = true;
+			else if (fence == af)
 				dma_fence_set_error(&fence->base, -ETIME);
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
@@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	/* signal the guilty fence */
-	amdgpu_fence_write(ring, (u32)af->base.seqno);
-	amdgpu_fence_process(ring);
+
+	if (reemitted) {
+		/* if we've already reemitted once then just cancel everything */
+		amdgpu_fence_driver_force_completion(af->ring);
+		af->ring->ring_backup_entries_to_copy = 0;
+	} else {
+		/* signal the guilty fence */
+		amdgpu_fence_write(ring, (u32)af->base.seqno);
+		amdgpu_fence_process(ring);
+	}
 }
 
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
@@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			/* save everything if the ring is not guilty, otherwise
 			 * just save the content from other contexts.
 			 */
-			if (!guilty_fence || (fence->context != guilty_fence->context))
+			if (!fence->reemitted &&
+			    (!guilty_fence || (fence->context != guilty_fence->context)))
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
 			wptr = fence->wptr;
+			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 52c7597870eb9..f93bf83f7f5e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,6 +155,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
+	/* has this fence been reemitted */
+	unsigned int			reemitted;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.51.1

