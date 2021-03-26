Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1183C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B05561992
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B05561992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEA36F48A;
	Fri, 26 Mar 2021 20:58:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419B16F475
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 20:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEAgBIv9sI5hQfhOzUVfIyalD8X84edRCSkzBiPSUp8fmEgVvg+jY51Z9IsM7MaBHqlGefL3EE55EEPAzs5QyCiQbwokEM5N/diNVzKCnmVZ/cAlnqjIgTAqmBeaWg9nEyHgkLP2yCaI6LGd3hkaR/EPsXgXoJOj5vOJmcvL9rRqr8SFc8JPZBagiPD25xiCzYk/UJwUzc//IKel9DfIxl8vAsLOBcdGlOM/F6qKwoeOmgx6VfydeSeatI2IHq0g6ak60HrSa4Pr+kA/WelneICnhHcUbXYTd2uyp49zjiQM+5aHf7awLvl1BB9XCWAO9tousGNTGC4EY/2KDdPLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ2tSPFEaq8sYtzKtLhI2OGBf+jMPDbXNmRYF/OyZBM=;
 b=OcY6rucE8rFZVFojHVJmLaYPnyoOm3xjlBUR/bgYHuafmLpjGZ3uSoH7EAYZIzB2Xlzlc6YWNXa6kelrpRFIFRjLAHHYvGI+woEjT4gA8xWKEpJJMbXiDpJEWvTE2yzR/BoRtA1hB3DIGZK+yu0FzXIqJBVvJVYhd6Lx1qaEj4V6i9YLCvh5lsJSywObJVmi3bB6RbX/xLynkMHCq5wzitcB84xDULrTy4SOa3ZAw94kcjqjMIGuSPVcjynmHWaCRapWaXZZkAu9imkLsWmGoN0tTNmbHaRGhEu0eSc6kxMAMOph6sV9KkrTg2Ug/AIAXNNscaUaIefdL33BP0aEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ2tSPFEaq8sYtzKtLhI2OGBf+jMPDbXNmRYF/OyZBM=;
 b=tRMqcZmr6MCcMPg1y+3+VY/8UUn759IOZ68/fgEQRs5/FZvO/OKkcqM14HWYYGjARD9l+6lWTSMPa+1fbUbh9FqPdXdWBsIohMsdxJQnK2Kx4YZXo0gcDaOaS+2CluDZBwUb8H90kv33MQ7j4NvLKoQ45bnUUf3sZKrxjTdvxtI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 20:58:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 20:58:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vangogh: don't check for dpm in is_dpm_running
 when in suspend
Date: Fri, 26 Mar 2021 16:57:35 -0400
Message-Id: <20210326205735.1324461-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 20:58:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76f6abb7-e3a2-4fb3-25f8-08d8f099f751
X-MS-TrafficTypeDiagnostic: MN2PR12MB4407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44079CD56CD0753E928B34F1F7619@MN2PR12MB4407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMFBpDeJCvGRaAF4IMVRoLpQRQMlgNnVGB4S47afyRxdFJ2xx22sj0+MqIqClaBfzL7XK9QyOQ3qPRoZs4Q6TdCGJYSo+Z61jXvcs2vuSNsXP9C7+pcQPCZEVmWeayQ8+vToV/Ot4ZTE1LgFETz7wk9gyjz415Kfe+2AiTWSeLx9hMUXT1SwyA78AqJZ1tFHrvFrMMaA+18G5khWiWXjbPZ+ab22l0VPEW1tSnpUd99vmFizIlvtZ4Ba6iqlP9hrZU6hTgAY0QLbrcXDlLM8RTS/mA4DLgZZH+fliSD7hb62tE4udhfS+m5qlpLea3cMhTlVmTWyA9Hiqc0a7Jg+7OP9AnlBlUXrka2kVVTz69OHw0EDvQ/B1hyhdP9k/oFEA4uVY3En0eA2VLUb+FXObw+ySEkV5fIRrCUwQoDnCamVBprZ8eb3S9NK/SXzcMf0UluZFYtgAfnihPkgW0H+plhyLSIx1IAAAwJqBdadKCvjTttIaEgS+tT0falIyHIAsCs0sxR29cIVeaiWa4KKStLA8cCS8OxOWvchwnYOGKBPq11Tacsoacx2LEjPRdVmkLKjKTh4xnSh92alJODNA/lMYyOzi0BHnFoJVVnAjV2Po8l+qC7asl7m9gipMVjpVQt0J37oVGmR3YJX+nCbhs6Ye3r73xndT6kAmtdRCA6eWNtZOUFlB6P1xdQGyDNN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(83380400001)(6666004)(15650500001)(4326008)(8676002)(6512007)(8936002)(6916009)(86362001)(186003)(66556008)(66946007)(36756003)(26005)(16526019)(66476007)(5660300002)(6486002)(956004)(69590400012)(38100700001)(2906002)(316002)(478600001)(2616005)(1076003)(52116002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: w2rTiS4dCC1hOV1CeUb+VitCgi2lFWZJV4t07/rIrpvBEvp5CZAReoA3XWx3FficTxUz0hj5iyd//me5Q94B2vVC9Cl0URdFONUjkfcLZUMZJlGJ+kw3EIJs3qD/mGCPwLf3PuF22HwZMb98FRa8r0rMx60Nc7YrWNGqvtIYoBUsSh3uaMZOhN+G6pniWQ4Rw820Al1lgJ1laPDmJmSPrcp0bgOmaLveoNcsxANsv/FdJqzK472qRCvSpNcoXAw2Nz+OHGkfl5Ll7DX0+v493IHUyBUf9q+eArB4cHdC+PoVOG/dxqLcrKksF7ppiNLOeBeZfe+JzqG8RpQVwgQiR7XSwohXSpznqtP2YgRA5mO/vkglnXyc+e1hyq1clwBGtrMasH+hs6An/wC53iE9vy9Cj/jOZ00YQhNz3KFSPEJvzV9wuUOyc1x6A+52Wijs6WEC0AX6ke9suO3OsPUT1B+8Q63wXFNr8cKmN/OL7i9WZ1sWNBwSjNJzfFAOaMoMdtj9W78LXYs1pj7zdajcZqnhzidJm6YlT+BxYSM10+rudgPBT8rZaKMo4iR74RecE5TlbkqxS5MvWY5qOMVF09INRm2YdE+YbUO23Zj1kJQfPcxrWaOzslKCJQKf56pq+wYRLzhDsnR8aImEN6P3ZOI9zLr6KCQV1unwq5e1CeB6qhFEXQndWnuGfoO5cTo+RJApQ/S5FLq6QAuS7U/eXG07oEJKWOpk7AVrUoSGWP8Cj1yTHvelg3kvaZoPnyvl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f6abb7-e3a2-4fb3-25f8-08d8f099f751
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 20:58:54.4461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKIlJSvhroCwgRotUavde0HhQVYSyw1qAks+Q8MvwSvAHXTWGCyJkzMJ7paD6UMx7RlkGXZDdsDG1t1nSyUi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do the same thing we do for Renoir.  We can check, but since
the sbios has started DPM, it will always return true which
causes the driver to skip some of the SMU init when it shouldn't.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f502fec67d5..ed11e0ab8299 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -384,10 +384,15 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t feature_mask[2];
 	uint64_t feature_enabled;
 
+	/* we need to re-init after suspend so return false */
+	if (adev->in_suspend)
+		return false;
+
 	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
 
 	if (ret)
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
