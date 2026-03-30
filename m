Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC81FC97E2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 08:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC3310E00D;
	Mon, 30 Mar 2026 08:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CyiSrt12";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7932E10E00D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 08:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkjjqD4QsnK7cDmZMVzyTRc/sO4jVBuC97gwzT6HglBB1stx3PzHKdJWRutBHYg3YyUVevbBpKD/mtH15jWvL2nd9k1TTQ3TQO+vvOc7TW3Ej+r3peXHX7kce/p84/tbA022M59QN+yv6l+nM6LoMTNno3viQCvFchz1FppGrn9svEiC9HIIbDHLig/4TZy8zm8oYWXiX+qzMz0KRJyUPJdd5HRKXV0lGB3r2DfA5pxMSA28+8Q1KcrIVaA95v8YuMZhx3vLMM97VJEsivfH07cBWWB3HH0LPEWTs1Xeeg4K6MbYTgAIlak8gmqMo6NZIdn3Qpc6XQJtEKEV457qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnvrbwLLG54eAPjMJSSPCSvL7/lLqoMCda4duRvsoc4=;
 b=YAEtcMfgsC8eIDl5GOynBhq5eNhJCB4ZHx24wVp8MnxTHier8mNk6lRTNrTvp3ZwrBD84AKkrNCNKOSbPotEMPvQ5zLlNB+9P434nZ3uDm8ai6nMfFC7VEVq908RUu8liOfQu64Q8DqbSRAJurA6gKojydiciQKIvmpbrnUmkyY2/APn3ZBhX5lPm8nLjnmMU7+s3AW+MoNQ7kFGdYV625ZlaMvQjhctKL9WUcoxTcz4B70fLml8bQhvsRlFRaPY9XTCzN7ZBYgAqHgrD2uJeJp8iHAtINhLLrY2krn9lkJHR3NYkq1/AHRENqE2F8Y9wYZAxHVzHuEASbcq9CWe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnvrbwLLG54eAPjMJSSPCSvL7/lLqoMCda4duRvsoc4=;
 b=CyiSrt122+MTZCzQQNeHey31cGJiCN9CKUNOI4GNyrvyjo+at2uZtGT/u8t/Xcczr3J+vlVNIPdcRNe3CPWPzeZorvgbP2oDz+xPN3JfRNUyt9hjsIlcpIXZAbnPXQlsI9krlMwJJUCI0yHjV16T5hT9gMxpfuQF338ogt9VGqU=
Received: from DM6PR06CA0094.namprd06.prod.outlook.com (2603:10b6:5:336::27)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 08:38:41 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::3) by DM6PR06CA0094.outlook.office365.com
 (2603:10b6:5:336::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:38:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:38:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 03:38:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: run user queue hung detect before decrementing
 userq_count on destroy
Date: Mon, 30 Mar 2026 16:38:05 +0800
Message-ID: <20260330083831.1144112-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d23e8ea-bfe7-4f0e-1f0c-08de8e37beb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3VVciMxPpZZOj84/5qecmZiX4j0v+a4upgH9KP8kswWfQHmm2vVU+XmEZglh991Nnecxg5/jTqkvAGQzHatk2SSaufYKqYmc6Hm1ULNofooajkGIMK/cp0bgm5N9cy3KNBDwxqxV3iohoENMl6XDJMgn050zEl/g7+/tk1MNYmbD6JZs1CjnLtBg2kyKmnvpCM9t5YTHEoYoY1EgrxB7iaiD5bGBqwrviU0nSCS5EUapBiqYjsTWMh7TOdSZDKcCMAsYMK1th8/C5VK+TsYPmwMH5v2BZ712EmtrnlA7wU7LvrWwUUrWqPztTdwZVVJaMTJ7jVlhXSF3xxxGzj7jQeXPy2RxCoZZuQWhtaePAJ91ST0pwP5SdftmC1gCidGqhKYwX3n2ahxq5TGqf3EgBPenPctcIeeEueApnu1FOCupuu+ZY/AeaH0dJybAUJatEuQ0p5yaZ/VR+jYBDrfCZa0YRCJrcDRWFHEQ78pRTfGsijyQUsaiZK6hFLWcL+ONdiob/JIk3h4RSkKG6+1IXZqsWw/aV/elhImICMsLp9yI9k8EoB0a4Z2SgeqZWAK1+8qaR2SzDo3ijWjlEo6e+7bInj2TZshDI0XIGTGxk1UqfP69oXSWP0qrjqm7RHePaH8M+fDYDvXEZtrQGJtgCDnEIZnrnVCGGkh4mZLvj0MA69oaLf4FiUw2uDGdp42qPlCGRXeEaC+M7KsyNB7fueOnPoffgOZS5i3is9BZNjkcE2rYJT8zhI08rQ9ym6tGLJR8+LRJuUQVw8kmEo6Gdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 06Bw432Zep23ZaCjXkYWU0NugC4RGWc3oRxCEaGefp7Ro8dQS4TdeSRtubfhKryl1h8NSYQu8x1ickjh9dhrJ8evxtvQwlMNw0NOH2TjWI6HK1aXggLUVCPzmrYWGVxHZyXs9zaO47HaQLDWhpr8GfvLXIPqo7yCa4PqL4ouILxO/SIRp8ILEVNNDXmK7EbLSNe+mLe3ZAUp4nt/iHaLMkN7Whi+jJNKgwn96M0LRc2QDtT7kYjoQFAE4aG0/ysvr/NcJ7IB8Jkp+Lt3MVkxRqNT4zu1xGqQiAk3dgCkxe3IQOgpC4bqiAWYP5X9l5y2DI/j9QkWtPDNSzDpSAqZGEp+bZszdMo+q1IIBOIq6JLJZNUwoNUg7MDki53xsvDPxQ8IavdwZPjJK36r9VnpZWC7kxIcfPF/D1zfTdumU2kfR/pZPyhiHzVITHVzfvtP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:38:40.6396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d23e8ea-bfe7-4f0e-1f0c-08de8e37beb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

amdgpu_userq_detect_and_reset_queues() only invokes per-IP detect_and_reset
when userq_count for that type is non-zero. Decrementing the count before
that call skipped recovery when freeing the last queue of an IP.

Move atomic_dec() to after detect_and_reset and before unmap so the final
queue teardown still runs hung detection, then update accounting and remove
the hardware mapping.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aa0e6eea9436..d64cc9d700a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -652,11 +652,11 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	}
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
 
-	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	r = amdgpu_userq_unmap_helper(queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
-- 
2.49.0

