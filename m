Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3EBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103C510E3FF;
	Wed, 30 Nov 2022 00:44:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6411510E3FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjfEwWul4GYhJHWHXYGtc3Cu71NyJvhFKdvHibwnTTcfnY+gBSYFLyr+yRyMNeARevOqHAHl78wHMqelV9OnWnqSyOldPAAeDL/tcvgTYYPmBWCWLBzsCdfSsn8Sc44WkqfvB4iomqI12k/bqMC9oeCuIYhs91WqJJ7l57gOlToDmuL0r1xKo9v48Skcc/oNXimLo1oykfHREmKCkvvkqLuTUrwUSYX1dvGyfMBODFYRxhcUSIPfYMHPMcb9oDi3Iehqxge9nG39m3HLW2e3rLqt4OcmupPYltLEOLsPZTqRsbSn/A63V5KabAjkjrZ4co3GUJsoVy6AcmgV29IaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxIshWkR+oKNgkOscWWbcFxP7M2affzEyb9vQaz+WNI=;
 b=kLDwhioUwjn3sXkCaVq4G52vHfazQ6qTaclL9K9/kZ1jBtFt8kbYN4nEkwtidb14BJI0h2e8QdBEOGW/YRDt6ySwRq9S4XurQ9erF36IHcVYiG0vEls7SZdSy9lv6Ro+r1P/NZ1VhAajIYXVqJXF3jWAjj2kAi0h99qkNRxl488qs2QChN+IGy4sxy4jeAK5YhR1BEsJ6+e1C6inueUrd1RkFiqlFgyedHPBWqMlPVuxgVG2KxtU1UD6WIXDe0ZNKHcl9hMDYG1xlnO4ExPf/4S/QQbH/pfGLGAccHVOYcKPwBCTBvO8SAmD13OfXaotyOCCxFTtWy/U8EIWAmvzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxIshWkR+oKNgkOscWWbcFxP7M2affzEyb9vQaz+WNI=;
 b=q46krjY5tzrhBpKumH7dBI5PRMkVxDJTcLTCtFY2xZoJ/xUW67tDtF5JcNNiIxcvxmbbxGRe2lja2YICThzPm4HTmbSt+yKNRZ1AkgsIYmsQuQsDEzpt0jMyMiTw/ftHFRH4UcqoAqrEzuf6BOQh+oOQmMddXXf9k/FYm4HowP0=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:44:12 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::97) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 00:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 00:44:12 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 18:44:10 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/mes11: enable reg active poll
Date: Wed, 30 Nov 2022 08:43:53 +0800
Message-ID: <20221130004353.58323-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221130004353.58323-1-Jack.Xiao@amd.com>
References: <20221130004353.58323-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0522f468-ffe2-4bcc-a754-08dad26bffca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w72twJv8elAWezF7mViCOrkAKDhoW/Hv4iPOOZORUaDvl/B8um+WSHBz1HcqesaQH/qznoYPlx7Bi1//YhFvoltjQEmALxVzQuUfU1rad6PcYMOvid05LdlUTvqaUQbR4CWVbqIx3d8Vm5d3+puRC+seYgRXW6t6lRZAy8rCtxdQgN+1A4g5H4fJ18E1wHIqCg0zZL9bX0MvgzV/kXsVYICtwVKhfIEaZ8lbnkX7MWizrmpTc/IWl+0hw/bX9rcrVzq1mQGFoLp3W6ydjCmswlUqxEtTwjjpBkKBgJUKDSUjbTyDYJju7WhgLd1YoahXJRtezblSB3iuqX2eWhLK0ECJVVdl6UcRL35FsPp2z0bcmqrRm/7+a4EtRxjX4B88q405WWF54Ymn0sHvy95bkWZYIdUq3bn7kkh3v/BsO7+MzknwdDX1xpSRWiwdZtGeODVGNp44W6bobN0aNcxmE7hCxjoTXBOcD0GDONs90RBjzph7fL+sBCbe1Qkct16CnkFH31JPcEqyfQv9/EsTGgI8A7ZjnBLljKxN1yGZsJgrxODXH77/tM/KYs838Fbdxn6qCV8xlYwBi52u5SIM5nLhzAKZ+jDVBArlkPv0E8KHJBVLl04FPKxbXlmCSLpyvSWSLxulGvSflbxBIBLK0MrBdo0BYVICKqjieE7Nx0EhFN++vA+nAC/FCVuDCcDeDgJaKD8DVYOA7RDiQoCgTprL5+qQ3NSZQx9Ls9PsX+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(81166007)(40480700001)(356005)(36756003)(6666004)(82740400003)(82310400005)(478600001)(26005)(8676002)(41300700001)(40460700003)(70206006)(70586007)(7696005)(86362001)(4326008)(4744005)(6916009)(316002)(8936002)(5660300002)(336012)(426003)(186003)(1076003)(16526019)(47076005)(2616005)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:44:12.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0522f468-ffe2-4bcc-a754-08dad26bffca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable reg active poll in mes11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 02ad84a1526a..a3e7062b7f77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -383,6 +383,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_reset = 1;
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
+	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-- 
2.37.3

