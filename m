Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97332C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DDD10E812;
	Thu, 26 Oct 2023 14:20:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EDA10E7F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjYQbx7s03Ey/3OhMJoSM+wulpRlP7UgUlan/GKrvsJsX3PK53ywJjqjVviDRmooU+TPwzIzPh4306AZ59eqDAGF5TM6oixWybj6x1yFPqAUuEQFZUysPN8YDhl2wB9SkamwkK7h8v7JjHpjImUwX3nZK8SftIhCBcaB7HpVhLc3ixn+V7gTXsmQhvLyhOj7dMK1hG7X5n8WWWqPVJNmnpFxHnx5fDRCYUmjAvBbquN6Uw34UjG7mLn6sudR8bdjHO7qRmWNq7/R6URTitOglenP/9wv/wiKiyItvrHD3/Bdq7Y/Gagyva4dpbqiWwC3YPoxEdA6Jla0foj8yHWPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnHHUdPTtw6P4GBbNVw6KPm6f8XJrkaE2K7VUa5AZsI=;
 b=bDu3QW2vSTwgdcxY3V6yMhWFH18YNju4NfRrncHJIvpTwEploSU7F78pL6VGTFAUAtvASPle1eqazToNcWw5QYJa6b0mtvZX0SrZDhXIg7ZodHOmgF0rtzk7phUXUYSSviunYCbkxiY1uL23Sver98zhXTd5JfaT1pLWCVR3XyWeEfHfin26o9IlHv2cZVO+OKHhzuoJLwQMH1hOKDsH6pMvNegEywAni2juY8rc4kV1U3nvQX/BYy3dJk17ACPv2ROBQPldL4x1DtwjVW1hqds9UrBGmn1IRY2oMKU4761gmTkEiHENwyc8GLM1Gr9v5T3/6hiqWXY68CoSGTSc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnHHUdPTtw6P4GBbNVw6KPm6f8XJrkaE2K7VUa5AZsI=;
 b=eP91B+4G/lW+DacW9AVUZoKqi1F+dfSN6VftPoWMIKH4fGBFuvBWuLsbtQ408OCaBTcPo4W0gJGG3LlmYBvrW10DKWC4bZ9m3kZ6D9q4whUjxDtIrLlRbCJMnuRuwB4qv569+DnYTfmSLcPttFlM3f1Gs3lBYyCvwL8XcZti+DQ=
Received: from CH0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:610:cc::27)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:37 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::60) by CH0PR03CA0082.outlook.office365.com
 (2603:10b6:610:cc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:34 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:33 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/25] drm/amd/display: [FW Promotion] Release 0.0.189.0
Date: Thu, 26 Oct 2023 10:20:02 -0400
Message-ID: <20231026142020.67861-8-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: cbee86eb-b831-46b5-8c38-08dbd62eb930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TE8Di1oS1zk5NyAMeKscVSYBDtz/a4sUMZl0z+sPYpD0Ws77BWjzPM14hGYQokkdo3PdIVFUjfCBIlXWJtV5e7ltAzoIq+k6DPno9SIBcXg8rWpt4Nx7DDIS//5VHgtmDX+rCSzuwdB7IS5rxn5MtIoYxvAOI3JiVR+aFRkZRnHxBSE8KFWdcFL6MNLX2mJtxIDZvAODDOIKlB1dwV4RX/aFoEqAqq1ZXGXFktSNenNPfdAkn0/HyMrALfYTZdbinBCz++JZbzNOXuu+biRnvCRmyLcE60u9RYHQ7Xu4/K3hc0TEOTy5FZt4umLpYO0GqCQkJwZBjlYpxJCyAYdLY133yuV9KqyPAclZrTlXv56cPZMJr/v/PSsRfIdKLYODfdBpYtfNAaiLjyQh8qpMyMN5OjDZR7WZcShCnc8x8Jjuw+H8d9SCM7gk44P7M9mWrraRVncyAU80QJ7mxAtsbsuFOr4Do/PDo3k9TflLECTiS/mjPYXJNmfM3bhzGFe9kffcBemCbceXmv61cq1nc/5wMDIaHuuySTyhjeK5bK1y/76ke6dBH/tlQzxoYg6FzyEqEAVWCRz40LH9byD8yfpxslljY+Wy165cmu8q39ILvkcRMIodyYhcoRA4k0kq0KqWiQJtdLDOr46Mp4fHfB9Xv8nIVSf1F83BmC3eyLaifut8t1Ape90Mc/veGefrm4mWFVEAm/ycOmnTxzf4PvJE3waLJ5r3bbVnlyFyrefJxrjV1gxznsNB03WjbXvbMTC4RlIluqWYtRvehNTw9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(2906002)(36860700001)(82740400003)(316002)(70586007)(6916009)(54906003)(356005)(81166007)(1076003)(478600001)(47076005)(426003)(6666004)(336012)(40480700001)(83380400001)(2616005)(5660300002)(86362001)(36756003)(8676002)(4326008)(70206006)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:36.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbee86eb-b831-46b5-8c38-08dbd62eb930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Anthony Koo <anthony.koo@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Minor formatting changes
 - Update defines to match the bit width of the field it is used for
 - Add new boot up bits to control HW sub block regions power
   down

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bc907ae2052d..61b4009c3b76 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -583,6 +583,7 @@ union dmub_fw_boot_status {
 		uint32_t fams_enabled : 1; /**< 1 if VBIOS data is deferred programmed */
 		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
 		uint32_t hw_power_init_done: 1; /**< 1 if hw power init is completed */
+		uint32_t ono_regions_enabled: 1; /**< 1 if ONO regions are enabled */
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
@@ -599,6 +600,7 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED = (1 << 5), /**< 1 if FAMS is enabled*/
 	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6), /**< 1 if detection need to be triggered by driver*/
 	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7), /**< 1 if hw power init is completed */
+	DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED = (1 << 8), /**< 1 if ONO regions are enabled */
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -2098,7 +2100,7 @@ enum psr_version {
 	/**
 	 * PSR not supported.
 	 */
-	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
+	PSR_VERSION_UNSUPPORTED			= 0xFF,	// psr_version field is only 8 bits wide
 };
 
 /**
@@ -3620,7 +3622,6 @@ struct dmub_cmd_abm_pause_data {
 	uint8_t pad[1];
 };
 
-
 /**
  * Definition of a DMUB_CMD__ABM_PAUSE command.
  */
@@ -4046,6 +4047,7 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__MALL command.
 	 */
 	struct dmub_rb_cmd_mall mall;
+
 	/**
 	 * Definition of a DMUB_CMD__CAB command.
 	 */
@@ -4067,6 +4069,7 @@ union dmub_rb_cmd {
 	 * Definition of DMUB_CMD__PANEL_CNTL commands.
 	 */
 	struct dmub_rb_cmd_panel_cntl panel_cntl;
+
 	/**
 	 * Definition of a DMUB_CMD__ABM_SET_PIPE command.
 	 */
@@ -4470,10 +4473,6 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 		uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
 		uint8_t i;
 
-		/* Don't remove this.
-		 * The contents need to actually be read from the ring buffer
-		 * for this function to be effective.
-		 */
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
 			(void)READ_ONCE(*data++);
 
@@ -4522,5 +4521,4 @@ static inline void dmub_rb_get_return_data(struct dmub_rb *rb,
 //==============================================================================
 //</DMUB_RB>====================================================================
 //==============================================================================
-
 #endif /* _DMUB_CMD_H_ */
-- 
2.25.1

