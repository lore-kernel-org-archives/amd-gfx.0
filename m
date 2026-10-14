Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E368DCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDD910E96B;
	Wed, 14 Oct 2026 15:06:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED68E10E96B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCnc6ELSE/fKD7COLVmiHUKqFRuTwpdp8jYkcygtVs2E2o650O8x7wMWceMAeKkFP8q4ohGcc7OUVsqPYDlJu5ZsWrlCi8IEd7PTQYkNrxowgfQayTdJqqeFpXWUxlBAeC9al+JXb1yUl1RhrspprIAfKi8kumpuM8N2730uWXFSQMasIR5jh9dcvhF5YhAAf1sDLkmbL4OdjVCeSwCgLi2UyGb0zJBkSqtfJx4RopVUqAzp+qyPkdov8U8hwTpDEVRW1EBcK4mh94FxMcW/gjdRHnRUAueSWzZorztMSss7KSM7WdiRcbHz3RGeo2AKxIXzHf/4IQSnLd9fmnodJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfcg0BUh4PaR58IGP/1Lf38STFghklmTXFyQOOAGjd4=;
 b=ZsTlmSXqU1GXFgtf8sy76UGyIPX9Ga407FEHCqUPtCURP7HvApTJpVYFAfRjwF3b//2yQKRLgR600OQEoAPUogARbBBny9q3Yh9xvNsnAayJii7CWzWJO6HAISAGl+vHLpYhdD2+7QH/BxLpbIqA9IMPI0z8hhQsPPTusX/iaxNFxDRmONvFM2PrdpvFTFsmHOH0MtzDg8zDmltWMA+ZjasQiF6QlSqn6ZiqH5F5tUOxeh5u5szqDpHhT9ga5JkKagDbXBALSD1Ys4teikvaefOe1bPZCJtStV7CYwOsuol8Yde09h0GcdVQBrODhnXOnQwcFeR1Y25IX12KLcWHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfcg0BUh4PaR58IGP/1Lf38STFghklmTXFyQOOAGjd4=;
 b=PbPnDgdc/S1TGulS6qGIshBtyQqT3W1mZ/mY0LIDMOmwBEADZFdBxhTvGc1mvXOvq41yBEPVJERrf65NsRYW8NkREvHege4/BXWZH3ZGZVBY0F5BaKvxdSuLyGtnwGEjufLT5hx5NDuNo/QDZgTzqPHvyspBs8AkjPH2c7JakpU=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Wed, 14 Oct
 2026 15:06:06 +0000
Received: from PH2PEPF00048918.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::20) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 15:06:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH2PEPF00048918.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 14 Oct 2026 15:06:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:05:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:05:57 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 10:05:57 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gmc_v11_0: fix flushing mmhub by pasid
Date: Wed, 14 Oct 2026 11:05:21 -0400
Message-ID: <20261014150521.2766488-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048918:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 35630018-1aaa-49b7-9ee6-08df2a04aaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|56012099006|11063799006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4p0cFK/WrOxG35Wtxg3e7UUjLTgWjPoqM5P3RufKreAxs+BDIQ44axkZDfA/jxc6tMdnqCqCDvUAhcby0scvMxc2VzauZx6ULQF7jII1kXun8e5tnTNhw3cIvMB/e9V1s8EWxZ/Fab8Rf5UgX3g3d+UA++9h+yP5e6dO0Wn/qku2NJTAjN+46+++brW5NlNKQboWzRqWSJmANAcZidoKP0Bf2QpHD3LWbKSV7013/t7TT2TPURdS9EKVy6fryaUoesCXa8d5Q7g+x85B2DPl+AGXRrO2/Df0AxFYC7Ah6I138EOlSyLQejBlNn8W+/jgjmIFmQcD2ZZqwOljekv0uMPubWnBpNbffytAGZPCEv3oRvRM4nXzGEyTZpjcBDKv3OO2jcBjioOopMd7zOj6qOh/y2REsRLZOKEx2e7qK+r55bsxjiaKdGpqY4Q6IFEId8x6fnMzd8jQeRRgOgC1k8wuysh7v+KPul4p/HTuiQaNjTWaKKjVNZzMI3rrjBrVBXUtnVr0xQLjOy4lUN9TRtEtWFiVpErhdZOlCo3t3reCtR7v/CR4af/ZtOA+5rPCfu12TmzHRQBwwRt2mFmB4qjiFpfv2cB/yXv69F3fNRn6dKIY/CY3qBeWsJmiK6Fw++s+yGA79dZNhx43gYOrpWELkPwsgfZFLbq80TtoSE8pQxLC7oPlcvYJzLbI3edATFlCQImWCJA+nuaBuTaIcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SbJcIBy+uBJeUYvqng9hqlF3irSXhWXsMCSgasfdlP5cet5IDLJRKZW7/G/lR1gwhVvijjdUKbemuHXA3CVU5xNhsR/b68G/l2ZAdbv2+1Qqs6dZapU5Pvs7SwYqVD9Z3MnTj1nVWM302sS4qdTfLlC3/1G7O2NCR3to10KdwYFgCYyvELV5D75ikm51yNOnU5fAOEBKrtW0jWG6hmYBNXaEDgPsF7EW4oIoyUMHCnSGvcCTASbpHG1OawmMPEjM49ulTMNFaJy0pAggBLkC2gA3OIaPb2Dwwzm/zJ7JY5K1XDcX3mS7gBxAhTAtP6RaLA9Bx/bUAHv/q53uM3SAFZLGOMZnqK6XQ/MQHQj7e4pNPOq3U3aoVn0x2bkjk/xP7jyYKqrzUCYm92j3N9iIM3VD6GXruoHJP9Q0lmBN4k6jIOgEyWySGXSYTRwagh16
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:06:04.5304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35630018-1aaa-49b7-9ee6-08df2a04aaef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048918.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 47 ++++++++++++++++----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 709c3d1b9998..715ccce8e4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -204,10 +204,25 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v11_0_get_vmid_pasid_mapping_info(
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
 
@@ -330,24 +345,22 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
-	int vmid, i;
+	int vmid, hub;
 
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
-							      &queried);
-		if (!valid || queried != pasid)
+	for_each_set_bit(hub, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+		if (!all_hub && hub != AMDGPU_GFXHUB(0))
 			continue;
 
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
+		for (vmid = 1; vmid < 16; vmid++) {
+			bool valid;
+
+			valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, hub,
+								      vmid,
+								      &queried);
+			if (!valid || queried != pasid)
+				continue;
+
+			gmc_v11_0_flush_gpu_tlb(adev, vmid, hub, flush_type);
 		}
 	}
 }
-- 
2.55.0

