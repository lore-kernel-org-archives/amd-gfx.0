Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E8C2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512C720644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c8YuZ3Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512C720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3856E20A;
	Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E968C89EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYxheBaNBctOuKuXgR9WV2+QAOOLTozka4ygnrT3+T8orBVR0KG/P0upQ6B0IzRUOqsLUFHsSqrgm7zMgS2Amjivrx9jGZGJUtficlswtphWp15+Z+rS01+Ol7ndsSaprA6lpeZTuW8Mo6HdK6V2F62d5yP+X+aNit+F9LuPBuwtAbt/frRmFqSqdqbBWczsT0EeiGBXYXeX3hmJPsPU1VOLxNlqDgyNb9u2Fy3lr9MK/KYT29JbRKpaFkn4XQ2wbECIbLjMlyuTKpeGh2PA+a32G0rnL/A6d1qvU6726mVcIJ9vrDxxmDueN8VjcpP/bz1kPqRp6Rhal9KBjb7alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI/kiFP0HMxQqhTS14i0z+Jj8Nbg8XlP9UHOsvk/1qM=;
 b=cbMEsTITu5fAyqlijO81WRf/QAvKympwaA88S7s4R8jyMqNsFD3sYbxjQ9VLN5ieOsoby8cYhBvUZ0zeX57b6qXD0ipFQU0TgC80XxfCQFRGKrx78a5KBcHXfWdKvixKXcHQdkmt1AASvwRRerrSvNMk4gVkxwII3KYWDQqG+0GBF/OHeL2guuUE5eLGIPiXtUjVDx2ev1/42CUUMCn8r/UUHy4xxveDHBsnwHtD0DVVd7IT+qwJZbSiJcmlOf8cPWG9kqZWLX9kz+S4QGg6n54ETcCHUAXZqepkl9AVyzrjItUFfHkCImU5WpvFFqgzgNu3tN0Z+y8lE6g3xE6PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI/kiFP0HMxQqhTS14i0z+Jj8Nbg8XlP9UHOsvk/1qM=;
 b=c8YuZ3Jx/zApDGgYAbwdFWYskCip0vfR3eMGqckaCTO7V3e1I2aLFx7NF2YBGiJwTklDWWZbl8aW92TSV7sBr66LhOZRK3tPIRhL8ywaXzmv4UsUg4gJpikspPqEspRaLgDstul/WyrjWPVKbC1Vc/YjeQBAz3IMxU/eBD5ZyGw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/36] drm/amd/display: 3.2.78
Date: Sun,  5 Apr 2020 16:40:40 -0400
Message-Id: <20200405204115.683559-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:38 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46697e9c-258b-4b57-6281-08d7d9a1bdcf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255558EE9445E8457793095798C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(4744005)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG4AriE6H82+9CmloxoanVHRhIY0zwAbvojEFdijHRtLRS/4+5dJ+bTl7FwRqGT0bxucyxxesvVbQbxYz6Nl16uXW9zCNRjNbsuF2ovqZmQMENE9Ed5+ZHIJ3qgjLX9G0qrZhafpxKIn4CXgCe75XCrmGy/VQZ6MtVlke6MQWcR+TTqCoAMUVRqiUiIuXECJIJnT7aaSZIaonjOEgoEu6BlzptL9yHq19am5isSFXqRVqzpGOW96gWUNNVZUCLVAv9vYtKzeE0GkvnabbDMT853YWZ8noYfA+OSD/5hwIZRDR22d2vkxZWjguZNKALd8EcWKN1Xo1wzTe0LJdXVys0J283rCiFyQAbSPO7l6y20qwoLbTRONPKLieJtHmd/pYuJv01+9iLotdPfBEAk3V3j10t4YDN3mTaIu7S3UU+5361bgqs2nsoE+7dAft2Mj
X-MS-Exchange-AntiSpam-MessageData: RN/lRWoXDwuzpH5/q75JdRoYbXjCdWP9SBLmgO7KgK3MVyxVMosKZ6Wt7HnrgeHvj3UCgzHoPQ3DmfaUk06zuSvtsMXZdLHMjwB4HMb5rrvHPGJyFjV63naf9cPnZVJTZNplVnbOIONTk7RekjmK8sbU7+bPLyTpCWjVqxpY37c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46697e9c-258b-4b57-6281-08d7d9a1bdcf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:39.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qs92uBdQYXZIuL2BFNyYgp/j80QKch4ULZilhvN+cRT/fDvDCTbf3gpbbknGzLgEykZFzmb1o3PsNWGvxYOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 92123b0d1196..9ff239d35519 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.77"
+#define DC_VER "3.2.78"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
