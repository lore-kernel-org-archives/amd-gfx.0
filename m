Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4D3C25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 10:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DD410E972;
	Fri, 27 Oct 2023 10:30:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4D410E972
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 10:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYMOSba+z5y8YTJU1CYISf4DyouHDJR3cPh2tCLEnYE9TChK4NPTRH2nSqYhwtBpNm6BjSTbI2ljZRa3UYDV4LYYOC73gVs7gOPJ/6TGuqMX9v/oeWaHaKFMH5uUFo0VNOi6PRkhADYx+lP3xpiE37kGNTcjKfa4FESWdy/9CjYTtXohcgU1iD8H2q2MttM8JYjkLSXG2o7UA6Qy7uJbBorlp5ylqN1rYj3lQ9Q1kX0swAfHP2MHldrr54NOgNU7/UVuR0XZ41ImfaNvS+p+wk+9TeqCDBzrS08lelk7CMN6Jw+o/DS+rkNQDH+YGyUlXHwTi6Ud860/CTvi5fX0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwvD0BaoMVewBV6D3rfetYpefJRWuMYDf0haQrFpxTk=;
 b=jT1PqRm3s1tCoDx4+5Sgm05yvDkf6Mtd7rniDfCOAKR2tgUaYJiRcQvvNL1whrU3g+c+ShFg0A89m19FgxnHumGb0FzvWBo+ljPPoaGSs2gxn9i5FD8TnAVLMVa9ANB+V1/JHT+SiGuh9QDt6TsxODl3yOVFogA5D4QKpgL5O8MZeHXoLLnIpye2AiFF5iQGOpaEsK+vT6Y221IznQxS2fBR/aMTjI8QreYvXia4KEjm3jbKvqGcrlv/8B0nxCPNeGFVpQVbtOkgkKoGtMHR6ggLZ5/GQXQwp+mS9Pa2r8BjccXHTpK12jJ5txIa4d6IBCy5cMgJX4I3aeaH9DcEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwvD0BaoMVewBV6D3rfetYpefJRWuMYDf0haQrFpxTk=;
 b=Ew6ycycRX6pGaZmo8376zmW3SxKJnyVr5UENJgwhJlGJZ3WJhmzPwfO7Bcw6nn3bSe9jdhuIMX1puWUCs3I8PIbP5yKkxizlzFfUdgoiHUZNUFTGkSdUVVfY+zoUtF0m1spyf4VWxf2eLsgYz8kLJHhHwDIuaYjyWAy/k9S8Zv4=
Received: from CY5PR15CA0185.namprd15.prod.outlook.com (2603:10b6:930:81::24)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 10:30:06 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::ef) by CY5PR15CA0185.outlook.office365.com
 (2603:10b6:930:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 10:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 10:30:05 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 05:30:04 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Drop deferred error in uncorrectable error check
Date: Fri, 27 Oct 2023 18:29:43 +0800
Message-ID: <20231027102943.1247582-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 781b4e29-e6a0-4722-b88d-08dbd6d7afed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7phde2X3wAySzCcHh7/XlHri/1V9bQhmAkfsmfmfokctXkopEx1W0BTS94Z2O4uZJuV0x8x4zFn+NmkQGYPtUF/livOcOG9cPJ/WyKZj2QEo5q4+st7k5AxS3fxXFySys+FSuMmblo8NmWiYP9KlhFpOffcEyt3FuIt0AAFSlHKTsTANm5XLkw2Nj1E0JtcJhiMb3O6mVqnh8ZFNkHyWX7I2X8TOExBwPTUESLdiaDja54nXtdN8oxivSQNdHo48siqr/4FxQlhnQ6IALpnumFvuO1BqoqP46Am0llIfFWpXvgITa2B///0GIjzjdOavx1DhtigHjRgYOToAPX9OfTifa4iEOViq/OHE6cZ8Sm+CHjn2eQrKZmVtauu5CWANPsUJTF4Qm/wLt24F/fQWSKACwPaJrkNUWGAPDsmsG4VCUtQJIMmDWCQtYVtXYqd6MCYAnZBWsn/ty1NrrasZoSn8PHK1Tghl4EZ5rzsHjgENxYZ6wd4X729+NVS1ZXiJ4ewt25/kJXUCZezTAMqXUc4Id9QRKK1vmoY29Gn5Zsk/Zx7j4Y3u3pxQKrHYVtlwHVdM6Ye+WxqUrlaooHri7AWFsBRFeI06aHWzokJ2dbtoH9PbAslVRvIk6Y7May2AuDnhocsDewt6Y9G4UBJF747enoIpllwWtzDmNWfZvEkwWYp92F89/hh87EWkBbnQHDKr32+7BM/HZ1PbQUM++zTDSWrokBuz8yYjEDmkbweFclBX3WYEDH4FLqcDyVVZg489GeKN9owlzfFyodEYJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(36756003)(4326008)(2906002)(36860700001)(478600001)(70206006)(316002)(86362001)(6666004)(70586007)(16526019)(7696005)(6916009)(1076003)(356005)(40480700001)(426003)(336012)(82740400003)(47076005)(83380400001)(40460700003)(44832011)(5660300002)(41300700001)(2616005)(8676002)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:30:05.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781b4e29-e6a0-4722-b88d-08dbd6d7afed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop checking deferred error which can be handled by poison
consumption.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 743d2f68b09020..770b4b4e313838 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,8 +91,7 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
 {
 	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1));
 }
-- 
2.25.1

