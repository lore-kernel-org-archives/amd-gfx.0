Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD34C3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5257521D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IdXoPDmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5257521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876966E5BE;
	Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158746E5B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAWBIki6qJD0SwBWiNpcWqde8kkMeA6WRMEpbYUsnFLkV9qLKwauI4etugXmCzWR39svwbJtWbwk4/11orebb1bImnvdQ3CbKi4+KKdCaKT6dTYaHlQ3OFkqZ+2fS35b0HGWlIJGkrgl7ZCErcnozkfSTw5BDLWYXb3+Wn7qGZ4O72mztOArIH3gBWCtjB9af/1moYUAO9SFscNxHz2q7tDRMswX+grRZu68VHxcJvrnrYpSkCIAdoN+haU+NiKVcgUkzIPd62Q5nwE0vK/1vXdoqPGFyh7M5RwtC5vo2YeoOhN751DCN/4GtRJD8w5xGXHVK5gr/RIklR8HPSvXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En6NhiBu74kJjhBF6aMmc0kiV9B8rZK+xKyBd68dJqs=;
 b=Ov+cDBQ/6ej0XiUwYn04Gsz56jgcDTOJiOkvM38MOPU3E0c9mnFgZ76hwyyxS12tfiVLj3rEf2P0suoeQwlbooy5IkQ4dOjhs2yywXhjGXN9JoxXHLgFvuLmiSSinWT/01jZipDmTrQ5F6sB17phhpfC7eR+IB8idXqumqmW+l9Nc8nV2EMr9wfNWVfIobwpkyxq76REG2tI7XJMwsfwy+5eVlvhbdxaAbiZQ10QvR+caAiCqU8L3SO0etQU6u991Prsmo5LEgKobZxxtkkBO4Bn4E7SuCRuJshl0cER+U2lMcNTJjMLpmjzAa0qoX7WJW3Np0kJFK0ZnH8dTRlmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En6NhiBu74kJjhBF6aMmc0kiV9B8rZK+xKyBd68dJqs=;
 b=IdXoPDmVC/724A0owi5nj30GJbgAAhiFTXY1YrrC3Ddg9o8OAfbZ3Yg8pk5dTG3Zq8lk5L6r4O7Msq6oxJJPUBhcw1/m+9Lad8njHuCaeFKD9COnLIkCfg0lTOj0WudxpTb0j0+OLsTA8BgYOh2Ff3idXih6KN5Mqdea8B8Rqls=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:47:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/22] drm/amd/display: Add driver support for enabling PSR on
 DMCUB
Date: Mon,  2 Mar 2020 11:47:17 -0500
Message-Id: <20200302164736.89429-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e8400ac-c310-48ff-1e5e-08d7bec972ca
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB254013B10613798F56395A6798E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzBBv8iXRhYrbiM5JvAy5pYOwxttMy+vuD5o1yY7cZILlpVXBG6OhENnIsu+QAGkPFSjDQ/Li0yoQ5gch9yzI9kMzkzCX0CCTfl9uJ/rFF7P7hBX6zNxphqAGveev0WfIZPm7TCh0pBsW++kMLotIMJbGka0F+Gj2LBZqJkjcudYdKvfFQ84JSFNcnGj4EI5c/7+uLnM3CLvyuGbajV3nTe1k/ry6o4hGNzz2xwBx/h/65YIVecVynd18RPb9xhpEK43jwAQAk4/eBUli9WZE96kMoXIrDT7ym+J5QQwkjsAQMoS6c5SqnG8uSJrW9hjo/WolkMABNL8TDE+RfV3NBdsCQU2mvNUbIZFYZB0wRYQ4RKp82ccbS4ktB8KBW9AOAMcw5l0Lho3RzvJvhrz8Dl96gJ/QAiNuNj5F/uezQHUvJ0QczDkScJjwY8sdVvQ
X-MS-Exchange-AntiSpam-MessageData: b3WucSgEaBlZSVp5/ryFj5FUbUMjc7lu4H6lRg3zeeosSaWjcqBf6p81iDNiQGtu8euwJUDWSvWb4JLo/sQMzKb/KRdwNeXfXBzMYUSi60wNcO86dC8tep4t30QOXTZuZcTEEuMrdRWa90XXerUiqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8400ac-c310-48ff-1e5e-08d7bec972ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:52.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwLlZrQGsxOVbnA+FgTfstEQqKjo9yHacBTBPCfHblzO25WHOKlKo8fqLz75eGwlhY2az5KFEXrfRVtVy4/f4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
We want to be able to enable PSR on DMCUB, and fallback to
DMCU when necessary.

[How]
Move psr_on_dmub flag from dc_debug_options to dc_config.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bc1220dce3b1..32dec3257d5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -230,6 +230,7 @@ struct dc_config {
 	bool forced_clocks;
 	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
 	bool multi_mon_pp_mclk_switch;
+	bool psr_on_dmub;
 };
 
 enum visual_confirm {
@@ -410,7 +411,6 @@ struct dc_debug_options {
 	bool dmub_offload_enabled;
 	bool dmcub_emulation;
 	bool dmub_command_table; /* for testing only */
-	bool psr_on_dmub;
 	struct dc_bw_validation_profile bw_val_profile;
 	bool disable_fec;
 	bool disable_48mhz_pwrdwn;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index dce4966eca20..88b51cae6178 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1848,7 +1848,7 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	if (dc->debug.psr_on_dmub) {
+	if (dc->config.psr_on_dmub) {
 		pool->base.psr = dmub_psr_create(ctx);
 
 		if (pool->base.psr == NULL) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
