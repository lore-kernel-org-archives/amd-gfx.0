Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B1DC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49DD20714
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VLpNUSt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49DD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B9E6EAAF;
	Fri, 20 Mar 2020 00:24:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4190F6EAAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnnXPt6nFtMmCQWCMvJAd5PXc7l5Re+Wi9sir5GsVJ7eY+WqiZzEooE06k6M9YTCBUGVPyMe7TGnzhVD0KCvu5ax3NKsIR+dsCvehJDMtgJvE88HO1ycvl379OdsCpB4ZIIomXmiu+ezcfKh00/aAtJYOGN0pHJfkbks127nG9nkBCdxxXyVGhMqyhCOF+uw6NlL8qQDY+5tnwmF5j8OeH3RZudZRy5XoN5O2J3JCmSZ9DrZVxAtAaF7NEfkeLOf3s/tZvrMD587ytGkJm93/TevMIYPzkthpLsMs9A7CsBnP5f9FlIHTDTKnVc1+QmN28iRlDZXG7GdM+8zNYHiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC0Qf9PNJ1hyUXbLRTvSqiWpAvF6yU5iXNj+X8X5I3E=;
 b=WMeWUUANU4WqQyEe0rbKKv8P4SCLf3rcqIKDdq/C9Tud/bP7tefMD2ccsQi0jsFOA0CxAdbOBGkdiluvxlR+F5yr6j3MAI/CjJBAAhQknRwhal7AWz2Nqytf9jX27eNGKRPZdUlNqvLWjYb9Go2rZQQCSXfIewEynbNltWfWMZ8H04RtIHz8uN9P6h+byBeXMlPAnWSJhOz8qKWxdaXWvuKHO4Z5OeZzV3A7fInqJZm1Dfleou19M6zbonInmjty3Z6K2zEOu+AIZ8SUW0Q/aX/Ht9aCDmGlkXBp4H7F9xzr6YqERCmeedWx7rQe/qdkbVvJP7giYxrz6ZvTRp0IKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC0Qf9PNJ1hyUXbLRTvSqiWpAvF6yU5iXNj+X8X5I3E=;
 b=VLpNUSt/sNVW+PvremPuQK9TvD8iOG1jgJ3pujtsPouhTaTyQbaF+PY5u4PBhwp/b3/U+Ze5z9F8AG50RM5fLbA3lnBSGruDdvBUpHYjxeRuOKrsuot1eIAKhuGCtAk45xk9ZBb041I0hsJccu7iwiGnDoL8C+XvfEYyQ/mh6H8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:24:45 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:24:45 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: ih doorbell size of range changed for nbio
 v7.4
Date: Thu, 19 Mar 2020 19:24:16 -0500
Message-Id: <20200320002421.14984-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Fri, 20 Mar 2020 00:24:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d04cb239-83c5-465f-9e0d-08d7cc65170f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:|SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451224C99376BCE69A876245FDF50@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(2906002)(6666004)(5660300002)(6916009)(44832011)(6486002)(186003)(1076003)(81156014)(8676002)(316002)(8936002)(956004)(2616005)(4326008)(86362001)(36756003)(66946007)(478600001)(66556008)(66476007)(81166006)(7696005)(52116002)(26005)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4512;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBq+Cp/kgGJMiwac/OJ0zSsKmIfZhBVykDBKEatQAKvTsIxlXmwuzCg+LzsT/I+j/MbmXJZCrY4oNhO6JyqLhfq0TuIbB2pGdLCZVly/LDNSMrJlfs8sv9UmDLcSLF2pfV6+WuRusO0YO1QPx3R3oiEaVNbes57Jn/YCJ7WURLsN8D7NC0DBXXntKWApf1LfMAj0zXMC/bZPhHsUc4zH2RYDRINXexm026CTMjajsW9dXUpJ0T6Pt46TNRFfj9sXJfVyj9wU+6N3VYr4K/sh5zSJej4DV67EPWgSOnHaaWwe+Wo55aHXEB3selomvLe8GgNy/O/LZZ3LzgNqGkCWSbiPIVszhOnSyFsh2MG+MfiBAh5h5+KZ7srRJe76W9Y+Pl8EekYllwx0vpijedskTuJOv1IAo07WgdOaMmFDSQ3QgKHFqmZIpxpUnH5WAtG8
X-MS-Exchange-AntiSpam-MessageData: sCavv1L7MgbE9a8rTck7WG6vYjDRvpkvc0TNdDuQFyLmTSOQJWH+o9ETmznLJJkxgYullGWNTo45Vn3G6XbZlJAVSa4V1DuZWj4FYrxPSL5QIK/b4uh8bzT4o3bfpGcTXO/T33d2jO9KxmM954Kk+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04cb239-83c5-465f-9e0d-08d7cc65170f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 00:24:45.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNfSxHlm5K47RJSTUN09Rtqgh8NlnrrCBajIkJggwa5PHm12JaWCyjzdh2eok6DDAd36FKCb8wJZiFVvd2rqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
nbio v7.4 size of ih doorbell range is 64 bit. This requires 2 DWords per register.

[How]
Change ih doorbell size from 2 to 4. This means two Dwords per ring.
Current configuration uses two ih rings.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 149d386590df..263dbb1f92ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -185,7 +185,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
 	} else
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
