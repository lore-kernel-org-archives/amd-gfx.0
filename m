Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30D2D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 19:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F2C10E45C;
	Mon,  1 Dec 2025 19:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RH9A7Ndq";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D5910E45C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 19:18:02 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7b90db89b09so446536b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764616682; x=1765221482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uG1pef5j3kb+4gT82++NmcY1RocDe5RimSakU+cBCck=;
 b=RH9A7NdqKEVHUuz5SeFNJQWCj2rUEC+Ln72t/QJmQdP7r5rVF1UCPBp6VGwTzWdwmd
 23MbACPmAwiZ4uYdTO1MukJYYW5swjLD2EfvhUIC/AC5rfhO4LeHIns98NCxpbHjkw7L
 BHD9a/QGS6CndQGPqB/c67+J+/aMNzjWhqoET9Bl4fpIiN7V608TOZzDO8BS6YOL+tYQ
 QeSCSDhTf3JGg9Umc2i7UonhdLu1nGxHUsZLWTJ8FKD8/xyhnKn4RCzM5cgJsBC1aGwV
 l9/uwOgARnmuBEoRGtsF/0LFvaUsFpG2jVfpd2TcE6DgdBqtN5cclmv7n9hOr1NGFVuh
 1deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764616682; x=1765221482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uG1pef5j3kb+4gT82++NmcY1RocDe5RimSakU+cBCck=;
 b=Ajf3KufZOMdHEuXw6g0MG+zRzAqRD/Tdjwx9Y11gnj96nz7WvxvJQg/1ezbufyfstf
 0FIIkMAPbNTWpamJTGca7ZZrJa6j/6nIbzTg+XbZj59b/Q9A0y8gSaDmasjDTfqHs/m+
 KjIYW6rShwhAO3wGYt+Eo9+Eg0BS1NCeRfCbvaj+RQCL1sz9i4AOWSHIG8qyLBuE9Nuu
 lTdoL7FwI9uiULLB+o35zKexyGCEEN7UHwhuXzfYtAGDm67SlKAE4U3JMJ75wAFkvXkI
 Zssp1/mG1SoY4A7SGvn0xevGZH0jy7Oq+7ZD0efQHr3rvqSM5QKB14/katTLlX6nkKPN
 CVXA==
X-Gm-Message-State: AOJu0YzHGLKBcZgdr9p8YseeO+uH0NGcVrbjzo0Xokvonm4IyJNR4C3R
 VN2We1u5Yflv+RH44+URCiZovYpNRJJ1v8aAuP0HMUiquTBmMTeVO48b3TJDFE6pb6MLLG5FVnJ
 1T/FPlLZvwNRS3IAEHRJF6quuFpSwqSM=
X-Gm-Gg: ASbGncsQNXfFs8SwJ31YAF3P/4rYR8LZZssi8nXPKxVyuCXr0YD4hDf+LVFdnlYkMek
 GwhXt4+I538eJzXV5bM1RlosOKU6UnfRgNyVn86G5t6TOF3kdekmG2S8l/hd1CJJfkT6Id7bI1G
 l9nUWNvgbDS0qJx80k6/PpNr56NbEv0h8wT/qqXUpR4SFsvYYvTLgvDyEz0tpRCgPBoILfSaPZm
 ZnIQ9I9D018XX/ekUuknLTpLnTX7c2wSSgCUXow/Dq0GxblxisDiDehjx8jozi6jjDUu2I=
X-Google-Smtp-Source: AGHT+IHK9eiAGQUPs7XxDwdINu82yjOiyGXjBNyvKQ1nsCNnDHeJez+OpNJZ1kHkrXY8DwHjOMdc+y57KAFRjvrxKCQ=
X-Received: by 2002:a05:7022:f902:20b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11c9f303bbdmr17346603c88.1.1764616682007; Mon, 01 Dec 2025
 11:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20251130014631.29755-1-superm1@kernel.org>
 <ad10d9ef-c769-49ba-ad12-3d2b5ab7f1e1@kernel.org>
In-Reply-To: <ad10d9ef-c769-49ba-ad12-3d2b5ab7f1e1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 14:17:50 -0500
X-Gm-Features: AWmQ_blzIYmdGqX6DnxfaOOAl2trtlOnCOWHglxWvMTQPOVTdx5ArwlXlupYGzM
Message-ID: <CADnq5_OJo_Z2feLLpeCjNE6KO9LZuDV7TBU4YUi+8ckw6g8NzQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd: Skip power ungate during suspend for VPE"
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

On Mon, Dec 1, 2025 at 12:04=E2=80=AFAM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 11/29/2025 7:46 PM, Mario Limonciello (AMD) wrote:
> > Skipping power ungate exposed some scenarios that will fail
> > like below:
> >
> > ```
> > amdgpu: Register(0) [regVPEC_QUEUE_RESET_REQ] failed to reach value 0x0=
0000000 !=3D 0x00000001n
> > amdgpu 0000:c1:00.0: amdgpu: VPE queue reset failed
> > ...
> > amdgpu: [drm] *ERROR* wait_for_completion_timeout timeout!
> > ```
> >
> > The underlying s2idle issue that prompted this commit is going to
> > be fixed in BIOS.
> > This reverts commit 31ab31433c9bd2f255c48dc6cb9a99845c58b1e4.
> >
> > Fixes: 31ab31433c9bd ("drm/amd: Skip power ungate during suspend for VP=
E")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> This was reported by a few people tangentially to me reproducing it
> myself and coming up with the revert.
>
> Here's some more tags to include with the revert.
>
> Reported-by: Konstantin <answer2019@yandex.ru>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220812
> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 076bbc09f30ce..2819aceaab749 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3414,11 +3414,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_de=
vice *adev,
> >                   (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_GFX ||
> >                    adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_SDMA))
> >                       continue;
> > -             /* skip CG for VCE/UVD/VPE, it's handled specially */
> > +             /* skip CG for VCE/UVD, it's handled specially */
> >               if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_UVD &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VCE &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VCN &&
> > -                 adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_VPE &&
> >                   adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_JPEG &&
> >                   adev->ip_blocks[i].version->funcs->set_powergating_st=
ate) {
> >                       /* enable powergating to save power */
>
