Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2BCC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 21:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773A3601FE
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 21:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773A3601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028796E05C;
	Tue, 23 Mar 2021 21:01:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CF06E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 21:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD+3FEy9yaibJSukQiMGdyVrbEWELQGmicp+35jUjh+YbTYRQpnwnvUCRopUJXEenLljJUYPC7K0OHOYvMpBP6EovPRCaLdwdQhCXXYl9ZokayrtJtod2LGTptufbvY+YLSe66Y2e60/uXbHnwseLJmE7EX7nR1Viaxe9oVw91RSpFYlt21fSRIkfNmG5lGIjf3jrWltVwJpo0/yoLtdad4H4biu6jvsWBE8+531D8OUqUh4gmbDSPPsEoK4UEL2dUaBOrzbcEhvsSEpkhjwvumy1wPIpvG146JAdomd+3MLAiDk4TKtdy3q0OkJrK3YyNA9EkkTdi8A9cGBR+jEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+4sPHkpisJu0MNuNLL/HXxVHMRNanhTqXq2E5iDLGg=;
 b=Op1sxz4EaVfw2UjfGachN8I9+JdcV0CyxeLSsdL2+93sHt6lf4WGepD7H2CQmNRCgHBwUXbjAb2W3s6ZFBEiKOduatW7zKCxu5oC33Ir6nrnJjsDci4niT/Oz0DqEu6n079cDl6Lgzj9PrysCt/oPilIqSUl0SSthUzfKbhDVb+M24uJLoH0N49jA9YDcL9AZGqBq1Wp5ufiBsuPa5Ke13XH3qRc7y+FokENsXtW0hC1f3mwKlv2OTo0uUCIz8F6d9BGR2TN7vEeO/6GW115CbMFiLcNyI3ozaczfmfrqR0ZVO517zH5RqS51/g6v/rVF0RK/0BPB8N74hbKtkpAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+4sPHkpisJu0MNuNLL/HXxVHMRNanhTqXq2E5iDLGg=;
 b=Dm0wpsPz4DFRazoen3K5BMMn5yLSNNX00p47MGohJLowCq1+WucChrWzrtKM/Er1N/7OK+IYlOYmQ7oRpu17cjxJIz5HOQZWYL676Zq15H3eaOSyMYOZ9XOWxX6DYqhTJ9IN+xi8z6WABetyYyQfmO3G2YUz+8X4ZLHf8vxppp4=
Received: from DM5PR22CA0019.namprd22.prod.outlook.com (2603:10b6:3:101::29)
 by DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 21:01:48 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::66) by DM5PR22CA0019.outlook.office365.com
 (2603:10b6:3:101::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 21:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 21:01:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 16:01:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 16:01:46 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Tue, 23 Mar 2021 16:01:46 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Removing unsued code from dmub_cmd.h
Date: Tue, 23 Mar 2021 17:01:34 -0400
Message-ID: <20210323210134.432845-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a8f292-c1bc-407b-edc7-08d8ee3edf95
X-MS-TrafficTypeDiagnostic: DM6PR12MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27159150BABCD1B4D23D0DC4EB649@DM6PR12MB2715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3sdGB/rElZW/Dus3Ckn7udU+mGXcAmaSIsxikYBgVVq39qatwjR4hGykBo1oi7ohDHK8SX5zqmcv8zThIxo3cZYnDd2ak2kGC7hrw7g4J68bcNyftxPQhdV2Tz3c9LrLoCUNybOiJsdYgx7TwyaZAqUQf1rZu11TekxUg5z1bwgGhhinzJmy5y3GcRTeD7/yhCC/LAQsjpy9YNX80b1DjRJvaPP5LpM09CqOEqw5AyISS9fnSmLekmAHD6o+6X/LootvJVslT1+RVK/qC+m4oDOPZ21tjdkw77guX2yCpjMZ6/1k0VhZFNo1YarMa2seNsO+l2wgXNkGM6/d3rt8bc6cD9u0iyj+h8bZ9wuO8R3qV4KsNZ8wIIpGFjyjt+sgECN8snc3THTFCJw1ec7NfyLRsJLLldOfAwZ2BCl1CvZbSpCcTGOHnWrJup1tHG2h75PxNKmIykz0Fe0Bo78L5Rp2FN19ZkDwGwtb5u6LtbS4awmLBUq8XYxnkLQXdES+eM9iEMhJCHpev8K4RzlY0IEW+BHiHkK92MTEQc9xa+XUntysp+E7e8Gc6mMm1W4+ycAfusp484kR15fe4BEY7GEbsAYz9MLR6E40bzgimZxqfpvcDfZodB7pGmMrXwQZ5MkreuuofgYsDp9uNG8XieIP3vxNajcyyjftqRwtqokv5nptACA1AhfyQXag38h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(478600001)(70586007)(316002)(86362001)(2906002)(70206006)(83380400001)(36860700001)(82310400003)(8936002)(5660300002)(54906003)(4326008)(6916009)(336012)(7696005)(47076005)(81166007)(26005)(2616005)(6666004)(186003)(8676002)(82740400003)(36756003)(426003)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 21:01:47.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a8f292-c1bc-407b-edc7-08d8ee3edf95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Rodrigo.Siqueira@amd.com,
 solomon.chiu@amd.com, Harry.Wentland@amd.com, felipe.clark@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removing code that is not used at the moment.

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 09c62485a1f1..2d23462f4980 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -202,12 +202,7 @@ struct dmub_feature_caps {
 	 * Max PSR version supported by FW.
 	 */
 	uint8_t psr;
-#ifndef TRIM_FAMS
-	uint8_t fw_assisted_mclk_switch;
-	uint8_t reserved[6];
-#else
 	uint8_t reserved[7];
-#endif
 };
 
 #if defined(__cplusplus)
@@ -532,10 +527,6 @@ enum dmub_cmd_type {
 	 * Command type used for OUTBOX1 notification enable
 	 */
 	DMUB_CMD__OUTBOX1_ENABLE = 71,
-#ifndef TRIM_FAMS
-	DMUB_CMD__FW_ASSISTED_MCLK_SWITCH = 76,
-#endif
-
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
@@ -1115,13 +1106,6 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__PSR_FORCE_STATIC		= 5,
 };
 
-#ifndef TRIM_FAMS
-enum dmub_cmd_fams_type {
-	DMUB_CMD__FAMS_SETUP_FW_CTRL	= 0,
-	DMUB_CMD__FAMS_DRR_UPDATE		= 1,
-};
-#endif
-
 /**
  * PSR versions.
  */
@@ -1791,24 +1775,6 @@ struct dmub_rb_cmd_drr_update {
 		struct dmub_optc_state dmub_optc_state_req;
 };
 
-#ifndef TRIM_FAMS
-struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
-	uint32_t pix_clk_100hz;
-	uint32_t min_refresh_in_uhz;
-	uint32_t max_ramp_step;
-};
-
-struct dmub_cmd_fw_assisted_mclk_switch_config {
-	uint32_t fams_enabled;
-	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_STREAMS];
-};
-
-struct dmub_rb_cmd_fw_assisted_mclk_switch {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_fw_assisted_mclk_switch_config config_data;
-};
-#endif
-
 /**
  * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
  */
@@ -1951,9 +1917,6 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
 	struct dmub_rb_cmd_drr_update drr_update;
-#ifndef TRIM_FAMS
-	struct dmub_rb_cmd_fw_assisted_mclk_switch fw_assisted_mclk_switch;
-#endif
 	/**
 	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
 	 */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
