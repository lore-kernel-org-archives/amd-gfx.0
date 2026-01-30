Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE6D73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6020C10E0D1;
	Fri, 30 Jan 2026 02:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWijJ9vE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688DE10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWT1mugex0uZqGrwSgAeHNl0SWYwKxPyA8qwT6VkJOEHMAgrZWoJH/O+29RlC3A0R4fKYRuTON6gti50fuiORFn9nqRGZJHjCjrpelkdCU/C3u1qTGwX4PNvLaV3LUEOAFXKwQUIglcNL0KjogAge5YwmNc7zTvYUG1o1ZgVeG8LD7HNlb3tQaASyDrCvGedEi4CO5EzKDtPdgdP5a3h0lFNmqnc0jmu6ESc//yeyhjhhQduy6EIeG6lVsPyV09/eJT+3oAnGj3wgVFE5Dhha7++0CYyQITtRKHl59CczZMvh097W+S6FgMqo04TfCwjmjwde0L1iFgYPyOHNFGc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FyBnSzhKUCKpVsmRMr92OKpp9AncTN8Hzs8UA1ifsE=;
 b=ugGHD05DkveJRk76am6T15p7C3pDit4XvCasfi2gILHQmkR+NokglXIb8wBL7F2IeOOCSElp3QoRslbhgftQpZI6FJrC+XOhhAP3EqD8gmoTtHKY5icA9y98QQgEXT8l8TlTYx9qi3wNGgLCo2hRC3FbMSJSiFic/XE+iGeZOJWeyB4qveajxrVjx7YumTyETtNIYJ6svaZuvNePDKoNwqnPaIM1M0gTOGxhS8mzewZ04N4MF2psl268KRdOhoEeql7OTCY+fuf7/an0AaZGpWJVrBfLPP53RXMn1hOjY6bpghiX/cdRxEAtn2D7aSUzAJfkWQq+/V5nAWcrC+hH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FyBnSzhKUCKpVsmRMr92OKpp9AncTN8Hzs8UA1ifsE=;
 b=PWijJ9vEjA8QZyxk1ZqbYp5/K9tuOn0+pSH0igHRTHQpfbAfLuClmK5YMFg3EVcUmgUbXzRJL2BExj3+7h1KRP8GECyeOectBrPZHIPni4qARd4+42EROH572BwCGfPscJEByKQPYhJ5dXqEWL4SwATh1KV7XwUt/BbYLKRKsYc=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:19 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::32) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 02:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:19 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:17 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Date: Fri, 30 Jan 2026 10:29:38 +0800
Message-ID: <20260130022950.1160058-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: ac109458-9c4a-4021-f55f-08de5fa7830b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b0wCOCtaFGxW/DwqVI6FEQbJ0oUIXJiaIOgR8NI8Pzx7EE0Qb/iv1wpe1sYU?=
 =?us-ascii?Q?EI3kvEI35XcJx8XQiW7fkJXBHEwpVzUGujx/7ekpS2vZBMTRlhRaewEzFiRL?=
 =?us-ascii?Q?CIe4V6X8zv89qGQbbCPmUUF8FAofc7fQAWYi3skwsQm4Bra9OA1SrLQZJu9R?=
 =?us-ascii?Q?DUerT6hAGlUvWT9TL3J+PE+tVUckrx+WXkIJYjERzSjcjtedcD3RlT5WdJpO?=
 =?us-ascii?Q?MojUKUt/YF45i81fZKG4AdaZ902e9BVy3da6gQAmUlF6r5Z8KPeGFp6gfyfs?=
 =?us-ascii?Q?6qUD8sH18EMLbkf6KLF91Ane1LKX1Jtoq6rrR5pAI/EnPU8bItsmI9VWjxJS?=
 =?us-ascii?Q?rVRmLu4AYI6wvWEsfzVt0oXNRx7/3hEWPFpRnYYPWatyuxd3NWdWnyZ/x6Ym?=
 =?us-ascii?Q?c8vF/AenEv/gccVvn47WsaPHAvNQF53rBgTf0TfZn6id7g4KRXcXYmWxA9s+?=
 =?us-ascii?Q?b/F5AgGG+cZchGLCv2U7eXwNmmii84yPcl6hNbA8GcarR9H0RRu3KYwftqWH?=
 =?us-ascii?Q?+MoTg/tCBCqnMti3SifO97EwpKYFnURYetMi0PE6jroNfsYODaf7isWyfuQy?=
 =?us-ascii?Q?e6FISDlCDvlyrMMAQrJCKsacEKi9RuRf77KsS9NFitoSmKaw1rhMG64fpgeD?=
 =?us-ascii?Q?TOoNOezR4W2PjEN2qMERm5VC7IJs3hnhg6Clag4XVqofJMoK+ZDgHEcZPm4p?=
 =?us-ascii?Q?47GCTIaKXlxIvONKsdtmsg3xO2vZo1gMl6GIP4/Bc3385Smqz326awzw5jpK?=
 =?us-ascii?Q?d6xgLXwYEI/KGQ0awEhdXvFflocp61zEopp80URt3mDuN91ZLASG9KDWhM8z?=
 =?us-ascii?Q?JdByDbnf5fXJQuQhQY3esJuNuC2XC1J1yud0OaU3p/jB/rNo5OmnmJ/v1Z/w?=
 =?us-ascii?Q?KTfEm9HFVuU+n6r8jW+qaUwUtx5hmKIxoacvLQB7hsnmtzU4cBOrApve3YRv?=
 =?us-ascii?Q?jA+xItJGo/r2XtCed2Eq9DqY6WsAX3i/wqk0CITEy5bLmXlHUGnj9wziJ23z?=
 =?us-ascii?Q?sOd3sFe5YaIpIqIU7/7K34gTQgw1Lf47+bmTA3yYbVy/S2sIhd9pbIkAPgQL?=
 =?us-ascii?Q?MNMuf25WxPorYLmTpYAymVWvu/YBGPh/CBuiY4siyfs2iY/baAxzHOD6KxHs?=
 =?us-ascii?Q?cCOkSWpDVPI1zaa76zEcTUunc7bOPuanyXnGYlTSs1s3hrOtWsDw2bVyi24L?=
 =?us-ascii?Q?896mYC+Cyo3rD0V5jdtdevx6TQRuPcmmW/f1i5Zsz/Xh4aKFXdEgjOpE38ND?=
 =?us-ascii?Q?XO/kzO5nPEJCRZjss9EP2x5Z/5mvvJMb4q/tGCMT+YzcegafCYzFkn7Jl4vU?=
 =?us-ascii?Q?E83AQsdh5wuBQh2wPE/vcOEYYx0vLPMHT4TiRQntaPWxV64izGU0Ca27IAaM?=
 =?us-ascii?Q?xkskMIU+20qDumwrGHW7aj9SOvqprfwn/FHCDS2V2NzIxoN5xOrGBzEs/EIp?=
 =?us-ascii?Q?w+4HK1TdIYtidhRoVvK4AMb/eIJ/W3N94V/lKe+0dc9tYorK7YDc2YDzFFH1?=
 =?us-ascii?Q?ps810B51GU4gwLehIb9ccHJWg83hTS50KALurIl3HA/crXKKZgS9n6WWqYqd?=
 =?us-ascii?Q?WBbaWgQa9CqSTWaZasv65RAKa00NS8eCng6fyS5o3hjnBCxksYVSQx6EL1MH?=
 =?us-ascii?Q?s7cIprUSGelBuqWV3MtYwIKrkIUGreTW8e67eDZm9v07Csz9JgDoGGKAob/N?=
 =?us-ascii?Q?5X6PmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fXw7lisD4QkSp4wbL28iFInl3zV+wzieZXQ1Cc8TeXf0jWJGSCEpI1zBZGKGJVadAyKUfltQIcaS3bTJgZsEt7hg+oRi35uAt8tIST3XXz9d7+Cx37KJh761v6EQj0XMIJz8BOzz/mXdkkpHcRYNjTU5y+LsVGO8WgT064Jj+Zfj3PVgv+TrQINC/PNPNwEM2VAMME5YwsxWVgiIkX1FUER6uNSOP7f0CsjP3DTUZNGQ+KQRzDDiECm2NauH4QPgk3+DXdZ4qaBI6q0VPXQqZv+w/fXybj9ZEZ8Ln0WsjHO3jF3RDtHwz2fTmmxEla2zvox5q0CBgzIfNETna8M0yq6gQ4nRWEntV/pP5SMe+niI/s8qMelZhGKO9mBpO/E2KWOT2Hx+NOLVo+N1Hu5v/s+BsXae/+RHRSlgUYjy3MRrY2TZuAQ5TKGnOlfE5+zE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:19.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac109458-9c4a-4021-f55f-08de5fa7830b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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

add amdgpu_smu_ras_feature_is_enabled to query one feature
is supported or not

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a15670e561b5..142f8351a7cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -624,6 +624,18 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	return ret;
 }
 
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->feature_is_enabled)
+		ret = smu->ppt_funcs->feature_is_enabled(smu, mask);
+
+	return ret;
+}
+
 static int smu_sys_get_pp_table(void *handle,
 				char **table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4d5dfd936ee2..ba8c85f7c90c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1843,6 +1843,8 @@ void amdgpu_smu_phase_det_debugfs_init(struct amdgpu_device *adev);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask);
 #endif
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
-- 
2.34.1

