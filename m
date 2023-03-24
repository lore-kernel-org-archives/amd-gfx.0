Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C3AC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE1F10E4FA;
	Fri, 24 Mar 2023 06:53:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C4710E4FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZy89UpfuWGNBFMYL59w5yv5nWbCT4HIQKrDe8ejKGBTAgo+y+0f5799TxDgywi9y5T4YcBzQxjkzrW3EUYQfYThbB/wLJosKHFqLGS3PtdGqpABGoyk2a5Q40Ngfr5ZHbPWZg0/ucvkpSOnOCs1+at0bGeDyXS95QZC6+Gb/aorNQBHUkAyRI3CqylPRZslCSoP/kZOpW+YlKsz8W6mqCEL5UvCiHkeHgltDm+P7SMh4s4GcQqeJIAC0zwrd1dUPmCQYqWwfRlXZvxJgmHkEj1Ch3uAwpVsZrATuq1LovyhepU9g1DZIwkcNr3pkJ+hP5DAEi3C1So18u3tuEXVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waWv7qsPsbWAylhSD5h9TKlZmB5F89lh93r+eN1hslY=;
 b=R1kmDz4fzK0hgXPUct4E2WKuXq+eTC0Iigk/9vKjnTcm46t71a0QUTCGTm2etH2zzSTr5l0/bqwcI66oevmybMv9kfwGaS1LpenhzL0bVUjcbk9ln5N1SQ7VG0+5BsvY6cNl4DpZxBzN+sjaaLYfW6giz01TOrvNp5YKeHeFea8eP/mnVoYXPWNcr0JLDntmczhtdEhbDWRhReyc1dL8MJofmRLxfRLoJxZN0do84fOvv8u8V/Vl9UsLARkEAr7nJ6OIGR0NgYL7qrCQKcoN8TeuTWenEawuliejr+Wdwn5x9t4sIo4Vqosb/su+kcJG4mnlcCT0MvL6Rv5uPT0/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waWv7qsPsbWAylhSD5h9TKlZmB5F89lh93r+eN1hslY=;
 b=M7KjjrAp/uJCMHIpMyE1TGf7zg0/tPeFO+gXwixCUcWDr9vGNSbqQrnoR5J2MmSQe9+6jQgn7CakcY6f1NB3/CcFIPLIznWlTEwSFYB/2Mf2R8Bvfxi0oV2yipUkFUFpypio9Zdg1sYQXeSFygPaop02c58w1NBKseV/SO/9blo=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:37 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::9f) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:53:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:19 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: [FW Promotion] Release 0.0.160.0
Date: Fri, 24 Mar 2023 02:51:09 -0400
Message-ID: <20230324065111.2782-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 676ac7d0-d37c-41e3-9a88-08db2c347dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGKtxF4LGLo7H4wwAgctSuIrlBhEIyLGnxIPPMcOH5awp2Xc6QFFYAz9ZbRn0K9fAgkvpp/aEl1q8cwxEYkLA1N9QJ2NF0XrJ30YGxQ/W7825qM52/IksERW+Tqx63ccUcocCIRRF0jvhUis2FMkoofzs1SpaXUa28t7OfaQrNuAQb7V78Ur3WayUiLSySaXk/ziwfdpC7m+W8HRkUSj9VROtfC+mpfk/0BnFRmCRS7/xEDwSMOIBHIDrAg98WiHJobd18k7id/DdfEipbmS7Fh1qeURfXEtXQQFgC0kLNUcwbo3f3wofGnA/a/0g9BKnNQg1z6VRfCyOmNlezHjoisIiFR+bJ6iLbSsPhKmcumkIQS3yJTZBmvI5W33QgTkNCujy4jVfmIVEbnOrM6olc3pnLImdneS/joQvj+V7/AQFstQZlTaq8xk5X0idsyMsVbCO41UuoHlfVrXaSXQSfN4xLo8n8tgzy9KOAdHZIE112BV6664UMMIW9TOODtcQYj7rJa+CFOB1ZEdjzkcmkqeCEgiKQOTuxQMDoszQatXaJODFHYk+SvGa0e/xlrBlAqCAZQ+7wJHRkErrZfjkzE5GDdxCzkIFzjv1+jXMZKJYgwEoCH6bZtsU0YOOMscaQ5r68kx7Smss04Nkmn9Re48Q6zEGtNn9jHlEuDVw4nUAt5+g+yKuA8q/olHgMR78HoePkeanbQ3GenNdNIRB1+9Wa039Oofq+7OMMoXeVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(82740400003)(81166007)(36860700001)(36756003)(70586007)(70206006)(40480700001)(316002)(54906003)(8676002)(356005)(478600001)(86362001)(83380400001)(47076005)(426003)(336012)(16526019)(2616005)(1076003)(6666004)(40460700003)(186003)(26005)(44832011)(2906002)(6916009)(5660300002)(8936002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:36.2919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676ac7d0-d37c-41e3-9a88-08db2c347dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- New parameter to define extra vblank stretch required when
 doing FPO + Vactive
- Pass in pipe index for FPO

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3175a4fe4d52..15d26222597a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -95,6 +95,13 @@
 /* Maximum number of SubVP streams */
 #define DMUB_MAX_SUBVP_STREAMS 2
 
+/* Define max FPO streams as 4 for now. Current implementation today
+ * only supports 1, but could be more in the future. Reduce array
+ * size to ensure the command size remains less than 64 bytes if
+ * adding new fields.
+ */
+#define DMUB_MAX_FPO_STREAMS 4
+
 /* Maximum number of streams on any ASIC. */
 #define DMUB_MAX_STREAMS 6
 
@@ -3084,14 +3091,15 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
 	uint8_t max_ramp_step;
 	uint8_t pipes;
 	uint8_t min_refresh_in_hz;
-	uint8_t padding[1];
+	uint8_t pipe_count;
+	uint8_t pipe_index[4];
 };
 
 struct dmub_cmd_fw_assisted_mclk_switch_config {
 	uint8_t fams_enabled;
 	uint8_t visual_confirm_enabled;
-	uint8_t padding[2];
-	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_STREAMS];
+	uint16_t vactive_stretch_margin_us; // Extra vblank stretch required when doing FPO + Vactive
+	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_FPO_STREAMS];
 };
 
 struct dmub_rb_cmd_fw_assisted_mclk_switch {
-- 
2.34.1

