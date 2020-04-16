Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFDC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF7F21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hmIFIQmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7F21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8638E6E271;
	Thu, 16 Apr 2020 23:41:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869816E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/eAMniCVEYpEzJjiWlQlJ0YVCRjESRwM8W5lq8W+fz3QjJ9z5xGr8LhD7UD1fkDI6UMmfQmnQPx8HPLUIxN4GVi2IOWJSMizvGK9JeqdGxQcbvUO3L4Y3DyAZYu83oz5enXRCVf67SV+o3F7zpDdRZdf0f3DAwn8VhDI7gQznQrsP0p9l6nhxb2gXap6+Mgspum8XReOloohHsB+ZQXNb8bZvIsywybA8FeLIsRX50EreGQYMCtNvXTWHGcO+/gUyyQvbtfqmVlcEB2EK/R6/mh4LtYSFyDoazIkpT6Qvs+1Oxut5bp+JzfhZMSPUQnDo5l+DfpeRDLeMshrCYNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnyNSaTybQtXNp1dv1rVX2YjHBO6u2syDQOujkuOSA4=;
 b=MdYblQGT71mK04Sggn9fq8gbLTyNdpJCN9FNEl5TVNUzHO8uukSXXzwifuEeoJkp9PVDGmODQVKR7VV5W8QgnRnlLJLnv1K1eI7iPZAZjxA5F7B+wMPkrwblFBnJYvwr7eyMVWZuyxYVgIAy73zEKSW5pAx2FkjYXXj3o84LQgHOpVHpsBRqZuv05JXvtv5sqfAs2ZpKlz8VNcZdzpL896nVEm9dMfk1QO7AQy+ivkAuAB5HOmD0AsTeFn35AhJrsyUC6q8tP1ZE/bc+UEuRxUew4F4pLDgIvLWmgni6T8h/OjCPW9eYmtpJQXu5phrTL1XKTTez3h/gYWGXgI12/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnyNSaTybQtXNp1dv1rVX2YjHBO6u2syDQOujkuOSA4=;
 b=hmIFIQmmCFRUQ6ByeCLEyd93kWAJnAJVMKtlwBTHH4sg0KpuzsuLB6/3conbHcrMjd89qnXA42hNlHeo/Zw1C4d+Gd2Yqc75Nqtjc7UvgopCksuFgoLKu3rkd9irM39z5ecoRCkUmma90znutOVDbPhfqNe07dtWoXFmdTkVAGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:30 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:30 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/35] drm/amd/display: Avoid NULL pointer in set_backlight
 when ABM is NULL
Date: Thu, 16 Apr 2020 19:40:24 -0400
Message-Id: <20200416234044.2082886-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:29 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1f10da3-4296-4e38-348e-08d7e25fb016
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459E466E63B4517C7A80F4C98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3OunZo+Dr3TnKBRr7ojGoqUQltM9CPnYNO9xYALGU5zBVaxIcMke1EadaaiX84Aqho4VX4czyTVo8CSmhsOueda4FhlU2KkvG5ealPjxed/rsxInYoZNOvR9um8ZbAXKsAm+JPM1AhbdTS4vAFeSiFSj+VR0PUJyqa1z+5uxkBVuYhWwuQWgPuZyIX//vkyD9Z91e3CwgJf88BokjCq28Br+bLrbaWc9xyYEyDug/4K5AVRZpU+qNrX+T1eG3/oN+sdqV7AAJZrjTfm/oXeBiV+42XZmisngO8hbGfDi/esWQOsgUTtT7NzGqHyRby2m+FCAx/N1q7tWgXX5UA6SMRw67OZVinK8vcW6REaGGuN3pwwv24eSIEK2Ax4Lz4pTJyTpCGDRKc/uXtD8G3i0wOv3+0U8Kq87L2/tCtDbZrkYSz7Ut7OxIc48GZCiQaO
X-MS-Exchange-AntiSpam-MessageData: Gq7yHUIY0ao3bb1Q0fKlGP035xHoY1R7vozJz/8+oF+S8nqq8IzTGKGREbjukPviB0zD9DpeMTRaX9+4A3Eg0CMaMa1yJn/TmR1DP6hArggm7HD88unqwu57Kn3u7FunPc2DXPgblq99gWjRbPWRZsi2oDc3V1Jf+pVRcyDWnjE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f10da3-4296-4e38-348e-08d7e25fb016
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:30.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaFvyfdWWnFQyBqpmNZECkpYjuEhPmX/VMz633hoR9ACaP+AZ56eu0qftsCMpebHft7czyFysgXFdVS0+Vuf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <Wyatt.Wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
On ASIC without ABM support (most dGPU) we run into a null pointer
dereference when attempting to set the backlight level.

[How]
This function requires ABM, so fix up the condition to only allow
DMCU to be optional.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1c5c11d6347e..a926c1c3f57d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2462,8 +2462,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 	int i;
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	if ((dmcu == NULL && abm == NULL) ||
-		(abm->funcs->set_backlight_level_pwm == NULL))
+	if (abm == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
 		return false;
 
 	if (dmcu)
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
