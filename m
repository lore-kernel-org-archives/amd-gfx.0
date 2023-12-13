Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14134C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85ACE10E851;
	Wed, 13 Dec 2023 21:26:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BD110E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvu1uNucjqRxpl4+f8ZM59UX4WNL7kWR/K0oqcJex9Jlyn2TYzhLD6qlwOQOXtvATUhV492BeRnmlXl8tgh7v0xAqbEr+WWQfjqIAxUKAJ5U7jv2SrJ5wf+X9oLZ+SmZY1qYXAZ802voWVZO55HfHhwQ7sjaY9vokaNWgZV864HuAjwRoYH710JbAIGmW3n6bzy0A8CzJHE7qxuLcdTet0O3sUeE4bFEsZvu0JrOg7oufdhEVcIZJf8MXoQpJomizAMJwNPQ7CXruf8JJc4RxJvWq84JioqlUzOf0oerS6uHGy8goV2HfgThjWVD7cPzf2m6LP3VIz0Zf1ECufFNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/DSfk2RZdJjNjg6wVE12PAsDlHvm1/hiBD9lq8DOi4=;
 b=QpuoLIP1yewVMVc04wk85YKdiW/GgqFxNkkFgX9JUOmObXtB/vJqIpSfDaNqYBGTFQt7rn40Qq6bf+kU/49+RNW0gi3URIWlVeO/FsmwS30lPdWiqYoB/mL7iCnrjB+bRy+Gg+R5hyHezzUWGUfjlfKcfAj6+Txg63I12tod3YXIpcrT4pCjR4WNAwuc0+unC2hY/0oVgF78xXSCrEk2oPYw4b60O1nU83q46TbVU9s7eET/GhW5uSpEzGemMTodX5VJ1Y+aakSZsU9b+RTVBonNvSpHbVYWeBTJNVKdjq344rdgPY828Kf6CCmxYq5NTyv363dPZJ/e7FdN8gzj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/DSfk2RZdJjNjg6wVE12PAsDlHvm1/hiBD9lq8DOi4=;
 b=fSxw1yH8PgDc9eRFBmcLPR8nPPK12zTIFsHLqK7JE+Et8fHB3sf1a9ryMPzEwyB/MRNK/PEhJ4UWbEn4S82k9nkJCIb/yPzFzkcnUxnOR1WB7CTfMkuk7IslH8/VJdMuSRV6/t5E8fzcJmjd9LBDao/Hb4ebDxRW5k9GyvwxYBk=
Received: from CY5PR19CA0020.namprd19.prod.outlook.com (2603:10b6:930:15::19)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:26:13 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::a) by CY5PR19CA0020.outlook.office365.com
 (2603:10b6:930:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 21:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:26:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:26:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/atom: make amdgpu_atomfirmware_allocate_fb
 parsing consistent
Date: Wed, 13 Dec 2023 16:25:58 -0500
Message-ID: <20231213212558.1965046-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213212558.1965046-1-alexander.deucher@amd.com>
References: <20231213212558.1965046-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e07cccb-e224-4184-1e42-08dbfc222245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chBiGk3C13Y2wEhZ/j3UqDPS3+zoU1BIcj+c018dHAFMszaTe1zxYrQevDrfXbbH7/ityVVWFlKP+HLv8oE4y6kzu4oFiW0pn/f33hkzmkCM6YIXWztUymfLaEuLxIfothTpha9vCVz1N/Pd+YC6hCGGXxia2sdLxsF3uB+9yFkhacnRI9kjyP1bU00W7vJ/o7eHs86M2la3yqMqBezFS7dLHrdIKIM6qDD+6+J7bnHo+opttzMZV4wiMUQPeT89B3vnflvHHBfTuS5ud6EnggZGyZwivENBau+O3iszm8pGUHEcmhKmu2F7dHACQItb0/yrIkidsUkvoJJf1dh3pWfjTtjJV2dwcsrUTh1Namqy2JcOhj+rXwdWAzxMI/o9dn9WiPFAPzd5qmbgECzPbGg1/pNFXaePP3Ukz/KixDfdTSLrzEEe6JsgoOR1xhBi1T2RVL8N+CcJlzs+PzppMrs1CEpwhdiYKSQcy0Mcu5Pm1745EEOSf5TuI2Ouj0OCGVIni1Q63Ag+9DzeIoALUgYk3F+NccB9Q40n5Yf3JDCeChXBhLdpv8mzEToIJWt59GKYq4xOEvDfqCqn6CrHzYY4NeDeO4ftZHIpO3u6QNqqBcdmPfamLUVq2Be3NEUlPpVeXsiS5/gXR3B5zYG4Qsl3X2nr4Ks6BN8IkSxgQHLU0oZLtQeMdoQT0Ho7HJg6hPUJisL0YsQUEUN8fj/HGRSzRxGYa8+FKd9GIqsWoV+wf1I4mCtc9avcH+PZlzhs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(966005)(356005)(81166007)(36756003)(82740400003)(316002)(86362001)(16526019)(6916009)(2616005)(26005)(36860700001)(70206006)(1076003)(336012)(70586007)(426003)(83380400001)(47076005)(7696005)(6666004)(41300700001)(4326008)(8676002)(8936002)(40480700001)(5660300002)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:26:13.6006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e07cccb-e224-4184-1e42-08dbfc222245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For 2.1, ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION is SR-IOV only.
For 2.2, return usage_bytes properly for the non-SR-IOV case.

Fixes: 4864f2ee9ee2 ("drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2")
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1215802
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 55 ++++++++++---------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index d8393e3f2778..b1c1fafa2d8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -115,18 +115,21 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 			  fw_size,
 			  drv_size);
 
-	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
-		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
-		/* Use the default scratch size */
-		*usage_bytes = 0;
+	if (amdgpu_sriov_vf(adev)) {
+		if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
+		    (u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+			  ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
+			/* Firmware request VRAM reservation for SR-IOV */
+			adev->mman.fw_vram_usage_start_offset = (start_addr &
+								 (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.fw_vram_usage_size = fw_size << 10;
+			/* Use the default scratch size */
+			*usage_bytes = 0;
+		}
 	} else {
 		*usage_bytes = drv_size << 10;
 	}
+
 	return 0;
 }
 
@@ -147,25 +150,27 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 			  drv_start_addr,
 			  drv_size);
 
-	if (amdgpu_sriov_vf(adev) &&
-	    ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
-		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
-	}
+	if (amdgpu_sriov_vf(adev)) {
+		if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+				      ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
+			/* Firmware request VRAM reservation for SR-IOV */
+			adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
+								 (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.fw_vram_usage_size = fw_size << 10;
+		}
 
-	if (amdgpu_sriov_vf(adev) &&
-	    ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
-		/* driver request VRAM reservation for SR-IOV */
-		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.drv_vram_usage_size = drv_size << 10;
+		if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+				       ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
+			/* driver request VRAM reservation for SR-IOV */
+			adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
+								  (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.drv_vram_usage_size = drv_size << 10;
+		}
+		*usage_bytes = 0;
+	} else {
+		*usage_bytes = drv_size << 10;
 	}
 
-	*usage_bytes = 0;
 	return 0;
 }
 
-- 
2.42.0

