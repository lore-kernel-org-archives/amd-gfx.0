Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CB3C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 12:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36C910EBA6;
	Fri,  1 Mar 2024 12:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HjTqU468";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFF210E855
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 12:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmQ0BB8mtGLwqkCyKcFaglD+G4mSRFbpVU62x35sf46xSQQ15dgDnUH6umJum5Emflf0y7bNp2QP5N9bM4RhgFe1yr79w4n6vasdqPT0ss5C7epPAo6uEnYHGHLoXpEoB40sJHhV2aesYFwYArSIoxFE0X8IWH7twdlx3B1O4Od0W+fy3GoU7OPILoHLxg+MAAbKVfZKAOeXYO0P0mRpMLaeBuiPwZ2cP4Le1zWQ+E1pnsAOJIwbyTRqgWMQ0D3SsQbUYt3rCcnF29eSts5ToS4uEKGMHELkgFqKZlPHEyV2yJYrxRULM1l3vH5eUSV8liGL/h/E1W87C+PrX9rFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA3wiGDouszXvsTMFFKyKgQuCM04mnEdOUNWwIAqK+Y=;
 b=Rk+s07kc665fXNuwPY0tf7iR9mOHt/lxLrjhJ3q/8NU30c8tsxt26oGEo3MltDuwcArizjpXCd6dChZIY5nWKTIX6d17trYepGUvwXiN3K60Dhozm7S+Wfl1fhx87Mh/jj9IXj4fAl1PbV4Nvxu8BHdG4vhI/ug+JeMczK9kVcpS6Q3cZR70JujmsnSC5VVH2x7Ms2ilVy81mGshdEKvq2ePfCF/VaVma/slvrfDNNZ1gVVm2cTBWmLPUCH7BTud18gSUu30PwzBSP5//ukmRc0qOt0ZsTvrf0M+9sRoKuu05pOe0/qD/iHecipL57zpJBRtfsx4aU8D0epc+br8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA3wiGDouszXvsTMFFKyKgQuCM04mnEdOUNWwIAqK+Y=;
 b=HjTqU4688T7BrhwCLJJFUX6r+DZcKyDC1CW4Hs5l/Ya2JOqghD7x+q3Y47QPhHbR50sCFuXs/PTwJjabs0heXOVVIZCZXgz9CALXgqKrAvPi8jvH/dbpEDRDhPRTR8d8qT7OkgcDypyfuVleHA0iY0dWuBA6HQYII+4neNIs1bQ=
Received: from PH0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::34)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Fri, 1 Mar
 2024 12:46:12 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c) by PH0P220CA0020.outlook.office365.com
 (2603:10b6:510:d3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 12:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 12:46:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:46:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Nicolai=20H=C3=A4hnle?=
 <nicolai.haehnle@amd.com>
Subject: [PATCH] drm/amdgpu: Fix potential Spectre vulnerability in
 amdgpu_gfx_parse_disable_cu()
Date: Fri, 1 Mar 2024 18:15:51 +0530
Message-ID: <20240301124551.4038626-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bd9706-4fab-4b65-f728-08dc39ed931a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prX0xHMxgEHGo/yFywgNZd+rDaNJ779EcGHMgLXfJqBLAe/kkCcOvwDSDCXJXvVsk0sTWKstq82lqLbxANaUnvHCyTil+sFtqx+2THtvIlt7MMLYlFJobFCizPDlCshNxcp18oIki5mR+1xEUGrXacqbLqSqtDcxE0DHOIZRmwCAjJ1Gv8d7A+86EPiiC7l7rByTEbDtSnv0DerT7+A8+k+gg72Af4zQCDEf+d5UqeTcbRE32i70XLDmkCPM/tFdDJRi/cdRTE5X5tj7RgdcDYn58ASQVSNtJN4mcQFnY6uvY+TM5usvWzAxS2xVMWg8xDJO9mccXTWOIKYT31+bNsL1PoE2Km6H4999r2nvjudONFrnnpu3dZv31RQXSe36tzM+fI4T37KDu4VU+qFAuHJJRei2vUVFxkM3YmRqxLW3Tqa0fitfYQOKrQ2Y5L+OUfOcaON/aE0ZI0AaWRDrrXX+mVadm8nk3s2BwlMX6382IcuuMcADaUDVZqvjZ72pWtLDuazTE5PmzDGk+Zhr4JFb63Qv2XGyQ1ZxNXAalUqU+b7yyu1r2tx8dSlUfuFCRnAgfM96E37xAsOrK4Xd1Dc+0uMsMX0fEjm6buWnuhuEgPzBykTl4I7dn5dOzLmmiCEd0USGpMk1fn3EHYRj/KWrftARUTWekHihlhMgRZ6nfGusWrW7h+E8XgW0gPifdRSh/kGxqt6lKFV/fyHeCbn8MNDF2Njvmjuo4u1ihDHqhhoiuwgMWsPW9sPWcDLd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:46:11.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd9706-4fab-4b65-f728-08dc39ed931a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

The 'mask' array could be used in a way that would make the code
vulnerable to a Spectre attack. The issue is likely related to the fact
that the 'mask' array is being indexed using values that are derived
from user input (the 'se' and 'sh' variables), which could potentially
be manipulated by an attacker.

The array_index_nospec() function is typically used in these situations
where an array index is derived from user input or other untrusted data.
By sanitizing the index, it helps to ensure that even if an attacker can
influence the index, they cannot use this to read sensitive data from
other parts of the array or memory.

The array indices are now sanitized using the array_index_nospec()
function, which ensures that the index cannot be greater than the size
of the array, helping to mitigate Spectre attacks.

The array_index_nospec() function, takes two parameters: the array index
and the maximum size of the array. It ensures that the array index is
within the bounds of the array, i.e., it is less than the maximum size
of the array.

If the array index is within bounds, the function returns the index. If
the index is out of bounds, the function returns a safe index (usually
0) instead. This prevents out-of-bounds reads that could potentially be
exploited in a speculative execution attack.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:136 amdgpu_gfx_parse_disable_cu() warn: potential spectre issue 'mask' [w]

Fixes: 6f8941a23088 ("drm/amdgpu: add disable_cu parameter")
Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 4835d6d899e7..2ef31dbdbc3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/nospec.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
@@ -132,8 +133,9 @@ void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsign
 		}
 
 		if (se < max_se && sh < max_sh && cu < 16) {
+			unsigned int index = array_index_nospec(se * max_sh + sh, max_se * max_sh);
 			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
-			mask[se * max_sh + sh] |= 1u << cu;
+			mask[index] |= 1u << cu;
 		} else {
 			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
 				  se, sh, cu);
-- 
2.34.1

