Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D3DC61D92
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38EB10E2EC;
	Wed, 22 Nov 2023 06:59:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C9810E2EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2K5CNY76oF+BvGgIAbaCx1gejrC0aXiLhu+x8FDmdn4CcuhHp/CYEomSWnbZGyuuzePopv6p+CZC77f/F/Gef74xyxw9couLmRlcTSUHiYRVR3KLY9ZLN9zFBdmRBZ5chD8v8jOng4/zkP+E4+xmCsP60uxLx/Cc0apswCrjJ44upBhkxE5gHAWLLeeHGerFwWLwBOx1jBKPW6hvtPU66pvMcA0aryhnXk5ZFS9o2v60/5mV9LAGbtEwEVK6bUvOUaDN6SJedKVfkudp4WcF1HEdxcpeDkc53Brn+bwCzPvWzmNU++XFMbha/Vpd3EGZAeqSpSZH6xVKd8vbmoBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5RiojbTKZN71WshxFOq135jtPupLfwAcB9rBMn/G9Y=;
 b=SuSLzrjJVbOSNTTIqzVNSjJYGijKcHWoRgTKDnO8YT6+SSoUozmy4wC3F5EqQxEMqN1UCD/O/JqYxBf+7VWDqh9i44Wu+D/dAC6h0BioZmUPcY7dSC77c6LvqJAf2priETQjG+Q0hAx071ef9xvgHceevGelNhLCBuaAXqGYKP3ZdPuQ1ZcEN4Qsl5+Uzw+n7JILbVhqWevYYGxyQURBzYDMK4jjPIjPCq0EeVj1hXr9R3nyaVnUDcBOoRZrRK6Bzet4mjhXJFETO0SJA4m6z91soFa/XEsruaj0e7Kd1IH2L/1sUmovOMXyOi4FJDtOmmsfRjGzjrw7DmWxc0uOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5RiojbTKZN71WshxFOq135jtPupLfwAcB9rBMn/G9Y=;
 b=Z80u+mRSudp7sxYJphzf16Sm4PEg59z90QlX8pL9/EcnFbr1uAPbv18hHIqdg2xn6r63MNkD0oM71O1zqbeshHG9oBWu4JjwPOcWWsOCrxPthryugZcgb0QoPgbZrYPgutUvOO/xOSXEk+/edupeUVFDFGLrwnyfZ6pf1nFqVGM=
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Wed, 22 Nov 2023 06:59:40 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:610:0:cafe::5b) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:37 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:31 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/display: [FW Promotion] Release 0.0.194.0
Date: Wed, 22 Nov 2023 14:58:38 +0800
Message-ID: <20231122065841.2267110-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae183d2-5203-43c7-bf11-08dbeb2898fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMQLWCDhjKMR5nO+PMzI/WdfiqYfZ6QcvJumuoYpZ0urqvAtbnWid9wnL/WO8olfyykVb4oSogqqV0VY3FBVIa2orFT4IiG2FzqUbp5KzA8HYJmvfXGFyJLVJp5UmOdSdGSIzZrzEHLlmV1xiw1WZtgn8fqMXZz6/veoYDaVqiSAcRE0gIT9peD3J5RRhRF0W3xNnnZ/bGpy/irbA8/rZo3+1G4uXOEfj4dIwLMp9giAPdZ046TYleFPRrNjqUsOiiFomAp7VQJID+DzwCpPu7for8mg4K8elsEoeFoz4bbpQWgeRl6PuCbbns07RNtmZ+5OZq9AWByme+whJxysWNbXysKp501KRwJtraONiqTyfy2kAD5d+Y5jVQ2n9gUirq53eKgj+O5IYG1KSeaTGaVL5NFABN7oGW5xE+IyRSb2CfSazpHDuUEVyFcY46qPE3GpFjYjhZCBpCeI5G+Nvg4PoZLvGptnumumhWpnKFjA8lNrKP5Oduu1SJXUDZ38uIu4CiBRFuIQ7TgUa46RWv1YTCKafXs4ZRFz6MemlzdfEsL/d6ZNJX6H0fMozCau4joD1lAckiqrec/FmL9sApJsxtgG6ksB6id9OVa1SuGQ9IiUn99h7D42qaX9x4qsjs5CEkz9obvFGRpkjcwR0KQXJsRpNda50MXw3/tFrBz3/ueEqNDbP5pRlDNfH6sSvfDsYNjkIzn3zFP97m9vYh9HQwcPUILr6k3JPdrmp6Sjx89K8m9Na9HY8m1UZj3Acm2jYGt7G0vsokHC0aRwYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(336012)(70586007)(2616005)(1076003)(426003)(26005)(36860700001)(4326008)(41300700001)(8936002)(8676002)(70206006)(47076005)(4744005)(2906002)(478600001)(5660300002)(6916009)(7696005)(54906003)(316002)(356005)(81166007)(36756003)(82740400003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:39.9817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae183d2-5203-43c7-bf11-08dbeb2898fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

- Add a new dmub command in enum dmub_cmd_cab_type

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b7d9360bfdc8..a365f6c096de 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1345,6 +1345,10 @@ enum dmub_cmd_cab_type {
 	 * Fit surfaces in CAB (i.e. CAB enable)
 	 */
 	DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB = 2,
+	/**
+	 * Do not fit surfaces in CAB (i.e. no CAB)
+	 */
+	DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB = 3,
 };
 
 /**
-- 
2.25.1

