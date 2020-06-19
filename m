Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E17C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B019208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FBWPWdlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B019208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888DA897C8;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBA56EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDGubSMyPjJOQzLGTjFnf1IIXOr19FomI8w1V8c0+ooL+DczAIK+q6igHNS4xNM9GSA2EgXLrGgub/Yk7IRZpbYRq3HAXcm2Gc6Id8U43jDIMZd6eGff6/0dAO36UXif+Txegm4+CkLhEbVL7GXrWzTyYvcK59oYcTlw3LYyho4VyIvgrN5smuTRdfzCeiIl0kfO0iwOKZY/yq0jncjycg8yA7Qww8LhuIwcewwY3Jz5KLcKH+VEHqvqc+yu7YBMguRf34pFwKuwy6KD5NC4+aKW+DwdWKq3nYfdxHl74VkANaAPkoDxEglAt/+ioFsLyGDCe6rZiSNQbFNpiGC7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn6qe+2q/PFEi4ISHvjZbbLyL9SlNcMIc+STnLZqneU=;
 b=AIjC4ZJO/N1g7FaXj+i51fSVQCNDrhuEj9BQLN7E+krW/bEBrjtF6C/FvzTzl6exJ9UgrPsh3DgalboQ95nyiB02aQUpTq4j67lBgAWtphbDZpjhNWl26/RH7yjI4XKKxi6jh2L8o+VOybsTK7CBtvj90s02UBIexdmv8y0ekOxbxEd7MwYaQIwVzDwm6o35wpIjnIVbF/U98iu7rn1wBk97UDIcysLqZc/6aPx0XGUTHTer6Qj339d8UJvip5UmjNZ/dLx8gItj+jJ1uGYgWkhdUTG0eY0nitxoiG6DXl3bUkDx/dToiPTXkHnFhIycr1M6zvg0o6XKi9Y3wmQadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn6qe+2q/PFEi4ISHvjZbbLyL9SlNcMIc+STnLZqneU=;
 b=FBWPWdlG9J8Pb0I7RhX27lkpzXARPaoXztiklJlrnUocga2L3k2uYB/Sf/W4eDxDy+S76/3zHvUbO2zuTftIQKWfSYYRj9QPw4+HJqIoc+BcKgYMQC2BxMO/u1eNWBH5YimCTQeQvDI6ZkOYT2AoX99ar9tjmuEsO+E/Sw6TPy4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:57 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/30] drm/amd/display: Added local_sink null check before
 access
Date: Fri, 19 Jun 2020 16:12:05 -0400
Message-Id: <20200619201222.2916504-14-Rodrigo.Siqueira@amd.com>
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
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:56 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 160040ef-af01-41dd-c4c0-08d8148d27e8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087D80E10AA96FE5E2E285798980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV6dMiaG5vfN7E4elDqw93igLxOnU80OUTFh5NG1WdbTOvpUJRkvYBy49Gdci8cQVsl36BhESGTAdVbpjqfng/+s4SBtL2C2H3vE/wMtYPf4wks3F8iRvnIjB1QdlIuehsqSYmH9tVyW+4qO/9kqip4/tCSpp0jQ2yHcmVrDBpiAuK9V/nNJJ45ZOpGC7FWPaay4fN56weNKLtlWfhNIdb8fbxBDCnm5YuxCgTq73xPnCeDb4tKweDveoMkpSwZQipP959GYd411VM61uVygwQRPK38zjZPLGP2oelXBqWj/ibVa7OyvDKsE8T5ad0Q4Qa1lt+nC0BUj8jdDE5x6Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 98j+32JUeVCyTB93BxdvVUcpZ4MEWE1WCyvqQQhlR4zIJrTMgZ9j28eT6pl38g7GD6g6t0x2qdRa9NpgcUE90ttuDAXrbkvXtYaXK1RgjQH6OVz+SUenhAMfh6tYShs0h3RvgaXb8eroMFU31dTU3AOeLI2A/LmgtxXU/5Y/MvWYXn7juM7v4c5aeqB2DRfyTBBiWSAt2Z0JcO+U3xfsN0MtMivWuUv1+g5bEt+3oWjyI4TBAcjQvXIVAWlEswJPEGvLrwv6MUywBbhwXXYtdYFh2NVz6GO6DCYk1m7NaN2Yu9Fd9M0ECes5M6SaAPyxA0hDZA2TKOcLHsB+gC8L4SmsZd9lmz2UekHFdX9Pe1P3+RmGWjOnu/6dY9/dRjYjJ1roi6RIA3YDi8oq/EIrq4U/CnMTY5Q9JYfoLYLhKSc3aDy3iWmwGLnccGQ2EDLoyV8183zWh0OQEVxRKVQqQLL9RwmZ2/5j9dOzyCfbZPC2lbPr7JkfdKWI97Q2OhAA8GssG08xLSeCMyP06Ls/8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160040ef-af01-41dd-c4c0-08d8148d27e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:56.7133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t1tlTtr7wc4b5emqiT5o9Xrx/bV6yyx9QriEjfvEfRcEI2F/PW91rLpWLyAHsEpFrCis56BSbiSsaauJHoXvQ==
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
Cc: Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Need to check if local_sink is NULL before accessing.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 6590f51caefa..93e28231a9d0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -167,7 +167,8 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 		} while (++tries < 50);
 	}
 
-	if (link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
+	if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
 
 	return result;
@@ -201,7 +202,8 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
 	}
 
-	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
+	if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
 
 	return result;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
