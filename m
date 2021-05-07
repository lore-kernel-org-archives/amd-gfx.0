Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962ABC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7C1613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C1613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF6F6EE4F;
	Fri,  7 May 2021 15:00:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0A56EE4F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXmdZHhiEP0MDMnMfLX60pnwvhYQ/o5pgLM2C1pREa9yKL72Rdp3VHy02EMLytR8PLdcMhhk8IaCFu2AuvKBqEZDCaDXYCkfy+e7Y3abQffIwA6I0jEcy2tJp37v71lL4AGJDF9SG+7xm9sy5arPBQgpa6YAdM/0U13SUlbHIM3k81hA1FTBc9uKJE7MfMvOU6Reh4qRXfKXgHq4GJKoPlKl/XwUFRjgtz2AJMHBfn4sGuXJQOOtbW+0S8xe5TqnlejyvqRXgaIb74U6Y5KCghcaRrB8YQNLU2T7nAjlalbJ6uY2iyYUrWVKLqOUhkqM7VWuRTcfKnDlv26ejQRgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN50dNMCny0VizHK0uFczsPzoHkBb1pe3ffF4WSKZ50=;
 b=UjTZxU+HEs01Mhzpi9tccLUvDWTU1aiIsFpjfMB0uAMRr2GySris6VNI9Dyg0AlEa6uv0ET3ba5LugP/ex6YCIBi91v9RY24b+wB5CyFzH7oaypjDZ+oaDjWO1hhjJAoUElKtqG2YKpzzHQJlFJqvHwICw6wU5JxtD5xLAvDOYg9DjudbJO+QeO1C5Psa9o+j9srHCskzPGDWA/ExjYIBdHBOTB3wGHswON9oCLCCKp1pGvUMry1sqeG1ndThoVQHycoEmh8XKmoGgpQ/2m40indtNtZJ45GiX/wiV2SJAIm4IqQcw5HH2Y4c88t22zEXs5tyzhFEO7W9Gbr25RJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN50dNMCny0VizHK0uFczsPzoHkBb1pe3ffF4WSKZ50=;
 b=oUO3w3KLGN7EFbDKJhpwD+ZN1ycB2FdhH0PZqNo/jhIQoQ/xdP7yi+9ja4956LXeiUY9Jkul0RULPKCmeYyIceduOkFDao8G2CxlbBYcP2m97I1ehJhZhAR7UHF7n9I4BGZalktGCNuP5ShGsPGPOyBrCSyL9IOUNBvVUV1cp2I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:00:18 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 15:00:18 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.0.65
Date: Fri,  7 May 2021 22:58:21 +0800
Message-Id: <20210507145822.248029-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:00:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 558b8879-9f0a-48a3-af49-08d91168d3f4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786D586585AF8B9EE755826FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPiy9tTp0sCDHquVSuRGzQKyh75ALFpGK56m/QqkdlFcdFnsYjd6D2FjHrCzZtQtrgHZc6YkJQNmSM6yBdYIL7G7t+6PZs5VZwPv3jCsHnd4iVQj8EjE3nBYnBdz1yLl+26HLxmZ99Cv14ZsFSS9GkpnzK42Zm1oVS5qS6QyMtKqs5ROSqdtGSqtjKE4G7KZjwjAtEyflkEWZ5opeoXWnNLVXJolUAYxQ8GEbUU4xWQ3oR38LYONZW96J1v5a7LLeJu0XeUYNMPWBD9wUPvy8b/wuUQwr11rupRgJLYtk46AGfGctq+mtiYct8/Ce28BNGXDzrUa2bFq0+EvnjB6CITI2JwhNBGbV5M+uOwCS2BZkyG9tVpRHq0G+jtMSBwxy8K7p+2w8EL913mr7Cr4Bl8OpU84N/cg0MIVfCSTiaS08MDXK0tfuGSd11Ygm6LoGB8/Jl/W36cHMNYsag6AlOmog1GGKnTkUX6hILt8X1SIWkTJ3m3qftCIR+xDZ2uMai6GdV902LzSmnrv/bm8kDbPvzUWcr72Rw2Cd06RV7yEn9QC7M7g+rHnd3LcnXJc22DLQMunFE1QbU57j4fLq0QF8a1aymoUKN0rB0O/66uF/8t5f9HvDwMoPKkXy81iHnZ4o3nXTZEPGBKHnmnyAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wR1A25S+eA82RtEbjmbOglzOwlVDGu7L+NJbKNeLWdjfm78DWKkOuysGwc4n?=
 =?us-ascii?Q?eKHwsXpVRTSZhgsc5rW+SxLZUYUhjRCCN0I467eLxAYXfbU7qGC7U/HbrFCY?=
 =?us-ascii?Q?ar1whEcUg4g71tyOC+n8EFAyGzSgJ/b/6mTBZGa6NzeC71FoO4Wk6qmo7tYF?=
 =?us-ascii?Q?9U7L2G5rF2EO6a5hU4dmgqELOFxN/Cb3p9++8JTfnOR8p1fC+SEkTfHn15S/?=
 =?us-ascii?Q?bTAxv1qHZRNaEdUNqZsLP8L462RVC8uCIB6SYdXKFRN5YZTb10VCPKQA3p8v?=
 =?us-ascii?Q?b2a6UuiOn4yPpZTm1y14UchaK1aofllcakfTuC/FyrGlR2OfZw1B0W/4wx12?=
 =?us-ascii?Q?utdf6gY47mqhAMpNk0yYGKhOR9gI0PZ8hZd5PNZP9D6oik/IAMZIXqzd/HNn?=
 =?us-ascii?Q?rvbQB751eGYRw0HWm+3U5rJyrBcJzDGuRwBBTEm7Yo8BWOLO4IFO9juWKxXv?=
 =?us-ascii?Q?sFwU6KCCZPFN8VXL5PPSlTixW8gqJOzAqR2nErFSCbjt7e2mmTwm6krJH3c3?=
 =?us-ascii?Q?TfDGD+T9WE5FW9wEgvNOkEVujE4ujZFGGmmocW8APiDvzO5gLZfubvH4syO2?=
 =?us-ascii?Q?S1QSIrFxPlvBx4veI7nnBtTy2uGZeuZBzSocPzsV8vqjBXc8ZpVwE9bT+WP9?=
 =?us-ascii?Q?1ikYclXPXZbSZGojCJ2CtiQBHLiKiGkbaG0W5Mj5rsOxlBKIJIk1PXHYJNTZ?=
 =?us-ascii?Q?8yLcHp8LIhKotN6NVubbQ3kBCMJL8xFrA8X4P/RBsQOIvJqeWeMF96WQwfbL?=
 =?us-ascii?Q?3zC7gagvI/QJW+vHIJj+3ZFETMhAFpgyY6pVkjNYRZ0rN6K9jRpnTeNrgfp2?=
 =?us-ascii?Q?fw4c7BnwmTGoBhZ/xuDnm2+v/rYxMr/ag23JwE7zZZMJmGA+K/LajhaMbO5v?=
 =?us-ascii?Q?wwla5Q/3jsOSLzlO147wcaXM/GBocHpmQGLADQVojMNHf/ZIYhvPGEQ/2zHf?=
 =?us-ascii?Q?rqaghn9/aAgwwTp1Ntqfe8Anodk0kgD+F/6l7umepcxD0C1oeeUsQE0JYg8L?=
 =?us-ascii?Q?J1nCuIkx+ecHG8qg6FVDUaHF9UDMOq3rM/lXQzreHoue6jgLL2+WJ2FuMc5y?=
 =?us-ascii?Q?v+V48Q7avJUcGu0hYpCuZptR9kUMZHgo8Z3yP/b4avo0zEmGFYum3DoaCLvj?=
 =?us-ascii?Q?Ngdld44EOAcBPYL1Z1l5pkdAF501pV1Kz6E5hp8A4VC/2idxejglJi/mpYnh?=
 =?us-ascii?Q?A10tJf8k9FOiwqez26ybp5ZdbsLIUKlAUjaLXJ7EkDGTwHwpZ54ji4BChAjP?=
 =?us-ascii?Q?kcv4bSYGNpbyOArcVP9m2GzlSSifWQxRj5XHwNutSuR2Td6VJXZ8UZCufcoG?=
 =?us-ascii?Q?Es18sCqee4OOU9F2vb4s7twx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558b8879-9f0a-48a3-af49-08d91168d3f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:00:18.1484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJBVK7j/y38IC2Zfoyl/f4zIavo9b09Osz4EZKiiVnZHb8ngQpZvt1B+SLzqCorWCjkN+92XMrJ2eNA7hIssVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Stylon Wang <stylon.wang@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Implement INBOX0 messaging for HW lock

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 123 +++++++++++++++++-
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8df382aaeb8e..40ce15eb934c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x9130ab830
+#define DMUB_FW_VERSION_GIT_HASH 0x2cab49dfb
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 64
+#define DMUB_FW_VERSION_REVISION 65
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -164,6 +164,13 @@ extern "C" {
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
 
+/**
+ * Number of nanoseconds per DMUB tick.
+ * DMCUB_TIMER_CURRENT increments in DMUB ticks, which are 10ns by default.
+ * If DMCUB_TIMER_WINDOW is non-zero this will no longer be true.
+ */
+#define NS_PER_DMUB_TICK 10
+
 /**
  * union dmub_addr - DMUB physical/virtual 64-bit address.
  */
@@ -455,6 +462,61 @@ enum dmub_gpint_command {
 	DMUB_GPINT__PSR_RESIDENCY = 9,
 };
 
+/**
+ * INBOX0 generic command definition
+ */
+union dmub_inbox0_cmd_common {
+	struct {
+		uint32_t command_code: 8; /**< INBOX0 command code */
+		uint32_t param: 24; /**< 24-bit parameter */
+	} bits;
+	uint32_t all;
+};
+
+/**
+ * INBOX0 hw_lock command definition
+ */
+union dmub_inbox0_cmd_lock_hw {
+	struct {
+		uint32_t command_code: 8;
+
+		/* NOTE: Must be have enough bits to match: enum hw_lock_client */
+		uint32_t hw_lock_client: 1;
+
+		/* NOTE: Below fields must match with: struct dmub_hw_lock_inst_flags */
+		uint32_t otg_inst: 3;
+		uint32_t opp_inst: 3;
+		uint32_t dig_inst: 3;
+
+		/* NOTE: Below fields must match with: union dmub_hw_lock_flags */
+		uint32_t lock_pipe: 1;
+		uint32_t lock_cursor: 1;
+		uint32_t lock_dig: 1;
+		uint32_t triple_buffer_lock: 1;
+
+		uint32_t lock: 1;				/**< Lock */
+		uint32_t should_release: 1;		/**< Release */
+		uint32_t reserved: 8; 			/**< Reserved for extending more clients, HW, etc. */
+	} bits;
+	uint32_t all;
+};
+
+union dmub_inbox0_data_register {
+	union dmub_inbox0_cmd_common inbox0_cmd_common;
+	union dmub_inbox0_cmd_lock_hw inbox0_cmd_lock_hw;
+};
+
+enum dmub_inbox0_command {
+	/**
+	 * DESC: Invalid command, ignored.
+	 */
+	DMUB_INBOX0_CMD__INVALID_COMMAND = 0,
+	/**
+	 * DESC: Notification to acquire/release HW lock
+	 * ARGS:
+	 */
+	DMUB_INBOX0_CMD__HW_LOCK = 1,
+};
 //==============================================================================
 //</DMUB_GPINT>=================================================================
 //==============================================================================
@@ -573,7 +635,8 @@ struct dmub_cmd_header {
 	unsigned int type : 8; /**< command type */
 	unsigned int sub_type : 8; /**< command sub type */
 	unsigned int ret_status : 1; /**< 1 if returned data, 0 otherwise */
-	unsigned int reserved0 : 7; /**< reserved bits */
+	unsigned int multi_cmd_pending : 1; /**< 1 if multiple commands chained together */
+	unsigned int reserved0 : 6; /**< reserved bits */
 	unsigned int payload_bytes : 6;  /* payload excluding header - up to 60 bytes */
 	unsigned int reserved1 : 2; /**< reserved bits */
 };
@@ -1346,6 +1409,9 @@ struct dmub_rb_cmd_psr_force_static {
 
 /**
  * Set of HW components that can be locked.
+ *
+ * Note: If updating with more HW components, fields
+ * in dmub_inbox0_cmd_lock_hw must be updated to match.
  */
 union dmub_hw_lock_flags {
 	/**
@@ -1378,6 +1444,9 @@ union dmub_hw_lock_flags {
 
 /**
  * Instances of HW to be locked.
+ *
+ * Note: If updating with more HW components, fields
+ * in dmub_inbox0_cmd_lock_hw must be updated to match.
  */
 struct dmub_hw_lock_inst_flags {
 	/**
@@ -1401,16 +1470,16 @@ struct dmub_hw_lock_inst_flags {
 
 /**
  * Clients that can acquire the HW Lock Manager.
+ *
+ * Note: If updating with more clients, fields in
+ * dmub_inbox0_cmd_lock_hw must be updated to match.
  */
 enum hw_lock_client {
 	/**
 	 * Driver is the client of HW Lock Manager.
 	 */
 	HW_LOCK_CLIENT_DRIVER = 0,
-	/**
-	 * FW is the client of HW Lock Manager.
-	 */
-	HW_LOCK_CLIENT_FW,
+	HW_LOCK_CLIENT_SUBVP = 3,
 	/**
 	 * Invalid client.
 	 */
@@ -2198,6 +2267,46 @@ static inline bool dmub_rb_front(struct dmub_rb *rb,
 	return true;
 }
 
+/**
+ * @brief Determines the next ringbuffer offset.
+ *
+ * @param rb DMUB inbox ringbuffer
+ * @param num_cmds Number of commands
+ * @param next_rptr The next offset in the ringbuffer
+ */
+static inline void dmub_rb_get_rptr_with_offset(struct dmub_rb *rb,
+				  uint32_t num_cmds,
+				  uint32_t *next_rptr)
+{
+	*next_rptr = rb->rptr + DMUB_RB_CMD_SIZE * num_cmds;
+
+	if (*next_rptr >= rb->capacity)
+		*next_rptr %= rb->capacity;
+}
+
+/**
+ * @brief Returns a pointer to a command in the inbox.
+ *
+ * @param rb DMUB inbox ringbuffer
+ * @param cmd The inbox command to return
+ * @param rptr The ringbuffer offset
+ * @return true if not empty
+ * @return false otherwise
+ */
+static inline bool dmub_rb_peek_offset(struct dmub_rb *rb,
+				 union dmub_rb_cmd  **cmd,
+				 uint32_t rptr)
+{
+	uint8_t *rb_cmd = (uint8_t *)(rb->base_address) + rptr;
+
+	if (dmub_rb_empty(rb))
+		return false;
+
+	*cmd = (union dmub_rb_cmd *)rb_cmd;
+
+	return true;
+}
+
 /**
  * @brief Returns the next unprocessed command in the outbox.
  *
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
