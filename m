Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED941CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8705810FC83;
	Thu,  8 Oct 2026 07:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ImWKRJJP";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479ED10FC83
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:01:54 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-8249ca723bcso1706389a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 00:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442913; cv=none;
 d=google.com; s=arc-20260327;
 b=CnE3trFx9tHXlVlqykli7GBeU/A+gm6R4UIoGEr+dNhq2QJr3ob58Luj4uX4WM6T8U
 TJU4DgKvwS4NXwL16rcYSmiw+RCanJBaOsLOgtwf6vlWgBprkjUtamI3xVgiypRRB3eI
 rXnT3jLZ2a/bAsycLBmk9qePefF6WK8ZHesJX3WteFITb0CnC4h6nV1e6rlaDdNb80i+
 jsYHVXtLrk5/D8VlS2mSzUVHkCtAtnufswrMuGVk+WxuJOnsxCb6khXGLkBTAYS00GLo
 PqXfO25g9fBpidu/LBdeV/e7ak60FDfXf578dGhtmSw7WZx0HNyu6WZk/BFqCEYeZYPi
 dt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 fh=D/7sZNnZ7A2Ak0Sx9iKH49bi9ryjhqxDy70XYIquN+I=;
 b=Ggezl3cBT+TtRHOGEOjaL74g+KNeWBcnXSfxzVaSnBWXocdLIItEmiIHrj9Hu5YZfY
 dCvFyRTpX9xPOYpTk7+6Jt2myR9lEm+PwqLKGPzeJvb/GC87BRMFhMntJTPUc4oMKtAp
 9nGCvUWNG5HexzRjJrPAm82/nwnUWp+VzSUMG+dZwvrXbYI3C+JYly1ugXUsXdt8Uyel
 rryTAlAvaBwbtr3vKBudWLyZMnPNCsfJ06DbNNUMlL+J25XEKk11aZt2iHeXO3loduE1
 0GlZXrjy5YPlBSoidd75sl77oq4y1cWlVRr7rFkK7wlUG559szCOa8qS2zXoUOzFsmDa
 1dWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791442913; x=1792047713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 b=ImWKRJJPrluEkjJ+Vfl4+BhunI/0RAtwetIbiYKViFQsCvfUiRR0KV941L+8OmHQR3
 qs3AlACFooCqe/4ySL8ner/qQ5v51y/OFWsxUkPETbWMJiYkTZeKOOR0K/tIhNYf8yn0
 oNQRETa8OZ26tJONeApTMuwrp83/K5ogJWOC6cpiyW7CNX/GuGtkJW5F2k2/MV1EgURO
 njrIGgGh6ecR5fAP83eWFyf6TZ6uODF6UTNAAWPnuPRxKol90oo7amqg4UoTS5z6NkNm
 iFE3PWgGw3OGTXFdB63QBoGJg12NwZqcg0nLU4bxEDLWlsxal8oIkFcPTU+fbUKJ4mmu
 lKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442913; x=1792047713;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 b=gAPgFS9TKWapkfcKkNKfH14NlhWnkRHnJF5jw8cvCK+AO4DqXXSlGv9zMO0q1cC5uV
 MKMzgTUQBFOXCDoo4yC17/2vf1HJx9wa23VvWbDME6pwR+n0xFQHjmRN+OBaKCUCrIfi
 xZbd7s9CqEM+yxkiN77KqOq3kVCdrDNF94mVo473qzqx7UOy8Atoi1T9/MSkUqU+gZWz
 lpLgO91cVZeoz5L7SxMdsfe/wnwILAi4B4lhZpHuEBLfhL9Xm+KGvm4yy40ajs1QNWGl
 AUOio7wtv0xwwW/5GBQbWHzjygW7jzxNqUPrykxQwakGlnBFnO3bwV7NDgAxtj0/ih1d
 TpAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLOLdEEWjCMFwZRXoKXvWNzuobFbjvrGGDve5ypnh/JGtnEewxcm21uLj10WkSaRP2kIj2ezhh@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxcmAgufNyaQWxw5klkDfczUzi2UuIR48jYieRP1bnyRmPZnhQ
 J+nZPAnHBYhHVl0CqqBjkkpR/OJs6N4Zmvplm4kKvQAGWUnOnYAuSqCIQGPNAJ1wzZlUBTMQtWl
 b6jdFYjIxjSrk+1CYMErTmzZ3ueKFfPQ=
X-Gm-Gg: AYBFou3wHoA7KrT8DzjAZjklWFhk/AVVEVJQQEqwYa6EDylmAj9Hxr+r18lPB9CCzFy
 60N8R0PgTtDAnId/ZUAqSfpKQY4U00fqOon/ehor/NmStBOiaK93KwKmIQa4Hs0H+OA5MqWQkya
 hPynZMGuCWztNCbciZy5yOxPn7i5mcaxa1PAEbNru4yg7EfY4EUnFsnHzaAhj/VOEK+O6QEyHme
 a/IHr4mY6i0h2V1bqfoQFsR1uRr0ZYn4ICEeSHdbQRpKxzQZdBQ8qUudSajsHCUbzdIagW1/hRn
 A1csNGNMyqbQKqtS54/whIx6B/ih0uDqkduZlO2g82q49DLRT/erm/EHeiWGB2vXxJPAGVvPAtM
 kqX18fl5Yv03NzTYKsv79TRvrxNapXfuPeXRqrmNHSN75XLFy1l1s
X-Received: by 2002:a05:6830:25d3:b0:80c:d30f:97d with SMTP id
 46e09a7af769-82ad16d6194mr5557685a34.30.1791442913372; Thu, 08 Oct 2026
 00:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
 <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
 <CABXGCsNQZY+g5AB17yiZP4aD3eKBpNWWNqcOL3_eh5JLxp=H3A@mail.gmail.com>
 <IA0PPFD4454CAA918D3DA3D71405C9C7FD6FC932@IA0PPFD4454CAA9.namprd12.prod.outlook.com>
In-Reply-To: <IA0PPFD4454CAA918D3DA3D71405C9C7FD6FC932@IA0PPFD4454CAA9.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 8 Oct 2026 12:01:40 +0500
X-Gm-Features: AclHuK9yC09SUFDh4Mtny64tXmLQQDmS3U1PZKcvsixYfz550FQvCb7EW7S4RLM
Message-ID: <CABXGCsNGmbFYB2FtAi6Hzn-jPTy6YG7P_Y82Qe4hi42svcq4xA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
To: "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
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

On Thu, Oct 8, 2026 at 7:25=E2=80=AFAM Lin, Wayne <Wayne.Lin@amd.com> wrote=
:
>
> Public
>
> Hi Mikhail,
>
> Thanks for catching this!
> Could I give another patch that will include this fix along with a few ot=
her DCN fixes, please?
> I'll make sure to CC you when I send it out later.
>

Sure, go ahead.

Please keep "Fixes: ef45aaf73717" on it, so that the fix also reaches
7.3 stable, where the WARN is new.  A Reported-by would be appreciated.

If the other fixes cover DCN2.0, 3.0 and 3.1, which the Sashiko review
of v2 pointed at: their offset headers define all twelve CRC1 window and
data registers, so it looks like the same addition there.

When it is out, I will test it on Navi 31 (DCN3.2) the same way as v2
and reply with a Tested-by.

--=20
Thanks,
Mikhail.
