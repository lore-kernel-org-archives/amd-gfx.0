Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3F0C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 21:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E4810E77E;
	Thu, 30 Nov 2023 21:56:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B630B10E77E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 21:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNSQ9YGrkQNSRKPw0rcQqlb5mt007a1oI/8ZWPEajUGeRLKOwwHAe9F5Hl/lCm1BtARkfuWbattZkQcNMnnjcujI18Xx6iViul9QACGCuvxErKuBchky7Xu0fRiRrW1Jg/HYQNz1qWBUwAQWTpAE4nzPk04/iWA8vH1msm1LM6zbXOFomzMPN5K4bpj+hGFy/GeoyFnUwhEOz2jk6lXr5seesNNI/Qlq06a4jzGhbkChbmCMZxmO5NQFI+uDdqygT1GcUeuy0Zz1sJriq4+Q2WVc5yeAAxSJNq2qWhHywLh9T7xdVvtUct3l/hcrHW9q1J5jAEca1bOobHSY2e0E7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvGKV8K+GTA4Tr1UzIMDGALYJPrY9EPpoZypjeSLrW8=;
 b=fup8J9WKegEMpPKMm5InKkqlxlBRlR2oqNTk+q5ODflxFoCAya9HumIar0TkRFTUaYjTOKH+GiUhMZlqaKQSeBWVJ1GnERSfnPjvg6wsA6NdPnPzIvKgyvpW5w7dWdQKPbkXlhmeWpVeAD6ltQmySLtV5VhlmAj8vk7cFgMZyY7vjaeRWjHp705ScSTj+iKvnpHItkNhuJieA1hHDHg6RVO26TVWR5oyJ0I6MmuxUZhSVBVPCqSP8MpuYjFxaKfEkWqU2JETq8ZTC9HGjj0CXPK247MlS2lKFgBDUKKp9gvqDAqqpz3Cxb1YXWgLUdUHw199E0nC0zSaZIuasG4bAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvGKV8K+GTA4Tr1UzIMDGALYJPrY9EPpoZypjeSLrW8=;
 b=eM8zlhct/yDfNGxk7T4mKnQjnclJ1ftahm5NTviostyjcZ4aomgWuu438/DXprh6EGJd79Z9SVyX0I8SlZjusWjpbB+a/L6seajBmw7e/3RQBh52LXhYfuKGJDqBCX1gtBP2f3bRQi+3QX92vrouUzVVKm2l2th8iF8IsS4RH7E=
Received: from PR3P189CA0074.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::19)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Thu, 30 Nov
 2023 21:56:33 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10a6:102:b4:cafe::9b) by PR3P189CA0074.outlook.office365.com
 (2603:10a6:102:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 21:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 21:56:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 15:56:30 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 15:56:30 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add a DC debug mask for DML2
Date: Thu, 30 Nov 2023 16:56:30 -0500
Message-ID: <20231130215630.885802-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: a93dcd66-61ad-44e8-2261-08dbf1ef364d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sesix+QAngRUAEwkTq/WCZ9o+GdpwZCU1B+2PJ1dEq9vdh5EnjkDB+xgxD2tnnYSQ59n0s05lgkES48/Xa6bWoLTE8kt8ndAao2E6zM6bhBeKDf8EYlNCbopibqoWUQBZXSpwYlfZX8z/CT+GHYaNHnpV5JOcgPsEIyy6Txix3vuO7RFDT6jPerjXsl5m+yupIkm9MUbryU3XXJ2qcuApVyTjGIlW2IKrUYPdWitzt3s5IWPRWJEnkmYZ02koZVOrS0slYIcLMYwCad01uwdwt5ysjH/jH7YOlNidkH8zeKydorAHa9pHxVEHBiz28abD5yFugV2n3vpo9h85f0pKeHiR1rK0OOxDE1tDbXUpKgdtndTJ83pYIV3LyEIlf/4B7bOipCa7pi/I0E09eqByW+ArIbMxXDxLjriWHkgMYRl6q57jQACRNUZLInV07DkmkxuhUVSXUIqOf9VZo1Id+fpVXLJ3tgP5zN6y0ib9TD9dzlOOiuSd5GMc8LNk8ep1WPJCu5JBy8EZ6FwDUs6R2YxOnwD9OBHC0ypF05WHySrnDl1O1EwNiqF8y1fzdtYUSG/MDkwZVMG3BORraNg3T86vnLmh4/3bNGEoQmbPjP2ZmKxPeqrjO6CBDcWb3eUnMV4suMpVaVYR2UEoeYLLXlz6/ZUNfSbqE5cQkjKKGZjzfPON4appHhr9c9PueV6ncRqmMDu0r6ewLAQkYmwnpe/+/upQSvNJJudbXlf8KhTHRPhb86WcI5f1MQhiJxioNfS3HF7NMHKIFXAfO0s+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(8936002)(7696005)(70206006)(70586007)(54906003)(316002)(6916009)(478600001)(40460700003)(81166007)(2906002)(356005)(47076005)(4744005)(26005)(41300700001)(36756003)(86362001)(44832011)(36860700001)(2616005)(1076003)(82740400003)(40480700001)(336012)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:56:31.2934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93dcd66-61ad-44e8-2261-08dbf1ef364d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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
Cc: harry.wentland@amd.com, rodrigo.siqueira@amd.com, hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
To enable testing/development of DML2, expose a new debug mask for future use.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 579977f6ad52..ade68972ec28 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -255,6 +255,7 @@ enum DC_DEBUG_MASK {
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
 	DC_ENABLE_DPIA_TRACE = 0x80,
+	DC_ENABLE_DML2 = 0x100,
 };
 
 enum amd_dpm_forced_level;
-- 
2.39.2

