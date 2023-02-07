Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB54C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CC610E1DD;
	Tue,  7 Feb 2023 14:21:21 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C9D10E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:21:18 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id s66so12731787oib.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Hd/M80a3pFy++U+oZtOVnk1+ZPSSOwl4O5OY1K/u0E=;
 b=VbOtXxz+C3SGiBH3al7cALY6lIQsIzl8ESnOQMOi5ePdsYvLF7xJyRUoyX8ixKL0av
 fehT0Ha4iUsQ6G+cuEIuLez8GwHw5glETQs6PsqNldU+Q1WH+2Xg0MMyrLmC9LRfsZf3
 nGhEBfTFyVp5NmwsU7bO9BSN7bmKxSE8SkC8K14lB/V18AX//ExM+StOK8qN74+dUd8G
 w6SiRROWnxFrEEthI9I91pE2t5ftFXmKXwAs7QfhNQ9WDMXKpzEM21X22pimiihvAxyo
 4tYj737tlUPIb3vQwG8ouYnYrWIyYp7Fp3C0D6Xwj0oeqLFeVxnU/2NpKrMlQBw6Fb9e
 fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Hd/M80a3pFy++U+oZtOVnk1+ZPSSOwl4O5OY1K/u0E=;
 b=wTnSghHfuCQGEDYiw36hntPeEFbfQ4HayB7Q8BHwxFJAmC2I/Cc0EaJIxtLWsq274z
 3Vm0ZUbdNaxlisiGtJw/hyShc4dETrQN8bbIZKLtEvo5YjQlVJzSWJQy+Ee68pKZRrct
 AmFphqPsHqllXJeg1SEMlv7Ov4cmeE3/usdMOfn3MKzBKEyWaPB7R18O4eS15prboU2S
 4nGn+I2UzvZStFjc6hoHeQFU2l5G/gSbgRfIrlv+9TwoLs9sarbmVKtwIFWi/JP+cDET
 B0DhnpxfNAaJ32S9D++8DGq2ufVxCHFU63cX3qsDwjiJueI+tzofUsdgYyfEunbI0Hg2
 s3Ag==
X-Gm-Message-State: AO0yUKWktHOtRXsp8ki0aDQW4wCuG+AyXvX8R0kF0wZFaRRkOtJrnywt
 7If057AofHlQ2MM8i73H1knHDSc7/gYdB9jKc98=
X-Google-Smtp-Source: AK7set/E8wyHaANf1aj8Qpm2J7ymu/b1E/AZGE/X7Q1/Kx2CvUbpKAcevNmgl8sTaAB25BJvkPFTrlkErCYRFaFTAVU=
X-Received: by 2002:aca:654d:0:b0:35b:d93f:cbc4 with SMTP id
 j13-20020aca654d000000b0035bd93fcbc4mr315041oiw.96.1675779678248; Tue, 07 Feb
 2023 06:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20230202162103.5811-1-friedrich.vock@gmx.de>
 <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
 <CADnq5_M--J7ERZqLML3SL56zj14RkSe7YVnDwv22nHtjyZJ1RQ@mail.gmail.com>
 <4211e472-042e-a384-25ca-0a109004fb41@gmx.de>
 <2a41b8d9-81a0-2be8-81e9-cfbad79f30c8@amd.com>
In-Reply-To: <2a41b8d9-81a0-2be8-81e9-cfbad79f30c8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:21:07 -0500
Message-ID: <CADnq5_OwEVHV6n05QCsivz+ykiL9-0iyTnVrgyqTFJ=k=bLE_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'll add the stable CC.  Thanks,

Alex

On Tue, Feb 7, 2023 at 2:34 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> That sounds like a good idea to me as well.
>
> If you think that a patch should be backported please add a "CC:
> stable@vger.kernel.org" tag to it before sending it out.
>
> We can always remove it if we don't think a backport is appropriated,
> but maintainers seldom add it by themself.
>
> Thanks,
> Christian.
>
> Am 07.02.23 um 00:09 schrieb Friedrich Vock:
> > Hi,
> >
> > thanks for applying the patch!
> >
> > Do you think it'd also be possible to backport it to previous kernel
> > versions or do you already plan to do that?
> > Since it is a one-liner bugfix it shouldn't be too hard to backport.
> >
> > Thank you,
> > Friedrich Vock
> >
> > On 06.02.23 21:26, Alex Deucher wrote:
> >> Applied.  Thanks!
> >>
> >> Alex
> >>
> >> On Mon, Feb 6, 2023 at 3:35 AM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>>
> >>>
> >>> Am 02.02.23 um 17:21 schrieb Friedrich Vock:
> >>>> The pid field corresponds to the result of gettid() in userspace.
> >>>> However, userspace cannot reliably attribute PTE events to processes
> >>>> with just the thread id. This patch allows userspace to easily
> >>>> attribute PTE update events to specific processes by comparing this
> >>>> field with the result of getpid().
> >>>>
> >>>> For attributing events to specific threads, the thread id is also
> >>>> contained in the common fields of each trace event.
> >>>>
> >>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> >>> Ah, yes that makes more sense. Reviewed-by: Christian K=C3=B6nig
> >>> <christian.koenig@amd.com>
> >>>
> >>> Alex do you pick this up or should I take care of it?
> >>>
> >>> Thanks,
> >>> Christian.
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>>> index b5f3bba851db..01e42bdd8e4e 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>>> @@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct
> >>>> amdgpu_vm_update_params *params,
> >>>>                        trace_amdgpu_vm_update_ptes(params,
> >>>> frag_start, upd_end,
> >>>> min(nptes, 32u), dst, incr,
> >>>> upd_flags,
> >>>> - vm->task_info.pid,
> >>>> + vm->task_info.tgid,
> >>>> vm->immediate.fence_context);
> >>>>                        amdgpu_vm_pte_update_flags(params,
> >>>> to_amdgpu_bo_vm(pt),
> >>>> cursor.level, pe_start, dst,
> >>>> --
> >>>> 2.39.1
> >>>>
>
