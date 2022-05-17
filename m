Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06228C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 21:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9681610E8E7;
	Tue, 17 May 2022 21:14:36 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBBF10E8E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 21:14:35 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 z15-20020a9d65cf000000b00605f064482cso2389oth.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KAm5oQA2ST4kd3Z7scLtWVL8/Ab645bSG3aByNeSTxE=;
 b=exIusoutCwsPSzH6KH34wn3PqeQfrXFL8VD5Q2XmsIdSqbQYl4HuEBCnGmpqqNJsmN
 z3HyJdLJ90Ok5w51wijIB+Pkq5PyI+2lGCgWlXNJr/GgvMWIa6S6yZ7/4WIztiLp6BOO
 08kzmmSItPY05a9KAhNLoJX1AQMWf8iL55BcRXBRPonFY14698saOrxYHZejKiGMWL+Z
 Isy3ULNqxNalgVoLRdgcD9F+RYNxolyoP+4LokBFKtkiPq0MtzTrEXzKbppnEAfgn3v1
 q55UgAe39h1MVrVc54znPUUHiWWCroJJ/wMKD4uffCviPKVn17SrD5H753fOJOU1L5KI
 27CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KAm5oQA2ST4kd3Z7scLtWVL8/Ab645bSG3aByNeSTxE=;
 b=fafzllH2kYsAHVN/+2pgpT4DCgShpg7P65AIRt3Lb4XZsi6OzOEL9eDPHlC3KZPyfs
 umml30+ZtA8ZC8XFtzX3slTMx7CRjnnUUFcjUXY4l/lGgnwBjnA5OD9/dlZaBrcfpYiB
 Ln5tRKdnn9hUatjV83L9UXKMszdEr4zrycRpNIjZQBzJfumhbYZ0eTUUV68enqGSKirh
 CH+RI62IrC8hr4hCMenHj9iwI+eplW2E4gnGb5btM30ubrg9RM22IrC/x0HllUGdndVp
 zB4piLW+6Fk2qjCein/Jo7VYtGquoz7yxHRpyfoHQMvtzIGt6/+tSzQhz2nD8K0w1Iki
 J5Dw==
X-Gm-Message-State: AOAM533IWUS8GpQj1go5pJctDDus3ipCUFmA75imR6evGkG72HW6Ot0O
 D9oTvXbewfXOXxEeBnpP5W0DPDn0lg4xfSh07c0=
X-Google-Smtp-Source: ABdhPJxKga19NbhA1bY+qynrBJC1ZGQafwqBon/jqSUkJGvziaRxj6fpPy4A+2OOrbNA2RQ/nj/ukKZWfu/9Jy1lnCc=
X-Received: by 2002:a9d:6543:0:b0:605:e789:271e with SMTP id
 q3-20020a9d6543000000b00605e789271emr9079210otl.200.1652822074921; Tue, 17
 May 2022 14:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220516192027.87891-1-JinhuiEric.Huang@amd.com>
In-Reply-To: <20220516192027.87891-1-JinhuiEric.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 17:14:23 -0400
Message-ID: <CADnq5_Nh+i90_+qnXLV9d5KNCaTVKfouP7OjRkc5LswyOSP98g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: port cwsr trap handler from dkms branch
To: Eric Huang <JinhuiEric.Huang@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 16, 2022 at 3:20 PM Eric Huang <JinhuiEric.Huang@amd.com> wrote:
>
> It is to simplify trap handler support for new asics in
> the future.

It would be good to provide a basic overview of what the changes are.

Alex


>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2527 +++++++++--------
>  .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  325 ++-
>  .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |  244 +-
>  3 files changed, 1596 insertions(+), 1500 deletions(-)
