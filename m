Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B04B64F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 09:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B04B64F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200846E517;
	Wed, 17 Mar 2021 09:56:01 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983106E517
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrN7vX2Fc+gfw7615edeCIihipzXZgpYv/dN4pJI/3nVoD0iawmqSO2DZExKeH/ngN3pJVqn2wU+O9myTaLwqu1+MH6W3ODeYynXdyh1Q3b0MlSIylBV3Vvc1X70S2E6onw2K8JzkpKA+y3Qy+0tcJco4p14ve3RfiRyeY84rVJgxxHXbj0Ho2WGcF2a81MCEAnBxRztyA0MmtY8Fxk63hvRFe2Gwyp3Kh5DFmtEkZ7NNCU+pTdLUjbCO927EoCvNdkWSne96pclXjDxkL4x7djOi+QKDswf5ZTs/hgxb3tOW2quFnG2omwOi6E7bmnLFgVVnVk+xFVdUsg9tcXhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faHoWgyEejTpc3laiYej7KfsFqCuAbwf7zMyCOEqWHI=;
 b=g/jaedTWyqpgPMkyVVswgAjwr0eqkZHkTGapxSfxCn2YDxJ5VR9iwkL9rFALGbaL5K+lrDw50hvBQeHaYTXGjKlhOKTpq34PgBt33RPem1DkuO5lbvev7l/O2HL6QxGxp6FrJCKQztbSq2k+eOSkcXurF81HYfW75ObZPXmyf5mva7OeydvTTOsYBd6wG0JUFGEfuNWlxoSs7BIzHE83/ArYLzHO+CiRYdNuqKgbKWXZtKB4Si5wNcVGmZJPIDm7wCuUCElbPFZD4G81y7Z3m+jNKUpZ2PyKFlokTBLyqGrEBKB03bE5nKwdYXtQl3tNLd1qyOmKD//gZsvnw6oZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faHoWgyEejTpc3laiYej7KfsFqCuAbwf7zMyCOEqWHI=;
 b=jW93ulO/5aKQsjRIQj49za3AH6OyXTLfS0c4u3cCBvG6r5a9UcpnoqjAXhgxeZfAu0W7E2TDY2whBpzHgP4MxX8gbWGra2ThzkxR52uuuFbZ0RknDquuY9yKnh5C8Bm6mghK9s0wcjek9YOUoqRMHFp+++I22BhsdIuZ3uyNNqQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 09:55:57 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3933.032; Wed, 17 Mar
 2021 09:55:57 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix memory leak
Date: Wed, 17 Mar 2021 17:55:39 +0800
Message-Id: <20210317095539.12309-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0195.apcprd02.prod.outlook.com (2603:1096:201:21::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 09:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4badb47-98d2-4178-3c6a-08d8e92adc39
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515F0C0D8AA2BCD9E2622B4876A9@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvVCt3OQh8u9Ijr2dhinj1H+P3hbtKT1PpIYjBenPWsyMv/zfNRRCF1+QZhlEWVdWmF9w+vZpdG2dLxNaPWuLKH4QlAtysGnnehgM+4wNBE/6XoLKEfIHD4Y4txACwO4ysbeAgv3tBgKfYlp4efk+p6EApixKX4uKr4jQn8e6Zknb8vHuAQR/OL7LwMzMAyi5gpdrhaiTfVWgUmgae3wRLe//QpTM9dMNvRO3ptjnowpg81GwCBOGGdN2ZJLxIbIn9xHCdVhhjNSbdf86mVi6/ChmMC4i/lQ8Zw+DV3GYxuLvgWEyFb5uMuYqYItFG8jXo6QlSkQbNCxTN/Cozkj3ROzux8V0p+CklFubUWxoT0aq3nzH1FYlyvHqbJacpbgHl1UUtymkSc7YiA2WBssbgOuFki5r+On5A4S6O6hoxHNhAdObxQ8olXPGDrjg10U8+NuloP5DiReDUkDxAeIuet19HdRcZRNjG9f7pelX2QxsIzT7DxLsRXqxW/jd5NTB7r/o4VPB7F3sjlsul7FnOzo3PoD4QMT9sX+3uryHjHBsxC21u6OTUL0SRLAb2VJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(16526019)(26005)(66946007)(7696005)(66556008)(52116002)(5660300002)(6916009)(8676002)(66476007)(478600001)(6486002)(83380400001)(2906002)(186003)(6666004)(36756003)(4326008)(956004)(8936002)(2616005)(316002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?M0TkFWkcvB4Ur3GLXkccAMWAUtfCSqsBY3iyOGmJ/grIa79mqs2a6uJY6OoK?=
 =?us-ascii?Q?sE+gH3n79R8BfMZbWmMLCnC1KjmMjYKN8hYwNCSBpVbexhdaXRJVeSS7vYAE?=
 =?us-ascii?Q?tbBKkus1IGoig0cnDgxeVo0YI3mP4UJG2JwmY73liDw9AvHBe4JGns5bQzkv?=
 =?us-ascii?Q?HTA9n1+i0pGrDSEvNqpAmBKP3BziVHFbtOw48JNWvIpDhu1IYP2sCJPwfQG4?=
 =?us-ascii?Q?wSPJEyAE4OZj8PPQ0XPf+Z0QCpAuWcgU28Tpy9F50YLpun3QbNanHhGHcCGE?=
 =?us-ascii?Q?9B6zuCcU/JfclxvuRo9ZJfEay1NH/S2IPGZXbhXNLf2uV6Qx2vSbxY1Uva1n?=
 =?us-ascii?Q?bhSTWPk/3ie32BhxaY9Vhk2ZXHY25R9fmB/P1pASRJMf4EpV0v4GCmr8xM+J?=
 =?us-ascii?Q?t/Oqu2V2GFHTTZjTml9jf+/DHUCWGjSH9nwBOlkewxntTKuapHWAChq1L9ym?=
 =?us-ascii?Q?jGe2pa2xA76Sun/WJJc9kwvD2tbr8Fm2J6M42Hws+Qq4mHn1pN+3Cg7FGDmG?=
 =?us-ascii?Q?HxDtV0h+i9ZcOI4KEjO/NF1AY05zVS2WDjrlnzphHT3Y7vwy3ObQCpkgSJOk?=
 =?us-ascii?Q?7pgwz7lW5zQ9Vc5LKRDQ6VjcOnfe6bfbbocEf1YlCLGb6yiIMxuM72HDdP7I?=
 =?us-ascii?Q?JDRTIKmIdprrW//WAqRfVyWvibfXHj3ylORtZ8GCHzH351KE64pJq1KNLmpR?=
 =?us-ascii?Q?RZcyquwqzRa/RxbcXI5DiaynSi/sOPJR/5x8flT9ZJTRTwi+2jpLO8nMxNeX?=
 =?us-ascii?Q?fDo85tO38u0QP4NfHPyIpVlTF8U1Ivarakci3yWmhlla6n5UlPErCmZoWYNA?=
 =?us-ascii?Q?NomsZQ6Ssa1bS+GPfm071IgBOzmzgy9aZjTudOI7EqWm5/Dh+hZdPLTf1fa0?=
 =?us-ascii?Q?9SSRXexijmTlZPe6483mxr0MWJwL5Xu23cOL9IFMopKFKxGg9/nduCxdJbWT?=
 =?us-ascii?Q?VBOCbSGL7yMrZHOL8vGAwkfL4FeqZXiS0Gr453LSlRubhP6xQ0NRO69u6v4E?=
 =?us-ascii?Q?CFJTC20a8IVtWg0Qb1ChKfkWbPgsSA/5FHamvdjmHHmpDRJhici/+CUf+SRb?=
 =?us-ascii?Q?9c4Ux8+ryM+IAmuXFrm/qBYJ3aAP7bZOYVRyzjz7JyNivPb84kYPQT1H5m7y?=
 =?us-ascii?Q?vkwvModndiSL9pljAOKDsrZiyYRshJDGqX9lVG2iTe6Ld1Mbx5NiDYzrujLz?=
 =?us-ascii?Q?Exq8+craFQ/P1AfyN6ECixt/KLFDVolQjnyKOOxI/TpBtnItLqpJ5fFD7mZR?=
 =?us-ascii?Q?C9rbo3+738uXSaK4HIMKoZNndJ/WrJBOA+UAkAXESla115YZmiHYyqukJcuK?=
 =?us-ascii?Q?W7jUQ8KzRCw1V0INFjpF4g3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4badb47-98d2-4178-3c6a-08d8e92adc39
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 09:55:56.9979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwYloeGICy3X++W979scqFEi/uohUxaJXM6pMY2FIzPud5qxLfElpWDw4Om9RJVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_gem_object_put() should be paired with drm_gem_object_lookup().

All gem objs are saved in fb->base.obj[]. Need put the old first before
assign a new obj.

Trigger VRAM leak by running command below
$ service gdm restart

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index bebed0f307a1..46dafea8da8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -955,8 +955,9 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	}
 
 	for (i = 1; i < rfb->base.format->num_planes; ++i) {
+		drm_gem_object_get(rfb->base.obj[0]);
+		drm_gem_object_put(rfb->base.obj[i]);
 		rfb->base.obj[i] = rfb->base.obj[0];
-		drm_gem_object_get(rfb->base.obj[i]);
 	}
 
 	return 0;
@@ -1002,6 +1003,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(ret);
 	}
 
+	drm_gem_object_put(obj);
 	return &amdgpu_fb->base;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
