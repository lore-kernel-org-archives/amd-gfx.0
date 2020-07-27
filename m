Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFEC433EC
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53D52070A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yL1NUAiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53D52070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCAD89C82;
	Mon, 27 Jul 2020 13:25:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1034289C82
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 13:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeiJMO3zcpSLlz7dXwm7w8bTJb9yIXcZ1QQMUiiTLJwaK/rdE9Vl2pZjshphUowyEN7Kz5Sm1XdXBHJvGLu0K+KZAARIoxJYk/bkawzLzDhJHi05+zIoJa6HOpt2FTp4f9REoVQI/N9bZVuvXpL+WyTPaAjMbolbsDhnxYKOd3myrHNTbQTkYyFLQITz2lR9EeGN5vbowlFilQ6EON/AbomeHXCvziaGmKlVP+smwa6M3AtdenO8qUXn88mvnnS9UOm3ac4POprquYqVpbnwT1nNIPSf7iqMWzTJub1/ynOtYi9kwA+ADWoePxn+rGc/Wui61GR9rX/59DNKhVl73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xoa0vaAhN2U+aOF7bJx9L+up6EA4792ld9V4hlLqtME=;
 b=FmOxuLYQk+x2E+6R7rW5Hfae607h1aDVjpehALar6rOzMXdJMD0tINOlpfnkzMWBZPMy9aWtLWIw2YKSS9dnLUaVejadyw1wHzDFbYlBqnEsBzaQRtxJh7dH8WwXnigvz6RI5gFHndsfU1PTfVFd4+jruymVuwZd9/g/PMrOw9mqnYD4PFEjy1rCHYf9ewUJpdmVYJWCvK23//acGsMU/6g4/+rAB6Myz9z+2biCXhXZekDx0oDIcUU7BHdoKXjGzWFcTZ7iQ+YNDvR3GLNzRWhNCmn6q2Gl59wF1fITPVoaZoIUws8UUMoiDLgacd0s2XLo6O1cKXUM2gOolsWNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xoa0vaAhN2U+aOF7bJx9L+up6EA4792ld9V4hlLqtME=;
 b=yL1NUAiETmw9l3LCuZzPWnF/O5rAkWbX3CqWUF6LChpKoua+LXFsff4+vNEk6zWOqb3LUDdFbqOd5099FfKneGtQIqtBHlGeruKGbRFN666LRrbb41GpxTt4w6ADs/skNQvdfi4zMhJFzuUuWwQtXFfBYk2NHySgrAWYknaaswg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Mon, 27 Jul 2020 13:25:14 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 13:25:14 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: option to disable system mem limit
Date: Mon, 27 Jul 2020 09:24:55 -0400
Message-Id: <20200727132455.26657-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 13:25:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c9e4906-ae3b-40e4-bfdb-08d832307eea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1339E3446E77FFDA6EC1F381E6720@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXbk4jJ6CUf4qYTI5SYJfoGPT/oxI4TXxoOR8QZlHCXfm3j/ULf5eWKogn1c9cm4mZtlIop/BXsJWiv0CEL9c5218p1IoqawulCo6cZpNHOULmZ/tLxGLgLEqkmtdlU0Zf98tz8gFY5c9GqTwqO/eAVK7IQlU8V3Rxwu43x2INmpgDiCvjX8RWldL8zF7Mt0PXtfop2IaBUHSqgSLirhjqzYf3bGRpF/TY8aqbVKKvtQ5Odhs0fT+KEIJCF4vt43Xu3acLFS2B/UD0qq8DzNJS85tVz+hqxkiGGENr7GW6Jy0NXrjm3C3OPgLeWjjAV1lwzf41ymJXV2a4DD9HE0qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(6666004)(1076003)(5660300002)(7696005)(16526019)(956004)(2616005)(186003)(26005)(36756003)(52116002)(66556008)(66476007)(86362001)(478600001)(66946007)(8936002)(316002)(8676002)(6486002)(2906002)(4326008)(6916009)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yijG0ipPOPKsK04gg/is9M00JkEvQ8D1rdp693FB7rrXUIsOA6ZxittBMUwXpjoE6AumvJMDXrt8Lg1osOCGIKWybE8A6GU1gAGmkBQcXYmzW3cIhVbSmDOEu4d4cth8Vjrxowz2RQt9KzduAAm3/gtwxD1yDmAEh+y7ZWdGEaBR41XVnb7pE5w20Y9QxJ6sfCzL6F4+92sjNCzVkMCBcJ52b9THEIDiFRUcncdeskJPUpWDgmeOHpVrKJkh+HaJYfjLM6eIj7YMBdhXpfCibZ3ByQxfM2lz5cz5j2gohoV7/t3RwFpGLrWIqccw1CeKBy405MMCUVry7FpY+Pm29bxmNt5ylOnB8rhoScduOfTlb0E59GqgDpTOzKbeY0sw5mJsOlb3Almp9XcJqJqLfgyFA/P+8gnY8ssC/8Tux9oNPLtfjiOKykDHc9cccf/RoUbZbdLdej1KQNq1FMz/+rxtXI0WG5NLCccZ6JvM+wADJlaBbHBfPyJIdVj0ZiCe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e4906-ae3b-40e4-bfdb-08d832307eea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 13:25:14.3377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3rsT67uTKC5QTP9Nuc7jUkOAxvw1nQ9N98KGwc8KZJHM+jJ2HYs9BC69GiKMTr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If multiple process share system memory through /dev/shm, KFD allocate
memory should not fail if it reachs the system memory limit because
one copy of physical system memory are shared by multiple process.

Add module parameter to provide user option to disable system memory
limit check, to run multiple process share memory application. By
default the system memory limit is on.

Print out debug message to warn user if KFD allocate memory failed
because of system memory limit.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 9 +++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e97c088d03b3..3c0d5ecfe0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -187,9 +187,11 @@ extern int amdgpu_force_asic_type;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
+extern bool no_system_mem_limit;
 #else
 static const int sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool debug_evictions; /* = false */
+static const bool no_system_mem_limit;
 #endif
 
 extern int amdgpu_tmz;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8703aa1fe4a5..502e8204c012 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -99,7 +99,10 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
+	if (no_system_mem_limit)
+		kfd_mem_limit.max_system_mem_limit = U64_MAX;
+	else
+		kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
 	kfd_mem_limit.max_ttm_mem_limit = (mem >> 1) - (mem >> 3);
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
@@ -148,6 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
+	if (kfd_mem_limit.system_mem_used + system_mem_needed >
+	    kfd_mem_limit.max_system_mem_limit)
+		pr_debug("Set no_system_mem_limit if using shared memory\n");
+
 	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
 	     kfd_mem_limit.max_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6291f5f0d223..e9acd0a9f327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -715,6 +715,15 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
 bool debug_evictions;
 module_param(debug_evictions, bool, 0644);
 MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
+
+/**
+ * DOC: no_system_mem_limit(bool)
+ * Disable system memory limit, to support multiple process shared memory
+ */
+bool no_system_mem_limit;
+module_param(no_system_mem_limit, bool, 0644);
+MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = default)");
+
 #endif
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
