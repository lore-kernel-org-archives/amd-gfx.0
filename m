Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E3EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9A10E5B1;
	Wed, 12 Jul 2023 17:13:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD4B10E5B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THN62b/Xuuqu2qRf65da4H0hfwNamnxbcVkQ3yM3sOvs5oAMBLkxgiFQafFeFEpnJ0SulePl/Yql+Z9x21j7K4QUMxCycI5JiHA1JfYYd1G2AL8QndlcDPLtl+xzzNhDUAOnznB5x/EyuPbPEW1E7jKzAo9pjjeN6g2FibNksQm44rHALDac3+H7hN9VL9+0wp0WzB+9lgGzABTPkmxfVAN56aKsBc5nx3HGpiKqUoDYwED4YHGn6Rg7tkJN8MXSQRSZ5zl66yHp+NqdLj9OJSqnPXjH9nVrK1K/gil1w5oH431OZK6W6cAFbygTV2daqY6y40saJ4UKx8393Gt7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMtmdsx9cCOSvCo3R79uZfgnzn5jT6ZVDkt/J03fVi4=;
 b=KMSbnJMdYqrVAWw/l27ku5ZazMVCs2T2ieKe6BCfgveHO6SsEpM73giiB+7F8pD6GRE+sW9Gc49LAjkbWv02FywawYrkRI0CprRkcEheJdEGJE0A9IOr0wutWv1M5EDMOY01N90+wQNttC5mGyL1aaOxaXPbYTg1fL5lWj/byzCi1vtBGggEDovNnz6dTs1M4FL7aDC+1YEmQvEyoDhTDNSll+Jjix0bBWmTM9/FuWiUfpENxAyp17POZKuNfESaYmnBO70s9b98ZCpdLXItfUel2cM8rlYwRTKLko9E2DrZqZ+0ucaXHYF7yOeT2etYStvOjfnAjTdft7KLQStbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMtmdsx9cCOSvCo3R79uZfgnzn5jT6ZVDkt/J03fVi4=;
 b=SSAyMR7eF5ys+bJTyuvjRyOpQLk+/RKjY0fcHqfSXZ7Z7qHzEuF7TXDH0eMGe/KWiWSHxsryJ0H0LTZGWEB01GzoRaNw7wsa8ZVS97SjnayVKj7xPjgHAro/cGEae5FyNbxcJN1zYVkborO5mDaMLMTap8yqu12OSKN2rtD43GE=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:13:34 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::7) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:13:33 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:29 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: Add helpers to get DMUB FW boot options
Date: Thu, 13 Jul 2023 01:11:20 +0800
Message-ID: <20230712171137.3398344-17-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 53563ad7-b9c3-4ac8-aa7a-08db82fb5311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHIQdIJdMGyUiTKK5xfwy2mwF149FRhev/aI3EJ6QFFIENRg1OGJ13bas2QIZzFbefzZYKDB/Jr3G6i6+5ecz3TT7Vrn4LHSAhKdCSRvrb098zFXcqpX1rLoEq/x9qilrYOi7+lRlnRinorDhCyTDaJkwfHXKH7flt4astJP6nfJwu3og5C+7Hcv5SkWfzVj5VaGOy1+fncALWu1NTHmE5+gZEtpUSREaUdPnvVC8N78Tqun1rBT0mctheI/T8fESl41DaJV6wIGIP168Hn1Oizb61uZlssAeytbolhfsjgIUkwK4n1HCsy7sHifA1dmiXnwp8Iw5H8YniSqJICEXTUyyZ/oVVORbphwKmJ1VxFTElalZX/5GnunU/Q2rzxrkrO8kcSEtKFOhdhOy5oMAt7IfGWFxks4ethdD7HxBXpRP3lwhKbfaLOh6hUV8zL1qa0x47VSpSEVKNs5ooTZ70ShxoRmzb0MQ7RD4xEdAvgRoY5sNXsExm2cpTAexZHjj5GDxgeXMiwcOgLUTEgBd9aSNOBXz7GTs0QbGdqgz+PNO4VX8M3tofFvyt5CxEeVK0iEw6z9H7YtgEI9yx0j6to4sfPlOQuDXqNjh5Ngh6bzEm7KATQOVgsYCejYscvym7EVBXkXMiNv0BFJHexXToWJIZrGVdM1kWQoXbjys5pD/kCz//tiYUSOSai5UDb9Q7MXvGEtmfthtS26ODinsAkBn906r8rD3pyO5nHfY1ajt5RLpiiCtmZnBXGINUZ/oR5l3q3wFoOAKZW0BsXJpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(8676002)(8936002)(54906003)(7696005)(6666004)(40480700001)(2906002)(316002)(5660300002)(6916009)(4326008)(70206006)(70586007)(40460700003)(426003)(36756003)(478600001)(186003)(336012)(86362001)(82310400005)(356005)(81166007)(82740400003)(47076005)(1076003)(2616005)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:34.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53563ad7-b9c3-4ac8-aa7a-08db82fb5311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Cruise Hung <cruise.hung@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <cruise.hung@amd.com>

[Why & How]
To query the bits and print them out for debug purposes.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Cruise Hung <cruise.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       |  4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  8 ++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c   | 15 +++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 4585e0419da6..53bd9bf8f0c8 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -378,6 +378,7 @@ struct dmub_srv_hw_funcs {
 
 	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
 
+	union dmub_fw_boot_options (*get_fw_boot_option)(struct dmub_srv *dmub);
 
 	void (*set_gpint)(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
@@ -778,6 +779,9 @@ void dmub_flush_buffer_mem(const struct dmub_fb *fb);
 enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 					     union dmub_fw_boot_status *status);
 
+enum dmub_status dmub_srv_get_fw_boot_option(struct dmub_srv *dmub,
+					     union dmub_fw_boot_options *option);
+
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 5e952541e72d..094e9f864557 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -352,6 +352,14 @@ union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub)
 	return status;
 }
 
+union dmub_fw_boot_options dmub_dcn31_get_fw_boot_option(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_options option;
+
+	option.all = REG_READ(DMCUB_SCRATCH14);
+	return option;
+}
+
 void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
 	union dmub_fw_boot_options boot_options = {0};
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 89c5a948b67d..4d520a893c7b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -239,6 +239,8 @@ void dmub_dcn31_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
 
 union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub);
 
+union dmub_fw_boot_options dmub_dcn31_get_fw_boot_option(struct dmub_srv *dmub);
+
 void dmub_dcn31_setup_outbox0(struct dmub_srv *dmub,
 			      const struct dmub_region *outbox0);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 3253162e3701..70af110af687 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -255,6 +255,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->get_gpint_response = dmub_dcn31_get_gpint_response;
 		funcs->get_gpint_dataout = dmub_dcn31_get_gpint_dataout;
 		funcs->get_fw_status = dmub_dcn31_get_fw_boot_status;
+		funcs->get_fw_boot_option = dmub_dcn31_get_fw_boot_option;
 		funcs->enable_dmub_boot_options = dmub_dcn31_enable_dmub_boot_options;
 		funcs->skip_dmub_panel_power_sequence = dmub_dcn31_skip_dmub_panel_power_sequence;
 		//outbox0 call stacks
@@ -846,6 +847,20 @@ enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_get_fw_boot_option(struct dmub_srv *dmub,
+					     union dmub_fw_boot_options *option)
+{
+	option->all = 0;
+
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_funcs.get_fw_boot_option)
+		*option = dmub->hw_funcs.get_fw_boot_option(dmub);
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd)
 {
-- 
2.34.1

