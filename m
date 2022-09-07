Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B82C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4B010E82F;
	Wed,  7 Sep 2022 18:36:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C804410E82F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW5cvuOv0BFk1XkzEYTes1hB8Jq9SRQe6dsJJVmHTTO2wjQwMA41MhFCvPnXKQQrqbEWoKLrTGR6GS2pykaAqHqqVlqsuj/o+z6tD23030iTUGOO1xlgH4W1lUsKyzlBoYdCIUzphy7KWuebuX3MWEHlwOkxYn9qweNv4FCEHoEPowvOV0sj7Vh0gBcIgCqUzjrOEQ8JI1I1B1Cz1rMU3Sp3pb+2Fls9RefwF2rln9WOF0a0G5P1384M8GxOFA/rbA8RALYbyGHytBJj6g6M/oqmcvVY6y3vk7q63Hjtg+a3ZzFT05uh2yDwAzwA3FJp/jXGnQ0eL0AaUmgnjIwk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7u4lKYIRETNehYzCcg60K79kNUfkBwZzGNz24txzi4=;
 b=KPwlwJGbpZHXJtoXBL8i9mywWmlEPmh4yRReCTzqS+srCS6AW2Wi+rAEsSVeIF2oZKXUu0rXHnsdRy7wK9M/JmX1xeW/rw5bDzW6zg+DDB248aF9pzw5uJYOF27uHzOqvxsuqaFU3rGbqDB2Cot65kMOLBMW7IPWdcCM6NT6wm1BWrkJ/+DPeUp+oZdWLvcr4uJmS4VOmAJcrgFpEMmc9X5swZ3cGsVKHHwXCd+e5CJaHCL6SXvDI87z0oCCuxWl4obqcOf4L0VTLdZpfBZ/j8pVsNXm2Fzg1ss10pZSXjBNmYj1muTaa6JyKeMsthFUuzgkqP7j5e3z7tJk4eUTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7u4lKYIRETNehYzCcg60K79kNUfkBwZzGNz24txzi4=;
 b=wVfMU1+Cl/oh0rrpllZA8E5NtkSXGh3p0dW5Lt1v/odCa47+jQxLlNa5CvDwIwLjuo7y+tYZyQWn5/+3Dk4Iv1jejrUp1bo29rKwsYjFKsESXFLxHAzaDe7PvqIdZI6vIOHlQsM0fgN/QVTwuBGo37WrFJnXISdNGAxiyDnWdu0=
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 18:36:39 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f4) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:36:39 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:36:37 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix CRIU restore op due to doorbell offset
Date: Wed, 7 Sep 2022 14:36:24 -0400
Message-ID: <20220907183624.26018-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|DM6PR12MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9100506a-1526-4d90-0fe6-08da90ffe74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtAB4rwfrMtDW5vQFaiTWo3tndjt1jeUIYzKPZeJFUK2ZxvfVhKvMx1thiny6fYEPBgFGGOOtqeI4KnwRH3QDRI1DYsxzMrOK8LG8IH5XNijf+7ll/hIANEF0oDcg3oew4FxkzQFPAhoN0gVBfrSi1k2pQHf4FmI/e1oT5UFJZG6otmmraAvh4bi0zS5AbDHhPofktoAMhj9TIL96GdzH+ujgHF+Ilt2C3AtDHymr7icdnSwZvB8fiVjUlUanGCqHcGpcBZ0KOdWID2r67iUbA3BlLxN0f4NCssWeP9SYoiw8wJ2B1hj6zSIdwzvnEbwHzqAMJju6DeAe7VKGNMlUz4ZbtsefEsY0IUfAMB2L1c1tiQp1abQXWl6EKn/ZW62Qr8/uXCOSWE4mfw2DB/OerMR7kOF17saMjULVxsH/3C9hu7KKHZBQ/4p5Tm9580xwNyKAJNtLl6dkck4rUliu6KQhMhX9bjqVdcfdhSo+C7RbQogRhFq8zAsGrvGV2XwSZVy+UtdO2Kxo2cKOLOMndrMO7H8MZILKZdK8wPfTxy9DJJU6UrVweisXU0LXe0jRPkUB/2IY9myAVpktjeEacWVcOYq3MHSOTw9ITl/Zo2Hxz8/Voo/PvM4MI3X8Ue0Oe6rvEoYO+vy98OE7xBwJEPgBAZbz863Ynb9aVoTGHmKCkseqAz5REv+b0WtxiN17zVoUJbLlKT9IYjmarG/htsOuDHtU61PQ95J7Y2l2hOL211nfZOHuYuJhuDtx3e+2foxPZ3Q8Tjy88ITGtjfDz+dERFpHQA2do4ck4kSbb9bMvTOWfDtAL/QF/4TKBiL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(40470700004)(46966006)(426003)(41300700001)(7696005)(26005)(478600001)(6666004)(83380400001)(2616005)(336012)(47076005)(8936002)(186003)(44832011)(16526019)(5660300002)(2906002)(6916009)(40480700001)(1076003)(40460700003)(82310400005)(54906003)(316002)(4326008)(70206006)(70586007)(8676002)(82740400003)(36756003)(81166007)(86362001)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:36:39.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9100506a-1526-4d90-0fe6-08da90ffe74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently introduced change to allocate doorbells only when the first
queue is created or mapped for CPU / GPU access, did not consider
Checkpoint Restore scenario completely. This fix allows the CRIU restore
operation by extedning the doorbell optimization to CRIU restore
scenario.

Fixes: 'commit 15bcfbc55b57 ("drm/amdkfd: Allocate doorbells only when needed")'

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c              | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84da1a9ce37c..c476993e3927 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2153,6 +2153,13 @@ static int criu_restore_devices(struct kfd_process *p,
 			ret = PTR_ERR(pdd);
 			goto exit;
 		}
+
+		if (!pdd->doorbell_index &&
+			kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+			pr_err("Failed to allocate process doorbells\n");
+			ret = -ENOMEM;
+			goto err_alloc_doorbells;
+	}
 	}
 
 	/*
@@ -2161,6 +2168,7 @@ static int criu_restore_devices(struct kfd_process *p,
 	 */
 	*priv_offset += args->num_devices * sizeof(*device_privs);
 
+err_alloc_doorbells:
 exit:
 	kfree(device_buckets);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index b33798f89ef0..7690514c4eb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -157,8 +157,10 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
 
 	/* Calculate physical address of doorbell */
 	address = kfd_get_process_doorbells(pdd);
-	if (!address)
+	if (!address) {
+		pr_err("Failed to  get physical address of process doorbell\n");
 		return -ENOMEM;
+	}
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
 				VM_DONTDUMP | VM_PFNMAP;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6e3e7f54381b..9f05f64c5af8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -857,6 +857,14 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		ret = -EINVAL;
 		goto exit;
 	}
+
+	if (!pdd->doorbell_index &&
+	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+		pr_err("Failed to alloc process doorbells\n");
+		ret = -ENOMEM;
+		goto err_alloc_doorbells;
+	}
+
 	/* data stored in this order: mqd, ctl_stack */
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
@@ -876,6 +884,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	if (q_data->gws)
 		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
 
+err_alloc_doorbells:
 exit:
 	if (ret)
 		pr_err("Failed to restore queue (%d)\n", ret);
-- 
2.17.1

