Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81423C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAF822D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d13BOgLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAF822D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3236E92E;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E986E91A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEjvqRhH1Hmh72flrKoV05bjR1RDAR7rus94yevctWNrmf++pVm06CILE4ODZuH+xdCuihEurtj1cOwtbGw/XYHFNbu9l1fyvT53vmImtti/3Lvyf9EUjW8EMxTPERPtfF/JfbnMpCL0pEuDbaILTJDZouUwTMBZRbr+ADldZVCQRH2xex7GcRQ/zJiWl8yW7GGsXz7SJ9VgQEPCpQoAxkZTTU/hIKg/DfF1LWI/vi5k82iCzhtoTrwW1go35FOiMc7N5T1dFz24uvXKVaa6ymljZ+VQUNSxJuIDTAHm3Uv6qWak7sqwOZ1Zz3wX/wLEgR8qJpLfqpo2x3nwB/8FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oJH/DfweUZDd1xrYt5lMc8CR/H2ASIgakIgJpd9yq4=;
 b=B1T4h8DtDT0H8UN0ROBsAhXTZoZZaw+SqSRGgmUshtyO0e0xOz2Bc/d+L8KAqZXoqAIcGGp4sCXxs2xLSB6kzBKh7kv/4Fno1UiOY+9v1lVsSa6Fo+4nwpC+aw4eJDeGDsVig0QOsYS1vWPhYLCL3cPt644kC3/FpmrkZRX0EvPrP0nHGJBDWao6W2wQtLn9NRPViREm1sFgwskG3B/YSy7h5LSVfLXko//iuYZM1tmebIIrJE+fB1P6BYR8TS0OyBwQXa5/1yJET5DerTMg7h0Yj/2GUlM3ZCkOOaNryNXI1M/5935SORJZKfV14/JZeDWouIvmoAB3OHw7SCE5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oJH/DfweUZDd1xrYt5lMc8CR/H2ASIgakIgJpd9yq4=;
 b=d13BOgLnTWl8o0ZTCoMIfjDglvNmdUfo90GfLfw38pQmChXew3xc3kEm34ooqX0r4E47Plx8X2WoW8cEyBBjB45qn7hD45J0im+W+abjCry9aXMv08yhHl90BBBtuUIssOGHsykGbg0ba3cf785V8/dWQtrKyQSO7occJX4d//w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:31 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/18] drm/amd/display: Check multiple internal displays for
 power optimization.
Date: Fri, 20 Nov 2020 15:19:52 -0500
Message-Id: <20201120201958.2455002-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3234f07-9cec-4538-e1bf-08d88d91ba42
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42611E153E66D0770A80E2DD98FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:56;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+rajiDl7oggP81isXrXN+1/oYahozRTKouQz3g1K1eQBldKkNwzp8MLqDq9j3+9GFV0a28sbTZA+8y554BlqD0S5Z383gnufOCh6ASvktA4CnlXUIDgspYJVaITg15kzOSvKmZSg5UgyseeUuWuLP1oUQKvnzCgX+MMzWSor9DjQgPTm1yKMs5kpefNkSkxSUwpGx6zC+3gm1VVOrHCTR44cHoe+kNw4JPtHwUnfRjZKbJ9vlQo2tLwCO5KuvsuPAzdnxzVCSK7NBW9Tu6+44eHwvsxjXCZ3Oabu+NZD8EbGRJL98fnKbYsBdh5JW33QOLdG2gaganR+Ty8tb1jKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gIGn5Q7EiHIXGRaFQFNpQhnC9MAbb3/N2F1kdbZuRZUxe1OoOX7+VmXQfw/o6++m9KM9PgDHvC+eBS4poR/7JP/N5XiUNCqw2jbcChEt4vQVn0IZacJ+ykzq41tIfFYD4te9e8IUmOC4BC9qwPM3S+FB/oMrhf6aikXLgMX9IVOZ+YjFUBDsw4D8bgXwAAh7zKc8KV+9mr+XYLb9JPRCb8tHEYfLeg6p/ZYA+LIqarWqHKDLv+WRkos5oIRnQ2bA6DbfKvxC+Bkwj821V2Q2u/tiM2OyR5FXaP9hUqqF4wTNU8TFmC5RCwBZnY80TAgoHxt59r0EtfII80HknzOgj/hiTzbod2CxRRUbpK/uCFq4SrLp0bKdV0h8adlqSdVYJTlRMNLt8v8cN9Znzf6Spyp1J1fBnAfRG8w7TtmAkFrydphsH0cDoBL3vtaHpKNFvqdGkcegEOCOtxH6d86ZkV0MuuFPEl4XeWASiNDizXpvZdrX7Vc8ULAvsnKqVvtv1JvXT2/gqrH//uAU4VGBfq9DbDXY735TbGLV1GQtcSVNliyua31vsdUNzC5trz8lGicagt3bOopQUV/9poKFMORbhfJccpHNLrw/0mXWJTJiiL8tuTXkMT0kL+SnEwcutIWRbhLHxk8xHnrjNxQf0GCRj2Ec9mi6QlKl4uJnEGJjMo7Z1l1Bhw5n/IIF6rvhNe0f1M7fZB3EsfBrLcTo3zLcJCWKRlvCiFx84xZvjP+fMLa5JbzIne/JRa7Su2ShAEJNefLUtK6lFS68MGzqsFG2JQtJa3neQqAipMr+IH+1WExqcrvHO1iUn2ZE1DUGtPuwMYkCCDhan5GE3apvPxoth8rdz+/x4lhWbniV8GN3ZphrcBdb5z32oGpTjZFXGEhOZAYlp12rnKa5dVzTdJYihIGHNf1TXZZzC0Rz0jNWWrQiwujchw3Ld3cci1h/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3234f07-9cec-4538-e1bf-08d88d91ba42
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:30.9803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KUMODzmLRAn/ux0mQAgb/II08DGuvZhd2wsMY7AHFYuin/LcKMyRKkEsAhY9ZqHxed/7ewPYLcED4Ne7CvX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
only apply multiple display power optimization in case there are more
than one internal display.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 28b856e2686d..903353389edb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -149,6 +149,20 @@ static void destroy_links(struct dc *dc)
 	}
 }
 
+static uint32_t get_num_of_internal_disp(struct dc_link **links, uint32_t num_links)
+{
+	int i;
+	uint32_t count = 0;
+
+	for (i = 0; i < num_links; i++) {
+		if (links[i]->connector_signal == SIGNAL_TYPE_EDP ||
+				links[i]->is_internal_display)
+			count++;
+	}
+
+	return count;
+}
+
 static bool create_links(
 		struct dc *dc,
 		uint32_t num_virtual_links)
@@ -250,6 +264,8 @@ static bool create_links(
 		virtual_link_encoder_construct(link->link_enc, &enc_init);
 	}
 
+	dc->caps.num_of_internal_disp = get_num_of_internal_disp(dc->links, dc->link_count);
+
 	return true;
 
 failed_alloc:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b170e653febc..115468d3f793 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -169,6 +169,7 @@ struct dc_caps {
 	bool psp_setup_panel_mode;
 	bool extended_aux_timeout_support;
 	bool dmcub_support;
+	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
 	struct dc_plane_cap planes[MAX_PLANES];
 	struct dc_color_caps color;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
