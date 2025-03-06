Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD05C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4AE10E9DF;
	Thu,  6 Mar 2025 15:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/lT1EBa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9054110E9DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO+Wpq2JCIEF40k+NcCh2mwzYbifCyqJbFVmD0c4fvoNjU4udVbs7G6pGAPqM6rOyxmLZGtzxMu0L0o4HJ3itCSEGR3zLlcpkT3i9MkmCUMqIUZfQFBnjDjexMVRMuNUqmRbzOZNzGrogKO/A6oD88PTYC2CkE7jfSvLb/kQ/NMUvNPZuAHnIVn4HPzq7zzxY4QdZMBArcLMAi5GbcKtjA2m5nru3WDd4557OSYH2kx5TyVuSJTgWgX+z3hSpPlVb70V2alc5o0jj+2VUbTNb8zAX+2o10X41nofqEEbmLhKoQjZP/re7TzMiJ95YMCZ4SbtV7H8hNxmCC5KrBQpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkbXRDLPCcsz4STxGK+XAAnmkhLP5o8OsrlOYG+cpe0=;
 b=ILNQLkexQvCjotAWgSwsgTDEB0Uod+JNiccim9Oby8W59JlorRAa8NYTnyUOnpdxNq+MAf93LPfT4G45mZcM10K785RIn+o8p6ijxz+OtUKvfZ5XFZ+ormAvpzz+fb3/Dzi+ilPMQd9bLcpWF42axusmPsMx8WouxYARhAKTdTE3WRNlZO0hwmw+bQIIZOevjbhgYjKYwutBUL6MP3Uo/WlEje3nKA5UrggB5DvPFLXVU/bIL9GWrF5DiCnU5Pz9jeJLty6Y/o3LptdgliqWW62buMBxpqE+KcDCOThTkx9tjtyFerxeRtU68xDzsgg2D015pJzGMGSW5TjRFcHv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkbXRDLPCcsz4STxGK+XAAnmkhLP5o8OsrlOYG+cpe0=;
 b=M/lT1EBa6GmljaG2V6h73HE49Ud7tMNITdtZVGkfBs1meTjvjpkDPcnZYJsUSmZhPsYxpJwYAxJpN+KcGkYxwI6x8dsTgwlUCySZcaDeGiXMRmDKutB6/iekHcHe8biEQgf+JQ2ffGgtIaD8lnw7X7KelBhxkkQHkoFGHzrXZ0g=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 15:56:23 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::e1) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 15:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:56:23 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:56:20 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Add support for more per-process flag
Date: Thu, 6 Mar 2025 10:55:55 -0500
Message-ID: <20250306155555.4687-3-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306155555.4687-1-Amber.Lin@amd.com>
References: <20250306155555.4687-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2189bac3-3891-4a4f-2119-08dd5cc771ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tw9gnaWKD6Ynp8iiTBbMd9sHK/x3FxY6sRr264SIbl8V31Nitgjwyx0yBPLF?=
 =?us-ascii?Q?glqbpygr/m58rJfSQ7FUpAli+acIjVhl/MvDfiXVKasmeCSatczgf6CCASuE?=
 =?us-ascii?Q?LEhBm5L5EZR4CKcps85IzV4dfrwhyhR4R0UZSPcaeVRLc6SAmofRo/2d3OHd?=
 =?us-ascii?Q?0GJ06jelATxBn+5qiojYw1AiclzhgNLZJ0HxlJFixOBVOHYMXZ32PZuQPfL3?=
 =?us-ascii?Q?8CBdosEPxjwIDXGPdHN+E15T9ws2PDZqLdziZzFKSADOAqZZXmKZlrhbiAtK?=
 =?us-ascii?Q?Jmp4zXtFpw7Q1y4RJqORaSs7Ab/X6bv3rYVrBQx4ewDcidz325n08iMCtLvD?=
 =?us-ascii?Q?4/taZPE6fDQ8y2zoLwZbVFDib0NDheoujfPpkt4FrrKqawp551AWPb3ypb0b?=
 =?us-ascii?Q?AQjDPOBe2qdqzjLLw2m79osPZ3BpY487mw93IXGl4OkveE5S1BU0qpGkACvx?=
 =?us-ascii?Q?SDoFH9uu9lDEi3lJ8/ldAAWb8xsiawjyqFfDI+nZMr6bo6Ulksh3TVF9fMtF?=
 =?us-ascii?Q?coUwKNpue7sNB8CoW6aHC+XZIvAtoxJQFXkwnHr62s4FAGyI8xBzrIFpiM7e?=
 =?us-ascii?Q?rYM0ZUj/OyaxE1cq0clG2B80n0Q9v/VQPT+W7zTFTNLQAPOUIvUhoHIVb/po?=
 =?us-ascii?Q?21CIWb31e/QrbK6+k7W28g5fXg2cPynshnIDMYkZIbAjAYiaNpGrL2KvhQPi?=
 =?us-ascii?Q?Kpk/IRegGrytiWbKG5FE7ceh3ZENO+Ry17u5KAwMp/Ti4UStFk+z+qV/Le5h?=
 =?us-ascii?Q?Gx4FCTRHYxknNRhqBC2hfDL6FGJUSOgW82uFKRDFJamp9Nqew3EFWT28y0kG?=
 =?us-ascii?Q?mOL6zIHOVsUHG3vI+tpdVx3+9es215q2EboDESR2/7TOS7UN0oX0Ou1JBBgg?=
 =?us-ascii?Q?y4irD79vp4QC2Jds5L1ndhOygByi+03pzsxfx5CYTtruMQfEHcGhqYwlpwmY?=
 =?us-ascii?Q?VCW7laqckg79bEzk18z6bd9U7Kd6KgaP9EwFBWjVCAP6PC4V/TCKnJJj3CmV?=
 =?us-ascii?Q?N0iX169y5suBqsdamy4s1mHF88kPFyBKVEVByUyaJGU6bYUJ5eezAphfdhKZ?=
 =?us-ascii?Q?Zg+MeuZhYQhUwwNgDqfywoWzNt+3nKPOeGPjkOaOvlA9i9yZOEKa4eUx64Nn?=
 =?us-ascii?Q?dJA9zNfIVZxSvvlmfeTi6+3Z8v0x9ee/HMg6Lhj1SV1hITbDXfAqzhXvzO/E?=
 =?us-ascii?Q?KAHH1hlj3VcllNptBuqbVLuv7uxM5ocDtGnAS+hJlunYtKO46E6r+H6E4T8K?=
 =?us-ascii?Q?HrnPik/1PXgNqQzj8WGBz/K5G+bGlKkzL3os3VWGIgYv1CpwPZ1ouldksKJw?=
 =?us-ascii?Q?m0721lTh6Z8ewC7UbL5O4S+oXnb8HqIGTDGO4vkezyBionuaXmFBXhH8Bzud?=
 =?us-ascii?Q?TdcG6pdnQkCjUQp4W5RcLKQ6UWSIrlFH+yFFIBBD60Vq0BWptuEujROuO0la?=
 =?us-ascii?Q?MqMPI8IbRBpQk5SlH9F1Qy27G7NAhLtpDvg8HhsTpRXxxkvGtgRR2SxaeWVl?=
 =?us-ascii?Q?HzX4ZUnr42LwCv4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:56:23.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2189bac3-3891-4a4f-2119-08dd5cc771ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Add support for more per-process flags starting with option to configure
MFMA precision for gfx 9.5

v2: Change flag name to KFD_PROC_FLAG_MFMA_HIGH_PRECISION
    Remove unused else condition

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
 include/uapi/linux/kfd_ioctl.h                        |  5 ++++-
 10 files changed, 43 insertions(+), 18 deletions(-)

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
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index b0160b09987c..e7b4b1551529 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -150,6 +150,9 @@ struct kfd_dbg_device_info_entry {
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
 
+/* Misc. per process flags */
+#define KFD_PROC_FLAG_MFMA_HIGH_PRECISION (1 << 0)
+
 struct kfd_ioctl_set_memory_policy_args {
 	__u64 alternate_aperture_base;	/* to KFD */
 	__u64 alternate_aperture_size;	/* to KFD */
@@ -157,7 +160,7 @@ struct kfd_ioctl_set_memory_policy_args {
 	__u32 gpu_id;			/* to KFD */
 	__u32 default_policy;		/* to KFD */
 	__u32 alternate_policy;		/* to KFD */
-	__u32 pad;
+	__u32 misc_process_flag;        /* to KFD */
 };
 
 /*
-- 
2.34.1

