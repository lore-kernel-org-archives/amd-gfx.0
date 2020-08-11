Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0458C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2082076C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NzeWaHKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2082076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3571C6E520;
	Tue, 11 Aug 2020 14:15:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25136E520
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 14:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2MkMiaPzArKhM55RG4Tw7GAgzw+eF3fL6nwG2syHeaNWkPKY1lXueye4YU8rGoGsr8p8tshMJLS3+u25K835wmTPOkOOioFH9Ptxr9q28Q0B/lJrPAyuDteIdB/ohd37BHuKldbPMl3OlfO4TLZ928csGqKfr3qpsyF2CBtbXMVpmZP+hewFIxScemKvKuOFlysQpdCblsfx2/e2Udh07OflPi9NnfBXhggKFSGbxcf/Qv//84WblUXJ9CqVaIvuyvyLZf5YrxarOxZtv+EgNcDY8seuk7WxiDgnDcJC1Uh7g/cl8sQdhDCPShcoopQcenSkP3COr4cacyLunXRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZbJptlcheBEqWdZ9G4Q4qw4cwN4xTCBysZoCaAmAdI=;
 b=oSkYe4Z3Mis9G/a2eyX9B39SnpydJCZtBIcK+riRT2GpSoMBO9V4EMSbYhvULGYPxtVsU0ydJpqp6qHev1/QzqrPbystz/XBp8hKRqQNCszQVOo66yKN39+ALwO2jYtHq+T1p/5Y9Ubv9ApWA28KLknRNycfr4B+GtrqhJHDQp95Qd1phnrhsSTfIRDcswCTtZTfs+l+wPP0H9sZHU11OGqfZ8tQB07iQmCx6TlRiukxaFZdH9iY1ecEyMtfrwi8BENMyhZVtOTdHa9c9OyrAtGevJhHUfl2DqhC7/KRmiHNX49yqARN/V+CVMG0Nu0bCdMcxiL0qsRJEVWlN1n3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZbJptlcheBEqWdZ9G4Q4qw4cwN4xTCBysZoCaAmAdI=;
 b=NzeWaHKexg23fyaxMSXxZCXPi3kkOwIUhxSB7D9sf/pTz3IU6qA6aFbZN4riP64Uj+gZfl7TrgfJja7O8mjFDHb9VmdEDe9oGiYAdVX71+HByIA8w/EGou5z2FAgm6bSRz7Ep60JJwJ9bAG5KM2twauGYIS1KbHTGOQvdgcibjE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 14:15:05 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 14:15:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: pass NULL pointer instead of 0
Date: Tue, 11 Aug 2020 16:18:19 +0200
Message-Id: <20200811141819.93228-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: BN6PR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:405:4b::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR1401CA0005.namprd14.prod.outlook.com (2603:10b6:405:4b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Tue, 11 Aug 2020 14:15:04 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a6fcba1-f09c-48ac-0f0f-08d83e00f1d4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0186:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0186CC6591EF465D0193C7E58B450@DM5PR1201MB0186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyvpSNvpYFNwX4xLePPEHZx9HrSCEux7vtQ6OCEwRGP4SHD3D4UZHe0ZPDDIjnnIM6LUtfUj99rQXpqduNyBEEW2a2SlMTUWFRKPIFjb2EvKKvpYLX9fi3H9ki9b/ZizLgdT4sgjTYjbHJsxU6Jhxxaddjj1oGR6MxolXBkzPqC8TgS/AW2LPSYt8PsZaU58YQhbo/yrJqiuFLG2xi2M0KkpWn4SYGaei8yHkt6Gv+Vdww89puSZwLsJwZRCE9+fxxtBhQOPBe6flIet2gUN7zkwhFfLs4twPVeZGKES+aHPKfk+rupnU6eGmOhMmtvhH6EWyvGGm33T7WiuJmIDpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(478600001)(316002)(8676002)(6486002)(36756003)(6666004)(4744005)(44832011)(956004)(1076003)(2616005)(26005)(83380400001)(2906002)(186003)(86362001)(6916009)(4326008)(5660300002)(66476007)(66556008)(8936002)(7696005)(16526019)(66946007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2UWxt26gqb9dPycDYX0gXSRZO9Ecm5+SwzTMLDGNtNcMFMB7rFHzpLbqZdMeeq0kLbk+V5AL/y1SSpnmJoUTCm0PJBdapsVb+v91YobZDEGK8nKe/DJvYypbXOrpp55xabIjkeVunuqMrTNpsA3Ndfo4HVjp5wjrCPgGui7eSmQadhhOm5ScwNeTR9u+BXFFo/DIiTVNmA2WFEDWYzinB1THoo+EqndZoAEPfi3Ww4XDOU0Lnv4+VvSR2XwuppTLq9EHhgfzmav4v0InOfOvxjvRCXizjZoLbI8y4cibskT7zzJm2xIiWPBf5JQ09oG69JZf+utSxPv4HvsxS4IkccfE1FQaDjmLw/ELk7CczK4n4Y1bCHiUVC3nGosD+bJRnifzKgjWI3dElRmwDIAEce0Mss2FCWXpXZgnhtl57I9/mug9cqACexKDmcPBpvCpMaPD3jmKdcYvvnecVYDArfuCvhb8g7jXAmbvq6dL+8k4amnT5mOYm6yaY49TXZ8Z0tsTuU6Id0WeK5MiF8NmAlsnYHxnp7E5GrW1xLvg6Gqk0rS4M1JGbSQ1jN1TZE+BKFo4sIYMx2uYDamKmDA69Olxz1Xl4rCm/Fdk6pKQo/XHuBVtFwurW1nSW+IJDYBPKRPRbmg3OjhydO6N+LJOTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6fcba1-f09c-48ac-0f0f-08d83e00f1d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 14:15:05.4142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nNlCDEF78MhBLBP57vyl/H30XtGGfQUvuUAI7/Gml7emiLr5qJ/qotwnUtQu4AQZbXKAOpSi+kBpK4xBtDWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0186
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
Cc: Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: c030f2e4166c3f55 (drm/amdgpu: add amdgpu_ras.c to support ras (v2))

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2d1fad1abf7a..cd1403f83dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1570,7 +1570,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover(ras->adev, 0);
+		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
