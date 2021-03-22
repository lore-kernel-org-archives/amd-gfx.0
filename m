Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88351C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487316188B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487316188B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0426189F73;
	Mon, 22 Mar 2021 02:55:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0000489F6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEfobcX1jQbisHjNuGAtFPdodb72Cinb+M2atQ7t0gZS4AT2X54z2gjoRJpoFVKI2387KE3rLiAb3NOKG+9/4lrDXn/Vg3zPx2KDgPXjfvRpHEWx8JLyNPhr26tAJ9H28FAVB5+3VT1p/OZWbfZSBp5sQS3EfXX6xXQX4PXT69EnCNXL2k9NOLzJth9zZ0rDPm71LqeQ8haNogEv2WJ2noLNRepoAne1Iyruc/6ZNX21WlFrU0ZdtoHE3jFBtRqTTXeU49msj1h6xaHwDe6ZL1x4d4nZn15r2DaHIUmD7fMPnW2x0dpa5ZSRIbJkzOS+f4otKjwcmsQjPa1kMjvKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A62ua9W4t4g9B2S8KytdBCzMM06bq+fibpcFmau08vo=;
 b=AST5BF2ln5oj931AQgP1Qi3l+tUWYtYbxzc7F4aurYB6/Y4t2KDAFaNs4xe70wWg8lGJVM66wO3oOgd0G3kLDC46//jvEODMLrEzNO+PXPj+L+dH6Jl6t55cQ/6qUy6b7XxGW1s24tU3kA/CPFlCt+4I9WNforlinK3XJPBhcWpfDVio4HJW0QLDXXXFik84rkGuONkrwgV8wbe+eyNezcJotkALhOu2BC9XaJX3zET6HEgc2S5GD5nDp0QbO38PKaWh6558quQH4fHiyw0ZV073U8Vdt2SpbMxgI8jMooqCNJvshAuLmqWYLClI/77TtnUe2kVyH+GVY4Ljwf+32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A62ua9W4t4g9B2S8KytdBCzMM06bq+fibpcFmau08vo=;
 b=kgnbKrfLM3YCX4QLP3uXSWVBdIWbmuRoQccJ48dQo8wQ627ccTyxUXNWWv35c/4bCZWgK11n1Jtp6/E+chUw7Ye8I9WQUck936of0szmXFXIHFBBTtLgPME1H7r0RQmq+62z95psh8v9YmnBdEYrPeJHzL45CQBVEIl2qyvfK9A=
Received: from MWHPR21CA0042.namprd21.prod.outlook.com (2603:10b6:300:129::28)
 by CH2PR12MB3973.namprd12.prod.outlook.com (2603:10b6:610:2c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 02:54:55 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::4a) by MWHPR21CA0042.outlook.office365.com
 (2603:10b6:300:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.2 via Frontend
 Transport; Mon, 22 Mar 2021 02:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 02:54:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:54 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 21:54:52 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] SWDEV-275015 - drm: Change scheduled fence track
Date: Mon, 22 Mar 2021 10:54:06 +0800
Message-ID: <20210322025410.30570-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322025410.30570-1-Roy.Sun@amd.com>
References: <20210322025410.30570-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21892224-b457-4b6e-cac6-08d8ecdddf51
X-MS-TrafficTypeDiagnostic: CH2PR12MB3973:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3973CE3AAAFB5C87A6894460FF659@CH2PR12MB3973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVUCQ3niUzUjQfduyThNWRTGSOrk+GJpGc6q7yJf+S4wOV56B3pgqQw4AEQuoCOHG8LmTlT7RRJ9xwc6xz7i3aSZZDpObsYOkONQse6mwN8teqkfWasQa5rpG6aFjcAl2CYiInnmlwavLosg5MHf+vcI2XHcyvRza05B74VhjDQE/T7kKhjxBPC8MKdds42Fv6c7FUXWMnziCgoOr5OSdWPfwSxrE5NSGjo/OhOrRv8qnUSJKYXnPdG1RXJXWjsyP8xhB0ZqZaLmnvBk35GfJFNCDRmIwdzzkEXkd1G4hz55BFGMsLOM5YpzYAvL1M94D0CGezELz3K1YOQBcb+IPNbo7dfThLYRfetpVqiJ+QEH62zqT8W/tG2Za8kl9bUdtmyEtJrb3yb2b30pOMcXVEiSkJ6M9jI8V+zEiSZsU21cQsVZjudKDxJGEf54eof9r5586nDLOIHxBDYpV3R/Jkieawojd/O25eWHvxvzQT0DzlPP8zlM2SvlXxAC0DBUMq7i80LissqqvwImrRjEAnrT7/cyytOxRUlyWVS2jYKBzlLeLEstXtVjDJI71e2Q9E5LXZmxMXhs/ZC9Fe1OLXp3dIJDunOlK0RhCVMG9VTW6Vr1xUqGvzjkJiL9bFXbBKQ+lzhTXn7F2PElXQm4FkxMYdeSMmV0tQwy58acfTfOL6awOTfX/EgweLPDzbme
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(82740400003)(36756003)(478600001)(356005)(47076005)(86362001)(7696005)(6666004)(83380400001)(36860700001)(82310400003)(81166007)(70206006)(2906002)(5660300002)(6916009)(54906003)(316002)(8936002)(8676002)(1076003)(70586007)(2616005)(426003)(336012)(186003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:54:55.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21892224-b457-4b6e-cac6-08d8ecdddf51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3973
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Update the timestamp of the scheduled fence on
HW completion of the previous fence.

This allows more accurate tracking of the fence
execution in HW

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..952c553c077e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 static struct drm_sched_job *
 drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *next;
 
 	/*
 	 * Don't destroy jobs while the timeout worker is running  OR thread
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+		/* account for the next fence in the queue */
+		next = list_first_entry_or_null(&sched->pending_list,
+				struct drm_sched_job, list);
+		if (next) {
+			next->s_fence->scheduled.timestamp =
+				job->s_fence->finished.timestamp;
+		}
 	} else {
 		job = NULL;
 		/* queue timeout for next job */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
