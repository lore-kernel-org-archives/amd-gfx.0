Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA39C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF4E10E6F5;
	Wed, 13 Dec 2023 06:14:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567FE10E6F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNgr8HIPuOiKz3GVlNzvbIRbfwPTIlunksK3hHRJrvMFGWgBAK0XZjAge/lNkEEJzKR9y/g8ahjeconRlyxQbfkJGy0DQri67vVIK/MH54U0J6AI7XDVM/nC333KwWnF1O52Oem3yFqUfiGyPZSang/NfGTLgGPPQAShXWDXzs0mHFe/XoFttsU48kn8b1i8YZMuEdvnIkUfNXo+yNQdZoBJZMIy+k9u/r3JjHKwl3V2Dfxo0qfAZmLpLSk/DglbEXkCfgz5lqpyOwkaGwZoGSYidQhV3G+r/QfLrCzmqOKqvQuko37Z0jXPi+dKMLbMt5uUD/cewEYmtJz7dr7DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vof6fJZWw3KUQoSTQiKUWzUMgCwYAIMSgjcAQPqd18=;
 b=Mjg5TiMsOwDfNmcEU6nO1JGiH2d2gnvono7fPbb/aKrxcTRpbgTBEawEeM0+QNmx0KfrDo5o3SkxLWBLDZJjpKW5nVYSGc10uyjP9YrEF121bukWhakbLNHojgUbU0Fp81rj/t3MwOS1vKpPpclTkK36JOS9isPguGntbNpQ+s+lsKHLsP6vuZCBIC2lPHGcdyzIDDCsyZBwbv3R/pUccuvTD0GYJZKMqVKRIqLosAIMnXmaIEZE/BbJX8JtHdfZpF0QrQghb3wuVA4jk9QvybL/WFcCkDijQZbLD9RvWhGGBPXNWgpOyNWAFEC0Rwzs2zAqix3Dv3dglqzOQ6v/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vof6fJZWw3KUQoSTQiKUWzUMgCwYAIMSgjcAQPqd18=;
 b=yLmp+BHQzRnXFculiYqzsnls1YocrPS729uSpRAzitetRm1JVa1Fbp7UgSvOfJi+1fNTKtqYaWh8oEeWkz7UjNzboZYUUeNad5VNXbo6KKYFSkAEGG4P+3KcwxSYKDLluuZyFaL16sl89sbRmNqjKYO43s1iVpjAWxUoNT2EhLo=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 06:14:12 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::b6) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:14:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:10 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:14:05 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/25] drm/amd/display: fix usb-c connector_type
Date: Wed, 13 Dec 2023 14:12:15 +0800
Message-ID: <20231213061227.1750663-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 988e3b2b-3607-4379-d52d-08dbfba2b9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PMtRTBzxOD25qA4tvln1oN0/t/RvNRMyvds1IVi+noTIwkJuvZE6zS2sj0qkH6/kH/xsYolZeNfXje//jnR/Le7kiVV25ru1Z83OtoIZbeuQU6Iz0qxLPt3Ww4XLxX9NP9rRYVElx80IVUWSyLyEiiOvu+IWyMfwzwIVlTnuC1XCKsSaJUWTBfQEU6jKSENKH/rCY8LlImH+u6AVq0MMNu+BK3/MrDra5cRzLDONtvN8q3Io4hxLBG/b4I7OHeV9R3n2SonxhQdwSvkaqQV80bBHZsYPZ3z3hHlzV5RkZ10GZJ6ffs3fAvgSoReu8Csqwq8lKlkWPy/Rs0fmgauCuBVVY3Yr5HbRK+sni/3GhXYFLy1VMClyzKyh6EJv2mJ2OiHYK9uiyfTRoH9jd3d/qm3vqCCjlvTHRZqElCyaXTVVh0hgPXcWT+nfyNIt7lfZiV6rs++gOgWoQ1ui9EDEmjvup5U2up0uz9VrDBpPSSW68ZPdvozCpHJ2V5OxSH/1OyAL9Zw7fsIn0WL2uxwGzvzt2vtn9HSrEMtRu83I/dbY1Z/BMrNnb2lUafe/SzQwES5Z0EuRZn4xCXDOyETsyudiwHiG/A5g4YhJA88s9RbTKHNXNK6weERzcPBza4Np9TEvpzfhbdu2a+31877N7oIBYCpdpjqFEIg3TelqrbEig/a71RzbaCaTWQAXbKpzal+euuIEcDSvw5mqNf515qHvtRpdfRoT/2tITUfW8Tb3LBqrqpsvNeKbRn467PNbU7FpGVdt0JJX5izSf3hCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(70586007)(6916009)(54906003)(81166007)(356005)(36756003)(82740400003)(86362001)(70206006)(36860700001)(47076005)(83380400001)(1076003)(426003)(2616005)(7696005)(316002)(2906002)(6666004)(8676002)(478600001)(26005)(4326008)(5660300002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:11.9749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988e3b2b-3607-4379-d52d-08dbfba2b9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Allen
 Pan <allen.pan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen Pan <allen.pan@amd.com>

[why]
BIOS switches to use USB-C connector type 0x18, but VBIOS's
objectInfo table not supported yet. driver needs to patch it
based on enc_cap from system integration info table.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index f91e08895275..da94e5309fba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -256,6 +256,10 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+		if (bp_cap_info.DP_IS_USB_C) {
+			/*BIOS not switch to use CONNECTOR_ID_USBC = 24 yet*/
+			enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+		}
 
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
@@ -264,4 +268,5 @@ void dcn35_link_encoder_construct(
 	}
 	if (enc10->base.ctx->dc->debug.hdmi20_disable)
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+
 }
-- 
2.37.3

