Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CABC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 19:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C4D10E086;
	Mon, 17 Mar 2025 19:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0TdV9Fog";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4020B10E086
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 19:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWRVjrpDFhvxzXRW9y7fJanEHxRPgeLZH2FY3jNXZ7UNWwiBh8wBlraCGGBuJzESS+04EtHeC4CtDGFBwKpVO2N8eQYRkP0d4m4OhqgxnuV48gNzGlohMzXyGywwKnlNOClklzbuBwwwyOV6oTLUd6CWXaSlXFI9Q9qPmJJK5ZDQo7WZ5nQux90oPqxSog5mv2//PFyhKyzjZB7DdyhwQZICTxqVbV6jIlpxY541pUqouYDPy9OwYdeV3YPqQ+JKC3aPWxae5EqsFkeL3mnUjPor2QYn03Rl7OlEr7Ec6D21u0/g/8klj+N03IkinFjeMfmU7+bImGW+9lOOH8LGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QejEN/rQUrtr5RJhUA2uHdrOrvsB39GdE3QbR2Li5U=;
 b=ZbvGf9jzLwMTyft+kWfy9rcpsTwJojnHsKS+l02CEHAv9eLG3zFaVwu8HLLiY9xSpi0l2emu5Xy5evTGJAUvwg3WK74R3fIN9vsAruMWw3SLUeKodYiyYRBqoaIZzabCtmg8jkB2w77hP7z9C2moJoshqtvi5rXIDtWMxQmLdyKJkGERpzYi3M/hHgaTLZVvyIYsQH/6j2pi+ZAnwtMZSKZI38uf2hObP+HQZlwHy0YAXd4DFYvHhjBe1O4FydyS3p9AxjMe7huBUEH/M58eiQlZ7WnEKV/di8ujhYakX6i/8UhLvxpnrB+KsrQIsBw6t6Gej9MgjPTVn1eaJ0cvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QejEN/rQUrtr5RJhUA2uHdrOrvsB39GdE3QbR2Li5U=;
 b=0TdV9FogMntNrjP94HKTqqaAqiLpGThh0l3NM9DzvldbaqqTuRHNToFnzceOhuh/JPehLbNyVuKZGGS02t+8HsHSWKykRxoHRQ7zhm//XlClJfXGWjY8kw7dS35csQDdP46dZ3xFo+zP/KBEm7QknOLYTi6odLZcb8/ST61IviY=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:14:04 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::86) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 19:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 19:14:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 14:14:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <marek.olsak@amd.com>,
 <prike.liang@amd.com>, <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
Date: Mon, 17 Mar 2025 15:13:49 -0400
Message-ID: <20250317191349.942719-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4498554f-de60-484c-8f96-08dd6587e191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FqZCvCK7s4TJUl9/CyPqlXvY6+vRpz4mHbEsnicZM85aSe2jx+XOITES7OI4?=
 =?us-ascii?Q?SCrT1zOX5n3Aml5+uvpILLO2XwR83Ch6AOvZrbAahmT6Q3ju+m3+mVI9Lfyh?=
 =?us-ascii?Q?QlG/bKyORCK7jfkvyM1hcXKANRbtRjUCizu/CqFtFhLaYuIF30RzamtdKIi9?=
 =?us-ascii?Q?AEJGVcR+RvmF5GHfnex+NxokyuhTlK9fia01Qf+F3nXdlsmSljVk/0RiKo60?=
 =?us-ascii?Q?KHxYGQvIbNY3GjoRzn23cDcgo2BK5cAjuQO1YKY584MZDK0oS6LEQYqnmMLN?=
 =?us-ascii?Q?O/uV77DKDkFUJxmZnuTzU9TLN/u8Xxl2sNzv4E8iK8+zYZgLs8dLZ+X/SPzq?=
 =?us-ascii?Q?CqpVJchKRXXVL8Ys7VO0HdXPTvB6VOy4uwTqXqVXDSdISP6/1Ww8c05AYhA4?=
 =?us-ascii?Q?mCJkTPRhPrHFS0f12lpGgsVFxYIESZww/yhVPNaXLwUYthgiyLSHU4f2V+jn?=
 =?us-ascii?Q?yARSIIKqpPrVOOmbCVlVx/Wtr/JbRMKrflRt6ex14EBMTBFnRYpF2UNCwpV1?=
 =?us-ascii?Q?xRQjq5h1CcoNA1HS9T71hAlvNC5rc3IO9Xp2SVE/Wy9yyB4s6T5Qfq0yMzFA?=
 =?us-ascii?Q?CAw6nSyXpNMzpcED/n3B2cmlPyGgjzmxEDSUerJJfEPv23Yl5SjHfG5FZFpm?=
 =?us-ascii?Q?KvTrFmh38r0VRpPK8i1GfJ9sTmUqvHFw0ZeVe0xD2nmcQKYvTvhPbJtvAXTp?=
 =?us-ascii?Q?BCrgtYfeAcuh8ddr/8ltKCK1CVN13kOOpzVlF1j+eheYNwvROCtPD3/qnvnY?=
 =?us-ascii?Q?9LLqBflzC7MURhdgqH5sBhEUPpRvUN5QB28Dc2Gu3ZZnWaTReeqXaIqnWfoL?=
 =?us-ascii?Q?87fs0Knm/eIE8ia2rU6SBgTh4qTT0VZlQ9E8KyxxvtPCpXsggKGAqefi1f68?=
 =?us-ascii?Q?alN2rBdpDrv/dgKOQpuzAPNcR9Fa9O3x1SlGDaLtl+DiKBRr6bxMEsDzEGVk?=
 =?us-ascii?Q?eLsm6SesYUYXTYROjbwGluUmj4flsMkAs6VGtJFKCGzT/WZJp54V1s8YLC95?=
 =?us-ascii?Q?WPLYnlJ5gPigsr3EHVWeAXR8Nh9SRQpODR3XZoLaWapM8j9bnxvHYQU4MpdB?=
 =?us-ascii?Q?d/H3Mi4BETvNT30rvFNCT40vYMSIftWvIdM51o/UVmITJMf9m1ww2gGV6OcZ?=
 =?us-ascii?Q?sjxsHtfWfoVbPsbWuyNpwKfWtZtjN8uSQT3pHizL6kWgxl8wuUGo2ZhoprrF?=
 =?us-ascii?Q?KSM8eVtvkm8AE5UfPTLteNJetIjhPA4HJvEwyPkW4Rf2Zgyk4XOUtlg0tQxT?=
 =?us-ascii?Q?e+Y7AoZuW3fNdvsn7jWIFwto18VcdjwEDfNNqJvfdvFz5ODbCJFKxRxQluJ1?=
 =?us-ascii?Q?1DP8Rxzocd0Jk8Mw7elI8iv10109TmbVarh5uiBKiCJ6NmbuyZODisc3XemO?=
 =?us-ascii?Q?W5IUQ+ts5KBfkLKX1tZCnWAgd/pvJlAwifVIGyjmSdzaRMwcD6iz6XEP9FM6?=
 =?us-ascii?Q?QoLxfFuXG360BdqS0lMMiQCsnGKIUfxpzhp3FkylopNxatFhGG8t0nijyajq?=
 =?us-ascii?Q?dxD8bWai07ByLxE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:14:03.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4498554f-de60-484c-8f96-08dd6587e191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

Add an INFO query to check if user queues are supported.

Cc: marek.olsak@amd.com
Cc: prike.liang@amd.com
Cc: sunil.khatri@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3b7dfd56ccd0e..38b8983f59d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1340,6 +1340,23 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_UQ_SUPPORTED: {
+		struct drm_amdgpu_info_uq_supported uq_supported = {};
+		u32 ip_type = info->query_hw_ip.type;
+
+		switch (ip_type) {
+		case AMDGPU_HW_IP_GFX:
+		case AMDGPU_HW_IP_COMPUTE:
+		case AMDGPU_HW_IP_DMA:
+			if (adev->userq_funcs[ip_type])
+				uq_supported.supported = 1;
+			ret = copy_to_user(out, &uq_supported,
+					   min((size_t)size, sizeof(uq_supported))) ? -EFAULT : 0;
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5dbd9037afe75..b4b6fe006af8e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query if user queues are supported */
+#define AMDGPU_INFO_UQ_SUPPORTED		0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+struct drm_amdgpu_info_uq_supported {
+	/** returns 1 if supported, 0 if not supported */
+	__u32   supported;
+	__u32   pad;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.48.1

