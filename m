Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCCFCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 18:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A173810E7CD;
	Wed, 20 Aug 2025 18:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzYDtzmF";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9B210E7CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 18:36:26 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-76e2ea21430so29905b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755714986; x=1756319786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lPO6v2yCQMAV/fdnPT1+8+lKwyGbKpkr8nACc66TLM=;
 b=dzYDtzmFN6j+H0YTq/eEDMcV+IcdBW0Z3mCwH8HofNePOfskXvMIACGkX2JXJK7w9E
 nvJcuV61jSc3scv5v/u017sY7yGI3LZPWoHdf+oDNDfCvOyYP5Yz7yacfrRBWT3L/s/E
 CfzkPbO15+2ju+gShsmGq3WtrzYOSa9v6gEd5HlU9AuAKyLxrmIYNBlJ2H4SZv6szbQP
 q9B06d/67FJzOXKyftr53JHxTgcngS2+EZ4H3f+dMqUEBUqWZ20Lr/UpzYFROlgLMdG/
 hKSilq1dqUrjqkhJwBsXEK8FuAjU6gcnq7SXp6ZZBordnJ9xE/ct2YSCeKJ8Xf+8HZHc
 exeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755714986; x=1756319786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lPO6v2yCQMAV/fdnPT1+8+lKwyGbKpkr8nACc66TLM=;
 b=Q2p4EodK/olxDJk0UuKpDRhY9Aqbr1KA5PKkm+O7tZ2xqPMeop/VcPM7Egl5w7d3Vg
 DZ5BuvuAP46BKLlpPYfsavM13qK5qbjCCD89UH+aqzvFOSk7KqK40dbp0YSSv+BFWq2J
 xhiQ+aJRC0U0vYr2xWx4tm+B2kv4y2R4AQc/Db5jGn0ZsOQxLHrVy0hYtP39IvhuawQB
 Q9m7mLczzqaebl2/THiPE5MTzCZzjMGSPT1zE7urtg33nzpKCT7ukoOVMsXcfx4i7o1s
 /sRCwjW3pOHGLvH6bz/Py/r0YC8jRTtcAolfwyq5rmfCJQBlBjAUUCZ6yGy45/4V64fG
 9Ixg==
X-Gm-Message-State: AOJu0YyeKRO0EEAwuBjR+jIngjCOVIJasxNwyMcjo1HWzqQrTgz2MVCf
 Qcvd53blqw0b6OphW0CgvG5l+4pyjfW7P6vEJxti3kjj6RPelrcZWEB7y0sPoaVvmrA6NavPtvO
 G9vJiv0szvfSPqEImX2GW5s6gyvGpQlgBvA==
X-Gm-Gg: ASbGnct6UUaHJhb6QWNVRCkGjfV+WtppvjLtaGhkH22ULDIDL7wei32XIRyNMFuPhwF
 cE8pByPPbk22i65HHTAS5DWPTy0WPn+NlvHnm203li2xDCuin1kpdVchuyRCcbsatu4jxwP8ifO
 NnUkB7WCd0tHyUMDV86gc2Q3eZ247AC4dVjDb+bzM+tF7kMgy9n13IyeRoRguIOe0GPhZSFaVrn
 TtDUpr+BDiX1eH7Aw==
X-Google-Smtp-Source: AGHT+IFS57xCwVFECis54fbParmjGK+nthiWJlV6iFRkrpdk3Gyvbefv/4JLvMREP8WBWGYXOb7AXTkTGMxQYE+Kq3Y=
X-Received: by 2002:a17:903:acd:b0:240:3e41:57a3 with SMTP id
 d9443c01a7336-245eee1d08fmr26217925ad.0.1755714985565; Wed, 20 Aug 2025
 11:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250813193658.2444953-1-alexander.deucher@amd.com>
In-Reply-To: <20250813193658.2444953-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 14:36:13 -0400
X-Gm-Features: Ac12FXyVArixu0NWXpXcE8j5JvHsqZpbJjRxcaq-QARYdb2UG0oXit_4Jrn4k70
Message-ID: <CADnq5_PqnUUxF7Suj0fg4Q6F6ELa8ugT78gFWHd5Djg1GGB8hg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Ping?

On Wed, Aug 13, 2025 at 3:37=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We already call this in the hw_fini() methods for all
> VCN instances, so no need to call it again in
> amdgpu_vcn_suspend().
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c184..fd8ebf4b5a824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, in=
t i)
>         if (adev->vcn.harvest_config & (1 << i))
>                 return 0;
>
> -       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> -
>         /* err_event_athub and dpc recovery will corrupt VCPU buffer, so =
we need to
>          * restore fw data and clear buffer in amdgpu_vcn_resume() */
>         if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
> --
> 2.50.1
>
