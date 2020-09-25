Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910AAC47426
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BEF206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sl88n8Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BEF206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABFC6ED16;
	Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD706ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CegCpCab4vIh6S3WpXv8d9j2/fO45Hg2sPyqnTzwkyxTZd2W2PUciw7zVrBQIEypvxmCnxEzYeCS+23AQs4LCxSBb3eeLEQQ0eSmV3JQgVyuyxBik6JtA4Po282ljQOnmJ2UzpD7+JcNVojBlbnIJ/3Pwk3dXbDu52uslahhj/vWaw4OQZtkCUcSIz8MoDJHDtd3hWmKbqDJ5UB3LNsLDQ0Do+0Brqvg9tH5sUZXUiQ1TWnlwN5L8UjAOm9pNXNhsUaGRkYHGDYwkGtY/V+DJvewR8JnNFiWUYyTjrpLDGOcM6I42bpk268MdNz3rAU5yYd2OdvnzQ191D6xGJC6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6Xa9DuSGzjnl2SiQufTflt6iuqRkgbrrk/HBP/BLPI=;
 b=aiCrvflUo8OFBDmgoRphlnuokCZEd5GzVYM9kX4ZWgWpK68SHZqZuaFi2TnWVNzPHajc8brtwKzfkV3HBPXjNvsdra6XdhjwnDHOFGnng7dZ/HmjIE2+dMTAQD1lJ16CGDZZYYTi0+myZbmOfojA1hOQjiX63qcW9e9BMAmX+BnpEyNDVIUjJYwMJNtgtV13HVEWzYryHK79d7xuQDtaxyGQQ7B3KSTTIfs5QF9priyh2HA4wuRAJWk/PjXAwCN+RwmttcRSQPK4DzKYQaCP3k823BIC5mTrnL8/x/3FrtcinshYAB0D+ej79JdoQzaZN8BR/k5pynsClI44TeMlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6Xa9DuSGzjnl2SiQufTflt6iuqRkgbrrk/HBP/BLPI=;
 b=sl88n8WnoPrlaKRpKuERtQolO66ArGoSVoropLmyTl6v6MAV4WXaZWlbZVMR1qReP/lQKc1CsAmM3Zin0fsTtM8Xwy2wF93w2w9bMBT5p5gGIZvv3olIOSVArDaCnZZz0Qfy/D07I8yMm5oo8wk2r16qnZcPLuNkKpgfRnneosM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:15 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amd/display: [FW Promotion] Release 0.0.35
Date: Fri, 25 Sep 2020 10:54:54 -0400
Message-Id: <20200925145455.2398170-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4bd0206-19a6-43d8-a0ed-08d8616302c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219B0B4172E21832BE7251598360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wve/5Lqpd3kaSgm4g4UT0+rtz0ZkGbfeXPswcSuJu1Yfi7zHQ7AZuW7JO9zaTWwaJZxsS8SPsAq+yIc2vto5CIfrDsp8vY7p8YLtkgxE875KKAJR8QZzO7x3COw519MZeEv20vsvLAZgWkL5DK2fGHQTLVhxstTgM4Q/Us8PD9l3qs/nTxO3mzeVkX8sNcFglTHgeKGamwqp/6DumbD3kxkfjD37ybhQvPfsaD754+eioB4dQnCGW2Oc95D9+0aYLiujvBOS8g9CXnJE9wQkx0o4YRr4VATj0DVnBoZhxVNdnbSYgat/evV2am1ZdqyQmNWaLcYNpbQ9AQMFShySGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tFJa6lAxgfaieHv5hEKI1g944j4n/tz/wjr6wdv+XlNd3HqCdyIixWIP3wqRkpbxzYX0rlcJ+XhWO7/qbpD1j5vGq+jq92tEk0T4mMUXiRLhl/NlB6tH8MmfVTDEGVR1H7ZOxKyqNX1DGp+g/plOwSmTZ25r6C6rmGd/5q/2rx/FP4aLveaPxYQmkciLNHthcwdnSALB9KrP1bVo1NjkGjn74fjKuU3a70mVO0EMEozpHXWDrHw1bpKMYraDzZ5IjyuY4qzleG6Uc6ydYFq7/4aezkCv+YMIrW+qn+QIGFvY9TEYseasJb97oseOx/tpDQrXUh93b7ikznioUr67+0a3282XXiLdUUwM+XavV/WHejQENG4nkttiKghqkDOGX338KBIxGKKamdxNC6KYMN06P+sUS2XylrZZTDasd31OH1W+pDt25gWAHtvWwwjlzY6CsjZ3HsrHwvsPNXYvSLIJl7YsRyA21dX+eKjD4m66BqbhkK2c7AKg0YaOBHzHL1KO0rN9AjIPNapvl/588rQQGSMw7qDSxBkmdxw2i5Mre9GQOgDXzwYHk6p84AcRGhmwfoeufA/vozlRU85gEDih9gPqKta1g9nXlWQvJHFndRnQviM+LLevbbZo9Yc1Vig3YfSaZFajO1EJfqBH/2b1vexrpEvzqFAfR7Zip/OVDEipQgJSDQ/d3OvEQznH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bd0206-19a6-43d8-a0ed-08d8616302c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:15.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMSX1WF/Pr0TvCRSjP8E1auseJT+jY+L/M62FH7T7cxp/eWDNE47CBNxfG/v+kl8L6SNJf8HpMxkcL70nz2Qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
   - Definition for retaining ABM settings during disable
   - Addition of some new AUX interface definitions
   - Addition of some outbox definitions

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 132 +++++++++++++++++-
 1 file changed, 126 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0051b1000264..d103ec1eaa73 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf547f0b9d
+#define DMUB_FW_VERSION_GIT_HASH 0x9cf8f05fe
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 34
+#define DMUB_FW_VERSION_REVISION 35
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -57,6 +57,7 @@
 
 #define SET_ABM_PIPE_GRADUALLY_DISABLE           0
 #define SET_ABM_PIPE_IMMEDIATELY_DISABLE         255
+#define SET_ABM_PIPE_IMMEDIATE_KEEP_GAIN_DISABLE 254
 #define SET_ABM_PIPE_NORMAL                      1
 
 /* Maximum number of streams on any ASIC. */
@@ -69,10 +70,6 @@
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
 
-#if defined(__cplusplus)
-extern "C" {
-#endif
-
 #ifndef dmub_memcpy
 #define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
 #endif
@@ -81,6 +78,10 @@ extern "C" {
 #define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
 #endif
 
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
 #ifndef dmub_udelay
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
@@ -299,11 +300,15 @@ enum dmub_cmd_type {
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__ABM = 66,
 	DMUB_CMD__HW_LOCK = 69,
+	DMUB_CMD__DP_AUX_ACCESS = 70,
+	DMUB_CMD__OUTBOX1_ENABLE = 71,
 	DMUB_CMD__VBIOS = 128,
 };
 
 enum dmub_out_cmd_type {
 	DMUB_OUT_CMD__NULL = 0,
+	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
+	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
 #pragma pack(push, 1)
@@ -461,6 +466,78 @@ struct dmub_rb_cmd_dpphy_init {
 	uint8_t reserved[60];
 };
 
+enum dp_aux_request_action {
+	DP_AUX_REQ_ACTION_I2C_WRITE		= 0x00,
+	DP_AUX_REQ_ACTION_I2C_READ		= 0x10,
+	DP_AUX_REQ_ACTION_I2C_STATUS_REQ	= 0x20,
+	DP_AUX_REQ_ACTION_I2C_WRITE_MOT		= 0x40,
+	DP_AUX_REQ_ACTION_I2C_READ_MOT		= 0x50,
+	DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT	= 0x60,
+	DP_AUX_REQ_ACTION_DPCD_WRITE		= 0x80,
+	DP_AUX_REQ_ACTION_DPCD_READ		= 0x90
+};
+
+/* DP AUX command */
+struct aux_transaction_parameters {
+	uint8_t is_i2c_over_aux;
+	uint8_t action;
+	uint8_t length;
+	uint8_t pad;
+	uint32_t address;
+	uint8_t data[16];
+};
+
+struct dmub_cmd_dp_aux_control_data {
+	uint32_t handle;
+	uint8_t port_index;
+	uint8_t sw_crc_enabled;
+	uint16_t timeout;
+	struct aux_transaction_parameters dpaux;
+};
+
+struct dmub_rb_cmd_dp_aux_access {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_dp_aux_control_data aux_control;
+};
+
+struct dmub_rb_cmd_outbox1_enable {
+	struct dmub_cmd_header header;
+	uint32_t enable;
+};
+
+/* DP AUX Reply command - OutBox Cmd */
+struct aux_reply_data {
+	uint8_t command;
+	uint8_t length;
+	uint8_t pad[2];
+	uint8_t data[16];
+};
+
+struct aux_reply_control_data {
+	uint32_t handle;
+	uint8_t phy_port_index;
+	uint8_t result;
+	uint16_t pad;
+};
+
+struct dmub_rb_cmd_dp_aux_reply {
+	struct dmub_cmd_header header;
+	struct aux_reply_control_data control;
+	struct aux_reply_data reply_data;
+};
+
+struct dp_hpd_data {
+	uint8_t phy_port_index;
+	uint8_t hpd_type;
+	uint8_t hpd_status;
+	uint8_t pad;
+};
+
+struct dmub_rb_cmd_dp_hpd_notify {
+	struct dmub_cmd_header header;
+	struct dp_hpd_data hpd_data;
+};
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -690,8 +767,15 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_abm_set_ambient_level abm_set_ambient_level;
 	struct dmub_rb_cmd_abm_set_pwm_frac abm_set_pwm_frac;
 	struct dmub_rb_cmd_abm_init_config abm_init_config;
+	struct dmub_rb_cmd_dp_aux_access dp_aux_access;
+	struct dmub_rb_cmd_outbox1_enable outbox1_enable;
 };
 
+union dmub_rb_out_cmd {
+	struct dmub_rb_cmd_common cmd_common;
+	struct dmub_rb_cmd_dp_aux_reply dp_aux_reply;
+	struct dmub_rb_cmd_dp_hpd_notify dp_hpd_notify;
+};
 #pragma pack(pop)
 
 
@@ -764,6 +848,25 @@ static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 	return true;
 }
 
+static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
+				      const union dmub_rb_out_cmd *cmd)
+{
+	uint8_t *dst = (uint8_t *)(rb->base_address) + rb->wrpt;
+	const uint8_t *src = (uint8_t *)cmd;
+
+	if (dmub_rb_full(rb))
+		return false;
+
+	dmub_memcpy(dst, src, DMUB_RB_CMD_SIZE);
+
+	rb->wrpt += DMUB_RB_CMD_SIZE;
+
+	if (rb->wrpt >= rb->capacity)
+		rb->wrpt %= rb->capacity;
+
+	return true;
+}
+
 static inline bool dmub_rb_front(struct dmub_rb *rb,
 				 union dmub_rb_cmd  *cmd)
 {
@@ -777,6 +880,23 @@ static inline bool dmub_rb_front(struct dmub_rb *rb,
 	return true;
 }
 
+static inline bool dmub_rb_out_front(struct dmub_rb *rb,
+				 union dmub_rb_out_cmd  *cmd)
+{
+	const uint64_t volatile *src = (const uint64_t volatile *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
+	uint64_t *dst = (uint64_t *)cmd;
+	int i;
+
+	if (dmub_rb_empty(rb))
+		return false;
+
+	// copying data
+	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+		*dst++ = *src++;
+
+	return true;
+}
+
 static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 {
 	if (dmub_rb_empty(rb))
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
