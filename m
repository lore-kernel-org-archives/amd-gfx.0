Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D8C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ECE10F34A;
	Fri, 31 Mar 2023 22:46:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8AD10F347
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuDwgnPUEXWIG43fGF+zqUgkZTgyv40pdTM6fre/0msJ+hfQiqMUE/JNrdGD0zbwMYhYXjjv640dsBvw7njljO2fBbgLTFO9H4KWbzDNWXSvm8mQZO8CBjltPiqc+EgHTz8jo0h5QG+FvXZAGJNYi2JQRppG6DcjpruK8RXUSt0LvcYl8RKbCGFQyfPsJgxndn7vFi7Llr2w8wJ+c/o3NOKbuhBK7wj0cRFIBBMs2N8j898oT4WNS148UQEKNzGR+n59WLZR9V6Ngf9bEPiwQ6HJ8M1wO/ePVboDT3EgtyUniD1cbxSC0qEA9LOPtE7Sk65YR64SJhu+Mgg6qKNlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiHSL/JgDIFAicnbNfeou4kQyO5n9JzsxVG8Qi60I3A=;
 b=DJdxr/5fXdR76es9B1y0oJLq29iQTjpGpxajieUOqF6Mm+FnkeAejIPY+QiPYPhjFZxszTmo1Vpkmq/UPEBh7iiackRhnSiH+nNUfMZyuSYk4rBlD5Lndvzwg8kVhrHY1A6rVZ1hdtxhbpE48acrxRvDnyCdTjVjQp7Jo9xSjfYZB/d1oRlXvtLfkpda6laNajh7joGWsX3jRlViUmX1DoOkl+hy3986t9+TzQkIHfbcgYVkToRm0NQEHLifReQxFooNfeopdHGcWmMlowi3+HmuaGsyBwRuXhs/BUAmOA6DKAK6GpygKwX+OMLRJCvSnv3dmYf0rMEHQzuhdIjAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiHSL/JgDIFAicnbNfeou4kQyO5n9JzsxVG8Qi60I3A=;
 b=14vYcKBDsAeoMUt+kD8kQb3r/KRSNWnt0g3XiMXJAie7xGuamNfVvmGYXWYn/qSIVI3UTrzyhtK5b0XdC91gyalNkMIwvUhbqp21odLgyH2pSDnvRBK0mIs3zwbfUvfTHAohcageFGlutzr3ju1Vf92Rhv1IVUHN1FzY9EOdahg=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:46:38 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a6) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 22:46:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:46:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable persistent edc harvesting in APP APU
Date: Fri, 31 Mar 2023 18:46:16 -0400
Message-ID: <20230331224617.8961-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224617.8961-1-alexander.deucher@amd.com>
References: <20230331224617.8961-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 710806fa-35f6-46ef-efc0-08db3239c9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5t6pAsgDwPWzKu/k9fjD9CGTR2V0CTDCsRGJPC8HTut9tAmOVaDTmo6qCs3EI74XKj+YwR4DkxnB0GBlPrSOygVUwvOnSjLFQYAJ3H/lbDgHVSPCVIIlUVD64dLB/K6BjngKUm4tImLgNtis1TA40MNCfvjdrxCEvj8jGdZy5vfQznQChnWx02i474EgLT1v605gQZtCebeoM72RAuEJ2wymQqX8Yg6dKSjKZRHIHBMk3molFN99SIkWymApGes9BCR+9jL1v2MFe870qq4PmrvDu+yqkA8P8V/xsfEz9FwcSVKoQAJ2BMrXaopgXZ5v41AMf3YNLmiW7xEyFq9ri+VoKLTO5/7WWnXI+rckjawlVe608oN76XVOJ9b70yA048FkXeS0ccDhuNXeAMpeoIy/WM0yMEaYdlCd0SOPQP/1pAZ05cz3A1m32LBmh2nh2LiUb5cbzbr6W+WATvjgWI3PcpF7+8CYy0VaEM06DNkh0rQd1Z/m6vq3Lr6CTdXyoYKrIO1xefgejZP5tuXhJfPUXFD9dYAiEFy8xCgnDEHyFj0hXFZFXKfnASqorm2xKl2crKhoFmcC8aE1qxZxaaDqdgEmIyWmXCypU/lmc1fKSUsfNf5+fN/Y/wKM3u0VEn9khcAszp79DXhYmQX9NBWHXaUXUDKKfUhN8NVTokQ4Hugl48jjpH6lHa1Qa0GrSbc4Fy/FgroNoi6+/+Vh3zVRxfdJ8q0NPq9xMUMcQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(6916009)(8676002)(40460700003)(70586007)(70206006)(316002)(4326008)(36756003)(1076003)(6666004)(356005)(186003)(82740400003)(2616005)(16526019)(426003)(47076005)(83380400001)(81166007)(82310400005)(41300700001)(5660300002)(40480700001)(8936002)(7696005)(36860700001)(26005)(478600001)(2906002)(86362001)(4744005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:46:38.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710806fa-35f6-46ef-efc0-08db3239c9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Persistent edc harvesting is supported in APP APU

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5e9e617b0812..d5705ee99b4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2619,7 +2619,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *adev)
 {
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.xgmi.connected_to_cpu ||
+	    adev->gmc.is_app_apu)
 		return 1;
 	return 0;
 }
-- 
2.39.2

