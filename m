Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32662C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8ED764ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ED764ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3362C6EB5B;
	Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6306EB54
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlaLiJPrff9BEwk0HPlBvm07REfylSvmRC22/klWdVCAF1FG9xiEKU5w1TEtl0YqNZtgxyGLINTv1aTxVNwjdYbkRUQlb9ybmwUvLQJWX87xLf+XhCv2X5GHI5cN3j2t6cZDsKMhUSF3I4yckkaoJHG5CaRFXa8mKpzyIQtN/fJouqSfBDatTdZFf4l7tAVYFSOXnuPyR3Tj5/qpMLhWPf/EjEqsE5ALXRxRm4gxMHM4ybCosKJLBCdDHwb7M7qYw8YdmpN8a9blr68SR8O/QLfS/l1n6bc5imwvVl0mVw/Fngi8jF76MWtILbz1oN2x5ZSFHNRw/lToOX9iznAatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ6nuJKYObHUiUb4EWYGOXJI3L7lMzwP5AovLJVYM1M=;
 b=R1ZSrQXEO2nNpCEzFTOCCGJ1nH5uxI+fBlY6mt68kJAAKDwrsTW/641Irst360bNJmSXwHiS3SdinXYyecHyPkCg7RgUAtaT9YQ5liKAoYWDvO/jrxy9WuGO5POIKAXM5xXLOTC7IuQVr64bHFofQmBn6JB+uzuQEtyu/1h5KBKbowim1dP0jT9wZ7usJv+42So9ZjvDqAkZqO5WJmqA0ON//8FRSi9C7cXxvPLHmAN1ppTynWGt9ImdayBHmMWEJKSOFjHvmujK8QTkRnBGzGrVQMNnknFEoXkv/rTCX6XBlj4ETS+YoY14yi7V64lsfaVN63Cr+eGNsM5ZHRnohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ6nuJKYObHUiUb4EWYGOXJI3L7lMzwP5AovLJVYM1M=;
 b=VpgnEV8w0LVQ6z28lkbDsdSNy1hthhtAAFvu1cYN15LWs2YKDANohgL8wKT+imLCJPxGW7IF6fj5rvflNP15ZIgOpmNwCH1i4vt8hsD2+CLaut5pdRaYfC5vZS/EW/mNIKOaFiQN3ARZYwQxc5mn2o469cNhbj5v9N7NmOx6Soc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:03 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 073/159] drm/amdgpu: skip gds ras workaround for aldebaran
Date: Wed, 24 Feb 2021 17:17:33 -0500
Message-Id: <20210224221859.3068810-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0147aaae-27c4-431b-2854-08d8d9125927
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24978B9147180CC47E24779DF79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQguax3or1aZukVW+r42pTloj7L6aaBiJhnIZp0QWFguOpV4fHvlF26o7u78A2UAQLjuWqV0ZNggm58zr2AqWyFZuEJO6NiXp7nfaQKaidLnTADF+hZn6oXIzG1OpLxWJUcSG/Rzt16sQ29fp+6593y8A7P8IVQo8sXXP1vNksPYO3Ef9SgraNituQ21IvXIOxxtRJ1+qAdITH39u1/NO6JJ1aqAxXqdWF00iFz/TcHywRtDD9wffkK5+F5ErP3peF46QyYtEk9tLh8YGyM5Q4G10CkpaiITYQyOyjHkOPKtxUDvdF3ko6vwEXq8+2SzIppeyC52tEWXQn2w5qvdBQhFe/usqEhApp+waA8Ugiy284F8ddpcWdLl6Uf3GgdigdEw1WwV31rdswReoK85QZKtu2mqF+V64n0xqyaxsvzNZ+aKP0Zt4gEi0oayUcp6YsHPgIS/D27ZQbeUxiBK+YWZIfcY+ZjY3y15lL2xNNamEXo954VdSJni7+qlJCCKsxrbsq3+i1rmEtzBabfH9Brb3cpyVwS+thUn3pKIfyodDmioCSYlbBP8+bm4SBCCvCn9893bmEFJDOUoSWQnyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(4744005)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7HqdA0S30OfgzIVOXIKMsOSXf4emO9RIbnSiFl0a74IhXl/o3GaItOLp7BdX?=
 =?us-ascii?Q?reKf6BA7f8CNJeTelJkkOfRKyoYGzTOftelUAeqhX9uGqsehYV/qpjf2ZcAr?=
 =?us-ascii?Q?DzzT+UcWPZJ5MfZxYBycgE9g27dyFrjCg/lftH1UBgGij9JXQ7tlgq23sogP?=
 =?us-ascii?Q?DXSyh2CKE/z72X2ou6oEJnh+yoMMsv/5gTDKIR1TS2U5CEubEJaT2KWrPcUu?=
 =?us-ascii?Q?Vol84EUJ7qGa40T6thIhpSgtlPxvkkLG6drcQXYkSmozbDx9hzuhyQSclE8t?=
 =?us-ascii?Q?xwT0wtKApKXlj5mRtPM08cIsyMkirWoSaxXXcl3ifhtolW5BoVJzZbY/eHXT?=
 =?us-ascii?Q?ry4JkQ7my1Rm6CJ0KEPK9VYz1kkmFXwAEP1kNTC3pDSO6D/gOKpg6VRy9LdT?=
 =?us-ascii?Q?Bazps88xVRADOvMciA+0dzoHiIoDXAzL8yAvhoyB/FEA8M2BM/+AUDepPDP7?=
 =?us-ascii?Q?LF5Br+mRSj4XWlN3W1Oa6SVHbdF8HI6CAm49NKZHqIV1Y45dugde5yPNE0Ir?=
 =?us-ascii?Q?4jXpXhu1sKF1myEY9Ieeq5pBZL+UpZgDJIxvuFQGxzJSKUR8iWNx99z8jJE3?=
 =?us-ascii?Q?Ya2UliSWs2gXh1Q10uNjBI6ANX3TzCrFxnXbC/i8rtd0CLc1hw0OMtnP3ihQ?=
 =?us-ascii?Q?TbaotHc0c+uWHLN3pd/B2lBrEs5Hsi23n+V5mnIhiFAIS1zqWRbUHochGf0o?=
 =?us-ascii?Q?cGDLgiTevtmrFsjR9cJs5gsq5KdFNGYNACy3RY4BXmYIsEKSun8J2scb5JNS?=
 =?us-ascii?Q?fIuJ85gLYqSNLfQQbGYHx6Yr/0BJAYhb0aR7olgZjMGJJfIJZf3E9pqkp0M9?=
 =?us-ascii?Q?ll6TJ1VE/ZF1FgVgkWadZj+VBd4IQrxqbTYqWD2CqEuaH1t30mC3CNo+5f5+?=
 =?us-ascii?Q?ojmNNsvQpoB530z6sy8oANw8TczeJXeDohZfr1s3KBvogcht7hs88DFZlFXf?=
 =?us-ascii?Q?NMpOetPcDa9yXtF7CiEvsG3e84zGg59JiUK2oQ+79h7w2ebPXXZ3YEMBevo0?=
 =?us-ascii?Q?DLpiTF5UrNIWit54kWShbQ2mKvbfFB650SAxbn0my0Bws0xsHeAfO5KZWQpB?=
 =?us-ascii?Q?jm6MlPvSRi6bX2R2WAE8paEXFD2YROSImSKGvco5+bOBQIoA1xKjGF03HW67?=
 =?us-ascii?Q?I84V7MZFOFDcAKrKbVVjb0XGb/xuWa+agIl+KslcbTEISiusB6Fyxv+NXf9E?=
 =?us-ascii?Q?agk838R7cXxuuSuUq7+cl/ttTmg+9DRi5S2jfMXly/J6eKrhjqzcc7Njw1Im?=
 =?us-ascii?Q?a4DZh+QXPfALQuN4h3KyS2eJfAzZJWutPBCeP2EBHBk74mm5s3Fk3AEp/bQk?=
 =?us-ascii?Q?GklHBXN3ToHcDyOTC4tPkqZl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0147aaae-27c4-431b-2854-08d8d9125927
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:10.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sxJcDuI+NCswy4N0XxyvdjvcXVuxCxUVgcWjgW8NpmLZiEv77uovtYuqVbAS1RKLakMiBQlbPmUC9gorz07bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

there won't be any gds useage in either kernel or
pm4 anymore for aldebaran.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 91da6561cd1b..95cb1221c2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4691,7 +4691,8 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	 * to GDS in suspend/resume sequence on several cards. So just
 	 * limit this operation in cold boot sequence.
 	 */
-	if (!adev->in_suspend) {
+	if ((!adev->in_suspend) &&
+	    (adev->gds.gds_size)) {
 		r = gfx_v9_0_do_edc_gds_workarounds(adev);
 		if (r)
 			return r;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
