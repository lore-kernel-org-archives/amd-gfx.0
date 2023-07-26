Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E5C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 14:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED2010E486;
	Wed, 26 Jul 2023 14:51:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DA910E486
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 14:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBQ7DpoxkOXpzlAsDgy4nybyRz4zOZ+WsbhWNTumuOX77eGmUkkuwRZf6CwPn4I598Elpb2/9Etw4omfXP8r3Msjt0zxwMjXZdBZ6RE+iwR7eGhFLY+2AWsvAlPx28Ury1t9/F1JUwsBm3eNjO914Cvgb6VRUgddzygxItC+wVYCbqOrQ62GLfEybJwLYSrT1h7ckBXMdlGhWeOAqr39tWwiJn/qmdPfEpBMYjgZwRdQ/YNmCq9wwco2t+Ls+/geGTW9bkqnCkn4LljNZGVdtuOVhk3ypBukOxbgdY9k2DTs7kvFXT5LdXzG/mEc94TQo3uO96g/zVBTSKS4ARWprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvkPnjo+AlaKX9kUXCgN9qZMI0pInFt/aY/NQERW3no=;
 b=XFQ6SHmPvRWTVIdL2Hipzjvz+uK0YRwecpf1csMLH9R9oJHxAKwu+MhfvZBMG5TRsFYHhIuLIEGt5dx5f8CjG5tAFvBVMTvJOzMK6EvN+EzbfvBbq2EDM5ve2S3cI34CzXYMUyTKS5sZEM+AG7vEUU/MHu477+epdkLt+qD6UM1lhMNYSvWp0LJ01R/t9E6rBRE+urxTVyrWIM0H3llOnRy47RWzUKGQa9tDhj0HaYFLff8zTi8ghUmi16VRxT0Ck/GybStFAon/JJkoxk+S9noX9pHRJvM+kTLU2y6SZQmvmRyewPE9QxzhoZeE6layRNAVumY8526qHGHvrU0kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvkPnjo+AlaKX9kUXCgN9qZMI0pInFt/aY/NQERW3no=;
 b=vMO95Rpt0Nr+G68Z5kvdTEfYFiMD/LwCsi6F+nwGgDI75H2ce3perxyUZH0d0MyIHWzSiff3a1G7OmqMUGNQAdi8BzZ1f2dl4npzm0xZ20MhIAUbFgtxYqx5jmFtPDcmFAfG5hYMMVxwNVfhAGD1bhGVgmzdd6hf/t9COvHBrlw=
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 14:51:41 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::56) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 14:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 14:51:40 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 09:51:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/radeon: Prefer strscpy over strlcpy in
 'radeon_combios_get_power_modes'
Date: Wed, 26 Jul 2023 20:21:19 +0530
Message-ID: <20230726145119.2482465-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da9d27b-e5f5-4447-5c00-08db8de7d223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6LRNWeYb9Zsr9gAun27WTRDZxBlpl1EFir/nhzV4msR36PjeaPLzwwBXCFa5F0+zNT653kuA0m0I7lVlhfxjWCql5nN8GGb3UhilplpJMfVg4YVieso8QTHWECrar8IPqPonoxU5Dcqax+UM9gSC0Pb1ni3ONwcrO2LslGuO4v7DgvRX5rWMoXWf6GVxzmMhd/BurOCPFUiJ73Ucnt1oYdu03+SCTjuJNFwfcJvHiy+R2lJShHm9TFsr2id60XQ0t4KKRrA6GEvuZEA7wTVZrmlWKzYzbmpgf5JFWH3NysU8CjOqNQTfAgv3lS5+OEgUyCuhP5LHRnZFwEXZc4hLefutFoT0ocFFPZ/0tzsHJJWiGAIO/WSszq5nxPmBEjVAIRqTYKact6amHjG4+SnUziyaO2GiRivessZbYKCTLlqgRiogedI/Ztqe1q1Lbz+kOYD3FBmeblATtmP4z9LNPPjuapQlSKpgebf21z6Ox8M2DLN+g4lyETJ62ZgexnyOJcCAreVTHhZPX3kjHQo1YyXsIolfJ53LEXludiFICiMr6hzuo4MaTmUNe1BREwB8VHIuMoCkQ3h54Oe1pda0lAcL6HjtZgz06gjVmX90Fcq8ZjfmlEqSk5Y2Fg0U5SQpqYDsDy7IiDW5acR08qnx7ImmQ3ThrqqMhgiEC1hNZM/k3GKISTU2uNEKT16yLVGvsC3tGPno7R+zaPMjg+RHdZ8IzxpSMXjMWU7pnTrhNwqV+wA27HlcZFUVjafLZr5LMluuIeBGXKcjx1Z0o6S/VaOnObC9hyFR9AeLKC47yQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(44832011)(2906002)(40460700003)(40480700001)(47076005)(83380400001)(336012)(66574015)(186003)(16526019)(36860700001)(426003)(26005)(1076003)(966005)(356005)(6666004)(54906003)(478600001)(7696005)(81166007)(110136005)(70586007)(70206006)(8936002)(6636002)(4326008)(8676002)(316002)(41300700001)(5660300002)(82740400003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:51:40.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da9d27b-e5f5-4447-5c00-08db8de7d223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

strlcpy() reads the entire source buffer first. This read may exceed the
destination size limit. This is both inefficient and can lead to linear
read overflows if a source string is not NUL-terminated. The safe
replacement is strscpy() [1].

cleanup to remove the strlcpy() function entirely from the kernel [2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Fixes the following:

WARNING: Prefer strscpy over strlcpy
+                               strlcpy(info.type, name, sizeof(info.type));

WARNING: Prefer strscpy over strlcpy
+                               strlcpy(info.type, name, sizeof(info.type));

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_combios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index 783a6b8802d5..795c3667f6d6 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -2702,7 +2702,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				struct i2c_board_info info = { };
 				const char *name = thermal_controller_names[thermal_controller];
 				info.addr = i2c_addr >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		}
@@ -2719,7 +2719,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				struct i2c_board_info info = { };
 				const char *name = "f75375";
 				info.addr = 0x28;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 				DRM_INFO("Possible %s thermal controller at 0x%02x\n",
 					 name, info.addr);
-- 
2.25.1

