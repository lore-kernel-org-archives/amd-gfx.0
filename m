Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 03:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B3B20878
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 03:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wtAhILxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B3B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32FF6E10C;
	Fri, 12 Jun 2020 03:35:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0E76E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 03:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMiFHn4UVEqfBlasQLP0orOzXZImn43s31pgA+a35HEWtGxohTq+6cDYSxNQofOXFg26KR6UkCxnYIzBLarNAAXDQha+q5hYPn8fnPmIYVlNzj5CzcC32OtsVyuNpTYFlnarPD5HZ8qvp9htkEWkdsyj8bcXHTeWX9WfrnKWinweKYcuy9cxbSqQB9oZqyVEeOnPgS/+lSbjV7++dw8xYdTLrPWBx3+LdkNCDe7lJWLtDepoXyBQtr7DUQvVSxrO3p6yoiKzDxYKeKUce1JR80Xdx5XvG2wPnBhkIkH68KWnJbu/lw1+hznieB08Fh92C5Fgxt2SMbYP4SQByMraTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1zJgIVjcZVl5tPbr+oAlOqx0F6K9Jwxlw0Edv4NT4=;
 b=Ji/07SNQI0zZ1OdSpRu4uJOWR7IfOI7JZU8RzI12BXv39iJSFbX9ZZty/koim7elTN3MdTmrXExOsFr8+Oc9IfpDxvKJ3FR4ycQASEPe7atKCXBUGLRxlxZIBEEbPSF5MlHLzWH5rc2u1RfG4166Dyn7RT3m0ULDyRLDJL9SjoUT8EJEmOj31WLYEaxUT4BrRuhGGjG/e1FRucK7NAVswUzTKWHoWr4kX9KG2P11eH5PWdvU2nPdSyK03tfxMklQXPmJg4fTv8j6wHWvpNbNEFHTswVMxiT6prDmZqRqgo4PVNgK6TkBjL2UxY37mE8tW95KilVfV3vnc0ztK/KJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1zJgIVjcZVl5tPbr+oAlOqx0F6K9Jwxlw0Edv4NT4=;
 b=wtAhILxZu491Nr5DUOzmEE7JFdgMD3qE8ESkvjrgkw7HkZAvjndqnO9d159CwbNP0wa+qG+/8IuIYexQbi8IxOPS8kMemlF9lvFXzX/FSf8UiFcRm32UfjJtLVyjqQwzkWpi0B0JzLYmiiK1XdfBsYOcxCELnwizjbqFP/9Tz50=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2720.namprd12.prod.outlook.com (2603:10b6:805:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Fri, 12 Jun
 2020 03:34:58 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3088.021; Fri, 12 Jun 2020
 03:34:58 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Add eviction debug messages
Date: Thu, 11 Jun 2020 23:34:22 -0400
Message-Id: <20200612033422.5682-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Fri, 12 Jun 2020 03:34:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95daf9a2-6a74-403a-b262-08d80e8194f5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27209145171EEC58B094B0E992810@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMLb7B/ifZgLUce6mH8Wv27oQtkaAPqD1oe/c/zjLD4RQBIFniNFr2+4pVuFsONzrrPIB901CvMsbJBHyjPyN4Hv4Hs22+E0PFGqG0XTcJUZV4OlLqA+yu1HruPRuW76I8daEPxgpjRk4hu9IP8ghe5aDNy/DPOiX/wru3swEklAiYBTV9e1q0DD/iJgZPB/zvWsfVbQKD636PW+CaVRjvtCPVNeOpK8rkjCWeRTrMKgEVMbEjjKhvC+4wJraNaqcv/Q+Wfl2RhDdMpXh2rdaSFMMLpJnz7cpp23ZEPE0gIcAzUr9xLzVtd42SJeBGDxABXQWL0bXmPeIWKYxshs1FHpEdI/crqlewC8+1FbOuvBfFYIwhHDi6G2+jjVpf1z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(8936002)(6486002)(6506007)(5660300002)(83380400001)(16526019)(478600001)(6916009)(69590400007)(1076003)(956004)(2906002)(2616005)(186003)(6666004)(36756003)(316002)(4326008)(15650500001)(66946007)(6512007)(66476007)(86362001)(26005)(8676002)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1zdGf8OJfVY9mviwTGQbZ8jAO3uw3YMolbRe2iM9hgmEVbCTveRiJiK8rjjtmIo9GNQ2mSsudLhWqpulJC5vVcWNMrwY80tsXiQMvDT5r3DnrJcxnnLQQM79uyzfvIogq+fXH5mqJKNumJNSja6ZYUtykjPrEl0tlEY8evMLSO63dPllULptbo8mzps23skBF34A5+glO5WxWWX5uBLSArKzzhp+bKIkrfMPNjIpnlNue8mTRkEnpQEWKj+2vOh2Xr1QymCzJEtMkF73fxFQgJ61vLhw/ynvjUePj9bWZ/7sqiqL7SCQgQs/3WXf3Mxq13u7JKkQOPDtENlOAX2+X2HLjtuaiwaEmuEosdzxG3G5yOAwEnlzSjYwsLb5oOVb1gg/yA/HfZ86vRo0J3ENMgKPJaIgqDsnWwtrT358aydmeeL4GewxLO3Si5CvJP3yJyRBDhPHfvKq3HO/oxc3rPS11G/NAwM6DQJX4cush9ZtoqBs2il1NVIUWzVLZpMl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95daf9a2-6a74-403a-b262-08d80e8194f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 03:34:58.8103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py0k2eOxofYfXv8x9xzwwj7xWdonEGn7Me0CPlefP2RhpZglNVjJUskvFj7ODs/TbdSvPT/yqJVPTSoZJf2fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
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
Cc: gang.ba@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use WARN to print messages with backtrace when evictions are triggered.
This can help determine the root cause of evictions and help spot driver
bugs triggering evictions unintentionally, or help with performance tuning
by avoiding conditions that cause evictions in a specific workload.

The messages are controlled by a new module parameter that can be changed
at runtime:

  echo Y > /sys/module/amdgpu/parameters/debug_evictions
  echo N > /sys/module/amdgpu/parameters/debug_evictions

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 5 +++++
 5 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 10ae92e835f6..6c7dd0a707c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -186,8 +186,10 @@ extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
+extern bool debug_evictions;
 #else
 static const int sched_policy = KFD_SCHED_POLICY_HWS;
+static const bool debug_evictions; /* = false */
 #endif
 
 extern int amdgpu_tmz;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d4d7cca1cc72..fdf350d5e7b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -705,6 +705,14 @@ MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false =
 int queue_preemption_timeout_ms = 9000;
 module_param(queue_preemption_timeout_ms, int, 0644);
 MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1 = Minimum, 9000 = default)");
+
+/**
+ * DOC: debug_evictions(bool)
+ * Enable extra debug messages to help determine the cause of evictions
+ */
+bool debug_evictions;
+module_param(debug_evictions, bool, 0644);
+MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
 #endif
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index b87ca171986a..072f0e1185a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -275,6 +275,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 			continue;
 		}
 
+		WARN(debug_evictions && fence_owner == AMDGPU_FENCE_OWNER_KFD,
+		     "Adding eviction fence to sync obj");
 		r = amdgpu_sync_fence(sync, f, false);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 22348cebaf36..80393e0583bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -942,6 +942,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 	if (!p)
 		return -ESRCH;
 
+	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 	r = kfd_process_evict_queues(p);
 
 	kfd_unref_process(p);
@@ -1009,6 +1010,8 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 	/* During process initialization eviction_work.dwork is initialized
 	 * to kfd_evict_bo_worker
 	 */
+	WARN(debug_evictions, "Scheduling eviction of pid %d in %ld jiffies",
+	     p->lead_thread->pid, delay_jiffies);
 	schedule_delayed_work(&p->eviction_work, delay_jiffies);
 out:
 	kfd_unref_process(p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 173d58b2d81f..51ba2020732e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -177,6 +177,11 @@ extern bool hws_gws_support;
  */
 extern int queue_preemption_timeout_ms;
 
+/*
+ * Enable eviction debug messages
+ */
+extern bool debug_evictions;
+
 enum cache_policy {
 	cache_policy_coherent,
 	cache_policy_noncoherent
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
