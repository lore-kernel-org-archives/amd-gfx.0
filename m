Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E02CC5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 22:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8996810E09D;
	Mon, 10 Aug 2026 22:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/l7q4F1";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B52810EA00
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 22:32:03 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2483138fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786401122; cv=none;
 d=google.com; s=arc-20260327;
 b=E7qCnZBi5oNZ+XTJrfCGLqo9reqJ8lSTbfgGORd9bOiEOmm+1hSZE2PyczFUk8MAnm
 CUIp5GtAr5F7GH3dh47daYOeShotXn3v1+VYsCJilKsy3SB55+/MNEGeXFGvEM0uXvPM
 2l6srOCG0i2h4FI88zgvWQNLm8UD6l8gPI2svRwymgCGN48o7PYOElaEa6E6IUOeq2Ng
 BzwAm6Uxf3Y9nnpkSYFvSLHmGZhEW+dQSZaIf2ewyZ6QppxPxTmaTeVJwlRWyCYh1jhR
 qGsgrPy0ydudlP8a85d9nENfhrQbwMtSiuId6mMftGDtEL7nydtcgcvCWP2Xssp7XgAQ
 sJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 fh=T9iK5wvcavkqyvVffXBdb8Md8noUalR5DtA16BzhEWQ=;
 b=Ov/sgMMl5IYtonOe3zovx8dvPPAK1Rj13qpjFaJckk92vQbUOpch7uQILjU2O5S9Zg
 omClt+C8u3LC7pdCJ9j3nGJopXSGmqtnZEINF5OOUObSOzTPeVXhAIzo481Fhu7AGb3g
 6GuEvVQ+ZPTbO9RyY8Ah26HPAbLy19jqj3kpYkOorTJN9KRJdeAbw4j8QjaWdn59BDik
 tbfc0PhmDNKrqxjQClKWdandOGR1nQyMtu7CGTaBkHMcyGq6Jl7JMcdRzbLstPPDjvMl
 0WB2Sihc/rWsf5Ec9xFbq3JjpfpoMDpdpTeBfTG81G89XRGCbQXfy7NCyTqx/mF3Hwso
 qwCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786401122; x=1787005922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 b=b/l7q4F1ANeRr1F0D+YASwmlUdm03H/niyRPnybJ7PJTzH+reqap6yrgf/uFsiFc/v
 YG1MfnrOxt0akbYT3PazyNXLqj1lZPEp9XfubVgelhAplvek5BXBRFmzdy9MtSVaS1Eu
 bGbwe8hNTDk48z7a4+GmzyYMQmz0Iv+br9Xx2bd90gK24oWx5VQhVE1adx9ZH4i+ECp3
 BqJ9RWqBnPCbsuK8+Nlo2W7BoUEQEuODhSWYvrwR7kbSDQ61xk+roy0jIpm/fWvWkBeD
 LAcK/w3tvWd5cYgwK4EVSHV9381ZPxUCkATOkNZhZEgWNrsaSbwabcpThNcaF4Jiti3A
 bFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786401122; x=1787005922;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zyxXtENBpyFNsNuf38voWr1wQ1uEtNHDyiKrmTqUuxg=;
 b=dZboYUGNxWALyrzLx/DmlGFiPjIiDTgZgUYtMbd3LP1v7G9tIzGXPA6PSKjj+/5jou
 aH6bRQbnY3DPjrWxc0dv9AvHbkmIsvdkrZH6ZbVwWMT8ByUJoLMW6RMC9Ff1TILnn6jT
 EdxWr5HKjfCpdXRh+VHfH1xMVoHz3bnSmnXiVYRbpifq7taalNgQzH5J8/ZiTZG1yaFu
 qCiF0AXPptXg3lbhQj2VXKGLTINW7LUAYOEnZG5H/Ii/OC9SjGts2SrjkuC4C0Av2Til
 8fpcPE1wRT6uFm0YEHTlS3O/Qe5EAX0elNDlbadva/WI/Dk7ROn2dnKhyorkZy37FmDq
 uV4Q==
X-Gm-Message-State: AOJu0Yy9zgf6tAgANOll+5APQOred0wJeB6Nmfeau9NEWFW8Q4slano5
 0Ti/vrAHlVfi27sxLRfGRP3o40PdCLlyP0k25sQpaOYhG2KbfcnYJeLK8o9hcnVJyp51qVf7yV/
 5td46rjuKGlbVi5eb3+Pr/WJaEYY++sk=
X-Gm-Gg: AR+sD13/W1MIhZe5JbcDHNyeM4KAeYO0c3AiwDTrBATTQKGewLQlb6IYVkUBpH2rvpQ
 rxwGRhNqEiHB6mw9uVwJsoWd83J5B3CxSiIwdItGoklfmJdjyw99v/u18MixC9lqcGUONyBu+KL
 wngcc+qailfPVewxgXjvmwd2f6GWH29cZYPGA8jHuN5XKnyPbmhF/2RfqI7pi4LRPtXmLEENsxa
 eaAckR1F7fl5Mu8PhJv0hYfst6rlfuguoLSgZ4M2vqZnevekXawt5yQkYsplO8u68RrQ6GFdpjb
 fwhGd5+E529f0AkKgRA2oLu64lQLcgNR2z5c+u46Ll74O43elf7TsSzL
X-Received: by 2002:a05:6871:eb14:b0:409:5241:8abc with SMTP id
 586e51a60fabf-459ffc96be9mr14219832fac.20.1786401122585; Mon, 10 Aug 2026
 15:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260807182724.51018-1-edu042sjroy@proton.me>
 <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
 <TfUyS8ZAROFt0PXoGV7cW9HCmJCeX30V7o6BJSHAQOkc5aUVRYg5x0Bzui1uOBd5b1jXlYkwajcV4Z0_wSDRSHVaAcnu8HbjDYqhGD6q0Tg=@proton.me>
In-Reply-To: <TfUyS8ZAROFt0PXoGV7cW9HCmJCeX30V7o6BJSHAQOkc5aUVRYg5x0Bzui1uOBd5b1jXlYkwajcV4Z0_wSDRSHVaAcnu8HbjDYqhGD6q0Tg=@proton.me>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Mon, 10 Aug 2026 16:31:51 -0600
X-Gm-Features: AUfX_mwWXSS48fnafVI5tybbDEohF5POqvdUB9mQHhCRVov_4uA_RvOrYmLge74
Message-ID: <CACNCB+=cv9gBMLKxz+1e8=yFCC4PbKR0z4sh_jVEXPif1PG_zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
To: edu042sjroy@proton.me
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, Ilya.Bakoulin@amd.com, 
 dri-devel@lists.freedesktop.org
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

Hi Satyajit,
That makes sense for the 8-bit normalization.  Thank you for testing
the patch on your equipment.

On Mon, Aug 10, 2026 at 12:05=E2=80=AFPM <edu042sjroy@proton.me> wrote:
>
> Hi Nathan,
>
> Thanks for catching the normalization issue.
>
> I initially used 8-bit normalization because the mode I was debugging was=
 3840x2160@60 YCbCr 4:4:4 at 8 bpc, and I incorrectly tied the CSC normaliz=
ation to the output link bit depth. Your 10-bit normalization is correct.
>
> I built and tested your first patch, "[PATCH 1/2] drm/amd/display: fix BT=
.2020 YCbCr limited output CSC matrix", on Navi33 / DCN 3.2.1 over HDMI to =
an LG CX with BT.2020/PQ HDR. The limited-range path works correctly with t=
he corrected matrix and fixes the incorrect HDR levels and color I was seei=
ng with the original matrix.
>
> I also confirmed that the resulting amdgpu module contains the corrected =
limited-range coefficients from that patch. My hardware testing was limited=
 to the DCN limited-range path.
>
> Tested-by: Satyajit Roy edu042sjroy@proton.me
>
> Thanks,
> Satyajit
