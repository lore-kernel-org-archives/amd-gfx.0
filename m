Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145CC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ED92072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3VjvuIJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ED92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68776E171;
	Fri, 20 Mar 2020 15:11:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6D76E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFWlgp9QAPjMMVItRsTChnNaxYKpdETyg4AMJ/xcefbaKIoW82/oevmj0UI2NTuq6IzrMkDbLcCZhPZSS0SwIuBCKSluDEGlHGXLUe4Y8OSFdUma0KWrh5/5DrR/0ertH9YzhIQn5XX9k6ipeqI0CMJxoN+cRZ83ZPbhjibJ+Voe7z0HHCuvgPSYl2b6LFhk4bqVz3pxObCzoHzSexIW2B2wn36Lr2ieZhWGlyuZ0qwOzlVE9MeMPhKg379B77thj33o2F1+HysSus00y519fp7+qj1tw986EK939KhTYWhqaOBQ/KRxa72eVJ1DzJNrmT1oumfA8fi2DGlIUhrEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yRtOqcPDZl7preLnSsrvZaQtxXE4fi53U/6TyoXo1U=;
 b=dpb3BVEaIseC19cnDAhIGULz/wZsIjidIDjCUpSY3PuiwgjwIdhJBwXlL47WlKe9XoFL4CN2nKsu0GHdLJkW1z6yy4TBpmtP0KVX/ZVcVSFB2j1sCmjvBZVasbvLumw9PdciE93CIquZ12tdemIeo0NVi6ODvFhNKZztwSshDRmLL3xr8cUTILQii4KTjseNUKjuDvzCveL2rN3NiXsUWrH4YHtd8uvgkdO4Am5tmD9pnx9IV147Fa+2fQ2A1PW/kwDe5PeGEINmWmkFXGkB0P9CotnvMgK3iezAjCG1WXFzvxePDpEc7hmSxO3E9V1xK1DiOQrXd2ntpXdyGXD2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yRtOqcPDZl7preLnSsrvZaQtxXE4fi53U/6TyoXo1U=;
 b=3VjvuIJKvunyIFaTS+Xd01VVsLupmU220w7//uHzRHX8UP0gpUsG4nS6NL19YNZqobPJVGtGFoGcXjscIzagtVf81xaLJqZjFMSFt/ofuflSo9/SN6VDtwKe1NtoH/lGU3uzbY+o+N0rI7J614hUjOOcqHpZX6Xwp8t12nkqoA0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:47 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] drm/amd/display: 3.2.77
Date: Fri, 20 Mar 2020 11:11:17 -0400
Message-Id: <20200320151128.2039940-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:46 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2f74cae-bfec-4869-5103-08d7cce101e0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257214E90B72C97EA5EB380998F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(4744005)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLwgVwxlU/XmXnsN/WEHfsyEjOB7RX9Ds/rfKWgpnwZegh+7O/WMpFLQbJERrCBF35CFZPGnbFywirML8ukdzCkkpVEGhSQUomBUI8jKJqWO21ANpZSZ5ni6tMuUmjxgOW4r5xRoOtBe1cauAL/Z7o8CdrTgIez1L7g6YGQAwC1NndOEBbb1zwaZ7wcs+RpkR7gPvTPx213AMWbSiV/yqDelFDnDPTu9qWSpwCGEFVHyDWN9XDVJevsdd3f2xm0ztX4xxCPGQWdht+mrjVe0QZDmU2G1y3pjlRHnDDp81/KZGldr4PpJOZEEJE32Bq8Uuvml7lTnuAduHCiR1hVD7AWu2B5SNVrSwla+PqqlPee5AH88H/TZDFOhQexMSdK6LyWIUs8WfYZMdtnTmcff8h/lswXtaYuzt3jDUjWZTub002RJsclnyhw/LDuT16v5
X-MS-Exchange-AntiSpam-MessageData: 4V+LTyTWPmf2kOG3U97IF4CQWCZW4ZL42TUvLXYUBwGIdYutfUp8M1+DWdEYndpkZy8IrnGNrZnpP4/GnU1LV3ZDAbICCHZd+WcMp8hx4bJYfp633JXaeyCEirE8mnBGPBLK60FfxfUvxHZU+gdZRW8f6QsnadtqhvDFx0NVn4E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f74cae-bfec-4869-5103-08d7cce101e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:46.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BirzDpYO6ynrZAjnLKcfjf6ktvjdpLeiVAGX3aDtuA+McTNctn6nz3xSZFQr01PkFJqKOEUX9iqD/bnBQ943Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
index d3ceb39e428e..52c7c06d1fde 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.76"
+#define DC_VER "3.2.77"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
