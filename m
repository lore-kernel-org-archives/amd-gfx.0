Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9647B6140E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9647B6140E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFA16E187;
	Fri, 14 May 2021 03:33:38 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444116E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 03:33:37 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so21427858oto.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xav+Bv0nmXc8iASMRcz2HWjQCxkr2LMnz6YRmiM/j1k=;
 b=hNtnHkXA/3wYe6LFVjpiyZbXzYDE9XLqpJ8XRvTFv+msub5+0nk3ChJnKPpxZ1839b
 cuytWySo8fkhhk3YOJxnQtD8Jcvp0M1+OSDpfhPzMrTU6WYcRvDYFemp9bKWoOSmxJON
 d5UmotcC7Uxjbn0VZp1Xfjo6pEwXriwwylbreIFyP/uZKm1kHaBZ6egoc/CJ85Xbxcae
 MOSXqzRRM6GcckBtm1gi5sVIkWzYYHpE0Ia+n8tfR3IGvtiyPkAXHXAOY3jBDLy7BTO7
 RNX5961dHCiBxRJTj5B9EK9QoKo/Asd1j33CbOElgAgM8eqAd8nzA9Lby4ChSp31OG45
 lswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xav+Bv0nmXc8iASMRcz2HWjQCxkr2LMnz6YRmiM/j1k=;
 b=qKnPgVg5tlKROV2UAGUmQOJyVo+O75hqMNXmKwsEFa1ZKt9nWiQKiPmyE0k/uVwm+v
 BSoTJWeVp1DxIvnFT5ojhS1VfOu971lvx+SOXnLJrqD7VGiBz47uEujZDqYDHtX5Mz1B
 4HAnlymXxQv2NTVZel39pvYqHgeOK8Coj0bLcFUcC2aVwuwzcEr2TjVekikduN49RcZS
 zfEKKMRdjnLo+COZS+AEZ5rtIHRd6qxVOUywBcYdTvRnnYTXsc36R/bIKdDlbz0tFXM7
 NmknfEnAthqsAXAhC24o2iioxjnj+ey6bk5amzfb4IuS09LGHJQIbATUDQN3Cs11qp07
 lfVA==
X-Gm-Message-State: AOAM530ZS1pqD7zSgE0jEoRE6dnZFZa3Kd7q5qLYvPyAGMW58ZNiEMO6
 POnRGsd1owr7mTPDfDZQ8CH9XffmnBKnuFRTgFs=
X-Google-Smtp-Source: ABdhPJz+ENzhYzNUJxIM7Ai2ilgWteSlZBdJaOutD3NnAV555Gg2Ebyjgoc0pR7XbMat2Ngv5AIwdv4vHp54QWDKAYU=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr22408261otl.132.1620963216552; 
 Thu, 13 May 2021 20:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 23:33:25 -0400
Message-ID: <CADnq5_M6C7dNsWxNzJXeRWbMF10sT5BVcq-3S5bGvavM96pFcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

unique_id is normally fetched from the SMU on bare metal.  I guess in
the SR-IOV case, this would come from the hypervisor since the SMU is
not normally handled in the VF.  That makes sense for multi-VF, but
what about single VF?  Are you sure the ordering is correct such that
the SMU value won't overwrite this?  Maybe that's ok because they
would be the same in that case?

Alex


On Thu, May 13, 2021 at 10:39 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> pinging
>
> -----Original Message-----
> From: Gu, JiaWei (Will)
> Sent: Thursday, May 13, 2021 7:01 PM
> To: Jiawei Gu <Jiawei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Add David.
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Thursday, May 13, 2021 2:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
>
> Initialize unique_id from PF2VF under virtualization.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a57842689d42..96e269cbe326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
>                 adev->virt.reg_access =
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
> +               adev->unique_id =
> +                       ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
>
>                 break;
>         default:
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
