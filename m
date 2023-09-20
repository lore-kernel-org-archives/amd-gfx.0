Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE2CCE79CE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 13:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F5F10E186;
	Wed, 20 Sep 2023 13:16:30 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BE910E186
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 13:16:28 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c09d760cb9so4248548a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695215787; x=1695820587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ln+FI/7Xd47D0FCYB37l5H/ho3ovobGolj2OrABNd4=;
 b=cmnwpUxZ21Edh2YG3AmLzrUYiyfHR1RA7tcEz0SYIPZs0c1Y1smcQvN4lxU/dCSMHe
 RB+XRtOzj20ykUDUcJjbZYY1IVsLe+88l08qBSFzed6K5LAXqu4YAepmxhs/gzZIDUng
 hUtketwXJWzQCMs/AetdRHiDCFXGVDg9u5Xdz4ZSe65iNJEawym3dD7xowWHz8dhiiMD
 6ZyblfzemrDSpL4su4p3GYBVC14Ss4Fgt/R8Bv26HbxX5I5sbPNOm5mH1sU27y2NYEoU
 i8rFvBndvwMyugkAA4Jmai3mKpg37//5SAMbheqifBzpyvbc87egwjCMNgqhLWD0IFTz
 H6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695215787; x=1695820587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Ln+FI/7Xd47D0FCYB37l5H/ho3ovobGolj2OrABNd4=;
 b=Dv5Vi85eZcE29cAXEJbMA8GGat8pkQUfCRciWGHudQ5urQOkRkLMvdZOwKa9BDFgIb
 QdJwv+AN3usU5jxqxir93+zb4tjQ43+wjMkO4fedN6bAlQRSHUyFg2O0r6TJGo7gMtVo
 tfLIY3nDCuGns0Cs4uiHZab3DZjC0Ry1sIfeHZvIyOb2G1SABk01reDCihKB0w7gwHIX
 JtfXqY3GPTq9tgioFGO5intlAIg4tRaJdzyKtGj+BSwfRejiX1v1mSq8Tko8Qw0gpCvE
 zEpedniFRXPZ3FBJkHm3s/sp0nJwncmfYgB+2t4zcTMlBDISwRWZvfU6Zb1eY7bzz8mo
 1m6w==
X-Gm-Message-State: AOJu0YzOti25C5AFQlj4nnvs89zoGd42iFfqrJQIhpTre5IuHLa1SJS2
 8in5Yk/8npB0bttp0P4aItpVzllW0x37diWfTqs=
X-Google-Smtp-Source: AGHT+IHZz2t4t3klIwdDKUrqM1pHPhQ8urk4P842tGP6F2g+WRsnM2e1+pF1pkV66QTzo6kxm4UTwp4+cma8ZWzS9ks=
X-Received: by 2002:a05:6870:548f:b0:1c4:ee87:d3f6 with SMTP id
 f15-20020a056870548f00b001c4ee87d3f6mr2519354oan.50.1695215787599; Wed, 20
 Sep 2023 06:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230920002857.1802363-1-Qingqing.Zhuo@amd.com>
In-Reply-To: <20230920002857.1802363-1-Qingqing.Zhuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 09:16:16 -0400
Message-ID: <CADnq5_MWHwFxaRvHxiXUtDtv1LTsUm8VhKV=2ZVvFByLjkRo3w@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Introduce DML2"
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
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
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, jerry.zuo@amd.com, Nicholas.Choi@amd.com,
 IVAN.LIPSKI@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 20, 2023 at 9:11=E2=80=AFAM Qingqing Zhuo <Qingqing.Zhuo@amd.co=
m> wrote:
>
> This reverts commit 50003b5aa5f55677c7d4634eea755958ba6baa58.
>
> [Why & How]
> Revert to unblock arm and ppc compilation issues.
>
> Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>
