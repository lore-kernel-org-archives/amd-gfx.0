Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AFC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D020838
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFBly9t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796DE6E8A4;
	Tue,  3 Mar 2020 14:16:37 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFC46E8A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 14:16:36 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 6so3381594wmi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2020 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5bFWu6oly/Gt/0zmxAuLlYIEPGptH6XUr6fTYy30siw=;
 b=OFBly9t9ogbf4DLBtxFPE1DJeGnK98b9jaV6JDDjTineAPKnMnJkj9Zl0a4ubSb6lx
 286fNg6KVjh7n1pBLj1CoCtu0ZwClQ/ZdJDIk0jVQlngWxBN3BkpORhLjhVCh5TOPCRj
 NIl7xBtI6BP9ptf9362BQCg6UtVbc7GY0206iwhVO3/orwx3jped1svHGG3DIPeZ60Zb
 ArfvGJbtFZYHhGcFnNC/zjUuCdy0bKwD6mf3TaU1pV4ExDkyi1yr6XOnE1qt8G4wQIcx
 0mzu+rVqcd01ZX0a4xxiYcas6dzF8KUW+/PntSIQwM2K3SnbW5YNsJ8ictFZqpYPK0Pr
 vJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5bFWu6oly/Gt/0zmxAuLlYIEPGptH6XUr6fTYy30siw=;
 b=E0codnUFLUdhElQ4BhIXSoVGdJsQPnUSNwdRWawewzcjdBHiovcRGaDxatdf0to/ux
 DiyjjyetSnsAmwCQ7/59dMKgRIs/CcyrFkyFV9/QSLtSf0Q20ddOL7KSIE2PsefdD2xS
 Yzq5kf+8hFVQvT1fb2tRW3asdtZlc/oNvEuc8D7nKbWhhE7Zs2kJcYJPPjhVofOk7Zef
 3cJ4VTVd/dLgMJy45UAA0BCT/VZqWpw4lu6jcVeOM+f+047ykYaKxyS/GJ0YZi47TApI
 Lx9rMWQl5InL82iF3xNuObo7WqALnFww7ZNUR2uwFaGLFPicJP1uzliUmPpmIhPEatod
 1jTw==
X-Gm-Message-State: ANhLgQ131rBgZcIqREOXUAknn+a+MmxXXGetWNyGIlVbgpCQ8mHAu5ER
 +3e5AcUA8S5PbHEG3i1LCeDjmYoH
X-Google-Smtp-Source: ADFU+vs8/vORju+fZji0fq+7qcmk0XH4TJOdymGr9ofS09OQ/8is92uGhavYxA287dBxMkRd55fh2g==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr4435060wmf.168.1583244994730; 
 Tue, 03 Mar 2020 06:16:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a9sm4392734wmm.15.2020.03.03.06.16.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2020 06:16:34 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
To: Jacob He <jacob.he@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200302053529.5736-1-jacob.he@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
Date: Tue, 3 Mar 2020 15:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302053529.5736-1-jacob.he@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.03.20 um 06:35 schrieb Jacob He:
> SPM access the video memory according to SPM_VMID. It should be updated
> with the job's vmid right before the job is scheduled. SPM_VMID is a
> global resource
>
> Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
> Signed-off-by: Jacob He <jacob.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c00696f3017e..c761d3a0b6e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	struct dma_fence *fence = NULL;
>   	bool pasid_mapping_needed = false;
>   	unsigned patch_offset = 0;
> +	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
>   	int r;
>   
> +	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> +

It would be better if we could do that asynchronously with a register 
write on the ring.

The alternative is that we block for the VM to be idle in 
amdgpu_vm_ioctl() before unreserving the VMID.

In other words lock the reservation object of the root PD and call 
amdgpu_vm_wait_idle() before calling amdgpu_vmid_free_reserved().

Regards,
Christian.

>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
