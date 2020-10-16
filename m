Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4DC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F1420848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="21H8nyx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F1420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A7E6EAB5;
	Fri, 16 Oct 2020 09:22:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F676EAB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdeFJHiRAIAIFY98aQ8wJt5+5wcgWBOmPpkObGIrCNGrFajbFG/LJeY7yE6KXAl3npALXXdof8eyFngK2LlVhGCWRLU6UGzhLUwayWxAmfO5ngXWnVsdkI79SMavUA8z0plMKCFfeJekEBF2CX1U+Nzp3yCMg8z88DJUN7Jxn0k4bMi/kFgWzc9nLzd81eB+S93u7bjKdROGa3LiRjyI1pcnIc48/jTnFvO/V+him7OBVHIgEZcIMUkymkW2S4a+NeqHjt3aFw1DRs5we2yIsVe51NRVB5Id9mbNDlLzSjCg1jdrYBed2z9Jl3t8+DRFDocvmJwqJGYHBPuanp3frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtKjYNviW4JFQMqJheaZPd7xyoMqHVaIKOooK5HPue0=;
 b=cxpAhnfUUuyBsbsSjO+X44mUbd+sUypXtvhgqJSIJKEGHNTCa/KPgujEAtN3fd1GSAnqqU74sGqRS5RNDPY8rysoOLsKhfxym7m/V2BIMTG2xtbC171XXOOQZp0gyWZssuERBJmQJXqZ+OZPjhjUmsk5XD9LJs/+rEC+8kLtDNqyIXXT5U/KcOCfxti9ej5B/vUJDl4hmSCeXN6MTGRqYi+GBksYgkz1pM/nGm+OXYZ4EAh2D72yrXaKGpgQMwZR/CU7RMSXpRVz7EEf930+c/RYfIlArfOfO0KVfT7RfNEm3H+JS5nZYLyvcJilyOpGGzu1ZRpxQXPmnnpSaOgeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtKjYNviW4JFQMqJheaZPd7xyoMqHVaIKOooK5HPue0=;
 b=21H8nyx1LC3anURKNpCUoLdUJApvFVGmpk87eQPW/gcbnBTRUJ4TIGFhLOG+5tLNdlIc0CQkW1HSZcWkPcAoiKV19w/cq1zxDfnr3u2fTHsqdq655Ky/yOD+scNDwz14C4Q3jv3UhFWuI2xFmkS4xzhOk+ew0h94+tDaKn/TK+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 09:22:00 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219%5]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 09:22:00 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: fix reset support for s0i3 enablement
Date: Fri, 16 Oct 2020 17:21:43 +0800
Message-Id: <1602840103-21053-4-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
References: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 09:21:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e311649c-7fa1-4bed-b1cd-08d871b4ef89
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3128C03955D0F9F22C3E9295FB030@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSLjerRuN4ppmd1RRL4Gv4o3HEfBHMymzoWZvpo/lsBNJXb6venyRMbuGZShnTKziVjCxgV7i7Pv1L5C5zmw8jVBsh68uB7X3XLz/bi4UMFHeZjDjaMFqcQvdBKG1fVp0VZfxLzxd5h7kYLV7T/KEBsPDhUUcG6gZvQAMekeUJQhJAfvofC6TIlY5Jl6YTRGzQxEP7Olt1ta/MJ6HgBGqZbhZdSP8NxWvfZQleI+wPjInYiC5aABUqdxNlpdizfLTBqMjJARl+KbXs3u2SmOFY14bi8kdYUSRJ8iPAbiSwyDJQdNJVEeS8xH17jJkEUhDpgl10Kosw4Y8o7THy9ZPiOBfebRXyyn7xKQt8Q50APxxzB3PmWDU5p4N7bYf+3y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(86362001)(478600001)(2616005)(26005)(5660300002)(186003)(16526019)(956004)(52116002)(34490700002)(7696005)(6486002)(4326008)(66556008)(83380400001)(8676002)(8936002)(6916009)(36756003)(66946007)(66476007)(316002)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SRIM2U5b9QCiNlGKSuQQpULNKI1GuMZ3WY8oKbG1raxhEqipG4PkAlhoin4x3VUXGW+tDcnfZ1M73ctuwjlUI0wElI9BeFTKuuMf5R/CC8SyMf7YTtunQ8/WUxRMOI8+t+nGc9EpEO6JvND3RC6UHse/52BhiYhEM76p3NcBMMK4Dp/2n3r2Mp3cUZh3oD7vWipd1mJ0wvKZNnjidMRYDv5T6ZbB/83+2YxrF2I9yYI3xMdis4iZtV9ZbtGa3FWK3py/asgYITpPHDyL4r0gmy6q1PgQ85lJ/HB0YUJQdXCtdU2j5hJrL/zmbKCXh0CqIzreRYzmq9qwKQR0ZmCUzhRkKGQlPZ9uUneEPXR7Au25X/E4XlYzzRFsjDs2YaQSiE50xDpyKkTS9/7P74tBJiFSFwhF+H6Ss4HARlINsDmRvhyGA03GA4xxrgX6LXcItKHMCOkKPGSgWJwltC+pq8vZSIUsqXKLnYiblATCbqO8au/6BWHX+TVWFvJwENEyXiomamZCFyg8OgwOn3fAMJ8P85YlPqk+GOKDULy1KvveADihygs9DyYqBGpcDXyYLQpNAua9wFP5kGRgG+QUjlCy8LxYU76sKt9WmTZRmWHlKta/2UkpUyo1IkWBmvn0rjtYXpoNqd5zHk6xHwf1qA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e311649c-7fa1-4bed-b1cd-08d871b4ef89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 09:22:00.3173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELcfuFX66whHPsO1dvwIMfXmL8zyrrhL6tjE75DwQscY5oxfMZ/aric/3s5wDjLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update amdgpu device suspend sequence for gpu reset during s0i3 enable.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b16a7f7..ed44971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2432,7 +2432,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported()) {
+	if (!amdgpu_acpi_is_s0ix_supported() || adev->in_gpu_reset) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3461,7 +3461,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported())
+	if (!amdgpu_acpi_is_s0ix_supported() || adev->in_gpu_reset)
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, GpuChangeState_D3Entry);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
