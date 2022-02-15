Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C3CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E8F10E485;
	Tue, 15 Feb 2022 15:20:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E569D10E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/5L0/PyK1PSpr7nS3msLJCJvooLDRI0AZwjqwsKZtOLwCK0apxOCTfztf6DbQThcAjl1elwn6bBgjFMNatbFrZSB6w5ZLpYya1SZl4x2GAN5AeEpEdXaGWC6Ak57p+ek+UaUhKs0B0O3zZOvdv4XSgkRWlJ1/trB4KeBT6F320OnfyMhnZGRpSaRxMXnH1nQQ2xsPeMed6kXbvXLczcANC8vw6v/4Md/gP2lPQIi5axUD7HLxakiQItlG5U5zlut4k+hvVHhtNbXUtZWN/YSMZHFfWPpIP/l9pz98SUPD2tvmtXzcqoo7LIW+CwnPB+7qmVrBbbfnNQPci9PetZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZJgzhGcm2WU4nByd862MRv9zNQZJabSlH/2gElnigw=;
 b=YTU9M1/Qe/IxMLLT4GxyAs3QsQX0uxr1zOmUTQUJBSvATeETFR6zNqS022zW4nD1/mokV8Q9sIJWa8pI0foaxhwbvEFXCaHoL5slCMCGbiKrUfGUpwQuDbOaSwMbYJhucPHQBpvLsBRYxK0FyJBWYFHImxEATrdQN9Z9Gfu3Fm86friVmRUgotMZVn8fsVtzPdoQYv0cShosNi5kXbJPMW2df/g95402vZRCIZS37pecZBtDGHFabPgbezrmkSaWkEMbL5hIGvRJAor4wAa2mRAk1pKYpE6x/pY4JSEZMQQLxD8V87MJc9X16UDOE4PWbaJjZnWBPzcZubH7y7zqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZJgzhGcm2WU4nByd862MRv9zNQZJabSlH/2gElnigw=;
 b=xvp5K4bKQ359Si54LunDd8tqeYPhxLzEtiCF6aOJgS5wSFVNONtNVMZ/raamlyuFvi7yU0Xbgd8l6XgtFji8VvB8PPo6ib5n3OSGpxp7EpeAeVuXU8qCe/hdEX88s3ibT7Vqh9tDZ/ZImBNQyCgLvPDLXGBqoEh0FhwLJY5Yxh4=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 15:20:06 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::95) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Tue, 15 Feb 2022 15:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:20:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 09:20:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: Add support for MP0 13.0.8
Date: Tue, 15 Feb 2022 10:19:52 -0500
Message-ID: <20220215151952.2229759-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbba03ea-389c-4ebf-f4be-08d9f096a4c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB401060A26A9223B6925009EFF7349@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtMuTI7fap0X+ec/556JTPig5SqmtDzzAlRcCrRLdJrx0HW6upHv4pqw4P/pR4gysHhWA4oAtrZh8/BOGl5fsIBvrbl3b46gyI7LQn7/8cMkThtOdPIy1kOsK18S/YZWBF9PjpOGhmAo3ITBGNcA7Xl3nyMy21Wm+siC+t6SWx31Oz+BzBLVg31Q1nlce3/dBYQWJwnKV+OiVtI2wOIuBsGzAb8+TJ9+qUJeVQwx6wH5YeWwDnXtbLbJ1y8a2bIXDBPsNot+Bq4L/qe7KFEWM0n7F52P3WuZhS6pum4BB9/dBdpNh9bW2jEUPI6vuUrQEMIKA3rqxzfwJaqXR89gGr1khdGCx/gWTv4tsooMkaGmMZGRQjA1tGfTRLroLJc6VgjScCy58HZ/PHGbxcAIjqDupU+ruLKpEN6wEuPTk6qbcpUBPrjvbteHQ8p0xTWsDJj6cgPhl8nkXuZYUAHvVfuX60SFOripX576cD4napJT1b/212/lMquGmuTW5m6roBzCdzq/HVPb3T7fdyhjWUgFtO0Yazq6t+b6s+/yMUP4wdXWKunCd7Jf7i8v/7keEZ4mnATQq4so04b79q+BVgeOudWmmEOKG9OKbFlZGzlsL5Y4gTcSb3YqGItmHUfpK4r8jWw2bGTQcOPxJ8wVcXROZ43vwfOjAxHaHW42KKgxJZTL0h+EvHqHhqaD2maG93iWH4lH6XAG3UuEc1Cljg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(4326008)(426003)(186003)(70586007)(54906003)(16526019)(1076003)(508600001)(36756003)(8676002)(70206006)(336012)(6916009)(5660300002)(2906002)(86362001)(83380400001)(40460700003)(2616005)(26005)(81166007)(47076005)(36860700001)(356005)(6666004)(7696005)(8936002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:20:04.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbba03ea-389c-4ebf-f4be-08d9f096a4c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Set psp sw funcs callback and firmware loading for MP0.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 481b7b872e2b..9513fa36c02a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1287,6 +1287,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f2806959736a..ecbdbe3ea4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -133,6 +133,7 @@ static int psp_early_init(void *handle)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 17655bc6d2f1..17160849a811 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -34,6 +34,9 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -55,6 +58,9 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 3):
 		chip_name = "yellow_carp";
 		break;
+	case IP_VERSION(13, 0, 8):
+		chip_name = "psp_13_0_8";
+		break;
 	default:
 		BUG();
 	}
@@ -69,6 +75,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.34.1

