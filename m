Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D69E7E644
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 15:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E42B10E028;
	Tue, 26 Sep 2023 15:05:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A1A10E028
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 15:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqkdelW5NIagVTWevh4t3MdlCk+g7yu9MSxFxOoF6khasLUYLxbFN1GgnN5YnDRLF11Xbigq/rQJgLTRXCXR2HKqPJQOIxeqc+qhBE4EIRQ0fU2xmDtpdotfw4iIQu2XBzgblqg16M6uv6WspvHiy8A8D1JI5jnfKQ+7rIMx1C9bXjFS4+RY+TjPx5Wg1LHNDyHta//HM2Ki8tkDBIINWpVwzDDrLr+CR8jGxpA2X6p5NXG8Pte01ehFsqxNQSSZo8PsrWm5V49FByfG1NIIDwACdIoRk/KkvZcA2ca8b0kVynQB6/W8v/TdLrpFJdIENdrcv1WFzfs8ZQRn6YXbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9SivwVQFD1MeaFIaSnZy/UmuyLYkjFncMSe9BRFMo8=;
 b=erJ+dGngfOh9syzC4kR+Go7SbTQdqvw1G7Su5dPqPTOC1FF2wgcYcjceg4p1z4ree+IMsVI9p0JeWTFSnvNsitiQ7ph77r51hOa/N0+ERv4nitMnAtAXRaZGDC4p9pkl3p2NMsbPgqOTCVDDXu659gPJ+lou4LBj4JbhA3MnC5m6uSJMi6GahFLA8VdoB08eMQQ/5j3nBbE4Is+jkvXJJIz2ag0YSe/vCndnpkvg3tjkpHQA5xzzpQLXqaGC4xzLe6Fp8djMcGm21ORoc3yt5cXLoEL+wWw7e1SoDe7zwhKGCIPT+rG061V776JRreCWvH8eCWlX8SiUmQEtpmQGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9SivwVQFD1MeaFIaSnZy/UmuyLYkjFncMSe9BRFMo8=;
 b=VtDWYE+vEGksrCJ63v+mqS+WjnSLBXF9jmD+06cGmCXCQdRc4CWsWdEx9/WZnbjJTQQoyUdkzQp2p9Yxnz1QmmvG3qRvDMUlhJIjD1p1qbQhApfKOyx7Cu75oWCie+RZST2uY/HO6Ju3dMMKDnghgwbpewxBlGiqiYcJTGsSH94=
Received: from CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::17)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 15:05:43 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::3c) by CH5P221CA0017.outlook.office365.com
 (2603:10b6:610:1f2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 15:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 15:05:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 10:05:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Limit seamless boot by default to APUs
Date: Mon, 25 Sep 2023 20:44:13 -0500
Message-ID: <20230926014413.139961-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c980d3-1150-4e2f-7b46-08dbbea20df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MYnKka9kxzlOAUaN+dUfr73dD6D2M65ldmZnOHWt5gs0A45Jgp6rW9x7QKLKgwRtZAVlFjYvRyLZcvuizsD9/Eq+RDTrh7tMApoSd7deuymiWLEbHAAopMpxMiLJNffwhPmTmnZhN0/dcjhIMpVQTpnZ1OOBVODTU5LAY4dNEcUXnAof6zHHpTPldcXRo1Mnq1Mt64LS/xonL2P/kwzN4iyH7eA9Vw0n8CVkrbD8ahXYyyBG/gByzkJsx7qwsnNsbI61PRVbc8jjAzchCmeBh6m5bn5SCU6xhHjIGpykBRgNfIq3WcB4fKACN+BvlwjVpBvyDiWhAVTNCSckPJRG2FLmtkfXRKVZ1QiPzBAzy9eK7k+gOgEB5vTgnfdKNhrcfJSB/98+gQdpxQuzH4NRC7wPHGUX2NKASE9hg2H9d38QsuFqZ1mYQHWsA2mY/2VQ7fEs+Gfw3Qh44NREiVpfiZ9sxxs+1uFZwEk9fa3YbzOMdHFL4fGOy2stOq2fYAulkotTrK0S00D7yCx7ffVu03rf+pIBGcEC8eC0GoAbomn1UtlygxdKdJdF6duJAH52+8ZGw1ST05XMHiGAjcIjqZnXmzmS1u8jaUb1ZKVY3FpUSMsJk3GqGx6pfno4Thnp5jJj9aCkhz8iMGLXQGhVeRw1OLhqhDuISjmokIhxXFn76iTAFniztouYwRWmfOz+gUCU+ag9QTE7eWFZPhzMegLGBmAOdw3osIa2e+uXSJqy+bDlk5nyoZJn1V3NM0VEv/CMesYdxGddgRfP3N+ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(7696005)(8936002)(6666004)(966005)(82740400003)(478600001)(36756003)(86362001)(40460700003)(81166007)(36860700001)(356005)(16526019)(44832011)(26005)(1076003)(336012)(4744005)(2616005)(426003)(8676002)(40480700001)(5660300002)(83380400001)(6916009)(41300700001)(2906002)(70586007)(4326008)(70206006)(316002)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 15:05:43.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c980d3-1150-4e2f-7b46-08dbbea20df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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
Cc: Alexander.Deucher@amd.com, feifei.xu@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A hang is reported on DCN 3.2 with seamless boot enabled.
As the benefits come from an eDP setup, limit it to only enabled
by default with APUs.

Suggested-by: Alexander.Deucher@amd.com
Reported-by: feifei.xu@amd.com
Closes: https://lore.kernel.org/amd-gfx/85b427f6-11ec-4249-bf6f-eadf9c375f88@amd.com/T/#m2887e919d7c01b2a4860d2261b366d22e070f309
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 22c0e035de81..5436d7a34014 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1380,6 +1380,9 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 		return false;
 	}
 
+	if (!(adev->flags & AMD_IS_APU))
+		return false;
+
 	if (adev->mman.keep_stolen_vga_memory)
 		return false;
 
-- 
2.34.1

