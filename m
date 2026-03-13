Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFA6105F7A8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 13:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE9E10EC13;
	Fri, 13 Mar 2026 13:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPTBvAFy";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EF610EC13
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCGHz1rX4MYpKfcao83GPfyjpkUlDHoyb6jd5XIPNN8tZ5IBsDloXHlT6yjSpBlTQDR9Wk3ge3nhO2s5OsnCwpuANyc5eyk2IE8Qz8aQNFH7R0G+ObTmX/mYN7l/C8lf8GA7D23P1n3VEGnEMW5+8vPGxt4AIAww4kkpSKu/EW5hf56Af7R3r3WA/7S8qSGnKAAcTrDHKqsFXSfE9yDkzSMb/Ar2l9M3mDPuB43HERsvuQZ5oEpu6DRtgzt4shyXKT/WVZ4M6URgS2HgCS++85aeLAs6YMcj/nDrGKcgRcSfNFsFf2XEfMZK+B9i13k1kO8piyAEoDmWSOSmxLOtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR5IMMjernmBPtdqG5plDLVfxg9ARjYTbtbmdqzYSrQ=;
 b=cevFfgr5fuf825l/HFqzHtzT7wIo9z24hCEF28j+wytQEYsMzRkkY7j6xJG8jrfNXFNb/Yar1xvPfZloI2YX3/RZstE0TDMRMvyUQiww4jT3TXBh5YEW64CE4DuGG2A9gimWMQWHe+RrZ7shZvxb4vtcwh5M9XnAKtHMvU//+5KXianQhsQNnI+gH/wCIwBe9teE5yGIb4tMAMPvsq0j9/nw9stl3S8WKqnmGLmTVrwYLTtavekP0mFa6gYdwbZSgvYg6+hKHv9+EGBjnivt45ZEun1rEpZE7KKReDpO/NcQD1CPQFs8idtI07OVZfktkKyVO1VSmyydifq8xKhQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR5IMMjernmBPtdqG5plDLVfxg9ARjYTbtbmdqzYSrQ=;
 b=zPTBvAFyYM9vxEwxk7o0ap6YmK1ffrGIj3laVhMXWN2vKvtihoVWLvM7F2T2aew8hNLUiOXgPVYN1nAEaFoTd3ocN5HIEzihcuXpx+YInnQ551wwavm9Y8KdMSS8/IDQJ0c1p87Dd/p8QafaCDl7HeHe0a/l7nHbZ3A3kGD6UcQ=
Received: from BN0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:408:e5::35)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 13:39:46 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::84) by BN0PR02CA0060.outlook.office365.com
 (2603:10b6:408:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 13:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:39:43 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 13 Mar 2026 08:39:42 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to default discovery offset/size in
 sriov guest
Date: Fri, 13 Mar 2026 21:39:20 +0800
Message-ID: <20260313133920.3442-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b44e2be-78da-4ddb-1bd1-08de8105fc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: L0+0F+wUIUGGwHExU2S9wvv0GY8B2G9bE8lFTjtEVmz96xaDV+ANJVp9E15hB2xhZANPm9BeQtL1yYouE7aHe/WimKPf1uT6IKjCjISI2gz7AwNHl3wwDSszjbZAxy4oitpeH1P/45SkY3uDBXOasWbmyFh9ZCZCK0ISvgvl5nUwdOnMmeBdBQONdDzKZ3W0FRXa/rZMsXLMWVoZRYL/ytxU3VlyeZywv045TuqOqJja18ueXUtKVG+pi8DmvHqfscny7gF0FdRrOZVi3ZqlsN/kHob2i8/KImhsKqrI9gHush6Us8oAUsaiNUfmliWrFwlW0V0tjHTjl8L6bsFS7JqU4HAt8igcAxu0HM7buzNy9Qvul5H/BQdGPr0KXaqofXkRQzB2mvLBLiKjGb51drgkV2ez+mMS1kC8SblCJOXKqdjyQFCepcqMB0q1G0zcny4XjCrK75w1rU8zG4ISHksRCFwkySwHumnUDxTzX3gT0j7mWfyZmvZMSrlOc/cQKeBTLvFLcq5OTvSKTu0KILw5O85dajqmOdE0P8IXb3FlE5kz6+BZIWX13ZJ6HBw3QP14rzBmv5ZYB/9HGmAzdJBM7MPlEIsn/Hw/V1+fCMHVTV6LjaFQ16taOHBJvfwkDESFGgnvItNlaYSIW3H6mUv5ekozJK3L3wWB3yaSw/rx2Emq5y0ITEu/b2rTSAM0R0u7tjH4QdVotFy2PWqOpBttQ3dZmaw2y0aN3dGiGzmVFdqL9d55Q+XBHN1niqaLUJY0Ep69zk9FIt3Vu9iUiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tu0aZy65PymLdRN2n5uWIsf796kYZW5mLIwvv4hT2etF5IH29QMbGzzfZIwUL4HQd1D5pkyKNaf3wvbDGh9G0VcGJa0DhILTS5AozvsGdi8n+B1pE2iEQ109RlOPSrHnyw83XTPwKY7BZ+xIr5YYzyJKhd3DGpl9Ha4WTblcSvG3hhLuj3ctlXl6WZ3dSpntrEwFQnXABmxPUrwDipfsjqLyNS1CNEffP4O7pviZ4wje78ZrvhCP2qqRUPMplCgLF8B9x+92uTznDnlkUm4bmGQUgkzd/re7+4627HTF+LgcIL+rUEuWFamy1sMz4gE0/LYMbYJZLPgoPO/QBOrMGhUUtnq44XqbYo6xRWG4ZaEzvWljbSm2vIMkFeu+k6XbltKFgdnKiyDCO5UK6XRKcABw7bOuXuRv+Bx9O3hD/rOaI3nR26YBo9setXZemQn5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:39:43.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b44e2be-78da-4ddb-1bd1-08de8105fc33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

In SRIOV guest environment, if dynamic critical region
is not enabled, fallback to default discovery offset
and size to ensure proper initialization

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f77a03ea4d90..4e362b7aff8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -296,13 +296,17 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 	if (vram_size)
 		adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
 
-	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
-		adev->discovery.offset =
-			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
-		adev->discovery.size =
-			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
-		if (!adev->discovery.offset || !adev->discovery.size)
-			return -EINVAL;
+	if (amdgpu_sriov_vf(adev)) {
+		if (adev->virt.is_dynamic_crit_regn_enabled) {
+			adev->discovery.offset =
+				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
+			adev->discovery.size =
+				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
+			if (!adev->discovery.offset || !adev->discovery.size)
+				return -EINVAL;
+		} else {
+			goto out;
+		}
 	} else {
 		tmr_size = RREG32(mmDRIVER_SCRATCH_2);
 		if (tmr_size) {
@@ -322,7 +326,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 		}
 	}
-
+out:
 	adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
 	if (!adev->discovery.bin)
 		return -ENOMEM;
-- 
2.17.1

