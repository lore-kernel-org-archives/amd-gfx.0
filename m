Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22D3C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7487710E0DA;
	Thu,  8 Jun 2023 17:07:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9B110E5F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjhdE6Unb5N+ddMofnYUbvfyAt0xaLKzGsaQQLqBH9bzkr8zP6nVYpw6/TLn+lDJusTO0JcrL5SQU1gK+SAG/Dn7MF+9Wqze1ehKmnxl1BSvR4h2R8vzG1E05pcIF1JAG6Tysv3UGAj/468hTDwtE9f1pzkYwG1oGk+0gGj14k4tQLj3FABRWSs8KPJe6gYzkr3dvEB2DS0qUNM0KWfu6AJ/fUBjWTPho9kmWRC+UWAUctqaTb9Y/2Kc6x4yIaIIvVts5e01CvK8GSEVYDmX9kcYwRHFu03Dgfq7Ml1QsggNIvMf4osZQQpbH1/0B2zVLgLifMZ5t4kR7IR5UrjZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rjLStxrQAbPh78ENE3IQnmViaAMXnZLvKaNmgW52cQ=;
 b=Ds5r/dk02GEgtr8jqmXoas9s3P9YiK1T3g2+YT+KvtHxBfXiP7/oAaytnivsAo8PriOc47PrIF8qAQDuJUxg1U5I9NHgsZSFCeM+BKWrqX9Q7A3/k/gr7plnqwMYQpfP6a75h9FlPSGal3jY/bV1qsQu2MQObGZtuHVnvsKf2achiXqGFq9HZZEOhEQ+LwSBuq1j63082V6KQguEeccB33sEfFJa7PA9+/ctaSIkpRppK+IFx5cyt0rKHuQ061YaRB36HEIAqXLFAFMIOmdaL8CCAIvwvs4tWemKHiny34TLipQKg480/jf1c8O2f43bzc+60w2xGAeR5Ecb1rcbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rjLStxrQAbPh78ENE3IQnmViaAMXnZLvKaNmgW52cQ=;
 b=vjBsXC3J+pdQS6MQ6ThO8AGipm9c9qEDQ7ww0fZaxqNMWWKsstutycXLJOzEb19NzYjYN2EGmdo3O5+JM9D2LkG/0KZFe3K5QF9/TIKvLebwyamxSEJwOdaUVbLwOdNFhOzQzZnl/NuCs3AszdDENVLCXQdczMoKZHeFMK6nnms=
Received: from MW2PR2101CA0035.namprd21.prod.outlook.com (2603:10b6:302:1::48)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 17:07:38 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::6a) by MW2PR2101CA0035.outlook.office365.com
 (2603:10b6:302:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.9 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:38 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:33 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Date: Thu, 8 Jun 2023 13:07:03 -0400
Message-ID: <20230608170705.2271276-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-1-James.Zhu@amd.com>
References: <20230608170705.2271276-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5f13a9-b2c0-46c9-af41-08db6842dce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TRQakGEeQKr9p9YkhOP57FCZ2I2YomzPXKVC1LcegAqnSO8GL4nwg4/a+oCzysS8zT3gHBYR0/pHt9m997xynlZCYjRN++ngG54+OaKgHoukJAPrcf32g1UzXuLYBM4ckWOiYvoaCim3B8qq9+xi3HL6XuUTgNhMvp35iMxwpkS/jXcE0WRpzrts+kg2GJY4c0xYs18ayDDo9NKpGuQNihLff9N1XpAB1nU6nmQC6BaGtieAqAwAeAAcjwPNnw/QCQvTPy8ukbcjtGoza/hQza/Al/ObVvTKTccRUD8cAPNIRgDlFueYBVsWh/lzXof88jUehscxuXZ3pZbEIdgTf7VUpb2XvWrc8E1dcLHIAe5fd8SDhQVrNnJR6aBUpUfFBdNsUPomix/P5Jok7B9RYd0EsMmGfQ1tPRuuH7Tii3tdnOrkRuIJJFV5f59AIqKVRxTthHQgOEPKFLlYM5jcEmm6nxUZZNa1u7uonGQqv5yWTYXm7mbM1aUTDWuJZa3RVW8sqoXKVcdlKEW9Ikok5lxLqJSiIn/2D6wco3XB28t3DHFLcQMvNQ3CUqpJd77kP89P9ULzZa6jkcWDutp0WeqZNd3zC4CE5YREu0i8rtC3fE+Hap+pkew2tuamG++ImXjG2q8E03cL2GDkvkb/KEecs5t+5CVmIhfZithj4sf5cuQvN7WuHL1juRU3pb+wpzj1qVWUyEI/vPnnLLV36pr8IeJKn8MXfuHz+huXCOLy7wM0rUWd0hSC2vMmxEZX+cBLmWFI8JMtBO8t7vkQhVoKxWQR5fsYoyuoCvNCqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(16526019)(336012)(2616005)(426003)(83380400001)(36860700001)(47076005)(186003)(82310400005)(6666004)(356005)(82740400003)(70586007)(70206006)(2906002)(81166007)(7696005)(40460700003)(8936002)(8676002)(5660300002)(36756003)(54906003)(478600001)(41300700001)(316002)(40480700001)(6916009)(86362001)(4326008)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:38.4886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5f13a9-b2c0-46c9-af41-08db6842dce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index c7689181cc22..4c6907507190 100644
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
@@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+
+	/* last_event_age = 0 reserved for backward compatible */
+	waiter->event_age_enabled = !!event_data->signal_event_data.last_event_age;
+	if (waiter->event_age_enabled &&
+		ev->event_age != event_data->signal_event_data.last_event_age)
+		WRITE_ONCE(waiter->activated, true);
+
 	if (!waiter->activated)
 		add_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
@@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
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

