Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1CAC8302F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 07:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1CD10E50D;
	Tue,  1 Jul 2025 07:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVvoVzZ/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C1810E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 15:19:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8DCed032129
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 15:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 66CJdJsC347ysZVqffGRFxm2aYFeQsQ85CaTAPDUfkM=; b=gVvoVzZ/8QYRuwVh
 stM0KgHz42XwKOjUM3QfToRdHFF+zW320t04nfN+DQ2F6MTTQBySdkTkPcMBiOEg
 1i+E3IXOWAVfQ53PopzaI/w6tSYugiOJ4WwOSE/PKodXoi5MydORgpTVO9hRsG0Z
 EaXZyX+Kc8RbiE+XMy8HcrSTA4WozX95OexeBv2dz900UU5mryyZcI3G3kcR1oWQ
 LsGKfklZfmnvaZCGWtCLVaNhudEki9IMSipIZotMEeYDulPSVkJ1Lmm6XpPSbJFi
 78zHXOazFCheqbVsaq0zNhhyOyDPz0qnntrScB8LXyDJhn/DPFNSEFIIL3WNscKU
 63qhng==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k5dtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 15:19:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138f5e8ff5so2289633a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296775; x=1751901575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66CJdJsC347ysZVqffGRFxm2aYFeQsQ85CaTAPDUfkM=;
 b=hhMoovlQxBqM+zMiNXQLdCASIC0ruSwbk5r3iynHSQAV0kNkmUka/sBeDsIZ1oKbkO
 7JS4Gas5a+ZJv0dcW+WBBJs8oqhMfjYPlGajpbW0KIEmc7sfFCxMFXAOK0gWKmk5bpsP
 X8pUnQipnYSHSXQoQM7FCxHk6+8FF9SpHjut+4HrrujTQOH0bSh1LCY5QY0wy0oELd88
 UVSRlt9fBHCUBjrxT3urT/IWNV3dEu5u3uCGrwoaRTxf0ySdSu8pcMMpi5gz9nwT4Hcd
 xtmnSl0DR7u4dhvvaaZlJp93eTAkicoguR5W5S5EWORXAoLRSigCdp2Bitqxy7BxLKaX
 zFxA==
X-Gm-Message-State: AOJu0YzXNZBCTLarbplCf2tLboJ9k5zQMXbx7MDjhn10WIRyMOHeAUDA
 TZsRcTzeWyfYVHmLO0BvZEr6waQTHNLvahXGXLm84/FL/SEj3M3v58BlW47IhprlWKa3dIg9Df/
 aQ/9oS25O65t7RIPR+aLa5sE4rlIzcEUuxRQ8kFwZggsSLq47PlTXXzua8xZ6uf0OMDDw
X-Gm-Gg: ASbGncv8jQrQFYUf+ikni3EK5p1h1lMnzIhXpVllGiCTZWYmvqaFodf2hCf+H/YgGB4
 BJV7QVjPDAqCtRgqS/8UKQWRwdgdJpifzqIjGny10h8QgD84AznKWsDX+p/ff2CNPIyFJHlXPwy
 c9EW1Q6uZq0trCdLjzx2MMo41dxm9d61NgMHLkXJJa8BgPC4wYP1aG7CX70I/baDxWSB+DOZy1K
 WevHsQuYClp8vHJO27/MHz1qPbRpSvMXZZone207Cz/cwJ3ImRWPtFmHc44kXiYiPhozy/mErog
 07mpwDYWPGYB4kMYUpijvjbA/+CSnStlyzoUZKdqRa1nGMZStUt/cOADBHJStDTKMylKRdBk
X-Received: by 2002:a17:90b:1f87:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-318c9316409mr18110179a91.35.1751296775322; 
 Mon, 30 Jun 2025 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiVDL4QnysnvkWZn1Kr5K4sbkgaq9owWU/OiOIK4gwIxbVFAVqFFbOw/Otk0OOcBsMBiBSFg==
X-Received: by 2002:a17:90b:1f87:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-318c9316409mr18110135a91.35.1751296774816; 
 Mon, 30 Jun 2025 08:19:34 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318c13d54e1sm8956630a91.22.2025.06.30.08.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:19:34 -0700 (PDT)
Message-ID: <9e45cdbe-8cdf-42ab-8769-067ff8f30e1c@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 09:19:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drm: move the debugfs accel driver code to drm
 layer
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
 tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org
References: <20250630143613.2520111-1-sunil.khatri@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250630143613.2520111-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=6862ab08 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=zd2uoN0lAAAA:8 a=Ci5om5BGt_NrSYkhAQgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyNSBTYWx0ZWRfX8OcBB7hPX4MJ
 wOU98pJB5FIEEpRMe51gm2wAJ42BXsTEMqFLTecGrSDJYBYoFvEAKMOk6VYxkJDOhFs7YhM2lxQ
 9FPvUApm2vvbz7XdYzIKkW26b6KE8Fli1PDiboGoiL+6HwsDpYsojk1m62RqGEXHj27rvYJz12h
 u8HAmLVQQbxJANoroNgP48hNI2+2OD76VQXEvgJWfE7xRRh5DQ+baYi9WUVMplqXDf/86B6ly76
 +K9WyYRUIO6fcACHQrIKZDtfzQkUQB9edOf5r4RVtCxRwCKUrQMLK4K7BhNIiX2a7btjBV2xg5z
 s0LzwDtlSUq5Xf+xzQgD//9/0ChRAGL62Aqs17j0wH0Y62rnX8MLICCzWXARt0lyRriAMUSuzil
 2a/9iU1XXA7sFMECkNYwStQFrpdTbs+xqCu2yErITEpzLRE0aErN1jCQ8QwSb3B6BDDnRFvP
X-Proofpoint-ORIG-GUID: tt6HIaf7sA3G04uV3ky0_XDwa4Qe2MOy
X-Proofpoint-GUID: tt6HIaf7sA3G04uV3ky0_XDwa4Qe2MOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300125
X-Mailman-Approved-At: Tue, 01 Jul 2025 07:16:54 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/30/2025 8:36 AM, Sunil Khatri wrote:

I don't see a cover letter on list. Surely there should be one?

Looks like you didn't send this to the Accel maintainer. Did you forget 
to run the get_maintainers/pl script?

> Move the debugfs accel driver code to the drm layer
> and it is an intermediate step to move all debugfs
> related handling into drm_debugfs.c

This is missing the answer to the most important question - why?

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/accel/drm_accel.c | 16 ----------------
>   drivers/gpu/drm/drm_drv.c |  6 +++++-
>   include/drm/drm_accel.h   |  5 -----
>   3 files changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
> index aa826033b0ce..ca3357acd127 100644
> --- a/drivers/accel/drm_accel.c
> +++ b/drivers/accel/drm_accel.c
> @@ -20,8 +20,6 @@
>   
>   DEFINE_XARRAY_ALLOC(accel_minors_xa);
>   
> -static struct dentry *accel_debugfs_root;
> -
>   static const struct device_type accel_sysfs_device_minor = {
>   	.name = "accel_minor"
>   };
> @@ -73,17 +71,6 @@ static const struct drm_info_list accel_debugfs_list[] = {
>   };
>   #define ACCEL_DEBUGFS_ENTRIES ARRAY_SIZE(accel_debugfs_list)
>   
> -/**
> - * accel_debugfs_init() - Initialize debugfs for device
> - * @dev: Pointer to the device instance.
> - *
> - * This function creates a root directory for the device in debugfs.
> - */
> -void accel_debugfs_init(struct drm_device *dev)
> -{
> -	drm_debugfs_dev_init(dev, accel_debugfs_root);
> -}
> -
>   /**
>    * accel_debugfs_register() - Register debugfs for device
>    * @dev: Pointer to the device instance.
> @@ -194,7 +181,6 @@ static const struct file_operations accel_stub_fops = {
>   void accel_core_exit(void)
>   {
>   	unregister_chrdev(ACCEL_MAJOR, "accel");
> -	debugfs_remove(accel_debugfs_root);
>   	accel_sysfs_destroy();
>   	WARN_ON(!xa_empty(&accel_minors_xa));
>   }
> @@ -209,8 +195,6 @@ int __init accel_core_init(void)
>   		goto error;
>   	}
>   
> -	accel_debugfs_root = debugfs_create_dir("accel", NULL);
> -
>   	ret = register_chrdev(ACCEL_MAJOR, "accel", &accel_stub_fops);
>   	if (ret < 0)
>   		DRM_ERROR("Cannot register ACCEL major: %d\n", ret);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 17fc5dc708f4..5d57b622f9aa 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -70,6 +70,7 @@ DEFINE_XARRAY_ALLOC(drm_minors_xa);
>   static bool drm_core_init_complete;
>   
>   static struct dentry *drm_debugfs_root;
> +static struct dentry *accel_debugfs_root;
>   
>   DEFINE_STATIC_SRCU(drm_unplug_srcu);
>   
> @@ -752,7 +753,7 @@ static int drm_dev_init(struct drm_device *dev,
>   	}
>   
>   	if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL))
> -		accel_debugfs_init(dev);
> +		drm_debugfs_dev_init(dev, accel_debugfs_root);
>   	else
>   		drm_debugfs_dev_init(dev, drm_debugfs_root);
>   
> @@ -1166,6 +1167,7 @@ static void drm_core_exit(void)
>   {
>   	drm_privacy_screen_lookup_exit();
>   	drm_panic_exit();
> +	debugfs_remove(accel_debugfs_root);
>   	accel_core_exit();
>   	unregister_chrdev(DRM_MAJOR, "drm");
>   	debugfs_remove(drm_debugfs_root);
> @@ -1193,6 +1195,8 @@ static int __init drm_core_init(void)
>   	if (ret < 0)
>   		goto error;
>   
> +	accel_debugfs_root = debugfs_create_dir("accel", NULL);

Did you test this with CONFIG_DRM_ACCEL=n?
It looks like you change the behavior with this change in that we'll 
have an accel debugfs directory created, even when ACCEL is not built 
into DRM.

