Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5E4C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 20:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E8C10E03B;
	Fri,  9 Jun 2023 20:44:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB75D10E03B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 20:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhsu1xHPlVJ/0AwneNk1HRma31U2DvntFhu+BnJc8T7jsgzQjy3JvKWFVvyUcg0M5nj+G/bLnfC1AcKfgZQRAG9vR0Oda00a4GV2AEkjAIeIss1RckdG/ZG/+uGmY96968kngEQ69o6T6qh/f0XuJ2GyupZ3uzsfMjPCnqxaOehMhYCV4W2dsquifnG+HQzGvl1DMMpH5cxKdcaaVkQ8+T10CZ8cWtqZw/vT8LBwMI+6OyyqEMK1Q/21ALu/1w+e6NwZqo/ZH7My49hJxi8TA36CbcRetkT7RMF8ddKi055yisaAVAVht/huQsJ1cYFObHHK/7jCmy9BnMvNjoZlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srn7jQhMESl1koN+daNhHYn4tZfPzyB6+Qe0KXp9rzc=;
 b=jMtXLnp9W1YXLfrIXEYWV9gdUFSOnDp06Ah3RpZYI1ldDHn68Au99wFk9ccUkhZ4S1/TxvV65XmPxx1zbfepJmGNXb7yHgaYXi1GqNYG4h3KsuZcWfKw8q164c6bpBP1gqGcGDjYWhV65AQ0f41HMFqC0mt3GTwnJKubva/SoOnWMOKb6arCKXOOGf2iUO1+nwJZgFlxwOH9Ih8Hk/EW6pvI7jsxyWhnnx0/Q6DEOYDMEqoWdXTtomZOJW4fe3tRAzP0dWIeAFE/X+7DVZ6GeTOvAjQ2ZeXWXQqTe/sfaXjV0RTrYc2KPEDpLyYqGU6AQ7cP7Wp6S+w55WUrrlkllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srn7jQhMESl1koN+daNhHYn4tZfPzyB6+Qe0KXp9rzc=;
 b=dQtkfsBn3z54U2mxSq9WSF8m+ZaPjpDwUgnSk7WtPw8ju3qQWFZJJFcNtxAOhTz+4FO1uIx89eOUn2AQoppis1u1c2/FQI5ty7vetN+1XP1VSSvFBLekdgw0PBSb8LMqtw31qw1sSxOcGP7xkk7IXI5ZIa2Ol0FJB4xg0YE21sI=
Received: from SJ0PR05CA0136.namprd05.prod.outlook.com (2603:10b6:a03:33d::21)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 20:44:05 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33d:cafe::d9) by SJ0PR05CA0136.outlook.office365.com
 (2603:10b6:a03:33d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14 via Frontend
 Transport; Fri, 9 Jun 2023 20:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.29 via Frontend Transport; Fri, 9 Jun 2023 20:44:05 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 15:44:02 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Date: Fri, 9 Jun 2023 16:43:50 -0400
Message-ID: <20230609204350.2352248-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-4-James.Zhu@amd.com>
References: <20230608170705.2271276-4-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 97527b9d-20b1-4f27-bef7-08db692a4402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k03XB4DyZRT7MBtahD1UQrTdH606z68AEIAKTf+5vHSmuB/vOzJGRrgfOQkPinwxukB32zGeGleR7xAj667ByXQCJkAkvqDlhc8K9tRmT3X0jE52Edd7NwP8JSewfAL4o7O898LJJkeO4ySL9rLPhGl5kG8CPAFI68VDDNhyTWWlsyeQWqZ6EC9qogcfFYfU+m89ANT1okDPuKyScP8YWdq4mRxQe6CnFnYJk5ixfekcsHXb9+sr4zBc3caAOFkOYC1grZxQTOm9/kTLm89JGJJEJWv09v/xwTC9qI+ScKadbNIp0ACVlGKtQJ9ObpQx4XF19BhjE4ctfPWrk+sd2to2xrCjGL829PYpw/nADOPm+8P+qBjT9p6WdOk6d/9rTWoQ3BJj2hmgOmP/1AGv8QEwUGUAI3OAFPz8Ko3v2YDHyL95clep2XmhQlYMTQXnkHq8a8B0mMTxCA0yxJi4JsoTQy27rDFz67XYH87GFN0m/2bYWksrHQSmTf+zihJfRBd+zHCHgHMqE6QtQvhyvU4+4lo+gbuEngY4Q6DZfOSlsLJjZvlZA7sjtVJ6xrmTDqLL65qv0jpHHlIhRZIf5cW2Tc7QtLrMzHL6cGJyH4vxfIOjWnkE7N63cOLNwaiNTwxWIjW8rpEKHcDZ40T2VtBf9MQAYUx5ugn4fMxOiEU+pLdR03w1KcZ8fo314qA3HhbCD7tBUO3h2axYKU4TuZWKL6KNVs0mjQN9w1hQ5pilXvt0DMJnyA0fbP9mT9ZKitVjXZAXibDbgNSMdyu5gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(1076003)(40480700001)(26005)(82310400005)(16526019)(186003)(426003)(5660300002)(41300700001)(478600001)(2616005)(54906003)(83380400001)(8676002)(8936002)(70206006)(316002)(6666004)(70586007)(7696005)(356005)(4326008)(81166007)(82740400003)(2906002)(86362001)(6916009)(36860700001)(336012)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:44:05.2224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97527b9d-20b1-4f27-bef7-08db692a4402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set waiter's activated flag true when event age unmatchs with last_event_age.

-v4: add event type check
-v5: improve on event age enable and activated flags

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index c7689181cc22..b2586a1dd35d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -41,6 +41,7 @@ struct kfd_event_waiter {
 	wait_queue_entry_t wait;
 	struct kfd_event *event; /* Event to wait for */
 	bool activated;		 /* Becomes true when event is signaled */
+	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
 };
 
 /*
@@ -797,9 +798,9 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 
 static int init_event_waiter(struct kfd_process *p,
 		struct kfd_event_waiter *waiter,
-		uint32_t event_id)
+		struct kfd_event_data *event_data)
 {
-	struct kfd_event *ev = lookup_event_by_id(p, event_id);
+	struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
 
 	if (!ev)
 		return -EINVAL;
@@ -808,6 +809,15 @@ static int init_event_waiter(struct kfd_process *p,
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+
+	/* last_event_age = 0 reserved for backward compatible */
+	if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL &&
+		event_data->signal_event_data.last_event_age) {
+		waiter->event_age_enabled = true;
+		if (ev->event_age != event_data->signal_event_data.last_event_age)
+			waiter->activated = true;
+	}
+
 	if (!waiter->activated)
 		add_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
@@ -948,8 +958,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 			goto out_unlock;
 		}
 
-		ret = init_event_waiter(p, &event_waiters[i],
-					event_data.event_id);
+		ret = init_event_waiter(p, &event_waiters[i], &event_data);
 		if (ret)
 			goto out_unlock;
 	}
-- 
2.34.1

