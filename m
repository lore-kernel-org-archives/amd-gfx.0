Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D47C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AEB206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L36ue09z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AEB206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E8D6EB19;
	Fri,  3 Apr 2020 08:03:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4805C6EB19
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 08:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwcRWjVaUH4mFzus2ecUYT4Jx4Rolmb1a/QZjfwqa4cXxopzV2GaUeug27etQpPddRkwGfp20IR43kMfHPbhydEfIkaHJYJGV9DfYmJhI0KxC0wfO7sImHcR1UzToYDHuUT4TZ4gVcGH79gqZugxQKp4zHSrke+QiksiwgEsq5QGwziZcAtp2bLNzMiavjnA86/+bTxEOYgFJ/X6Bdm7Z0n8mcVMfzlZAUuRpMwy437a0BCiI8c3LFzoDU7/Ch94XvszLDjAnESF//ozoU0Wcgl3iW2ndIn2E+c68X6lkwuEBQ2ThdA8KxJKIimGceGUZ5bsQOmXmU5Jty8QVfSWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Dso3yQH7IiSpATueDgl8WfllnYVaOQy9fItSCw668=;
 b=meVkfEYiMirj+gJNofcXw/UIwTBUAiZ/QgVC3OKxSEGLkASE34WI7Hl4ihpr/+BgzzP01oW0nBUU0dOh6rhDEIaqMBedDsbrGS4a7/kSMfXegucGRybHsj8KDprUBPQv1ZzV8Qs8Hua3XQMlGX7yULOb7DekooQvl9Vza4uhyYpX2gf8TWx9IHK7RugBOcXPgJYSWNifKNB0o/Bre3wUINq5go7h1xeRpX+AyRFJfSlMlRKohe/708UmkpLDmLOZj8weCGit/LaC+G8VDd4auiLG8b/QUzbXmdk94OyuFULG+q5cA79Jm6iwwtG6I/SY6y1GtV+IW3nGI5/GlJyO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Dso3yQH7IiSpATueDgl8WfllnYVaOQy9fItSCw668=;
 b=L36ue09zevwIMqi8V+FvcxgFeiQCKP04xg6RagivMNj7uj3QO7XTWJVtU30NGs0uzu2G/3AVc1mLuisCqWIk9Lk7KSh3YVlL1LGXAtvj+Ilp2o3ROMndHmSEm/wCrQSZt6WuPFD9be0illX9Rv6l3pzVov8EoqzkEOJsqMkZqQ4=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 08:03:23 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 08:03:22 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Topic: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Index: AQHWCXUrB572PirNtEC3WMTwnRqRPqhnCbfQ
Date: Fri, 3 Apr 2020 08:03:22 +0000
Message-ID: <DM5PR12MB1708D61DEADA9EA2D753547584C70@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1585890173-10429-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1585890173-10429-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a39f950d-9053-4bbc-5355-08d7d7a57aea
x-ms-traffictypediagnostic: DM5PR12MB2439:|DM5PR12MB2439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24393D6F6937DC95802651DD84C70@DM5PR12MB2439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(966005)(53546011)(66446008)(64756008)(110136005)(7696005)(86362001)(6506007)(33656002)(316002)(66946007)(76116006)(478600001)(66476007)(2906002)(81156014)(186003)(45080400002)(52536014)(5660300002)(8676002)(4326008)(26005)(81166006)(66556008)(71200400001)(55016002)(9686003)(8936002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xew0qXkOWeBQ1wFxj9XXoDRW36Ff5xaL+affInmbFoLMd5Ia6poGJoV3/IfaEjABvBcUl9+8GY8Y6ecZ+c+dE0EW7JTi6/MuLWc4ckk2DUxoZakkNyTTvfVEAeQ/HOdBHPl7pde7R3qfnHq1tcrEa8wjIk8eUFZY5nay+v+AAnwCF6qxtHmh8HUTKihUhA0Lh0UOuRpvC5fCW2TtvH1OIp661kd24BqpSVH2bU23DiOJin7ltGEnzsL2CaYipajTkevc7SV9eaApaSN6RkDPZVvb4KY+6uebuK9wKmzKfS8PnLuAa3/Zw/TBM+PFtRmf6AaQVgZ8f9x7xvWbEW4xCLjvon9yAHAsTYO810FbTF5oCRe00i1tQZWQs8UI1qKZjhH1+wY07+M6R2AhaLNWZ5kUiIeQR+P5gPs6B68SqDqWbWz6Rg89z9JF/dU5xYDGBGYHFF6eL0xlmF/Okf6hkKMbkRniYgwo5oSu2zAACzI=
x-ms-exchange-antispam-messagedata: k1aYd7VF3WPBRkQqEPK1AlYFKL+mEBlyh/dKyK3biA07OqJ734l9u+eIGZtDjpJ7FRJg9ZQ1lsvhApZYtDDIu1K9wPKnkVCSMleqYjFCZ3zjoHUH0nF4JUQ7DksUBdfHnPozGitaTj25Xt4RIoC2cQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39f950d-9053-4bbc-5355-08d7d7a57aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:03:22.6418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXi+3A5cron7un8wtb/vYqk+AIbVoYgLiH6A2F8RbdPIE0LZ75fICrFY/RW7dVZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Friday, April 3, 2020 1:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those allocated memories and get memory leak.

v2:add a bugfix for kiq ring test fail

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 +++  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 4ec6d0c..bdc1f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,6 +543,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
+	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
+		return 0;
+
 #if 0
 	unsigned long flags;
 	int retry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2..c2562d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,6 +541,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
+	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
+		return 0;
+
 	if (adev->in_gpu_reset)
 		return -EIO;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17..e3f7441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3854,6 +3854,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C8506d4a2f5034c8afde008d7d78c4a3d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637214869899102590&amp;sdata=4TK7XVJvnPMtMc8woS8KL0xJvuxs8reDu0%2FQEfOpu9s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
