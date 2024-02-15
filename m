Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64637C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919AD10E0B6;
	Thu, 15 Feb 2024 20:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0nfFOzs";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB33510E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlWwcohVB2fyLOSb+pCGCRmpeFzF82AWipLA5/P9tm3hD39r8f0KJHeuQQ02TQonrna+fXk6XO37N09INcgOyskSIGRirs59gxq4dT3tOxI7cAJdrArgA/i+K6xrG74nT47SzvttIewy0tvohi8Bsg1N64XUFudGQ8QgyAj2D5aZq8mMGEVAjrUoRGF/CpuL7VRWvspbxmbsARZjM9WGipy4hkOzpbbIdgAZZVxnovuGWA7Lqf2GW03g4+a92Swq7ynI4IqNDHXe9bHjo9d+HfAF6Vu7rSN5UO/f1/Nu1race/O/2ZC0XTLQf3EBzqWsSc2apKuwcJabFCf0lPF5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/tIiS0WYhYUlMWZnIeEWVaQLp8d/FO60d/UkZdumzs=;
 b=RapkPGsKJhVx3/rgxfqCADZADtw1htba8FBQwZo/yQrZgD68NcQ74aJA4zLLsesJ7Mfn2c8Kj1thiDpLjKtNAurV8j6Wrac9biS/VK9YaedfRuFB6Q4jIfqS/3aCez4kbYxfM9dQXwauAOH7qWk2VT57njvuctGW11Io4URoWUQv5jHVzSd/xdWVSYVNGDGQioiz1eXi+FxBzK0R1Qg8CY3wblC0YJtaMSU9QmmJQKQtvM2FW42Qxcz0bsxGz3UXuL4+nnJKm9/dBPN0Z9BGNmKcganrgXoLp6fMdUNXhWGFdGyQW8nNuQbUrQYdtqwXtmPibZmRCUF1eQFoRaYIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/tIiS0WYhYUlMWZnIeEWVaQLp8d/FO60d/UkZdumzs=;
 b=K0nfFOzsHF/MQjNpVXtzooTiHxoL6XlL10MmOk+da+6QEGldHJCVSWzT1E9qG2BbpvGMwCGFvwxyD8k6/oPGkWfNwyJyYxbEpzIzu2QNVLfcLmKqsO5ffUlmRi/QaG4+9/MdMghH4PRM4MjtDKTHqgEqwmLNAe5VVPiG03qlpYA=
Received: from CY8PR11CA0016.namprd11.prod.outlook.com (2603:10b6:930:48::25)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 20:26:08 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::e5) by CY8PR11CA0016.outlook.office365.com
 (2603:10b6:930:48::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:26:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add GFXHUB 11.5.1 support
Date: Thu, 15 Feb 2024 15:25:46 -0500
Message-ID: <20240215202548.415025-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215202548.415025-1-alexander.deucher@amd.com>
References: <20240215202548.415025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a6c10a-0dc1-40e9-438b-08dc2e645799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00tr6taW4RxQSTTEYFC8RsvQ+32oG+Isij7FpSDt+PqNR2dnyB6fj+xu3AY+4mGWjF89rT6apVNtumA+CNY23bGIpV7wBbwpgHWLpetqbjr+AwRTg31vFQgLRn/m8K75F1BLmO4zfzKxz0c9w/J3QcNh6iCjBrjcH+RIlS86IymL8mS7aIx4GYYmRFIU8RJ5PWmc4qObdx5fNktaSiWrhHqcY77WmMvf57Dxj7m2fg1Y259f+LQsRCctLOjx3DsY+E6KmMUbplVVWOvlh5G9kyNUHKTDNw52ajEQDb0ZCYh3Ur4FGJtRC/SfDJHk3Fvje7Q7LgAKse9wAigfQusMDu2Y62bhfvFG+07KvN/4m1vRKMFQ14Sffth9of6u1Yg1gl3HiLUw7zP3cjfdmdYVMGiIDPz2QFNQrKP+s7+jC/6SyHD+p2LGepSWR1gmW0ikFcFosZ5H+pSlMEB/Arh31X8rGA6N1j/re07HYqPTETc2GzV1OCxdIOkwc53miWqfk6p151OkN5PCQp3eHwH5Xf6mNKPEFuTlYi0BYVbCKxhL/hVNE25PRWPmPsc8twyzccMUZ+ofT8Xb5QDyd4G5eg4JBsxXN9KNS2KPFz8n2ECiFi+f0HOZPNH44NFo3LI1vy9WqPYZZXbKxeXQRwlUew6RX/R3qH7wI36pUszO1tk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(36860700004)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36756003)(86362001)(6916009)(8676002)(4326008)(82740400003)(81166007)(8936002)(70206006)(70586007)(5660300002)(356005)(2906002)(41300700001)(7696005)(316002)(54906003)(16526019)(2616005)(1076003)(336012)(426003)(26005)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:26:07.9943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a6c10a-0dc1-40e9-438b-08dc2e645799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add GFXHUB 11.5.1  support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 998daa702b44..a3812f0036a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -587,6 +587,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 		adev->gfxhub.funcs = &gfxhub_v3_0_3_funcs;
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -748,6 +749,7 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
-- 
2.42.0

