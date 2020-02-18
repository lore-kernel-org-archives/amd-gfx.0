Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE243C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 06:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640BF207FD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 06:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pE0AcfBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640BF207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1E96E12A;
	Tue, 18 Feb 2020 06:12:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563456E12A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 06:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdTcG7/AHi2SgYf2YZ3wbBv7146s6XFKQ/ZKXOs682I4be6F8lF9nUChBgbvOhEl5vtYWUqR9VSREkXWV3BIlRn3Ikq/z2IqKRDGlR0FDbmC7BDESM0BZFg0RRlnu72Cuc2MTCR5xfjBNh6Qr45dw76kO48JhDLSvP4kFqjyBh75J4F5cHEhLe2vtiUjNyOpMbfQASYd1krnk5ma9WBbQok7+fcqRdO+CLRzaT9OXlF4Sn+XN5CZtUfiekEpMs2sJJ21CqwtrKaK+ym4ZjbQXfiaDuOjRnuHme2nVWQo94QkhcIuT6oWCCgz0AJCjc74gVjka3S9KyUUpg1IUA2n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDGLeeSfsJ9YhJSanp3deV+KZJeG6JKEvov2/0IWvMc=;
 b=JxDgnzBDpJnP/HdtSjzRMRo075oGRE5yfMVUqO3B0w+vtTJbEG4GHEBrwsxW/DbmOHahLISWmQ0goXhdAePz+WSlEgenOgFKby7m7cXgdPJ6NFtmQdKtbfvPdCbFg66WpOQBBqvYeDNaQlvGGpD2KnmTihDwnf0cj3L6I8X0YhRX6T8R7wzBAaGqwpOKLaQuqTxqVb7xkWTffHfMWOaJJzjJdeCyinDVMr9nPxr0qLUUgbpx4Z+s02Ark49melA+dh+ZFjUBuNUv4VYnrcEuBkRlEai4xa4/9DH6GWtcydYr5p6a/VydpU0BwIW7rgS/6wc6/km202GgNdDmzS7IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDGLeeSfsJ9YhJSanp3deV+KZJeG6JKEvov2/0IWvMc=;
 b=pE0AcfBosKumo2ombH0BcC+mytDUKRn68cnUieBpfIKvRB7X6Eyaz218zvpudwN6PqiYoZRA1NwOlWRTfVzuahoEDZCJYDpyzU0Ik2JsvSgxEWNPqZNVI5eVH8qdHjAS6P2eypdDddcvzscQjR28AbFWh4KEjXn+AwIXrkENXiA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4061.namprd12.prod.outlook.com (10.255.125.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 06:12:52 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 06:12:52 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the wrong logic checking when secure buffer
 is created
Date: Tue, 18 Feb 2020 14:12:11 +0800
Message-Id: <1582006331-32356-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 06:12:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c8eb78b-3bc8-4cd7-150f-08d7b43995f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:|MN2PR12MB4061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40612BF8130E7BCBD4E88C26EC110@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(54906003)(4326008)(7696005)(66476007)(956004)(66946007)(66556008)(6666004)(4744005)(478600001)(2906002)(86362001)(316002)(8936002)(36756003)(16526019)(2616005)(186003)(26005)(6916009)(5660300002)(8676002)(52116002)(81166006)(81156014)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4061;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3ydjb+zO+VJPaIOTmimX/s72G6jl+lq/zK2b9vO0lhYTnyEV+pgmnoPCMaF9/l1OLVzSylJKUKfmaGSLFVAjKY9sMpLfPl0xToHJ2kT/yb0rzeWAnhI6ewEZwP+kqlNtpKrq/xeCvnzi72wnzeITCYSxml5oJDQ8NEW6IG/3j9sMbPkLWZALK380oIBaQ2UQqUdvte1BxY9GCKNrdCwKiaUXherExDm37/HZAMVSXBsFIKmf9rWl8wlz6erXn627C8OZA+4rupaw5/CbKX6YR2lH4ggpiMPva3/h8hWaw5FT+P6cKQ1yT5MGrGPU8Di5pDau6ulcPNHf7I7nDkf6x6+uUPBltk3o+ie0L7+rXYdtOVjyeGFY4zztr2/+YSrjfAtqCZIDh0UwLLfpdAGk2oAs6ynl1tXH3ZJF3mDnatcGwWwg2d8KLKcFLR8kmzt
X-MS-Exchange-AntiSpam-MessageData: y07BrGuFaaVl8CVMDlqmW07rOqq5RoD3mYuM7MZbcjfhf/KBiXwSLJvnWgkUmx8WxuoHGc6uRCMDK76bJyHnKkjoipnZ+4t+Zb/EZi9MECFblzOVkHqe/3IJkdG8qJ1u0PLd79ejkhAK6062Lc289Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8eb78b-3bc8-4cd7-150f-08d7b43995f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 06:12:52.3307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQuRO9oUtXS6VjVtDu/koWHo4NIJdrZrHf2mIfFp8LL6dusAuSita+OAFYUC+tuw+ibboJBjReZPI5ixzv2JQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While the current amdgpu doesn't support TMZ, it will return the error if user
mode would like to allocate secure buffer.

Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b51a060..91e4235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -235,7 +235,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
-	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
+	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
 		return -EINVAL;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
