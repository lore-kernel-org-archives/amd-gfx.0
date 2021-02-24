Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E50C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6741564ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6741564ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852B6EB5C;
	Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153D06EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haOfDI13PCXQU40VjyzUohTTQZtsgOvJJsBRiZinurKAOmsvN3JRUdAPi6Vx6GA6kBNqM47SQ/LKDH7WxdbjnfHRxPuHxQtkXLr9gmzAMchKytmpOghRHck2CxMvb3T75bw4djfp8+BcO7YkSBtyvDIC7oeTS6M8lLdgn6mJuy7PUnwenVunUKJ6LQCj6b1fSGOhcFsBTJ9MmOG/kZys+oLEpx9Koy3b0WqeeYzFnML3W13VLdqY6Aro4RHhWCvhjO42pQh7XLJEXraqX46315w5LabvWqevP2T1JmPWAW2gy0pbGMOc7BXbQrsrbyYX8hLiFKZGlbWAmC6oCMHwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGmOlZOQMWi9a4AEXnV80I1mPXlbCRMWUw6bKR+ybbY=;
 b=Y9xDOxz/sGQxtTq3K+h/No2j0peJbr0JC5LWDDtqXzbxYgFQthsvjWWME7FQdTO0jwC1KFgvx6gZfpT9K51oCdiaGXw/yuj1N+HMk8mITLlA3GTF3GlyVs8l2n2YtgM7Y/2QWF57l8ttkrlREALHG9E59acgNrDDfCoLmLCY6YQY17JEZWe+XAtkURbpgc0hst/1iuSZTcTdjb3weYSuR7RVYZHmRzxT9lqv2AQ6BQZxw3jzj53jKrM1aj5EXEMAF0Okog09lrnXUbZuNsGXCzmtdH89F6UNJvX8gB+WcUQPPeuh/0/w2sVvi+McN25wTmuD3sJ2OVgDmraHdTC+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGmOlZOQMWi9a4AEXnV80I1mPXlbCRMWUw6bKR+ybbY=;
 b=CQRNsPCFs9Z9dN5UATDgkf4evuXFoM9SR0TP/pWHRbv+uuLcaIRFKJdguql28yUuW0fhfB4gIBsEIJjBFdAWktH+oQ7qSfCKBV9+PKea42KebnvMZlzRCfQcwQHMES4ScHmMudpZVs2hrkrUGZ4PjKZk33YXyUus8cvqrt3U0HI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 089/159] drm/amdgpu: Don't do FB resize under A+A config
Date: Wed, 24 Feb 2021 17:17:49 -0500
Message-Id: <20210224221859.3068810-82-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56def0d2-755b-4605-b3c3-08d8d9126049
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046CBBE4F12E921CFFE39C7F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJgbf1t9QdUjSDyBhYX02b615OBdYSCXWMu4Uo8Q8l/pX2wCTeHhfZT9UdM3senABPSRcQebIu7sAfuu9Sbl8nFGEKeuhFXZs+T19jHPJKOXaBixTMXrRh5tWYqiUpCTgSkzMaxmD4TmZNmW0XBstSBMIVAgNu15qNtrMH4BBBSPlI2Cw1OxZzmN/PWxB6S+iJst22z0r9OFZSTQVAfP3xx8XEcNQhnqEGdRFpOmRfIX0UqKc8k+D49qnrjsKf4RPplYFY4Y/Gl6RQy/IatKdpp/xwN3GlUW9k1WMvJZIxXX660p2VixJMwYPQpiVjwUW9z+P9+YFDvTJcFkrHhy1N5YcbKtMMZ3cdkyzKqPdT07IKQkyDxVP+qSHvdkW6ngSm+GGT+eP5jSQy3Tsuja3061hpzqMcoAQfdCOUGEDwiop3DYRmq1eCpCKCgEkJfQ/x2O0qkjq7vVs7ZXh//UqgvWD55rmysr1k8WWjRsTSyXIg/idmK0Es9SsVf9+Aw3HwCDkM2Ozo9iUYH0Mm7F/9sZXTwzQi/4DxWPEwxqGJ/fBPK9jwX3fqx423FCmjjotnqqylZHvb3YM+Zt8EQv2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7xUr0nf3hbSYm92Khb0wpb4hR8rsYhPa/m/F19qfVHoinCsIZtshJtegU3Vl?=
 =?us-ascii?Q?Fwvp//CIf+664PI1hgw0GeRssUj5Hgw3Gyw8imo4ctdAF5FLeeb3bXqJLLYS?=
 =?us-ascii?Q?ZnQ2k4jISWDIzwb3oUKBW3fltNxuHObuu+pjT+6uSvYqfpBkVXdyejr41uwT?=
 =?us-ascii?Q?vsl5XEmzwhHNqJ8roGaYTGH9OQKCOCwQdIwQChQb9PMh0/LmON1KIky6AazG?=
 =?us-ascii?Q?mGzAF0uNrPFl0UfSojTHg2TZwSR3jT7dL5ScQwIvntXI+XHFHFc++HOidUzR?=
 =?us-ascii?Q?wdEDla9zVci1W+ost51HpEQP6vqB5LrrJbSih80e1OSBuKalzHsb12MaPX8f?=
 =?us-ascii?Q?Kgq3NL4rysaUlRaGxc/3O38UztjmGsN0+AQkAWeFwHD1yjqI0PwdT095YF/Y?=
 =?us-ascii?Q?tZQLuZlI4OLfgmvg655oistmqGEYBsIaUCXXSLmJ/D/og7105wViLPZqE5zL?=
 =?us-ascii?Q?/pn4nPPXF2bywSecqqUugIR3nGb4knZeK4FZ8PCfpFEKPJs04UT8uSF5INcr?=
 =?us-ascii?Q?Pt52Qd3n53pZ0DirepnXhMPQBQpoI8FmnJLlAQrlgKSMnmWTTCy5AwmvJcbl?=
 =?us-ascii?Q?54Pyw1k43z9Dqs2PUWJU/QTedEFqiJE3MRXa1qY9IGHyTMVnAFAVbSWVwYsE?=
 =?us-ascii?Q?iNTLuWF3/MN+KWwS8sAYJULjqklcB2MGUn+482HyENANYdJiP+nSl9wBBUGd?=
 =?us-ascii?Q?UF6uCVthtfcUcH2mXxrVMqCn+YRuX7bo5zhGR0ee5unWIZn4WpmAuZ6k4uzd?=
 =?us-ascii?Q?v1WaNx+CNHlZA2K8mAqVJM6ZG7slQHTgNIlxEZQFTt2Gh5pwbi4MUfGPCDXC?=
 =?us-ascii?Q?cG1DFkXEnq5IgcLa/NctCTBavMirT3PAE4n7nVaw2+aY1dJYjTR/NFug61j8?=
 =?us-ascii?Q?QdxnZAus9feeNX7se83ZhuI80U9x/JzNBEpCkWJBgmzJH3xVSVWLii/LINqU?=
 =?us-ascii?Q?nP9QfmNDkoOMHxs1pBpgEeCggkPBbJu6VuELxW+tFpEtUyqTEW3PCjQjEEfY?=
 =?us-ascii?Q?tFyh4X146paiwvj9NjyOnTgaAvO/SdI+4uFevW98RmXIZIggQL5q4iWnKVUL?=
 =?us-ascii?Q?T9h/VluY6pSo3hc8ZXNVQtBA//VjdDvzW6f89OIitFo0CMpqJg1tV5PkOOzu?=
 =?us-ascii?Q?2bcSgxipza8d17JlP9kESgwF61cAb9L47o8py8IToX/kSlJgccEtDLJ2wYUr?=
 =?us-ascii?Q?dHnDFfiOJZUGyoGPO2V0IjuOWdhnzLDW1afnnSbznXQrRZzKdNajCHouzcee?=
 =?us-ascii?Q?NuSzeZuBzRT8m2S3l9vqvqRj917LGQqrQWsjUT2nr43GFgyut0AQCye99w+J?=
 =?us-ascii?Q?5l02ze6YV5gIutZe10d9tpKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56def0d2-755b-4605-b3c3-08d8d9126049
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:22.3336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVEe84PtduYRBfC7AfitK/PnsCTRdO8SVWZpd1Cs8pa4ZtcKP3fUMkl4CNuR5nZGZRXQiLk2e3epwIAC+fqOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, Felix Kuehling <Felix.kuehling@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Disable PCIe BAR resizing on A+A config. It's not needed because we won't use the
PCIe BAR, but it breaks the PCI BAR configuration with the current SBIOS.

Error message of FB BAR resize failure under A+A:

[  154.913731] [drm:amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Problem resizing BAR0 (-22).

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.kuehling@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6009aee49fa6..53c09aa4e159 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1249,7 +1249,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
-	if (!(adev->flags & AMD_IS_APU)) {
+	if (!(adev->flags & AMD_IS_APU) &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
 		r = amdgpu_device_resize_fb_bar(adev);
 		if (r)
 			return r;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
