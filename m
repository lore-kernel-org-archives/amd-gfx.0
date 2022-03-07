Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B1D10ED28;
	Mon,  7 Mar 2022 05:51:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D8410ED4D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvAyabmCnm/vpZoxNsYa9a8cJn1R4utJtasl2IBw6VbxoKimP7Y05KL4cn4hHTK+qqdRGM7oI3m+VADWr9yVi6vvIc6uHuNj4jYk66NUuNEwYaM9yqbDgEfcpblZ9qp/voeiRTgbwu2isiYZPVbyKXUncaFSIZ8ovUe2Gedsyu2UVrc/WlwMAbj+tOiZa201BJFO31HjS1l5v/o9xOceSp0p6MSohoKoZYiDg7E+6o9NYBH8CkDthoh7gIFQ+fTQ360Sd2iwtZKMqHP1DciQ35VDkev+9ZJMH0Uathm5tFFiL1mLKEBTjU0wEd9A9WU0Al/fO+9I5mMV4LtcgiA6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9sKkfF+zdmMBk5+ShNqBpcuVVny4MGROBGRCajaiRw=;
 b=oefWSDSm8t2iW7SeQj22ScQ95+F/yQOHzZIVCCPxnpoiCKF1QmmbFr8UqtLaiGdY93s6m93H+TbSG5C9JIxH03QHNN+Q0qTAWJKx57Gttvmb26wrZnG4yHYOKOOVeYzTNAmvkKCj067opaYMoAUDt+9dp4wVEdG+tDb2LC/I5Fo3arr8gTBoVXkBuhN5xna4+dwT73uBio0eg+/rUDQStM3WBbfmzKX+/f/AqyiNTP++H3Wxocq5IVHIctIjJ2OyzFzEWoUDV15N5MHdoKIatk8a4UdariXmiymTNiuoKNw5aQpNHTzDLABHRYXcTbnVD5Ivgm5ByCS0QRIDcD3RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9sKkfF+zdmMBk5+ShNqBpcuVVny4MGROBGRCajaiRw=;
 b=q/dlAZLht7PgYDgtLZpG22EfhJfgmrRz0DQhTYe9IMcoaYaePT+3074pdmaRz0FDVbcUwyq3Byo1DwWrYEvgxeo07EydtWaomj2MDIdvcwRFlOZRmTfECXIxFpJt2wf0YXBXa3FofYgwtjt7korUfy4zbdfMv6NjvyVnTULVz+s=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 05:51:09 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ba) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:51:01 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:57 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: disable HPD SW timer for passive
 dongle type 1 only
Date: Tue, 8 Mar 2022 05:09:34 +0800
Message-ID: <20220307210942.444808-12-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1f8f5f-ab78-4bce-844c-08d9fffe79f7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB158687F52E4F67CB839D6F66F5089@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4S4X6AnfuYVEuXO/E3ZD7pSkmrg2WC0nhvmaOAL27EVCWgaWOW+gqnmMN6Mi95lCZKASSCAkyFK/Ce7EUEDFqTUTnRovw39FU2C/L4nvyHOu/Zo86/2KtuVot1s21YUNZinkMalQY/I8fq/ORpBe87yBh0y9PM/k17IQeyiB2CTEzPW2k0g95XLTZ3sOzps9ZwcXLg1awlWiuw593LKSFZr+8PpA8sXfOQBp2J6hzvbuuqM4ToJT1wvbx54fBpVbdQE1pl1Ifko36wY78vRIEY2d8AmpyZ+kRweYJoz+SeM1upAjRnAJI1eQdXgXs9CLBZKcD1gUbZiKf5D9HP2mKhqBmeVdL9bFXe+h3GLoxf4T/hqisTUJCIWLI8DszYlTMyFU4pVnpGPW1ZF73INfk37HMB77qZLX2uYWE975fKGu8MUy3bZgnF2+dXJQPyQVQlEogsW0UZjz/MbBOXG0hiL/isj8Vqx82kb+G7CRaYOkcZIgdIrw1nP3P86mwCqmllR40NiNxLTrqcjfFF82sAlSEhw/S6ej0LwpwQUneCkK01ySCEcVK79NjVCWIkeI6j7WR7xLYYgni+iXemdS8VKfKIWvz/yn37spkVfuwZG1+HzuVCHCxu+pESWop/5nt9tSNhcJ8wElZNn5yq17g8pZXbwhXFFqZzjNzXDeCqa/N2dD8QgmYFSZR6gp66p2RKl1WKV8WNuVW+9gMY9b+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(26005)(8676002)(81166007)(82310400004)(356005)(83380400001)(5660300002)(4326008)(2616005)(316002)(86362001)(336012)(6666004)(426003)(36860700001)(70586007)(70206006)(54906003)(40460700003)(508600001)(1076003)(2906002)(47076005)(6916009)(8936002)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:07.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f8f5f-ab78-4bce-844c-08d9fffe79f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sung Joon Kim <sungjoon.kim@amd.com>, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Need to provide this workaround
only for type 1 passive dongle

[how]
Detect if dongle is type 1 or 2.
And use it to determine if w/a is needed.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1951a92e3417..b3ca3307d39d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -731,6 +731,7 @@ static bool detect_dp(struct dc_link *link,
 								sink_caps,
 								audio_support);
 		link->dpcd_caps.dongle_type = sink_caps->dongle_type;
+		link->dpcd_caps.is_dongle_type_one = sink_caps->is_dongle_type_one;
 		link->dpcd_caps.dpcd_rev.raw = 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index f1bbd918de35..1d4863763df9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -493,6 +493,7 @@ void dal_ddc_service_i2c_query_dp_dual_mode_adaptor(
 			sink_cap->max_hdmi_pixel_clock =
 				max_tmds_clk * 1000;
 		}
+		sink_cap->is_dongle_type_one = false;
 
 	} else {
 		if (is_valid_hdmi_signature == true) {
@@ -510,6 +511,7 @@ void dal_ddc_service_i2c_query_dp_dual_mode_adaptor(
 					"Type 1 DP-HDMI passive dongle (no signature) %dMhz: ",
 					sink_cap->max_hdmi_pixel_clock / 1000);
 		}
+		sink_cap->is_dongle_type_one = true;
 	}
 
 	return;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 333f4a49cacb..a57ac086f2bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1206,6 +1206,7 @@ struct dpcd_caps {
 
 	/* dongle type (DP converter, CV smart dongle) */
 	enum display_dongle_type dongle_type;
+	bool is_dongle_type_one;
 	/* branch device or sink device */
 	bool is_branch_dev;
 	/* Dongle's downstream count. */
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index f561e213bf98..f883d87791fe 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -64,6 +64,7 @@ enum ddc_service_type {
 struct display_sink_capability {
 	/* dongle type (DP converter, CV smart dongle) */
 	enum display_dongle_type dongle_type;
+	bool is_dongle_type_one;
 
 	/**********************************************************
 	 capabilities going INTO SINK DEVICE (stream capabilities)
-- 
2.25.1

