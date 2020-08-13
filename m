Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F56C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89B820768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3Gokr049"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89B820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7336E25D;
	Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F136E255
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA4H/KhudopybVqMtAf5slr9EHb+XUGv2Nghe9qzLUluf3kyakwfngqI1DMd2gz/wr28n1vrKnZhG5w3bB0Mu5PfR5v9zE5bKVUwmGvaAt6lPEN/ozngYDXve6ukqkfPmk3A8gSj89s+oh31ng3+f0Or0iLXiC2RFOC3Ix7ZwNVic2pb49X5XlpF0VxDqck4VrfTV0FhHhZWixSW9cZLyuhHgdl16NE18CdZPOVX9NBuw7KE6FOXoAELJtKYlP4cnRtu7uakGN6F5zmQiV3EfeqSqUUt8z1Vig14rITBGLcYd5FQ25U84+46CaOrwp7LatrDhv4e1wrnZr7EZ9K5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goLzA1WOl/RB7j9gyMKpeW5Sc6VLmEm3zd3GZZNNeco=;
 b=KmmWW43caG7cKJcCt562jR9Xh4ZdCM16W6QQGrG40hG+4cJtbB4NIZvNP5FgDstejozI692K/0rrVJGBlAI9+CX0a/SEEC8QqMGvb8cI8LvRvz4jlzjtRY1RdQBIY6YQdDjwS0C/5ZHVtkpp1SIgxeB6WF8YxS4Zj836yKZRiaVdKOlvzFQKg5cnu8tzu8rt3seYoulR/CTlSgZ+//DNUiYtmrg+o9acD+d31F0qiVovBqZgqJq5HVlbT/VFHsukVRcZCC6cnIPKIshh0MeRcLpxnHn+ab0aPb6GpLJ65sH0lMpxvniIvxC+WRO2qgJQYJecPCtRE31r/qW0PS1Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goLzA1WOl/RB7j9gyMKpeW5Sc6VLmEm3zd3GZZNNeco=;
 b=3Gokr049InmRZwJ0zfmnnAIqjuemcYC8F77O5VAqdyQ8QFX5aZiJUAEGe2s0FaXNvNjnH0o1t3ZVhs8BufDmp7i9qya3GZupKo0fy+l/l738LvIGHmafEe+ON4+KDimLeHez/dRQa5raD42Ifrotgtfgslwtu8Pdizo3mIoV7j0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:34 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amd/display: Reset scrambling on Test Pattern
Date: Thu, 13 Aug 2020 17:33:53 -0400
Message-Id: <20200813213356.1606886-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d644fbdb-d61d-4508-c9f9-08d83fd0cfb9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355C73122A83477533A033598430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Yyh+B9n06qBoRa0oVMgF5Ph5Xc6COZ9Bx3+nRKkaixSyPQnSUoeRDv3xOzRENCh0AaWJY28wLiIXzpea/l62MNqYXvYcOqWobe0UTuFxGpw+K/O41PTT+x7wi4wkuZlmtVJNDg1rB1yiPF5yWu32x8RDCKB9Ve5BI3HXZpZZLePP5v8TFIBAv7Q7h7555s6p7Ucv0bnUY/1KfeikWqiShioDeps+uxK26qvd0JZ7r2lMcMvrRwf0FC6xMO2RpNMQTV0T4bNNeGjd//Swq0lmJoh+sLMkXijiZ9zCwE81loIooArYAJaprIRENdVf2k72G1OrE5Zgn5XPewBi+Bx0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uxtE5GaMu4iKN6kwtyBcdlGGWAqV7iDDbvL3DBQSPE950ieED6nfB8dsEEnUYj7FxMYgu4iWSDs2zrTtxTc6SIFPXslxbpD0/roPm/sR+0tZWwltYdSI2DAbi7YcMK7tZbXjZvJSmCdV6bQ2lInKXc/pnB1/BfAJcOg4WaFdl7hmyjUh/46Ukqe6VB232JRzlHfPpWMZleE2g3imWrCDKviQbHwqD69Tnd+PfIpvErMMGeG4u+CjN9Hk3fHw0YbBU50oL5l86vtSng/M+OIufiBy01Vm5i135Fy0t9nzCrz+msx3cw9lgoBPJO5BOwKuC8pg1jsgZ5/Yud7OxOC0uK+t13gADQ0jf1zBElFRUz2Orv08prEsPGHvf/7c+2uwy+Lk64SZUCPWf3ya4yPz/fv8/2uM7lQKIkidigZFuzt6RaE0UuLuaMbzvOyABowBS3toXlLzYXeKypas2hxg7mXem0vZiu2IQsBDubymdF71Ml3w7JL9Yq38q5ngoil8wegkRlLpYWVaVN3XgvZV6tz5WuDr8z7Y2yRo/t6udqvP/kUbIqYYd/i0a9lvx0q38/ZlrMs7OADG9jgbZZfp+vU2t/gd+5Qn9TRCMpK+Ren/Y4mXdUy52UiIXMkbUeOIpA9HcDrtfQwQU9fyKgPpOYkiBfjcWw2S8gradQw9hnOWxogbmZT1Cte4a4uGoBJj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d644fbdb-d61d-4508-c9f9-08d83fd0cfb9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:34.5862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z+/z8xnGpUa5hu3aFjECvF5z+dUr1c88mi1LIgm0uKfMxp+qdLlu+trJ8aNezkRQWlyh8d72mdXciIkl9XAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Programming is missing the sequence where for eDP the scrambling is
reset when testing for eye diagram test pattern.

[How]
Include the required register in the definition

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3b4c356c5ba6..1ee9087eec76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -491,6 +491,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 [id] = {\
 	LE_DCN3_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
 static const struct dce110_aux_registers_shift aux_shift = {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
