Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF8CC48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 19:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E4E10EBA0;
	Thu,  8 Feb 2024 19:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FTvsLoNQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051F610EB98
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 19:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWc78D7xpwO7IQYjYyZNnC13lFxX7e3zkExwueJ+iWoj+KEJicspMarlmGF2CpCFRZuAH8v6ooBPr3QY6YTRhpa6oks0sTrcgVUEPAER0XOyGc1A5XimGhKF6Do5xVmleAwFTtIEBJXuheqik/TxUn+knrh5c6jq9N+7jnqyEd2bFmbY8iKf1H7wc1PgW2QUVJLuSIux7NU3VoRgdZctWtnUlR9jqfTcwXBUCiALWeM5KbE6c3o1RvvYuEVW4zX2m8/ooJPJq++1kn/+vodoZYnu6I4rVI4Bn4D5JQHTSEDUqOuD59BwwLtsjKiQcywkTiOGmvO5aESaYiJVJ9vt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl1+fyzAOLsO2JjUcaA+/KE7NA2BFZ7vkFP4sCF/aFA=;
 b=RrxyZmSMjym49iV3HN23Rpy6QV+H+pZIaNdxrhVgF8QAbNMLguQwmSk3DRM+b9aZ3h0eDkjDboskZ9BQiSzIRO8AT3tUmnE1tnwqyANEoEfp6sSSNq6Bhc6Qd4BLlPy1l8x09IIMPWvS4/uHBV145Dxm/TWoKgjyrEyp3Sg45b1q5jqEmd/p24xrE4Eva75bpfVZGg/D1lWhDdOqa3DXUMw05QczMp0g2i4xomGDu7Sg1UddpcG2yL1dVDDaIJerrcwhKREIU6fVZfzpgmicwWnMuLtdPsTwZ3tXfbtzLo3jitVA28XkUIwha1/2ybsIDldhV3e/0pSHs/kWka9SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl1+fyzAOLsO2JjUcaA+/KE7NA2BFZ7vkFP4sCF/aFA=;
 b=FTvsLoNQGpCQaniZ7/cpTCP108mPEVS/6A3vnKOJiaK+jdjfTBBryJzHz1vpDgOIUKk95rkOpRj1DFhLwbYtDh3q7ce7RsvYEs5J7I5Wd4VJQdTAyijp3d/RQlVmzUI76TIQ3wvWFVAhcox+zbMb6kQs8zC8JWfBK3GXYJUzJk0=
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 19:53:48 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::ff) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Thu, 8 Feb 2024 19:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 19:53:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 13:53:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] amdgpu/drm: Add vcn_v5_0_0_ip_block support
Date: Thu, 8 Feb 2024 14:53:30 -0500
Message-ID: <20240208195330.408853-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208195330.408853-1-alexander.deucher@amd.com>
References: <20240208195330.408853-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: a26746ef-e277-4912-9e01-08dc28dfaaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AZ6npzvw+hhJbqihsotIzNSjcufdziliarLyz8C9ZeWVbV0IpkmbfNOe6WzBg5PkY6nX2Nwgnt/P0v/vLQ0HDKoP/dI/iBdhs1fYVtJt1THvq8u7hQ1U3/wPU82rq53aw/5g5BoZGLROyRNEUod3MoxEgvhgCdTLlh5pq2Rl+TF/KDMQk7jXd3itJ1wpfdXshWggw0I9dhSW59ySAi1hBtSmnEKZv8F8s/8dmxkwV7HlSI7G+LagKnvjuM8APXoi1xwPJXT0rQQFUf/af/cKe0jdYhMzRU9qBbGunS9+5gz/h78Znmc5mH4pZRNf850fFMIdEBwftCFVhQs0RZdTpKQtCBx68DoRbCBPrqgzDAJVUcZc5WuzB1sS85LmA5fSSG2pM/lACimJI/FqcM6cSfjLDgixLqFc69JtipqrWJS8767OAy5w5HbGiyB5L7sbFYrMOlYnGX9ogGPf7jFTAGMLLbya+aOSuS7CphTHliYD4oKY/ecd+gSXELANFK8yecAtNoFNMsP1KfDzLKX13GJoFgUYrD4m2aQQUMZnZTGpZzvn2tECtR8KdRJUgl9K3sNMaPXYVMZ8h/uC70fytbiaG2DXUJCRjMYesGSdzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(54906003)(83380400001)(6916009)(81166007)(356005)(336012)(26005)(2616005)(5660300002)(316002)(6666004)(478600001)(426003)(82740400003)(70206006)(4326008)(70586007)(2906002)(86362001)(8676002)(8936002)(36756003)(1076003)(7696005)(41300700001)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:53:48.5556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26746ef-e277-4912-9e01-08dc28dfaaac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable support for vcn_v5_0_0_ip_block

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 59530fe36b6b..399428054c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -96,6 +96,7 @@
 #include "smuio_v13_0.h"
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
+#include "vcn_v5_0_0.h"
 
 #include "amdgpu_vpe.h"
 
@@ -2132,6 +2133,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_block);
 			break;
+		case IP_VERSION(5, 0, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
-- 
2.42.0

