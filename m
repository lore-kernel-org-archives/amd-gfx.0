Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F125ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDF110F337;
	Mon, 29 Aug 2022 14:32:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD6E10F2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp3zRz8lz+iBf5svQLh6vnTk+eNU+XE9/ykgO05v6OgDQ0YH9AON4/0JHYmrKLRkK8tO6nQc3g33ZkmwG7/+xb+T5LfRZrWltsH8jXBadhnlPNzwOttvJSq+gJcUEQS8m7FMwCCWzDFKl4IKlK1jbrKLcOXUuUvGgBZoutbcPH5q0qEEcai06cQvbIJRYERpc+eJUyj7MN4eQEI+x+NK8qTKzBnPZCgD6dlO17/6fhKhrI8t6lDtgTRm/sNn9WdY97h7zCL35dHY/T8seMsi2cWNQM3F1+BoQeTb7c7uRm3V0t6hooirT/I2gZIBMv+3UHevm5oZa7hfKz0/7byFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebTLgpH0PCwUE8gFMQyoEiwR449NImMozi+Jhl7tBtg=;
 b=mt1ppjCGNIldms0QzUo85Ll2Dp5DM6Ojyz22GvQh04qQVibmsm5yOPmbAGQqNM48kYRTUB444f/s+4pYqEecnKwl7Opd17XGFQMaM5j8/JAp//0xCk/V38QVAxnMRlTPMrwfg/pyCCouJafxxppvkBlgYolbyOSKg9N3Z7ELbGnNPmt9aiaCHoA+fC5asCCET0VACw5kQ5zqs6tssBNfeSE+V11phVeSR3iVGffRF1JxqMofpCUH+6lnwFKH/SVWFyaWHbrt23ivCo7iWBqXtuV2RcJg1gRXKuEYsKhRT3ZMCUQTeDZO273psYUvB3uGTd3QJReS1hiXKak0OUNHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebTLgpH0PCwUE8gFMQyoEiwR449NImMozi+Jhl7tBtg=;
 b=fRSKuWjT0FQY/ztdLdc+MyFJrEtJUJYd56MUHYoQNm+1bgOpYv2X3eKbC23eCfYBB+krYamSTH+aUKwUg6uMjns5bk3YVYrXHnYgVucUhhks2ts9pN84WGczkYLudjIOoKsc9qnyix+w+XkDkXGOKlxTlaCFAEJMK7T56d1NNfQ=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:31:15 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::26) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:14 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:49 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/29] drm/amdkfd: add debug set exceptions enabled operation
Date: Mon, 29 Aug 2022 10:30:16 -0400
Message-ID: <20220829143026.1509027-20-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f33f2b9-ea5a-439d-83af-08da89cb20be
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rsa9Xb4za15ONbzybsQ5I1Nj/ZMgyqxHdSlyRF91VCbiUxmfuGCYLL8Mx1sXzjtOquhxC1adrmdRkdVh68qgcUwC57xRExkzhZOha88N2rwPKvNTBMUqHiZ/jY7SlJwEbBtWj/C9WFi1NBRunG6o9s1pZR59lTh3F+dxc92hEx0HlDLrXKNo7qs6zlJFkMpFa81zygBNd5tUudKznr2/lWNrCMtHJ5SXUbdfVPEUEEBtFtiXlD4hJcoigNERDAXOMVPf+v9Fjnn2Sc8WQdRjprDwBhECONykjp/qeO7U7NVi143OQYQFiYxp2DAXQ7qAr5z0p/QnyX0RqJK3/z0iuR0BQIrDs1MvfRKvHHcbT98s33L7Qg2cTbwFBGXlq8xJ3t1T4q/oGbIuH24QvhDuqHxOFYFjqgYGkiEICWZYOFQmr3Kak+ZsXOMrjRpiTFIeB408/8JuyzlynYED0jJa+CBho/kyIPFJ9ePz+bWPbohrmxHr7N64fscqF/L6UmORkS4OBY4lwdRbQAwFx1Wyh9HQmhqZ5wOQxzSoCa046nKWyH8g0qICwYsljIIAHiSm3/KokuhramKudexLOgn/+ZB5Z5ZKojkFdnUGQ0W+HwIlDNRNmh9WgZ0vf/DyIJGq1Zmgk2KG3t7JNwsHZetprS5I4jrQHtEAXhzrEctRIAQ9uh8oFuOkQOWD6exxXUoNJ2dibZm6my8UZ5CJtjxDXukQuf1dzxg1qDLcRa1uWbtnRDfSne3aykrecMwKiiDnxDrQWzGhQCDNYb5KdfE9Ap6l9DAP2Ry4aiI2LM2w19j6be9HMC7GLVhf+5SX/W9v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(81166007)(36860700001)(40460700003)(5660300002)(8936002)(41300700001)(40480700001)(16526019)(186003)(47076005)(2906002)(336012)(426003)(2616005)(86362001)(1076003)(7696005)(6666004)(44832011)(83380400001)(26005)(82310400005)(36756003)(316002)(478600001)(70586007)(54906003)(6916009)(82740400003)(356005)(4326008)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:14.5194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f33f2b9-ea5a-439d-83af-08da89cb20be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The debugger subscibes to nofication for requested exceptions on attach.
Allow the debugger to change its subsciption later on.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 36 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 166b671d20fb..5ac15a0b1bc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2856,6 +2856,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->send_runtime_event.exception_mask);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
+		kfd_dbg_set_enabled_debug_exception_mask(target,
+				args->set_exceptions_enabled.exception_mask);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
 	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 8d0e6802e2fb..8619a86f1482 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -415,3 +415,39 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 
 	return r;
 }
+
+void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
+					uint64_t exception_set_mask)
+{
+	uint64_t found_mask = 0;
+	struct process_queue_manager *pqm;
+	struct process_queue_node *pqn;
+	static const char write_data = '.';
+	loff_t pos = 0;
+	int i;
+
+	mutex_lock(&target->event_mutex);
+
+	found_mask |= target->exception_status;
+
+	pqm = &target->pqm;
+	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
+		if (!pqn)
+			continue;
+
+		found_mask |= pqn->q->properties.exception_status;
+	}
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		found_mask |= pdd->exception_status;
+	}
+
+	if (exception_set_mask & found_mask)
+		kernel_write(target->dbg_ev_file, &write_data, 1, &pos);
+
+	target->exception_enable_mask = exception_set_mask;
+
+	mutex_unlock(&target->event_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 5270d5749828..837e09491a76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -58,6 +58,8 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 
 void debug_event_write_work_handler(struct work_struct *work);
 
+void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
+					uint64_t exception_set_mask);
 /*
  * If GFX off is enabled, chips that do not support RLC restore for the debug
  * registers will disable GFX off temporarily for the entire debug session.
-- 
2.25.1

