Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1BBECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A139310E0CB;
	Fri, 26 Aug 2022 18:45:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D3C10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwKQXQmIUn+FsKIBHNycq5WF+244skYxkU/GFvpQiV27rK51o6wtxp7NfNPt8wpV3mGQX9QDP4YYzTJvGBjGFSYgtQ4//6++xM9rkLOQ4On2WV8i5TQOXEp9evkxvBo/CHknEdBBlskCHPiLe30DJLL4ziiSI/EX33Rh1xu73nOgvOPiEilkUxelkHjWEvryqKmyR4GSk7Y2/jORMwZxOK+zatG/Daaj2i5w5iL6REcPEpP/99y/rraebFBG5SevCt+nuXC7AXUwstx3JZh2zW2Qncl9GDm5kJQqavYk12veJUYZ9ETrpDLwIEbmNw8th+GcVBSO8tCUMKLOQlXXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8tbltaAgxSWovLXIyI4LWaJSxoFsnYoB84C5ll9ql8=;
 b=lBp9weNRXXTH7tsSyeT7INFeVcjLLCG8+KmiQzYGo6+yA5E65HOil5KEwZ17K3LNqEQM1pEiv5NLoHMaJKBXdpWGsjvDqncYfvhFkFz0GELpJuz8pqfB0FRqiSuR43ya9Y+uwyrtrxtqPn8wIZojXu4QHpqCj3s5BaB0480n440mCWHwvKL6Wrra+zD6GnP2QY3E2vxlfwj2zf9hzOdY7dPlCLiu/SGaY2PrUJWKAR3fBQy+8vvIflLdlkEGnB1+HWIsUK0Kt83IghMDPfEPMK9ghNJb9JhFmHBuhmp1da3tqQIRXS901NxdOU+vDsmtAlZXgLSZWV7tVyfnkud28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8tbltaAgxSWovLXIyI4LWaJSxoFsnYoB84C5ll9ql8=;
 b=I4XeEVmm+hisEnRWti/BFCT54aS3BXP08/Rm2uwPrRylnX3+a31yTh/1lSR8kPoN9YsAXYJmG5+zkTc1Sb1kpAY+OxQrw/c9dJNVsVVZ3hbIWdlPQInnuYYB6HLWWwZS+WJllMOn43vvdlxQ1Hu9xD4/9I++QydHHgglavF/YyM=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by BN6PR1201MB2465.namprd12.prod.outlook.com (2603:10b6:404:a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:44:57 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::dd) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:44:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:44:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/pm: add smu_v13_0_10 driver if version
Date: Fri, 26 Aug 2022 14:44:38 -0400
Message-ID: <20220826184440.855532-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184440.855532-1-alexander.deucher@amd.com>
References: <20220826184440.855532-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed2f00c8-c168-4d8f-c8ac-08da8793130c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXk8r/MeD5HbNYOf53L2HFqoqa48/RkFkCGASAslwHE5sfB5XPNqw/hNguw0HMGmXSqmfBOCI9nNLHk/LOgIUpNLH/0e1U9/8AumIzYVrC5mWqeTs2TmoHDiu5Ivm4wUAphU6bl+w4gGFBA/rACV+1VlhDnrns8avQcqwqduQVIca+nUSzUUga3wNSKo+TXS0yqUdk7CljsvT/ZIDtMlEaDx3Yu73oWE5sajdrVGaOfNcDma4xNPbRJId4fbPlwbW6bOaKqtFK9fh0MbNQ9T9MEJLegW0s5nYScyvPgTphN8TUQ/mCEzRWATWbpydYDZKbJdvpMOVCpg2nmZqX6MYfMtAR8Ex59TRb4e70i6YwS5dfOd1GvYZZVIvX9NRVd3IT9RgfQGNDV+3lVSL/TZlWnhsI+dUcKwXNR6YLsYyTWPfoQ/rBLVR+WE9wUxvd3/pCuElwwPfDK0MZf2sYQPOVSvfHbJ0CB7frsnMuTMb3ToahkVzf6JxgGCVFwThauBml3TucmcgfC/C51OUrz5Zs4N1kVDjfx5l0dzBtTi7mkkXgc9BoGxmZUh/Ti970xqCNIctoaiP5CKOsCD7WjWMYGvh18pgewN6d+9XQyUXIg+FsxmTserK5d3rC7kLUre77TInUFLI6KcHwMgklEo8P8TEC6T2diwRUwTRBlTIXgfmqXqPIyAHUmJCWgmYsimeKxvYzUA7VGe2RyMteijOg4fn0cshuIVJSBIcU4r007jD3+aGUAfJdzJ/maubDRdFDfDjTYoIIbiLwkDqIyqkgHj5bpVgD/FxCG8gW3nobg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(82740400003)(356005)(36756003)(86362001)(70586007)(70206006)(8676002)(4326008)(36860700001)(81166007)(7696005)(426003)(1076003)(47076005)(6666004)(26005)(41300700001)(478600001)(82310400005)(316002)(54906003)(6916009)(336012)(186003)(40480700001)(40460700003)(2906002)(16526019)(2616005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:44:57.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2f00c8-c168-4d8f-c8ac-08da8793130c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2465
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

add smu_v13_0_10 driver if version

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index ac308e72241a..950fb7c7d28d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -32,6 +32,7 @@
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2E
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index fa3e5d1d1d2e..8e17bd5b52ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -331,6 +331,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(13, 0, 5):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_5;
 		break;
+	case IP_VERSION(13, 0, 10):
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_10;
+		break;
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
 			adev->ip_versions[MP1_HWIP][0]);
-- 
2.37.1

