Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C946BC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED55A10E5F5;
	Thu,  8 Jun 2023 17:07:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C78310E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I57/4GAkVUETNEFvxqwvLmC6+jdH1wMUYod0pjx5DyM=;
 b=GVHk81e4VIbvM6al12AwPDnPpWwFirWziup7gWOca5zpWRCOqmgwDnaLllFoz3rSaZSBU+scRB3/6//D1XLtFLK2E66cr/c4sFWUzBJRRo4/PiCJWQdlYXS7yCxN3zTSSvGT1c36OELLvxOvsIgfWhafPgFwWsUU8mcosmnX/yk=
Received: from MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 17:07:37 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::8f) by MW4PR04CA0200.outlook.office365.com
 (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:37 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:32 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/5] new event wait support
Date: Thu, 8 Jun 2023 13:07:00 -0400
Message-ID: <20230608170705.2271276-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 29219d2a-3c81-4c91-8b1f-08db6842dc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ChU2glvtn39TCFT6vEiVkdxo1/4W+NbvqkVtNGXdhzA4gu3uOnXViPBb3sYx6C1vxgfwvod2EQLAR3bHRH0PTj0oGALQuQuD+TyZ+jYukJmkvZftqmq2HlAZUGuEiZnu8Es7t/Qw+5O36XZ/27DkohuZVlRp+g8IMoLElFYr5eLqhbUymETNPsGm9nzC28G4trIrp5mv/he3x6auOCfxb2WKXa/marv6x4HT/tPSbqWVc6KO6jp+pg+J2v13kyYuF/38ONtQY4U6DkXMJRVcr6WdVKhX716jQVrTwhWOoQ9LuqDDOdhQ7R22Xnu4fxnpr7eWD5UddKrOpMSLsVmiyv71pfARfmi+ACgyHSZqFF4avTILjMGM27ZDmxXA8gxh5RS4MTdERbBGY0tQWyDrBo71y9P45ckd009i9XVLwYhjrEw7wfjVvfCO7oaaLQ2mAyhcvax/vRQrYYqJO7777KvRWmtFhHp4QxPH3gS4Y5fBR2Vy1S+R6DzTuvpOeaGdJSDne8ZV65O+y9doammjF1A2wDrXdhbjjsz59ynLnffIE5gDhO+72PYeXZ9YK9T/Bxue4o6ELRO1PUF8tZcYVyGAp7HGbEbKcsL2jJ05ENoS/X/lXeb545LxZ59yMPTIcbZQNQM8iTi1QlHI98T5/Yxg5O9GyxAettdi7H8TdlLjUgFHlDqbFm+7ZQZoIcAvBz11/7jz2uXiFy7oLGgDNMCEPCmUtXK2JVord3K5rsehvrSIixDcwpIgSgfHUk2P4xevV7rWwfVT0otwr6NR+LGL/R5hM6SpfsMPmS1yTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(82310400005)(6916009)(8936002)(8676002)(4326008)(5660300002)(54906003)(86362001)(316002)(41300700001)(478600001)(2906002)(356005)(81166007)(6666004)(82740400003)(7696005)(966005)(40460700003)(40480700001)(1076003)(26005)(186003)(36860700001)(16526019)(36756003)(2616005)(83380400001)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:37.4653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29219d2a-3c81-4c91-8b1f-08db6842dc4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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

In kernel amdgpu driver, kfd_wait_on_events is used to support user space signal event wait
function. For multiple threads waiting on same event scenery, race condition could occur
since some threads after checking signal condition, before calling kfd_wait_on_events, the
event interrupt could be fired and wake up other thread which are sleeping on this event.
Then those threads could fall into sleep without waking up again. Adding event age tracking
in both kernel and user mode, will help avoiding this race condition.

The changes for The user space ROCT-Thunk-Interface/ROCR-Runtime are listed below for
review togehter with kernel mode changes.

ROCT-Thunk-Interface:
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/efdbf6cfbc026bd68ac3c35d00dacf84370eb81e
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/910108272091d1ce61dbc48bd9519731e0e9cf52

ROCR-Runtime:
https://github.com/RadeonOpenCompute/ROCR-Runtime/compare/master...zhums:ROCR-Runtime:new_event_wait_review
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/e1f5bdb88eb882ac798aeca2c00ea3fbb2dba459
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/7d26afd14107b5c2a754c1a3f415d89f3aabb503

-v2: remove unnecessay link

-v3: 1. update kfd test cases (910108272091d1ce61dbc48bd9519731e0e9cf52)
     2. move event age match checking into init_event_waiter
     3. move last event age update into copy_signaled_event_data

James Zhu (5):
  drm/amdkfd: add event age tracking
  drm/amdkfd: add event_age tracking when receiving interrupt
  drm/amdkfd: set activated flag true when event age unmatchs
  drm/amdkfd: update user space last_event_age
  drm/amdkfd: bump kfd ioctl minor version for event age availability

 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 44 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h          | 13 ++++++--
 3 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.34.1

