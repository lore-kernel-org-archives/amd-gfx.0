Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87CC2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B25A20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e6pkF2Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B25A20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB246E2C4;
	Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D1589F53
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsqZAXwUMVP69SN8mnwyv31vrAuVLXVutTmOSHYB35SA8flfEmED3Nzu4WHtsYynJLd81hUcgLTihoRT6YbX9lbIXTrxW9A3L3/TWhSON3QbIfnt0R73MVW9dc/fYnX6lqBxPDT6niztQLKCvZ5PN5Z+82CrXN+FNgH7H0bmdqeFYOPIAMLas9Oy0q7QYmqv0f1zrniZQXZNBtEO7Eqnlu60VgdKlguh7FDBO1DSZWoQSQqpp9lUiHUyr7rZkDrA4D0iSFHIdZa/bgvaFfmFowMKjUZj25zwIwsLPake0aZt0gs07FbzswjuFonVfk+X2QAHG6k6IzZKUOfN3D6XOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQpMSQ8dcwAd72DZ6cegNIh1pqfTMr/rrDqkqMW+Bg8=;
 b=UcXRBsLdVaWMbdCc3x7gA3qIQBGkvBVg5dSxPUZ6t4RItRP7p8kPenzPEN9ZLw5I66yd+z9WEhDSSz+GVf8E4Mp+TJqyJGF1lkUWCe5PeaT2mlNNIwfBqfM06TO6snoEWhcG79jDpEhAm82ZGMjkW57T+LqkuGW/NVgZjd2/9qQlJnNbM4uCZzKeAT5PeKtaEDbmOOXW9PEIaHQrBaxKCTwBBwjAykH2PwnjGG+T27/Uw7WIwT/So18LUp49znwFh8YakSQOWmpPPR/hk/odiRoU1ztLfZf8IUuHhqqBrcLhgnyrbpJ77v/OebTkSGBZnjcfKtkBKRI9M/+r1+sjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQpMSQ8dcwAd72DZ6cegNIh1pqfTMr/rrDqkqMW+Bg8=;
 b=e6pkF2FdlZH6e1vI+qQwgy6Iz767ekMujxVRW3OVhKWnQ70QV4dQU8+9vwaZ3+CskOE2F34TsyD4QUt7GCh54crvVVxeTTd8HtS9luZl/j40k5q8La3ZgO9402bIwKd4BVAZ+zc1VrCAY5Vv0GBvHBcf4cKYJ3LXKV6+hX2VPY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/36] drm/amd/display: 3.2.80
Date: Sun,  5 Apr 2020 16:41:15 -0400
Message-Id: <20200405204115.683559-37-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:42:13 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d94cd60-4bc3-4021-e0fa-08d7d9a1d2b1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255559735C482DA98F81009598C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(4744005)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFN1nPBssvXZFb+IoQeru2O0JLy+JGnKJ0VTgqA2R9Qn7LCGPB8qtOKROUgICkIQ5GbdQmFDUX6SxKuAcc2lFnz5CMeEDZcas2VuBOU/IzjbzC0BmwpN1mmMEqztjWMLl5QLPbJIQVJu3W4zk9RFVL2xapF9DHZdT2GBLVtPH5fQNuCcDIhYhwbBXZAtkmIzq7R8nq36en5y7D1KzstJBw8zyio6PjNcMCZsYdjA+nLumvoQTkghn61Z3AzQLdI8W6ivosSLtZZ22Jv/ChcIZxouz9VqeeskPOnuiAzQPZ6ugtFTIGP90UBpB+I7pwQpKDmb2vh49IDOYl6ejI4J2BoSF1J2IHNXQqVOYUtF8Is5d/UbFLteTgmoTl7bn75HgpBkQZJoUeWhxN6QN5lY+yGdxbHZWlT4ZcNiF9tBOSzJLMSa2Sa+85Z9asnsstAI
X-MS-Exchange-AntiSpam-MessageData: ahCIGFMOhfcvJycgl24bJ3T89ovjmi6PTb2DAYbT86P6zvzs+siM5pDVcS/Rs6Q0iKMjp1y87NLk7Wk+XErzuTLbEINVugGYUwDwcZ3j1xs2YI0n2rn/lAUVKbHO9qhpaDkt/CZ46qWF4uGUPumv7tIyIXNqyqaUQ68tAFOCIu0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d94cd60-4bc3-4021-e0fa-08d7d9a1d2b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:14.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFOdFCs2aSCO7h3WLaMU3lWBshjoElDe7PKu6V21gv1ZoSTM0Irp3Wafj8rioz09mU6dqdQ4GLNvkylTTWQS9Q==
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
index e20b09ca8894..2c70d40f1ece 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.79"
+#define DC_VER "3.2.80"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
