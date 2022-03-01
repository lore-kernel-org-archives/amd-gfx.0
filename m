Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E063C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C82710E61A;
	Tue,  1 Mar 2022 16:01:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F0210E61A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMO5Y3Jv3T2Cb/N5SvUjrcwePDqRN52AllXSohtYN3BI8bFjixCekyWagJrl+rTOC+IFULNOaH83p50+nD3GpyIsKL9e4S4T2e1+xvLHPcW83DrnvfvVWJkjFkXP6LltwcvrhTAP/dDWdZIPEALCHFwk45RPWxfXURPL4n5/wAXP+giCcOJwdkH7/JBCPUajxBvCPF+5ygzGHkmZa5n1f6/JddQ5RoERuRHm1GebbHLcf0qthI0EvZ4e+bVPSeKV5FAkdMUCz3C2x/hMYCan282PTYf8uiqAzJRmyUDgP71fxMYpa9XCt3TVKPOlNIq2L6+3lyJGhrynFzhXYjXxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49qMvgNKgGtuEYkvYIAtleCz8irfosXj2RQnSkBHApc=;
 b=LUHRUkcjD+TVvx4bIQ51Vxo3dy4gdTR+dFYJ4p32xGSjA2uXzooT4O5PwBZxgF3msfUZIWG1Vm6+xKzmI2ggc74p7L46P5CyF6W0JY2kw1x2lFZ17I+gCZRCChG5Q/zGNsklx4sSakI00gCYSredZthyLI3ylZme1zbLh7Dbt22T4mGdYJQLSKOzezZ2NsF+JcXP6lGYGXEmTIco7X4xYMsEHZy1ZLkLYpkSGfgSdDBklVbXlf7wKFJ9uGLeV1RfRBYX7Xixn2vcISawU3J6iovISVKnE3O97eZwehVQD3jop11Z2b9ZfDImQq2SrMyZ58BWxWGly7j3yDBUtAxnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49qMvgNKgGtuEYkvYIAtleCz8irfosXj2RQnSkBHApc=;
 b=YlLti5CZhYcg1jWvoRlbBBW7LjDS3Z/3sgg4RzCzQP+wdEDYJirNzgjrXsNLXUDZw631F+CshotU4P0RKW1Duit0lpTwH7MS8YnyktHwBBScNZBC8otmFgbz2rgKsLVMZU9RULMozO6ecxmTqjCn/QRN/g7dXCzIjqdUrlrAcTI=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 CY4PR12MB1735.namprd12.prod.outlook.com (2603:10b6:903:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 16:01:28 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::4c) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 16:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 16:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 10:01:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: remove unused gpu_info firmwares
Date: Tue, 1 Mar 2022 11:01:12 -0500
Message-ID: <20220301160114.1404305-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0866b9b0-f565-4370-f698-08d9fb9cbee2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1735:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17351F5613E6E2A6A24AA9EBF7029@CY4PR12MB1735.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmNu/EzLlpBieKDnoOaiRpo4i++W/Xk3s5LfuzljE5A2epAQx9ZeAdNhOwIJvOOynbLdSADsMmVEKvMieXkMGdsoKDFxmJPIbHoqnP+8ij1OWUG7PIF2im2wlT/DFseklq39mEOftdPIMTD8jHGKYMNvdwdYWbEAIVObM2yDrRcU4pmFb1pbaMDBTBYH/kvFhXp/opxO11ci6k34mfO5AJzDh1IRAv+ZhRVcvbQHWPQCjIWs9jb4jopKnGncia8ZxBBtzqbqvsuYyiIMTkZmrTi405rRcKa8hET73PNkQzdA5HLelWcg+IYR3ZhCWdc7ywHA5mSHrQPOlgSX6RHZ5+ySpjepSq4g/fIRg5/RIgk183Ts3Qu541bkHWDzoPwHF/dMyh+vR/Dgp1wH5HOANQLYBejvBgw1eJufGmc/pefLEn2AXgOpVhJ7nJbfJ/hZ0GMm6qjF5Fi/mLHWy7xiaKbCsfVv8oWgSAc3skW8jPzQ44Cp0OTcQ9n88anKX+jcNygx4Q8ySRxZ270Ro6A3DIkzJBq/23BNefpEaLKZULS5hPdD9CVqXAYU6baXv9+894HHs7j27Cd1KckwG8WZyqq5MhIuGwpp5/2lmP2bwuOAH06ksZVUWQ5L0aOpIVvJECwNO6JPF3e94sYcBfwUZf/SNMO9Tq/ENhZixEzJAvbtUO7K47qpFI+2Ew1ILEpCnxSsrkXk5rsuwPSp3BAc1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(356005)(6666004)(82310400004)(7696005)(16526019)(186003)(2616005)(26005)(1076003)(336012)(83380400001)(47076005)(426003)(36860700001)(36756003)(86362001)(70586007)(70206006)(8936002)(8676002)(4326008)(5660300002)(6916009)(316002)(40460700003)(2906002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:01:28.4557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0866b9b0-f565-4370-f698-08d9fb9cbee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1735
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

These were leftover from bring up and are no longer
necessary.  The information is available via
the IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6113ddc765a7..2f732a1758d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,12 +80,7 @@ MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 #define AMDGPU_MAX_RETRY_LIMIT		2
@@ -1992,27 +1987,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		chip_name = "arcturus";
 		break;
-	case CHIP_RENOIR:
-		if (adev->apu_flags & AMD_APU_IS_RENOIR)
-			chip_name = "renoir";
-		else
-			chip_name = "green_sardine";
-		break;
-	case CHIP_NAVI10:
-		chip_name = "navi10";
-		break;
-	case CHIP_NAVI14:
-		chip_name = "navi14";
-		break;
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
-	case CHIP_VANGOGH:
-		chip_name = "vangogh";
-		break;
-	case CHIP_YELLOW_CARP:
-		chip_name = "yellow_carp";
-		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-- 
2.35.1

