Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0081C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D68F61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D68F61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C296E201;
	Fri, 14 May 2021 04:50:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719386E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMZOa+4agITsWdAw3wGiekTmq7NH2dnila5tzFx/b7FGFTRT9lT5y7iPmXJSPlN8rcGVtb3oY5jLPWxZVKOhj6thcchR0foZI6U0ui16UlNU7ijvWBNyrfmrc5zDWgglz8pb3fljAIEsybrm29C6UuauFV+zYJQ9bEXByaz3dtOmZ6laJYILnIXJN5tc/SzlDSUkFLOC06o2IUk37stzGMxT4jqejGQ6jpSIsZsnBoyJkhypJtKENmLZOw6wHvsVIYK/IDaIBNsZyRAlYBJhGmDa/F9GU2AxZeTPiZJA2gFModKBMqZtHeuerTCJSDjKZj+dQ0ELcv2l4zweEoMWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXnvzW8ng0i+1gaeF5qcFaKBhmnJIkIuVhO6hFVU1NA=;
 b=F4Q9Of4P1l96sbF8ecYCt0O9gNo+PpPRJzTayhBMQxQqN6u1JeUzR9qc2Cd28xBicl8tR4EI1c7ul0wWlatrD21Shj3uaVT71XWvg2VIESHoIfEFVFhBizHEPHkzROkFYEhDQB69S+s1WdrsnUwcn4xZUeEznZ4412o8rGyswKwadFEly9P5Jl1hQ1LIUV57vqz+KU+jQhKUNtOoWMXb0bVcEbEAcFy1EsdNKOwWrVh7dpV+x39nlXZ/u0Qw7tGreXu7YgnAoRVIo5zdpZvQbVHG46QJrrm4W8UF4fqVM0AmPtR+Ke7DdtSghTCFvBRIGvGax5XSztC/vBHyd7L/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXnvzW8ng0i+1gaeF5qcFaKBhmnJIkIuVhO6hFVU1NA=;
 b=mFloUMfGNgNs1LZ+++79/B67b0/m8ckth8Bhlv1goWJnoBF6JvqqYcxmEpzbmqsueXDgWMXceGKS6wELiKqMRiBNjD11d79NMX7/QtmZ0/JU1vM8WS1i632lOb5d0XTlUkyVzjosw3AFXBRH2DKA5GRiRqoUNRq9wqXmQpJuKa0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:39 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:39 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/20] drm/amd/display: Add documentation for power gate plane
Date: Fri, 14 May 2021 12:49:46 +0800
Message-Id: <20210514045003.3069681-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e1df9b-89fd-4418-d25a-08d91693d233
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129C927E3061924969D5CC9FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeUb9Xfk6mXPlaikha240SpmCVQ2aWyB/sjfWGpdIQf0Ex+2SREXdHY/yc8KFPeIYqp7EfTOw9ZMwhH2DyFkH1wMOSwUVi/jfT50qC6wo3gK/Z/zyj+xz8dzUbE+AexBlmKCYeiCHIZrobRVWPOr+xspSbhlAYoWBwFAHZ9AP0RvwJIOY1IWe6J3BtbUPW1yP4BLOzx/dGLtj5tH2JPkdbGmAq0vT+XIAcJGXD5v8MQEXczl/CekqPsat2wU0fDaHqq0WQDuP9I7TEwgeimxqJ5Qdgp5Ox6A0zyQohnlNtoWk2677b0JhKyS/C5k2rJ8C5vyEKZPd6OdxEubGGg3kQ5RcXFp3Xld688Jq2/hoQ50+odAau7iU7o6bmh+nlecVecy+R8nCQhIC5fXyooPEMV/iov8LshKcfJulIRoWvNVPYWWfT5hhE3lnVLyOLRlN+LfODZXpiew6Y3gxu1n+Uyw7kFKc2HjGx73EFnNe5QVH4kvcVCdtLp+ixEr+5vVYuGeVovCZoO8+2cAd+k3OcwoEh/MrXGP3Az3QLbMrYGwmWBFvZOJ7Lqm+I7k0jSRU8yQ4l0dNW3JfdWdP/JOorD5kXMtJAfKs4JDYj6mYZyhNrSCDZOW8Y2REdxbpIwQ28H0gXpxahw6PKAZHgEdjOHibNYAIuqttkOEwcuUCHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qAs10L03860kphHmTL98SqOpuGTeSE4XBep2EObl9pQ286PKK0A2eEXgc0c6?=
 =?us-ascii?Q?3vjgWg/ET9EofMb0/yaiH/zbj5ydrNbFIg7rAqHTjusTpiDHVtoAYqQ1rzZj?=
 =?us-ascii?Q?KXPIjJd9/jux9+txb6BcZRfsXINxaJ5INGTAue7HsaI0iH9/ZZ48hP8VlsQH?=
 =?us-ascii?Q?y41Dq0EAu3oeZt/WewR3aBhC3o/3iGOuxIAp4az5JyjPq95gWfvA5nu/3cUG?=
 =?us-ascii?Q?qZNsDphsQo4LGAmX9rK9W4tRWhCiruyQ171W8RFBOIYDCb3AWAdGz9FHRC23?=
 =?us-ascii?Q?uTCMKleIU6HCV+oAjWmYCJzHe9hqvowsbbFHiNwmkZYncAO55iD0tBexb+8O?=
 =?us-ascii?Q?LboCjvwMKIdcWTVQlF9O58i616FbXVKdwQAIrx4GUVXylk8lQ+NySVOVHFkX?=
 =?us-ascii?Q?yct0mB3cCCnvgQF2qTHmcUc4sBOIrAT5nGqilJfl+wOkN9HMW77Co3NJWvDJ?=
 =?us-ascii?Q?3vzji++yCvV2gLIbbD9TM5py4byI5pZzJOzVt8VVmf+dx2uvCSAFMNhlEj0Z?=
 =?us-ascii?Q?3x38bVoM3BKI04vY7JkscVSEleYvHz/F7+KAOwGDHvdyAio6jMmORxhMmuWX?=
 =?us-ascii?Q?YV26p2resy0s4vv3UY0OaeiDr1g4BCuiFzBc9SOCCQbYHzJ+MLWRk0zzA9uN?=
 =?us-ascii?Q?aXkx0RQxtQhHnWpTxDgYtEMr4+gBdFNXwgxM6TCE6L+HFMHFW+D9SrdncuLE?=
 =?us-ascii?Q?zVeAK+hnTYck3P5PV3rPwXfh8rZU4mkBHlwsPWTXcjClo3ow5OIQ4VdDrJeT?=
 =?us-ascii?Q?rpiGHZ8rQweNnTMcwtOehg4W2H9+ceC9foEnl4GbOdHUfLU+lCLis2AwcbOT?=
 =?us-ascii?Q?22DOcuNDSe0dg5jivpvVzrFEyp43uCp3z7dNf90qwk9u+A17a8clJ+tkdOiD?=
 =?us-ascii?Q?J/MkkOF+2+WCg4Ladl8qAjllqjDOfTPqE11a7WipdkJ6n7zJHGC14HqUWgkA?=
 =?us-ascii?Q?xaIGF0Ueg8hFkW6bWvkdjxAtWZPiCQxdGBTbdAZuUxQJU1pHgS8aNqDrtOFT?=
 =?us-ascii?Q?ahQQ1J6R7C6Vwy6Ls1Umzg8ki7t7b8t+WWaSqrxzuB4NBPIgpxoCKMULtTnJ?=
 =?us-ascii?Q?ZOz0XMCwE5zZuF+czIyyKnYfC+F/gyijslunA6+qGtQn1c/1Jg0u4e1BIOKU?=
 =?us-ascii?Q?fQFCAvZZqu7fuvntOQ3YD9W7JFDVAIvk6BDb/5yzr+EjFIZB/pnrDTG/FwtX?=
 =?us-ascii?Q?TU0R3GQPBueXnf1l59w4qRUmCh5B8pSWYkyamJi+Lyc5GzQ9fg20XJ+ISGlT?=
 =?us-ascii?Q?QZjFjlfnltW2mZEkqPZWY+E3eSvHMNXDUjvnM0GLQnvCMSQMU9zV2eUMBXW9?=
 =?us-ascii?Q?kDkLdLgGdA1oFgjZJy5HTrfT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e1df9b-89fd-4418-d25a-08d91693d233
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:39.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC79X2H+zDwJEdNSzRgjn1k1CwrQtfbgEEcO2iyD54KGONf+txgwpUS+Zbm7ZkbojqzDCY1TWX0d7fAf07LU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit introduces kernel documentation to some essential functions
related to power gate control over planes. It also adds a macro to make
one part of the code easy to understand.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8c2d3d42d9da..90cd8f8529d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -72,6 +72,9 @@
 
 #define GAMMA_HW_POINTS_NUM 256
 
+#define PGFSM_POWER_ON 0
+#define PGFSM_POWER_OFF 2
+
 void print_microsec(struct dc_context *dc_ctx,
 	struct dc_log_buffer_ctx *log_ctx,
 	uint32_t ref_cycle)
@@ -536,13 +539,22 @@ void dcn10_disable_vga(
 	REG_UPDATE(VGA_TEST_CONTROL, VGA_TEST_RENDER_START, 1);
 }
 
+/**
+ * dcn10_dpp_pg_control - DPP power gate control.
+ *
+ * @hws: dce_hwseq reference.
+ * @dpp_inst: DPP instance reference.
+ * @power_on: true if we want to enable power gate, false otherwise.
+ *
+ * Enable or disable power gate in the specific DPP instance.
+ */
 void dcn10_dpp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dpp_inst,
 		bool power_on)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
-	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t pwr_status = power_on ? PGFSM_POWER_ON : PGFSM_POWER_OFF;
 
 	if (hws->ctx->dc->debug.disable_dpp_power_gate)
 		return;
@@ -588,13 +600,22 @@ void dcn10_dpp_pg_control(
 	}
 }
 
+/**
+ * dcn10_hubp_pg_control - HUBP power gate control.
+ *
+ * @hws: dce_hwseq reference.
+ * @hubp_inst: DPP instance reference.
+ * @power_on: true if we want to enable power gate, false otherwise.
+ *
+ * Enable or disable power gate in the specific HUBP instance.
+ */
 void dcn10_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
 		bool power_on)
 {
 	uint32_t power_gate = power_on ? 0 : 1;
-	uint32_t pwr_status = power_on ? 0 : 2;
+	uint32_t pwr_status = power_on ? PGFSM_POWER_ON : PGFSM_POWER_OFF;
 
 	if (hws->ctx->dc->debug.disable_hubp_power_gate)
 		return;
@@ -1078,6 +1099,19 @@ void dcn10_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		hws->funcs.verify_allow_pstate_change_high(dc);
 }
 
+/**
+ * dcn10_plane_atomic_power_down - Power down plane components.
+ *
+ * @dc: dc struct reference. used for grab hwseq.
+ * @dpp: dpp struct reference.
+ * @hubp: hubp struct reference.
+ *
+ * Keep in mind that this operation requires a power gate configuration;
+ * however, requests for switch power gate are precisely controlled to avoid
+ * problems. For this reason, power gate request is usually disabled. This
+ * function first needs to enable the power gate request before disabling DPP
+ * and HUBP. Finally, it disables the power gate request again.
+ */
 void dcn10_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
