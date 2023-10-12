Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956F2CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285FB10E46F;
	Thu, 12 Oct 2023 09:01:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B333A10E46F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV1muBUojfipCto4HrzKld5fdQhEE0v3KZOoz2rFq08DVdjsRpymV7Qr8SmqyXKqOmXAulHaxiAYE9tHhz6YjeGfpOM632xeAjZZtO3zfoeBF9THnzToEfGBwPIsa1o1dIzX1NAOxIbAAboUlBhuT7QMyaJgjSuZoy6Z5yNI1/HcMGOv19x6+2GcGMhIzFe/F3T9a15B5+Pp/42gkt6AzYlTzu4sjEkZwnINTIuqa32wF7h8wvWDBrVWSjmLBOwALRzAuXjXNW+vhEV2Y2IhO8K4xrpwLGf/E/hUPzrfhHWnm5iJv6XstSia8GY+69yLyvJIUw4bLr/dWm7Z+mv2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb+H7hpkp6G3G/2V/3l6gQlA0W4D/GagTQlnUg0fEBo=;
 b=Vpe9yG3tJUs/2DWyUxJ/simamd+5RaM744JPViRzBCLB9bySzGSDiYghqhLZ/1ns0upVVnikvQ48isN3b21CVuQX8l1A9hgCxnrZhPwZngi+5IABDN8p4//kwDG+6RqlX75bj1ywr8p3c7j5C1Pf8xeWp92whaFyAUwiL0fes4svIOnxgmCfXOGWfCS2j2aJawyxdIB65Jb2tZjgPoHXrFvdg713CJz0SBVGmEbnJTLpOI2FFwmw3Zy3nxTX2ECmYyZv351dqLHynMXlsdEcaHbXQEgZM9in6b2uzzU98G0FLDg1YpijMow6bP9gUP/AQ5PhmUaCJ2Uet2uKyXv3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb+H7hpkp6G3G/2V/3l6gQlA0W4D/GagTQlnUg0fEBo=;
 b=JfQUMb0kJJruNoduGh6Y5dTpZTqpJu5Px0ZDGofZg8/5WtdVnXt1TCTosSrGns08yOnTT3b1UKPMSxADIgrm7BJAxp5MK0U6tZ8fJzPNOVvMh/2LDy5joUPa1q/xebOfvbEdGwGBnOqtZoTP93bvCj+9kuUMGkwHqOs9ygHE2nQ=
Received: from DS7PR03CA0047.namprd03.prod.outlook.com (2603:10b6:5:3b5::22)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:01:15 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::a5) by DS7PR03CA0047.outlook.office365.com
 (2603:10b6:5:3b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 09:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:01:15 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:01:12 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: reuse amdgpu_ras_reset_error_count code
Date: Thu, 12 Oct 2023 17:00:34 +0800
Message-ID: <20231012090034.31055-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231012090034.31055-1-tao.zhou1@amd.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: bc073d98-6b6d-421d-10c6-08dbcb01ca74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+wHQYyOW2lR78wgzklX0kpGs1iwASiBIJ02FRmQhjm9kcGJGa24gzURx+khTicsPqnxSMa7hEZ5HpMdVlGwM2H/szQy1bkZL0XJaVhEQmsB/ow5wOK/qfPFQulFAWMlSYBiHTutoiQFdBgoTMsithONe+mbri8iyrF2W4wdeoncvlJeHVLYi4dZ6pZhrNcyaI+nQS56J6v3JQU2MNNcvyRgTqPZxHsaDOzWbCfYA7Fvg4lVIUKb207VqIggFD3EYTRFXT6UhZxsg3CKqGSWsN5iSJReTQ1wvl/NJwEqh8Q+VdgdXKaSLEw7FzUJw0Vk7VL5DHimJCidK9/Vt1qcL7LRC7/1ZDstr8m4nt9c4BEiJHmN1f5E6CqONfI5BMz7Sh1Vzv4bR9Lv0F4K5UpVvcV6gVbILMSk6R7meA+V1sOGJ5QqGe8dQ7iMiTSz7HK7cxLSYzzKTdosYSJRRud01v0RxiFDSPW1Zsw3yD9Az8mAHej8RJ6r0zh3C/DKvc+JviyFwtOyOMBWr3Fw6W1ZRoYmcCMuSvdUa3VSMbZbs6XJPe587p1BGmdKvS4jvhVanGrwpxHBKIHkQANNIRDwjorTPwayGhLUSj5MiANwkSiek92fm6q/lepk0F2G6cKWwS7F1kbXSBbcx1fUoOytzqnEAxnfw+TxTvSj2yhPYxyjW3RLIFhoMfme1/06/8RYDPJDxBrV8+ZDL221CagDbqQ9BjK2mbOU2cTS2Kkr6bml69Do90vcerTG8PSvC+t4EnHt1bvIODZg8aWBF0I9Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(1076003)(40460700003)(36756003)(40480700001)(86362001)(81166007)(356005)(82740400003)(36860700001)(16526019)(47076005)(426003)(336012)(2906002)(83380400001)(6666004)(7696005)(478600001)(26005)(8936002)(8676002)(4326008)(6636002)(316002)(41300700001)(110136005)(70206006)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:01:15.3973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc073d98-6b6d-421d-10c6-08dbcb01ca74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To simplify the code of amdgpu_ras_reset_error_status without logical
change.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +++++++------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6dddb0423411..3698be299992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1107,17 +1107,20 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
-	if (!block_obj || !block_obj->hw_ops)
-		return 0;
+	if (!block_obj || !block_obj->hw_ops) {
+		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+			     ras_block_str(block));
+		return -EOPNOTSUPP;
+	}
 
 	/* skip ras error reset in gpu reset */
 	if (amdgpu_in_reset(adev) &&
 	    mca_funcs && mca_funcs->mca_set_debug_mode)
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (!amdgpu_ras_is_supported(adev, block) ||
 	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
@@ -1129,25 +1132,9 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
-	if (!block_obj || !block_obj->hw_ops) {
-		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
-			     ras_block_str(block));
+	if (amdgpu_ras_reset_error_count(adev, block) == -EOPNOTSUPP)
 		return 0;
-	}
-
-	/* skip ras error reset in gpu reset */
-	if (amdgpu_in_reset(adev) &&
-	    mca_funcs && mca_funcs->mca_set_debug_mode)
-		return 0;
-
-	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return 0;
-
-	if (block_obj->hw_ops->reset_ras_error_count)
-		block_obj->hw_ops->reset_ras_error_count(adev);
 
 	if ((block == AMDGPU_RAS_BLOCK__GFX) ||
 	    (block == AMDGPU_RAS_BLOCK__MMHUB)) {
-- 
2.35.1

