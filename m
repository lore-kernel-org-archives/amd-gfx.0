Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FCACA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEACD10E6F7;
	Wed, 20 Aug 2025 11:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dJ2sPTO4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23FD10E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/VlE0RiA7+z9Py0NOgNuxK9zqgpC4G7hCWm8MtuMVxydYfNJUAkILfR75TC22HvmQy63upXKTjM49tqbHz6m4D1TEY+Vupo3K4z8tgFx7VDkNIEunVP0RWDCVqPG2Ma+LgsAYPnJC1jpviCwYUBH424SwgeVGWqABlnClYQkBtDBIH9Kqqrc6gzqxvzZXr361q9RRhn6B2HuRkmE6eHc9kYbh5q1/zmXFJI1H8RfKAN7CnqJfIdLwrw9fgdrOULff9n15YnXlXFdSzigGn0Gb9JJdudxhY3gww59ZtG8p9QFkMlH/s5rGaUadIu/krznf3BY097ggdtPYZSAvyKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBL7hdbmceCK89ho6eS9cmLvMhk2zjCvzqjaQueb4rI=;
 b=ykHA21q4jufffIJOtA7iuxPMLoQq+bdS4qXghQGjuNMPKbwTAveXajabomw6mbTD7FLIxSsiV5NSzCeBrjt0pjJNxO6Rc3hi2G6nR9MxUSn7WUt0+4vJr3aHLkvNag0rQqaLpQmqsH4wrAio1MoVQGXMG55H+pDS+05aG8SEZfpy+pf+ktu0jfAUS51vpnRyGmEg6oDlQN28sg3uJKB5/a2TeT9XXA0YHPZGmDR46T0RXHtOLBJ9L2qmplnQzv1hjujJuEcpuGyeUlOKwN7SzHY/3K2zY+MkqiCVCufBe5SZ1WMrTf8TvSsEfg7wzRCzOsWBvG77QEiGfVYEOPvgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBL7hdbmceCK89ho6eS9cmLvMhk2zjCvzqjaQueb4rI=;
 b=dJ2sPTO4MAIkpGS9aS9GHHA41HsC7/l7XAW++kX5x+X7DmpMtpKF7ZKiX3L/aP1LtjYde45qVaBHrW22NiQRLGaZ8lSY33uV+MEUUZF+2kJDNb/bGs30rH7tQJ4QdDaKGZvcuYsrEBRO7zTBPpsmc9OyoqvX5VoLwBJc2G0iEjw=
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:33:24 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::47) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 1/7] drm/amdgpu/uapi: add AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Wed, 20 Aug 2025 17:02:48 +0530
Message-ID: <20250820113254.3864753-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 35401381-dcee-4749-c389-08dddfdd5fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjJrMG1RK1FteENvMVZ2dWVVdW1zMjMxVDJVLyt2TStKN1lQY1JmSUdrQkdN?=
 =?utf-8?B?L2YvMk1RM1B3ZzFzVDBwYm93M0hCbVNzUU9zYTc4MEROdW9kZDNjYjZvK3dX?=
 =?utf-8?B?Rk9pazQ4QlpWSDlKTkRCVEx2ckMrZUUwMWlQSkpxVEtvY3lPVXhKUWIyN1pC?=
 =?utf-8?B?Rk15WmwyalJBbk4wKzRkZUNaYzYxVkR5T01qRUJtelZSdFhlK3R2MmN4RTE4?=
 =?utf-8?B?MFlNSlFSNFpsQmh2eEZJejd3VW1zbWllaXJiL081NG9OK2U1d3VYbE5kSHZ0?=
 =?utf-8?B?WjlXanltbmRVUjBXaStBYWVlUkxJdXBwUU1mZ3NVSVIwbE9QMTRqdEJlM3FY?=
 =?utf-8?B?RHA5eG84c2RReU5wa1BJOW0ySkp0M3J1Z1g5WnJNT3pDejBNZ044NlphczdD?=
 =?utf-8?B?cWVNeXVDbkdPQ1BDY3NpMTdJbkJKOHplaUNhVWdkM2pIZVN0VFNjWkNnSnFp?=
 =?utf-8?B?T3o4dGZ2anlpL1dWTUhqRGpyMmNuQ2FZazgvcVQ3TCtwRzNhM3ZyaWt6WjdN?=
 =?utf-8?B?Mm5aSjNBbE1DWmkxU0p2NlA5UXJvdnJZSmVHeVk0SjFwZDdGSFdvSlAyck1o?=
 =?utf-8?B?ajMzaWNUQlB4RmRFVHN3em9TdWlsS3dONjlobEdsL05jWnpDa0xjT3RzS1lF?=
 =?utf-8?B?TDExOFJJM3lHK3E5NkNVRWx4VVphV1dSZGtVYjNEdlNHcE1qYjVJUDFyQVVT?=
 =?utf-8?B?WjRBWllhSHdQOUd5RkdvS09JaytjTy8yKzM1TnVKYTVKZVlhcDAveWdWMi9Z?=
 =?utf-8?B?MVRVU05aSGxhdXMyTnFiN2wwMWM4dkk3MVZnWUxNclBLSGZKUnljM3cvWmhD?=
 =?utf-8?B?b0N1U0d5d3RyMG1RdVI3Y2M1Z3VHbEo5ekFjUFVFekN1VXNzUUY0a0I5VGdl?=
 =?utf-8?B?ZHZGV3J5cFdFdzJOMUxpdHNaYlpUQVkvb3YzOUYxSktNdGplNnpLV1A1Mk5a?=
 =?utf-8?B?RzcyTWZib2owcGtLU3BHM1VtdFdGSUNGdW9ZT3FBR0NXVlNWRXo2YktxYmJX?=
 =?utf-8?B?cGd4Uk9DTlAyem82RVovbGJKK1FaQ1NmN2JqRzh4Umt0SDdSZUEyQXpNbTR2?=
 =?utf-8?B?bEJLVDIxbnNwWU1wckJhc3dteHpUODNzMTBEU2RrUXpKWTFlWEVCd0hCZlZj?=
 =?utf-8?B?YWRIM3I2OStUb1FkdEpCcHliZDdhY1VPMkpqUklZbERIZTlmS1lHbWU5U3g0?=
 =?utf-8?B?TEdxQWZQVi9kR1Y2UHJSZXZ2MlVSbGRBcnh3cXpTanlMSUR1dGlqeXdtYWVJ?=
 =?utf-8?B?bGdkZDJhd1VlT0d5djlRcS9pQ29SaFhBN3p4Mk56aExvZlFuZ3FqeDdKUlJF?=
 =?utf-8?B?QUxGRFFmYkRLVTlhbndTeld4UTRkZnBxZEVtVndYTENwaDlBYUFkeUdJcmtU?=
 =?utf-8?B?WmNYNnZ6ODdtOGZIcHR3Z1FyTS8zWS9qNnZaNDVHdkI4cks1YUxTZHdEKzJY?=
 =?utf-8?B?b2ErNll4MTB5MGZ4Nmx2RVBXbEVPRThWQWdORXRTK0RTTTJLTjNtWlkyWWVP?=
 =?utf-8?B?MHhBdExhakJLOTF5bzR2QjJSRXEyRFpZcG5EK1dzS3pQeFZMKzRoOWRFcy92?=
 =?utf-8?B?UTU4Q0lzOVhON2l1NlZmMy9tYWNQN1V6STVKa1RTYnNENkJmemNmY3RiT1p3?=
 =?utf-8?B?TzZwVlFmWlBOSjgwcEQzc3FDUmV6aWVzS01od1BoSWJMU1J1MDZTK2lrdmlp?=
 =?utf-8?B?WTNlZnVtMCtaWEU2Y0twM0tvZXVmYWVQM2xFcUdOeTRmT2RpYlVHSXlQMm5n?=
 =?utf-8?B?MXpvSWk4a25rQ0ZLWC9SZGVEZnRoWDZzWGVDUW9HVUQ3NmIvb1IvVVhWS2Vh?=
 =?utf-8?B?NDh5c2VaSGhHd0ZLWVhjVXMyR0lYYTVPTEJIUndhelF4T0Zad3psVVp4dGZv?=
 =?utf-8?B?Nm9iSCtzOGVVTm01MnFwdjg1cWJuUUkxczBVVG00dTYyV1JQUzNSTmtEQ21U?=
 =?utf-8?B?SVBxZUJ4Z3FZNm42cWE4NHVjc3lxd2hDVVpZQU9jdzlvOURkVWMvWmhwNElW?=
 =?utf-8?B?MzNKeDAyNnk4OEpWMklXTEVnN25JczcrL0ZyVUoveXU2SjBHbmx3blo1bzJr?=
 =?utf-8?Q?6ftn9z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:24.1201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35401381-dcee-4749-c389-08dddfdd5fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.

- include/uapi/drm/amdgpu_drm.h:
  * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
  * include the bit in AMDGPU_GEM_DOMAIN_MASK

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..fc44e301adbb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -103,6 +103,8 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
+ *
+ * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -111,13 +113,15 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA | \
-					 AMDGPU_GEM_DOMAIN_DOORBELL)
+					 AMDGPU_GEM_DOMAIN_OA |	\
+					 AMDGPU_GEM_DOMAIN_DOORBELL | \
+					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

