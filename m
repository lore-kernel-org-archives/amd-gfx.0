Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558C2C7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 01:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA1910E047;
	Thu, 27 Apr 2023 01:26:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8474410E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 01:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLeN1QiE5NefMUGUijGeB11mufXe9+a3IJLTfD2o1oJtMnlNIfohwkfRFXdrQZ6UfovlFpLyb8tvV/EkP0q+m1dZy8w6I6puVjBeTOJeH89ylYUPPQiWnEEkCATNlzm8SYHEoZdIDxp5XMp0EIqeamlsPV/kyZqLJXNi0PynIJgEXBsKz3xzd41RDjnEcUNpleblipYcNRZbXyGnqfhrIgny8gW00m0zMdouqwVE6P+S5vTro36UJSmJfAtUp2ReZoc3adRC+Uo39iVJDvFLGQ/XmFkFleSZIG/xlshWwelk78NJyQe5txS2ZBrUFO4fFr9jAYwoqDn4T2GF6SxS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di+jjoIbQKsFgHW/2EbQbVjGYACCwoqolWa02r7I9c8=;
 b=no8qXia3ydwWcuagjUDBzL8Ytoo7EIdUltvZ+aL4Z0CAvmUf7ynBPx8HY3Witm8nMTjJKkMBTsZFqtKAB+gb/uEIr9mNR4rluq9Vj5K9Wx3zAmqScUiX/jpnhUTg05fzNdpkvlu+/o58KEzZFNrs0EK2fod6WSpvHsnN85Adf75Auxq4s149OU4hfQnzVlvkCkzhz9sJskgPJ3gtm00MGqwpsB3qGyD/rM43NOOi7UF1yNe+weoP3Bm/iTthQV5OoO7v31LTcwhsAX+4wqRCPzpB/DrVUfqeakINU5XbzJmJ3EGEkBc869UE7IANS+/UMZMbVraNi7bIKyPKV6/Cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di+jjoIbQKsFgHW/2EbQbVjGYACCwoqolWa02r7I9c8=;
 b=O1libcT0BA3Ns5tmtg6MUHf8QZ/A2zTrw+kcaxH8WHTmB6dZmwOAkRinqv5uMrnpNHrkyw6qLGoMP6x/1nNGCChT3jUgyJL6v7a4sZwhBijut0wALLVfMeGjSDoaqwdFVCcfOOdwZCfEXzytoC/UslNgMblezYOVjWmcAT2/864=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 01:26:20 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::ea) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 01:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 01:26:20 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 26 Apr 2023 20:26:17 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: mark gfx_v9_4_3_disable_gpa_mode() static
Date: Thu, 27 Apr 2023 09:25:59 +0800
Message-ID: <20230427012559.749630-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: bb59a9dd-037f-48ad-fcba-08db46be6806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX4Ag+lOb0lHI/g90qtSVHLQ4nGIIZxGC+QjTDxCF5SwbcUmvtvoskOZvbgFYkIpCXMuN53j0kEJPCzZF6A2nWnreubKLdO3+cZe2n8UMTUiR/SJgy9VDn4XgQuTvBspbm+DDbBG3WtBsuiC3eV2OjoipqGkK/CZSR666/hfr73wjW42snPSD0Vn4ytqHSnkALKQBh3A6428kppjqRXMDiRr7N3f5BbXnVoC/pn1oyR5ChIxs+Rd6vWBmbWth9I0zeXay7xOpPO7NLyHw8wWmq01qJXZaRosR7qEJsg3LY2KdNroBJG+zpzSUXcug+CZ8tAso/reGMykolK9V7BiUJwGnDMsdMA2dYPPFcYQaSbHuonHSO8r7vmRfOrmeknyz5ptX1b3rZyz6u8j01s2lS+UkDOwlRqMoHIe8QFpIBgd+dAzUrG0fg1SCVWzxHj8jq0bH1pems3rLWuRQvZcYpYKMr1iwf1GPsx7EvSkoexWxZRKcMMEBGwlr3ai0kzXefM0vVov6M2F3UAvE0RWWtuBORe2UKD4knwXn9Bj/UIrFLDRsqKXEw6DMG3Hgc46Pue9gBokwoXodXlaklI/BSdMKwT6xSKTm6x6aFdqwnnB4wIa9kWWEV4dXZETWl142/ys0MDSv4sw/4j3jso1jPks8mC7tVqRGku7AYnqm389uzaJqYwVgUMwahLINFs5TyHdALNs2gKNUQSO5a89IiF1MUBxbLcJ7MDm5tr5PHg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(26005)(1076003)(16526019)(40460700003)(186003)(478600001)(110136005)(54906003)(82310400005)(7696005)(5660300002)(6666004)(8676002)(8936002)(36756003)(2906002)(44832011)(41300700001)(82740400003)(4326008)(6636002)(86362001)(316002)(70586007)(70206006)(81166007)(356005)(40480700001)(2616005)(83380400001)(336012)(426003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:26:20.4669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59a9dd-037f-48ad-fcba-08db46be6806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
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
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was left global by accident, the corresponding functions for other hardware types are already static:

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1072:6: error: no previous prototype for function 'gfx_v9_4_3_disable_gpa_mode' [-Werror,-Wmissing-prototypes]

Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 56a415e151d4..312491455382 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1075,7 +1075,7 @@ static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
+static void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
-- 
2.25.1

