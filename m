Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDBFC7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 10:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CB710E680;
	Fri,  9 Jun 2023 10:45:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937DD10E680
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 10:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3zbkcHyrfrfbGINeSa5Gk8G2+g1wxiUmcO147UqwoJCHiMOiRSbYf+bLaePVhp55q0LOK9ra/KjRVlGnJhgP8alz7fvZB4mN86wKS6a9dsTZWxRT0pqFlYZEyzmIbwK8zNn0pxmmNnEkGo6FUvqVBd+IdXbdDsumsKh+zVN08YcopZZl1+gPMiJCcVjP3bJBs01CTLxsh36Bdywsx4oZ8WkI+SCH/G5MxxD5T/1KLvqDcfU3XFwosub/YgWnRJx/5xCGauHGWcv8+P2kvauDod7pG+SqYdqIvb1jA9dYzIw9kVt6FNPiT1UXEnNFz/iK1pyUvu0IwYL6XjONXqfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAvQRKWTndh4YGHCFXTLLv2sP7uVLqGw8OBJ+HhC0a4=;
 b=Slbo1nCx8Tw518vxn5f8my1xIdzJO9BqUrhyg3HaarxqqYOCCZuPE1fuLgVNEFMPV6ANcln7eL/YkWBPfh9VWmkYBPdpn8e/Sk2KljaIRvgbaemQ9uqQ05kDNpRAU9tfyXC0Y296W01Yc8T0Ql48D2PIZNAEsZMc4Ba4++OpFOPImY1h6CK+5D2RLoql6/4owhMotJ8D9w4tQqL98TJL7fGoRyehPcSxEHLu4HndppBXm+4+g/fcGfIhFPi2ksfIF7JK3yPWawmarPYAdSDlFAiNzoLPAx88Ka8Bsfx09RN5LtiatAEoFPyr/hvLYE7lJNQ5HKA/Nw2NeTxhVpEkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAvQRKWTndh4YGHCFXTLLv2sP7uVLqGw8OBJ+HhC0a4=;
 b=fBjd2SLWQW/HthxHEbVV6TZrOx5S0OW/7nVmdckqQSAhbkmy00uzdyavRyA05OO6KPvIMYkP79zZH9nFgeTg/nrivY0UFWJsQgw/vngC62MIM2/WnInN6PVZ0DrI8Vir/0xnAmymLgbe0JpiGWh8irC/Q4crSI9DkvGy6AgqPTc=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 10:45:29 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::b3) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Fri, 9 Jun 2023 10:45:29 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:45:26 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: enable vclk and dclk Pstates for SMU v13.0.5
Date: Fri, 9 Jun 2023 18:44:26 +0800
Message-ID: <20230609104427.636097-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609104427.636097-1-Tim.Huang@amd.com>
References: <20230609104427.636097-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cefe87-f3d3-4558-9347-08db68d6a454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gus1bJBIvWZ26jWlYDegPV3TBf+rXoLT2HilIIovbWuETT1WKy9SK+rr54XZ3Jjj1+fki6t9riG1oX2rn9sOKf8W3is1zWzTeSBAxSE9LEN2ZK43MEjeTM5DmkM3AaYMxhcN+4fVWM+Kdehpm/koMJpsB4gd/TTbik5MAup5FoiZ3PGw0JMbOhosrIq4KSuFoobzmaDIJLtCoO6tXxdxVnhvrFYc/M6AhEsh+YrKhiCkry4oVSoOtBlT482N+lqs453aiZpPus7usIOmjCOwUPFthuFMI49zc1VtNXIKd51k8KysRWYOBVArTeOm47uJopLRdOIWvc3H65ZlpI1zxiInPX7pQ/tlMVRN9FSQlApp4zSLGzjKG8W+ZkkwBdsfq9ld55OIK4SSfdjGkSAig3LcUXqoZAeGobvOKoCCITGLhtjJ931zS8I+Pg3rknD4lSHC44XnldNkiqgmJ82J4JU7gXdRk+R6ddD622mTo5W8/3Jz8i3M3mwWSXd8tFcDeP22/ANbUgi93N1EcEfS17i7U+9XEwH6OMcfZatd4vYYq6DX7UHt9Z5vI8r9EJVy+rSQC+knlB6U725jn7gtmOXHWS1TRwRY2ZdLYwyfXezPVhmoT2Sw4WWH2+81vjBD/kmqFAIapLTsR64ntoE8ue88uEiDXSFtxJq26mg4PyhRRvPHg+nEcN0t93psHKayc8ircw7++gnZ92pWRPhhcHClvk9l7TCnpZEoHdDxCfzaGkQYvg8RW1c5OAhkbwa6OxuQekvuIj58YWQtuIC4nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(186003)(16526019)(336012)(2616005)(1076003)(26005)(47076005)(426003)(36860700001)(82310400005)(7696005)(82740400003)(81166007)(70586007)(356005)(70206006)(36756003)(4326008)(478600001)(83380400001)(40460700003)(8936002)(8676002)(5660300002)(86362001)(6916009)(54906003)(316002)(41300700001)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:45:29.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cefe87-f3d3-4558-9347-08db68d6a454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, jesse.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the ability to control the vclk and dclk frequency by
power_dpm_force_performance_level interface.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 725c791ad3fc..53c508acf895 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -983,19 +983,31 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
 	int ret = 0;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
 		sclk_min = sclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
 		sclk_max = sclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
@@ -1023,6 +1035,23 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		smu->gfx_actual_soft_max_freq = sclk_max;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
 	return ret;
 }
 
-- 
2.34.1

