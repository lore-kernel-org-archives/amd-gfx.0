Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392BDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D5C10E4B6;
	Wed, 14 Dec 2022 22:17:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDF210E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSKoTR8TMl92gFwmMrDr0orX1YDiyx7b3JC/DmFAw+/B1MnR+7a40sgaLscmN3cxFgt1myq4y12EVE2B4njAxEb1c+Pbq+99xoglz6eJEOwlwpYwSh8bysAR4bI0MNm4WVU0r38XAGLNF2XeZq2O+uDsmCPK9rYMNb8G05wBeM9ugcq9xeHv8ASsTSAPGfQ70wGrBqfceZNoZPx5UmZ0eUja6A+DhgpRvtj/oVTNV3duMjEpX3T7NbBJVhKZL6MmBZimTiye4TsExmD3MRGhPZyl6c5eDq8b802zaK0zhTqBmyHwFsZg71Xw91HU9qtW6CyYh7lp8rnoyPE9Qyg91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phNeERq726jxj67Q7gKViaZOo/rTuaCIi3JP1uTGg8c=;
 b=goc5zqZ7QnkLzrp7GI5KJMCTy1hgF+22+LPemO1uPC2fzMe5xjLesrwL84ZNsQxbJBJwBXiCXiE26nOpzNkjz6STOyitfvziYXbIS6YILdNCpc0P7kgp+RPoG50bvMzq6j4wYewhiXTBWZ5eyRahGbdmAPhoM9IKNAKXjyzI800TUx/wnuLI5uLuG3n6UsF6LB2Yl3bhxs+g4mN/LeMoGh1uxJpS//EEkC8OIdWLUA1boRORgQWm2pO9Yat70KKtC5Ca5MycyvVn7kwQWyvA3HEnefJ9/mN9FRbZguQGgs2GwSTHkvVgKeGgR7QFEo1XCLXg3HuVdyy/UiDV47JyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phNeERq726jxj67Q7gKViaZOo/rTuaCIi3JP1uTGg8c=;
 b=u76EkbGBJ36oWmahsD6ZoxZRfJe7782uvlUfeesjmmsxQrz2C29r9G6NOTgW1rMOmeVIcFGORlwZHBAjZh5TUj/u7iRqPXbO4u7Jtyd7yjriX5tMnKFJqYPUHPNzre7GGDDpqWB1T02TgCcaDrvXRadtorifLEVmfQ+/e77N+0Q=
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:17:14 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::2) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] Revert "drm/amdgpu: force exit gfxoff on sdma resume for
 rmb s0ix"
Date: Wed, 14 Dec 2022 17:16:54 -0500
Message-ID: <20221214221654.1625194-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ba42bd-1034-4926-3f15-08dade20f451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWuj0M7Jx0/PrNmWtcMM9OwjbIA8ghCvW/XDR1z4yTFacpzCs2FKtug5tAmlLHKCcG5FSuuQv2ECznplbJLfG36/o13PwRRxJxOhjmTf2h+deRkP7oAXO2y0GrAhVKH/NT/1E/YW0+XGr+HEteDCOCSWa4dX4tvdlxUjYryCwyCwj8F6yPdkayVm/wzyzERYlIpwkbkSK5nc4yAlOwGgynw8aFleXIXWQzBI1LTJL/DYlWp5RcSQWwLIbox45KUjgeR6EMEa47npBnzoZg24MbX/v4l5qDQFx2tEj2R2a5K/UmDm1eKeuqMJQACg2ZP09BsoIQaYF01j0pE5SCnRpdVMMB2UyDfAgckzs+gMzYVwLHgQomhMENaVA4BI9vkWRHarkClTKBatVTLNJ/QFxrsbVMuO3yYj5NZ5Vph3mhF4j8wm4c/CmjCMAfAj8ss3A6RSIHiZqbDcxAsDnGGedu08gxv+80fb+bRLKtsGPvGNZLM1egcQ1f7iO3r+FiPww/gwMiOMncsS7sdi1KGcO+4ymc66qxQ9y2OVW3jT7PNRCFGvTV2DExG8ePmnuyGX1iY2lMP5VF6IZajTMhEjoGYV8c7MzixU+NmvcKGDiS//yUUy4UE7bxGYvY7kc2dZH8M+s+KbNy4ktiKRH4OGVrAGEO6rBpxBhCRe6U/G21N831IxvbdKkyIEz+7b2oSWcfDuuXHFwo5PDJcLd6TajZyV5Dyjs6pI8KCQNyUCIcTfY1a4uWbu33I7H4mcnkTWyc5bcRXdbzNUqRiLs/tg9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(356005)(82740400003)(2906002)(81166007)(36860700001)(5660300002)(86362001)(478600001)(41300700001)(40460700003)(40480700001)(6666004)(70586007)(4326008)(7696005)(8676002)(83380400001)(26005)(426003)(82310400005)(186003)(8936002)(47076005)(316002)(16526019)(1076003)(2616005)(70206006)(336012)(6916009)(36756003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:14.4850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ba42bd-1034-4926-3f15-08dade20f451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

This reverts commit e5d59cfa330523e47cba62a496864acc3948fc27.

This is no longer needed since we no longer suspend SDMA during
S0ix.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 809eca54fc61..65e7a710298d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -809,12 +809,6 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
-	/* TODO: check whether can submit a doorbell request to raise
-	 * a doorbell fence to exit gfxoff.
-	 */
-	if (adev->in_s0ix)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	sdma_v5_2_soft_reset(adev);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
@@ -823,8 +817,6 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
-	if (adev->in_s0ix)
-		amdgpu_gfx_off_ctrl(adev, true);
 	if (r)
 		return r;
 	r = sdma_v5_2_rlc_resume(adev);
-- 
2.38.1

