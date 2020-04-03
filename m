Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B927C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 03:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAD220675
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 03:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WBHX6X79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAD220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA606E1B1;
	Fri,  3 Apr 2020 03:38:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA026E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 03:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdr1mRD6zV93WhlKWIIz97d6GGFKzzH/S+qKh0FkrJrGK6BB8KWVkjXN5lP80lLUXbZEk9POcazAzmNUvUE1tcHTNy7vUDEiz19ByZtMK5qrYBk7nE00J+zmCzsf3CvXafJw5lENjI1hSdlmvpKnz0g1igJxuz9yQfUrMH4HYeeE6mIt9+4cLSB9iaFWWpoLYwr0M02TvUHKhskb4cBSrKU7StMJDIuc+IvYcqtYuY4sO7RHjvqPLNJBB49EU5G+k3amk1hI7UJNWuQWiDL79tFNAKHxNvx7buI8DCcORSGTUIPyj8EurzoyBNeG+crPJHjTWt2bHNjf7RMkM2w0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCVbE/uCD6rJGEUlxD2CVnHgUZqBZEjX1MQthqDJYMs=;
 b=OoFdetFzmI3tJ5lpj7fvt4HvY9JdZtub3b+fGFvJttgkhaCD94ime7DOwTkrKcB3uG1ntJmii9JsYM6SWD0KXxp1VuIMNLRykBlJC0s4uufhemF2wg0qLUjqc/jpypnMWceImwJIcvlpccdqrI31trZ9jDIzO+OpuTGAjhPWj8SDOAb7tECzK/MGB8EDqKnTnRMNoDS1/IyFNTo0J+2ymVIDlsZ/EKy6/UxYm+/p8wCli7aWolwfWEY6udk4zPXGl6ph3+cFt/4+q8TjgusXJ7LfsugbfFRcdpRY/lQ5KWPDdpj97CvwiSyUoLZy5pgXD4+pmaTQnyr3pveRwJq8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCVbE/uCD6rJGEUlxD2CVnHgUZqBZEjX1MQthqDJYMs=;
 b=WBHX6X79KudQLGlKj4WBdgkDUR2j4nNK5w71/ObmcGc2unZSb93Xgw2ZO8UomqwBRRWAaYxh9pjhkwPpYpB9btnzUA9RisNw1osYPNrUPt5ix4dXRJto31VJcgM6zAOUWQEySQ/cciz3j2GuTp70vAwbJJeyxmJX4XM6ajG1unk=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 03:38:27 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 03:38:27 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang, Jack (Jian)"
 <Jack.Zhang1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Topic: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Index: AQHWCL9NFsLX+xcBukmCLzf9tj5R3KhmFgUAgACqsTA=
Date: Fri, 3 Apr 2020 03:38:27 +0000
Message-ID: <DM5PR12MB170815B08B429AEBFFDEF25784C70@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
 <fd3d379c-41d2-3626-6785-a2466d7de582@amd.com>
In-Reply-To: <fd3d379c-41d2-3626-6785-a2466d7de582@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2951a190-c048-4896-c64b-08d7d78078a4
x-ms-traffictypediagnostic: DM5PR12MB1148:|DM5PR12MB1148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11489DE4592914FE26A919EF84C70@DM5PR12MB1148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(8936002)(26005)(316002)(2906002)(53546011)(33656002)(6506007)(7696005)(52536014)(66556008)(66446008)(110136005)(186003)(81166006)(8676002)(76116006)(86362001)(71200400001)(5660300002)(478600001)(81156014)(55016002)(64756008)(9686003)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CH6WJz6N9+jiiRDujy4EGfxc5A8XZxSNDgA4a5u12lnZEkQpT1Abz9/lzG6pAMvkvBSG7Qmo1GK0123iZHNSn7glm5nNxOtL0yQFSKXvjqoJ+GX8Wlu7QPgLnPHh3kovf/+6+jhh0P/UY5y1AA8iA6gdd/zrjX11kAKqY94Y1ZCTJWNrY3uhzI3BRq8yJ6G10fW+1i3qjaJVHoCO4Oia3CUtcHFXqaTP7A5NgEwRfVoe0JKMv3WqWkzqwS+qxFjoVNl7tkcbABWVBMXS9Eeb5rs4i/GyUe9898DHbitUFsR9FhONKEzZ2LjnwgIocgFxAesQo2lAvKdA1NImzSogMQff/wQdNeR6XOrvfNmP8ABwaYejYzi+7SuZKj+ATrc3CjZprZfghzPe1NMEQ+dqs8C53K0SY8pXoUFrvXIDmyXzc2gTs9/FJfixMnrEl9NY
x-ms-exchange-antispam-messagedata: bFNb2fKintdC1QVmkOSU0MydIIOqLKgPt4GX+5UMzoqmeH/XU6RicFUnKSKCpDrjYdx+YXZkRpU1baA0SwmuECZoCQQW2qgr+6iKRJ22fX32LMy4Tg7EgRa+V4LHSIciTCHaKqMvrx2MVR74Pzn5HQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2951a190-c048-4896-c64b-08d7d78078a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 03:38:27.5195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNJ6Ngq/BfNDYWUDAsrkgisFKpvySDe6BDZTRkXKd5C3H7scXmF5BV6vcZg+xvHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
