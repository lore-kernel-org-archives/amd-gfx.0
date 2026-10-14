Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280DCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0BD10E9D2;
	Wed, 14 Oct 2026 15:06:21 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CE210E9D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg2jDVKhsI8TwkmRebVN1rrSnffolk7zFPGJG3UoCwV2e2fgNkA42/bVSRf/9y4589pSANkXSxkUkGoeReSZnvx0ZINrNuoantRgBSNgUiFPwavOSa9ZSQlI/klV5IISfxtqtloVJU3/TgtGfLPvZij1qRObY+rAI+XJVbTeFp/wShE47omXz6GeB4uZBOGZ4uWDfOW0afefxHBM9GIl+xbUUYZpgFNtrKN/rcGANx1Fyb3tPV7azB9VuvT8fjvsWySOm7ryCJHqUACf9ftxJhQAH7bZjCnfpYUPRhB5W11NsyPrODMf8wxtAwXjiVFpDMYXXp8c0FVfWuuTvFvxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkiL3lH98ssHORJxhvqNMWBYvZFW6ML4fFdEbwZGK0c=;
 b=M2XP/+cjEZT2u4vHdhhKvSlUB/BNZ+glA2AHVxJx3HEDQXUrsau/Sk56Of5Q8KkShFpyRDQOBWlMeW/AVB7KQHyh5i77WOw2WDevNLCKvFMeakUHi39C8G4NJnEqKKSZ2BXYf1PcwYMmc/PsnkLfFZbAf09Lyha+orIgiIcvnzO41P+Lqo2I+9O0kpLFhh8oWsv7atJK/tagEw/29uVoRLcz/t8sdRh4K+syCfU3ZXJPD3d8K99uDtJsc30Q4H3VbTLVAqLzoAkbXF9+UFOfy0EZEtK2jRKzmHP7zu9kMgKbcjl9TFtTh+PhEXaaZbMZF+kOzgtF2tQEs6HopqfcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkiL3lH98ssHORJxhvqNMWBYvZFW6ML4fFdEbwZGK0c=;
 b=KWxLHFtQcfpZu2YHu6jYBZZfj7RWD8iqgD6e1xKRQdIQuw6F3WSzrxHIjhSRznKUtLyPWW9h5ivcW3WjD5mmmw8CB7AZXqFPRjpnEe1PZPgWEplUzqCgNjF10ZWtBGgJydk95X4r6eYnwH/qGH0Znwfgw3dpTT0wqirt7KN6Wwc=
Received: from PH3PEPF000040B0.namprd05.prod.outlook.com (2603:10b6:518:1::5c)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:06:08 +0000
Received: from PH2PEPF00048919.namprd05.prod.outlook.com
 (2a01:111:f403:c95d::3) by PH3PEPF000040B0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 15:06:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH2PEPF00048919.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 14 Oct 2026 15:06:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:06:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:06:01 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 10:06:00 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gmc_v12_0: fix flushing mmhub by pasid
Date: Wed, 14 Oct 2026 11:05:22 -0400
Message-ID: <20261014150521.2766488-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014150521.2766488-2-benjamin.cheng@amd.com>
References: <20261014150521.2766488-2-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048919:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: b7beae2b-cfb8-4a6c-3360-08df2a04ad26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: fo++Cb5MwGZkJFza/9+gS8bSPiEX6UUbB05n+/r6Xm3ICm2seqFvkiTRLYK+Yxue+26utlJeS06t8DURrj7MA6fiLDRwuALqxxutc1sKp8TUZtYlEMGT80UqQhOdlIpsb+mpVSd+jEUEoqqiQasdAheHTOW+2oEiPbIpOzq8MW5ZhOMoJzmLrRvkhnbTCfLjNlmJd40eTBUU6yUUjIBuBxZO0Z9iOXyqijbqf/JGUk2W/+HcueNNgVH2SVqLPEMsrX0ARfIODFoCE8nJzpMkEHuv5YMXjKuQhln24UN645IKhR4fNtzMdK7gf42GdxvXVEo8vAQjbT0hlGphqYUqRnCe+nKe9w8wSOioSz7Rpb+ag/Q7FDJf9H2SFUs2nQnTtWt4sLmdXkOVpKipbcZV75HNWdXUE0SS6VFh3sCpjzM9EgJSWlkkXVwhlTBUOE+LsqfaTymcT9plvvKdx6aeZPmbImIDauTJw1Dtu977E+F1UW6dEWT4pZDXAeQGEK5ZpkYGQs9tyC9oy0VS2QrBJS8lHcFqxMLTh8CrEIk7h0lulI/nIDV7NhGp4BO4CYTpKjSajQntB7XrG+CRpXa4q+x0dJG0Gue9ryFzNOnqXKlqpSJnBik/tVl2xxEwj8+zyjGk29uRx91bKX32cZNMpdQg3R6s+d934MUmrkoZtR4aHHSTJMfz+/sjJzdwPjActc7C04xJ1vkWcSwaVLHgRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G8S1KOBeOqpI4zVV4TvJQrpc0hGpJoUJFENjuWM876BTlUDQ3tE0sqWibj/7ANc8ah6XqaNeKys0tZW8aB6IrT23Z/bQisuRM8cyGWx/SQvbmwsw1B1QSe2Q3wpRoMKJYVhL0H+pxv4V7+sqfKw0y+YDXQMk6HJADQ3CREJgPJyijanU0p4Lc/7nQ8AitOe9Q14NhnrRfiD1Xjh5lb0J8GjTy3IIIEP9sh+3E5GF0ht+HDJ+ww6zUks8i3Q7rUn0Ju0J+l298cHRs86BbjU9IZtNVCBsO+HPdRtgDr2Cfk7edcSidSvUUPRmuFpjsTV+fEHyYsqThx7mGy7DPDE9cdxiXzRF+NuatuhfhQkozZ4LqKHJGB00/9D7rPOHZVVZskwqvZ0M6uqQ/dWae3/d0G/mwjVVeqe4xuVLFMCW9sPkWT65PkY8Sv7R2WGM1zH8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:06:08.2457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7beae2b-cfb8-4a6c-3360-08df2a04ad26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048919.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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

Each vmhub has it's own vmid to pasid mapping, but the code was assuming
that a gfxhub vmid would also apply to mmhub and flushing mmhub using
the gfxhub vmids.

Instead we need to find the vmid mapping for each hub individually and
flush with that.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 47 ++++++++++++++++----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..b6b815d939e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -200,10 +200,25 @@ static bool gmc_v12_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint32_t vmhub, uint8_t vmid,
+					uint16_t *p_pasid)
 {
-	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
+	int reg;
 
+	switch (vmhub) {
+	case AMDGPU_GFXHUB(0):
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT);
+		break;
+	case AMDGPU_MMHUB0(0):
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM);
+		break;
+	default:
+		/* There shouldn't be any other VMHUB. */
+		WARN_ON_ONCE(true);
+		return false;
+	}
+
+	*p_pasid = RREG32(reg + vmid) & 0xffff;
 	return !!(*p_pasid);
 }
 
@@ -351,7 +366,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
-	int vmid, i;
+	int vmid, hub;
 
 	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
 	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
@@ -369,22 +384,20 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		return;
 	}
 
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,
-							      &queried);
-		if (!valid || queried != pasid)
+	for_each_set_bit(hub, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+		if (!all_hub && hub != AMDGPU_GFXHUB(0))
 			continue;
 
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v12_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v12_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
+		for (vmid = 1; vmid < 16; vmid++) {
+			bool valid;
+
+			valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, hub,
+								      vmid,
+								      &queried);
+			if (!valid || queried != pasid)
+				continue;
+
+			gmc_v12_0_flush_gpu_tlb(adev, vmid, hub, flush_type);
 		}
 	}
 }
-- 
2.55.0

