Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94095C001DF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 19:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29EA10E68E;
	Thu,  3 Aug 2023 19:38:20 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E14A10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 19:38:19 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso1096464f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Aug 2023 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1691091497; x=1691696297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4RebVzoMJ7Gin2hoh37Vr1dX+kaifExQzZA9NWWs3LY=;
 b=Zc89bYWPA3k0CZWvAWCbJTdkObSnSKPGYgRZpphiz2qgMZjoCLT6/I/ZlAdreYaAHc
 ReU63+zPwcCnEnkHE9J3RX1tPg3z4rFbWJFD2oZyxfTMdxltfd0M61kAaCWcQCM4N92A
 ZTE9zWBan2KK9PSt7bXb9C8/pGA8tZ6KQNnZjlC5sp4YhpgOs2XiRzHdZLQkDqF/xItB
 A+h4/L/4JSJG4uCbvjobpPZyLqwwCNZc7XtwWUrX8+P9woZ0fffb2Cx2AQp9KM9EuTSW
 fOds1FrtJqkpL0LDePFG4F+/c//AZHAbFx+rmL+hfnVJwBUbc6BRXmciTLJBcn+VtKIY
 lG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691091497; x=1691696297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RebVzoMJ7Gin2hoh37Vr1dX+kaifExQzZA9NWWs3LY=;
 b=OdhZMCnPZNYUhayo6LJ2J1oB+SIepdl9yVDYLFtWf4C9q+lBNULj4VeEwzKnzVuEC1
 uJgJXbgiYxGqu6hj4Oi5CorElvHDHvyzGbkhMNcI/W38lopIBStz/B/hYxFTJvEs55Di
 D9JbnReviQbsOvWpArZs55u46BgjO/q0c6Q6JGuyUKRsikqReI5l96fsSPEBuKckYXAT
 3xgno83intERniRVc1+V98HwQtywgheAsoJH9iIhWwoGAvw7hV702YURzS5hiitWAOPw
 KMIc8LRoXHeb+1VPZC2WPY5eUq5DXhBDff+6F8tK/k5SNkDNkGFtkLT47IbIwrTtV1Xy
 FEsQ==
X-Gm-Message-State: ABy/qLYwSFjVwdArHeIDbZwyk67yndYeZUHwhb+qvWSxNqA/NzfdJUIf
 pdHjP4Jwi0Rm5LW9kf0q0TmvGhSmL3w+3vsXoc2IRw==
X-Google-Smtp-Source: APBJJlGIJU8SvVYaNKZhoAKak/Le1VQ0x5fe7LdS2S48kQt8AUBTQe8DrIpHnihKYLUZ6aP1AmTxcbBMz6/daRvp1iI=
X-Received: by 2002:a05:6000:1051:b0:314:311d:1b9 with SMTP id
 c17-20020a056000105100b00314311d01b9mr7962153wrx.47.1691091497299; Thu, 03
 Aug 2023 12:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230719212255.30960-1-alex.sierra@amd.com>
 <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
In-Reply-To: <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 3 Aug 2023 20:38:06 +0100
Message-ID: <CAHbf0-HZNEvSN0d2Ddnwg6z500WYDd5zzbTx69bBQmOc7GF=6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 jakub.kurzak@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

I'm seeing a compiler failure with Clang 16

  CC      drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.o
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:3568:2: error: call to
undeclared function '_dynamic_func_call_no_desc'; ISO C99 and later do
not support implicit function declarations
[-Wimplicit-function-declaration]
       dynamic_svm_range_dump(svms);
       ^
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:50:2: note: expanded
from macro 'dynamic_svm_range_dump'
       _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
       ^
1 error generated.

Cheers

Mike

On Wed, 19 Jul 2023 at 22:27, Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2023-07-19 um 17:22 schrieb Alex Sierra:
> > Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
> > from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
> > it could drop performance, specially with big number of SVM ranges.
> > Make sure both svm_range_set_attr and svm_range_debug_dump functions
> > are dynamically enabled to print svm_range_debug_dump debug traces.
> >
> > Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> > Tested-by: Alex Sierra <alex.sierra@amd.com>
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> > Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>
> I don't think my name on a Signed-off-by is appropriate here. I didn't
> write the patch. And I'm not submitting it. However, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index 479c4f66afa7..1b50eae051a4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -46,6 +46,8 @@
> >    * page table is updated.
> >    */
> >   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING        (2UL * NSEC_PER_MSEC)
> > +#define dynamic_svm_range_dump(svms) \
> > +     _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> >
> >   /* Giant svm range split into smaller ranges based on this, it is decided using
> >    * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
> > @@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
> >                       break;
> >       }
> >
> > -     svm_range_debug_dump(svms);
> > +     dynamic_svm_range_dump(svms);
> >
> >       mutex_unlock(&svms->lock);
> >       mmap_read_unlock(mm);
