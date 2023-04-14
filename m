Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E15C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5F610EDD1;
	Fri, 14 Apr 2023 15:54:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FED610EDD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0GgGQFJFAr9aa60Gz+ksk8YpFyVpytVd4UIqU+jOr3E4V4QjEncd1SL3JTADGziAKz2+yIdsDlYK/b6EPTWY3u1q+7QtaLcRlY0i82DHDvBWqSus+33J6EpgrcJp9Czoin1R72HcR422deawlCejGIF/Fox19Fydc6mE9TMK2nvrjtaw335+Q3IHP67TgJ6l8L0QyVWcehi8TuKFqr9y7c8jH+k4ieSOpp0MSNML/HilEkldhTMITXALP/4tTvAONBm+BBjlHLiAbKqEeUjya1wYXZCWtioA8oPh2LM+t5CnNtL6Ah/vOiVqY0X6GQ+DLYjo7wVQbj9ighV+6QbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPleJNPXKULl+8Cw4wB8NmYsDUDfzmNJxpouoJUy+6c=;
 b=EAydQTvh0EJ83IBS6S51vAoNtpBX4NdpzTYHfVT6M+eLq9y0r/au+QzJvK1KnOxPzTzhNz0THqyEBptM4EmjHsKIWkwGFm0fLEQz0v9KtzmoyNB3BY2z6xUCkdQ0lPmGS4txq1ggR6+0ppUGGeKIQitEpo3v9BS2Q5JFhk3wyeCodLbEl+vOdrAppVIi8qXReW6siXRpPJ7RxXSES39342SURqH8C+PQSMttsGNi10fSzpQrQjbe3reGoS8bb2g+fx2yiNBoiocUbtP5VKrc1Tc56a/urVJmZKaiXLSpKQLqqUM3PHplR8mOte5FUAwCnNPc3GWguBupUJnmiTtCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPleJNPXKULl+8Cw4wB8NmYsDUDfzmNJxpouoJUy+6c=;
 b=hojbPFbE7fIZaiqSdTgiD32fnLuL9GBWl75PuQSEzV6FGnWwDNETZYCfNaFHnbw8aGH44GVwUO9GPK5jeZ5dpMrjFij9A6lnLdy67vPH0JdbecakXa7XtbOjnkFU0vKUOxGyFNTfOgBcMuGIDrD/i2/F1ni0o/MR90x2uNXAhKI=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 15:54:32 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::64) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:54:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:30 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/66] drm/amd/display: [FW Promotion] Release 0.0.162.0
Date: Fri, 14 Apr 2023 11:52:54 -0400
Message-ID: <20230414155330.5215-31-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cff3a0-8e50-4d2e-c1e9-08db3d00897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvpoIoNFwdL22PWqFiBHs0gbRht+2+zIU8IRgO7xMej9qEln4g7RK0iVpSDs8ADe3MATFdpehF1qk8SYuP/Um60/AZ0A02Exqh3HaNtR+iriDM51tV9c7fhM0DHZr2JjxYiyrGo+GiyZ5OPT2W0YQlIP8bjHoPrkjOnHSla2tza5mjlwR/BRuEPilEF5ArJHS79k0TJMyHP/kyKP83/eNlgnULtuIai18l8YUMVxk0g6cM1zpkzxHeDadALUV1QXDkLm/gO2E5NFP0Z2vpW3wHg1MtFIt9H4Z07XIxdrgCobaLbLpHgexBGsLaRk4ALb8TqkYZ9xFpd/DCTFo330vVUITns+TM9R6uHIJzoWZ9yjEbb/Wv2tizYIfBrlCjKvqyjZQ3ghr9X0h4e2irFPOWpjzGdN/ZlkWuYSFF1kr1oySMoBfQStyE6aBh45If+zymGNJG8RpOZlnFpMv/aOuC2wF3c5E3wYL/Pzxi2PecdUkp7PLMIg809ySFFuuNEttTYX3rjSvtfDgn+H8b7Aly0WVQpZNktNXzWFMWJWQsL5mf/gEyMt/9Lh7RdyxJGWgALSqvquVe/bk2/3RcvWG0jX/O/aXsBP2C43YD/ygnjAhHFnze9JXYWXGY9cr2DvNv41aTI3/ZlfL8LbO7fMg0xMj4TTEXj3fq0aek6uL2sBBOv1dOWDmE2Lvk9mkdvzCvmtv3oa0X3XKo+m287/81jGMgIcXawpdatvlXm9hUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(70586007)(4326008)(70206006)(26005)(86362001)(316002)(6916009)(16526019)(186003)(40460700003)(1076003)(36756003)(6666004)(54906003)(8676002)(478600001)(36860700001)(40480700001)(2616005)(41300700001)(356005)(47076005)(8936002)(81166007)(5660300002)(2906002)(83380400001)(82310400005)(336012)(426003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:31.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cff3a0-8e50-4d2e-c1e9-08db3d00897d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - Add DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command
 - Remove d3 entry event and instead check for stream mask
 - dmu: Enable timeout recovery and detection for p-state

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1c55d3b01f53..54b7786f5681 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -419,7 +419,8 @@ union dmub_fw_boot_options {
 		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
 		uint32_t usb4_dpia_bw_alloc_supported: 1; /* 1 if USB4 dpia BW allocation supported */
 		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
-		uint32_t reserved : 14; /**< reserved */
+		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
+		uint32_t reserved : 13; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
@@ -1125,8 +1126,6 @@ struct dmub_rb_cmd_idle_opt_dcn_restore {
  */
 struct dmub_dcn_notify_idle_cntl_data {
 	uint8_t driver_idle;
-	uint8_t d3_entry;
-	uint8_t trigger;
 	uint8_t pad[1];
 };
 
@@ -3550,6 +3549,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_HPD_INT_ENABLE command.
 	 */
 	struct dmub_rb_cmd_dpia_hpd_int_enable dpia_hpd_int_enable;
+	/**
+	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
+	 */
+	struct dmub_rb_cmd_idle_opt_dcn_notify_idle idle_opt_notify_idle;
 };
 
 /**
-- 
2.34.1

