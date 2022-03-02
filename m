Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E07C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 15:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0152789361;
	Wed,  2 Mar 2022 15:39:22 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48A189361
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 15:39:20 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id ay7so2020630oib.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 07:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kJ7XgdBjJiXODBrdr9EFafnlFbsAfpl0nd8IyCLbP+E=;
 b=FH+BcERGbn+eeIW0UTPobqVdlrKIXVh0hwdKLL1GTRl+tX+lBjLHTTh4jrzO+XUbsy
 Tsg5feZ+t3RF98kmVf0mru7VBs0JNrl6t6WsrJ2ikRM8bLDO853fbAs3ivoXoc5s9e0S
 ZCnPxGxHgnq637aySV9Do30DFbRmG9IWodXygwpEYEdDgnJxZAh4bNLv0yElsRu/05Iw
 1TnL6ojMNKToSallqg6H+63mxE146kVc5SK1qGd9/TT4Oz5IID0eb87TCARHbFqXLriQ
 SMpD5W2vPE0QjLlcIPP2VBzBMXf3VYVpz0sq1/eAJxAKkqbB5CODYU9AiuPszKLYAuKS
 lpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kJ7XgdBjJiXODBrdr9EFafnlFbsAfpl0nd8IyCLbP+E=;
 b=qIJztXzZWXhux5Oz6I0xG2nYDjb/gj9jHJze5FxNNLycKSve6hWabUbElJ7NL1LLVm
 n/CSB0VC3LJMSv+EPfcsqDSSTLOC+YLzMlLX42ntfDTBUapdMxL4glPXcYvbY2tPDlrE
 HIEJ1fFlAn3/BrlLMD78lw5KH9NXYiGbM6Da5A6ai9eP/hmt1ui/fPgIGJTCwOGZQV9I
 uV3PQXQBYjiQcc+2C8IpcvmxPrChGqG2qdhoHL3yvlRu7hYOcFpBC5r84szEhl6wN5JX
 GnGR8QBIUpwWHcbg8VJL86CDGYLkRUd6qy/KQbaF5uZo3jG8sWDRkG5f1isxtQyTxfx2
 7A3A==
X-Gm-Message-State: AOAM532QB5ILXz/NyPQH/LHnxSIOsHXLdcxOS5eBkz5t3J7dqiCWXmFc
 duhFg4E+XLGYXNDtDdRyZrm8ObQ64phHewHysJE=
X-Google-Smtp-Source: ABdhPJzd82AcZ09eWLdR0tm3vYiXV3i4LXdUtmDE4zYyaPInCeq2HBPUhJJdGsIgz6moxvhUb/X+1K1r4EGsgZudi8I=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id
 j13-20020a056808118d00b002d4be7e6748mr329541oil.123.1646235559909; Wed, 02
 Mar 2022 07:39:19 -0800 (PST)
MIME-Version: 1.0
References: <tencent_A4D5E94B44BF0EC4B7CE08BA886C0C1B0F06@qq.com>
 <CADnq5_NOGDTnB+YbN2vLm9mNo1sAn4n=Seowk8vd4wuT5krDow@mail.gmail.com>
 <2cf40fb2-6d0f-660b-c238-a8c97511ab22@gmail.com>
In-Reply-To: <2cf40fb2-6d0f-660b-c238-a8c97511ab22@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Mar 2022 10:39:08 -0500
Message-ID: <CADnq5_Na2UtFUTX5uphZH6THw7PisPM835TLgjB=Ne_3==VJUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential null dereference
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Weiguo Li <liwg06@foxmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 2, 2022 at 10:01 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Looks like my response never made it through.
>
> This change and the existing check is nonsense. The caller makes sure
> that ctx is never NULL here.
>
> So the check should probably just be dropped entirely.

agreed and dropped.  Weiguo care to send a patch to drop the checks?

Alex

>
> Regards,
> Christian.
>
> Am 02.03.22 um 15:21 schrieb Alex Deucher:
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Wed, Mar 2, 2022 at 3:56 AM Weiguo Li <liwg06@foxmail.com> wrote:
> >> "ctx" is dereferenced but null checked later. Swap their positions
> >> to avoid potential null dereference.
> >>
> >> Found using a Coccinelle script:
> >> https://coccinelle.gitlabpages.inria.fr/website/rules/mini_null_ref.co=
cci
> >>
> >> Signed-off-by: Weiguo Li <liwg06@foxmail.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.c
> >> index f522b52725e4..b4f035ce44bc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> @@ -258,11 +258,12 @@ static void amdgpu_ctx_fini_entity(struct amdgpu=
_ctx_entity *entity)
> >>   static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
> >>                                          u32 *stable_pstate)
> >>   {
> >> -       struct amdgpu_device *adev =3D ctx->adev;
> >> +       struct amdgpu_device *adev;
> >>          enum amd_dpm_forced_level current_level;
> >>
> >>          if (!ctx)
> >>                  return -EINVAL;
> >> +       adev =3D ctx->adev;
> >>
> >>          current_level =3D amdgpu_dpm_get_performance_level(adev);
> >>
> >> @@ -289,12 +290,13 @@ static int amdgpu_ctx_get_stable_pstate(struct a=
mdgpu_ctx *ctx,
> >>   static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
> >>                                          u32 stable_pstate)
> >>   {
> >> -       struct amdgpu_device *adev =3D ctx->adev;
> >> +       struct amdgpu_device *adev;
> >>          enum amd_dpm_forced_level level;
> >>          int r;
> >>
> >>          if (!ctx)
> >>                  return -EINVAL;
> >> +       adev =3D ctx->adev;
> >>
> >>          mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> >>          if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx =
!=3D ctx) {
> >> --
> >> 2.25.1
> >>
>
