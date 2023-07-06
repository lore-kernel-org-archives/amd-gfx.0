Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D6DEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 09:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BAC10E4A3;
	Thu,  6 Jul 2023 09:23:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63710E4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 09:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1SFR6dvrn63ma+c0+iWv5E+VZhyzGmNzV3T+pl2JN7604zu2b+jjBUUaPolLIuWTXnZnSYa+7gvSEZzlBFG9ufabRCN/SfDTKUn9MpQKw2MLYItVoiCX8i0Wzd1ZgjltHZUoJpvom4gqlX0i1y2rsMYDb8dftWXJQ2r7VupZ74ag1EexMtWsU1WqOSyqSsEJE/8xFcveTKivOEs0nAZlHPjxhDv051f/oGNXXWngPEaq+eVAH+FmkP5HngYil8yvgbRDqWO06eToiI6M3M3uy5d9uDRwOJarXM44wZEaMmEpbYFCzNaqh4vMUZPnBSJpYh8mqjSa9nRm5+ah4jWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HBHfoUlhQN3hkHKUmZDV3b3EKwjKi1YyGrkmPvTlT8=;
 b=JMGABRgIQwhFZrkk7vN/Nb3gNXu6qhS9xFXTIrTZb+ctE6fYm0uMqkR9hj+Vj7TlYKZ/htrKVNQpKQyz3b+aTwh7tweih5c383q4HwazSrd3mbMyxNz34GqHy1FQ5KS0WuRPsIDuK60csxe9LyrfqdIeAJK62HtsayViSI/WaRvlQgyV0yjd+y6nEwANxEpu7umCZ07im8EZCol2pujjOa6kBUSNufN5M7GqVxOeprTBsbCJ4F/thXkgqmH4Z3aTmu057F7EIP0ZJXOq7ubrudXK++m1hWxrunfc269fBo8cJze7Pe+kGRzDKmkIbo+g7770eMN5lCWz0sBaCPGCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HBHfoUlhQN3hkHKUmZDV3b3EKwjKi1YyGrkmPvTlT8=;
 b=3h7hPp5n0QZqqfGCUSDsfBXGi/ffCJaBQCgYTCs3GwTlr6hI1u/SO6tFI3Cy5GimhBNlFV5TneVwFqhSW13jaGk0OJX/3j8K0oRWxQv5C5+BRhve5et13NXgvl4TmSQ3VpNZLtt5s2SxV7CNpxgdQaNZRUlEwg1BqyVl28qxMiI=
Received: from BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:23:24 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::88) by BYAPR07CA0061.outlook.office365.com
 (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 09:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 09:23:24 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 04:23:21 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <flora.cui@amd.com>
Subject: [PATCH] drm/amdgpu/vkms: drop redundant set of
 fb_modifiers_not_supported
Date: Thu, 6 Jul 2023 17:23:06 +0800
Message-ID: <20230706092306.1050029-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5a5c33-0839-437a-6045-08db7e02a603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTF/hxGuSgE5MAXICi0gzNWI0CqAtByfr2vUiYarOGGQxS/vOWtME5YYJIqL/3djdICyCXtpXRMPHFCwP6m2udSgkxNM2phjtIQCMX1P5x0DYO1vrk8Krme5Exq33rGH6cxAoygaIc9/XcW6+jFu/OS9YgHumQRmS8zi1ZRPzXlH4VyXHNuQ6YkxToGcb+yRe3D+hAcH36VvAOZawrOu6KoP0X4CoCbj5PpZGHsp99IMSXszdscug2dM2m4eKfB3RycSdbA4vthoviMRz5lpT3K1LZ7NnVkNFaC0hNWpPZ17H8ll+JuOzwBcqFV8NE3p9A+sNwuXKC1OyRDRzXXkfARgHWpbHYqK23yRADtyMndQEsSyXn8uoNkCw99y09FA6a9bR5VXkypp3s/x3/+gcMZUmKzzlvPrbPJ5Q3oNhSGvREZtZXHn2aafJwmCpJxvcX+x1+NuH0L5ZKe4XZu5YdfmssQwFinej3yBYUCUWw7edPywOdUIISDI8Cr67R2PHx/Q334uhlV3GueRTl5BsNAOx2XpuTF+a9I3CzTf2f6REE/EdK8KxmyWl93iIAhYMKyDesWQUlYnaRTDpn8PxXDOWsfYp+a/ZDelvRu823pFakNhQ4zg2jbgYv+8ILV4oE6wxsGdVAnUjVMA+TK+czKYma47UR5XlGjHHlUZrWG4atg/Zmt2CA/2EufyTh2mVSIPdgM2635opaaH2ADL3DqDE85mqgFSfiA+HxfZ/+/s3+HpXcMJpMXC1PkkPQ3gMOUBKKQ6yXXDLFlvjaQw7o4Zp7FRDwZuiHKHemP/L1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(7696005)(478600001)(6666004)(70586007)(110136005)(2616005)(36860700001)(336012)(426003)(86362001)(36756003)(40480700001)(47076005)(2906002)(16526019)(82310400005)(186003)(70206006)(83380400001)(1076003)(26005)(4744005)(81166007)(356005)(82740400003)(41300700001)(316002)(6636002)(40460700003)(4326008)(5660300002)(8676002)(8936002)(44832011)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:23:24.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5a5c33-0839-437a-6045-08db7e02a603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to a coding typo.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 70fb0df039e3..2a318c6d2cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -500,8 +500,6 @@ static int amdgpu_vkms_sw_init(void *handle)
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
-	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
-
 	r = amdgpu_display_modeset_create_props(adev);
 	if (r)
 		return r;
-- 
2.25.1

