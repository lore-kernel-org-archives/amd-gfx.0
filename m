Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16697C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 05:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D412E20787
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 05:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TQn01GV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D412E20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE1B6E1B3;
	Fri,  3 Apr 2020 05:06:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE9C6E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 05:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFy4mKDNNJHCGO+Bqocf8aw+b1mBxGuewUY7OuOgpySpF1H+eBehcg9hINyfjLAipro4VWfOxpOZr3TAiC84ObSYdlsM+9dfLgNnYtGOgYlwqs31OBh9a7w/N1oO8Ln3Alab2d9ld6DZDUOgpAERIPYIdty+2aoGy4eRxPW6Td5jGqTOcta3M84grQcq3pA1OFqhTSZmT2hMxWoaUhlJ43WnaThBcPUAp6yWfKaz+AKSoLsMpwAqpm3AAIsx5rTyYOwnYSENJMH8HUK3OSKdYnMlQhuddn9v21AC/uZyMvWuPuw0SWhOCzcySOpSGqSjZQB69K0BNiS1z/TIex/Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnp3xTWA6IsuwsME095qCw1v3vx2T6lQK8TWWVEudOI=;
 b=SZ2hqG1qhgLaXinPJu064RYM9VKTEpCqrtqv0/RAvqi9nufpls4tKNgIk3eKcawge9jDijWQU322oG6/4eVSQKu7vZDo9+zvVihadlLM/BJTugLr/uKTmPOnu4uAstqVSN0NH+VE+lGZqe6fylp5dPixqUp7ax+NxAsP+naDf73v6FZ0qHaPAmYT/avUV0X/JGJYTgHY18dmjckV0I3ab21LkQRsRolmLp2n+1wnq/gqRTl2UVYX2DHtJOM75KTcbM9OuzCsQA1M2xRnaU/YQN2TEG7qaP1NEkuL8egR8chmzuDVfvLtAyTpo9wTSGjFrO4KYC9WiIU2/vgYokXdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnp3xTWA6IsuwsME095qCw1v3vx2T6lQK8TWWVEudOI=;
 b=TQn01GV2CawddPpmLklZp4un/KtPib2I0CTcjnq91v25E3LK/gu42SIkGRk17IpQb8Od8k5fiJ7KED7Gt2TkGwSvs7Shp9j3iegddU1C4rDjo8UQ9tkGkjqu7BvNu/L0/ly+dzOIm92FM9h8GquMmd+UZQzdM0a4oqIJ9AG7saM=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB0073.namprd12.prod.outlook.com (2603:10b6:4:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 05:06:46 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6%5]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 05:06:46 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Topic: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Index: AQHWCL8uh4cpltSLTECyMztLy6BapqhmFgUAgACrKICAABhUgA==
Date: Fri, 3 Apr 2020 05:06:46 +0000
Message-ID: <DM5PR1201MB020497AF7569522DB1C4DD2ABBC70@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
 <fd3d379c-41d2-3626-6785-a2466d7de582@amd.com>
 <DM5PR12MB170815B08B429AEBFFDEF25784C70@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB170815B08B429AEBFFDEF25784C70@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc09a9c3-047e-4a19-725a-08d7d78ccf40
x-ms-traffictypediagnostic: DM5PR1201MB0073:|DM5PR1201MB0073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0073AF883DCAB60A74B03595BBC70@DM5PR1201MB0073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(53546011)(81156014)(52536014)(9686003)(66946007)(71200400001)(66476007)(64756008)(186003)(55016002)(76116006)(66446008)(66556008)(26005)(5660300002)(2906002)(316002)(7696005)(8676002)(8936002)(6506007)(33656002)(81166006)(478600001)(110136005)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52Es6QQmoz7x+izlaz/0p4mE5jLLQtHwr18geW2xz9MDuyXtEASQCD/zpFRylA9rkBYG9yY/2JeFlMDHJcfJCwrLd1FAEy7ljGT7aFr+3v6D3H5HXYv3ydxisaHpOnvzrm/n6f5qmIkGFXJcv5JNrrPJ6SZu6p8IKRy0X+ex4JYSb7x/we/D4WLtjwsO/NHhyB3mOvLNJiMJB1v/sVfrQA0MT2Hd+QN9HcGS0BOaUSm6LzVMz+zLbgnWJv4BWLeastsv/hYGZOVmjueoUdW0RN3leFaF5W5aUTqKIA8XT/fL6iqEODo/ugRNnVQIVUeVP5VW/8zEadOVVurvR+S5WGS5N/XShDDQ2sF71jhCfINSb8Vlea3rNVJDha82u2PVw56yOr+7vsZNKYiSUJ5AuhL1F43B4ZcVtdvaqkylxZHByn+GmkL6N0hTc/fSgl0c
x-ms-exchange-antispam-messagedata: EsdeJ+HxiKJxBcXBQzVFvBpqUE4TmRgY0whIJUxQtKJRlVHDpCaTx9EPsviImdsPxNX6f5Qb+wKZpEQblAZufihyHHhc2LCR7GxiMzamDnRjboYA3svQWcy24II0yQIKkGtZbVgVlTN2iSESbNbA2g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc09a9c3-047e-4a19-725a-08d7d78ccf40
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 05:06:46.7405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAcwrPhUtY49Cok6XvKOD8tEIw2GeTdPAxD3RSt1w9pdGNgB5fkvhXa94fkNR5os
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0073
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Monk,

I just updated the patch and it could passed 1000 rounds TDR test.

Sent out an review email.

Regards,
Jack
-----Original Message-----
From: Liu, Monk <Monk.Liu@amd.com> 
Sent: Friday, April 3, 2020 11:38 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset

Thanks Felix

Hi Jack

I think below changes can resolve your problem , we had this on our customer branch already, it fix the memory leak, and also fix my previous bug .
Can you make this change applied to gfx_v10/v9 ? thanks !

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 29749502..532258445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,6 +543,8 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
        uint32_t temp;
        struct v10_compute_mqd *m = get_mqd(mqd);

+       if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
+               return 0;
 #if 0
        unsigned long flags;
        int retry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 35b32ad..f6479e1 100755
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3653,6 +3653,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
        if (r)
                return r;

+       amdgpu_amdkfd_pre_reset(adev);
+
        /* Resume IP prior to SMC */
        r = amdgpu_device_ip_reinit_early_sriov(adev);
        if (r)

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, April 3, 2020 1:26 AM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset

[+Monk]

This looks reasonable to me. However, you're effectively reverting this commit by Monk:

a03eb637d2a5 drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

In hind-sight, Monk's commit was broken. Removing the call to pre_reset has other consequences, such as breaking notifications about reset to user mode, and probably invalidating some assumptions in kfd_post_reset.
Can you coordinate with Monk to work out why his change was needed, and whether you'll need a different solution for the problem he was trying to address?

In the meanwhile, this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


Am 2020-04-02 um 3:20 a.m. schrieb Jack Zhang:

> kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate
>
> Without this change, sriov tdr code path will never free those 
> allocated memories and get memory leak.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8faaa17..832daf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3847,6 +3847,8 @@ static int amdgpu_device_reset_sriov(struct 
> amdgpu_device *adev,  {
>  	int r;
>  
> +	amdgpu_amdkfd_pre_reset(adev);
> +
>  	if (from_hypervisor)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	else
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
