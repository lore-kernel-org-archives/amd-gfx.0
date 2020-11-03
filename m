Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE0CC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EB7206B2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZoGaAzR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EB7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497EC6E4AD;
	Tue,  3 Nov 2020 06:16:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461AB6E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 06:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1wyKANA5t8sg+KmIy5l4HPEhNCdcz+PqF3kQGWIJUF6AlEJh3QQXuXu1nGglztzCBmwXEx+bUUEDRxj3buE30GL0t7lqW0mby4WndfHzyGvve13OtH0gSGPeOWNHXIZ8uF9YA+yhXSDDxQ0gOK8DX5TSPRHP0sPcl0G0I1MrWXLVCNQyDFONMR5s6Q2O4qmhSlpsutYfVak1bImfr5G9RhiFM0PV5Pc1xR7yktSyCV5tbdhsmSk61QH8TeCGQD75w2maPf10329Q6S47CEs9iMZq07hiRgdTcCatZyVf22vJlc8WT8ClizkFF4wWgjO0a10QAYfieFBOqDSNCQcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIv+gtYHsDzMphsJvlpdTNdNOv3JmFmb2UTNIh5TVpQ=;
 b=Gh15IucX7ZtaOGakYb9zR2pkRvdn8nBxsR2lVeaM/5sF+LD3mpLZlqM9FyX26LyR6kD2+f3KO4WXEk2z3pZsKWPhCwqkdpNgv1i5xvYjPX23CrTd5P+1ICLMJRZi0eLTrzOH5d1M032Ax5LzuynQvfgdlgEFCah2ZcFio3CvUo4REcH4obNrF1+apBY1kxJKyl4/my7KWsaqQTpsvNoR2Ra8MgYEqLGqanbjJpe95pp3HxPaVEKlUIrBBM3w6Z4wV/dqE1RC1yk35L6YzM/e7oFb36fXkeiZYCGZhCMUXbQhsfoUApDcNMMehJWid2RZIyu/R5JCQwSVxBCiQGpE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIv+gtYHsDzMphsJvlpdTNdNOv3JmFmb2UTNIh5TVpQ=;
 b=ZoGaAzR+/hAZwzqvk7rt+BZObfQ8Y277cDn6tuMwIzd9mWV1TllezrJZZq+y3nzDEE9X8LLQp+oeGUW9WxS/GkotTZMuZ3KcCsg7ch/hpw8Mxwdr9cEb9D+dp0SsCEKCzMxGYnLDp0k/sTarFRp9gZ9+dj8H0AwDCAOPQ2ar+gc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Tue, 3 Nov 2020 06:16:42 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 06:16:42 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Add GFX Fine Grain Clock Gating flag
Date: Tue,  3 Nov 2020 14:16:19 +0800
Message-Id: <20201103061621.10549-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 06:16:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8af85eb-8c9c-44df-ebb2-08d87fc00832
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021758286D7CE9B7C080845E90110@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ah5wKutfKQSk7lpijQuKLXjRv/apHPEvOb6wpaMt/acgAqND7jCTlIOKHzyU4ElUBJqezBGZG9xCrMkFuY3ZkpcGK5dAPz06L4sU+05gsfkl2Z9mHIl71c7LAJkG8rm7hcaeeiAzpG63y6z9rMW24qNzT3Ln1V6nZxhyt1K6E20S/9R0OIIZKIlAw+DoP10m+ymPTpMPvc825Y92XP7AAjgE+73skXYKPpE+djsXe/heDSIpacXob116uNfW1XVqD8BcWGCYSqMa2sK8j8wEHAswV7P2V0Ydf1uNk/EzfYbRl42NGb6NQe/hFlMzPeJU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(86362001)(36756003)(6486002)(6666004)(316002)(66476007)(2616005)(6916009)(66556008)(83380400001)(66946007)(956004)(8936002)(5660300002)(8676002)(478600001)(52116002)(2906002)(16526019)(186003)(7696005)(1076003)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XN+oglQATSjxRa2xZGhWn5PIoBYprDQz0td3Q8A1ZxIt30pq/iFSziTsVT7HQoxLWivp3C2dGHHbnPXTn5sOT48jjF/spE+JrPNkCqDHW1vtFpam+iki5lSn12S/KSFDVXxFlMHzr2O5E4FJmaByOQ6tsv9qYHNDR0VU1Z6diVjzhVY5EJpHGzhqi7+0yVsIpxUYsRCqiMJwn6LZwEw58+i5/lYeszR+6u3GEl3bod0ibBaD43zV8ov0ndp4vtpfuUNs5KXVksdjebTYStg3fBcSbK+TFQ3nBvqtkxsv11gz6n/Rm7C5XdvV3Q9SIYJgFmR8iwsKhXI4+53/YuHvspyj++yjQLCbGf/N7peqyl+kpS+aFT7O3O8Bt1t97HtK2WyzAc7dMJ1DbSBUPrFPnNJ0nONHwrRTP1E1F/1uEZfbH7a7DYe6DcFo6lMqQWJbxhD5QTApeDOLoUzsvZke2ucM2+4VGM+nwLnVXzqIsMNTDWrT4oDwdoESiCotpyBT9DuQBHQx6k3Q6SOSIZuHHe1DZ78X5/kQ2kKYkAb8+Fst1HzRlElNaMa3HL7M68OuDlwrNZ+sKLtFCheINKihQ7pAeQ1WxFTvIQPTrtOuDRk5DV0TGpf0RYfC+aUJevvUV/BhdkYS6TeetH58FlN4Ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8af85eb-8c9c-44df-ebb2-08d87fc00832
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 06:16:42.3377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UVKUFoe8VulcrMc1TCGq8tJCXGOYIUU4E6d11gDzHg4dVg4bA+UwB2Glh/ZOb/yDgqT7Kq97Kw3zAyQC/MzSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add AMD_CG_SUPPORT_GFX_FGCG for FGCG

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
Change-Id: I97e10e258e25a60de2604b8a31514421f6819448
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 412602d84f71..9676016a37ce 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -144,6 +144,7 @@ enum amd_powergating_state {
 #define AMD_CG_SUPPORT_ATHUB_LS			(1 << 28)
 #define AMD_CG_SUPPORT_ATHUB_MGCG		(1 << 29)
 #define AMD_CG_SUPPORT_JPEG_MGCG		(1 << 30)
+#define AMD_CG_SUPPORT_GFX_FGCG			(1 << 31)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 080af05724ed..e57153d1fa24 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -39,6 +39,7 @@
 #include "hwmgr.h"
 
 static const struct cg_flag_name clocks[] = {
+	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock Gating"},
 	{AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Sleep"},
 	{AMD_CG_SUPPORT_GFX_CGCG, "Graphics Coarse Grain Clock Gating"},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
