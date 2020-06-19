Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBF7208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oQIBaHnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBF7208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E08D6EA0E;
	Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFE96E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is/EUPnFtZ5E4dtiZdFLnCuar+iIH2JI61Zsj9h833poKqmkEDQ80sKVpn1a5x+IgSfuTxpDHdcducTwYdQ/VE+BVeV0070jgHvs6kn2H3ccW/1kqBt996xqGmG8wt2IoMxfIBraINZUQSl2qnkxBxHycnvex24ZvBZnVBbplq/lmaOvR2Inwt9LhD/Juo4obObGydnELEwRyseB6dUF1k9YKGauVOgeLzb7eAVpJ2g8NHOpHlXjfXBq7qcMrRlb26LR0RN1DtM5iGod2wlml9vVMpfW56xKvo5zA3tfOU1GY4nK3ISYZqUjW2tqTGUwn/SygEv00tRdhgrXDYuMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW60gj7ADjHdbqjjpzTrdDFhlruzze+v32JUjE++O/w=;
 b=Ez1+u6unW0a3VSfUjz1sRJGedUAAO+Vt8cD9hkF/JjTJHRUAkApQzKNamrW2R9Yo2iWGD3NH7oUVMZIjZJIu88/JDcteexfBZOL3St8g01luWgyJSsb4HpKe6spOmaLAX5UQXtjtBuvAh+GtQv9mV/TVNc2P0PxBqiPAusqmBNlPqsSU6dTf5SQb9jYdv8rnH5+6FkktTVBqyyJ4Sp2SM9kXGqGa4dnKNr+ISoMG3Prkhdk6xSfTa+OwrxVLBQCnJnUo2sXz9T+TjQTwoBwYaZo/Y5sCR+FT+dBkk8KLP1goInxwVRm6GbHZcLY9q4/goUuuUQc7d7BjUBPKFAC0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW60gj7ADjHdbqjjpzTrdDFhlruzze+v32JUjE++O/w=;
 b=oQIBaHnFg2AOyAbm+yHJAFef/fXoCQFO4BmZH66DFgWEYSRi8M5QfgFYG1ax18IIei2HpFqm2rCC1XPEdEZPOCMxwSO+a85gMSJFLnhDKN+VughcK6QFC7WJWXi0VJqOKICJt6cP+vQqiTvplCcRfjv+mGa47JNWSB13nddNSsw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:50 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/30] drm/amd/display: Fixed using wrong eDP power sequence
 function pointer
Date: Fri, 19 Jun 2020 16:11:56 -0400
Message-Id: <20200619201222.2916504-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:50 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0b85e90-373b-45c7-b785-08d8148d2458
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087BCB01A35A56E9084F30898980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeB5teXFGHeLXOuANLb7d7sSWNeGxWaGDqLedENO7IFAygU30jZqaOPZtzzI4D3AmlOTyOEqODNCpzZvrfYJd7jaoHsrPJvOLHFEHVuyn+2LMMh2xKHzvYFpFkNDBZlT5X6+jGlPIM7fP40gdjgC+bWRhlpsK8+vvDP9PG05tFoLOTD0vAxDmFBD6R7DbY8Uy5ZjOlGPZEUp3MIYgRR3ZRzMosb3WQQ/v1CepTtHnrpv3jJaOq+EIjvJER35pVn6ZiCFArP+SrbSopsvMfiKVAYcFlRJAev28yoI6Bryl5MtrgPgOsYALpFWnHdYa8+KOmI9u4IennZUsGX+rydYIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZcIH268oOZA+Lq9H459GvhE3KGUqlMc2LD5r+37cBPqbZEfCFowYvhXeN95N0ExridDBBr4oskPvWmUTDQNz8GHTE8plqo67IQnWrdLLZIwI1YaGpLU0Q555GI/78l7kyNhkjtXY1ZioSEtkm7OftRt3f2ybhuwBAcRD5/3OhKgtaCmFwv9HGekalypANiV+igkAaL5LOlo5HRr8QaCFPHqK3fHJJe7zTizKn9+VuVJySHMl7gChwVGJ7BQa7fxBrpoDGqdbBWwDcUCGxRSlPjlKXxlxP9ZoOdD/yqnaQKuXd7eR+4ITHepqgM73NtHV3x1GN3Q0H31bKtDDYr+EUsoQFq9lERPL2uQP6rX5XQieusxKG0LG9hatZTGhjVyI4HFBVFxnvIW2oTzuy7i4dDjS8W0quF4FhZtuvpjpnwvmEi7AWm2yRhqXHhdOUo3S9tbKdMB7ojVQ3gCbbF668jU+9iwJuyHj9dtLOL8y5nyzd/i+TR1zrHPtd4H1302v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b85e90-373b-45c7-b785-08d8148d2458
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:50.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsWOPtuXdZufQbPvoHup8TSzGStqHGlnTkE8vhKe+JzkvA6J4cGUNBjFRBvWQY0AVnJ3GxkhddVnZhqfPBy1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sung Lee <Sung.Lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Yi-Ling Chen <Yi-Ling.Chen2@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>

[why]
dc->hwss->edp_backlight_control is null, it would casue it only be off
main-link of eDP.  It is not worng behavior for eDP power sequence off.

[how]
Must use hwseq->funcs.edp_backlight_control finction pointer for edp
backlight.

Signed-off-by: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 845e7f823a3d..abb160b5c395 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1394,10 +1394,10 @@ void dcn10_init_hw(struct dc *dc)
 		if (edp_link &&
 				edp_link->link_enc->funcs->is_dig_enabled &&
 				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-				dc->hwss.edp_backlight_control &&
+				dc->hwseq->funcs.edp_backlight_control &&
 				dc->hwss.power_down &&
 				dc->hwss.edp_power_control) {
-			dc->hwss.edp_backlight_control(edp_link, false);
+			dc->hwseq->funcs.edp_backlight_control(edp_link, false);
 			dc->hwss.power_down(dc);
 			dc->hwss.edp_power_control(edp_link, false);
 		} else {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
