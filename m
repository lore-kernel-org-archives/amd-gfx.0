Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B6EC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9982B2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ztChgNKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9982B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC9A6F496;
	Fri, 21 Feb 2020 16:03:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33806F496
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNJIcrzKQgWv4ZhEkuhTQ5qiJuhz3xop8ZNJtsZ3ijMREfM8o7vp5moVqgmZ2+Yok0SQAqLIHhlacDVLXgXF/j1BwtO8sdjCzDJ5XutchsKqiiJBffLRdtrlDU2CHJ3vffrBlEQ/XAk2T1bQCiF8VhB94N5Iz86eiiUUgENFUz3yVcpKsZng0LWhgMKEonN0dxpv6SjSoP0rXPkiohF7zBgYyqQ0bP04sINfF9oqQLPXXUUUTrt8evqlsRbqFJgykeKtSMFId9mkFUN7Sxk6vNghJSGzI43g8rUpOF8Uha1iUW1N4Z1t7/KxQkM4gczmTpO0BsVI3hGw7/k59lfRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWalMBlUc+pILQSlwqZyOL4jVOpd3KCv4WmD3Q8vc7Q=;
 b=YgOMYkOR7AjKPNPJYbYvq1BaeiTrrJ+Sam8VVIEQZzFHep/ZfE0EyZoj86tvfyaMKvmlADeS7dmoUMGhPtejTmnBy5JZ34g0knmr4+GTND79Iy3a2xicQVFeW/6whwvOFES3CPYCCWAniu//w37yfqDw1PNMwZSYLLfkPr2mr8cHBoBa/35/wuyfSh1hgjxGTeqbRd8xb4tS3YWK9z0SUpneSAOtmyaArXXYSsFJDQBSHdO6WaT9OhmJ1p+UdZG47Ay7L/yT0j9pJjnCmKv0u+7QjJjYyuYC61vcxlq4vO+uIQ2rVZPtZLUxksmPU8fdlQNZhJL/rdYBjVL2+ZAWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWalMBlUc+pILQSlwqZyOL4jVOpd3KCv4WmD3Q8vc7Q=;
 b=ztChgNKnfPffBlq3RkmXyJpg10GHktAAJDCgdNmmHTkSsKgY4WP0yOy5xhhDLgw4Uedau3IRGij0SH80EPONKeN6Y0iNGksddIeA0nmrypFILmn+pklPZzDuC9yf65AVu2dMckEbt6f0gR04eO0NL5IYAGgU5q/El5y6hg9boFc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:43 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/35] drm/amd/display: dal_ddc_i2c_payloads_create can fail
 causing panic
Date: Fri, 21 Feb 2020 11:02:50 -0500
Message-Id: <20200221160324.2969975-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 340da558-2949-49b6-2206-08d7b6e79fed
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572631EC9C36CB50FEA535398120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001)(70780200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TI3mSJFRbBVWqMkwmKCPB0KSKy8rRAgW7PEsurTys/Re0DEz0n8o2u6vgSCM4cw2FTJpFXjJRUc5aynCwRqd448orJKP43fUbTq+A4hfIJXIp+3UkDXrKggSYymfx7QE74jqbj8MhbaITQ78GuXMHEDbfQHOYkg2OldI91AzfLyS+UOtQtFOhsYPkCzuCAafxSdrGkinOPk7F2c1QupbrPtRjZl09YtuqdC2jgj+ER/+sMhGuODIWU/HTTjshDnelI1JCc/z+t/gIUpYCEkz7BSSxtiwTnqXW3bxFBGWrgOoNb1VzEgOPvfMrwIXbckssNfu8oHkPW1ndGTJlOmOZhuEU3jJ/kS7vhgUVknMTtqlGUQYoPTz2IH/fyJHzehhPCmhMRG19rWujVfV7w3jYAoL1grjQzMVPoumzWK7QtDlMNVxcXBRoc3tEcLKxEEMfwOt7azQT6gakX3aGfmlf2Eo7JAwovtMXNysyBNuXAwKY4c9ZVL7s0pK/2e1+DC
X-MS-Exchange-AntiSpam-MessageData: o6HpI4eXjodp0dirNDame8ORNII7+De9FvoZ0LWQyNb5Kj6xDncDnD77Eu/+nWJCuPFlgOf8wgr9AbDj50Kf0dwo1yS7FpeWRwFnWyFUvcz4KAO5M+EsdxWzjkEaNqLO6eUpeNIRXR2MeDpV38fszw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340da558-2949-49b6-2206-08d7b6e79fed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:43.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bca6LwoQx12IV9tPdNESRZ2qc1KaHcL7tptJKVLg3aIHxPk8qtePuwyD6DSC1uzt+iNkrcaXpLWZOMCtkxrkFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Since the i2c payload allocation can fail need to check return codes

[How]
Clean up i2c payload allocations and check for errors

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 52 +++++++++----------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index a5586f68b4da..256889eed93e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -126,22 +126,16 @@ struct aux_payloads {
 	struct vector payloads;
 };
 
-static struct i2c_payloads *dal_ddc_i2c_payloads_create(struct dc_context *ctx, uint32_t count)
+static bool dal_ddc_i2c_payloads_create(
+		struct dc_context *ctx,
+		struct i2c_payloads *payloads,
+		uint32_t count)
 {
-	struct i2c_payloads *payloads;
-
-	payloads = kzalloc(sizeof(struct i2c_payloads), GFP_KERNEL);
-
-	if (!payloads)
-		return NULL;
-
 	if (dal_vector_construct(
 		&payloads->payloads, ctx, count, sizeof(struct i2c_payload)))
-		return payloads;
-
-	kfree(payloads);
-	return NULL;
+		return true;
 
+	return false;
 }
 
 static struct i2c_payload *dal_ddc_i2c_payloads_get(struct i2c_payloads *p)
@@ -154,14 +148,12 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
 	return p->payloads.count;
 }
 
-static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads **p)
+static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
 {
-	if (!p || !*p)
+	if (!p)
 		return;
-	dal_vector_destruct(&(*p)->payloads);
-	kfree(*p);
-	*p = NULL;
 
+	dal_vector_destruct(&p->payloads);
 }
 
 #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
@@ -524,9 +516,13 @@ bool dal_ddc_service_query_ddc_data(
 
 	uint32_t payloads_num = write_payloads + read_payloads;
 
+
 	if (write_size > EDID_SEGMENT_SIZE || read_size > EDID_SEGMENT_SIZE)
 		return false;
 
+	if (!payloads_num)
+		return false;
+
 	/*TODO: len of payload data for i2c and aux is uint8!!!!,
 	 *  but we want to read 256 over i2c!!!!*/
 	if (dal_ddc_service_is_in_aux_transaction_mode(ddc)) {
@@ -557,23 +553,25 @@ bool dal_ddc_service_query_ddc_data(
 			ret = dal_ddc_submit_aux_command(ddc, &payload);
 		}
 	} else {
-		struct i2c_payloads *payloads =
-			dal_ddc_i2c_payloads_create(ddc->ctx, payloads_num);
+		struct i2c_command command = {0};
+		struct i2c_payloads payloads;
+
+		if (!dal_ddc_i2c_payloads_create(ddc->ctx, &payloads, payloads_num))
+			return false;
 
-		struct i2c_command command = {
-			.payloads = dal_ddc_i2c_payloads_get(payloads),
-			.number_of_payloads = 0,
-			.engine = DDC_I2C_COMMAND_ENGINE,
-			.speed = ddc->ctx->dc->caps.i2c_speed_in_khz };
+		command.payloads = dal_ddc_i2c_payloads_get(&payloads);
+		command.number_of_payloads = 0;
+		command.engine = DDC_I2C_COMMAND_ENGINE;
+		command.speed = ddc->ctx->dc->caps.i2c_speed_in_khz;
 
 		dal_ddc_i2c_payloads_add(
-			payloads, address, write_size, write_buf, true);
+			&payloads, address, write_size, write_buf, true);
 
 		dal_ddc_i2c_payloads_add(
-			payloads, address, read_size, read_buf, false);
+			&payloads, address, read_size, read_buf, false);
 
 		command.number_of_payloads =
-			dal_ddc_i2c_payloads_get_count(payloads);
+			dal_ddc_i2c_payloads_get_count(&payloads);
 
 		ret = dm_helpers_submit_i2c(
 				ddc->ctx,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
