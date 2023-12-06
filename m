Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E45C10F07
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D1710E648;
	Wed,  6 Dec 2023 19:52:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F5610E642
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQvUcvDohPSJzr0mh+4P5dFLDTqwXgux3NfuBo2fmrBRraWXO3I66lhKODblQdqx2DzwFV5raeM+jUa0kXEsO7zTY3VJ0ovzW4G2BZgwq34STpTUMyphZJJxneDIaMHe/E2ZnXcPfcgsaffoDWFhatieJuzNuTylhYQVDQ4iV0TyMif/XphAKA3JwtX5u0ZiKzhfelJg2hmbqmcOEiEuZKnJbpPD5CfYBHLKdgzL37iX8z05U7yrDHVGr31Kd7Wnqj+LvWXh0bhLsi8XRj8O21Wpc9KhQdEJb+9wBzVZ1LXm08savGWaPQefW8NIJR3Is7zULfbN1ylRGuEodbzSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi0gWSOMD7gsxU4q5yIwqOXcupVWE4cne6l0GXstI10=;
 b=eIu87OjWBBI4d+8I4FeIeHx+ATdjGvlEQ79m1D/B3naQAQcoeETB6UDH6D/A9sGKYDrO3kf50rlBGWDfzrBHigPTzir6I9PSF0kexazm/eZFwEY81VZbEeQu/7ObxYqHSxQN5loVsiw82+4m4AEkOD9F/vaqAbzOj40RImo6si6GMytnHzrQrWDLOfkfwJ+aQ80CIDfGQbtJycUmB3EQe+cdFiLUBV/C3iyJCEKllxwWk/4Yl8zkfAgJovje1lUghbA6DFFY2mNgiv+UtxpoZuKAoDIzyYfz00ARg5Cc0PZPKowU1PkyJOb+WRSEa79VsfTiT+WLa4/glBVUxd/qlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi0gWSOMD7gsxU4q5yIwqOXcupVWE4cne6l0GXstI10=;
 b=l6VmK6Rzmll8wAxxzdTLqhwHRqwZDUw6AoFq+3Bs34K9Dab4G/zWpr95P8swOh0NvAYlRo+a3KRLmSPSMXYbGi+HYndUkNbEA2NbKGWgdO2cP32TsUn6bluMN8p7YPg6r8Pe9RitiffnUh4sfRvuiTDyzP0iSpCUmCFFWWHsqqQ=
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:44 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::74) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:43 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:42 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Exit from idle state before accessing
 HW data
Date: Wed, 6 Dec 2023 14:52:30 -0500
Message-ID: <20231206195234.182989-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c73e0e0-eb43-4c75-7ff5-08dbf694e986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibC442cXv16rIhplDpp87C6wlDhAkMbzXYOoC+0kP612fZsOtHQ8MDmUPljv9NchX56dqcIJiUeOlxc0pvv2OyeJx+xMVu6jdq7lKQxNdD7758fMFcYrzTz7Jn0xOelau+I5e3+7Z+tGLjx+YlIuO74AqRczkOQNbQjvD0ZyDkjFm+tvYL4JsHoP6OWkd6DJiiH6Raj+xMRbEL8QZGb9S1lEqrrI5GkbuIgm1dAUh4Y+HbDVXiOm2p2vjV5EzIHNoS3PTTgTtmmDme1AFEP5nLvlQw4LtqBC7miP95KYrfgsTh9thF7SIMd4rRjKudQIXMAeKyHquV65BgTIgd+51G/6n0QmW5MGSLwEu/CZT8KWba9Si0rRVURlSyinUZNtcO3VWhPhjXx/jtWEiwwHx/X0o4WlKvYqavMI2aPSvUq9XoetTuvWbRlbSX7UnmEHnLd2br7KVezrFZBsWTMkRVZWoC8xwmxEJfe75Efkkz7HHnyXBtIz5OSq9gQ+hUAj4KsRVX2OFezXaL2yBjUTGL2lqsSsVOR+l2Y9vj+zVWGB6SWDr1bB7iz/evPvVGJIYOa3ReJiumPNlTpbv7SR5ms0IQKi7z6Fqk83nFZKKMlh92RkFDJTA20QP7RCSsM16ekojno+KQ2SlMJ34SrCNM4i+vaS+u3hMVmNXBI9pVPQ4G326fJHUsIyWrvuMi9FOlZH2aadsUYlJm8Cw5SL9+FabtJkZYnw2GaC89Tw6eIgB0E6JFUIEHhiepC2Otsn5spq2GcE7I5JMcCb8TCFCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(7696005)(426003)(40460700003)(6666004)(1076003)(2616005)(26005)(336012)(316002)(70206006)(70586007)(54906003)(6916009)(40480700001)(5660300002)(2906002)(4326008)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(478600001)(81166007)(356005)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:43.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c73e0e0-eb43-4c75-7ff5-08dbf694e986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Sung
 Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why & how]
User interface cannot guarantee system is in
idle state, so need to ensure we exit idle state
before accessing any HW data.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 930fd929e93a..8c5e7f858be3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -64,11 +64,15 @@ static void dmub_abm_init_ex(struct abm *abm, uint32_t backlight)
 
 static unsigned int dmub_abm_get_current_backlight_ex(struct abm *abm)
 {
+	dc_allow_idle_optimizations(abm->ctx->dc, false);
+
 	return dmub_abm_get_current_backlight(abm);
 }
 
 static unsigned int dmub_abm_get_target_backlight_ex(struct abm *abm)
 {
+	dc_allow_idle_optimizations(abm->ctx->dc, false);
+
 	return dmub_abm_get_target_backlight(abm);
 }
 
-- 
2.39.2

