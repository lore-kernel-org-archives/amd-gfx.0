Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF1C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBA410EFD0;
	Wed,  2 Sep 2026 05:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQu10Bva";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7E410EFD0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQf7l1OX3tHyI60nPEx4QR7ln+RiAj9e5Omwzj9eb9lheX/I2aAkg7fR6geNbgg8o5LH0dzRlQSCPQJgBgOhKHF7BgOaWQS7LGvVVfSc0NVeqWLAGfd0D5+4parqJo/P2EzfBaeDDVwWNgGNGoiOkf1Ncweuig37me6FRtDN/l6179xeuL9hLbxzL7wbsnafK6Up9eJ/+qNTBTv8zQ2T/Ct41gCK8eMEpZjPLjDoq1WMF9wn58ixvKUKjM+ofpPscHG+MEqYGk4adDZMPkt0kz2WGPle3I9Is6Mi+vc1KLCyMsDjWocrIJJqqnX10tEEGSx2P83vR4MoSrSCCfGfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25wlo7vkE1IGyNWRc6hJExViUNPoGBV7swcUMPdDXrI=;
 b=W2zQ1hATJNGIQalv+l8aHzUUdDzbOQTH2PDWjJ6+kZgj+uIkO0DDVcr0sX1tqRzxFwI1d5a8cWkbYA5n5Ro5x6Iyyu4OIFaFCzYLoiq65k5Po+BE0iqrjgLwd8d/2HiQ4aEi/JXb0PC060OQgOi0c6O2uWTt5mJ16dnSWvgq2AwNQvR5u7Mp/52vBQJUVqI5R2uKE7y+fmQlDTl7tzsVrUsC664Gg83GPHHpfMRfsML3FZkrEPCRlqS4RbAM545aQVXEvV3o7Az2xxtRAjNi/iK4GXr5sjOnRXwQxpqguhfc6FTr2cQu/KndMtURIPxvfWdpoTHL4+f7Nx7f4IYf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25wlo7vkE1IGyNWRc6hJExViUNPoGBV7swcUMPdDXrI=;
 b=DQu10BvavBzNdT0QNqA2gRBHy0snNoLC7R3on4U5l749jWnkyTKR98or5pnz0p0eiPBQOXq6GaR0WwJEN/SsWthlaybyLVPA2r9zRx3cXzKO9Kt0Ha12n9ReSC6dFZUZk9+IxeCDZr3TfNmhqeQpDkQFJeQW+GfXYc/OL+4NKXw=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:07:41 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::31) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 2
 Sep 2026 05:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:40 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:31 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <austin.zheng@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 22/40] drm/amd/display: Fix unused params in flip sched
Date: Wed, 2 Sep 2026 12:58:44 +0800
Message-ID: <20260902050411.3473916-23-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee9a7e4-0808-441d-47a3-08df08b01d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4kv8ngPdgKoXNZVc4ygW4me/zvL3Ailg64+l7VFkipOtgk+kfTrrsxaxMZCL2VhKj0Jyy4NnVSgnFH6eaHQ2KvYHFOmqYLJ3F0blDC8kGGb8oj9ja3ETNoRCrZZEaS5P0PaCWwFj5G1JaJEeW82ICUKaHMugEFODFHFAVygnEy6Ajai18ethlHJCWBmTgS9aCmqUvajm1oLaWi+NxNA9XuztEPpFPW2UU6XkSL/Vt+ouYiMoTsdiKNp2voe7IJ5t98F8SMtNYEwt7rVxYW4X4Gk5DCpI9wrSEWkA5FpXwSlJWRYm9Tcu8C/R6OX/E0xlMF00MzevXePluQrkBAQUjI/kGIuVQzGO27+VQmZRCdtyq+FCRVtCBSlg+0uCTOUWE3StrxUoH8NGstNoGuPOLzNaCCwrOYY7MWHM6I4uxuwAuD/riz4RiEVQ7CgMbrI1e0YGs43t1G9rDB4oiNdjm95H9OvUzVF9zo3wfdB4YL+FkO1FcWaCGH787FddvHHJ8Acx9CaO8IbNGIHpuP5ASQ2t7MpwYSUTMRz3pJArsRCMeKtD5Fww+nIylQbT9GR5GTI7ikfq7JnRcKkw7pRnHw3+DjjYx3A8OaqI8UyFQ0SFjG2UNsX9Nlp2pMmOA69lsnuINV178lGxl+Jm0ictiQPGgNFjnjp6QZzLk4Ikph3Xk/kQmxpZbAugMOwR8C+/ypi8d7I695iS/JBmll79+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z8utAxMoVXfVWR4CvBqgUjZkrNjje1BScTlhH74U4FKbwDAsowAYpEhfntVqPFiBNdY5Ehur4hA9U3V5jtx/pEGjzhbrqT/KUk4ij28y8kIh3gX5a0PGthWqqrK+zXv5QzQaCGQJITvNQ2UlBO4cwdz12P3F7JnktmJAnYZ0/vQBlPq/XaPEgb4NbwEX8FJzGuMzJS3JQ7OVIP6ltflhYi67WoaZa5gnv7kAOWyGpefTOlg6aDjzNuVDd+LLPboAaC0NqP6in+2hPxbkCCXXf/6ZfzsWcxmGlGz/QIStP271XYiPWtqevuYQ7AV/NqsIpdq6yitdWA8U5Oju7T05tg2iXFpQ5tOteI28psOtIXJa8HgV01KsTLAegXbB7QZ/Sx6CWXNEMXodHd90vDUbTEMSJnVwq3Sf+bHODrxc1KDVJYH/vAWBwisUh2ZngK00
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:40.6815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee9a7e4-0808-441d-47a3-08df08b01d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
dcn6_calculate_flip_schedule() no longer uses meta_row_height and
meta_row_height_chroma in any of its calculations, so both parameters
are flagged as unreferenced by compilers with stricter warning levels.

Cast both to void to document that they are intentionally unused. The
parameters are kept because the signature is fixed by the
shared function pointer.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index 125ad095c2bb..78bdf11d0d46 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -592,6 +592,8 @@ void dcn6_calculate_flip_schedule(
 	double *final_flip_bw,
 	bool *ImmediateFlipSupportedForPipe)
 {
+	(void)meta_row_height;
+	(void)meta_row_height_chroma;
 	struct dml2_core_shared_CalculateFlipSchedule_locals *l = &s->CalculateFlipSchedule_locals;
 
 	l->dual_plane = dml2_core_utils_is_420(SourcePixelFormat) || dml2_core_utils_is_422_planar(SourcePixelFormat) || SourcePixelFormat == dml2_rgbe_alpha;
-- 
2.43.0

