Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADFC4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 03:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D261310E946;
	Fri, 19 Jan 2024 03:48:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A50C10E946
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 03:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGr71PjHw5+e/BHD2wsgX+VnPSe3u8kdEYIdwNfvkkTsNFkwN8NpFJpQLKMr0lVRBr9FBRPhRouCT2GAss59HwnKNTtLCPqy5YCw7Meg2raR3yLr4EFJCbmlXzdvZMKVjkZ6auC358/zcWyjP3EJEvfe0kje1+cBsuq/LJposl3mhpPswzqPVMb28SjxpjIaWedI3kj79DBV8wv3Vl13gkH6t1sa5InFcKAOlCh3iAFR7IdtMBCyDY0ynjK5gOuRfjTn1XsZ3dv7Vi4GIIgVr6pkpvX4hpmlUmzC6ccPPKZucEyhcCgjlU8YRsF5i6/zmJugpGNUyKZCqWf4vtqguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjalHNkZW7Yu3sogjnxGdo/Fu/RZDRj78/DAsIJ8pg0=;
 b=Awamd7JfCEF/xTjztpKr8fjAjxHg1ABUc/3U7EXYo1Imc1zA7MDGZDy2LmDWNiNcxOJxfPpslgE4oTXUuTeQNcs9XGPoNFwb4plKzxbQZYEB7j6/3gyl651Licoir59Mqak0qWQXGQ6mzVHGw8QM9wPdrBAatSZgkMC/XBaNsU9xe6XwxVnsx1h4LsM0n2gmm4AXlYd5NCDYMERvVsJ5NucfcY6XjDaQjU2me/E7RjOnyLeX1+2XJkWRPKrWYHt19xBfMvWqiQHpkO1CkBLEhpYpex1ziFrVwrTqogPqm72jWHHmMuBV44R4Kw6roT6l82WPWT/mPtJtulgqXU2R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjalHNkZW7Yu3sogjnxGdo/Fu/RZDRj78/DAsIJ8pg0=;
 b=yDc6zSopGmuWpm4QSp6cPeKZFsmwVdp84+B7N5hz+KPcRNNP9t1sbi2tETS3Oayv2jiO3QQF3nnRV357gdPiEvQgSOiMmEys35RlHSSCQVMD09oPglN1lxbKeZIYkYZpAllFRqQ7QXVFyeRNvPpj4Sr2wGydisjwQT5SIgLjAWs=
Received: from DM6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:5:80::40) by
 CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 03:47:48 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::45) by DM6PR08CA0027.outlook.office365.com
 (2603:10b6:5:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 03:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 03:47:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 21:47:46 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: udpate smu v13.0.6 message permission
Date: Fri, 19 Jan 2024 11:47:31 +0800
Message-ID: <20240119034731.2271175-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6625588f-07f4-435a-2db1-08dc18a167a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: th9+CA08yakGDgTI47fEGCABeLozMypVILGkc1+JWX/JRpdOazuVArSCx9oVqoutk8tFckp1sRfFqhlC5Rodt7lkzD8+0XPQTyAH+ExknE5Q09Vlor7D+Kd2xbXN5g1Y2omjOp7gZJ4GJsNJ1Qtr4K573jaidV+U/X7kHDgtpSiIK0xC52qWr1NSiFr0IWzxUKC2vtb5IJeO4WGOPWQDHdtNR6hxBHRxxiO0fHgcvcqsiCjb06xbIphti6mP0Q1B447ENbTgd17M4uHm96bTreb00p1v1bemr+fgy3od4vU/AMlJxYh38Z8jYzq7s7/MjkjhWt5ls0o6xs4AT5ZiwwQCEp/e9bSc6nLpNk1hATxbqELpP/XKDFoIhI/H/0qYJ/5uRtk2ZaJxB9qKRXOL9gJ7ctNUvXt/yQ/pTkDka7QfvrzeCYE+dxq3r7fu14j/yu1vq+M0rNMWJ6C0Jh/C4mPSSQWUVWQ/Gw5fcoGD4kVyoSchdammB7v/h1R/p7cH7NRpDs8zrKsNj+MX4EIRYUAbUwFFdbiAnguo4Duq7a29C+vSYouy7IrgnkrUKN7Y1G1DpoVbuAXn5AKKwNRLQa9aSehTljrp+0QyS0dWOdezh49uNLWr9ZkMKns1UTzlyDfWfF/bkX9tjdhcL6W/ikZ6XKjhSUvN8gT4XlKo8ACjy407zEqHwr1C3AFHWBKM4FtaajzQ36JJ5V3V8KdTp7KqASZCnPZGIbKStXE2ywCfhnY9rmiIc8H0/HmxwhyIO9YEkVGU5nI3A/NBWNrY5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(70586007)(83380400001)(70206006)(6916009)(316002)(54906003)(2906002)(36860700001)(36756003)(86362001)(4326008)(8936002)(5660300002)(41300700001)(47076005)(8676002)(82740400003)(15650500001)(40480700001)(40460700003)(356005)(26005)(1076003)(16526019)(478600001)(81166007)(426003)(336012)(2616005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 03:47:48.6797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6625588f-07f4-435a-2db1-08dc18a167a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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
Cc: victor.skvortsov@amd.com, Lijo.Lazar@amd.com, vignesh.chander@amd.com,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu v13.0.6 message to allow guest driver set gfx clock.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..35d8a309eaf7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -161,8 +161,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                1),
 	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                1),
-	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
-	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
+	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                1),
+	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                1),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
 	MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottlerLimit,              0),
-- 
2.34.1

