Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B77C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 05:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56E9112A49;
	Tue, 16 Apr 2024 05:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WCAwVXn";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3164112A48
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 05:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvQ9fR/4XsMqin2lp9k+M4aEMUOjmMUSSPZLY2Q/E33+y8sGgFaqO5zAuJgo6/LH2iSDVf4KJ30reqRXWaBU0fbQqrCf/84us4wsybRJ6sXubT2pGE0j6T5u/vYHu/dgYUeA939koXd6UzhwHL6KMI4v47ZDHMmmls+2FE9tN4cYKmQ20Scj4/c8+bZD8IsTxMZGSNCYhU38/FrBgWxoTufd/6a70hh25ekTy9TAIZvkSxfo+eJsfTk3VsXczYHWXwX6GiF3I7XWVetfIRzl2E/KR4xvlysoNCUjw3Q4OHGLaeh/omPCDwKDU0qhHUDI37YbE0jZF2LwSLr2HVnRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KetUrA2k0hGKxvaUb/M+71LW0k+4r8ZSAUiPmH/kmbM=;
 b=nvWo/gQ7WG1hmQVEUbV6caCPjle2b+TcsMTTzR5aLckVS/vlNVFWuDfKSFuS6HwHcRcOWanf4Sl60EdJY86Uy11affrYLPwRvbrDBgA7IldZ/vpLnpECx//QsQ/2+ROaL/0hqPpNpGD91sZuleR32arl0PU6uf/KmdLMRXSSeSO9wnCIZZCtoxaruFWNC53tTZ9EeGhOFJ2UoFczEmrery8F3ugmfIM2c61rwCq/R0FezU24xC5Rn7VIjOIwFx6LVNXWwX/qxBNU+y1A2J1CIz8TE7ZePP4rNxPFfD7whWvWM1SkJ7KY23XyDsrd3N9fd5FqE8QLP0Pmz1flI8XIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KetUrA2k0hGKxvaUb/M+71LW0k+4r8ZSAUiPmH/kmbM=;
 b=5WCAwVXnSlqge4X/TN+iFj1IrIaMkQDh3igcK2QJMuzzM8MRr41ydkeNozfBm/SNmtJBAeffWZtc+Fe9hLUYuuT0Z4LY7MdSaoXDRb5CnDCRDaw+KrPYGWMy8jTVvu0K0oJocZbYWhT6c27vp2Df+yeNfKFGRHijqAHJujzEspE=
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 05:56:08 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::b7) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 05:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 05:56:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 00:56:05 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 00:56:04
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling
Date: Tue, 16 Apr 2024 13:56:02 +0800
Message-ID: <20240416055602.2036-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ceb203-8627-456a-11f6-08dc5dd9e8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ufQ7c4SZHMZTInLwuFIxxCVsFWoERzJv3iYPeemx/3+nIBbr+d8cR9JhutZbl7N8wjTRkWQ8+KYYWw9oX+dlLMFA+OusGZZtsVZ4Q09f82HXHsMHsV8P6jxZ1i6PrwpndoXI5DgmtPTXnEqdXCE8sqxkiAP/dlfINTamx1FZRj0RfgAC+1cIMBuhRaFIoZ9HsP7HXFTdlrgIY6YwjCgDYCAP4So5KSFldLrl4ESonhir8YDZT6soWNa92eThpTi72SeUqLfruwFnC4tJs8jZRscj1pJIMMqn4O29tlG+WPPrz2gLLuyYyyBU0f2xOIid+SVR7a7E8b7dDgrH+6rCBPwV9DBi/cIEF90Cz4xuUjLBUzmVsnmO9yOePorlPi6jBkWQP12RJoH5dmmTJsPD7sbdUs9zEi6cgYXdcWhFQcs0DSwk5iFRiwXFkodJ5ef/UCgt4Kl1e6xGmDdmWyAdQM5lyKEjxO7uw+MFayA8L3PlkcCKvTQJ/JhLx+1TuSEB9ZBep5oLAi5N1SuLqXkAmH3KR52qHs0yoJ6Y9pWop0ixoKAx4+lhsOkuQa3cEEvg/WcZRZS73dj+sc+F+2Q3E2OSgKfeqfnL6YzZLJxkETStafV0rxwZTv4wsgyXK1WAYKjWCH9YHescly2gNfq1cER+k6It6ApJjsPxJ+seoQCdjmzEpzHJdHRGyYqX33RufuaWww+/ZUusQd8DSZueaHIT+7zwHa21nk3Wu56g4ranraDOgQdBD9Q9xRnqVmP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:56:07.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ceb203-8627-456a-11f6-08dc5dd9e8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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

mode-2 reset is the only reliable method that can get
GC/SDMA back when poison is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..94eb2493103ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
 	enum amdgpu_ras_block block = 0;
-	int old_poison, ret = -EINVAL;
+	int old_poison;
 	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE2SH:
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__MMHUB;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -189,18 +185,6 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 
 	kfd_signal_poison_consumed_event(dev, pasid);
 
-	/* resetting queue passes, do page retirement without gpu reset
-	 * resetting queue fails, fallback to gpu reset solution
-	 */
-	if (!ret)
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
-			client_id);
-	else
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
-			client_id);
-
 	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
-- 
2.17.1

