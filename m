Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D94C7EE2E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B10A10E5F8;
	Thu,  8 Jun 2023 17:07:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3611B10E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvtRBsU64XhaBdzGaN86HFSfm5zXnVLmv9CpP0yQl/Mb1B1o1OJAiw9dEyso54qRIauH551dVomdCYvnip9zDbeMlQCFrg2Bk8aC+FSoHdTLoqSjNXzbYfQwQtysbZ5+/uDoMvpyxy4ZoHGr1PLqasa6qJPf6VhfJsXQ+uiGLIALIYKuqtunkdmMShlGLPQyDQBHAiD8CDdNPnkf5OXg2aWmwUacNhyVIlJ28atRS/YnvuOkVwn1QHC5bdJbNnHvUNcth3zT16Mmv9nUIUj83j0M9MZ8/Mo40j3l5kBDQ4FGCcpwlClyjz6atciwQ7CzqQiHnEbknC8/6CEKr1a0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=iBFbqmkG1ZvBm0OvfaUhrhSs5zWl3L5aa83QEYCZrjVxW4mdMJN8dxni4Qakf2r7824A/XvByyyOqbZg0CvYweXcLvtATzifXxqHnV4m+L/eSr+9M7XagD+0H5oPATiB9hYC3QFErml8fZxOvR47sXZOgL/fnBwYuHuU9ornLlY4kXmywODk9L1VzkCUC7L2gn+wYEh/whv+pe9lptLr5p5jYTzydCVBThyx5LmBO7anQCllusn/Ih2dvrOxGcoqZHPnuvVzVZMp6PYSETiO3u1GE0Fl4j/Mm7mx4Zoj5ht14ALeX9whdqFkSszKBJiaKKbGaAmrraIu35nxZgV9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=dhQ8P0KMPc2KqDVSVIgTdLvfulIGZ7a3QDT2zDT5+FHWHoNusQoJcHYzcLiirsw+98IJ6M5ej173DzlvmWfHc78OIyhjeMEBuu8BaK9Z0lI9j4eHw3pfdi7/eMc6WD2RzzM/xuNRMFky8LzkGi9fFeUncYaMs7QFcRvQHKJgspA=
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 8 Jun
 2023 17:07:39 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::17) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:38 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:33 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/5] drm/amdkfd: add event_age tracking when receiving
 interrupt
Date: Thu, 8 Jun 2023 13:07:02 -0400
Message-ID: <20230608170705.2271276-3-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f041be2c-d9d7-4bb9-d3af-08db6842dcd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItJXnH4hkiw5GDYU02/caZVgCu/I6ELKdKIladec3WOh8kI5+2elUCCjugTxO6+SisxUC2F4mdw/0TR2V0SjwCmFck1UYKo02I3KmE3J5QHPvzj4zAXhoBz6yBnx2jYA2fu/nm1L5ZdVjFr2pVlzLGYtG8Q5w4BC88oVdvWDOxQmQEdKjTGhnUjOLjVCAXMErYrGQoB7t6R9dSbjGF41TMabKBSuL/39Y2pRmM6qVQcxRkbhvST4B55jnhQTgxUf5g3dSG5+6HDfk9nUChKQgHghWTcoZt6Yeyg36noInTkxs2+1g955eUpV6NC4iCupJ/O5ovCikIdlFM24In7f2H//x6viOphIRzCMSgzNc0atqvPF120UOv3VQOqR1//rtl7JPVHpDIaq00d47bh4PY3cIWUl94jEuH+Ua2g7z+VGvMojZN6ZXT4z5fiD7cPXdN9FVbu02kT5Y7Yompfx30Je8nzX1E+6GXcvtSWM3S5gJLpFkLBeGlg2BcEAVhWjYBd9eY6Or+ts8MntomgUx7J8pIEooDyYATQHiNYZjiUTBRL+mzDpZMNNbvw2JYwnXN71j7FfQoyHCnPZjnNg6fJW/4kkqSwO7bGgoU96qfjRCkiOV3RcG4I+0oP00YPnRsf09U7ff2QZCLZkEnF0AmYn0cO8eW+Gmde7yrxCOB7oCEqWh3NK4lPuoKvB6hnscW5flyk3rrFcUXoq32dYqR8YGNnzL67XYPCVAMSUlMAEg8tDpI9wmEYH0fjHwuso3dHR1Q/gpc2hSFUE+mEZMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(83380400001)(54906003)(82310400005)(426003)(336012)(70206006)(70586007)(2616005)(4326008)(40480700001)(36756003)(82740400003)(81166007)(356005)(6916009)(47076005)(36860700001)(316002)(478600001)(86362001)(1076003)(26005)(8936002)(41300700001)(6666004)(8676002)(2906002)(7696005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:38.3560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f041be2c-d9d7-4bb9-d3af-08db6842dcd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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

Add event_age tracking when receiving interrupt.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 7ff5c4e1b7e2..c7689181cc22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -431,6 +431,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	if (!ret) {
 		*event_id = ev->event_id;
 		*event_trigger_data = ev->event_id;
+		ev->event_age = 1;
 	} else {
 		kfree(ev);
 	}
@@ -629,6 +630,11 @@ static void set_event(struct kfd_event *ev)
 	 * updating the wait queues in kfd_wait_on_events.
 	 */
 	ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
+	if (!(++ev->event_age)) {
+		/* Never wrap back to reserved/default event age 0/1 */
+		ev->event_age = 2;
+		WARN_ONCE(1, "event_age wrap back!");
+	}
 
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
 		WRITE_ONCE(waiter->activated, true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 1c62c8dd6460..52ccfd397c2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -53,6 +53,7 @@ struct signal_page;
 
 struct kfd_event {
 	u32 event_id;
+	u64 event_age;
 
 	bool signaled;
 	bool auto_reset;
-- 
2.34.1

