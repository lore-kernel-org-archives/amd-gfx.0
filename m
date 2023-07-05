Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F93C001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 05:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC5110E0F1;
	Wed,  5 Jul 2023 05:46:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F1C10E0F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 05:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZW2B9ef5dFrDbmIgihe4PFrXTtnizt5LJ9vvQNEkLwDSEHNEDZC7Vf1mNbfKdKmoRBHMRdokf8ZgbcoYcljSyKhr8Y9wrlvUiL8wGMUjYEIu3D1cGgkr8osqb/RumCDVp5KPrp5CURMHtF3UbsH4XiDF22OV6YKQZ0wBhfZ+YCmPlKnY9athZa+QtiqFyhauXnuY/8FDWueSaUs5iv//k6CCHby0hA9R8TaS/gUgpRFT0auNYrg8VT8i/jOjM+5a9/nCc2dl5kDfqiMmHLDkFeYHXlEdYcQVqP7Y8fe81KdqdFBO3FnjbTMvJtae+eeg++gYnh/9vYAbH73em/GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXB39BPkWGq/kAb43KmH0w5jM5yTlwOlKJmSUDEI6uI=;
 b=S1xEJLmmX0r+Chb+O4SHXEkqWbYNdMMs2GlA9HXdnJlb/Wp5GkFB+LLzY1OPIg+22PlOnH+OA2x6aqWZeT14MLYwB1GCDZ4czuD9Ha1TX6RqYvo7qYxQq3FmN8GdzFRkzS9uvbF0PtwueL6Qierhjpa1CH8oFBh4oqdWqN3LOMigpQi7NoWs0Z3jw5b4yGGaNra2C+02D0RArjrcaLYtBz8E8OVmL8GOD6ioZUXqUFjuTZdnYNRQb0HLZ5TZEtAF8kNUswMxUfGaLvnmGu/DjO8wIeUVQsRuSBNF5bTYB8aKMlfVHM3oUCTei1ndVGGK4TGwLRQ7wvvdNfxi931iKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXB39BPkWGq/kAb43KmH0w5jM5yTlwOlKJmSUDEI6uI=;
 b=eRF+79HwJzcSBDa+8GyfFh8xj3kd1zIoUDkBtdTm8mBlSvtYJwZ26GyvpsGbdWypvqkMcN0YT4fqMAG9l6k7VhHmM2OfsKqWqYzMkNLMrCBByg5zKc/xwdo+X6HxXr7OJp8D4QB9WXAFxr+/716wEojo5hqim99ul0VtaSvJcO4=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 05:46:33 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b1) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 05:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 05:46:33 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 00:46:32 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Date: Wed, 5 Jul 2023 13:46:18 +0800
Message-ID: <20230705054618.3674372-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc88262-7c3c-48f1-2235-08db7d1b30a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlswQEM0QpDXm/F/WjYGdAIqN19h/CE80bc1dBQ7JQaAK9WeLUCJ6kE3a6J654ivbjnKK91LHjUoqF2d1PvdxCTn3PvSL/lrw4rhTlu6Pj2F5mHEraBNlvRnETlPUyXqXzKGAAK+F8GxeWRkPTnJejLrPV+uLpeKSXmZhkNlBodZcu4MFBDjxRQjttO0AudQXvR8mmIX8XLsi4DAclvavjMhq2qUdJu6a2jniEh8hK2sDafCyF/6zZgu4Hlarob4iTd4qI2FWVxRMr4ahAnyz2CXTHS/XpkhjTiydI7HmQwMax5I0zo4C9FVw8rpAvjEKlos6+vl6AWMclEjaR1x2bpwT3ONnUdaP9w2IMqDts83XSV3BuZjeyS8lVUGt92ssF1wD3gFWy9etWSQ6Vgg1p08f3Wz0qyJENzCaJDJR3kCRElJjhbFf/98x0elN4AG6775r5ivaMBMUCBEZ0DwEoMnFqnXI7slFYRxbvBVZ7SxPj9gHjKn/1hfPknIfI2Mw4omncMYEPlIx1Te8/qcdLvQgrPR8pmLUqAvcnE3vPyq7atf47+rvAVDcRteX+eWDvoYBLkFJLBzdH3duCULyQC9fyr71WJyHzzql1x0QWxKx5yrkeNVk8BMq/tT0/JZzfnvkdY1XFLBEWJ7O4YMqkXP13eW79YFXium/mv0sB/NnhFkDmkUXI+TgURpeBBmPrzjdIhEo1AerwLOIgtV8bGHh126vpbuNEV/k+1bXjqtJROdUfpFc37UcXsDZxeOMfkDz9yd5XX4e96pB2iiuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(54906003)(40480700001)(7696005)(36756003)(316002)(2906002)(8676002)(8936002)(6916009)(70586007)(4326008)(70206006)(40460700003)(426003)(82740400003)(336012)(6666004)(478600001)(82310400005)(186003)(86362001)(81166007)(2616005)(356005)(26005)(47076005)(83380400001)(36860700001)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:46:33.6371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc88262-7c3c-48f1-2235-08db7d1b30a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
the dceflck sysnode is not aviable on GFX v9.4.3 chip.

v2:
simplify code logic using helper function: amdgpu_device_has_display_hardware().

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ef88a0b1b57..f6724d633e45 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2048,9 +2048,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (gc_ver < IP_VERSION(9, 0, 0) ||
-		    gc_ver == IP_VERSION(9, 4, 1) ||
-		    gc_ver == IP_VERSION(9, 4, 2))
+		if (!amdgpu_device_has_display_hardware(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
-- 
2.34.1

