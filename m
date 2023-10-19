Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CDFCDB484
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CC210E4FA;
	Thu, 19 Oct 2023 13:34:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3DF10E4FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzkKXCIK66UI6/mKfvcx0CyoTasrnZSTONX7yxuugZrMtViou7Y5bZZLZQFLdhXmAU5BNPFF9uZAO+yvO2uhhIf5juGImDRT80etZy/xgjS8hxP9Y87K8m/8gyoOHeZHcUHs9P1HtPceKVJWYjRuPmZaicaeQtHHmVrvPcoj0U0jDXk8pubNOYI9UDTxilKMAJoczAqA9Rul2kWqeU31JtApitpWIMcXmteJSl/Pu0pvQo2unUT0uveyfghmgs0ouQbVo6el6YZL6xSxCiqxnvA9m63DYHbbt1fIcrTD4OyvWbnhKY9soAs5rW5qU8TN7fbuTJPQd9NIhYgL85TRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crsMgNsU0oZkIgrMDtn2/C7XmVw6q5GlEqZD1eJo524=;
 b=ITHG/uh8TD24uyGXNVHjFv2HCTz5xh9xqKi7iRVPq4iLgslpygFZzotGwPYJy9DuLoO1zCB5TxfVbMncAdkgMPuuOzkotKvR7oWsUYU2Zhl29qjGPnKul/tL2rn/ISLYcSsXD3uigQ8u/HRR/P7dpIdbUUOKT2hZkQdvMCgqpl1MnZY5sq0+NmSRkRuTc5EfMtr13RN80qp2QQxjjFfWGj3BHtIrE07iDD3QhWgYXOGJeWHZM0bs8iLrjuhc+k7BW3DKmtY3UPtO39pJ1dw0g36LWexBse2JTyDB2MrtOAbInRxKTH0doZx2JvW+sIe6V4FxPbba4+drYyKffvo+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crsMgNsU0oZkIgrMDtn2/C7XmVw6q5GlEqZD1eJo524=;
 b=PmY5g8aW6IfN0YuTVi986Ms14CbUoVkthv5aGuBcHDKzq/rgVSIu+nEQIBLKqavfXC4Mm4Xyv+SM/1DSvW+dL1MrASVGVtjEt/T0fyZ34k1j01g6O5CmqvTbYJwRKjLpu7FdSWHmvVyLtA8XdmH0APZVZx7IpGLEIuxgDD/TFj8=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:34:47 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::16) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:23 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:22 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 23/24] drm/amd/display: Read before writing Backlight Mode
 Set Register
Date: Thu, 19 Oct 2023 09:32:21 -0400
Message-ID: <20231019133222.1633077-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf9dea0-eb16-4c20-a29b-08dbd0a8291d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31HfajLjZr5ONm5+MO4QCDDT2OfErU3cVX05Wf1s3lzylgxp0d0EIFl8wXVe8+aTKUfHIYtIYcIyvJKHEvu/kJZfNAg2qlFtKHBRczITsVdIsQ0Jf1Us0NWNba/KicbR+NWUAfGB3nYW7TL87Z7OlDpUOJ2vZHNtnM0b2rGqjgrMIsNtDqVXQv1VMZgFhWaPYqRU/m+jYXzVHmCy+XNvWvaRCEbv7t4Ija/Wh8zfOa/JSzznRS6OOFySSs7aZzE27DAEVsQIdCyzb8LP4TQ2Zy2EqaB4xeXy9i5fmSH9E/9U5RQOqwT0OgPy2iTQJEytCSScYQUUEyyqC16PdbK7ZFNg0GJZeTB2868HOZL/atffHe3sHfgduno/swMqiObBNXRhVCRYd2STeDBxYDlXCKpfsjp5QsM4GPR9YcVO1xjVOBo8zBUZGBebiEHcqwAHpRVx+eljAVtzDFQZlPOzKo7FmTrmu+MvVIdUeel13h+2UHXmrOdE6DbErdGPaeZRkJiti7leSl7dhaGWPapeHMNjV51n2Xdr80Dgb/Hmj2dBg0MPZVVDFo7VFQDiDnlj700dmtXHl7ol8Vtgo0uXkXdqN2IsZ2WKwSSNjqaG7+dhZXfXTJyYkhGo3TyujVC3z2IglrW/TbcW1aEhC11HUes3nyz4n108iV152OTr8F2sC/klW267uX/aoBbdDFIE9gcQYSFGzjnDrrXKcp6KTpJcY2Y8AglOvoO1kfxasrqWO6wcEMLgsRS72MnfiuoIsTa3ExS+1AG3XSCN+a2ZuPgkW3Rdw0T4ZL5pfPl4SCQSV20NnwkjZXlsRIeGUVC0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(40480700001)(86362001)(4326008)(8676002)(5660300002)(8936002)(2876002)(2906002)(40460700003)(41300700001)(36756003)(47076005)(36860700001)(81166007)(478600001)(2616005)(26005)(82740400003)(336012)(54906003)(1076003)(426003)(6916009)(83380400001)(316002)(7696005)(70206006)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:46.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf9dea0-eb16-4c20-a29b-08dbd0a8291d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Iswara Nagulendran <iswara.nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Sreeja Golui <sreeja.golui@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Harry
 Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[HOW&WHY]
Reading the value from
DP_EDP_BACKLIGHT_MODE_SET_REGISTER, DPCD 0x721
before setting the
BP_EDP_PANEL_LUMINANC_CONTROL_ENABLE bit
to ensure there are no accidental overwrites.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 86f97ddcc595..e32a7974a4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -182,7 +182,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			&backlight_control, 1) != DC_OK)
 			return false;
 	} else {
-		const uint8_t backlight_enable = DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+		uint8_t backlight_enable = 0;
 		struct target_luminance_value *target_luminance = NULL;
 
 		//if target luminance value is greater than 24 bits, clip the value to 24 bits
@@ -191,6 +191,11 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 
 		target_luminance = (struct target_luminance_value *)&backlight_millinits;
 
+		core_link_read_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+			&backlight_enable, sizeof(uint8_t));
+
+		backlight_enable |= DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+
 		if (core_link_write_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
 			&backlight_enable,
 			sizeof(backlight_enable)) != DC_OK)
-- 
2.34.1

