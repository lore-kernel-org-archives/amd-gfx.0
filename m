Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD3C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 12:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A292510E5D7;
	Thu,  2 Jun 2022 12:02:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E0E112F16
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 12:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0FEBF1hCOZUerIaA0TCl9Jjv0VTC/pOxm+PtLKBSPosFQU0+W72YoA8lkiyqbp4MKE69fLKAYdJmb9A41IsqQuC2nmlVMVYPajVsbiyMUWxqD0abzu1h2hDoywqQprSLm0k+M2TJj1uCbjW7nb6ZtZ1DxjsYYUYpG33Dz829zj/Lw3qgCFPmg1yDxZjD1NO+apoFz4B4TpHbNBcasWTXHssq0QmaXKvPjB5l+RqnOaQwPu2jma/pnXGfklvJOgIbXy8AeCexN3PiQTi/1zc8/wu5PNVnOC82bFK6ACVvNsctWuCjvl/qTnvpLVYCMVfd+oFYQcT/WGeIuL9IkqKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crMrpsnhtPsmUIgBVfo/pOOVrQSuRCPIVhThtXV0vTQ=;
 b=jeXuVgqSubz2wJELHvpDckqsC5y5x5ZuCIqQiqNdSFwPd0byxfDXAlbpQBQ1Kkap5I+CPH9x5DtS26GMz7ym4e/4kDucxD/8MoHRdd8kyhcy8ii5Nqe/J1ZvqP473LWw9svzVRlgjL5ccKwoN5v/bFy5GhW2DC4OjGY7s5LnTN5qtWqJ+edTlmFcouXiTK3dvs8UKactY4lgpNQyqsAZvSLdOapLgSiVCpgwiwYRZkDgc21+ATSGi0mKE39wrYwn29MPBneA+Xmi+prfwOG6azHAVwJQ+AH5KL/Hm6EuAUQ0nm7uyXtcAduMWbK7Hw/7Xj7wZDPC1jIoHUJ2IRhVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crMrpsnhtPsmUIgBVfo/pOOVrQSuRCPIVhThtXV0vTQ=;
 b=frwjm65zLzhY16GuNUtbhEnoLkOSZCg7DCebXd2d6DpdA+Xs/r+se/xAWiG9fEY5AMiMVn9V//RV7HHTVpgG3R/Q462KYl37ySYd7PhAy1zw9kbpEUa5klA7ti2LQnRYTnZFOx5BUce2ZIRxN8IQieBy04rB68K+IyrEqeUpfgI=
Received: from CO2PR04CA0139.namprd04.prod.outlook.com (2603:10b6:104::17) by
 BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Thu, 2 Jun 2022 12:02:40 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::c) by CO2PR04CA0139.outlook.office365.com
 (2603:10b6:104::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 12:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 12:02:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 07:02:38 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 2 Jun 2022 07:02:37 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] dc: Add ACP_DATA register
Date: Thu, 2 Jun 2022 20:02:29 +0800
Message-ID: <20220602120229.2731122-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e58c90e-c17c-4c8f-55ef-08da448fca83
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5132D40F6E5CBF646376D3DEF5DE9@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hAONR4OJM4PUFtzYrFrjWgCkazmhlL++QAs83V3afO77gn53HpNG+r+JqR3sSTQWBlQ4UzCJpeQIOxUPB2WhlL8mqlLqWEf6DjD+m3frheSe4N9JgDCm1gaeAzfjk1XxcAbE49CenphTONUahFmyAEuoJKewH1JVDFGZhhlibMtbx+xR0HDp1QBJJLIDdpQaNXUmsmmJEcCNsbeVD9Gq3Hp3mg3iuMW6gGrjxYOb1OjKgmAJv01g0S7TXJAswkaOhs6/ezEl7ZKmb803wtanCv2qE4ifpnwIb3QkEDYgDFMxdVGXNtK7v0RBkF8kxYrCbD8pv49tnyE2ItKuAnLTyt5tVU6hS933r8ds6jXLGzopbC6xQA8PXL0xWoPfJoyMJ0gmYukMskh6avu8AdHn2ymdzEX5HDuvQP5UwE6ZinBzcJMf3KOaIuuXK6aN3yx8RSBZ8DKDcRUJvPmLuJrWbpo+57YaDOw8zSi17VjeHUB72CkUo/FHr+lvwOdQn4+SyMg37env778MGcn0v5eqOVM5by83aDjJ4kH6bt0VHt971au77d4tB/twb865nyzaJvJwN15jVoofno0zfhu0WsdN+qaqWsRhyBLh5e3mnbEY4/vH+gHJCVFl8WooacAANHPAWhF8VAU8bLrfR0G6HZeFUIh4JWjGg+2ewYbtv9PWwHlZ4YuhOEvN/AcBJixwiaTObOm9jxsDZCbNt0BCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(36756003)(426003)(2616005)(47076005)(316002)(86362001)(82310400005)(186003)(356005)(5660300002)(36860700001)(8936002)(70586007)(40460700003)(8676002)(1076003)(4326008)(70206006)(81166007)(508600001)(2906002)(54906003)(6916009)(6666004)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 12:02:39.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e58c90e-c17c-4c8f-55ef-08da448fca83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: Alan Liu <HaoPing.Liu@amd.com>, harry.wentland@amd.com, haopiliu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define ixAZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA
Define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI_MASK/SHIFT

Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h       | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
index 6df651a94b0a..581ba639b4ea 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_d.h
@@ -6981,6 +6981,7 @@
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_PIN_SENSE                        0x23
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL                            0x24
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER                           0x25
+#define ixAZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA                                  0x27
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0                         0x28
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR1                         0x29
 #define ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR2                         0x2a
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
index fa1f4374fafe..fd387c7363b6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
@@ -13639,6 +13639,8 @@
 #define AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_PIN_SENSE__IMPEDANCE_SENSE__SHIFT 0x0
 #define AZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL__OUT_ENABLE_MASK 0x40
 #define AZALIA_F0_CODEC_PIN_CONTROL_WIDGET_CONTROL__OUT_ENABLE__SHIFT 0x6
+#define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI_MASK 0x40
+#define AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA__SUPPORTS_AI__SHIFT 0x6
 #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__SPEAKER_ALLOCATION_MASK 0x7f
 #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__SPEAKER_ALLOCATION__SHIFT 0x0
 #define AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER__CHANNEL_ALLOCATION_MASK 0xff00
-- 
2.25.1

