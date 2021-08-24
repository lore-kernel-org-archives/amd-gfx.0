Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BCDC4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 10:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155026113B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 10:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 155026113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74FE89C93;
	Tue, 24 Aug 2021 10:06:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87A989C93
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 10:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+1U0Reepn/BMCCfrrzGRb8w7Ww70NIfhJoxArVn5tYHbgeKh8FKnnrx3Qt28Jhpmph/3ePMbk0YGoNNKAXO8WDyW8zv5n9M/hzWaJsoJWDki5tN34Z+dUeWhu9ZWydDY1HTC64Iguyhk1g18ShCmN1QsfBld7PRlzmfeYl7e0TMf+CFH2+ACOOJZ594iH5IUqZK7caJSUu10jz0plbNCwdRiXldhIUrhjAFz9oOUzkmH3kiIka+wbaW2FW52WVxyh+nPNuNB8AHBkiicUrIqOjDd1bA2eUFHIV1rfmoBtFdK/xwf6j19gCNFGOs3cTAdVIDFeMx6D+HhmE3zvL0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItsId2gYIy7QowJg71yp77eCtRrIFD0qcrO1wTN2T9k=;
 b=ePGTznKR4hE8f70NxKQC78O0kXzKkmiAMYg4Ucw8PRZh6nKHzwq0B3gM7DsQ8REfHZJbvVy/1QeAgAlf72ZOg6D6vf0yw2y3qwJpT/INuLWe84VHOjs4rIv+kx32SNIhyPuTdWwI6TbcFexEY9rqLxX3cPqjrfdSZGLrILYhPMayJW/CQgevmhAJ77W8ybkzImGElJncykYesi2XZEuoq4lLd7rtc3xIJOxgVzhvXs/192xlJnBYTwWxtyuN6SIAAUZ1+0Ogq+6tG3ncvVe0Lr2laik1pQ2l310oCdfs8PfrjvOrYMCZQvGklPpVqe5UO4nijDkbqFkY53qKmk9u+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItsId2gYIy7QowJg71yp77eCtRrIFD0qcrO1wTN2T9k=;
 b=xpkwN0xsduJYHrUVcnNfLghdjE+9f/IoaA2/CX8XmeNoTZOSZD2aD8H5hrjMzt9HNXI5B0Qc2E1jYBz25ISmAAUEoVrN8E4b1iCVc8rjgj1b/Gi/ScpASqU0x+zp4QvWbpYFoZwNuWouADNJtJm+jabOdRSSZcj9YC7Ryxtvga0=
Received: from BN8PR15CA0045.namprd15.prod.outlook.com (2603:10b6:408:80::22)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 09:51:37 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a5) by BN8PR15CA0045.outlook.office365.com
 (2603:10b6:408:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 09:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 09:51:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 04:51:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 04:51:36 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 04:51:35 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Monk Liu <Monk.Liu@amd.com>
Subject: [PATCH] drm/sched: fix the bug of time out calculation
Date: Tue, 24 Aug 2021 17:51:32 +0800
Message-ID: <1629798692-21361-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34dfe19d-46b7-4176-895f-08d966e4c39a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52463BBF303C1E0E66CA4E1E84C59@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9fkaO66USjFbJ35cZ7zDZ3q2i/CTK3ahiNxyK6Z0K9EQZmn0PAUdi2zvQ6JGgOr7NZjY6BsRjIfljy77JdJ0RVDLXfXJgPkMAk/W0BAHBcLXzd93zFT9XenePOEl4nJ790/rsWAquFLq/pWg6Mf4uS/L6Xt7JTji11fFYCFOl5X1+wQQ/ViS3lEUJhSVj7XeUxTW43tF94HI/1X0HzWqRaBP25FP/gctCp7tp1zEQ95PVcodz0AJUQd8kmzTYYbUdcGmrtFrosM29lhS2RrwPVesdI+tAoSWg+g5HHkrEKYyL727GSh7u5+U65K3PKKtfuWnni+EZJAHaNl2szNmlkOIY5pAQ4DBfayw4sq4w8zHmxIXt9ClPE2FraYiu5VWbRX0bwgt64utXsLSiYbAYuLmWZtJxmCxEzCcMq3CTSb0erM1wXHGzxVrvIOx0nAzFH8rzTh1WwquUMFkIMSNlorr7vFX3O2SCCzX+C0jcHwjgJo+k9VxkEma1UTdi45MWrzW1y8UoCLpemEjKhrKfzhjZrHb3pVbjHMsnFraAsdywdF8RbLWZHuc/ObfW+es137OKIDr3vkLMFHJ4NQRonBT3QvX748evVMgisYteRwhNXxiSw8XZ1vM67G/nwDMPiZdNEmFUjUGx6eEdpwcUmWg/JLcAIRA+KTHrJmtUmFlzSsNsm+0tbtwWp1/bzUA4v2yVGpFSElrl7tyVhC+mX3KuxBnxFMjsexA/x/DHWfaoJmHLHwe9Hm9qsyhwn3Kf8/LalaqFQS54vEvsdbdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(186003)(70206006)(81166007)(4326008)(36860700001)(6666004)(70586007)(36756003)(8676002)(6916009)(26005)(83380400001)(8936002)(2906002)(336012)(7696005)(426003)(2616005)(478600001)(82310400003)(86362001)(34020700004)(5660300002)(316002)(82740400003)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 09:51:36.9477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dfe19d-46b7-4176-895f-08d966e4c39a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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

the original logic is wrong that the timeout will not be retriggerd
after the previous job siganled, and that lead to the scenario that all
jobs in the same scheduler shares the same timeout timer from the very
begining job in this scheduler which is wrong.

we should modify the timer everytime a previous job signaled.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a2a9536..fb27025 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -235,6 +235,13 @@ static void drm_sched_start_timeout(struct drm_gpu_scheduler *sched)
 		schedule_delayed_work(&sched->work_tdr, sched->timeout);
 }
 
+static void drm_sched_restart_timeout(struct drm_gpu_scheduler *sched)
+{
+	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
+	    !list_empty(&sched->pending_list))
+		mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
+}
+
 /**
  * drm_sched_fault - immediately start timeout handler
  *
@@ -693,6 +700,11 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+
+		/* once the job deleted from pending list we should restart
+		 * the timeout calculation for the next job.
+		 */
+		drm_sched_restart_timeout(sched);
 		/* make the scheduled timestamp more accurate */
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
-- 
2.7.4

