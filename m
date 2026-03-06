Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65F8F33A92
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 14:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7482C10E2DA;
	Fri,  6 Mar 2026 14:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/tMbnwg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7B010E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 14:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP2p4KBXz92pxg6VHAEfVaEgkjai2hPWs+vvmHCrPgyuQA2OLQnkhI51E37yJS39QZzKP7a8thOX8Mk2xfGVyIyuj9aKo+RIam6+f1q9WNrb2bOfvI8JG/Fdx3gfJcgR3sm/Z2lB3SMz+1tFi9MkeF1OCLsVc5roPqLjzgdZ1dD5vUFE95/4PErrvMINRWRnuxk6dDFNjG1P06NrPWcLqAjZP5FECDaILZRiePPj3g6U02wrrNSy4eubyHCLnzqk9pE+2uFl1FQVRtLW4mD/RAqaAPHNoodXNHneIDvaiXUwqCS+/+OifuELFFt/PD6pNV034UkfO1x9xf0ud+5ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUQXeplssLwhHR3Vvoxlv3TlTs7mwT68UeYNpy82/hI=;
 b=h0OIIlB5m5Rvlw4K7y5luiuRpmPiXrAOIOUao9zQSXlu+ZHlTPsFcd4kL3Th4OdW59xp/PHfcWODKzRDGGkNvIlr+qmyKKTk/sjxhIwA4npFUeqfhxGOEZQMYwA86PTAafmohpp7k7+sz3awg/AKGtMDsvCleOn+NCHRtsjRRBWaLIP49gb0gR5i3drt9YD/eEnZEgRxJD4LzsEl1vzexlVVYdGS2WuLRDbQm0iVid1ED9bPN6h1dFAPJbEVGq32kCY3H5pWPwZGT/nPIhbXDFCSm1jN2iVF1+rQfnB2Bs0dGihlmlUxCSaMsOyGlv7tKijAJ+7rF1HhVeCtsdz6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUQXeplssLwhHR3Vvoxlv3TlTs7mwT68UeYNpy82/hI=;
 b=h/tMbnwg3ON0iDsiBnfHey0LIsKOabVirkCQ+EIzlMH9KigTV2p5V/tgu2EVoDO4x+tu6riF9iCkBYLD0BhQkxw5cCkm7bL5xFVreE0/nqdXEhEJSm7rUAKcxr/w6GxUEqqAlsJRvcQSC/U4AfrVohLoYA4dJDEvZrzcmhikUdE=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 14:28:10 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b6) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 14:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 14:28:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 08:28:08 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 08:28:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/radeon: apply state adjust rules to some additional
 HAINAN vairants
Date: Fri, 6 Mar 2026 09:28:01 -0500
Message-ID: <20260306142801.3914073-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306142801.3914073-1-alexander.deucher@amd.com>
References: <20260306142801.3914073-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b83afbf-174d-4c6a-1048-08de7b8c9722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: KPNiIN3RV20ta0SXSV7/zIzPswuxtgO6U9BD3Uu4p/B1g1Ua6naoXSfabZdc9tz1nNuYp/HSrYEh1Uc9evhvMwWgMLqQ1Nonaxf4MGtv5AEnHL0MRWh4wa0Gkhi+YhzsklAMFKzBxZERH0jLTB0Hd7Akny56xhKLGU6elL0vYDSGKBVH4J0ALxlizc2Q1MG6rFGFiXf2YADowpKA4ivkfnrKfeZAjRj7pwrZfkZ+nuGgatDiIRdXh4eLsQM8DHeifMKRnNnyC7DpKYBVfX8DH1sciADmmWGq+hBqkMzKDBVMh5+0YQS9j6OGY2bHKzADdzOk8Dj7jCPVn6Z+tuPwCFHI2T0Zg//njdkxnNYJ7Iy4wykWfub/Kw1Iu7vZ9Eutk/ux4xeH97sUzT3Kycz39Ac3wlQgfn4TEVJe/hzucS+r/GBzYCz2DWQEbGpOMekW1CNutylwEHS9nW2tV8zL8xBxJgcfwV2CMuGdoRpS7QFzq/C5iIdN58NiXvsKdMYenOxgCpVH/vg5+fstq9XF5dZ+xPLbboS80ODJYEh/H5hDUPYrRxDwDKlIWAggpFywOPC9/zPs3RSGFTSoHHmGe2z6fcFrSGE24SZbzbw6T7nT5UD3y8ffKt7UQ8JcXYocRhIDnDHFSTn9WHz4Qmm3KXx+V9IT4CMXW1H3MAacxOXxTcI9+MFqn2wGy+dUUFlfD9VWckldeb1z4QDTe28isA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x2vY704Uh06SUfigW1FVkcjAJqE4nXDrWjNScDcWSJFznEGab9+YwSHdrq1oTsXR+V3a7mrFDO9B5PwirhU8UUX6QUj30BwToZHuHgsCIVdiapQ83gtlx9xHD9OwUfO5kQsjgKjrFhd+8QI/avrbQTr48hkLxTO41yxWyu492RP5PKkW6Twj3RraAn84uyw5ms986P7LD1c+Uy24X44pKotYKh2+8htO6Hr33X0uIbsTEinBsdfV9Wjf6A52Q0Bogu8UvGKQMp2a+oi91faf7V+Ib4JzuFThiyInmwi1rU+/xJQfFhrHu4e5TVX2F4QXoUF1NuL9EFpnLgkFMRNz9h+6yGhE80wGGgK6Nd+oa0vHgerjKOsh4rAb9b1hBIW/WL07WtvwZbpyexiiPlqiwvn+jxcRJ8Hd2RL6dxg7Ui0MNDDyzvQPeP6Xa8/3ILxt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:28:09.3952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b83afbf-174d-4c6a-1048-08de7b8c9722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index f12227145ef08..0342d095d44ce 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2915,9 +2915,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 	if (rdev->family == CHIP_HAINAN) {
 		if ((rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6660) ||
 		    (rdev->pdev->device == 0x6664) ||
 		    (rdev->pdev->device == 0x6665) ||
-		    (rdev->pdev->device == 0x6667)) {
+		    (rdev->pdev->device == 0x6667) ||
+		    (rdev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((rdev->pdev->revision == 0xC3) ||
-- 
2.53.0

