Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE5C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D6710E841;
	Wed,  7 May 2025 15:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NmU44XKQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF0710E841
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocuSKx0Wl2p+0XfjYODeTnv5+flraYCi11nFtmT6uJp3e7+eDGfEpjWm1vEdEOpIHipQ7mzkN1t5JgAH/ZgdcgqAsfIXRHTUoD7iPIVo6CZbl6aHQF53FyhBA9c038zY16V3+jzHhEuYTmJ0YYx1fcgcvEhE3fadXW7EDmYStKOctu1SFXrmXISA5jKtJ/ETcsUQPTVmBTRYdgC70/iQPO1ufzLsnW/yuA4EBwjdrXO03e83DpM/SiVCCDUHCSLX0WTrxKsa65UhjnBZqNhAzLPL4OY0L76Ocr3SSFfyvnvJT4WBWvxl3cq2ZOEX9ArhibTmPgQ7xlDiyk0JhkW2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT01XiPJ77AODN8FPfHv2CMl/Wtf3HzMHgILyYyjy50=;
 b=BnImAgDmoxlo9qvJQCQAdemaIIF6w/IH/TRssB+VQvr8+g3kiqEs1VHRAgyTOHh6gcRlKrIwjjuAOm61NNMMW+xu1hVfrNr2Oi28gxgPD3PmYEVLlmmCA4jbGk00kdLAPsTJHI9++ArcdMVCZ641HTOVuOiS0TlymyCFl246RgGZy98IGR+CjTiOKqpkoGflb/CNcttDJFPZLrYu0FIhO6EDP4Yrwkxu5WOFFfuxtk/Jxb/z2w0ruiT2N5OtiE0DR48qnwDppnyFaeqdA/+OpEXNy3PGHeAepVuVTvsF2T7lU3GKMQAh7lQ0EbBE2EIm63EX26wHWIGRzdCyjj/fKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT01XiPJ77AODN8FPfHv2CMl/Wtf3HzMHgILyYyjy50=;
 b=NmU44XKQckPZ0i0vztAXpkD3KR/0OYbbvDyM3LRy4Q6S/kXHGpkm5g61UPDRioYaQB30N6T/F0ZbcvM4QvtJPzRmzbiTNsP2fHJdVuCsRsIj/a5Uj+b5SQySu+nD/9GXm7d+z9zsfdvpnXS3SPgeTOVoi9vfqwTMSPbEZmyFAmo=
Received: from PH7PR17CA0025.namprd17.prod.outlook.com (2603:10b6:510:323::27)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 15:27:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::93) by PH7PR17CA0025.outlook.office365.com
 (2603:10b6:510:323::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 15:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 5/7] drm/amdgpu/hdp6: use memcfg register to post the write
 for HDP flush
Date: Wed, 7 May 2025 11:27:08 -0400
Message-ID: <20250507152710.234881-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 5122859f-2198-432a-fab4-08dd8d7bad61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TkawLLfqC2gADPEx2m52gqqT/dGfUe23LWoW1NxYtFKfdUbWopEN0BnMnRIT?=
 =?us-ascii?Q?g559DA9jMhD6N9UvHBQC8Kf0yGbt0xxhNVzXhF7CrBUguW0R20EyXi+lcROh?=
 =?us-ascii?Q?5ygVn6VistVaA7Q0tLYDrXcmjrydg+Seh0W0zaKm7AUSFgHGc5+nikY6tm28?=
 =?us-ascii?Q?zS5hR5fr1PCOR5ICBYp/SLSdPILCUT+dwVGc8JbOnWOJpamHN/1sr/ZbrIqB?=
 =?us-ascii?Q?DA8tIR7d3/2t/NYeAZ8rM3BYMT7zUCZq1F+GN8Is0Nw7EudgLuQDaEt0oZVp?=
 =?us-ascii?Q?eHcO5+vDqnmm5FnUejVycPVqZ1m4qWqF0sXIVfbv7KNPj++XRLefU6ixZYB7?=
 =?us-ascii?Q?OPdFmxin2T5akz14eVEBElpEW1x/m15toD1azXrXVeI+6JTDxYTBnVluEJAW?=
 =?us-ascii?Q?VaMpgR/d/Al8h8E0wNvjOCW07EcTD2K6o30OhHSg+RDG1i+KQVFvQ5BG95eV?=
 =?us-ascii?Q?KS6muocMBQtFbk4YbJVp53bT05tG3/JCk/V4H5ju3ikA3KtBSqNl+IUi+83Z?=
 =?us-ascii?Q?AS22V97I2jOZRBH8napzGHXIdUzwTyQ7a/AZs3cswx93l679/f5lpq9sVuwX?=
 =?us-ascii?Q?zRIl59x+ibZDqV5jiM0AMup9xr7UjZCdPj1jLnCGPclXQhvdwJPgNqtvoCI1?=
 =?us-ascii?Q?kTPmVEiKjgacCNwicYSCD0DDcIjqg27VTgCMYQspeMwxEON3v9yWkmBEYYLv?=
 =?us-ascii?Q?EKfh01qn94bUiTj8GLVZmD7SLAOBd+mbn0A3ITZ4+q9KpOAWljsejsaGB5nK?=
 =?us-ascii?Q?C5M6VMh5ARU1Hdy5okWNwLN/cdH1/pVUA5V9CNyQWJp8UMOxvptajmhoSZGj?=
 =?us-ascii?Q?uq22YtAsmlPnkOBsZwqRf+FF//8yUWTCRFDQndylGSOkC3RisFP/+UPZ/ED+?=
 =?us-ascii?Q?3qiOabasLBvqNZyHTksETxZL0FjryKEjxcvD7tzbMhABknZRXVEot5j0/6Im?=
 =?us-ascii?Q?U86x+mLtMTyLOu0PDYjdNuNp4cGlVpWH0yB4eA/D+8OY21KijxzSNGHMg1JE?=
 =?us-ascii?Q?y6w5c5mPp610O0Q++pM+g5cLLrr//uLbfsPIXmUpuCMgxpy3KaA7vLnJECjr?=
 =?us-ascii?Q?Y2iE4B9BrZPK6+6eAPNIInuFLscuszektkejpia81OCGlXSuE8SQyShKDmyK?=
 =?us-ascii?Q?iAVJVkRgjhdC3WUwWTsB9/uyKqHQTsIZIJF3r1okMYUBRSGflgFL2AWhlSDg?=
 =?us-ascii?Q?80fgHlXlVhE7k1PIvhE7hnLZC9dmNb55UjnYD5xyXPTKtDB9lKHw147C4tUw?=
 =?us-ascii?Q?N7irVcZk91fR1nm5ULF14MF9+Y+12/fjdRg+LLSGeGwidF0iCtiRf4U7KcSv?=
 =?us-ascii?Q?vv+Nswrl2jOlo8vhJzg34x3GRGLkzVPT1LVt/SJ1AJlSThy6r1UeiKICO9bj?=
 =?us-ascii?Q?WpLdh6kJCUASAXFwmxjorWgKLtkS/9pvmtc8JglP3cD6vUt7XgDGHiBQTqxV?=
 =?us-ascii?Q?6cOWLen1NVNjqseUjVDoGSKkmSUlD3FJIUXFHmjfogNU8kaGrjGrAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:28.5207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5122859f-2198-432a-fab4-08dd8d7bad61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: abe1cbaec6cf ("drm/amdgpu/hdp6.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index a88d25a06c29b..6ccd31c8bc692 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -35,7 +35,12 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

