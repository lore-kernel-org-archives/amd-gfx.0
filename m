Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94345C25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 10:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E20710E02C;
	Fri, 27 Oct 2023 10:03:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A3410E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 10:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFF9FSxxqHccIPNLVRoRIu+tKV0qKD+Zjo1e0vD3xT/R+11Wom+nFp5GXhQ3N/zM+GwhjbScY9HmpXhoE+jBoukaEqEoTc+SB2fu0FCBqs5OrqOritNCDofJy57E6BzHRE/bCzXrF3QWs9gS0M5OLNWbyNAJBwO1BtcLaNMCC4qcnYiAl0J8z9Dg5ZUWuNRenqZiAPukw5fEWPMQ4Z/s5iUYYT91+Dt/4pSE7v8ETRquAk/6thPBZC2DUsfmfOT8fmsmnU0/PZSPOh8c0N0M58xpit/JSO7/52bXCBxXKvTFYbpQRgqj/AtHRWT/uAiLPnWiY4Ojk529aM01VFTHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H+hUE+pBTMM27CNyq5oLXBlL2mLVvKaYMFTOBYOL/8=;
 b=YYJWJn5lCOCx7HWdBNCzkibqFCzICD4P55RLd5OEYKC/uRRJ+ka5yC5+7ZAnrmSH8eZZ5g529BjkPxUM3xJvTT+9sBV7k+bVNTzXaYnsRIFqPF/U7xYxRdkEt+5lCfuFtTtLFJBL5AQOq70OPOdeKVNVGDbnTy17Kqx7crZxo+JJj7oA/wW1zRCaYrkr9q/uMTc7OtV7xX6xJzHh8m6gy1VJXBxF9AE1773jiVqYo7lXhoG5jMHcNeva+2AQ+4j3aQ5BlPyeE5P2NTcTEerGc2KYqJIS7dXcG+tpt5uZo5QdQkzRatJmsAYo1+GKxXo4hFp7rnILNb7Pre0zL/caow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H+hUE+pBTMM27CNyq5oLXBlL2mLVvKaYMFTOBYOL/8=;
 b=vgmdNn62vpg1vuXTrZm9dMxgpU/ybhod6WRSyACrhXJEeV+L66Ngl2PJQAXbPAHA1vCJbjbsMfsKdo5hTj5oKhrPPpg+CJ4vYkIvF0Tzc2YsULhZkWOBIa3xLPXaL7YNsUhZFVldkVoCl8TQT+7gg0zme/8M6e/F6FunQRqOz6k=
Received: from BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 10:03:15 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::f6) by BL0PR0102CA0029.outlook.office365.com
 (2603:10b6:207:18::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 10:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 10:03:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 05:02:51 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 27 Oct 2023 05:02:50 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <tao.zhou1@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix check order ras->in_recovery is earlier than
 ras feature
Date: Fri, 27 Oct 2023 18:02:44 +0800
Message-ID: <20231027100244.852452-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 527321ba-c5a3-44d5-f3d5-08dbd6d3efb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQbiTg5yLRvrSv7N3optSHLNF4e8R7etWBtbREWI7ToJPH4m9XRluxX/GZV2/T82k1/hY+ztBOfMMZwGEzzoQqr9LLJFwRJQFWMxF9ieAyk38fjBqpyWV2njv20vHWKklp0wIUyVY6HhDGiTglkSur8/TkkqLXFGpJ/ZvkFx1Dgmhp3/ggq5Mx77q2vmENkjYuJSPFAI/LzjMwgmZgQ5GVCgsTb3TnadjS+a+6uLs5EugkifkSgCm13NBIS56as6kuml5ya+NtjonK3D2vbXpvYRySj29Riy1RCRpnpaqRdD9agySWFe1L4iv48dPX0CDr90mPG3nT7LzNYCki8vBKRRKUVr31wimc9LtOtL4fZmEmaVPqWeOhYv2aSPUsjZWw0F+1FPT7tUbR4r1oMgn/Pma/0DKaje4BTqIeCCj1lqAHWHGV7rgINPncf7EQeZFkt5fNUMGb3IxhUG3OYxFw1+g6h9kKOaaOwvxGPVEm2Ib7fNJKcgmRq2wNUdOw+F4oyRplBOfJjr4d2yi9IPc1XK4mLb5Jos4RyxbBRfvMHMkUkTTcnyTDofc5FCGvD8pNgPSRKDSCDr0bfAe3zWRlqDXxKwUJdhu6orRZjZOwymdRcGUZtHav2MG8ZwJibYQGUMLFRclCIEpKwoBYksFmCbrHUWnSjHbwvbAHTrbWJb3mPbkcqqf0i3BtJazA3Xtqq/sHVvM94z/FstjYZ63O9Qr7ru/AjvtaBjvtOHuma1Z58uxgUUUfxzoH1NbdLi8TK9MssZjWi6ZWnp1SRkew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(478600001)(7696005)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(5660300002)(44832011)(4326008)(8676002)(41300700001)(47076005)(8936002)(110136005)(6636002)(82740400003)(70586007)(36860700001)(316002)(356005)(86362001)(81166007)(36756003)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:03:15.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527321ba-c5a3-44d5-f3d5-08dbd6d3efb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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
Cc: Bob Zhou <bob.zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Checking ras->in_recovery is earlier than ras feature that causes the
below null pointer issue. So update the check order to fix it.

BUG: kernel NULL pointer dereference, address: 00000000000000e8
RIP: 0010:amdgpu_ras_reset_error_count+0xf6/0x190 [amdgpu]
Call Trace:
 <TASK>
 ? show_regs+0x72/0x90
 ? __die+0x25/0x80
 ? page_fault_oops+0x79/0x190
 ? do_user_addr_fault+0x30c/0x640
 ? __wake_up_klogd.part.0+0x40/0x70
 ? exc_page_fault+0x81/0x1b0
 ? asm_exc_page_fault+0x27/0x30
 ? amdgpu_ras_reset_error_count+0xf6/0x190 [amdgpu]
 ? __pfx_gmc_v9_0_late_init+0x10/0x10 [amdgpu]
 gmc_v9_0_late_init+0x97/0xe0 [amdgpu]

Fixes: be5c7eb10406 ("drm/amdgpu: bypass RAS error reset in some conditions")

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 303fbb6a48b6..3af50754800d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1229,15 +1229,15 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 	}
 
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
+		return -EOPNOTSUPP;
+
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
 	    mca_funcs && mca_funcs->mca_set_debug_mode)
 		return -EOPNOTSUPP;
 
-	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return -EOPNOTSUPP;
-
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
 
-- 
2.34.1

