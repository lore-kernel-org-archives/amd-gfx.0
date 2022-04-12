Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48755C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 21:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDA810E6CE;
	Tue, 12 Apr 2022 21:59:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D1010E80C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 21:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6sbuRm9+aiLBszSHe0RgTWen8h53FSBdqmHJtgQjh+F2W5QbiEq0sNGR6MuuErXlZPJSJkdZyyh31zA1MMBp7nTya35NLPQzgao/l+ssKIF04TNnClr1U92t1V00JJL2rlJ3YP35rABwzQcq4werHQygZpJRrIEsAE1BIjzoHooM913bHpQiZQlkjA6K/YXIePLXeS0+HNee+FsuXjQyZoPhYVOHgs5iviZT1bnlmVTrfoX8c0mj7vnYgPSXOdFMvaffo8yIYhq8TOrfcFPPvS9g3EfnJiyS7rLLDwS/VQcDd4ostkGfNwwDYQwLrqcSwwQSvCZmOtF4yDqPVEHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BTpc/uOeSkWBf+FKQ/VH/hBt79hfPRpPOy8WHcoU9k=;
 b=HfEqreBZpDKEAx3x2mQ09PGDVwu/ABiV2gPBTO5VdKwFUem9NTAXoR+FoRxFh2dPfB89UcZssIIvRn/l0pQnB4XmEJ22QnZRe8SMPTbySKYKfXOkLmwx9dH3O6ZYbWGg5X7DZ25z+HKf6rn4msIPPZw/vIN2LLmmrtfXxHloRI6Svz4I38XcPFh55fa0tXxbIJUFOO90HtqJEaFWdDowcrSO5Ipmn5L81zRwGxqRyZlb4e5yCFUelUB8hANlQ9hoC+G20XIhWzMPFqIiLEJY1Vv6v7FM7WATadmjs8s4QMmYAJhpgPc94GSJbn4nS2QNGsOb8eO75nBbNQoOXZkShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BTpc/uOeSkWBf+FKQ/VH/hBt79hfPRpPOy8WHcoU9k=;
 b=0c5Rztb/WUF2bK07jgX1R0MJo3MDui4wjKShO9FrnSEJ8RURaF1fLTio6EgTn90N3Wahhw8u0q2jKAJ2ySPdpvSjj49/DCrk64PejXUApoIe/IRS0+GuGM+TVO0rhmSnb6XRkzAc1FZikUaWH3xiVY/tyNWjzydcQyzVCRtDDeA=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by DM5PR12MB2390.namprd12.prod.outlook.com (2603:10b6:4:b5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 21:59:34 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ee) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 21:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 12 Apr 2022 21:59:34 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:59:33 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix race condition in kfd_wait_on_events
Date: Tue, 12 Apr 2022 17:58:53 -0400
Message-ID: <20220412215853.487491-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f96b92fc-8e11-4fc4-4116-08da1ccfbae4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2390:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2390D705773F643A76993D7692ED9@DM5PR12MB2390.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYr8Wp/+2mwPLnqz0v+6DeCZYXoErvaU9Fnu5ImD1fL9KHZTn7nPHCi11WNkQzyxAuvymRkJSF6n87MDyJ2qAGHOYuwyVBp10Vzok5fansA5kelR7ypgZLFxtJMPYfor2d7PphFMyUoLuUzHTDc6S4NrFfJIZ65ChRq/qK/taEelKlFy1EyU/iCx6aQgWf78osQZVTymCRtpi4WeRbe91EDOlSnVJhcAYPJFD8jE4WO+9r0Kjih1mo5+xPXhu6fuu4GQSeNGZKwDaamRV7+WeoNqDBSgeNykpmueS7pYSLcux2GAN0S7bF4HY+8ac1bIYlqLqsnjoTGbqrHinOjH6cm4BAmS80HnAozl064HZ4uO6/dlChpGMf8rrD3rwrBzncft3IaFOLouWJnbJSJ9+hRkGr81crl/O0baSvd7rss2OnXkNk7ISjqM3G+dIt4//tMhWm4W83/fF4w00+0tdF5yIfvMYpjawBpqPXY8l1kNn/f9lxJwelgCxd+MyqZtiZ34isuw6JGwhB0ef3K6EFGeJxTJ2WBquXOfIozCJ/BvdZcocljdViyCyB+joHf3RLazjiFsg2WgI3LDQVKOP/X6oa5Qt6v/I19Ltp6iCbzhPP1/LrgjAOcoyu1imdgSSKNYd3TOViqzvtP5Mi6xcv8zbadIYyHZ67mgxqGqWQPIwNMU2pXf4+elBQ3FnipPWZowTLx2mKlyuP3bOO5HCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(336012)(47076005)(83380400001)(26005)(16526019)(186003)(86362001)(40460700003)(81166007)(82310400005)(6916009)(36756003)(316002)(8676002)(70586007)(4326008)(70206006)(5660300002)(2906002)(508600001)(8936002)(2616005)(356005)(1076003)(36860700001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 21:59:34.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96b92fc-8e11-4fc4-4116-08da1ccfbae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2390
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
Cc: sean.keely@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the waiters to the wait queue during initialization, while holding the
event spinlock. Otherwise the waiter will not get activated if the event
signals before being added to the wait queue.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 26 +++++--------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e43bb14adfca..ca562b9a8abe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -784,7 +784,7 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	return event_waiters;
 }
 
-static int init_event_waiter_get_status(struct kfd_process *p,
+static int init_event_waiter(struct kfd_process *p,
 		struct kfd_event_waiter *waiter,
 		uint32_t event_id)
 {
@@ -797,25 +797,13 @@ static int init_event_waiter_get_status(struct kfd_process *p,
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+	if (!waiter->activated)
+		add_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
 
 	return 0;
 }
 
-static void init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
-{
-	struct kfd_event *ev = waiter->event;
-
-	/* Only add to the wait list if we actually need to
-	 * wait on this event.
-	 */
-	if (!waiter->activated) {
-		spin_lock(&ev->lock);
-		add_wait_queue(&ev->wq, &waiter->wait);
-		spin_unlock(&ev->lock);
-	}
-}
-
 /* test_event_condition - Test condition of events being waited for
  * @all:           Return completion only if all events have signaled
  * @num_events:    Number of events to wait for
@@ -945,8 +933,8 @@ int kfd_wait_on_events(struct kfd_process *p,
 			goto out_unlock;
 		}
 
-		ret = init_event_waiter_get_status(p, &event_waiters[i],
-				event_data.event_id);
+		ret = init_event_waiter(p, &event_waiters[i],
+					event_data.event_id);
 		if (ret)
 			goto out_unlock;
 	}
@@ -964,10 +952,6 @@ int kfd_wait_on_events(struct kfd_process *p,
 		goto out_unlock;
 	}
 
-	/* Add to wait lists if we need to wait. */
-	for (i = 0; i < num_events; i++)
-		init_event_waiter_add_to_waitlist(&event_waiters[i]);
-
 	mutex_unlock(&p->event_mutex);
 
 	while (true) {
-- 
2.32.0

