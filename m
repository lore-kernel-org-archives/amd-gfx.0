Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111E9C3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 14:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A97C10E2AB;
	Fri,  6 Jan 2023 14:25:01 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72ED510E2AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 14:24:59 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1442977d77dso1668665fac.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQImUUykBshNqHBWyp6suzVRdRxRV2WAWjiXEGeVDpg=;
 b=HCItJkPN0wNhmn9n9kTPEXjUFwoeynem7ukMf0Eky+P6GM78dutIBGO73q02ZOPA9N
 bwXM4yvmv54igfLlII+xdaAhwwDkBABwcz8MStSQev3WwPJkLTZpdV9JgoUzNzcDHA8h
 AWCLRnBlmItcmzXuN/r9dkREkzg6jWIP8A0LoPC1adCETWz22Z7SJCTEI8/JNtpWdtEU
 rW9ahMLnsPMmx4zoKkdXowlBlqYKwLiXakek5ZdPFM5bWJ08ZkSMOFdgqpYaFKoG099R
 3KleY9EHlzT3mEITXrlFUtAVlUn/iHnOYnWtux3VpBacCyNJdRRl53SOfuszURKg9vu3
 fIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQImUUykBshNqHBWyp6suzVRdRxRV2WAWjiXEGeVDpg=;
 b=4Ekhty5zjad5cy83BB9cZsgip7MR0vOpWueGTrCV2YxHEKtSN4M8+VFnEt4uEIYvBV
 kXZ1i2fvubUg7ig/ul+wszepvCIJWHDqkx7GLjSuIVu8JuNSANreVDDRe9bavcO2eQJG
 u/58Twz1Q0MzoeYJAn9gVF8GAbCKNB4Tv0ps9T0W7RR+v+XG8u7vLxc5HJtCJAboffUA
 ui8DTjHeHw6z0/ctODirdxJymbUOl/Sxv8+8gmmbTqrT0JLesBbuTG9SilCZEQUMEcJh
 xUo3HsBIXQDP6YBZ+USlEbAZdwlk94zsjAzMCbgJGWfJHiiKGtFdQDAwd8Fmv/jUMx0l
 06XA==
X-Gm-Message-State: AFqh2kqMK8BixqkkfUKp23BBWgKjWxTD/YQMA9NGf0HxJuWa1CKHDd+2
 QrJgL/KSHvuMSM+GNq6G6wD2hKBEUubck8iX7Qo=
X-Google-Smtp-Source: AMrXdXucappSAecDqdX65fioKSLYk+bTEm+TsmXR7lw7zTNma53V/69LGtBtoQ0sC9YnPgfv4thUlETPK51EFQMTNY8=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr4660549oaq.46.1673015098104; Fri, 06
 Jan 2023 06:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
 <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
 <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
In-Reply-To: <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Jan 2023 09:24:46 -0500
Message-ID: <CADnq5_P0Nq-y1U5X4EgYyPSKXOdVsjxX+UOCmzZKnX8FfHC86w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 michel@daenzer.net, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 6, 2023 at 8:00 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Thu, Jan 5, 2023 at 3:03 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > That one should be fixed by:
> >
> > commit 9f1ecfc5dcb47a7ca37be47b0eaca0f37f1ae93d
> > Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Date:   Wed Nov 23 03:13:03 2022 +0300
> >
>
> Christian,
> This patch was written Nov. 23, 2022, but still not submitted in 6.2!

It is in drm-misc-fixes and will be in 6.2 soon:
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=3Ddrm-misc-fixes&id=3D6=
9555549cfa42e10f2fdd2699ed4e34d9d4f392b

> Why?

Patch review and end of year holidays.

Alex

> It will close my questions about amdgpu right now.
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> --
> Best Regards,
> Mike Gavrilov.
