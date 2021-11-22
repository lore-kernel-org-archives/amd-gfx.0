Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 20:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D2889CCE;
	Mon, 22 Nov 2021 20:01:30 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF3A89CCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 20:01:29 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id bf8so40015626oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0QguKLx2DbWpFPuB70r4WaayuITD9drqiErfw6hwF88=;
 b=EdKm/ebN2/QrYikWo9kzYgclViBNFaX5h7NDZfAJxyDQFmXm4+WN8yOnYRMCuc0OJU
 C0JqVlF4GJzD998TSZhN+nQAsnUaWTK/AaZrgUIrjC0Xp1IOxn9NBJxyWpEP+NV+dM5Y
 GURDYauhgOuUNo3wXDUerI7lxPSv/ZtDB4RHLDqkffR0BpZDP/Ilhe9K9miwYqDmJOjl
 tC4zCy1vVfvcxdVW6h5m4SKO3/40+/uTUUgsk3qbGLObtuNFZhtJqdmBQic/uh4DN7YX
 zfM5gLuMkHN9dYrBYoFfqyZxqwUBAs224M/6+T2Xif1TtERB14OfLR2p5knvWQ++u2Nw
 zacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0QguKLx2DbWpFPuB70r4WaayuITD9drqiErfw6hwF88=;
 b=FqweFsd0M2/vU8QaSEK7ZrJOt1fzRLqTT8aJBoiI5OpRP1BFmi4p4Crn0CBZS7gosz
 oRrlKSjmYJ6kilenmI2reartWbZvQPMFjXYkMAzbSd9Q+yjlI0b5tq8MRHEd2ZLLSJ0L
 E6EhecIGS7F8cDG14S5Xcb5OwL7AdusDA284hdH+/B3XTDuhi/fO0+eFTylXcWb5tsCV
 aliy3ub5Q3e5oHsb3BJWOKdZSMD4dCLDuZuhxeiOCeE+Gu+XgxEm3xuaKwuzy4DokjAx
 pnopuIaxQmhIsnkWJn9uaRnjJch9T6wOkbESIBtIQgSYa3Tobsc1RVLjBCHn9x96h9GB
 JjRw==
X-Gm-Message-State: AOAM532Oa4SxEgPDi/9Vr3RXZ7Xuu/fvw2W2NxLNoaX1pgV5TSlvmErD
 rNR0ZRLYwZkHSouJtoRC2TDirDwTix1B/d8AT4H8xZYq82E=
X-Google-Smtp-Source: ABdhPJyVoA6UqmJuXFO0ci9CRrxsTreQNccnyFL9x50Q3wwAhCx49VnhMzWe3hmo8OZIEmsZxGq0lxZXosUy8TwiWcM=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr23907388oia.5.1637611289240; 
 Mon, 22 Nov 2021 12:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
 <SN1PR12MB257578DF2A2958657B71FF00E39F9@SN1PR12MB2575.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB257578DF2A2958657B71FF00E39F9@SN1PR12MB2575.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Nov 2021 15:01:18 -0500
Message-ID: <CADnq5_P2ho7KNYqYatSrBe_4-Rb7pk1gSzeH153kVQkc4m+FXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Declare Unpin BO api as static
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: kernel test robot <lkp@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I sent my RB, last week, but maybe it never made it to the list?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Nov 22, 2021 at 2:58 PM Errabolu, Ramesh
<Ramesh.Errabolu@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Request review
>
> Regards,
> Ramesh
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
> Sent: Thursday, November 18, 2021 4:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: Declare Unpin BO api as static
>
> [CAUTION: External Email]
>
> Fixes warning report from kernel test robot
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 90b985436878..3463e0d4e5ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1332,7 +1332,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
>   *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
>   *     PIN count decremented. Calls to UNPIN must balance calls to PIN
>   */
> -void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> +static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>  {
>         int ret = 0;
>
> --
> 2.31.1
