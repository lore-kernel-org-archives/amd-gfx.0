Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D89C00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3452077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YavjHb9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3452077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD3E6EB82;
	Wed, 11 Dec 2019 15:33:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF6D6EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8//QSE6i0pBvyaBrDETnW40Prw3BtCMH2oS0ZTa1xqmYUVZ37zA16OHfu1IiHa0f2eDit4fe0sr+wPLLRdawugcPvgkHXd6R7bWxhLC1p1I9zAbwSo6FMd9PuBDM8BK03NdN9hYVCboLu8meOKpBA0DXsOMlPWIYxQyL9KCVefQFrzm7CHaVypN2K3Tf5EPGDH8KiV26UW4nZ134J8cXfSBbSslySv02rOEh/1Y4POvDubhsLkIFeYaU0NC4jNqntVGgdEsfW6KxNPqxImNP8jFU1IwWDOEZGQjbTTRWs2XyZRvLOG2ypUGNWNRAraOw0cWzyhZ9eglSHv2Ym+fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/A0R0HAB/rW/pl5fYREm6uH3X32oeQMKgM4wNVfhiw=;
 b=DfWzrqBHjeskSwwRQ37LLsvxheNx3StPCC2t0/9scN9CtjkrBkHgaJ7ERiwK3Vma7j2HaqOV/UE/mjnuoq65gCX0/FQxV1Ge7dzAwQka0Ev1elHi2xJXnz/KlRHKw7kIMcQ/XEsVua3CgifHTAVNwoXHHxTYbosGHDzaIPm0zGQcPct8qQ7ievcrp0E2T778sAVc8JdzW1Oim802jEqIGLhweXDMuEQF9aGKPJ81DBSmea8mDslxgiM4iQ9f6rjgKl1qV2dJ0EHNvcM137X0bJjVpP6jCqSPn14hfhjEIXr/qvlhe3e73bPXSw+/xcGl6OJ1QBU/DDtFAwR4LXUEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/A0R0HAB/rW/pl5fYREm6uH3X32oeQMKgM4wNVfhiw=;
 b=YavjHb9XO+/jvY4Oq1W/MLrYuQKB0A26fQqJ5yzPXp4egL6ac7RRTsLVYG1Bl3I09NCqz8JC+WtKWeLDugFC1Pz7bPrMDPQXUY6CDisTC51DQXMZpVKtmVwMIb2bYnRo6QaFLjUJEE8Trj8EpGWwXSTKkFyNwPtnN4wmCeKD0FQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:33 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/39] drm/amd/display: fix regamma build optimization
Date: Wed, 11 Dec 2019 10:32:33 -0500
Message-Id: <20191211153253.2291112-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b4c67f9-a6c0-4f1c-bac9-08d77e4f7b69
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491274784003EA21696D93A985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eznodLJ/VsiUzbVV6vUgZ1MeW1H0kbCpKMiKvtFwT6HYsI4lKubhTOOczm3hUv+/82Y1ftAoV8ylziLy0dZjJVMT0YACW2DcGm50LzcmhIA5ciIbDHhShIqPchLpCrPsl5oQH0UjZFOI7NZr67wit4S+NhdNM+p0/lBOwuGfTQfy5WJ1lCkrA1S9MCEUr7v9o8MrEzPQ/zbGfL9BUlay+I5ApHPewv02Cq7ErhT9LGAffDe2/S0k4RIOb6kqQcGJISydjcKav7NBG/L4TJ2relBfKgI8uXbH08zrVjC8VYXfpWNaGkfJsSKMf2na0r89U7O0+qD1uWo2JTOuTQTeleK3LrplAwA729UxRmYcAutem1w8ZoJc3BTjpPbcRNv7ZOiWKlvlNZfpwkFdS7RD0quvubkuB7vna8CAM/CM4xqQYTtltQ2KvV4nMXOuhIrj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c67f9-a6c0-4f1c-bac9-08d77e4f7b69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:33.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNOH1kgqVCC+sZJzSRMH8n251FKrCucdUdhqQGDfeS6LuUkG2oK65G5qmWwD1adl8gI9jqvr6o/RH1hBNkTsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Josip Pavic <Josip.Pavic@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
When the global variable pow_buffer_ptr is set to -1, by definition
optimizations should not be used to build the regamma. Since
translate_from_linear_space unconditionally increments this global, it
inadvertently enables the optimization.

[How]
Increment pow_buffer_ptr only if it is not -1.

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index b52c4d379651..1b278c42809a 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -364,8 +364,10 @@ static struct fixed31_32 translate_from_linear_space(
 			scratch_2 = dc_fixpt_mul(gamma_of_2,
 					pow_buffer[pow_buffer_ptr%16]);
 
-		pow_buffer[pow_buffer_ptr%16] = scratch_2;
-		pow_buffer_ptr++;
+		if (pow_buffer_ptr != -1) {
+			pow_buffer[pow_buffer_ptr%16] = scratch_2;
+			pow_buffer_ptr++;
+		}
 
 		scratch_1 = dc_fixpt_mul(scratch_1, scratch_2);
 		scratch_1 = dc_fixpt_sub(scratch_1, args->a2);
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
