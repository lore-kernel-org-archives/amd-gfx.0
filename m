Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C614C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48C910E4DB;
	Wed, 19 Jul 2023 18:33:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB6810E4DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkGjY/d0Ln2EWRiyYV90xkcWw3BNg4vspSMROXd/apvB/XNDbSriYbMWjnK4S0H0Zuhk9P7EzcQRKf4rAr1kpiUUUnf3teuVtRRyPCVoGkLd+qtCDlMmLztb6xKWQAhFEBLMCeemaKF+PrnlyLnjEMaNZh14KTSFrDrJSHJB3zGwBVU0M18GkIqIvVV/0rqYRlGxmU9qxntmQE4CQjp6xcjPU0GRJtUVN4sX3sFQkVQZZB+HHh+L4+S9E+Nqa1mMl2R1A3htnI+Qq1obNpeVKUUm51o+vRuidex4+TTKyxEXarm5mf94/XTJJK3GULdDIczI5WzUrFksmme7buZPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD5MzI77NxOEWhgONEtevLOaxQM4JCGwNPVPzyJ7Qoo=;
 b=FZkYhdrbklfUuy4qFOCAy0unBSNp6RTFHYJZdkge7jP8f344Hx7eJCTCV/NLFIcb1qG8wMrv1qUnpuQH9lDazujB1wONpoDEpP0hCkla3k2wWquzLU3DiBNhhS/4qzziCOiFWm1+RGeAk/w78HT7bDZj81/4DIAhuUqxDsipymFpzgg9npV603BxzkfEe3nX3Yea0IrMZYtIvZNa1AXeu+SHtwkWZlPXlRPApR2zAu/IZa3gHQ6hqwW6xlnRWZknH6frft2GQXKXPXrjdiSno6iknvUEQbs8kXewrIHE2g/HG0fv8x3g13YSrRx6TDuJhtc0gfdaatFyrusF/uLPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD5MzI77NxOEWhgONEtevLOaxQM4JCGwNPVPzyJ7Qoo=;
 b=zbtDxtnILKGI0UO2h8OGJSbe9ll5s4xGP5EHZeWl5D+lpd7khwZfHEbBzDrsnIi0vreU380vR+rpW0FN90P4z64jqvC9VDkY3i3vEoC4vi5tI5yHApnl2KP7+K4RQ1oniTHXpByc1o1hMb4opSPwEkXrigZHYKRJll7aCj2AefQ=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 18:33:32 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b1) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:33:32 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:33:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Add VESA SCR case for default aux
 backlight
Date: Wed, 19 Jul 2023 12:27:53 -0600
Message-ID: <20230719183211.153690-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1ba934-753f-40b5-302a-08db8886a7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wHACrqZXnVDEHNYo/uIObug8rQW9sMyKmzZRgjeC4qGPv1j6zrIcQTV+8VZPu9jWjZ81YKnjWvdq0ykSEBjFoUbryisguQ+sAwODo8a+/jAlorrxsmRka6mf++TDD4yAzs6ffnfbdKN34BL8i8Dx/+hlZVjoiA3WwDfbIvBuXc9SYTBm/P/snv1SegyuO5dkgVLM9qjnj6yxvvX0DDcN2ceJO8v5niHuV8WN3a5tp2BpAecBbsIzz27ePtVfA9Cb+MeoJi60J8RwFwbQez9jDhoYo0IuAUtDsMWUjO7fPgvvRHXaocj0pJVlTHVlXteXmPqTk28G29//qNH5ZYG3eSuv+msmlAkXG19ojcbU2loFplCoEyaYy+ngeHzN+I8IfSodmQMsT/kFusbwYf2ns44zdLGPeWJUhZNVgzp7rOYNnJ8mds2YKnnLdvwFnHHr3Bj9lYnC7PyUCEil+PWg1CQHVg6ucky8asNJSWxLE4E8d0NtBXt4qvJY0fBFwJa+nDFRYA0F0D1+o83EmG7/gkPQYn6nwa+Si/IfTYIqZB+NB+sIS4HS2j0CNrtq5w7JpRZ7wzwjWP9GvdV+jkb/Sbqp9mQLa1p/R/K0h0BSayHmTN2j+2FfFvF7RqHP1X2Fzz4yEAnHkHXRb/7+Pn5aE/R4BER8su/c0FfkPIglgTP9pUiaEPRCcRT8x+/5UafLK6pqOms7yFrWv3DPQU+ROpagHsEDUjngEbE941sGxDFBqeG/PnRaiXxveqelVTzv/jNKgxITJ9hogbYs1Kxog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(6916009)(4326008)(7696005)(6666004)(1076003)(26005)(478600001)(70586007)(54906003)(70206006)(86362001)(36756003)(426003)(16526019)(83380400001)(336012)(2616005)(186003)(47076005)(8676002)(316002)(5660300002)(41300700001)(44832011)(40480700001)(2906002)(8936002)(36860700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:33:32.3908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ba934-753f-40b5-302a-08db8886a7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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
Cc: stylon.wang@amd.com, Felipe Clark <felipe.clark@amd.com>,
 Iswara Nagulendran <iswara.nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[How & Why]
When determining default aux backlight level, read from
DPCD address 0x734 for VESA SCR on OLED.

Reviewed-by: Felipe Clark <felipe.clark@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
---
 .../dc/link/protocols/link_edp_panel_control.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 92f58a719c07..5add2360fc94 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -252,10 +252,20 @@ static bool read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millin
 		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
-		(uint8_t *) backlight_millinits,
-		sizeof(uint32_t)))
-		return false;
+	if (!link->dpcd_caps.panel_luminance_control) {
+		if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+			(uint8_t *)backlight_millinits,
+			sizeof(uint32_t)))
+			return false;
+	} else {
+		//setting to 0 as a precaution, since target_luminance_value is 3 bytes
+		memset(backlight_millinits, 0, sizeof(uint32_t));
+
+		if (!core_link_read_dpcd(link, DP_EDP_PANEL_TARGET_LUMINANCE_VALUE,
+			(uint8_t *)backlight_millinits,
+			sizeof(struct target_luminance_value)))
+			return false;
+	}
 
 	return true;
 }
-- 
2.41.0

