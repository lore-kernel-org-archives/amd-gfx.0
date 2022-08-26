Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B90EECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF1410E143;
	Fri, 26 Aug 2022 18:44:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8103210E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znx8Xc6G/QRCMDqt5k64W/kBb51XUqxgLaKnwMyeKxcqtKoodOYIqaZ2nKsfe4eiccarfU/hFcXC4/Xs7V5FFuX1gTbYGVCPsbPk1yMt1epOnCVcHg4OdYJ5BD0HNjesADS5DzHvBYh5F7ztYCcfB+9PRe4rIjEKcUGaQENLUVJkiC09LZkk3bZsLTrNv6Z9UK6lA3L6Nb7qyAcU/dhWazlVepF2dCrc2SL7VDP/EHz9zVKfTjWLZBGoSFIlx3ZOX+vvFMQvqMf6r8Zqyo9Y2FJcLHwXRQxS3hFaa+Jo4e4esS1l5J5+Zztt0hjUKJ5en/LkXSIevpK4tajdKhMzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkIpM3Q8C5cAZfdAGKGGzQ4eIz5GBuK+GercvWr2pwk=;
 b=neUXHVUOH709HMiYwTHZh9eY1Pd0BTZcEaGDrm7UDhsMsM0VSPzBziFGXkGKmdyZy8E2M8VEstxgCrGHPZttpfzysOOyRjLBJjHzni2w1+W5o/H1T26aMIeKRO/onBFOz6R1dJe+R/xsDsEJ7VOejCfqV9uRcFILj7aoIz+GCL0U6GjlZ/MgOjo9LGWqBfMTpid/EKc0EuqSEoTDrJyv7wGwk1NcSJWXdNlnDp+sk/RWAOFdYtXlelyavQ/n72qLEBEgiLVnLq1MQR4LpamQxWtR9GUsW8x4x2E5KWHU8vHVBsk5CNKANat4TnuSsvWVyYXAsnYSuNv5UCz6fA9fRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkIpM3Q8C5cAZfdAGKGGzQ4eIz5GBuK+GercvWr2pwk=;
 b=DKmGEFn9kVe5ym+AB+r3QGTQtWxyaV9xJ4i8aTmR6lNHA2va77Lv/vs/Wdt6S7Ivx/mnW32NuG6yOGv3jxsXdMj1nclusxglY6t2DNjsiwu8f214ULoGw2Y0dYEUUBNAw5M35B9ahiwY0fi3Fs5cHt+qAXGuuEU6O3fGvN+6sAs=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:43:55 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::53) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:43:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: added firmware module for psp 13.0.10
Date: Fri, 26 Aug 2022 14:43:38 -0400
Message-ID: <20220826184339.855360-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184339.855360-1-alexander.deucher@amd.com>
References: <20220826184339.855360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4059e3b-14fb-4ce7-1d3d-08da8792ed6b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hr8eBre5MdsMSM914Fp3hS/uBui27KR3fir8VLSow+TA/yIfx3z85lokFe2KLmUl6p7xLTANaBBdqDVDZx3uANwg+uYssCvpmwND8gcAF2f0fcsJ11hTjKay7CiJT8OLrOxzNxIZXgJ73B2YhTDOVGGwbzb1Oab2Rkjl9A7M16/3g4aQ3mSSVcPGK0xYdQCL+3PyWFDQmAyQebcBmqyz+RCesEZ0xmEnJAm0dX0dLEbeki76b9of0twCGxLcXtieTipnL/LF2KudhEtW2zbIM0AjlwsrbimeTP+gsdSyRkqoDEEeLPqcsbDeKzO0I5rp/R6shWPwzFX5ZYnUswqtms18W7/h9W+8QqvrzQGusDw14tYBGbyu/e+gsQzux4VqchgQm6aH9zINoozU/S9J64L5/MjBWa9Reck0XxHre3K1C95w+6nwMyEEXmZxQQWEadhi8N2LikoXB51kinwYe+dkbMirDm7hlK7Majxs/IrNTueJvfNButwNNNPM1BkNEbhbdEdf9Y+cpoK/14T30uQ3YD2WZoz7vpF6//7dcm9d524uvW676DKK584n3KFcbP1q+9rI7mJABDa1032kesPS1oeDOZb/VKqbMbj+n3X/d4kopagfByB8gi2AbEEV13wCBGgnpyMLFCfib0s+f6pL3xzClwAhmAmHWxCz5IOP7CvjxBwsEAslD0IK/LcMfHfSlNP/k4YiGHCXVrlTi5wUnSffp435PHoi7xFTd+xCzNc2qLXXEESoargTl+JwPzXc766cioXpTfka54T/qqlFRI4FAq1jd2YsyHfYx9CPSm9BuNwpCjecoFRT9vj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(40470700004)(4744005)(316002)(8936002)(54906003)(426003)(6916009)(5660300002)(6666004)(336012)(16526019)(186003)(36756003)(2906002)(1076003)(2616005)(41300700001)(7696005)(26005)(478600001)(81166007)(40480700001)(356005)(40460700003)(86362001)(36860700001)(63350400001)(83380400001)(63370400001)(47076005)(4326008)(8676002)(70586007)(70206006)(82740400003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:54.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4059e3b-14fb-4ce7-1d3d-08da8792ed6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

added missing firmware module

Signed-off-by: John Clements <john.clements@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 38553e8141f1..eac33d5c93e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -43,6 +43,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
-- 
2.37.1

