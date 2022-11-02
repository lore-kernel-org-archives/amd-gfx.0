Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA77C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826CC10E4DA;
	Wed,  2 Nov 2022 16:03:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A63710E4DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvvHMEfIPhnK0GwoE8keRFUt1SonSNf7qp8VTRX1PnFOXa0uggB4Qeuo5RmG7XTzshbNvZ1NctuiOqpMy9gFGXOxwQT0Cqz+ZDVEMF2tn/PxSt2txfQFnegYvHgEozNRq7foASR93l7VU0kiOz3KP1OfRGnp1duWvzP746UHK6A6i+zKtJgj+/8BbOdybLSkFJfDUF+kh4k7X27VkANK0I0b+o77UtwDGGnD4LG+sacJ+SxZQ/X7gy8NMRXfsx4twQrfRAVEm7lDqR1upqlFYz2Zf4wmfMiGEEDmUxKZtqsaWxdC1zvfcRTXYqlllknWMMWwsCNZ+acKxtjlQiDhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yGVOozYw06uGTdLu6uWqeRYOgql3u33FqJaY0MnH98=;
 b=hK+lfe7yuoG3Xuf/tSOsZ5qo4pN+aK1WzWipPstxXOZYo3SGCn+UsaLHaeiVV2D+muqNgkyidOMoymoFuEnzHdx09coITy8YDMkdcb2QMOUIgEUyAGOG05mdWyUf/c0f1LNE7qK5HsPYQU5MPZXwSCCXbNF0p8bbFsHRJ40lRCUtyz2btHf4Hodv7N8aqHjO51LnSdfoka2A2Vdztoml5+LVnl4JpAK3qKy/vRc3GrBiFBeOo4E+raMEb1t45rhFIIJqUu0vUe0IoTd5qWWCnc6Q0QULf28MftvR3kZftvFdLraYxSFxrlDUrUm37Qu77bAMLLjqEVO7I8C1Tf0uuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yGVOozYw06uGTdLu6uWqeRYOgql3u33FqJaY0MnH98=;
 b=PSBmdH1f41YCW6Hnzxu2MIiczALRLQJaD45e1M8Hi3SHAYel5wFDcjMihWy5LNQcIRfH7qfBS0KquaiqAelGvv1ZDMAYcD0iNCUE0H31dYEVDC/z/2D1fS4NTR/2XCtnBfBaa4KOuXwc1uB0MHCXByE8K3paJzTmE/0SIKThzeQ=
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Wed, 2 Nov 2022 16:03:00 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::20) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:02:59 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:02:56 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Adding HDMI SCDC DEVICE_ID define
Date: Thu, 3 Nov 2022 00:00:57 +0800
Message-ID: <20221102160117.506511-3-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|DM4PR12MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 918ef577-b339-4578-220a-08dabcebb75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSybG3Nvdu4EGgN7DyHI6VbjBEEC6P9Yk9TZ50P+AzrR9VcZSALFxI9B6PVPyMDk41ljyQfcs0RGy6T7FG0wiQU1YD1gRTGOGXMp3XcL0hSVX5UhsH4xsVOaI5zS0Aq7MKwf31gJcSGQqrGrkFngxF0TcwZPK6xKGteSQw40pu/ymoRXxgJFeSmPDtUiXrHNxwT7Ivsfo+lVMzoz9EG5ZeMk+cSwR/TLcj+KLdcrPV63urEvhxnUDCFl23VTsJSf6rIv+F5Ywf6kaWZYmwCf00XhQHuLvqdOwQBpRlqQ1TGKviLbe8MICTRkTKASzXrXJgf/bMlESoxUzuQaYrR+X47EsMBk3BqdDcWNlB7S6RNH3rNsdK5Pur1uZbdRfPsEFb6Pdghp/pE/uCYt+/7XTsh5N6wJlCrS4W6pV8yi/1ySxDhkGm+cztxwcCAA1SEouRm7k0HbNP0An0KvABY8VFpNfGugfMnlyBv9IpLHUkibTJVCUuqKvgMA84hxF+jeM5Ms0wzIVKP9ME+I/qV3enO0kKI7GCEuyo0Sub6B8p8uPDyYTdwty+W1csw1myCZ0CNnbSv7OHmeZkj+wbVWSUKd6MP/DQH8q1Yq5E5fW2CzXXos7lzdQ7rY+FJbriq6u+cfq1rOKkeAWDmEIK+p0FQaaWBQLiWI9AmQboHXu01ucS+m6Cm6/7r18d4tWy7zx/Nw2rtNUEr12DJMZodOtj1BqxXALlLv2Etnyv9ahBERDgRwhSldi6AYXPVANv0kcSUw3xP2r1AiCqR3un+9iBEHCKLOyHphDYxyUYMG/HNyYnqQ/qm1cwrGI1tDXoJr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(8676002)(2616005)(2906002)(70586007)(70206006)(7696005)(47076005)(426003)(41300700001)(1076003)(26005)(336012)(4744005)(5660300002)(4326008)(8936002)(186003)(82310400005)(83380400001)(6916009)(81166007)(82740400003)(54906003)(316002)(356005)(40460700003)(86362001)(36756003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:00.5170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ef577-b339-4578-220a-08dabcebb75c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

[Why && How]
We will need to differentiate vendor behavior in the future.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 651231387043..ce8d6a54ca54 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -82,6 +82,7 @@ struct dp_hdmi_dongle_signature_data {
 #define HDMI_SCDC_STATUS_FLAGS 0x40
 #define HDMI_SCDC_ERR_DETECT 0x50
 #define HDMI_SCDC_TEST_CONFIG 0xC0
+#define HDMI_SCDC_DEVICE_ID 0xD3
 
 union hdmi_scdc_update_read_data {
 	uint8_t byte[2];
-- 
2.25.1

