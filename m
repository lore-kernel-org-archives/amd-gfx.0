Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6428C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49E310E37A;
	Thu, 10 Apr 2025 18:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5YxyR5Lk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB99210E379
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtofQT3kJ/39MFlSFZj2Wpesou1W/LcjJvKD5sdvENwX1ftnI7BdKbb7jLCvoWVuzNfA22rG9mkqKZJftHSMi5cO65PE9MLKY/A1d41QJxFYvoFKk771onvsCyc+SdYGX3hDUQ/OOcqnlsDoQZOb4E+4ZRs/VPPU4cD+p9rNVWzHldEczpZSofuCl6BRIHZ11nV2nCpWW6lmQLn+1yZMPKmwYG+YdSUgIkTXEoznYmglqqCI64Wmzj29elkM57IBariQ+qfPp10gaoDVnJVCOS/0/EtCuFyNLNqyhcCx6Z+HDVBQopTRhMZF7dzGRk+tE6ODwW+r3UpSA7hVkJMSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4sVxzP0UROgLFi7DJayh+sVdxQ0MDZ8k8APuH+a7Yc=;
 b=ffZir7ORp8sjNwgtw2wV4sRjXw6fNiKFFqanAcx39tC2IefNIWzk/Hbexdb8JgRAOMZ0R6YFguIHpJXT7u9Cno6eNoR9w2iDSpBm6ksDgqV9Ybb9yBVow7vkGDlKrhy0gl7s4uouFccmNPRvX0CcvUpcFOLjKnkbmXvkekYJBEaqMWs2NMK1aFtBLUYVtlK1nAs/uXrONsq5yV6Ecf+xLHjljQ99tO+kGMHk1ThYiau31RnE7fksVoDmsiBNllQs0JADjHHocPpPtsjmso+NkvW7H00who2zmYOznaIK3R7ADz1GQ+4FVztjxsB8uz94bPEGZleZ057gDuFIaAnOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4sVxzP0UROgLFi7DJayh+sVdxQ0MDZ8k8APuH+a7Yc=;
 b=5YxyR5LkU11iByRtfMdvka8Q8rOq7IlnWS6QnWMhiY0803h1NZ5W5Wki/bNUbRASMWYeW2QCC+nwdewkBWHg3Us9SyTauouCo2vnD5yJlgXCrlWgbWPbT7go1KT5prHGLIDZkZ2qGcTa2yUWUoOz23YJkHcdQfBOmWp/LR3Z0Xk=
Received: from BN9PR03CA0344.namprd03.prod.outlook.com (2603:10b6:408:f6::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 18:11:57 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::e2) by BN9PR03CA0344.outlook.office365.com
 (2603:10b6:408:f6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/userq: handle system suspend and resume
Date: Thu, 10 Apr 2025 14:11:35 -0400
Message-ID: <20250410181138.2287932-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: bd042ac0-3729-4a7a-7589-08dd785b2e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+I9keA4BDSHXCViqiP9ozvydtOQuYCsArPy9WMgymdeUlt0fNFD0PRrQAToo?=
 =?us-ascii?Q?3qORrUa/PxNthBEwB2syhbf+0lGGcYu1+1Euj9m+QoB6EAbOFF8gDZJSxLuS?=
 =?us-ascii?Q?+nicsy4GwN0jK7XOeifEnXzuAeoqQrOjTMSpDWFwCm/4MMnG4W0Lshd7VOUa?=
 =?us-ascii?Q?h8hhMuWHAcYQl8Yp4KmMqrQmkyrdFKAXfj+MtF7fIIlgMBLyQAGTgSOtUQxG?=
 =?us-ascii?Q?WOF5Bul6xWPxpMKyrej1ToqE4g6uf7uLrTKNCWHsIpz1kgZh5lDfFOADj5BB?=
 =?us-ascii?Q?72fr9eGJIzyj/Fzx6Y5sKSsrZkAoFDiChAV/gzoV+Ypacz4EyN2xiJVgqn3L?=
 =?us-ascii?Q?Ky6g41xI98I1BxDjbsybjz55XrKq6hOQr4YqrJ7YMzYzLuBWc9e4UCyW8P3Q?=
 =?us-ascii?Q?mJLR4wc+Ls8zwu9FIN5tRsjMEvwOgWldFEinMUCYkKDBgLQSrr/zXCSGckPQ?=
 =?us-ascii?Q?Q9wohAGX6d1Xthv2+MCJnA3QwDzBNfl1GZI31//WFmAULZjXNDpvbBW+L6pt?=
 =?us-ascii?Q?7M4XK3MCiaHcKRDDobkcjGoPllOGQAB5yXQE3T1zUNHaZMiss2WpT2Qky3tf?=
 =?us-ascii?Q?5qbgDNTg6TvLNxPzT1Nxs7PNx8JnO7B4OTLPTd5WIS8rNCTwMM2voSe2PmY3?=
 =?us-ascii?Q?hOxKmsq5KyvswzM66fLnYOMcjJsf6xAE0aAeGxSdCqNKmsm4w4up3YH0mDKQ?=
 =?us-ascii?Q?DZavZE/GnUVHpett7+Qdqoc402FoW3b2YfgSj/ak5VhpcE2QUpyp9Zm5ckXl?=
 =?us-ascii?Q?GpIk491ODpTuQBD6iq0vMWP8kYEXCxFXHSySo1QdvNmWOq6whfLcTHVRbJST?=
 =?us-ascii?Q?QC3Ip2qu/yixZBO8Tin1nITPHRck+kwkXDhnVekkOD1HfZRUWrToNP0K9Naq?=
 =?us-ascii?Q?Q9TmeE9sOCmjwPPiDQCRADiTKQMKGkAlGTdUEWV1wQ9WN3bnXlzmlGPlSu3K?=
 =?us-ascii?Q?o6BQliQ55NDlMwfivZnNadVf9JVntxQgpd+WUSI2jbW2zYJrgNxGXwuqAE36?=
 =?us-ascii?Q?TQPAfzEmD/d9Z7gNHNmH7h2PvvP/lWKEgNYMG4mrtBmh7l7j0PLDG0l9gxmt?=
 =?us-ascii?Q?BCDpyEri4n8zFPxmdcxumACYYz1M9NTX0KEjVGVFt7of4GinRSz+BXmFjQYX?=
 =?us-ascii?Q?57PQw5WNDlJevSwFktI+gzZiaNwop3/yOdkK5NfAWLvwBmtLe3o9la8kxVZy?=
 =?us-ascii?Q?5VRZ+euySkDoXuuyOQ8nKW1e9AAtmYcQAB9nrzJUFRfDaZteTJWxDoqYY4qX?=
 =?us-ascii?Q?pmVoCyr8ejTSLYUh102pN2hLE9VlwjPDVSjm3udwRThaOBiTEIRjyy8OvbCB?=
 =?us-ascii?Q?iUz+0SBHyA1jqPnX/pEjASCUjzR9qwwARInYfVG4wYXEPPAVp5L9wyZL5IBo?=
 =?us-ascii?Q?yFdMU2JMmYKeSQ6mFgRodnbAUAn5AmRZgnlR0JduDq0/1nvPBTNG+BqM5Xaa?=
 =?us-ascii?Q?9OOe+zFw5Zol5BpkeHroLtdSIIaY6gddNRm8dBJhxqHxs8b/vfIQki7TsCT3?=
 =?us-ascii?Q?H2OwhWkFRPKVSjo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:57.1440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd042ac0-3729-4a7a-7589-08dd785b2e60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
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

Unmap user queues on suspend and map them on resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6fb234832ff3e..4e1c97a919cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3489,6 +3489,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	amdgpu_userq_suspend(adev);
+#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5057,8 +5060,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix)
+	if (!adev->in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_suspend(adev);
+#endif
+	}
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5125,6 +5132,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		r = amdgpu_userq_resume(adev);
+		if (r)
+			goto exit;
+#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
-- 
2.49.0

