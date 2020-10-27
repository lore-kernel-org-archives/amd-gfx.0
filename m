Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C4C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814B9218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E1u6eoAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814B9218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF846EC51;
	Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700084.outbound.protection.outlook.com [40.107.70.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5843E6EC54
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me5k3IBnwdqc/PbvJtFvP700nDjiQpOjHQthk/aXgSvnVa1/zUELaev6sSjjd2Y0vjNzEbCDHqxCgrTvuwsGIcl1GnlAn3hjqGyxSeDzjMvxgDv0ss2OPNCvuA3JBsev4YqCHH+mARf36y9RmNJywvxWdAYxur9hC2FZhJWWQrxS9cTRN8kpkJd3ezYi3a8X0FV4nln9UufdxzOtKwDLdwNu1ss0XNZavlvi13bp2JlNyYCxpjMZcwDuXyGJiidnNVk6KH0KWk1kLYtiCEcWogCA2TjS4fPJdr3NR4q/dt0uRVuWKwyRWONkyoG7cuTIE7M/WDew27lkQuXpbeAqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFr8dBwRZxbX+o40qjaYbgby+DUbY9id7BmycE+c17g=;
 b=LK1F4/gUmK3oXhKrUzmFrfoFTw5oQcgBEJVZ6HwqutJ96BZeir47p8FgKhbPrBR6VcZUz/otcwIm/yeZYHKV0zEMsbLbQ+WPI+Q0RLflQ3+xuEQEbO+FPOkxV96wr7+TL2mMTO0zVDsrGnKtCa2hZkY3HYt3D+MGUTi1ZdnIbs77tvz3ynidRR3tKlu28Rjr1MZNmZahmLf75YYVzsSQifAQW/ss0IMfRRo9XSU0eO1lJ49j7Op/l2hmBlpQE4IjUk3uH3hwZR9w5A7ZU5cDqREy6BciQLUuThRfb4VYBa4IAT+TWUVmOhLhMq3tCHVojmXDdiJIDDGVvrA4cyFwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFr8dBwRZxbX+o40qjaYbgby+DUbY9id7BmycE+c17g=;
 b=E1u6eoAE6v1t6BnIwHIF0iDSOBW6KPpDVa4xlW3LaeJ/ixqg3IYSuwCX90T9mhSGrOELgCMBR7043GhxR5VmHgA6jEN6p855bfADqSLPYC3WIcgoItSZZiLMTZ1yNSLVAOzdAEIemJ+Q7q70gtt/Mpz0JcSZmCVhqQ03zR8Z6IY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:54 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:54 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/25] drm/amd/display: only check available pipe to disable
 vbios mode.
Date: Tue, 27 Oct 2020 16:52:12 -0400
Message-Id: <20201027205234.8239-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f075e674-d55d-4082-ba22-08d87aba4270
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595AA0E07A1432478E39520FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /B6DF/fGnfJ9fZD60y7BY0IJbrfvPsSzH439/eGjEq3BDk+Q4x38Zfu5zK4LuFsDvs/zNb+j+mC811K8zHWRUlwhx7DewuyJWzzXxu9avEzTv2/xxP9fmzBvkgGI0IVURSrld4jigyBZ8JwpQ/Mv8+BH6AHZn+6es5U36fj/4TF7cB2lmv7xIMZcRtNkgHvup4wbOK5fI9VAXzsbhoBpW9BcLWsIvk3BdM4PwimE7MkfEbzy/WRr9FKKarwKHwC2/LIPqhkTHRr7mDgw3vT4vr6tc5kbqecmm3BtiIp2b29vETcPy3QjhF22SaPWW5oYh9NmyVlHw5SVsXXBsnb3MKVvsB1tum0BJ6uQk4r4iE71E7GW/qj3tD7YFzhg7p96
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PcGLrIu4A0d7BtfDy1qT3qScG+r4qLdb1j+NMLfVe2o9DJ8OaB7WO+3FL6iNCWWPACAFxNmfOunE/VIZ9kDJQPm9Jmx/IqfQGIfZ8nDOtb818eEyWYh/dDvunlebLhuK67cNlHnyhmXofgdMMWivgV4nz29xzY3BA30dwV4r2s5UaqZ8ZMdjkXwZmM3jLLfNM7OdWDqOzhvnYYIwmhJ5BzRancrkozguTC13r8SbKBFEl/7M5ODPnw2dxM2yDkSidUGtxBz8XOibZW0eOiZuCIfl/HzMb8YSKjq7tONlBtVnRCvjmu0CTHeoibd0OwryN0nt8FLSGFpy4b9Vl97V6Cf2aOispSlwcg7/7cFUhhrRX0xRQmrm2TDyV2FQc/GB927YIXc7+ei19HpM/GSXlqMdXJRC7hBshkZ/wiji03hhRLpqdUua/Vxjcl1RLsQ6MywZbqn4rBO4A9JfPbsX4FSg1BJ17dbuEdIOING1ICHzaDdSZe7roeZ1P0AH+owksg2Gupzfxrhqu81CeUf1cHwENYQKhHg/KiIQjQMZ49kcS8mnH3GF6EXv5l9ZpbE0DnhWYttYj0+WNG0Ajf/KsqxBY7bhhFLlo/nqDySnUypsfMbIvI/symI4UMUGw/4Zrhl7JerUuqvvh5uEMY8KyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f075e674-d55d-4082-ba22-08d87aba4270
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:47.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+hmvlb5xex4BBo3r0sxXa8sZig9wGU/Ph/whuIH7z432lQuhBnB8IRhcvGssbFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
1. only need to check first ODM pipe.
2. Only need to check eDP which is on.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1fa4a50e0a44..18154eea09f8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -861,12 +861,16 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		// only looking for first odm pipe
+		if (pipe->prev_odm_pipe)
+			continue;
+
 		if (stream->link->local_sink &&
 			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 			link = stream->link;
 		}
 
-		if (link != NULL) {
+		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			unsigned int enc_inst, tg_inst = 0;
 			unsigned int pix_clk_100hz;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
