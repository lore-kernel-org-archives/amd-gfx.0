Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366BC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E9510EC75;
	Thu, 20 Apr 2023 14:48:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D839310EC79
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8YxA/l+6y2o80h/iuxjVbSgTYcrr5IKQLJPkUUfNQROmm982cn68dijJ6Luxty68dVsM7SJHY+ClWt5TPHH9ezWEhZ+HNPvrHDm13frQ91/ION6oEqCg1T35fRn5KMH/O0CU5vAf2F8IPt50eVhEiNx+N9nnahW9xImdbDLuo3EssPZkT29F2f9AppDfES0G5NlddECiYNOEKkB5yYdD6+NN5/PG5vVP6RjEfL3f/b45i91V7divedVYu5vvF+pGcqJ033tJoqxDcbfswbAOKIf6VQRAM6lIm8HY/MfEf8m1HPPdJmcCOW2t6HNR8OZZ/a8sBsTwVz7TmSCZTl8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoycmQhnvRj4zZiATn4fGMjYhsrQN3cdfl3kaZx3X54=;
 b=ZQ8G36yeK/Yg+HNg+jyHgK7ixG1kJEiXfc8feQ7L3/8U5679ptoXPs1UsV/dCUmEoW8v1jXG57V5Z5YuVyRBjTMImQXiQiH9vc+Y/tn1JKKCWHHu1ygTR5cnpsp9oBx9PfWW0GZe/fEH4YnE67+MrUNoTgwS1r9Cfxd9KzrrM+UVsuwL142XVROa7aMofr9IQcH7H+iy+jAjwkuRB3rtFUlc1/Bs5oDnBpxxYbsqhqhTSpp2o2YyTIhh8NTN5vtSRQbaNc+XgidU7bt8UfNoMfE4HkOGin2ObLqQhvw+z9gWstKKlUF2Pb5ZXs+ylsVnkbXqRvruLicA+Yob7nY34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoycmQhnvRj4zZiATn4fGMjYhsrQN3cdfl3kaZx3X54=;
 b=agliZrb6xxFElWBqLPG8SNpXGUUgqK+SEgI5k0Azu3RNJCFU23bLP9NNWZCzqV6bYcSFcQRU3thic8e33kWUDLotXvCk7JY3e9WwJCROY0rjH8U/OgN1EM78Ftql2eT8pObPVUp1Uve5ayXXWvRXQqZRLabnGD9goGtTyVzBOgw=
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 14:47:58 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::b8) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Thu, 20 Apr 2023 14:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 14:47:58 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:47:56 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/6] drm/amdgpu: UAPI headers for userqueue Secure semaphore
Date: Thu, 20 Apr 2023 07:47:12 -0700
Message-ID: <20230420144714.124377-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2c3b12-f023-4957-5908-08db41ae3bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KUOqfXrHPrRgSB1vJfw6MQl7f3IJvBtrFYaFcMzTjfNp0lvY8NEFjCHAyRC6L528jgca8HuCBGx5Gha9/lJU7yViYFDXRVx1DwkyhkrtwUD7sf3c01aQ5ZJdUdeY1/Q4fgqSrhzpEoxdLNpqpcjkLWwKadPHmd7lBaBNSN4VP1TVSKFwiSCnnY2zXDB+1pYDJypZEZky/ZOJYC7D1k+XJSPennw0W5EmFkjkc4IJvaUXhGlAal6CJa/NS2tcA2uZ/grByECmvViKtkGZvz+p7EV024+rAP0q2/93NELiswitDprxrorlhGEi8CIRKcndHR5JMuKXTzhCLnjWkftAIdlVF+SNFuifv+ZE9SPpNhlSw235iLr38YxGKV5B9n9gksbEZ61S98Qp+go/AoKjEcMdbaJLI5itvJVcmEJi8DnBvFMIAUMqsMTiqSv92qX3zFHlH9+QKXGLC3qDcs8Zv7wfgPbzYsnPWUoVDC8FfbdKlPuDkvfCD2hiAqr13e0UlJwdAIFjlUtBzdlD4VThRpyifZq0YpiwhTebG4aLT6QVsg4PuzsNXczXKsEZw0rdBEvXDnxwBEzLLhHW/wJlw2LL9AkFlvno8qtJ8qS5OEuTwrOe06txyTqOs3n5ruy/49tKj0ucjadtZmVHcuar7Z3IuJo5mdHjuPQkxp0i4hG8Yx/UkV4QXHsT5tCMmPbhOkYrHMUCp4Zq1X4QRc4Sq7bO2sBkiVFEJ/kJTTl/yk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(186003)(70586007)(6916009)(4326008)(54906003)(316002)(70206006)(478600001)(7696005)(6666004)(8936002)(82310400005)(8676002)(5660300002)(41300700001)(82740400003)(356005)(86362001)(40480700001)(2906002)(81166007)(336012)(426003)(2616005)(36860700001)(26005)(1076003)(16526019)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:47:58.4524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2c3b12-f023-4957-5908-08db41ae3bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 - Add UAPI header support for userqueue Secure semaphore

   v2: Worked on review comments from Christian for the
       following modifications

       - Add bo handles, bo flags and padding fields.
       - Include value/va in a combined array.

   v3: Worked on review comments from Christian

       - Fix padding issues
       - Add a number variable (num_fences) to get how much
         space we need to allocate for userq_fence_info
       - Write better name for the variables

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index e4943099b9d2..39a9203908d8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -55,6 +55,8 @@ extern "C" {
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
 #define DRM_AMDGPU_USERQ		0x16
+#define DRM_AMDGPU_USERQ_SIGNAL		0x17
+#define DRM_AMDGPU_USERQ_WAIT		0x18
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -73,6 +75,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
+#define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
+#define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 
 /**
  * DOC: memory domains
@@ -362,6 +366,49 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* userq signal/wait ioctl */
+struct drm_amdgpu_userq_signal {
+	/** Queue ID */
+	__u32	queue_id;
+	/** Flags */
+	__u32   flags;
+	/** Sync obj handle */
+	__u32   syncobj_handle;
+	__u32	pad;
+	/* Sync obj timeline */
+	__u64	syncobj_point;
+	/** array of BO handles */
+	__u64   bo_handles_array;
+	/** number of BO handles */
+	__u32   num_bo_handles;
+	/** bo flags */
+	__u32 bo_flags;
+};
+
+struct drm_amdgpu_userq_fence_info {
+	__u64	va;
+	__u64	value;
+};
+
+struct drm_amdgpu_userq_wait {
+	/** Flags */
+	__u32   flags;
+	/** bo flags */
+	__u32   bo_wait_flags;
+	/** array of Sync obj handles */
+	__u64   syncobj_handles_array;
+	/** array of BO handles */
+	__u64   bo_handles_array;
+	/** number of Sync obj handles */
+	__u32	num_syncobj_handles;
+	/** number of BO handles */
+	__u32	num_bo_handles;
+	/** array of addr/values */
+	__u64	userq_fence_info;
+	/** number of fences */
+	__u64   num_fences;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.25.1

