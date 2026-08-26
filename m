Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6102C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 20:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BA510E2DC;
	Wed, 26 Aug 2026 20:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHQF6GOT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7CB10E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 20:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE3Qypb+Ko6KMHzLKbf6yHgJfxVcWb7LN00b8qOFSvLe2LR3DHSZDurDrcpQvga11YTfVoWPVgXilphwuSw2jOKHsyhTSO+toOV2FF/kEiSt6OeiBTUy37M6JDBHkki+o5GpddObDG+Dol0E9ZmYikjwvDYflfwLnBY6IiO1Cw4sUTJm4/s50Pi+kdIWswjmf82ewxT6Vm/dE+3dGQExQiaJq09Hg100/AK7QWewDk5N0BBYcfGm/1PzigvCMoVhdwS3BM48gQoRQZXwNoN2NriBbGy7s4tGfrfx/uB7q18oINqigsTVR1PF/f+lhGkMXVRCNHGJxUfEqES3Sf3Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGBDirqky/laP6tgbuXPFfAhjBusP59RlewGaLDnP+4=;
 b=WTUYWn4aYOtp+GJaLqfRHh2q5f0LHUNOZSf62KHCy28umAW9emOaXtco50IGg5hJrdt5DMeXYmCmEDhoBuU27yM/+7XBIB4LL/6bAuigFaCC6aTOmfR4w0DK5eJGgZxePPY7Cn8qxOeZ5PuShk8nI1+znKgTU7ytZa5hU+R38ivTOFztC4k7qVGgDXfOvddzMjxj4cViyKgjOk2J3LKqnHKCNCRJdXmYN3PM3tRIHcNNKDf1TmxnoHFbSAdSiRgUTZTGDkSHkTG/UnIG2gPJak89JiLnlI7Rt/NEEO9f+G+xf/N5W8n4L+A1ClgH+zT1XvofuWPqPQn6D2eHOVmCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGBDirqky/laP6tgbuXPFfAhjBusP59RlewGaLDnP+4=;
 b=fHQF6GOT72SX2TJgNELWewIdUmQH6Gt4DrQn72nhGxmOKBP+Y6BT1+WCS76gkZWOYmBX/2YVYXN7AL65w+9mgC9AStSF/LSZJy3HLgK5PXq1IuEUrwVx1/L1w4P05YWwPrLu23WsJLxkdgWKARBTqWk0Fd9MMuxs5NunwaMddV4=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 20:28:25 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ab) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 20:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Wed, 26 Aug 2026 20:28:24 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 15:28:21 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, <mario.limonciello@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: correct oversubscription timer inverval for
 gfx11
Date: Wed, 26 Aug 2026 16:27:48 -0400
Message-ID: <20260826202748.316188-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c857b1-cc87-455d-3006-08df03b0948e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ppMPNuLJ2z2Ej3nIlvn/CtaVU4YdlkIyhbNZi/mGsGovcpd+lyPxhfUqGYN4cl0b9MsTGU/w6SXdg+7ah2JcOHXmYHW/BSKkDPRS5w/b8khEBHdQNoB3mF2bvDH2GlzjJh1Y54LxF4doEv5CpuS45hNYf1LPeSadnPVMqBzBXGxwu75Bb7/UkVIlKCJJozLDn/5ijUea5qDNJNu6NzD6VFUHzBf1k3VKBJEw83twKxGC1CF/1gHgqhS5D+a1x3Hoknnd6hdu94xX6X0PvVQA2EGEeHCZtMnphNzystxpjdxeQBswNZei5T8cRqYeN0Tsl53FD9YE17xWfiTLzbWoN+cdMThbUXU20NR42XChYhDePsTU/HfhiGSQh/sUuWBFOi0Jb0/+WK1sXgYQ9jKwmw7wDSdbtclUKohHxGoWqic8pHPC1xHvu9lVXGxPSvytfWcbCX2Tkx8rb5wp9ChKyP/HIVRcIePv8fPF/I17eF2u1oe4UlgscMjo38oxLfIrsvmzXekVp48YviKIItDayov8+tusrdw+nqQL0oUEq4RUhNE6VB2SqnMX1epUUvcxpivnN0BbpEpAI/rc2Wy5Kizow/fAOAyUyNLWAudwTywd1NrZf6nVbsjLUoSjmw1SWP4S9c+mKlaYh/2vNWqhB1san5ASnfUFRzxaYrltisfk5z47+rhtfp9tEaUBBPjceie+P8bgRDMOnZdXomahKQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +id0baaqeieBEBSLDamSNHw674o9ku0j+7+EbszD81hTUZW9GYkjHHQLEclugwcPRqkp5WdPb0I9imdxW8ux5E5eMvopO/GiO0GVedydPUknGYHmOFDUROK0TN3RbVOgz/bGMYxV3JLIfOA7Q4ES6ss7EV3SQ6BxykD2MpOwyBbNnoo5QJ28rsUJExOFFkz08cXu3IfZow4AZNQPKlMLJgL0GCQsubwSBEYZLKSlymbh39N1s5EQ2TR032RmA6y4raSKTmrdX7aJRkZEUnbCS5Ax41hhkEKGuIPOU6hOZ2fqSzAGuk2cWTJobOLVvu9Vo8ikDSFzRSYuAgBxl/85RwDUOxAdNLxOy/eibJdf0LxDtjzZ9I0hTJ7Gs64hNmTdHKhTi7wo9vvSVFfA16qhcDfsqKqYpDKiu8AMIGApodSTn+nqC1iDYb/mF1XqTw9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 20:28:24.9967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c857b1-cc87-455d-3006-08df03b0948e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

oversubscription_timer in MES is in micro second, so change the
timer's interval in KFD/useq to micro second.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e0e38d6bcafc..5cf1bb1c2085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1171,7 +1171,7 @@ int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
 }
 
 /* Interval for notifying MES of work on unmapped queues during oversubscription */
-#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS 50
+#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US 50
 
 static unsigned int amdgpu_mes_userq_hw_queue_num(struct amdgpu_device *adev)
 {
@@ -1198,7 +1198,7 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 	if (atomic_read(&mes->userq_hw_queue_count) >
 	    amdgpu_mes_userq_hw_queue_num(adev))
 		queue_delayed_work(system_wq, &mes->userq_notify_unmap_work,
-				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
+				   usecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US));
 }
 
 /*
@@ -1215,7 +1215,7 @@ void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
 	if (atomic_inc_return(&adev->mes.userq_hw_queue_count) >
 	    amdgpu_mes_userq_hw_queue_num(adev))
 		queue_delayed_work(system_wq, &adev->mes.userq_notify_unmap_work,
-				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
+				   usecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_US));
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 69cd4441e240..b37aed34a72c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -48,7 +48,7 @@
 #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
 /* Interval for notifying MES of work on unmapped queues during oversubscription */
-#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
+#define DQM_MES_UNMAP_NOTIFY_DELAY_US 50
 
 static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
 				  u32 pasid, unsigned int vmid);
@@ -287,7 +287,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
 	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
 		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
-				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+				   usecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_US));
 
 	return r;
 }
@@ -3275,7 +3275,7 @@ static void mes_notify_unmap_work_handler(struct work_struct *work)
 	/* Re-arm if still oversubscribed */
 	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
 		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
-				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+				   usecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_US));
 }
 
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
-- 
2.43.0

