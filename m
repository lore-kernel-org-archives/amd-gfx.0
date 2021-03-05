Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3D6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8B1650A0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8B1650A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F826EC43;
	Fri,  5 Mar 2021 20:04:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B506EC43
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIsKAbHqA+3R8otG5xSwbsYgiDDlD9QtrGXhgY7cPOOXTRo8FZRSxvPgUO7b60KkWQm1HygZNpa79cWEJZv2gehKCb/6EUzc+/NQoxjKdOVybV5KT0VjG2h1BS+0zR+yjf/EuzRBfP3UET8rcEb3vnNJLIfjQEPC7DwK/PQoEnAPMgBq2asuJbL2t5wYFiRstBpTOKwG5BNLGJgiTo9XV2hESEEqm2X8fucmD1VGT7NZCzmiKTJi7XvlaPZ6FNoxwtK+Z9ofSStO+jMqED8exHjB59lS2zF7TcYF4p/eT6GkFEw22qDvCMsddxVNQjg9gzM5/1oNMEtz7tRvoXVyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1cJwmhoPeqmkX5dIyEKRTM+CQoZUpGjp9+1IJAQ5Co=;
 b=RrdPfe/uo7aJ4acc3u+eQ8QLojuEf6dA994UfD/YnX8xaFdtaIILcd6XxMAg5ihmveRz8G9no6gsYJjHqBjaX6kSK+PFMqtoU7TdybJrdG4H2XPfaRQ+TpXhGSLUxfOlZ8cvSIAGeiIv80Ea+albdUKtWmG4M9od6fsR28gzIDx+d0ZF9j2wXim/iFjZ96RIzBrkA68ZsoBRVyeqc+rOGjw3+dOclGx/uyymbC9gq8nzqSTtYswu2xDlHbWeWvRc3y25H50NuSvEEdLlNYEj5F6S+CO5Xm35nRJUuV5xVJJexMP9r8dpNSHJQEyY0BDiFUxUJIkJ2t0kvsu3WFhfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1cJwmhoPeqmkX5dIyEKRTM+CQoZUpGjp9+1IJAQ5Co=;
 b=ysydbVFo81G9mwsALEn1hx/VQrVVeyuu68BSUm+h/1ZuF6QN+odGyunU/jP4IlNpFG2ktk64xERC1X7E1fjnmiWpQJTj/j5CylqbCVcq7GQJfrMk2BM27Zo6Z+Zw9XmL0ukwY1zBrkVaMIVTgdrcxekKkR3BTF6OVf2xmYmhM5w=
Received: from MWHPR20CA0001.namprd20.prod.outlook.com (2603:10b6:300:13d::11)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:04:50 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::d4) by MWHPR20CA0001.outlook.office365.com
 (2603:10b6:300:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 5 Mar 2021 20:04:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:48 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:48 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:42 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: [FW Promotion] Release 0.0.55
Date: Fri, 5 Mar 2021 15:02:57 -0500
Message-ID: <20210305200301.17696-11-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0646703b-cccc-4999-0f5d-08d8e011eea7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1219542AC51BB177010A835DE5969@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wd2nk28/By7Ok5FDariSj+737i2ZNBQtXWYrxUwfV7RLBg2A1f+wBA7c0G+nYDMfZv5P51QQtpdCZS0Kkz9dVuI/OKwNwKs6IOgC4ck4kMxjvFX3uwv4ijwV2XUYOsT/ICjSczgjoifguGv/HJwkOWNY91aV+R/aVzLLlftGvPuJL9BuVRws2ScAlqRi25VvGiLb3KqPTw2ek2rjEHj1PdTz1oXKhsbxmcO92hg6rN6CiyfcRndTnGO/Aq+4buH7DR1PbWwzHPBFdYfO3Euo5ZxTCfdfaXutp6ORSUzRsmED2oO1RhCD1Bf52fodImMHGFHNWzvk8ywTL+SVKbvddCwvOP6dr1coF8U0o2IB2dWQlAUB9SzAugqwcrd4EPqyMiAA17xrPJ6sTdNtAtACKnZr96JTDxWbPf40hyB7NFBuRdPGqXSnoSz97cH4qQp1kLe+xJRL3JiZGtgStPToGCFqRAGKAvvj0bMlg1cswPwmhI2HQzzeiHugAE0nPqGUbupFWdSeWeTRuYpGvoFU0WFSh3rqS7OinC6CAaSen7rQOmIy5nLNq/q+V6bTU/RHn1F8N1t37ChBS1SaS1vDs1r5BBg3bmzqwvZomVM2z75hCfl3fIXwD32usJDxvlRw5bb2Og85T1Gvp3KapJRN1aeXUKuLyDXScD1Nt734GrsYQBtSz6vmk7TuTvBmmb7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(4326008)(82740400003)(478600001)(83380400001)(47076005)(316002)(81166007)(54906003)(356005)(8936002)(8676002)(186003)(70586007)(5660300002)(6916009)(30864003)(336012)(36756003)(2906002)(2616005)(426003)(26005)(70206006)(44832011)(36860700001)(86362001)(6666004)(82310400003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:49.4257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0646703b-cccc-4999-0f5d-08d8e011eea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Add comments to better describe the function of different cmds
and parameters in the dmub interface

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 834 +++++++++++++++++-
 1 file changed, 795 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a9635b5abe55..b6f4db3af5e8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x22538c5e3
+#define DMUB_FW_VERSION_GIT_HASH 0x920aff8b2
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 54
+#define DMUB_FW_VERSION_REVISION 55
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -68,11 +68,49 @@
 
 #define __forceinline inline
 
+/**
+ * Flag from driver to indicate that ABM should be disabled gradually
+ * by slowly reversing all backlight programming and pixel compensation.
+ */
 #define SET_ABM_PIPE_GRADUALLY_DISABLE           0
+
+/**
+ * Flag from driver to indicate that ABM should be disabled immediately
+ * and undo all backlight programming and pixel compensation.
+ */
 #define SET_ABM_PIPE_IMMEDIATELY_DISABLE         255
+
+/**
+ * Flag from driver to indicate that ABM should be disabled immediately
+ * and keep the current backlight programming and pixel compensation.
+ */
 #define SET_ABM_PIPE_IMMEDIATE_KEEP_GAIN_DISABLE 254
+
+/**
+ * Flag from driver to set the current ABM pipe index or ABM operating level.
+ */
 #define SET_ABM_PIPE_NORMAL                      1
 
+/**
+ * Number of ambient light levels in ABM algorithm.
+ */
+#define NUM_AMBI_LEVEL                  5
+
+/**
+ * Number of operating/aggression levels in ABM algorithm.
+ */
+#define NUM_AGGR_LEVEL                  4
+
+/**
+ * Number of segments in the gamma curve.
+ */
+#define NUM_POWER_FN_SEGS               8
+
+/**
+ * Number of segments in the backlight curve.
+ */
+#define NUM_BL_CURVE_SEGS               16
+
 /* Maximum number of streams on any ASIC. */
 #define DMUB_MAX_STREAMS 6
 
@@ -110,18 +148,49 @@ union dmub_addr {
 	uint64_t quad_part;
 };
 
+/**
+ * Flags that can be set by driver to change some PSR behaviour.
+ */
 union dmub_psr_debug_flags {
+	/**
+	 * Debug flags.
+	 */
 	struct {
+		/**
+		 * Enable visual confirm in FW.
+		 */
 		uint32_t visual_confirm : 1;
+		/**
+		 * Use HW Lock Mgr object to do HW locking in FW.
+		 */
 		uint32_t use_hw_lock_mgr : 1;
+
+		/**
+		 * Unused.
+		 * TODO: Remove.
+		 */
 		uint32_t log_line_nums : 1;
 	} bitfields;
 
+	/**
+	 * Union for debug flags.
+	 */
 	uint32_t u32All;
 };
 
+/**
+ * DMUB feature capabilities.
+ * After DMUB init, driver will query FW capabilities prior to enabling certain features.
+ */
 struct dmub_feature_caps {
+	/**
+	 * Max PSR version supported by FW.
+	 */
 	uint8_t psr;
+
+	/**
+	 * Reserved.
+	 */
 	uint8_t reserved[7];
 };
 
@@ -300,12 +369,22 @@ enum dmub_gpint_command {
 	DMUB_GPINT__INVALID_COMMAND = 0,
 	DMUB_GPINT__GET_FW_VERSION = 1,
 	DMUB_GPINT__STOP_FW = 2,
+	/**
+	 * DESC: Get PSR state from FW.
+	 * RETURN: PSR state enum. This enum may need to be converted to the legacy PSR state value.
+	 */
 	DMUB_GPINT__GET_PSR_STATE = 7,
 	/**
 	 * DESC: Notifies DMCUB of the currently active streams.
 	 * ARGS: Stream mask, 1 bit per active stream index.
 	 */
 	DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK = 8,
+	/**
+	 * DESC: Start PSR residency counter. Stop PSR resdiency counter and get value.
+	 * ARGS: We can measure residency from various points. The argument will specify the residency mode.
+	 *       By default, it is measured from after we powerdown the PHY, to just before we powerup the PHY.
+	 * RETURN: PSR residency in milli-percent.
+	 */
 	DMUB_GPINT__PSR_RESIDENCY = 9,
 };
 
@@ -332,19 +411,43 @@ enum dmub_cmd_type {
 	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
 	DMUB_CMD__REG_REG_WAIT = 4,
 	DMUB_CMD__PLAT_54186_WA = 5,
+	/**
+	 * Command type used to query FW feature caps.
+	 */
 	DMUB_CMD__QUERY_FEATURE_CAPS = 6,
+	/**
+	 * Command type used for all PSR commands.
+	 */
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__MALL = 65,
+	/**
+	 * Command type used for all ABM commands.
+	 */
 	DMUB_CMD__ABM = 66,
+	/**
+	 * Command type used for HW locking in FW.
+	 */
 	DMUB_CMD__HW_LOCK = 69,
+	/**
+	 * Command type used to access DP AUX.
+	 */
 	DMUB_CMD__DP_AUX_ACCESS = 70,
+	/**
+	 * Command type used for OUTBOX1 notification enable
+	 */
 	DMUB_CMD__OUTBOX1_ENABLE = 71,
 	DMUB_CMD__VBIOS = 128,
 };
 
 enum dmub_out_cmd_type {
 	DMUB_OUT_CMD__NULL = 0,
+	/**
+	 * Command type used for DP AUX Reply data notification
+	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
+	/**
+	 * Command type used for DP HPD event notification
+	 */
 	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
@@ -541,105 +644,242 @@ struct dmub_rb_cmd_dpphy_init {
 	uint8_t reserved[60];
 };
 
+/**
+ * enum dp_aux_request_action - DP AUX request command listing.
+ *
+ * 4 AUX request command bits are shifted to high nibble.
+ */
 enum dp_aux_request_action {
+	/** I2C-over-AUX write request */
 	DP_AUX_REQ_ACTION_I2C_WRITE		= 0x00,
+	/** I2C-over-AUX read request */
 	DP_AUX_REQ_ACTION_I2C_READ		= 0x10,
+	/** I2C-over-AUX write status request */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ	= 0x20,
+	/** I2C-over-AUX write request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_WRITE_MOT		= 0x40,
+	/** I2C-over-AUX read request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_READ_MOT		= 0x50,
+	/** I2C-over-AUX write status request with MOT=1 */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT	= 0x60,
+	/** Native AUX write request */
 	DP_AUX_REQ_ACTION_DPCD_WRITE		= 0x80,
+	/** Native AUX read request */
 	DP_AUX_REQ_ACTION_DPCD_READ		= 0x90
 };
 
+/**
+ * enum aux_return_code_type - DP AUX process return code listing.
+ */
 enum aux_return_code_type {
+	/** AUX process succeeded */
 	AUX_RET_SUCCESS = 0,
+	/** AUX process failed with unknown reason */
 	AUX_RET_ERROR_UNKNOWN,
+	/** AUX process completed with invalid reply */
 	AUX_RET_ERROR_INVALID_REPLY,
+	/** AUX process timed out */
 	AUX_RET_ERROR_TIMEOUT,
+	/** HPD was low during AUX process */
 	AUX_RET_ERROR_HPD_DISCON,
+	/** Failed to acquire AUX engine */
 	AUX_RET_ERROR_ENGINE_ACQUIRE,
+	/** AUX request not supported */
 	AUX_RET_ERROR_INVALID_OPERATION,
+	/** AUX process not available */
 	AUX_RET_ERROR_PROTOCOL_ERROR,
 };
 
+/**
+ * enum aux_channel_type - DP AUX channel type listing.
+ */
 enum aux_channel_type {
+	/** AUX thru Legacy DP AUX */
 	AUX_CHANNEL_LEGACY_DDC,
+	/** AUX thru DPIA DP tunneling */
 	AUX_CHANNEL_DPIA
 };
 
-/* DP AUX command */
+/**
+ * struct aux_transaction_parameters - DP AUX request transaction data
+ */
 struct aux_transaction_parameters {
-	uint8_t is_i2c_over_aux;
-	uint8_t action;
-	uint8_t length;
-	uint8_t pad;
-	uint32_t address;
-	uint8_t data[16];
+	uint8_t is_i2c_over_aux; /**< 0=native AUX, 1=I2C-over-AUX */
+	uint8_t action; /**< enum dp_aux_request_action */
+	uint8_t length; /**< DP AUX request data length */
+	uint8_t reserved; /**< For future use */
+	uint32_t address; /**< DP AUX address */
+	uint8_t data[16]; /**< DP AUX write data */
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DP_AUX_ACCESS command.
+ */
 struct dmub_cmd_dp_aux_control_data {
-	uint8_t instance;
-	uint8_t manual_acq_rel_enable;
-	uint8_t sw_crc_enabled;
-	uint8_t pad;
-	uint16_t handle;
-	uint16_t timeout;
-	enum aux_channel_type type;
-	struct aux_transaction_parameters dpaux;
+	uint8_t instance; /**< AUX instance or DPIA instance */
+	uint8_t manual_acq_rel_enable; /**< manual control for acquiring or releasing AUX channel */
+	uint8_t sw_crc_enabled; /**< Use software CRC for tunneling packet instead of hardware CRC */
+	uint8_t reserved0; /**< For future use */
+	uint16_t timeout; /**< timeout time in us */
+	uint16_t reserved1; /**< For future use */
+	enum aux_channel_type type; /**< enum aux_channel_type */
+	struct aux_transaction_parameters dpaux; /**< struct aux_transaction_parameters */
 };
 
+/**
+ * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
+ */
 struct dmub_rb_cmd_dp_aux_access {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__DP_AUX_ACCESS command.
+	 */
 	struct dmub_cmd_dp_aux_control_data aux_control;
 };
 
+/**
+ * Definition of a DMUB_CMD__OUTBOX1_ENABLE command.
+ */
 struct dmub_rb_cmd_outbox1_enable {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 *  enable: 0x0 -> disable outbox1 notification (default value)
+	 *			0x1 -> enable outbox1 notification
+	 */
 	uint32_t enable;
 };
 
 /* DP AUX Reply command - OutBox Cmd */
+/**
+ * Data passed to driver from FW in a DMUB_OUT_CMD__DP_AUX_REPLY command.
+ */
 struct aux_reply_data {
+	/**
+	 * Aux cmd
+	 */
 	uint8_t command;
+	/**
+	 * Aux reply data length (max: 16 bytes)
+	 */
 	uint8_t length;
+	/**
+	 * Alignment only
+	 */
 	uint8_t pad[2];
+	/**
+	 * Aux reply data
+	 */
 	uint8_t data[16];
 };
 
+/**
+ * Control Data passed to driver from FW in a DMUB_OUT_CMD__DP_AUX_REPLY command.
+ */
 struct aux_reply_control_data {
+	/**
+	 * Reserved for future use
+	 */
 	uint32_t handle;
+	/**
+	 * Aux Instance
+	 */
 	uint8_t instance;
+	/**
+	 * Aux transaction result: definition in enum aux_return_code_type
+	 */
 	uint8_t result;
+	/**
+	 * Alignment only
+	 */
 	uint16_t pad;
 };
 
+/**
+ * Definition of a DMUB_OUT_CMD__DP_AUX_REPLY command.
+ */
 struct dmub_rb_cmd_dp_aux_reply {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Control Data passed to driver from FW in a DMUB_OUT_CMD__DP_AUX_REPLY command.
+	 */
 	struct aux_reply_control_data control;
+	/**
+	 * Data passed to driver from FW in a DMUB_OUT_CMD__DP_AUX_REPLY command.
+	 */
 	struct aux_reply_data reply_data;
 };
 
 /* DP HPD Notify command - OutBox Cmd */
+/**
+ * DP HPD Type
+ */
 enum dp_hpd_type {
+	/**
+	 * Normal DP HPD
+	 */
 	DP_HPD = 0,
+	/**
+	 * DP HPD short pulse
+	 */
 	DP_IRQ
 };
 
+/**
+ * DP HPD Status
+ */
 enum dp_hpd_status {
+	/**
+	 * DP_HPD status low
+	 */
 	DP_HPD_UNPLUG = 0,
+	/**
+	 * DP_HPD status high
+	 */
 	DP_HPD_PLUG
 };
 
+/**
+ * Data passed to driver from FW in a DMUB_OUT_CMD__DP_HPD_NOTIFY command.
+ */
 struct dp_hpd_data {
+	/**
+	 * DP HPD instance
+	 */
 	uint8_t instance;
+	/**
+	 * HPD type
+	 */
 	uint8_t hpd_type;
+	/**
+	 * HPD status: only for type: DP_HPD to indicate status
+	 */
 	uint8_t hpd_status;
+	/**
+	 * Alignment only
+	 */
 	uint8_t pad;
 };
 
+/**
+ * Definition of a DMUB_OUT_CMD__DP_HPD_NOTIFY command.
+ */
 struct dmub_rb_cmd_dp_hpd_notify {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed to driver from FW in a DMUB_OUT_CMD__DP_HPD_NOTIFY command.
+	 */
 	struct dp_hpd_data hpd_data;
 };
 
@@ -648,17 +888,52 @@ struct dmub_rb_cmd_dp_hpd_notify {
  * Do not reuse or modify IDs.
  */
 
+/**
+ * PSR command sub-types.
+ */
 enum dmub_cmd_psr_type {
+	/**
+	 * Set PSR version support.
+	 */
 	DMUB_CMD__PSR_SET_VERSION		= 0,
+	/**
+	 * Copy driver-calculated parameters to PSR state.
+	 */
 	DMUB_CMD__PSR_COPY_SETTINGS		= 1,
+	/**
+	 * Enable PSR.
+	 */
 	DMUB_CMD__PSR_ENABLE			= 2,
+
+	/**
+	 * Disable PSR.
+	 */
 	DMUB_CMD__PSR_DISABLE			= 3,
+
+	/**
+	 * Set PSR level.
+	 * PSR level is a 16-bit value dicated by driver that
+	 * will enable/disable different functionality.
+	 */
 	DMUB_CMD__PSR_SET_LEVEL			= 4,
+
+	/**
+	 * Forces PSR enabled until an explicit PSR disable call.
+	 */
 	DMUB_CMD__PSR_FORCE_STATIC		= 5,
 };
 
+/**
+ * PSR versions.
+ */
 enum psr_version {
+	/**
+	 * PSR version 1.
+	 */
 	PSR_VERSION_1				= 0,
+	/**
+	 * PSR not supported.
+	 */
 	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
 };
 
@@ -669,217 +944,648 @@ enum dmub_cmd_mall_type {
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PSR_COPY_SETTINGS command.
+ */
 struct dmub_cmd_psr_copy_settings_data {
+	/**
+	 * Flags that can be set by driver to change some PSR behaviour.
+	 */
 	union dmub_psr_debug_flags debug;
+	/**
+	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 */
 	uint16_t psr_level;
+	/**
+	 * DPP HW instance.
+	 */
 	uint8_t dpp_inst;
-	/* opp_inst and mpcc_inst will not be used in dmub fw,
+	/**
+	 * MPCC HW instance.
+	 * Not used in dmub fw,
 	 * dmub fw will get active opp by reading odm registers.
 	 */
 	uint8_t mpcc_inst;
+	/**
+	 * OPP HW instance.
+	 * Not used in dmub fw,
+	 * dmub fw will get active opp by reading odm registers.
+	 */
 	uint8_t opp_inst;
-
+	/**
+	 * OTG HW instance.
+	 */
 	uint8_t otg_inst;
+	/**
+	 * DIG FE HW instance.
+	 */
 	uint8_t digfe_inst;
+	/**
+	 * DIG BE HW instance.
+	 */
 	uint8_t digbe_inst;
+	/**
+	 * DP PHY HW instance.
+	 */
 	uint8_t dpphy_inst;
+	/**
+	 * AUX HW instance.
+	 */
 	uint8_t aux_inst;
+	/**
+	 * Determines if SMU optimzations are enabled/disabled.
+	 */
 	uint8_t smu_optimizations_en;
+	/**
+	 * Unused.
+	 * TODO: Remove.
+	 */
 	uint8_t frame_delay;
+	/**
+	 * If RFB setup time is greater than the total VBLANK time,
+	 * it is not possible for the sink to capture the video frame
+	 * in the same frame the SDP is sent. In this case,
+	 * the frame capture indication bit should be set and an extra
+	 * static frame should be transmitted to the sink.
+	 */
 	uint8_t frame_cap_ind;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
 	uint8_t pad[2];
+	/**
+	 * Multi-display optimizations are implemented on certain ASICs.
+	 */
 	uint8_t multi_disp_optimizations_en;
+	/**
+	 * The last possible line SDP may be transmitted without violating
+	 * the RFB setup time or entering the active video frame.
+	 */
 	uint16_t init_sdp_deadline;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
 	uint16_t pad2;
+	/**
+	 * Length of each horizontal line in us.
+	 */
 	uint32_t line_time_in_us;
 };
 
+/**
+ * Definition of a DMUB_CMD__PSR_COPY_SETTINGS command.
+ */
 struct dmub_rb_cmd_psr_copy_settings {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PSR_COPY_SETTINGS command.
+	 */
 	struct dmub_cmd_psr_copy_settings_data psr_copy_settings_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PSR_SET_LEVEL command.
+ */
 struct dmub_cmd_psr_set_level_data {
+	/**
+	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 */
 	uint16_t psr_level;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
 	uint8_t pad[2];
 };
 
+/**
+ * Definition of a DMUB_CMD__PSR_SET_LEVEL command.
+ */
 struct dmub_rb_cmd_psr_set_level {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__PSR_SET_LEVEL command.
+	 */
 	struct dmub_cmd_psr_set_level_data psr_set_level_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__PSR_ENABLE command.
+ * PSR enable/disable is controlled using the sub_type.
+ */
 struct dmub_rb_cmd_psr_enable {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PSR_SET_VERSION command.
+ */
 struct dmub_cmd_psr_set_version_data {
-	enum psr_version version; // PSR version 1 or 2
+	/**
+	 * PSR version that FW should implement.
+	 */
+	enum psr_version version;
 };
 
+/**
+ * Definition of a DMUB_CMD__PSR_SET_VERSION command.
+ */
 struct dmub_rb_cmd_psr_set_version {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PSR_SET_VERSION command.
+	 */
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
+ */
 struct dmub_rb_cmd_psr_force_static {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
 };
 
+/**
+ * Set of HW components that can be locked.
+ */
 union dmub_hw_lock_flags {
+	/**
+	 * Set of HW components that can be locked.
+	 */
 	struct {
+		/**
+		 * Lock/unlock OTG master update lock.
+		 */
 		uint8_t lock_pipe   : 1;
+		/**
+		 * Lock/unlock cursor.
+		 */
 		uint8_t lock_cursor : 1;
+		/**
+		 * Lock/unlock global update lock.
+		 */
 		uint8_t lock_dig    : 1;
+		/**
+		 * Triple buffer lock requires additional hw programming to usual OTG master lock.
+		 */
 		uint8_t triple_buffer_lock : 1;
 	} bits;
 
+	/**
+	 * Union for HW Lock flags.
+	 */
 	uint8_t u8All;
 };
 
+/**
+ * Instances of HW to be locked.
+ */
 struct dmub_hw_lock_inst_flags {
+	/**
+	 * OTG HW instance for OTG master update lock.
+	 */
 	uint8_t otg_inst;
+	/**
+	 * OPP instance for cursor lock.
+	 */
 	uint8_t opp_inst;
+	/**
+	 * OTG HW instance for global update lock.
+	 * TODO: Remove, and re-use otg_inst.
+	 */
 	uint8_t dig_inst;
+	/**
+	 * Explicit pad to 4 byte boundary.
+	 */
 	uint8_t pad;
 };
 
+/**
+ * Clients that can acquire the HW Lock Manager.
+ */
 enum hw_lock_client {
+	/**
+	 * Driver is the client of HW Lock Manager.
+	 */
 	HW_LOCK_CLIENT_DRIVER = 0,
+	/**
+	 * FW is the client of HW Lock Manager.
+	 */
 	HW_LOCK_CLIENT_FW,
+	/**
+	 * Invalid client.
+	 */
 	HW_LOCK_CLIENT_INVALID = 0xFFFFFFFF,
 };
 
+/**
+ * Data passed to HW Lock Mgr in a DMUB_CMD__HW_LOCK command.
+ */
 struct dmub_cmd_lock_hw_data {
+	/**
+	 * Specifies the client accessing HW Lock Manager.
+	 */
 	enum hw_lock_client client;
+	/**
+	 * HW instances to be locked.
+	 */
 	struct dmub_hw_lock_inst_flags inst_flags;
+	/**
+	 * Which components to be locked.
+	 */
 	union dmub_hw_lock_flags hw_locks;
+	/**
+	 * Specifies lock/unlock.
+	 */
 	uint8_t lock;
+	/**
+	 * HW can be unlocked separately from releasing the HW Lock Mgr.
+	 * This flag is set if the client wishes to release the object.
+	 */
 	uint8_t should_release;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
 	uint8_t pad;
 };
 
+/**
+ * Definition of a DMUB_CMD__HW_LOCK command.
+ * Command is used by driver and FW.
+ */
 struct dmub_rb_cmd_lock_hw {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed to HW Lock Mgr in a DMUB_CMD__HW_LOCK command.
+	 */
 	struct dmub_cmd_lock_hw_data lock_hw_data;
 };
 
+/**
+ * ABM command sub-types.
+ */
 enum dmub_cmd_abm_type {
+	/**
+	 * Initialize parameters for ABM algorithm.
+	 * Data is passed through an indirect buffer.
+	 */
 	DMUB_CMD__ABM_INIT_CONFIG	= 0,
+	/**
+	 * Set OTG and panel HW instance.
+	 */
 	DMUB_CMD__ABM_SET_PIPE		= 1,
+	/**
+	 * Set user requested backklight level.
+	 */
 	DMUB_CMD__ABM_SET_BACKLIGHT	= 2,
+	/**
+	 * Set ABM operating/aggression level.
+	 */
 	DMUB_CMD__ABM_SET_LEVEL		= 3,
+	/**
+	 * Set ambient light level.
+	 */
 	DMUB_CMD__ABM_SET_AMBIENT_LEVEL	= 4,
+	/**
+	 * Enable/disable fractional duty cycle for backlight PWM.
+	 */
 	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
 };
 
-#define NUM_AMBI_LEVEL                  5
-#define NUM_AGGR_LEVEL                  4
-#define NUM_POWER_FN_SEGS               8
-#define NUM_BL_CURVE_SEGS               16
-
-/*
- * Parameters for ABM2.4 algorithm.
- * Padded explicitly to 32-bit boundary.
+/**
+ * Parameters for ABM2.4 algorithm. Passed from driver to FW via an indirect buffer.
+ * Requirements:
+ *  - Padded explicitly to 32-bit boundary.
+ *  - Must ensure this structure matches the one on driver-side,
+ *    otherwise it won't be aligned.
  */
 struct abm_config_table {
-	/* Parameters for crgb conversion */
+	/**
+	 * Gamma curve thresholds, used for crgb conversion.
+	 */
 	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];                 // 0B
+	/**
+	 * Gamma curve offsets, used for crgb conversion.
+	 */
 	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 16B
+	/**
+	 * Gamma curve slopes, used for crgb conversion.
+	 */
 	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 32B
-
-	/* Parameters for custom curve */
+	/**
+	 * Custom backlight curve thresholds.
+	 */
 	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 48B
+	/**
+	 * Custom backlight curve offsets.
+	 */
 	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 78B
-
+	/**
+	 * Ambient light thresholds.
+	 */
 	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 112B
+	/**
+	 * Minimum programmable backlight.
+	 */
 	uint16_t min_abm_backlight;                              // 122B
-
+	/**
+	 * Minimum reduction values.
+	 */
 	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 124B
+	/**
+	 * Maximum reduction values.
+	 */
 	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 144B
+	/**
+	 * Bright positive gain.
+	 */
 	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 164B
+	/**
+	 * Dark negative gain.
+	 */
 	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 184B
+	/**
+	 * Hybrid factor.
+	 */
 	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 204B
+	/**
+	 * Contrast factor.
+	 */
 	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 208B
+	/**
+	 * Deviation gain.
+	 */
 	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 212B
+	/**
+	 * Minimum knee.
+	 */
 	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 216B
+	/**
+	 * Maximum knee.
+	 */
 	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 220B
+	/**
+	 * Unused.
+	 */
 	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 224B
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
 	uint8_t pad3[3];                                         // 229B
-
+	/**
+	 * Backlight ramp reduction.
+	 */
 	uint16_t blRampReduction[NUM_AGGR_LEVEL];                // 232B
+	/**
+	 * Backlight ramp start.
+	 */
 	uint16_t blRampStart[NUM_AGGR_LEVEL];                    // 240B
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_PIPE command.
+ */
 struct dmub_cmd_abm_set_pipe_data {
+	/**
+	 * OTG HW instance.
+	 */
 	uint8_t otg_inst;
+
+	/**
+	 * Panel Control HW instance.
+	 */
 	uint8_t panel_inst;
+
+	/**
+	 * Controls how ABM will interpret a set pipe or set level command.
+	 */
 	uint8_t set_pipe_option;
-	uint8_t ramping_boundary; // TODO: Remove this
+
+	/**
+	 * Unused.
+	 * TODO: Remove.
+	 */
+	uint8_t ramping_boundary;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SET_PIPE command.
+ */
 struct dmub_rb_cmd_abm_set_pipe {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_PIPE command.
+	 */
 	struct dmub_cmd_abm_set_pipe_data abm_set_pipe_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_BACKLIGHT command.
+ */
 struct dmub_cmd_abm_set_backlight_data {
+	/**
+	 * Number of frames to ramp to backlight user level.
+	 */
 	uint32_t frame_ramp;
+
+	/**
+	 * Requested backlight level from user.
+	 */
 	uint32_t backlight_user_level;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SET_BACKLIGHT command.
+ */
 struct dmub_rb_cmd_abm_set_backlight {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_BACKLIGHT command.
+	 */
 	struct dmub_cmd_abm_set_backlight_data abm_set_backlight_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_LEVEL command.
+ */
 struct dmub_cmd_abm_set_level_data {
+	/**
+	 * Set current ABM operating/aggression level.
+	 */
 	uint32_t level;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SET_LEVEL command.
+ */
 struct dmub_rb_cmd_abm_set_level {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_LEVEL command.
+	 */
 	struct dmub_cmd_abm_set_level_data abm_set_level_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_AMBIENT_LEVEL command.
+ */
 struct dmub_cmd_abm_set_ambient_level_data {
+	/**
+	 * Ambient light sensor reading from OS.
+	 */
 	uint32_t ambient_lux;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SET_AMBIENT_LEVEL command.
+ */
 struct dmub_rb_cmd_abm_set_ambient_level {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_AMBIENT_LEVEL command.
+	 */
 	struct dmub_cmd_abm_set_ambient_level_data abm_set_ambient_level_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_PWM_FRAC command.
+ */
 struct dmub_cmd_abm_set_pwm_frac_data {
+	/**
+	 * Enable/disable fractional duty cycle for backlight PWM.
+	 * TODO: Convert to uint8_t.
+	 */
 	uint32_t fractional_pwm;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_SET_PWM_FRAC command.
+ */
 struct dmub_rb_cmd_abm_set_pwm_frac {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_PWM_FRAC command.
+	 */
 	struct dmub_cmd_abm_set_pwm_frac_data abm_set_pwm_frac_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_INIT_CONFIG command.
+ */
 struct dmub_cmd_abm_init_config_data {
+	/**
+	 * Location of indirect buffer used to pass init data to ABM.
+	 */
 	union dmub_addr src;
+
+	/**
+	 * Indirect buffer length.
+	 */
 	uint16_t bytes;
 };
 
+/**
+ * Definition of a DMUB_CMD__ABM_INIT_CONFIG command.
+ */
 struct dmub_rb_cmd_abm_init_config {
+	/**
+	 * Command header.
+	 */
 	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_INIT_CONFIG command.
+	 */
 	struct dmub_cmd_abm_init_config_data abm_init_config_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
+ */
 struct dmub_cmd_query_feature_caps_data {
-	 struct dmub_feature_caps feature_caps;
+	/**
+	 * DMUB feature capabilities.
+	 * After DMUB init, driver will query FW capabilities prior to enabling certain features.
+	 */
+	struct dmub_feature_caps feature_caps;
 };
 
+/**
+ * Definition of a DMUB_CMD__QUERY_FEATURE_CAPS command.
+ */
 struct dmub_rb_cmd_query_feature_caps {
-	 struct dmub_cmd_header header;
-	 struct dmub_cmd_query_feature_caps_data query_feature_caps_data;
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
+	 */
+	struct dmub_cmd_query_feature_caps_data query_feature_caps_data;
 };
 
- union dmub_rb_cmd {
+/**
+ * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
+ */
+struct dmub_cmd_lvtma_control_data {
+	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
+	uint8_t reserved_0[3]; /**< For future use */
+	uint8_t panel_inst; /**< LVTMA control instance */
+	uint8_t reserved_1[3]; /**< For future use */
+};
+
+/**
+ * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
+ */
+struct dmub_rb_cmd_lvtma_control {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
+	 */
+	struct dmub_cmd_lvtma_control_data data;
+};
+
+union dmub_rb_cmd {
 	struct dmub_rb_cmd_lock_hw lock_hw;
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
@@ -891,22 +1597,72 @@ struct dmub_rb_cmd_query_feature_caps {
 	struct dmub_rb_cmd_enable_disp_power_gating enable_disp_power_gating;
 	struct dmub_rb_cmd_dpphy_init dpphy_init;
 	struct dmub_rb_cmd_dig1_transmitter_control dig1_transmitter_control;
+	/**
+	 * Definition of a DMUB_CMD__PSR_SET_VERSION command.
+	 */
 	struct dmub_rb_cmd_psr_set_version psr_set_version;
+	/**
+	 * Definition of a DMUB_CMD__PSR_COPY_SETTINGS command.
+	 */
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
+	/**
+	 * Definition of a DMUB_CMD__PSR_ENABLE command.
+	 */
 	struct dmub_rb_cmd_psr_enable psr_enable;
+	/**
+	 * Definition of a DMUB_CMD__PSR_SET_LEVEL command.
+	 */
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
+	/**
+	 * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
+	 */
 	struct dmub_rb_cmd_psr_force_static psr_force_static;
 	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
 	struct dmub_rb_cmd_mall mall;
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_PIPE command.
+	 */
 	struct dmub_rb_cmd_abm_set_pipe abm_set_pipe;
+
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_BACKLIGHT command.
+	 */
 	struct dmub_rb_cmd_abm_set_backlight abm_set_backlight;
+
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_LEVEL command.
+	 */
 	struct dmub_rb_cmd_abm_set_level abm_set_level;
+
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_AMBIENT_LEVEL command.
+	 */
 	struct dmub_rb_cmd_abm_set_ambient_level abm_set_ambient_level;
+
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_PWM_FRAC command.
+	 */
 	struct dmub_rb_cmd_abm_set_pwm_frac abm_set_pwm_frac;
+
+	/**
+	 * Definition of a DMUB_CMD__ABM_INIT_CONFIG command.
+	 */
 	struct dmub_rb_cmd_abm_init_config abm_init_config;
+
+	/**
+	 * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
+	 */
 	struct dmub_rb_cmd_dp_aux_access dp_aux_access;
+
 	struct dmub_rb_cmd_outbox1_enable outbox1_enable;
+	/**
+	 * Definition of a DMUB_CMD__qyert command.
+	 */
 	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
+	 */
+	struct dmub_rb_cmd_lvtma_control lvtma_control;
 };
 
 union dmub_rb_out_cmd {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
