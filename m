Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5F3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 21:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6990E10E05B;
	Wed, 21 Dec 2022 21:10:53 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DA110E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 21:10:49 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1447c7aa004so248534fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hp8TSx7Rf/2MDLp3LdUja/9o6/1EAEABrKGs5z3g8VI=;
 b=RsQPJiykE6h5M20SQRfcoTQO5QYT8yYdHsqIPpG6SWUxhL5RzdYKy6TgpmRubTCPyH
 HD7vYANEA1+1gj1vVnIIgemba/aJM3gU/UQ98qO83TdJfk5PZDCMRdSauM7jTXtvkvjL
 pxHwLbJ5Av8bOlEvRjYfPGZhG8Ayug28Oh12wrGqzk1KuyC7Rd6hw3eChtLWYOOYUy2s
 f2dUCUikxtZgb5mk+bBXqarUp6NQZwfVAIRACMm+Ezc9SEAqV03ESLVg23pKjskxgMng
 IPfRV9uRPDfUbh8MjqawxlBdt5Gp2isXrPUH3wrGsaojkdNPX8JZJZU99Wpra2nyPz26
 t3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp8TSx7Rf/2MDLp3LdUja/9o6/1EAEABrKGs5z3g8VI=;
 b=a37Agsnjuiuvh9u/qMvUS/RPYvYAaZOV/U1woVjqZlby8r1mJkoRPZgmTiIAG4MGUK
 gawaTFd5zTuguJwj0glUrFrJ3ntIo1m0hgs/0nhCKVPDHGoeeRWFREr75wRNHw3oev8e
 EKfVgaJf9pvwbUBFb78fV2MED5vLmuEmE6n9cdhcLEG4a3c66YKrxdrgZeGgE0utP0RE
 L2h878O7nWp3sLMPf3IUIEJmJky+LnAQrBFn/96x+prSm+mQ16pw9/xUy9m9E2BBtbx6
 K6EU5etvV/0ZyX9RqQKdW8lm4afglbia3ZB4YxHrEzM0eHpumQCPFjstBr5h4QGW2Y9s
 1AXw==
X-Gm-Message-State: AFqh2koyhJs8s7c+bVMYcBIcM+rTx7YmADpgpO7NYEFoGdEcq19aD+WV
 zTWeMvw3guJ3GTkdmxso+5YGxqhm7Qgtye7hzUc=
X-Google-Smtp-Source: AMrXdXsvDRFtiAeVMyGWWtaFMOeRuf9q8FKFcjXnnrJKjMNpy9gEDHeRmy9+wamNvkmPFZpwNXdxPvmHFPN6rrx1E5U=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr293242oaq.46.1671657048532; Wed, 21 Dec
 2022 13:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
In-Reply-To: <Y6BuZ2jv8n9dEVxS@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Dec 2022 16:10:36 -0500
Message-ID: <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
To: Borislav Petkov <bp@alien8.de>
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
Cc: mikhail.v.gavrilov@gmail.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 michel@daenzer.net, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Dec 19, 2022 at 3:01 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Dec 19, 2022 at 11:47:18AM +0100, Christian K=C3=B6nig wrote:
> > That function consumes the reference.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM upd=
ates")
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Thanks, that fixes it.
>
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
