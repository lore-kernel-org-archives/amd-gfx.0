Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F640C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28A610EA81;
	Thu,  6 Mar 2025 19:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K34XSNEi";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB4A10EA71
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoT3A2pL0goaOjdDM28cyFLFf8jDyveyr0veoe95d3flEjcgprdV/s8gJOaLf7wTqEybrsi98YEyyOU1PJW8Y0nQS/YZbY6hPUPpKns2qfAOCsV49PGbLFevMKbn3uCmTDR1Z3pNFZS714ZSX+E9GkeGoTz4P2hkM6TDZfRwZXam6Ut4I5RxPEsSlkjW1JNBF9FDNYx2IN1S+fbGbF0F/xHwKNj63umtyek1vOeh8oEkg4KjjJi/pEhP7q+D33VA/nfhJb0YhfGItLJoMAMPoscIXJ17BzNgwTSmQtvfMtwodTED1i0CMUl2q3GuAx9jmvc0LJf7wSaHF34U3u/q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcwr9N7BYa1lxoP1dprT8tiuYZe3fnD/GU5ORZnpuKU=;
 b=gfB6xm8bPEbARWSWQ80ifuP3E5xwIHsItl2nmTty4rQdZgFuSET0bdN3RnSs6Pth9ah+/wRpFg471nLIy/+Vgurjr2l4JoxkVShohG8AOJoJYZIMKheqH5FHuYvvZ8nJQWiPcoUl2r2xLe82tMnluKBUzfVwllYHLnyAL3Xg4CDcQvGZECdhxeQNLJyGaIC3nAwDk+KGJNtlB/JePxPU/4pwUuhVfEk7viw2hz1Rg3/FsV8g1Lo6ZV1eMHtbUSnW7+44zsVFjNollEUzWWDy6+XNihQa4gnMBTMNHVNd2E7s0Fiht1xSDXVdfmrxl7l8WPuU9IKgDMtRRqT6iTDxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcwr9N7BYa1lxoP1dprT8tiuYZe3fnD/GU5ORZnpuKU=;
 b=K34XSNEiOcOElOJbKC8tIQfRW5xNsZSRixE/kM/SHWmAlZeuDxpvti3vi+e5Rw0eV5Bfnl1Xexq+M4XSxS/1+p1YlBGv2HakyXEUz5vlCXDhh7MSLHEUJNTnPCEn+MgxVR+/LHVcIATz1QgbanXI7/djUDN7lGAOJZa92aCl60M=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 19:38:57 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com (2603:10b6:5:54::4)
 by DM6PR06CA0041.outlook.office365.com (2603:10b6:5:54::18) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17
 via Frontend Transport; Thu, 6 Mar 2025 19:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:38:56 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 13:38:54 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v3 3/3] drm/amdkfd: Add support for more per-process flag
Date: Thu, 6 Mar 2025 14:38:33 -0500
Message-ID: <20250306193833.14258-3-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306193833.14258-1-Harish.Kasiviswanathan@amd.com>
References: <20250306193833.14258-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6f089b-9d89-44e5-12bb-08dd5ce688c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QezS8u2iufzau8Aytm9JpWiXZXc//Te4w5PBBNB7xM7G+Z3b76lpARKNgLEi?=
 =?us-ascii?Q?Gja0YgeY6hOj2CTf7g/Tcfwhi8N/APIGpWL5M1rhsifQFcuEsBjujw0eO6wd?=
 =?us-ascii?Q?MS03cJcfGOd4sDQHtU6LUxqP5e9myoKTG/7KzEe1gNrElOUejnZ4ydLirlx5?=
 =?us-ascii?Q?+Bk4JUjFhlRuPROG0dSu0xhrgVaBB2325LtV+aXw11fRAem8PDSPzKx1d0cq?=
 =?us-ascii?Q?ZocphIw1zROvdAj/ir3mZQe5FRzbbbVIuZb24i/5zQBydAZit53DxorjAy3X?=
 =?us-ascii?Q?Q9vE9/nU9AxAnju8IDYOcEAphayCRbI/1jdtdcVlSVOZ1YKqjCbbTADyPXSQ?=
 =?us-ascii?Q?Hx2HLbDwbBg0/W4VIJQNXf5z9Bb/6x0DJ38mqsGegIZ7Bd6GNWt97No59OaH?=
 =?us-ascii?Q?av1ZkDfY7tGlRIr7JsB5IP4JwDCxJ3FSKaTAu/xqhvWx5iDmpEo9LIi3/Hpo?=
 =?us-ascii?Q?32MyOM2yxqCCKoqlKQ8GE0CD02Jc3ydErUhbQZKR2lpVOb/Y1znZ6JFgKgct?=
 =?us-ascii?Q?v4lhURXaHs9MRoDG/LHwR7hakKPXquPJI0SX0rDdAJ44OIDi2ZgKYreZilqU?=
 =?us-ascii?Q?LRg49zPusWW5SUze8xLMJffHAv79nibhVarmxPWBEfxnLUa1KK96COUN2my/?=
 =?us-ascii?Q?POcHWteqBqqHXzvFtNMBGdqKoeJJrdN8Nm2T0o8HwlZeQq9+92iLP8MWY8DZ?=
 =?us-ascii?Q?aKDS6uIp4S+q2ampxr27y9rhOBvERGd0W85f7WY2GLPp+tOIHNS6p3Yi3cZm?=
 =?us-ascii?Q?z+P5keaFCR7rGHgGXkJA0oHnosIv8plkzXbklMIw3+mgOxxGPb/ZQq24AZfM?=
 =?us-ascii?Q?B3pRg+IrbYybeBQWYduRmGqP4t5P3xoxBDQb6NGzoyUsL5t/SmxaU1OYM/k7?=
 =?us-ascii?Q?iSzaIloSoQlu+SM7+6fSqWITXmJLP+Fon5mnyt3U8rYaNqjtHNEEKdnDLM9Y?=
 =?us-ascii?Q?l+0jxpSc4ycDoD7t0j2VNBdHYFB8NglX7T+7xAn77OGKG0jnlURmmN28T6wC?=
 =?us-ascii?Q?vY4AXsdfUGFdwCQ+RTFVD/GozQm35OQPjT+PBdnCjv3xK6I1ixJhZ2a7PG5x?=
 =?us-ascii?Q?47VoimGQUL+JMgqVH9Rw3K1xTH1+Wp4jK+LQbieKJciqmVH95vLxPDIu92+I?=
 =?us-ascii?Q?y8BJHpT9wNHEgW89DEG5iPpSFkUPcqDoM/EsKhx5k+BbtFju4XNT3RnAR2e4?=
 =?us-ascii?Q?Uz8e8OcbiJthMGu2kXSrVo14ArAOYUMaG2xdNFBpWah6aMyVr7oi/kmYPAp7?=
 =?us-ascii?Q?dF6IKFYXZZ/xMqNstJIN7I8DROhGViqReLGjEFgDxunTWZlC3DjCLBWUnGFf?=
 =?us-ascii?Q?kIWIllagf+kEienZ0Ewj7G4gJL2TYbsZbV3Hg/uO8bEb0b5coZdCLbWSYLv5?=
 =?us-ascii?Q?XNu0Kb36PPK4Jpod7CGvYu66lDCvrJql2WPJf4d4rmKMEoEj2qeaVuqVrHfK?=
 =?us-ascii?Q?H8HnhnFW9OuOeLjeq7ByJRiH21JaNdb+EpF1VS2McWrdy70wv5FaPZiPuTm2?=
 =?us-ascii?Q?0XLMKefDvQDCmmA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:38:56.2209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6f089b-9d89-44e5-12bb-08dd5ce688c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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
 include/uapi/linux/kfd_ioctl.h                        |  8 ++++++--
 10 files changed, 45 insertions(+), 19 deletions(-)

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

