Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA108C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0D32082F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fAFeVpI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0D32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE186E8F4;
	Wed, 17 Jun 2020 22:01:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61526E82B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWuxthJOBwLJYr7oaDLFZ3jAKnXq0HZZqaSL8Wbw0w3oVEFW9VKyCABWu3mYWxWkVG+RllMs3qvJpXXsJ+WbsLmtdW8kbhZGViobPdurNqhrEgJSHtA1PB0Uf6sYUJtu5oM+1mu6Wlhrj4CWoHg7rlDvAXCpJVUF2tgwHsYNzgkvchBghMp/afwZ85q5/ToMskYpkHCZWbwooizW8FL+A9Uhy7KM6n8BMJg+gB9rQhL0z1rC1+x2rvFoyiOIYKOLR9ovMkJEJetKUUl6tRVjhkbunuOLBGdn6rlbe/OW2vJujmKM0Hi/v1Vq78frtSIEO04lPEo/5TC7age8coisEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAqq9Q2Z/rWvQlhQBF9U12X5r+JZodTKA/niDqhUhBY=;
 b=Wq2tJXFHljeD/Xx349OqcTHJ3IOesTSC6LiYxjsCwbpHPBDnX9ns+bP2gKbgDRf26FS947Q1f9wQfz4pUEFxH4BZNRd3IMRtUW23gbwexfBZhFyoOOYLW5Yfh2UyyqGFwuUE/W+g9+FL91N4xbke711XWKywVBLWlNJpSVj2MV/95YBE2aQntD2covBej1JXUcz/d83XHWjGoaGo9Xv81ny8CtlJaUBBXYURmcmEG3Vq1qFzTcfTVZicFjjbc7Fcg2kkA1rF+Dkna6anhFshxyqCPmzB8ZWczysDqa+ayTTLCXuWpKX8LjFs+amZc643v9l5bPeWqprIAWN5EgSD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAqq9Q2Z/rWvQlhQBF9U12X5r+JZodTKA/niDqhUhBY=;
 b=fAFeVpI+4PbdICg0+2pnZ6J66DrlVRVXerlAMC2y9S9ZBeC4+YCa/XpqpCPRY9HBor00hPK4uFuW9sSuyp8D7s094wWNf2sJY1eGB4+pA48uG4MjPHBBkkK/+04eKz2tjUbQFDi1fHDeeIAxo+l6mwJSvBpJQb7WL+8VtMR6woA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:57 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:57 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm amdgpu: SI UVD add uvd_v3_1 to makefile
Date: Wed, 17 Jun 2020 18:00:14 -0400
Message-Id: <20200617220016.4844-5-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
References: <20200617220016.4844-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca696f1d-27cc-489b-3b42-08d81309ea01
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01854E32530FAAC14BC5C29DFD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovKwZetvIp4klvMAoUq8NoUYiUsezEsoiLgUhGOEm7F56bGaw44xHUg5wqSpp9Kl3gmmmAZOS45S2TjV1lpOKBgcvHj0W30A1Tj8CpoHa6+9yiwaO3YMExrGrwRKoxa1NZm1hJJrEINqA/BWmamRIj7rLJO6u8TjGDlSKko84Pg8Pu17cGbHyGPh7fiSB2ECCqAOOuu3SNqle77HvxJKBbOMuhlW95MMJ7cB/JaKic8H7wX9A7lTLAQI7UFp4pGy/swlEyrfMI7NerClckcXLwyuoxPA9tLEhaOrdVfT/v2f+IIj6DQHD1xiN35RTnLbKqCOD+wa8iGKdQCDDyfSu8iIwWRRL1eGnbYY1ausaqz2GLCeZGY7jLYG48mZmCDv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(4744005)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UhiuI+H2KLDh/zxKxx+7kKWsFjq2orApDPrPfuYo84qUGvNl0Cg9u1iaCqFF+aQiY3IiFRkZe5h+4z1JByuiG4WuYBVStdJBsUA1QbikF1r82ZCEcBEJd+CUWEcBK6J1esH1CfrgCynuTm7I/wMscp5Dp0Gx4H4KozdlyeIKROoCwwlyJmKGZ2YStjdfg5J/gE/eqs+BrUl5wdwexr1ZDW4+fbLCt4Pb4oODJ1xq7VZg7SxmF2jAK9DIqjNkJadqiiboUjlesNasV7yYYsa/n7qEyrlMnG8tBxE9hpJgyLNjQcGJKV50zqgvxAvkBhDHFZTOWePcKQPPAf4KpMc92d+Om2mI+jShj9tBwCWoRj/eI7Cq8Qb8gUOo3Vxvtyy0eFyRy1TjoH+GZraB3ytPhKBaHwJc/dkqF5ETF3sx3Zpj4fuzeq9Qf5+1QWNki4xxL3UQwm+5tljIXk5gpRfI2s8CvTh6jnhnz7dQxo7DxAbVM5u6lsyUT1Tg5dm4tA68
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca696f1d-27cc-489b-3b42-08d81309ea01
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:57.7076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwn0QneTMyKRiNAedIiU8RsqIrRXxqONtMaLXN1NWo2eTjgybiuR174vc2pwYk2dvEi59mAoI7fu5fozunV9VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index bfcfb034aed5..403ec3db29df 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -63,7 +63,8 @@ amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
 	dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
 
-amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o
+amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o \
+	uvd_v3_1.o
 
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
