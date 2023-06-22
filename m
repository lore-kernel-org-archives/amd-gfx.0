Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA17EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D42110E5A8;
	Thu, 22 Jun 2023 21:58:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B2E10E5A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REnYFubOF5C9tb3faptBgEcD2/9BFnaGyWy5rxXW5+M22GZz0cKU7txFu4EwIf3jb/DcwXCUbVm13ZEEVatP2IDmdPyWrMwkxB9DyQsGMs/qcy/U5ZI2if75QHtiqUsrwrGNwCtQmh+qgdD/FORGbPl/evrlgIqEeIlH3SE2qEwdMQ4TbJ8rkutgQ2btIXEZmz0YDrzLwGnOOf27dRQwG+WE0qPBjuVey0tA/HW369kjo1JknegLwD2kAHAv+usgBiobKL86G17fdXoj0yT0KmhXltfxXl6odrh3IlB8/phdWnMzkIeRX8y+PrIRV6sAwpi5IW37aKxpS1ueXAHtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/65Udu/CVzrxiBC2KRLcoLy5Vnc015Y46LyBalibXw=;
 b=W//OroEjGusVubNpsLkRyPCM7XXedvElED2w4mS0yu9iFaGNC1is+bFMT/Xh9U641Wkkuo7yz9NKK9C6cvb2WgmbI5D/1FwH+hm/y0fAvFJFhODYJGgOz9wVo5l/t+15KNwOlOrdNPRSPB4uO2l//hmvIXOmTb32QHiW+fB6QK9DqeggR1E6Q8vjaC27zaIpTv78LaE8Z3THshadZhRRCwxJDFwzBAgmOGnc3lBzej0pDj4Lpd2w2soKb/pB/LP2QJqKJkFJGI3erUwwx7xR2sdnHgsMGgtfHDxZPa7+XIqBv8RLlV5Gc9lGAWED6RPd0bQX1Eg7BAZfxf0PO3iTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/65Udu/CVzrxiBC2KRLcoLy5Vnc015Y46LyBalibXw=;
 b=vrssSzYiC0lgERK7p3E6IpDgvntgOI7E39bSL2gzVyGzuPjSPvJ6qvzUmZcCTKJOZnQxYj3uBNONEo87223FOVv6wwBeLCwW7KA6m/WP4MyRF/BtcVElOPpVUO9uqQG07bbRdSFa0UD8EK5JV2zikb3wwu/nC2tZm8bZ8qo/bjM=
Received: from DM6PR06CA0084.namprd06.prod.outlook.com (2603:10b6:5:336::17)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 22 Jun
 2023 21:58:07 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::8a) by DM6PR06CA0084.outlook.office365.com
 (2603:10b6:5:336::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:06 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Remove asserts
Date: Thu, 22 Jun 2023 15:57:26 -0600
Message-ID: <20230622215735.2026220-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d906d94-e1f8-4388-c53a-08db736bc2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXwqJKoohqnLtg+4UhdFW4AEtH0KbuJQivv1DlyLCIa9QO5h8DUgpIyC/FSu/AnKmpl0bG5FnHnTvz0/aMxGUcBjwPLXrg84GXaX7XLbKKZ/VGGNsB7+BtQUIAUjXWok4jmhgr6yIY4iT81Mnul+7Dt0/qAO8TSZ/m8e6rDsKDwLoPi/v8JgWpVJVj5mK1QKyIfaNVVznnHHHjU6eCefQJADfNfmN2dF+7xSh4tvPWp3il/kpGSMEZbf7Gnbh60eB9hxPEGUCZJlfT1yk0Ou3glLa6FhZSCt9DXo4nSLhJC03Uri06TodykvmDN/tzN0r5siGp7CeT0s5NO+y7yAEoaCO0T2hZ87hDO8dyOxAR4D3rF43a81/ntyLWTdcwgziCOTm7NC/SeSlPOHLpd8Jms/GAPwO0a5cv5WCdZCUmG/tozb4mMubALvqJusMYjq1fd3XFaAli7rCCI91CwaJgVvdLmvoTQ+9x8PCAH3XTx+792SDd88U1OXBHoAZ/PzsfzmmNjFRtzg0GeP8+VeAl3jiz3ZoqNrwTvqNcXntuV9Ll81/WY+vw1LWFp6ooI4cFnz4awTJ+TY1DT/ZK5MP/Rm0yrjrxe4U1h2OJ0qqIIk3C3/7VY3sz7QmpEVU8s9UuWN4RGJ8/4ySs7+KzXfhsqJqsJetAoqWk33xpEqULSNdSafcm2qC1hEnc3vYN/ybLk29zxBwAbTALc7LaB9Qgwjr45ByWlFT4aIdyfRmR579wFSdWHVdpVQGCx6lVwADkTc859RDmWLzn7NTNr4Vau1zKIJ0COZScpjcbENta78mQ6IRdmaj5dhw/G7ttodecBrnN5/hyGu1tvLRHJn6WDIPFG1VEejZbtfv1uW9qo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(26005)(8936002)(8676002)(40460700003)(41300700001)(36860700001)(36756003)(82310400005)(356005)(82740400003)(86362001)(1076003)(478600001)(70586007)(70206006)(4326008)(19627235002)(81166007)(316002)(54906003)(6666004)(6916009)(40480700001)(83380400001)(5660300002)(186003)(336012)(426003)(2616005)(47076005)(2906002)(16526019)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:06.7491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d906d94-e1f8-4388-c53a-08db736bc2b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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
Cc: stylon.wang@amd.com, Hong-lu Cheng <hong-lu.cheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hong-lu Cheng <hong-lu.cheng@amd.com>

[why]
Endless assert caused by LinesInDETChroma=0.

[how]
Don't floor for LinesInDETChroma=0

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Hong-lu Cheng <hong-lu.cheng@amd.com>
---
 .../display/dc/dml/dcn20/display_mode_vba_20.c   | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 6266b0788387..7bf4bb7ad044 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -4356,12 +4356,16 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						locals->PSCL_FACTOR[k] / locals->ReturnBWPerState[i][0],
 						locals->EffectiveLBLatencyHidingSourceLinesLuma),
 						locals->SwathHeightYPerState[i][j][k]);
-
-				locals->EffectiveDETLBLinesChroma = dml_floor(locals->LinesInDETChroma + dml_min(
-						locals->LinesInDETChroma * locals->RequiredDISPCLK[i][j] * locals->BytePerPixelInDETC[k] *
-						locals->PSCL_FACTOR_CHROMA[k] / locals->ReturnBWPerState[i][0],
-						locals->EffectiveLBLatencyHidingSourceLinesChroma),
-						locals->SwathHeightCPerState[i][j][k]);
+				if (locals->LinesInDETChroma) {
+					locals->EffectiveDETLBLinesChroma = dml_floor(locals->LinesInDETChroma +
+						    dml_min(locals->LinesInDETChroma * locals->RequiredDISPCLK[i][j] *
+						    locals->BytePerPixelInDETC[k] *
+							locals->PSCL_FACTOR_CHROMA[k] / locals->ReturnBWPerState[i][0],
+							locals->EffectiveLBLatencyHidingSourceLinesChroma),
+							locals->SwathHeightCPerState[i][j][k]);
+				} else {
+					locals->EffectiveDETLBLinesChroma = 0;
+				}
 
 				if (locals->BytePerPixelInDETC[k] == 0) {
 					locals->UrgentLatencySupportUsPerState[i][j][k] = locals->EffectiveDETLBLinesLuma * (locals->HTotal[k] / locals->PixelClock[k])
-- 
2.39.2

