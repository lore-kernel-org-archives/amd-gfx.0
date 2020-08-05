Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E94C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 00:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBF12073E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 00:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aOuYjSEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBF12073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A64B89B84;
	Wed,  5 Aug 2020 00:44:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F1C89B84
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 00:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfeBGzEn06yPbOZ8OmAdUwgAt21rvZLKstmw+X7SjWZiGGT0ZpVYS7zB7VAIcFDa86R4V3jifV8roTqIkUrXiKmEb7dd1ntfGvAApcVuXrXk5a8H+WSUwBb9Y0UgezcBh2ZrvEpBeHUImmBMOkwoXUPcl/BuLtIdw8dRTbEheQB1PdsW91nGxCz/CFS/0Yp4PomuRK0El5vh7LjS4v5pe9scvYWlgd3zqBLl4E0xaqpLAM8dBFneVABHxA9ykBl+bMBLu8hK3797KoYleoGvc25giIko+slkG5y6h/J+3x2sF2i7rhxyAXZpVuyalyIh3aF6grQcaTMZCQF3Lmfi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOi/HaX86JSnNZjnMpsgcf1ilrFIosBiEYNvYEsg9GM=;
 b=ACfaOkrgJrgHPTZRwhmcaCNdUtoX0bAoOg8u500NZiNFuLIL+gE+B+GAHeDIks01B9t9kgdfd3k9b9mapqHF8JBsMlBGLvEMGgfdQOjdpGxH5/SlDKcrRpW1UbA0SigEMdWJaimzvwFvKRY5O4aO0c7rvs8w7K1j87b9n4A5wHDcP1nFALS8f4HFpasujz98fDkDr05ixBXyv2H7yVm6PvMULBWi4zuYtBnqSSzBHpHexvCS7Pb4ZNe4tpuxu/SoEZ34aN0AjT3xEVpVVv6liBRgPrtRpzgp+XfwphbPyldtgLrBKugwEP3uEAKqvadRurwG3vVKwQZjXD+Lna/C/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOi/HaX86JSnNZjnMpsgcf1ilrFIosBiEYNvYEsg9GM=;
 b=aOuYjSEHPRaW3kP/zEjIIXWyMeoZ1s/bNkDaNHJFW3l+0g/0zghEyH+lqcZCQxJjlQyhYWGpexok7j3VAu+1VfPTnW7oYXt9aJpRe5HmtC5zNXYaf67c2EcHzrv4vnjmW3UtFDQgzVMVm+kCem8l9PHuFMst1bgfOD5lDAYiMfw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Wed, 5 Aug 2020 00:43:51 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 00:43:51 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: option to disable system mem limit
Date: Tue,  4 Aug 2020 20:43:38 -0400
Message-Id: <20200805004338.18090-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Wed, 5 Aug 2020 00:43:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: def5240c-b0a2-49f3-5f3e-08d838d89fae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11466D21D572B8F844081F64E64B0@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/e4nNZa6h3Q4Dqo/k4B9So+Za+yF3smvRTKRmNC6r1jBeJ+XnSmsX3zPhUIMGGFKq+F5LT2/dpVW0HyKx8KMXum3dCi70qXZuO7WU1TSlkui2V9TlHFGjBIfWuXwPPVDxwR+UZApK//zXaHvXw9tztFSn0WExr4LXQ/kr5t//V3NDYaqJIjN0apS/Bmhl4YCmq8cVD3LflFBA9umUru42df9z9SWh6GfXWNKdOQU96DByRWwOcDz5C0iOOq4B4EEGMY2V6blHTGQERdmx0A3MRm9jIQxTYnnmcyuGePIm+0YDr6nS8yHZqkmCG8rV5Y64o7Sg9hVjjJ6S9gSdadxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(478600001)(316002)(52116002)(5660300002)(83380400001)(86362001)(6916009)(36756003)(7696005)(26005)(2616005)(6486002)(956004)(6666004)(8676002)(8936002)(2906002)(186003)(16526019)(4326008)(1076003)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nAo1Ic235gssugZ3GgPY7BkEPdeaqg35feKjKJGmArzYTf5uAe3wr8wopnIrBgtMigQucUfiCmB/v+hzOrVgH/sbRv7vZVrgy/mdDoEGXULEhQR+IYGqZoozonpBmQzSJ5Ptd+GPoH/bmLeOMz8Y4OVeAlU3/AuLQqfG0ALWdhfc6GaBBFQMoiYm62+jrQm/UIxWPrBygCKUMWMti9Mr5XEZNSR9Vi+ZnHhNWXluh8cMCZfDEuYHOWU7dtMkWSY+j45+fYjrjMZKJIbhscJeUcC5ZFBk0cTQMme4w6je+EDFJZBiesk+8rSc4GRHE3LZlbsHJnwQIRPaCw+ZruhAdqa8rAHZHyykPIiD8gv1RysK/shdhP9EbJ9bUVvKo3hlMKR9lgUYHEiz2lhdrEgPjGj61Kk2wbeKZEXkXpzvpJ2pyV6HkjQ/u0tPErsMHp/+KJ3V//RCx+csyRHd9Zuo+dv6vq5gGebI/qK1WWlcb35kaBO5pA1rE2Sn4138fGzPiwzv8BcuNy+1j13LTIqZOL0m0GuEywnsnDj7NrBIpOxUc/JsXm1Zv3pDTD2hRNmHGWO24mPYUGWcjEZpfZpQ7vQXJBX2gfi3fV1MaGGi/N+g9xupG7Q6H7yxdYvAbY04KdKguHBR/OVAyabKASW/8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def5240c-b0a2-49f3-5f3e-08d838d89fae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 00:43:51.8809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGGMxFHRKD+yqztF+6TDn5v5e7SVEhK7GHESusfTAA0yBOpVi8Vx+sn1AdpSbW2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
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
memory should not fail if it reaches the system memory limit because
one copy of physical system memory are shared by multiple process.

Add module parameter no_system_mem_limit to provide user option to
disable system memory limit check at runtime using sysfs or during
driver module init using kernel boot argument. By default the system
memory limit is on.

Print out debug message to warn user if KFD allocate memory failed
because system memory reaches limit.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e8622854e61..0459e53f5917 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -188,9 +188,11 @@ extern int amdgpu_force_asic_type;
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
index 8703aa1fe4a5..0d75726bd228 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -148,8 +148,12 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
+	if (kfd_mem_limit.system_mem_used + system_mem_needed >
+	    kfd_mem_limit.max_system_mem_limit)
+		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
+
 	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
-	     kfd_mem_limit.max_system_mem_limit) ||
+	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev->kfd.vram_used + vram_needed >
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a252450734f6..d3bd7a7da174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -717,6 +717,15 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
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
