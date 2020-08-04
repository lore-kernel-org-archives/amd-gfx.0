Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3724FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C494520842
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hNfi74RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFAC6E4B6;
	Tue,  4 Aug 2020 20:42:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A0C6E4B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 20:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4qYzanEXX3ge2jQNcaJs0p1qlUjFOsHX2XNtQbz/Kr2nSdpSnsn+QQRYA5wGBa2+VXXTINMYFFKP3k0LJVOx5oaSJDVFE8MsM0czVtAnn5r3ZgRrpoaxHfdG4W9CkEVssUQEJocyel3LaHRETR+GkMhMZEGojXAjoMj9F02nC7QGyLk2FDOgeDsVqqSik4o84P4NUga1YNOLSEdMISRyNXdMsU1Dzd+ijNNS0Wa5Id9jYJc7tmK0hVSKbBB7IrLeSMcdadbZq2q3P2Emg8XMmMnh+M0IvxZc5taz01N9Paby+FEBCMIsGeQAgKq6FzO7e/nREoOZoVl2IiY0jbMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsZDTfhWn/Fj2WfYJ35HuxL/8839IjEY3P6S98K13ck=;
 b=OL8rHL1o+dAt6pA+SRdzZyGsKbLhyXcgBNaUVJgj299QH3okNAyGsbh6IammNXHflJCYYzBpqlIoZGVQ+wnnBmnxAELVIlrqevc4C9go0++bdsqpXPYIpOFHcHwodNXJ4K2hSSdTEnbWuJnTFN+z7qsbBqnzahjvyL/fNsj1k6fbipDuE5oenC2rzOSmM5h3xxvNXC2fhaiQJ1ZsA4gJLqg9e9MSgrFF0XYlTwm4+UXsFSNx/djIiKFGhZrUOXiu0g5PCQkCfCfTeeqKbS+z+oTKH4AS8NRshdNoJna7/MFvi6Kkb48e9QIT+f02r7F0LftpgHPJMMat/92KbqAzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsZDTfhWn/Fj2WfYJ35HuxL/8839IjEY3P6S98K13ck=;
 b=hNfi74RGkwvVzU/4qPti8GKBMXSUik6srZxteTFgsQAcY1H3uhKiW6CdB4ePJzv5amRFmHoAzu8PDS/lR09l0Cum8FliNWqhqrqC0jyoLsdAycg0bChijUvQqcy4U9/bHNmP48AIQNM+pCyjKw7WhAz2nJSM4i/poQCg41ZDAig=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Tue, 4 Aug 2020 20:42:50 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 20:42:50 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: option to disable system mem limit
Date: Tue,  4 Aug 2020 16:42:37 -0400
Message-Id: <20200804204237.26231-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Tue, 4 Aug 2020 20:42:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f6c9c5b-10cc-4df0-7642-08d838b6f415
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833FF79F7F3DB34FFCAE3C9E64A0@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x56qlQCNc+Ki7VEJfspIWPiIrKOeiuF7DT+tcpXI0gCLEorlDNQubLJSiVI6uIapCFlv2ob0gLOdaLch9CqKRHEzNVDO1pHNdcvmWakJNIZsVzWZgnRVYk8P5QOIJm/AqVu3lnSaG2UDZcCBWS8W2jqSL3K232CmCTF55xu4OhpeHp3h8s0KuIV0YFJLa8DW2EdJ6TF5m3zjhG5AYIVvSKZKUwLMBU9HS1fX+zTfwHIWeuAcwBUNZpaaE5I95FOo4eevc/NNRipCbrey6wgelE7tbNbnVNIeipVFeL5ZifM0zAKg6Q9d3NDWgbbfgoHMxqef5gFJPlrShn3G9azwdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(2906002)(1076003)(7696005)(66476007)(66556008)(66946007)(36756003)(52116002)(8676002)(6666004)(6486002)(26005)(16526019)(83380400001)(186003)(8936002)(2616005)(956004)(86362001)(478600001)(316002)(5660300002)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O/Km5y+R1mvnJ2uFm7dcGaFT+zf0kG3/LRLbrPbxwlzy5q9ztfI7+zEy4zUJQGM+wcgXfqLKyhkI+6cuUuAeHVmCoAQweRvCmQRUtcjd4uCinwbh3RvOT3wMoDZzbtG4rMGDklevzuOiofR62IhOL1K3Ojlzs+ssUmESRWuqPHy54D6Y5fOz23ffJ8kkHtUQGU0589pNHdnGQIoBwO4skBn0I+byfHpGdPVzcrGiQbiyDw9Yi8MNHpAcV3BbJ263NHT6jpfQn81CJIBQc8c33wCudXqH/1S1FOPKXsDHpYQzB9ilrNt2V1O6F4TBuMt2k6nDOI1eiKDE8MUn4goG4z1HMQXUHWt8n4XhOWeUgfZ8YA8BmorvG7WqqIdLMmk8k/TE5Kelkgid3U3Dg5AsWqMAM989IceXwAyOq0pWmad800XCnctpnDUCa7GEN0BiIXvnbh0p+O5c8FYUFAHBssoN31P36VTjdhusDgV9KVdrn4hFMW1ZW7zQCKxOAcjCeMGJrcgY84wCunqDuqCFSbb8xvi6IOpgtop55i8X7gwMTnXESicG07CgkLFTRlgDDVhkkb6MSJ3uKBfcKa3VVgiMGUEmKMMAYlzn3nmx7NaLIySI+v5XHXAU06531VF/218TC+Si50zWOT2n8LOksg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6c9c5b-10cc-4df0-7642-08d838b6f415
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 20:42:50.5644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGALiOowjFg8O+itvg7uTL9kDpE4pskT76vslZT4A8AtHIT1hStATnSr8sLdAuj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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

v2: support change setting at runtime using sysfs

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index 8703aa1fe4a5..be29b1e8606d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -136,7 +136,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		ttm_mem_needed = acc_size + size;
 	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
 		/* Userptr */
-		system_mem_needed = acc_size + size;
+		if (no_system_mem_limit)
+			system_mem_needed = 0;
+		else
+			system_mem_needed = acc_size + size;
 		ttm_mem_needed = acc_size;
 	} else {
 		/* VRAM and SG */
@@ -148,6 +151,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
+	if (kfd_mem_limit.system_mem_used + system_mem_needed >
+	    kfd_mem_limit.max_system_mem_limit)
+		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
+
 	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
 	     kfd_mem_limit.max_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
@@ -204,6 +211,9 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
 	bool sg = (bo->preferred_domains == AMDGPU_GEM_DOMAIN_CPU);
 
 	if (bo->flags & AMDGPU_AMDKFD_USERPTR_BO) {
+		if (no_system_mem_limit)
+			return;
+
 		domain = AMDGPU_GEM_DOMAIN_CPU;
 		sg = false;
 	}
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
