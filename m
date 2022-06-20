Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E8AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 22:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2D810F875;
	Mon, 20 Jun 2022 22:25:10 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE27210F865;
 Mon, 20 Jun 2022 22:25:08 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-3137316bb69so113489187b3.10; 
 Mon, 20 Jun 2022 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n93C0vcaJqb78FIO6WlUdPQXhs8rR4PY+fl82JmPDc8=;
 b=C41COq2xSle1WN6qys6phrTq+MeWSo6vh/QF8YYwrjVNtthF9sph75HfeYsMzf58JA
 BbcRURv/bfmvJpxT9slwyKhGCDjpFO4jRrE4EqhAvqzmE9KbBLXs/8PyUzo+8YYvdRwr
 xqmac0GESk2+14P6gEACxsxDmRWFMr6WbPeUE2pJ8XbhoADmomx61p7SGQ8n+XB/uY8f
 cP1uIFNX6nSLfGkcd8cTkCCIdXtOCrKWiywtsupj3Bcvo1ZOxGQPnwdJKYSo1gwpo0cA
 lHEz6z6a/s9KS96l3t62vf8TYVKyHRJSJut9CqZTsosVGu5uDx6tjSoneXyftw9WJK5A
 t+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n93C0vcaJqb78FIO6WlUdPQXhs8rR4PY+fl82JmPDc8=;
 b=2n30jG69wCqYNAXE8Zx6xj9D6VvLlfBA1qjeo58HlNbhS9b9leucObV7xcps3TfYlE
 +D5FmJ0sJ9pQsRXMKJujS2QcXrDMFS7q+UP+xOU4lS3DW8WkBEGRkd5k9y9wYYSSyg3+
 BmdV2oY55QH6XX8id4fxhLyIuldzWrXRUzT594MUWtHX0SkSuBRl3D7LIJaPcb9LoBW8
 6BcaH2oZyLrovtJURzV/v8hUkGugn2hVgAM2mMDUjsjHRkT2+5qv2XxKSNOpA55ypZQU
 DUbHqVTVBSdeg5p7yIR5Elj6Gs44bxQ82f9Csh5CHp/bOmHM0hpG93th9jcvvNTPDOhG
 pHNw==
X-Gm-Message-State: AJIora8+NylLtcF1ir+EtktuFbIddli1zDh2yz9AzZp09lsWhXs040ry
 k/OBWYoLDJksJPGpItxez1j5tXgR6YtrhIfWW7vxA4Ok
X-Google-Smtp-Source: AGRyM1tyRDWf1K91HpEWmpwV6SK4VX1oKf4umwNM6lWgTPMe9Ap4zjLbUs3lpNr9969Hy6e7qauG1rZUxVQZEEzeOhc=
X-Received: by 2002:a81:5a86:0:b0:314:1495:8491 with SMTP id
 o128-20020a815a86000000b0031414958491mr29754232ywb.419.1655763908195; Mon, 20
 Jun 2022 15:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220618015642.5958-1-jrdr.linux@gmail.com>
 <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
In-Reply-To: <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 18:24:57 -0400
Message-ID: <CADnq5_PrraeJ+ffvegLMWEowz2fUizGqBkwnAPYiK3fmV4E7jw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused variable 'abo'
To: Simon Ser <contact@emersion.fr>
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
Cc: Kernel test robot <lkp@intel.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, Jude Shih <shenshih@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 xinhui pan <Xinhui.Pan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Dave Airlie <airlied@linux.ie>,
 Souptick Joarder <jrdr.linux@gmail.com>, Wayne Lin <Wayne.Lin@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I sent out the same patch last week.  I just pushed it to drm-misc-next.

Thanks!

Alex

On Sat, Jun 18, 2022 at 1:38 AM Simon Ser <contact@emersion.fr> wrote:
>
> Reviewed-by: Simon Ser <contact@emersion.fr>
