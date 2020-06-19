Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA3C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE89208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tcHQhjeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE89208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027986EA4D;
	Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412196EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0YAYU6pRxl+bzPrDIvdZd3CntCtG9/T+Ftv9z3eXD1hl5OqXdmUKLJ2VVMSkyXq/XdKrvzgZmH65KK3/OJGlMwVYbtgaiLNm02hyDuu16WQAPwnBLfK/Sx2wvQvqElP9Jt7vqdMj8j/5cLY+QlfKkwnoscp4PXgWMoxQMvwKkUAgoZjkMGLeqnYm9rPP0oLsHM1fv0TTfT01qJVIN9+iSIqtIcdVimvMlLbdjaCguvXOYqDDaN+AMM3ZXW/sW9U9cWtALZ5C53S4FamzvhjHaYjuCu2Ke7dSRcTk2PHUw6CW7JdryIj0A14zVEVzpLxYYzTxbLXux/FAyReZmvXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV0OcsRiFJEganJzKzAyMvPAnmafWZObzNfD8wyo6Qw=;
 b=SNFjyWWv+oOtYjc7pAZBHb2ndqJY/++FZO88mJaLyeipaiHZDIQmiVKKOhxfhlD158OInJJao7ndpO3n4LTVjYuLDSZeIShcTuVI6OwkFxDVp+cc0f334rNDY2Gv9nmzt7KKnGyTTnYfX8avXlKIcinDDuad9szuDg59/lfzzZB5cp/fnahLI9sEzWjn76g3Ee+0xdHi1cGIl5Ta75x8FV1rnj66FRv2f82WqUMe3FYMgDQmIclZOWjJN62ykWeP2bFJoKLc/rqjOWkWpjerm17Q8xMOFMDlcDuJoGxEHVRbNxXCVnN8GkinEoR0GcFYApEOTGXWFtFVrt2RatIinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV0OcsRiFJEganJzKzAyMvPAnmafWZObzNfD8wyo6Qw=;
 b=tcHQhjeMGGN2Gx+Ja/64K25YGnwV9P+88FEdHSnkP4zcv60xxWpNpVg7E0gaogmTIiAc7CgidsgISGCCnpeScviV8qsOtNk4b2M30V1KDlLGU8CNuPsuiLuGqhbADNBRQVWv4K0kc+tk/TNOKudtHzUjZ5IgffPbQQLY+N+WzHQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:51 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/30] drm/amd/display: [FW Promotion] Release 1.0.17
Date: Fri, 19 Jun 2020 16:11:57 -0400
Message-Id: <20200619201222.2916504-6-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8352b4be-f6aa-4a1e-8cfd-08d8148d24a8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087A06596E32205640A625498980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2g9JOXetN6ftvqbaGmhEzBvikDe1LubyOnv57kJjpg1BVGu5oxGzMY89uR+qEuhM0XbHcCkVY0fyQ/gRNZvzioJTxaD+vMCHsKprg/b7sqo22mzbAcCy7OzjTvaXmy0f5ixsHVNF8eJqoR5FbK4Mr3ZOwOKW/iD0srVtUOfYlHgZ6YGssprgUKonq/kpgEaJP4g1NzlYbBuTldMCc1B7jQOIK+wJ9H+B+vernWShC4JeXbXpG12yP3qL0VzLmntvZELggJ8bf1PXDGkP0xZhHQYXd4/ahd7mDrQcIxM6Xi/bSeVYOiqYYTl3gOsqPD92nmf2mXumPAk15s77fLPLGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(4744005)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4L83n9pU2ntDt3CogxmKvoB4pGvgD0LTptULCIysxPadyLMceOgjvSVJCDLKbznv4UdAX7VvJRUZByl/vRuWBWn0iy3EWdf7n6KcQb9+juxO0LgrEhDdCWS88Mm6OJMPugOsxbAbCSQvg2d70vCpeAO3B0YVmnUm5lwl9UBKeF93WN7feJg9saseENnS43zco1nhj9OkiDz9hRg6Tjj6Hj4wvFMoS5P1tfpYvVcVyk4G1gug19YLjXzJiL78i/R6fVEV+6JESnDdTl2xAL1KN1FmibJ2/Lz02n7Yov1f6uvWf81Lm5o5XtMTxe4NurA9dAZGV0ouEBSr3zcgLZq0pco4S2BEeyViYENVzTu/3dwe5SZzxjliAtJWrJUY+hmY4EwIQ6W8WByHSNg0/X+U1+FjNz7wbMY7mGtxj+farUd6XzVG13rVnlvFM/mcw6WaBEY7ANna8YYdYxy5QIKEXKiscFScSd43ld6astvaWh76ln0FJWc7DHxizOng23Xc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352b4be-f6aa-4a1e-8cfd-08d8148d24a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:51.2677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1phbfFochQJ0B6JMccEk6K1AyIIq4Qzm+d75nyj1HZaN9yaMxlrv+uqmUOibiw7mYgq5vS6296tvs2kogkaXg==
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ef9c116b790f..2b399b836aa6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x703682cd7
+#define DMUB_FW_VERSION_GIT_HASH 0x6d5deb31c
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 16
+#define DMUB_FW_VERSION_REVISION 17
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
