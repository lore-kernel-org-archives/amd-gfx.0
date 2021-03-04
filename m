Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DCE64E90
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DCE64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E029989483;
	Thu,  4 Mar 2021 06:48:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6E989483
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 06:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1CJVWEFZmX6hZf0LB719xO9KtZjBjD7kLqr2Ldz3nmg0pnFxndmqlQxTxEpubhsdJnztBIDV4BssHyvDOOW8XxnkSumIxGxASUFp43VvdYilnZ565WdNkQjsyT++9wgCLOzKZTNheVQrXkg+DzuynYFjmC+h2y0O07j85sXGiNOCT8ZLiQ8tj2ZAFZe6HscHJjhOK7iG0kukyWs74+IKCIQrV/mA3p1Ju4wMw86/nAcRBkeLnYdgrVMRv33ygI840hq2YORvrBqSAptS6z6qEYvgMG3jlNIoReVMM/8LanbcaIkDK90xTvlL9uUxrR/d1bIZWMh2Ddxis83JtaXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuOQK9LxrcftAQGWeGUJvo4oiKt0Y4+3bLcQwm5miRU=;
 b=ZtIfMpZjpwVFuPPA83+vC/wENbyKO8c8n8n5GSVv1awBF3wiZBMcQCT4BbFUdZkzhSnc2bNTtJWcUgT0/hTM7+YSkx4kKQ/pjEMJYBJz2kdaeMp5ImSDfFYAt0h7uA9CbRMRXrL4D6HwNDL+d1g+lQIVkl0MqDkIc6kbsgzNdbZbw1b29N75sm+YKw4KCs6SBREKV4IrxB9JreVjyzW9IuTL00vq6AVjdK/FEJMBiHRDlLjYPQiTLfHRrc8hjVAEInUyHstJp1DLK3Xw1z3v5VOCS4mZ+7MS6UKym57qzlfG6gMCk4brr6h+v3TqNWS9ELTtKrRS2VHhsjqODIVnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuOQK9LxrcftAQGWeGUJvo4oiKt0Y4+3bLcQwm5miRU=;
 b=PY/JY+8pHRNc3fP2e7hd8KrmYfOx5S9WK74sMY7SEUbDkmSL61Zg7lM3hzoeo9llnlwxH79u8wiyP8glDxit56Dc9agrA84Z3OJRASTj1A/O0w/WhxKjlrv/4zR9uwBBp0zPUOdsmXY2kl7Hvut46Iz67PNpk3kbo7oS2KrRy8M=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 06:48:55 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::ca) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 06:48:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 00:48:53 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 00:48:53 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 4 Mar 2021 00:48:52 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Date: Thu, 4 Mar 2021 14:48:50 +0800
Message-ID: <20210304064850.40488-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb5e76a-9116-4460-a493-08d8ded993f4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38534A11535DED0740897062FE979@MN2PR12MB3853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzUFSclDD7MsMlfyFgDKqUhIkpHUvgt3o85d+HZJuMWgWkNEBKYqyJz60POTyAGZex9zxLcJE/pwv16a/twhpgv5H7/ZfYZ4wdlTEG2JA1EjUZfqaHUaJvsf30AvzmeHNK4mkdCaE8zQzBW2y6eDWlLBdvD6lpjlmcBswvSv4LX3nSxQibxOibhaAn21BmfgeYdFu/CsUwPjA6vTkNDBk6AxHcxpw58nSQNg/XQo/7p2rFFaawcdCAFsMXJaW2lVkEDMg5+JUjTzFXzFE9PETkzBasGeifKqdHPGLew+stVpc/xVCgHbfK9pnm3gGihmX0YivuxpVzAdHnRXp5l2dUn1PqRs1gBmZgDopFWxYp3NX4LLZjNLWy/s0AHpFZRs6cdsNNUSZvL0iABt0w7ptIcG3WlTfiKqFmij4KYliR/rEznxQ/H4vvFbs41v8Ow0CJdiKNzB4iQqVY6Ncs1a0C2tmNdKMV41P5dfomyB9w4PO4qRzp6jriPozoWf8j93DIlZqBdOC6GXTiCrG/3+nTdQw2Y6hojPI+RwaMdAgu0xz80ppc3iJVbqWrAfH43LbledAfS80LIHVAPsdgSIcEw4QSsfVC9ceamkoz61jqDuut7TIWMRfPa/uUs+kF4jEU0icdkwkzrVuAXS1yQ3RNyk+338+MMt46icKZwdvtaEe2wndHjUrLCdwC2SZF5T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(2616005)(81166007)(7696005)(70206006)(70586007)(1076003)(316002)(336012)(5660300002)(2906002)(4326008)(47076005)(83380400001)(26005)(8676002)(86362001)(36860700001)(82310400003)(36756003)(356005)(6916009)(426003)(54906003)(8936002)(186003)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:48:54.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5e76a-9116-4460-a493-08d8ded993f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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
Cc: alexdeucher@gmail.com, Feifei Xu <Feifei.Xu@amd.com>, Lijo.Lazar@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..70d247841d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,22 +2271,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
-		sdma_v4_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
-		sdma_v4_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE);
-		break;
-	default:
-		break;
-	}
+	sdma_v4_0_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	sdma_v4_0_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
