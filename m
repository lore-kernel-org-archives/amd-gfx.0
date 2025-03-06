Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EC2C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEE710E27A;
	Thu,  6 Mar 2025 19:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYiPHeGD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D676E10E27A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGW+wODrxtkxD4cG9YJweE9kK+zKQCiryNTfpJgvuXafkx7R9xhsqamiKvF0SjT2EnJttNeF8mk5t3uWmu4GIn8fyYu8+RMwLtTXW6SQs4Haj5B48p1t7AsLupPmzJGc5mjTp3jjZrFT5kDRZ8expXNx6JpiImEcyTVyKOMn7caNC19NNQOAd0NC9Uj9yu3Id+iTtYNa0CsCMGqS1lkvqJxMIo0HeabxWp2jlEPbSb73MujTb8zXfIS4I78dXu7enfxs/MB3y7xxLOzZ3gB8WaYcTMiU4en+8IpK10EOqIEgQYc149vYIZTH1Qf2EXx+b5yiIYVOBETdjdsnTxdxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ntZ3W76/QU9pZHjD7HkOjC3TlvHWWvcTmA2g1XhJ40=;
 b=uvZ2ngfVCipNrcs0Q2LhqawZmIIMcdps7q0OwOwtiQ/81QPNOEMx2QQeqCOyoskVHKy8xMnaSJpc3Gxpvzry8MbrVBzpMNpg4s2WAHe+WXMEEbR5q8eVfXtYrPkOXGojnTsAvx5pw4MBGVeSyABG9X+TwWmlJHB36cZI0Na1ZCPYJOrPDXRK5B40Tjo9TNOHjCy7n+tbiPlasUzWxLWn3TqrgyCRwZKEiWLZ5wJX07OoRc4yqZjaoFKVMb0LnNxGNpgomvC31gSm7lKN+R0F3P3C0ugEKnsTU88TIzPLC3y7dAKcVHuS90Z/SK4SBFBybAOAE2XqZC1UfBM6t56DJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ntZ3W76/QU9pZHjD7HkOjC3TlvHWWvcTmA2g1XhJ40=;
 b=CYiPHeGDmTIgi/q8wGkPXSq4zJkxsltFxTnTF+ICUDUt6SOdG9kJPkBWq1ppIO6aNZv/8MRJObMtXaWe63TPWaSnpQSDp8oGdR9jC43F9kbtSBTeVKiOfT/JYATeR00C8WhkyWBrwXAXxUgKGkJKytWaVoXHbWMBx+hT1aaUm7I=
Received: from MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:52:43 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::25) by MN2PR05CA0010.outlook.office365.com
 (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Thu,
 6 Mar 2025 19:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:52:42 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 13:52:41 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v4 3/3] drm/amdkfd: Add support for more per-process flag
Date: Thu, 6 Mar 2025 14:52:27 -0500
Message-ID: <20250306195227.32765-3-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
References: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c088c8-bf87-4c6b-2a70-08dd5ce8753e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwTBP3ectqBXRQktbD/OMg9BR0S9jGt2bUByGGsvl2h2ry5gSvBukl5DSzBV?=
 =?us-ascii?Q?9cqeSr4uFZD0K1pJUodXiGCOGd9D1vQuzxF32ztbc+JeAqYFBJsOFfUhpLZh?=
 =?us-ascii?Q?8zcE69eI/hn57TkQ8Yc4g3w23rwaAJ+3pRj3QcSw/zsQ25YsauSuNHnyGjmr?=
 =?us-ascii?Q?SJrngF8YdYFDx2684M3/fOH4j0t9yf5TNqfAZdXOcB8dwWVEicQ/WxcNz0h9?=
 =?us-ascii?Q?HLIAN0Tt+lGCL8GFCuXabRuP5zjrqL/6IH6vkus3Enure4s0C/OND29LSm2+?=
 =?us-ascii?Q?j95Ekd1qeLqoIbmmqrLRH/IKSNefoY4RzaqB0ydVAOFlyZi9Ln7mZMqOxB8g?=
 =?us-ascii?Q?k5cgTOcA0qVSsYCmqWNtD9u6UI+lHz+cFPezLOZqApPPwXn+mw7Uh++c02Te?=
 =?us-ascii?Q?pFsOr1Cb47aTDBajiDsCaTJF5mQdT5BeZxhW/2X6H/vRrXCmuMQn6kznZuw6?=
 =?us-ascii?Q?4mnQjT3J8OXdvQAqRdUr/XkrvCIzGjt+inpbD7TxHc9aUuNz2eRyzOAdNrWe?=
 =?us-ascii?Q?VFl2Zm9rEX3k8jd9JjoHxO80+LTdnElAclmoEE91ZuSCRZvZqy7OsRq9uJ+5?=
 =?us-ascii?Q?D0sq1wa4+tQcbkKwya8/VFTKW6zXIZYSeyuxy4DiRloa6/ookhsjBmlEK0Xo?=
 =?us-ascii?Q?YTZIdEpf2OPU7STafKlVgBBoaVk8VhbR0joghzl6lML3NL/nIyMzS/JNpYwp?=
 =?us-ascii?Q?G0thhsSQU1hkoSu7t69TcB4y0h1sFi0jkZ3v+Pg3M0sOE1w6PCiRu7cZeB6H?=
 =?us-ascii?Q?jIcAKVHD9LJX6yyDk+vrGeqOMz/Ctacms6xn4dN0pzB3ox+137ZVP6ONKx4+?=
 =?us-ascii?Q?bUWXtZIqnsqZm/0raqCNmnJD0gL4fpJRAog2ji5f+JZpcspyrcbec+h4j1uD?=
 =?us-ascii?Q?+lrrhIEqO4nAKMZ8rETxKu5OoKpgzRkEjfZxhQbqqRBQ7M+o6ONYgDABkHqZ?=
 =?us-ascii?Q?tAxW9NK8Od1maX6hz4UzS3UW1SYy3B2a9ZaOun9gvqussRX3vJ+ou3C714Ow?=
 =?us-ascii?Q?HkGWGVGg4tKpLlhOPJSuGdk3sS8k1G9ndD+T9/Tg8KoE+HwQj2KVnL+0i6BH?=
 =?us-ascii?Q?yrNB2usgvvcj+SeDv1uuQnWhL6QvHqzKZMGjGB4FRSHZljDFtPDTd004nzEs?=
 =?us-ascii?Q?FOApaF6mFRUmv8EHITGg3uvZirnqDU6bUPs32dWUnNIvFfAvjrcWEbbLj9F5?=
 =?us-ascii?Q?m6B5A2Ih1wn6SWbO1MBnNW9mbhu2vHqSvXMmR+lHSxIbwmv78iq49O9IvO5B?=
 =?us-ascii?Q?ks61xThp8e/QnJsCdj+iOEXAaC0QTSiNnxc8NSNz5eXSNqlPOVtfk8zIens2?=
 =?us-ascii?Q?Zgpir0KS92tCzkL59GuFORSc4xeaaE7GVKcrVKkERRkdX2/gsNQD8qV0gub4?=
 =?us-ascii?Q?MmqpqvrchMYMdKhq3e6NX0kWPg9JxNYGTbsPF9V/ghE4X4uqBCDZsANyGWE1?=
 =?us-ascii?Q?IkG3dxESpwpo2YWMPW1k8ee2lJMPdoGDDgIkf6nB70BK9Te4BkCNKhB9Ngmx?=
 =?us-ascii?Q?P8GS7k70EGCR57g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:52:42.5342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c088c8-bf87-4c6b-2a70-08dd5ce8753e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

Add support for more per-process flags starting with option to configure
MFMA precision for gfx 9.5

v2: Change flag name to KFD_PROC_FLAG_MFMA_HIGH_PRECISION
    Remove unused else condition
v3: Bump the KFD API version
v4: Missed SH_MEM_CONFIG__PRECISION_MODE__SHIFT define. Added it.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c  | 11 +++++++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c  |  6 ++++--
 .../drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h    |  2 ++
 include/uapi/linux/kfd_ioctl.h                        |  8 ++++++--
 11 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8c2e92378b49..1e9dd00620bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -606,7 +606,8 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 				default_policy,
 				alternate_policy,
 				(void __user *)args->alternate_aperture_base,
-				args->alternate_aperture_size))
+				args->alternate_aperture_size,
+				args->misc_process_flag))
 		err = -EINVAL;
 
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d23c6a358d34..2afcc1b4856a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2596,7 +2596,8 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	bool retval = true;
 
@@ -2611,7 +2612,8 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 			default_policy,
 			alternate_policy,
 			alternate_aperture_base,
-			alternate_aperture_size);
+			alternate_aperture_size,
+			misc_process_properties);
 
 	if (retval)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 7146e227e2c1..122eb745e9c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -174,7 +174,8 @@ struct device_queue_manager_ops {
 					   enum cache_policy default_policy,
 					   enum cache_policy alternate_policy,
 					   void __user *alternate_aperture_base,
-					   uint64_t alternate_aperture_size);
+					   uint64_t alternate_aperture_size,
+					   u32 misc_process_properties);
 
 	int (*process_termination)(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
@@ -210,7 +211,8 @@ struct device_queue_manager_asic_ops {
 					   enum cache_policy default_policy,
 					   enum cache_policy alternate_policy,
 					   void __user *alternate_aperture_base,
-					   uint64_t alternate_aperture_size);
+					   uint64_t alternate_aperture_size,
+					   u32 misc_process_properties);
 	void	(*init_sdma_vm)(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
index 32bedef912b3..0508ef5a41d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
@@ -40,7 +40,8 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size);
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
 static int update_qpd_cik(struct device_queue_manager *dqm,
 			  struct qcm_process_device *qpd);
 static void init_sdma_vm(struct device_queue_manager *dqm,
@@ -88,7 +89,8 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	uint32_t default_mtype;
 	uint32_t ape1_mtype;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index b5f5f141353b..ba6e3d747ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -36,7 +36,8 @@ static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size);
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
 
 void device_queue_manager_init_v10(
 	struct device_queue_manager_asic_ops *asic_ops)
@@ -61,7 +62,8 @@ static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
index f436878d0d62..8b447d04558f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
@@ -35,7 +35,8 @@ static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size);
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
 
 void device_queue_manager_init_v11(
 	struct device_queue_manager_asic_ops *asic_ops)
@@ -60,7 +61,8 @@ static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
index 62ca1c8fcbaf..3550da3a46f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
@@ -35,7 +35,8 @@ static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size);
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
 
 void device_queue_manager_init_v12(
 	struct device_queue_manager_asic_ops *asic_ops)
@@ -60,7 +61,8 @@ static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index c734eb9b505f..4635077aa905 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -35,7 +35,8 @@ static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size);
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
 
 void device_queue_manager_init_v9(
 	struct device_queue_manager_asic_ops *asic_ops)
@@ -60,7 +61,8 @@ static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
 				   enum cache_policy default_policy,
 				   enum cache_policy alternate_policy,
 				   void __user *alternate_aperture_base,
-				   uint64_t alternate_aperture_size)
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
 {
 	qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
@@ -73,6 +75,11 @@ static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
 		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
 		qpd->sh_mem_config |= (1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
+	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0)) {
+		if (misc_process_properties & KFD_PROC_FLAG_MFMA_HIGH_PRECISION)
+			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__PRECISION_MODE__SHIFT;
+	}
+
 	qpd->sh_mem_ape1_limit = 0;
 	qpd->sh_mem_ape1_base = 0;
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index 320518f41890..dad83356e976 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -40,7 +40,8 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
 				       enum cache_policy default_policy,
 				       enum cache_policy alternate_policy,
 				       void __user *alternate_aperture_base,
-				       uint64_t alternate_aperture_size);
+				       uint64_t alternate_aperture_size,
+				       u32 misc_process_properties);
 static int update_qpd_vi(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
 static void init_sdma_vm(struct device_queue_manager *dqm,
@@ -89,7 +90,8 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
 		enum cache_policy default_policy,
 		enum cache_policy alternate_policy,
 		void __user *alternate_aperture_base,
-		uint64_t alternate_aperture_size)
+		uint64_t alternate_aperture_size,
+		u32 misc_process_properties)
 {
 	uint32_t default_mtype;
 	uint32_t ape1_mtype;
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h
index 2bd9f3f1026f..0122a21c50cf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h
@@ -2261,11 +2261,13 @@
 #define SH_MEM_CONFIG__ADDRESS_MODE__SHIFT                                                                    0x0
 #define SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT                                                                  0x3
 #define SH_MEM_CONFIG__F8_MODE__SHIFT                                                                         0x8
+#define SH_MEM_CONFIG__PRECISION_MODE__SHIFT                                                                  0x9
 #define SH_MEM_CONFIG__RETRY_DISABLE__SHIFT                                                                   0xc
 #define SH_MEM_CONFIG__PRIVATE_NV__SHIFT                                                                      0xd
 #define SH_MEM_CONFIG__ADDRESS_MODE_MASK                                                                      0x00000001L
 #define SH_MEM_CONFIG__ALIGNMENT_MODE_MASK                                                                    0x00000018L
 #define SH_MEM_CONFIG__F8_MODE_MASK                                                                           0x00000100L
+#define SH_MEM_CONFIG__PRECISION_MODE_MASK                                                                    0x00000200L
 #define SH_MEM_CONFIG__RETRY_DISABLE_MASK                                                                     0x00001000L
 #define SH_MEM_CONFIG__PRIVATE_NV_MASK                                                                        0x00002000L
 //SP_MFMA_PORTD_RD_CONFIG
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index b0160b09987c..1e59344c5673 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -43,9 +43,10 @@
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  * - 1.16 - Add contiguous VRAM allocation flag
  * - 1.17 - Add SDMA queue creation with target SDMA engine ID
+ * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 17
+#define KFD_IOCTL_MINOR_VERSION 18
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -150,6 +151,9 @@ struct kfd_dbg_device_info_entry {
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
 
+/* Misc. per process flags */
+#define KFD_PROC_FLAG_MFMA_HIGH_PRECISION (1 << 0)
+
 struct kfd_ioctl_set_memory_policy_args {
 	__u64 alternate_aperture_base;	/* to KFD */
 	__u64 alternate_aperture_size;	/* to KFD */
@@ -157,7 +161,7 @@ struct kfd_ioctl_set_memory_policy_args {
 	__u32 gpu_id;			/* to KFD */
 	__u32 default_policy;		/* to KFD */
 	__u32 alternate_policy;		/* to KFD */
-	__u32 pad;
+	__u32 misc_process_flag;        /* to KFD */
 };
 
 /*
-- 
2.34.1

