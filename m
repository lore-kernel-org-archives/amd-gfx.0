Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61DC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F12E61DC7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F12E61DC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0674A6E855;
	Tue, 29 Jun 2021 11:12:51 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3826E855
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 11:12:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id o5so10662351ejy.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=D/uYvPuEFE9g+rzlE2Oy2rYw70ciTLi+Hr6Iw8iHX34=;
 b=gm3tcQLLHv1+QnhVsMfgBgl/UNIUmgXYLVtRYBi23YU5bP91KeszVuIoF8xEMJVYiG
 8VeP/0AwtpgRcrPxLqUOlvPEK9UdGI+F/Z1pQLhPEYSyuGL/IZN2cci5OoS1MMwv9K0A
 UYePaIJnRaTvR/DiISZ7TO1vfeegBtXvANU6E9keJoQuBdn086YEVeyTFQHQ9/PWznq4
 Nf70YRt15mTXCdwr536TMMiTC71vW9EqexD2pQ6j6+UtDk3xCbVGL32z3VZLG1LxQFqf
 WytxESm2mmOVBjDh+oWdZempllqG359boW6Y0x9uj1so9OkknGaqWZGaiclgKOcHVQRh
 lJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=D/uYvPuEFE9g+rzlE2Oy2rYw70ciTLi+Hr6Iw8iHX34=;
 b=DPQM7NpffHlEM5UruQgQjxAYc3bOD5+x1P5LP1wh07gUfsY6qd4PE9gGmzNUva6ais
 KVHLCyQT+UmzlRKh0m8QP5dlm9/zPND/fZpuW/DChb+VoDW1VDIKZRepULNtAPC3WO1J
 DCXPK5Es2Gdg+RXdsru16mbjEP+XhtIdVKvKp9hsDC+zqSdqg7LSC5MDMBP5itTUtANz
 JfwnNI2FBHEE/dGwDuNVwqnvIGTOoYiDxFt5UAvpKjojEVdfnB25Wu0AjEdTg/iuukeu
 Gi+b+zgsVp/M6st4eFYentOBY6LTItI5kBDm5C0pEi3gqUOBL/qjezbYIkGQRXEjzcRl
 cSug==
X-Gm-Message-State: AOAM530xYYW8paHNP303FjqGCgKt/QZbcH8nAXbKeuQv5WN5rs1jJniu
 iT7ag5rt/PgSbBMXAudqCVyYucF3Xwc=
X-Google-Smtp-Source: ABdhPJwoMbfNyow/EVcyftm3jNNXmH9am1O5/ngu3R1Vj0tGx+FPcGQFm2wTCA6U91qkkrwmeDcoxg==
X-Received: by 2002:a17:906:31cb:: with SMTP id
 f11mr29449860ejf.379.1624965168606; 
 Tue, 29 Jun 2021 04:12:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5?
 ([2a02:908:1252:fb60:acb7:5516:6a55:2bf5])
 by smtp.gmail.com with ESMTPSA id g23sm1474459edp.74.2021.06.29.04.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 04:12:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drm/amdgpu: free pasid early before converting a vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629074914.4114-2-nirmoy.das@amd.com>
 <20210629075556.12090-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <088530db-f8fd-9d37-fdc5-0e810507b3f2@gmail.com>
Date: Tue, 29 Jun 2021 13:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629075556.12090-1-nirmoy.das@amd.com>
Content-Language: en-US
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.06.21 um 09:55 schrieb Nirmoy Das:
> VM code should not be responsible for freeing pasid as pasid
> gets allocated outside of VM code, before initializing a vm.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 6 ------
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f96598279593..5a9006aabec7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1287,6 +1287,14 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
>   	if (avm->process_info)
>   		return -EINVAL;
>
> +	/* Free the original amdgpu allocated pasid,
> +	 * will be replaced with kfd allocated pasid.
> +	 */
> +	if (avm->pasid) {
> +		amdgpu_pasid_free(avm->pasid);
> +		amdgpu_vm_set_pasid(adev, avm, 0);
> +	}
> +
>   	/* Convert VM into a compute VM */
>   	ret = amdgpu_vm_make_compute(adev, avm, pasid);

I'm really wondering if amdgpu_vm_make_compute() and amdgpu_vm_init() 
now need the pasid as parameter anymore.

Christian.

>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9b0e8a9d7f86..0bd9575b0872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3057,12 +3057,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>
> -	/* Free the original amdgpu allocated pasid,
> -	 * will be replaced with kfd allocated pasid.
> -	 */
> -	if (vm->pasid)
> -		amdgpu_pasid_free(vm->pasid);
> -
>   	r = amdgpu_vm_set_pasid(adev, vm, pasid);
>   	if (r)
>   		goto unreserve_bo;
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
