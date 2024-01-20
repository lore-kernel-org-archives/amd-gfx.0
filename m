Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88557C47258
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jan 2024 08:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB8B10E230;
	Sat, 20 Jan 2024 08:32:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9C710E230
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jan 2024 08:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1x4xdVd0qyMxXrKJ4Rd8Wpqk4EO64RaZ7BgPXBIBRHLcJehTnR17DO2ItBWJTeAyw5kuuDH6Ma3U9V8hULqFcaRSg2GG3M44P8FJKnqej+N8W6RvD1e3BL68LcGT++HsWFXjF6d3R9a473hiO1c6KYzq0NqrvaDY4pchUNMEQ5lkVZgSPqxmEVohmhlX292FzgQJc38p/V9WzaMmDW+ueBtC5zLW0tFkQzwenQ1Uq+mSNYI3Poi6tsfFQLPaJk7oDv/xFncXrRkzDp2zPWiCVMwVNgJOCwtC5Q/VWCxGK1mC1BuEa7ZCggiW2YYM857imKoXBD8qoZ+HNLqpUzy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeTyux5blioIL7H2rqhlsqoMJJRBztS1OpXz5YS2PUc=;
 b=MfzFM4invNX6kj4VraLeLRXY2cq3T9UWDINQQDZvH+IbWm8q2FYZMK7R2WzMUWW4xfET8CNQ2/+PVLR5LweUcItJW5e3vofctDThtGfdXdBIdFsInhCyjXuXQqtKXZzcyBvghgCI6XBwZ+w1fEpZ6ACwZR1BYN/GK+IZsmkBY+YUFWrDHP3zZm6e1X/RgLxQvOpq2zKR6d02FRX+9BN8TPQJAf/V2iNVjX82YMecLgeAU/D7PGbqhh42Du5txG/NcTdm+7fzFldtpbY/uk29/nx5WQp3qfO3BT3sIYE0qja4nh+mgd5VJkAWG831WylcfsWZoKWqveKjrG2wO6ulng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeTyux5blioIL7H2rqhlsqoMJJRBztS1OpXz5YS2PUc=;
 b=qOPn7FK59x0v9gLB/YSQKxtl+cBH/PnDM2huufhr0XJNZ6S7mkwZbLMxy9IzrFuRyouzbKeO7CcSEHXTyUdXolcwqmUWY/zxC7lyKKjO/j/pzvGRr77x8h56MGCcnAZEJeCnoOECo5GZ07y9wr6lrFw1KPzTT712pXQt4XfvosA=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 08:32:51 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::7) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Sat, 20 Jan 2024 08:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 08:32:50 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 20 Jan
 2024 02:32:48 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
Date: Sat, 20 Jan 2024 16:32:20 +0800
Message-ID: <20240120083220.1804937-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df4b2e0-0098-470d-3d2b-08dc19926391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sv+z2wVPX4h70qUnuqEkaHDnS1+LRwzWdFaLYNl5uS97SOKF8muR/Ix7M7sIa4C60GHBvI/P9QdV4Anju93q/zemmHRv8ks9nnkXPaSnlxzhvHLhEuhOgHURiAqCW0iisdDx9t/UJGhTkvQTNJeu7dvQLSEHY40LuNtNJIk+h3XXInZLwyaXFdh6+u23Jn4SI2p130mvHBvq54TiVCJolepF1mrWzLoTdddYpa9Y1VSDQy90Eixx0jHbeTPuhUrK5lOxfJozM4UJhVowUTjONRMrb+B8SFK3lDHVbtV2FK0vxm4MCVcoMuBFgZO/pWxUwncuu7+rekXssyloLqyo8Iy+igHuVsQUq+xMjDp7tVa7FGKcPizwC92JPx+fdRvK++eEaOKelgxIRpFZtVLBBidIRX6qUADFhETx/lgr25jf2zRy4OXVbycSqIub4cF1ZVTgDnDx5l/qDCwD2zzQRQkrSBCKJW/POyGprFbrJU9387Xy1YH6REdm8ngUcHy5L19KF2CogiK3Rv62YkwnznRVU65x6zKpmSxoy+uKJCoUVs4EL6CE6pfZoTYIfzmQt2ZP+xL4ZIk7LjRlrSE6Lj77wdK2CDc/0bhm026HfLZu0Z3abLk0+vmj9l+ayGh5X+g8uG0SSjZcEl8JYniIfuKbYL8wA4WrQ4qVlnrdyBazI4F0OlOYHFz3H4LYr5o/ReF/1wT6TvWi3dIX/x/LpxlFYAYqRFsvjdVVWQ1cIcTkC9KmSlIWePByRxh/lkb/TweG3ruA6wxrCsZ+u0g1Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(16526019)(81166007)(26005)(1076003)(426003)(336012)(4744005)(356005)(40480700001)(40460700003)(7696005)(2616005)(6666004)(316002)(54906003)(70586007)(70206006)(83380400001)(6916009)(41300700001)(5660300002)(4326008)(8936002)(86362001)(8676002)(47076005)(82740400003)(2906002)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 08:32:50.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df4b2e0-0098-470d-3d2b-08dc19926391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Kenneth.Feng@amd.com,
 Li.Ma@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IMU starts anyway when dpm is disabled in backdoor loading.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a2d3cced8f19..c5b1d036c95d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4324,7 +4324,7 @@ static int gfx_v11_0_hw_init(void *handle)
 			return r;
 	} else {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+			if (adev->gfx.imu.funcs) {
 				if (adev->gfx.imu.funcs->load_microcode)
 					adev->gfx.imu.funcs->load_microcode(adev);
 				if (adev->gfx.imu.funcs->setup_imu)
-- 
2.37.3

