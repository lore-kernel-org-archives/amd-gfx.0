Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBA9ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747F310E6D1;
	Thu, 27 Oct 2022 18:40:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A4210E6D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dri0cj4/8b4IS+Olg7+knIGSPUIXSuD+2X5O11EKnAKlz4B30wwqCkvz6n8LQQ4bciJ6IVCKwSkyl2stC4l6WXNJ/xT12IgdyTQFTgUi27jxugFn2eK5ggvvyd3r0x22RlRMaCJ9MNawVkeH1oZG4AjUKPx8mHQRtAnp/yD4Kbzs+G9NTvFmyqp6kl8D4OKIjaREoObsl03koKBkXRSOgpPOPbvuJO+xVPWdaENZSXuwoyy584Zpew5d4nsx1hb+0aOxPLVW5PSSNxxR9csARGidMtS540f/7eCtpoU4jOVsU++bkSUlO6zsfDsL+dyh0HOmeZRH1o/nxXTii10J3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo09kAHPEiUI5GT5JiwKmjx94RztQ7fxngyhuVNvx3M=;
 b=Z5vd35WanRIUf9hxze0CxNwb9P3vDDScCEann5NkUUqDgmkZgM2vMiLMLVZDeAF4w74VzuL8jpnu08oIikx43JDufg5wnmf+Y7bc+nafOMpRzNPm60DHXmNgAnYu7n3hHVlWqpp85hvJeBn5thGkFMWMYdqXsB7tP7Zxxz925QISQWRGoBuXKq5BmSYqJUO5TSZBJAOT/+zgQGcsbHVkwpj37HzP+YxaktCt67mTzK2eks0ajcpFuO4HnliCpTgARD4uGTtK8kNs3IhTxeTV/68TkaRW17wd/1EjW67vcB/kYJGpxiO8XDxY9PkKqPKQg9JeXlNdVqamQADTLUyyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo09kAHPEiUI5GT5JiwKmjx94RztQ7fxngyhuVNvx3M=;
 b=S1ZWax7MBpAx54G+23+C8CvWdv0H491YngKltkvGTnTCnq54DF+guJPBN6WES1oDVCUx66YWKLi5hfoDHEaqSI0GzYj1c0OOhvttUtB4vWAhk0lQZao17JmJPM3xPQt5/4nfoKX633hc8qWenqCawwDVk7kPnjGnUjfIrL05g5s=
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 18:40:17 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::49) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 18:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:40:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:40:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/18] drm/amd/display: Modify checks to enable TPS3 pattern
 when required
Date: Thu, 27 Oct 2022 12:35:32 -0600
Message-ID: <20221027183543.1117976-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0de604-0acf-4bd5-ff80-08dab84ab199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDvePH+xSUl3sZCGau8un57L4LiSSvsrHmw1P+t3xr4QtfIPo86vxPxo/JPCsYrYq83Oa/jUFYXCKnjRa67Yl1wzmTKHFQ6cDz2WUGyRjBDNMZYwe30DSr/SDCDYfhl3+HMWKEsI7dlhvAshIuA3+VB9dOoZOMJOmAxdOF2dD+Zg2/ZnruthyMqihoWGlt84E8XISTJO0pFrE9avhPK76WTzBGSNXJY//RK5S9h1iFQLvJBsTXxVnAZjvy1HyDhG51sJkIlI9XdNYJgQFoiU6QBiEeNEtwgTX4eyVKMxPEKQGIpoF6WzV2FcpBfn8/lvq4rXCEeNxhmDRa74KFSSMvFD9CbHjMnRd7J/w84vjkD220JvHX0zoIYTbPHYyikBtrcHrhveJpZ20ST3PFxqTETyVPUAdhmoL9RiXWtyqmPs7Nw0NueanKB2KlHav8CE0DEjQmzRRIPIU/RJAqeAM1O7aTjr52S0+1THU1op4VfYwxsYQbGk+fZfx0s3YRi8JiN5REZWTL5kXRg8NlyNigCvrgOxK/d5cL+cu93MhWJywB++bPGXPpPJhxCxCvkNCgeWStCvCPlxjAkkNChfaUFF1wwHvBVbDtDCgM5HIm+F1/5Bw5ttp10qFWZqxtj5E1VxwfdcFhbJrkbyf8GqdaEoLRShJ8jShHM0JcoC6nAj1EA//pPwUuxbJRhg44NTb2rhpgGVhyj3J6klrwmQUVDVMRIDXAnQqcovlK9zDx5YtmEH4S4lvNPeUdO8bKtC03oLiZYy3pOi/XZfrdVWrfrrxSHmPbfPUXhRHTAShbvNXc8RtDsKW/zLa6bDehHA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(2906002)(5660300002)(1076003)(36756003)(54906003)(8676002)(8936002)(4326008)(7696005)(6666004)(186003)(41300700001)(478600001)(36860700001)(86362001)(70206006)(82310400005)(83380400001)(316002)(81166007)(47076005)(44832011)(16526019)(6916009)(2616005)(356005)(40460700003)(26005)(82740400003)(426003)(40480700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:40:17.2628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0de604-0acf-4bd5-ff80-08dab84ab199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Iswara Nagulendran <iswara.nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[HOW&WHY]
Checking if both DSC and FEC supported from sink and
source before going with TPS3 pattern during link
training.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bec5e9f787fc..cda1592c3a5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -399,7 +399,11 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		link->psr_settings.force_ffu_mode = 0;
 	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
 
-	if (link->fec_state == dc_link_fec_enabled &&
+	if (((link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
+		!link->dc->debug.disable_fec) &&
+		(link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+		!link->panel_config.dsc.disable_dsc_edp &&
+		link->dc->caps.edp_dsc_support)) &&
 		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
-- 
2.38.1

