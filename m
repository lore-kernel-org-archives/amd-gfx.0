Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E1FC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB0720768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K3026q2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB0720768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6526E0C2;
	Thu, 13 Aug 2020 21:35:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA286E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeKX5IyHJgFSbw2gSy6lz1NlCk1wwfy4onevttDgNe9lBd9URDJO78O68p6ykuK7dWu7blmweObNfi21mD64iZdreDdoI5CfcSHpuoV/NfNlJgtbJc9cJOBd2ab/1aaCDBIJHk95A+zafzo++gAjBydCm5WNLphsDLU/mxwZpjYtHRdGPMhDYFKsgQM992tLLIS/Jc7MUZa7f3yeCDO7/SF9vs0hUqlWmqHxNovR2ZDZys3faT68Efjgc1rERUAYkVEe5EfvRuAJ9G7TRd+sXwoFTzH0P7atzFwnpCU2+sBnu1j0ERoAnx02sCpBe7OXQ494DF7Bkm3f3cCXG8R+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LT0NCnaIwjdoQVjw9CPau1CV2lzE/w16yuJNyd2JBE=;
 b=NBO+wcC9zqb9WCnPXC/Frx8i6WZOi22KVJMcvONaQIuKtpV0QDU+M/qIdCIQTjkFB0DgBMcUv18V7GgxeM9nbte2S0NVQuw/4CcqTjaS4A68nUL+vscmeLHGI16l5zdAozY/jqAfqxE4+oyL3vxb3tGFOm5hTRC59KtOXNHJarxNl/jerIWe2z0oD4vPRtROdAjJ06kNxeA+Sk3BJVt3q0Q13T/DKI1HfM46FqFA4I4+tgy/MMu9VE0WzrkWnoBlPvpVBVqO8vAXjV8nULdpWjLXUDdJ5MwzftwiJMS0E5ocfr6pJkVRZqsNCW6jWfMidlxzSK9hYq0la2MMQrHlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LT0NCnaIwjdoQVjw9CPau1CV2lzE/w16yuJNyd2JBE=;
 b=K3026q2z4Y7KjhmbkxTLllLiYhZKfYPA1TdtQ7xonpt5LP1h8/3a2AZo/lAl9laBSvWpqKa6Ued2CE46jP+oho68a8kvCqffyH8QqbhpBZN7CJuII4bVFhIqRwZob92qj093Qw7Prskr66BRm3JZ9plI5Z3c8f/CyWYLwLS0IA8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:26 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:26 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amd/display: 3.2.98
Date: Thu, 13 Aug 2020 17:33:41 -0400
Message-Id: <20200813213356.1606886-3-Rodrigo.Siqueira@amd.com>
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
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:25 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d28a19f-dcde-41c0-6def-08d83fd0cabc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13559E3F2402FC7651080C3798430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD6xX0gCpqAidm+Ibc7EuQ+1AYfY0rt39LSLFQLmSayMNRm3WwR+enHp1+mxDtBlTi7rInG0j62HyW7yRoMMRUQCKyXF6STCt+PpmEKgO2Z/6BKT2kNpu8MtZlK3fCPR+zSVGcW/9hcOhzqs/otOFp2Rje6Xa2P7UuPrCVVDc9KP78f2HSgF1p7DhUUkRXX70XqdWjCUCi/2F1fTbKSS2XWTRPFaKvjjxm0JgaLvTOhYGhuzpaxxEaZt9J3Q9ItPjVdxYQGKaJT9bpCvUxiMvblKbGtjAQPE5K7jJOzzRsCJKJNCKDNi5OuVltP4TJGp9RDhnyNeau/1T49awTT71Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(4744005)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MLCo9Cm21mtmrbW3KpGsJlg4A4jRKzr0dKQ0U4cPt8PmgDnD4COwvXtg/6wE9QfnljOfkKITQyY5XRnnyxwZU1NgM7uoUFPj+RU9/v9Zle2t1p4pY01r92RnCVddONXF1zDtsdXn4I7SOUIL5h8TCHZSXteLPk7+xc3ToyOl77oqKg6OdBafM0Vu0Dmif14vyQtU02W99tk6fqifrxAKVJLNgkEQFGnM/EvcOsfcRS/wA8AlRw4Qv3cno42EUY+pxQhKoA5fFa0vNN/QQ6q30p1LdGfNZHzoqEcD+maw12KRQ4iSHwDgaDtnhOTpf/YgOUs8vpszM3GyqKYmoJ/lJ4puO0rVDd+POfwpzlUBQu08N3vDjK0647rrMc7Wma0EuZz2GA+rkTCFP5EJnFBdBg14iW4dB6JJW7Ix5ZicyIONZ0z4Wd94Z7tRJYoV2sMbiWS3k0NG7ILnMHj1cvlS4/xzyXaGfJtom2dHG6qakQ40ja0cWR0I8oTwUGRyHq35089KoELm+2JOooMG05cTmauQ7MAQDT5FVqRSW1WoH+rfIB1RNcBon9dqQ6qiDLD43qX+CUfXqVlmohxzX6MUhuki57qjKI78jwHMWVEnIRYG1DQJs4ZcQZ+yf9zhaMSY/KTrXFRS4xNgvP1XqSEmponaDDSv1IUV1hQls+G9VK2s06hUB6wBtl/zJRMzd04b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28a19f-dcde-41c0-6def-08d83fd0cabc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:26.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZgnFQ103CIuhwW5b6VrM0pusmNa7/jWKdqSu7J2Ks1DDgb8CDQYVu6/zwjYZK6B++A6X1pCjgmuN9NYYvhVtw==
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d4cab948607..772b3a647700 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.97"
+#define DC_VER "3.2.98"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
