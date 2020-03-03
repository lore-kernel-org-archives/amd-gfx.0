Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717CB2072D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OclxJ8Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717CB2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CB86E988;
	Tue,  3 Mar 2020 23:27:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628196EA89
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbSqUPgrcTwuMDF3EfJOEbEBUtRnS3wtrR5hdKMLgenQ7PFqToEgYTKH8J9R2ExuyoX8fqyI263STn0pRnxVpGVSMFDSVajHbFQ+/LoL8idVfUIadDU7QZjvDXid8/yfk6tNMHfqjZmAMPVb6P5p2U9DRaK/NgjXduuFoMTwCsAXjl5FmVJznQ8nglqwVwD2swCl0hwlClcKOXJcdxe1o9/hveNJOSkYOq/IcK8dTjfn3NfAtiC87OVHixIR6QTuhdm+hCg3wj5c5jIN3yRdRXXXbHJTqJRAcQxGBRIKXGQWLzSsmrpgTQH2AFctpKJxA27O9uu8s2GHINgnwYbNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2DMLFFzwgixva5sbchb6cRZtdFHiI+HUtr/S/AloyE=;
 b=gojCVVzr0pd7+nDvpUlCYEkEcqJpyfBk93yx479tgZnzlOojMzR9eCXDwSGzO8KrYo5bXZvb/SM6LRG/zPEoOy8UP/u96KIXUjjxOCciTVHtIizBCarOE8X0kY4EOddzNnD5sNMo3aqWh703u7jkQYaGwWwwwfMiLWfRRChh8rm27kXyZlQhgyEc85Y3s6pDM+G3BAkBuFYKHU4MchZ26ccEldQH+tlsYxCSK/lOHvRxKnC32NIg+Al2hb1jwD10/GfAuVQjKG2IkN7sHznp8B3p6absiQST4HbapUjt4Ikz74dQWd9ayGMgE2qr7j+1vomqkmzXJaUHjFQVkwx73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2DMLFFzwgixva5sbchb6cRZtdFHiI+HUtr/S/AloyE=;
 b=OclxJ8SfvsjrmmbHEmjgpLLoVbYL5Pvz0BTPTvE/siOYkGH29PgFf29l/JXF4uhGtCqze4f1yw6bYTL/pm4BhJDfawlYLaElNQApDiucboQlLv8FP6Yw/pJ+iJSemaqNC+WxQie//C4yBo24+HcfQrqbz2KkjngqIqdiBBMmzp4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 23:27:45 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amd/display: 3.2.76
Date: Tue,  3 Mar 2020 18:27:18 -0500
Message-Id: <20200303232718.351364-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b378c794-371d-460d-1b97-08d7bfca79e0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:|MW2PR12MB2362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23624236E63256E73D7D04AE98E40@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(6486002)(6666004)(54906003)(66946007)(186003)(66476007)(26005)(16526019)(2906002)(5660300002)(1076003)(52116002)(66556008)(4326008)(7696005)(316002)(478600001)(4744005)(2616005)(956004)(36756003)(86362001)(81166006)(8676002)(6916009)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2362;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh6OJywRF8B6FnAbZ28cBBy0oXp0pJVhD0AOaYV/oRZb6CkzrczMIrpOPhfAZsQiaKqjnJAlcxYgHg4XGPVzr2g5Y8kFGPJoI8rXpydLLzZ46yB1oGzDhDAHu8JjjpOFW7FDXEyraXFtEgYhzvVq683uO5/aBIz26nv4MYllGxPcy0NGJ4fewiT35vPfpmHIH2LmkIv76AuDhlvnkG7NU8g8UYO0bCc+5KxGr8TqnYKaQ8y3vUDUsLxLnOX2+OiEreArpYgrlgRX700oKIfTbaeubvDOiiHqW1EO1tBTnrjFuK0WepSelX9HxDpc9h1lwIuhzIsmLuOga8SkUkhv6LePC1t04jBl1frkV7M4Vb2T2OdPw2+I5HStKimkfoO/Fm/+z9VBzmCb8TYh/aiVLqn381gCVo3PRu3rkZlgvRm+2k3AjozglUesYI48k/QT
X-MS-Exchange-AntiSpam-MessageData: c3bsb6sCwi/8lXwX5yQaQgS49wg+0SRRWsznH/9JsrbhG6HximX6jsVSU6RoG5sOr6RdOd76FOy+jMn1+6vSmJgP+uStffknQcHW9hHuWEZX6JLercQBu9t2ugnuQSYPAiFWUOieEDlhs01e1lTuhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b378c794-371d-460d-1b97-08d7bfca79e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:44.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zlFdTVBxaNGZjrccBWNCVJkNW6IsPr7A9j+09U9zQNNjX3gNVOIHdnIh6iBHHO00gpk7+kkMy8WGMOE1MZn4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
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
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
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
index 5508c32f4484..1e6413a79d47 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.75"
+#define DC_VER "3.2.76"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
