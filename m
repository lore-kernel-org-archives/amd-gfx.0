Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8FDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7762072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BzOREnwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7762072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741096EB69;
	Fri, 10 Jul 2020 05:45:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AEC6EB69
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 05:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bci/oxvtwmwTGIDs9hmV07WwlyzWSYzTgeiP7uMducYyEXQF+TMgQA78jwKyi0a6a+dNigQzcOAEosOYkIRlkITSPB29PWzjYTaFHbzWdnvacKG3uXu9qoNx2oCmC5EXM1EqRKNnXvhB5zYLLmHCz7RgZzIv7yOUeRXWlAqmCpUN83z/f8HgGatB5OCTeYY4WK51oYJ+17VVsHvcm3ZRtxFeysqE7mk0WUk39DGeWGsv6SWQDAT1JmMNTd+H7ipjDhMwVbj4Ew13Zcb/Pi3vzXR405fZZHLUFk2BSXQmmWRb8KntVxhKoiTlPKxur69YcWQ6PYFyrOA2EVBWxD0ebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q++11sRjgEvqrOcpvD1oilPNtrHHk30dPaNGwAMazCI=;
 b=hVTJHNhZAi8YBMudQfyJlmPjVfruOjf4ZvnpMUb+/kVL1XW55lrvt9C0vx9fu7prPmsI0lS22CdzJbcU5u6nVDCHBFGUWWIcucsyZt/b5W3X+Ry8mWrkCCQ1yBKAANIx+v2ANi6+JkXTZg+hQVQTRcNxEUQdXi2XUAxop7+dkLJ4Xufr4rDo4qYm//sXbOn3tkoYtgCxEa62+huupacFh4zYPM2QSQBzhcvh18UrnwjCNqjFjg7JYn7MJO6ZOXZvhiNwfeg1pLlWNH2HlBsDiVjOFaUThsV6Q63+SbpPNnF8OhwfQYw2vvFEpIhMKdChoZM0Zg7ZojV4eYWqSSsRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q++11sRjgEvqrOcpvD1oilPNtrHHk30dPaNGwAMazCI=;
 b=BzOREnwIGarLYXS9hPB9bOqPq6TDae2kSyGWeRIQDiOG50oebuUiX2NDpEpugwrIHD/5pjogmGSPHHBcbO1oVdlyanJg7hV3P6Fl0FmdHliSsWnQbaXjKd5J4p3ZteyKKna4+VeY/PyQ9LXlEV1HKdeJL6EWPUjh0p+l8qvvxaQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2474.namprd12.prod.outlook.com (2603:10b6:3:e3::8)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:45:12 +0000
Received: from DM5PR1201MB2474.namprd12.prod.outlook.com
 ([fe80::8c23:3013:c186:ace5]) by DM5PR1201MB2474.namprd12.prod.outlook.com
 ([fe80::8c23:3013:c186:ace5%7]) with mapi id 15.20.3174.020; Fri, 10 Jul 2020
 05:45:12 +0000
From: Jack Xiao <Jack.Xiao@amd.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
Subject: [PATCH 2/2] drm/amdgpu: fix preemption unit test
Date: Fri, 10 Jul 2020 13:44:52 +0800
Message-Id: <20200710054452.2058855-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710054452.2058855-1-Jack.Xiao@amd.com>
References: <20200710054452.2058855-1-Jack.Xiao@amd.com>
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To DM5PR1201MB2474.namprd12.prod.outlook.com
 (2603:10b6:3:e3::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jackfedora30.amd.com (58.247.170.242) by
 HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 05:45:10 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1700bac-b51b-432c-5b40-08d824946997
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB326057245CEA920333757829EF650@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVngF7pCmieuBS2vsYKoRhcnRvWZOv9mqCw1q4BYvpcILqOBwCIUm+GbkF01Jqk46P3F3oE6WEXPZdMKnATutgFK+XqwXHqhD7+9ehzJ8zyafBoPQ+bcsoQH0D5He1Qc3IvgQulcniCKWNtTdeXteUpb3IJDNnAaTtVimz15E9iyHQL+x1d4sYzmu1gH57zZ+lwJfjPqiupV2hm0A3kAaqOuRPoyRWGAcaFDbQbzS7QHjXRHyyq9ZR9+F7NdrDpH1tL+uOL26dRwc/29Lz1cFNVYszercUb0Y1KKEWafFcdqcAoc11w/6GXisdgoU7Fj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2474.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(1076003)(66556008)(6486002)(83380400001)(5660300002)(66476007)(66946007)(478600001)(8676002)(2906002)(6636002)(6666004)(4326008)(8936002)(36756003)(186003)(16526019)(86362001)(316002)(956004)(2616005)(26005)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yD1RfxBgEds/vJGo2EccH2etGev/3L6WdAPCHzotVfpUGjywoQeo2ObmzDt23ZMgHi8lNCUd3dYFM1zcYII+1Gu5SWan8GZu5w+h5ZYEePMK9sUREHrXKOB+LsnNReDmHmDJ0WdRQiQFbIzSFOSR6XcJjYaWc2zHNicmDnj15m7NnrnXqJ5vBE9kkTFuUJJlp5aHff5VPeT9mwluYz3cejv2uFObZdDvxDECiIkoK6XVHDqYedcHt7Mennd79tLhQTM13e1uYdcHTtpQJpUK5MnQdyu2oPYagDtNAUYsE8M1EvcagOkSX1eBg8hfLkrOQmxfP+bN90p/KZbx2SXm6Bd3N8/c1G3ypRVjR9GBeAwt1QXUzTRhLBmvaqrZYXpAvrA/P54mZYbc+itqLIw9F8Lpq8jDRYnRdTeuapDx+TfRA967yZet1JPqrqhRctfx9iW/dTwmdvZ1FyvjQBU3iuN1uchkdPX01MnYaUPC0bK+UFTt/T8L+nv7DW0JQD4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1700bac-b51b-432c-5b40-08d824946997
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:45:12.0021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mETxx+jSExf2wCTmIJgIA8we+3w14Lol6vbJQeAi6lMXwtLhWZrEuiN7x4Rn0PBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove signaled jobs from job list and ensure the
job was indeed preempted.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeada7c9fbea..bd5061fbe031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1343,27 +1343,37 @@ static void amdgpu_ib_preempt_job_recovery(struct drm_gpu_scheduler *sched)
 static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 {
 	struct amdgpu_job *job;
-	struct drm_sched_job *s_job;
+	struct drm_sched_job *s_job, *tmp;
 	uint32_t preempt_seq;
 	struct dma_fence *fence, **ptr;
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
 	struct drm_gpu_scheduler *sched = &ring->sched;
+	bool preempted = true;
 
 	if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
 		return;
 
 	preempt_seq = le32_to_cpu(*(drv->cpu_addr + 2));
-	if (preempt_seq <= atomic_read(&drv->last_seq))
-		return;
+	if (preempt_seq <= atomic_read(&drv->last_seq)) {
+		preempted = false;
+		goto no_preempt;
+	}
 
 	preempt_seq &= drv->num_fences_mask;
 	ptr = &drv->fences[preempt_seq];
 	fence = rcu_dereference_protected(*ptr, 1);
 
+no_preempt:
 	spin_lock(&sched->job_list_lock);
-	list_for_each_entry(s_job, &sched->ring_mirror_list, node) {
+	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
+		if (dma_fence_is_signaled(&s_job->s_fence->finished)) {
+			/* remove job from ring_mirror_list */
+			list_del_init(&s_job->node);
+			sched->ops->free_job(s_job);
+			continue;
+		}
 		job = to_amdgpu_job(s_job);
-		if (job->fence == fence)
+		if (preempted && job->fence == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
