Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3385C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7528F10E938;
	Thu,  7 Dec 2023 17:41:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C991B10E938
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgrpblR/map8TM0PGPgj58un6zvQIgw1GtDQoDiQ1A6Ku6bgiSVPchtQ4BgWReoLDhD8J5Z2szkDAL/UDVWb3/TvomZIRP2+buSOcbPlvZbTdShD5y2p91VEjQTs33veOv5qUkfyGQlrrEGOqJTkLskE+Rt8unw4QxR/SK3byAXvaOKr/sfoTabbKea4UpHHNOSZOZ6+xwVOsC0/fY8+YkZucb5pMI5T+MB94IwYFhJQdqZ7h4q0KROPHGpwTnPcrU2M5MZmTIZO8HWwHYEXPaG6b+SlnWbUJo+ePeyrd3QZVaDoT6FtxDaj1/Y1rX5WbRx4pDvCz7gSEXxfcy1Onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uBomX6FfavxRVFie2gAygq+V01HtUFrhMuECsbG37Q=;
 b=BNlc/qa4Dn6qWu8tDYqjM47mBCJo7NlbA24BS/W8JwYXM3hTLrc3X/epxPg6syVYoU0druxvspR3gT3mdrKmpuqPOOMe65XrfQNQ5PM5zTn4eudwlDuhpgdvhgw1XNwO555fmZkAtvy6mt6YlATEEujhzsBxfMWwKNDiHIuDANspdXnB/UC9AxtOglGvv27IOIurT51iA8do8wgCMCWF8pIcIAsq5GtPvFvhWHcP7f+B2hz/UJxQR0fvGbuBZbWQWXnpzKdlKOiVeqvZusrQN1FWCsBMpYnaRWo/B0jf9qm8ORZ8LUlH17jQQ458ZeEQc/DzxBhEmBLAwXdUaS/ILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uBomX6FfavxRVFie2gAygq+V01HtUFrhMuECsbG37Q=;
 b=zWaypi73c8TEoTuH6YuQ1NkUtMm1SJouPigt19m1aVveyQB0BGnN1bD4UPlAo5Bl3qyNavy6g/4zp0tRRmH6bp0xCFal6rAB6NVibpkCVgYwRc5r/m2ZI2J5gefdOwyOmyBfb53FJbsVke7xxE7PTlUo1nqY9CFvpdq6cGMz1y4=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 17:41:07 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:610:75:cafe::da) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 17:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 17:41:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 11:41:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: fall back to INPUT power for AVG power via
 INFO IOCTL
Date: Thu, 7 Dec 2023 12:40:41 -0500
Message-ID: <20231207174043.395159-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207174043.395159-1-alexander.deucher@amd.com>
References: <20231207174043.395159-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 782b7541-b00e-476a-f9b5-08dbf74bb139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYpEsxRWg9OwtdHIOL3KYXs9di9dC2fAjwpqhTeN+PWlXPFkjdIXeXYMAuZCNO2u9E1rIGnPTZ86N2ozzfe3l9yTS3a+ZGd2Roaok34KTna8TN6+cQE+zyrzXq0SOs/4EPYamFnkKhvYQEE7J8IoHBHoIvNJ6AvYsY2gLQhY46jpsIslq3tj5oM5QDfhZgA9PWARAGvCc68pxflEay8JDnKuxEY7ynDWOFU1ft5dENx37mGH4Ll3uo3u0Pedd3a4t3SVAzpEJiFrB/JNxFju6Jer/gVTuwKJ25WDzqGk/uVApTVmgBGsRYzX0mcUCATLGe745GbGPP4YeQ7rauBAdOOjO0ifqsrHDgq/pLLTryst5r2AkqPQTl6lfzdbtJPvFSMHDttgJYjtK2jbmGUWToKevMKBn0f+ydB6bLWot1+OLEeQENkLM58SNwWvtR1xvKlnNiSEwypcOIhvGcQR5O44EizUIM2fzE7dpw1eiz3BtPJiecQWf+APrlG1rhQmnd+eBfiQMlAOhOR9ClKNDLkBhScXZ0mv/blY2fUAARuB1tTHbNS6alFofwEoYRXJm71b2YunVEA2O6kYmcsCagKhHDJVrJhhsxu27nNWniHjq7C1/1SOi4RF+Wju8wdqE5mlT8ZOF8qnPFyf8YmzvmWaEQDPc+ikfFjYRZ3kvItyEiXlTMcCAqnNNkY21+z8otdNSH97WNWB5ChvtyE/epra68ScZh6Xb7cnurehdBHO8JkxWJvFyNHFNHrvU9uL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(7696005)(426003)(83380400001)(40460700003)(6666004)(1076003)(2616005)(26005)(16526019)(336012)(70586007)(316002)(6916009)(70206006)(40480700001)(5660300002)(2906002)(4744005)(8676002)(86362001)(8936002)(36756003)(4326008)(41300700001)(966005)(81166007)(478600001)(82740400003)(356005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 17:41:06.9312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782b7541-b00e-476a-f9b5-08dbf74bb139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For backwards compatibility with userspace.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..bf4f48fe438d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1105,7 +1105,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				/* fall back to input power for backwards compat */
+				if (amdgpu_dpm_read_sensor(adev,
+							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+							   (void *)&ui32, &ui32_size)) {
+					return -EINVAL;
+				}
 			}
 			ui32 >>= 8;
 			break;
-- 
2.42.0

