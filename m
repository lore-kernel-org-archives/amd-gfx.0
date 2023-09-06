Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF8FEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B8E10E649;
	Wed,  6 Sep 2023 12:52:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A5B10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdP/FnCvez78Wh2T1CV8CNvwMXlJX8PaIekT77c3cA5cOxsvVaw9/VjfR3TNx/oUEPKaZmPnLiO3jKj1aCvXEtmq0kbYewSMSgSDM40sSDD6vFcUjkV84k/TTWtQTZj4F/TWmUi3Gso07AzSZXr8jKseyOeo3UWU7/tTUJiDouFJnjwez3Fdk1Jgj+KPf1HFRTmHXBqyP4OEIBSBurINRf4B7rShz7XG9Iky/qKnN4RiOzRnl8UH/roRd36oBycWrXMG2ByAxCAGEU+qUgyLhj1pUQTBdkPiqN4rwh5YIVQDd0iuKQ0ZCWAfPxzsifLhL78vpm2xv2Gx3LDzsACnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXhXr/I11yL1l0ZVOGASLlpG/t9u9jXUGqpJitCUTpE=;
 b=REyULsl0Ia/zKSKSNs7lAk/OntsgDSZhk2GEi81Yq0VPDvxh8LWhHofb2HJoUfTx0IVKgUktLeIVWUF2Ilyhk6NmWfO9utoLALC9uMhWgdFkGEAZLHbXUbHoD4GB1fLUXzMccyV+3KtBuJ4x1/U05gXmAoqHv8Bk1hyx8KYFcCa3Keief3GyWEKDRP7Ab+7x35K8LGPaJQuu+T8ltKTK7i6/KQ7rFhLYODY4pci+wKt1W5luuxATX/G0cV2u5woLAK953wzzf/woVod6QLqRiBWObSHzvhp4KfFVfJ+cwOJVbNdCfhuF+j/Z0Ul4gLJ1GMf6WGcgsIVcVjdinueCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXhXr/I11yL1l0ZVOGASLlpG/t9u9jXUGqpJitCUTpE=;
 b=aacLfZqMvXY0gWgFf7A/uLCN3Y638qmE0vkFDsAwyUcWe/yResdsmtT2F1T1OQmhLVxq6UkGvaIrP6JD8hRtdQ2iL6MiT5NWrEVS8aBDT/l2ldkegEKHqIHUYnTCWn05Y1Y/wx8Ljwbwm/Xy+IST1GEYTj+dE815v/idW3Y63uY=
Received: from BLAPR03CA0124.namprd03.prod.outlook.com (2603:10b6:208:32e::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:52:12 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::10) by BLAPR03CA0124.outlook.office365.com
 (2603:10b6:208:32e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:52:11 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:52:06 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/28] drm/amd/display: move odm power optimization decision
 after subvp optimization
Date: Wed, 6 Sep 2023 20:28:32 +0800
Message-ID: <20230906124915.586250-28-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c60123-d61f-4d75-64e8-08dbaed816bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tfcq1OqGsBVHh+bBxdFO6oM9z2igUIeIFh/6eRooUahTI3YIE2bhLgU4OnGcGrwfqDAa8sF/X0zYMiyUAny+oBfivkIhuF0HixgTVBKRlXGAPAu3qpeZSGi93Qbn9Q/E+z3rql5pcWl/tkGaLLF3it5qDOzWbgSJ2LoCwpzLCEvf9lYkDgO3Wuir1ALd13QZ27kho4xCt6SWFHu2ywGrqcTZ05AU/FrZQAHtODxiy41umEAKrmthTcrDDFQ7A+Sh/Wvd9NyOTaH7h4Fr+iT5bT+7FkSAdNNC38woM8+Y3jTkf5YL+Ag16D/+TS/IthgpbTniFFa/msYpdsXzWYleQSU+96gOcVLKaoQ8FfZKEkFelm4EgxZNeXWI+rAsFV+2hRnLGDC1xWsS5At+4rvknBlrA+N4y5Hc1xfYqc5PD1IKknKFEis4yqx+fd0cCrkeSpop4VAvFsI90e7Ksb7aelI/7FYuimMP/sSRhrqYq7VzliYpOJYBOSshGYflmzBZzJYXneb1/NHpdL/dEnXfO82c+OSEUirlXkeT/3tViOgmxxZpYIxf4mF3ZEveenaKcs/m0Uj7Sn9pZqRqF18iGwCat8jRe/ECvh5y++TAtvroEP7IWlVnF8JZWm4MaSAr3pNU8k7nYcJcHGajS+Y/5jNXlTl6rQy+j7v23iRXhQINKdXYXqFzS2svJkU9UzXuLmI8NL5qxUwv+UO0UUf2kO8HzSHR57Lp4H4mf6j/B/BbKnvfvRUk7DeHoeTxTuKkh82chMEcI/+MTtqcZE07mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82740400003)(40480700001)(6666004)(1076003)(26005)(5660300002)(16526019)(70586007)(54906003)(7696005)(336012)(70206006)(316002)(6916009)(426003)(41300700001)(4326008)(44832011)(8676002)(8936002)(2616005)(2906002)(40460700003)(356005)(47076005)(36860700001)(478600001)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:52:11.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c60123-d61f-4d75-64e8-08dbaed816bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
ODM power optimization excludes subvp power optimization but subvp
optimization can override ODM power optimization even if subvp optimization
configuration is not found. This happens with 4k144hz + 1 5k desktop plane.
We could have applied ODM power optimization however this is overridden by
subvp but subvp ends up deciding not apply its optimization.

[how]
Move ODM power optimization decision after subvp so it will try ODM power
optimization after subvp optimization is not possible.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 92e2d1df5b32..1f53883d8f56 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1441,10 +1441,6 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		vba->VoltageLevel = *vlevel;
 	}
 
-	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
-		try_odm_power_optimization_and_revalidate(
-				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
-
 	/* Conditions for setting up phantom pipes for SubVP:
 	 * 1. Not force disable SubVP
 	 * 2. Full update (i.e. !fast_validate)
@@ -1563,6 +1559,11 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			assign_subvp_index(dc, context);
 		}
 	}
+
+	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
+		try_odm_power_optimization_and_revalidate(
+				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
+
 }
 
 static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
-- 
2.42.0

