Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A109C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBAA410E818;
	Thu, 26 Oct 2023 14:20:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5739E10E812
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er0Dxd9dirvs+yaAK1XAg6j1HhVn8rVMbC5tKEe60Meask+RTProAvv57EJqzjL0BKtHtUuLoe/+nCm97oRN1X+BBv16UpOuvTI8HyoRjbsM45ftI31OjyPxtieqJgy8RswlWh4V2QRf9JsUV+0hPogEvkS2Q8jFB58pDArRzmNwh8JB4Oc0KvrcNLYmCgYrxWtyN9Bp4as3CqpFAhxPxk0mU/a28d6Ek8nrjwJB8WixwRfXmUyBvENNzwo7PL+oEAEASV1VJFIBJhPkkpq9PGvzJ0+Kh6V7HnqlEoGE/M6k5yZAZVqZXz5v43KAj2eFG2Xc9inL7JkorcYnkmgLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ1kL+QrLay0FntP54rLTlPcdQ8FNFwgeCS9QBcpaSE=;
 b=lYKDlneRPl7FPfV6g14kAfrYLg7NarNG/rHr9We8CPlTd2Zei0yyyTipB/hQXQPMNAucljoemb5M3ByfSY4zrx0u43v1tbdDZ+yRgWt8xesJunSf4SxIYTLGDH3g5ONW1gPBTl5j+8Q2JN1LCSOWLA2FV/7uOWnMnUvnYD8LWZyIgNzftNDfcpjaSqLUMuetnWjdE3/e9MB/CrkGbOBMXtokFAxlMIEanMA+ASGAz1QmF37FLxfyW6VKZ9C7ln72Ga2cs4+MtAcNEvAvOJ1ly7SEgjVzfAEXMrtRCBHayL5gddk1ZszewtGeiUMWcz92DT/OQyF+JdpDuTMe5VgnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ1kL+QrLay0FntP54rLTlPcdQ8FNFwgeCS9QBcpaSE=;
 b=5MS1XPonvo9+kJmCRxFai44/6Ryzzxg3PcRQn137yJsbk38lo3rlUQqZnPwKOTl/l3lhGjWvpfP9MH1DhXNc6STo9gwwatSq4Xhj/qvyeBfRh1ZWaVZ8L+Us1kneV5Stu1mY5BcnOedf5v5dOVtWk28bIMrdJE3mMd9vkKuxDVo=
Received: from DM6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:5:134::33)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:47 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::7a) by DM6PR13CA0056.outlook.office365.com
 (2603:10b6:5:134::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:45 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:44 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/25] drm/amd/display: DCN35 Disable cm power optimization
Date: Thu, 26 Oct 2023 10:20:10 -0400
Message-ID: <20231026142020.67861-16-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cc9e3b-7922-405e-ae2c-08dbd62ebf51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/Vq2UnoQiGpEWeAPEtBW4yCfC6xx6an0YcQcLcNjCOHr6TUS6AV9BES8m2hmbr8oK9q+oqQZBLMp05VmFImlKVzqvu5OArRc7PZz3BhmJ8+piYOIgRQyWbUUZdWbFBUpUoBA1MsTORD8KRwieQ+VpCUFFe1xSDMAZGd3ROHB1Awh9kjEumps30TzRhhFXfrWmiZynOgGO4dCAvfgX/YBWKVla3YHFEDGZrUx5UTtFW5gJjZB4p5NPdCWMluAFIEwd8abDwDjd7/VDeAeStJgP6qLgWKgi64j9zwBjc9SU2UDpPJo13Eyq5avLvIOyTAbO0lgXUHq8cQf4y7z2OtMJoeBTNrVTZW5cfgYqaC17KAPvTf8vXvDraQZhNCrXQ6ehhKl+ScUH6hD0arLLcdq3mOaBNBb7GBqWdCGuGQDfLj+64Ni8E8AolF4nMgsG6r6Y6XaPt/z6B5JUJEK+iSnenpo+7vNuD67aAxn28h+jVEBjB86DA8+fqiuxlPDBZPrJz+37HIFFe41knPs3HGZzmpbZwdHpPrO+r20NQ34dlbQ231i3KgOk3kMEdyrJOcwbeDp7Tm7Nxo+Yevz0gQgB4qxs212mDswr59Q6GkIV8HynhqZM4kU82rihTdXqv1//jhnMHSf/dtIslhsF9qgYZLkqBnyh5HMws3HCTgDZJSBcHkfyCOy7eh2WRikVJ7k9twpsOjaqRtAvpSvJO/SNcnyLoQogT8CdEaMt36dSlPljYoPzwHQqJj5vzGVEnPCBmVS/Lqg0EK2CZiIuNgBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(26005)(426003)(1076003)(2616005)(336012)(86362001)(82740400003)(356005)(47076005)(81166007)(36756003)(36860700001)(83380400001)(40480700001)(40460700003)(70586007)(70206006)(54906003)(6916009)(316002)(4326008)(8676002)(8936002)(41300700001)(5660300002)(4744005)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:46.8135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cc9e3b-7922-405e-ae2c-08dbd62ebf51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
Cc: stylon.wang@amd.com, Yihan Zhu <yihan.zhu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yihan Zhu <yihan.zhu@amd.com>

[WHY & HOW]
Enabling SCE after boot up will cause color distortion.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Yihan Zhu <yihan.zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 3c7c810bab1f..a1f4d775db23 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -708,7 +708,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = true,
+			.cm = false,
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
-- 
2.25.1

