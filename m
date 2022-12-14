Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9C9C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6911310E4B3;
	Wed, 14 Dec 2022 22:17:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541C710E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMJlLv+O57nJJeeSsr3UgwTBXh/X3tO2wKs9aeSrQ4EEbjmcz9owMKVzx8jlO0BKl4yL8jDeFVhKzPRlPff+itCIaF3BdSJcCVN7NwL0JK8T0KSNUl5c6hAEP3PbBtvKZkz9w1UTvYR1EdDzuKk4tVDQgDpq54IM8k/NDp6iRDFeBoorit/nfaUrH5qwJ6FMUlqLmCxcv4e1ESbE/aJAEBzApopEAujOfk4YICno8otRlI6CPUumRY4dVP0GtDuIF/on9TyLr/q29jXugRzP5b7dvankJ5U9zYHEUjOupgrsm7YxcOCt0r/DmJVKfnZk6ICXS3zQ4Kw6Mh+SqT1ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp72sBhO4PhnEF5VRO20b0Uu5ou/NbbDp0XJhdoP6vw=;
 b=empRY/bihlWfEXSvjR6qYMzGeQiZcKGg8gaX9PvAPD4/MdKoLT7+vmBtq5e3lVzQ+BpP1BzuPQEXC2GRnP2LXZ/VZmJDtkAGvpDfgIwU8STTXFwNbINBIDnQWNJLwLl98F1FEOhvedAjmp5w+X5/KZaJh9eprZhtzRlJwXfTaorbw9P640RWxg0drfasMzCARUUznvIfIh25rFHadwV7eNhwS+gDLUFzuCv/imQ4XRtlZbFTUwSRorErjCkTp9s1xwY4pOwXMAgJxaJDP0p+A6ok7bzkWKBFIE2B5yTREHecqtfS07d92UU9Tl3kq/qmkZSgLifCcq6AKqK3e9IbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp72sBhO4PhnEF5VRO20b0Uu5ou/NbbDp0XJhdoP6vw=;
 b=h6YPwy1eN3CmqxVozVXOBzc4wvvYCFM321v3Ol+7FLw71J1kmL0BWRqB8LrZAFRFl4TT9Np4mEMTgJVumdCp+JLjn1DJDTnLZ8LLVytIabVgRsycs0ioHHDCCC9iPuzq0GmsUFyp9gG6XoLrufgilX3n9gFdyE35gtfgXCzd+h8=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 22:17:12 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ff) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu/gmc10: don't touch gfxhub registers during S0ix
Date: Wed, 14 Dec 2022 17:16:49 -0500
Message-ID: <20221214221654.1625194-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214221654.1625194-1-alexander.deucher@amd.com>
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c252fe-bcd7-46ca-c81e-08dade20f330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18FoisqEWbV2Ce8QxEalR/rfGt+76lpVbf2Fh1pgLfyUrA0iSErvYzBHMBj5JHlcrssMovybWTbUvLLVuZGV1TQqESFXoHhkRba2B8EKIpUY6V4mMzS0a0hhmb7B2jPpwfvqb8942sQ00WNAZVOWT/kjKJXpdzmLzsRSwRGHJbZGb2Kf/TYiaB07Zuq2siJi8qkD/HMUeZg/FDJbKaHQ88PyqDXlVlvg3zVGlvhdCSRP+8kpxhYkwggm/aymtNhogt2IwS54XIkcQiafAKs7AgLHpdeWUyghN9JRLmExuZ8PO0ZMSi0GoyxWlgUokTU6BlQSAXE9u4iQgv/MgcC1qy+ATX2CjLZj/o8s7E5LS22ky8N8W8v1lAsfSScl9/8xIL6O3ePZITL7shiQycW0pShUAy1kpHT1aEgQZsWEB7cf9iLCEvUU/3xZWHn2eOk6XXXnB59CXf+SGQBw6vCpUpq4ynqKoS35lrB6z9TvwTjKnqm1dOiGRKLNqpZGibQq+8f5LMsor7kWYG0H60dg6xrzdJ0XGURB8l29s9Csd5JgtxRzT3V6YyRuQcrT3btSULwcPiwLu22cAjNXd69dX5C+gOheWXjrRnWXg6S9p+prgrBrygddyydVwib5+NmUDVk1xZVvDltRRhhach9xijNGB46EnwVV66IpIfzjcb76VSK71lysTdebu2D0b76uCnMyhBC9/ynMr16TXHdpRinbHDhO2m2Qa8HH7vW+SxiQe4/wGqt96Bggi8gAxZnz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(16526019)(186003)(26005)(8676002)(40480700001)(86362001)(41300700001)(70586007)(478600001)(336012)(2616005)(4326008)(1076003)(70206006)(7696005)(8936002)(426003)(47076005)(2906002)(5660300002)(83380400001)(40460700003)(36860700001)(6666004)(6916009)(316002)(81166007)(82740400003)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:12.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c252fe-bcd7-46ca-c81e-08dade20f330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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

gfxhub registers are part of gfx IP and should not need to be
changed.  Doing so without disabling gfxoff can hang the gfx IP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 21e46817d82d..6b5aa9b55455 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -78,13 +78,15 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
 		break;
 	default:
 		break;
@@ -1061,9 +1063,12 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	}
 
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
-	r = adev->gfxhub.funcs->gart_enable(adev);
-	if (r)
-		return r;
+
+	if (!adev->in_s0ix) {
+		r = adev->gfxhub.funcs->gart_enable(adev);
+		if (r)
+			return r;
+	}
 
 	r = adev->mmhub.funcs->gart_enable(adev);
 	if (r)
@@ -1077,10 +1082,12 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
-	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
+	if (!adev->in_s0ix)
+		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
@@ -1101,7 +1108,7 @@ static int gmc_v10_0_hw_init(void *handle)
 	 * harvestable groups in gc_utcl2 need to be programmed before any GFX block
 	 * register setup within GMC, or else system hang when harvesting SA.
 	 */
-	if (adev->gfxhub.funcs && adev->gfxhub.funcs->utcl2_harvest)
+	if (!adev->in_s0ix && adev->gfxhub.funcs && adev->gfxhub.funcs->utcl2_harvest)
 		adev->gfxhub.funcs->utcl2_harvest(adev);
 
 	r = gmc_v10_0_gart_enable(adev);
@@ -1129,7 +1136,8 @@ static int gmc_v10_0_hw_init(void *handle)
  */
 static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
-	adev->gfxhub.funcs->gart_disable(adev);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
 }
 
-- 
2.38.1

