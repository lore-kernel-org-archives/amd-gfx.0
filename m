Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B01BCD6E6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8661113C5B;
	Wed,  3 Jun 2026 08:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="x1Qs5+oX";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218CF10F133
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 13:44:09 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-68ae265815aso9263911a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2026 06:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407848; cv=none;
 d=google.com; s=arc-20240605;
 b=Zb2EN7me9XbzJ8QAsGU7qcunEQhaheWgmlwb20h6KK5LDeMSY74I0tKEuCGWYbbH8R
 +x87EWmlGWLV/yoowvNnzBlYlI0+PJMp8QbU4mkHovET4PdgZ3ctVA5DzR2GNHhv+mt2
 3qIejMfO4rYYonHnQ+rRBM1rqyByr+82HH86615wcvdHrKwcJphBxnD1GgfV/uwa+z7J
 hVnIRYapxzRBHifP+gQezo58ufwDHrxXayGdDMwZJoAyvWK10DL+Ka1BIAVqvnlfOw7w
 bPt4tru22IgQPGBM/t7cc63qQ1axQtdK6uI0HzZqC2lm8etfp9VW7v3temotipl/PdIz
 1Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 fh=SEy+uC980zvE2Gam7oDfeZCaBdiDe7l9uQPuy2N1Jk8=;
 b=TdNTtFeCTXQOH3xK4KC25JT4JgPdQQABi7eoWHZmKgu6hUixboVbAFon5PXnwzoDhM
 mGNN9fzRA9PxjnX0fe43nLmqDn/zPOPCSpZPpPAtk1qVFum13jnge4I8BASP4P232B2V
 lMKmmoVOBm6Q+3+JGt+2+VkvMWmzULtz8ENEgvPzuRG1mbVw9/SoOVGDhz73f+zRQpKf
 vUIbD4QnJHWs+lQxjQzRFkaXSsjbvfLw4G1gnVW1Bv+BKoKlI8kbD9OAWPejoRwEvW+E
 UXo7QW28bWtSvOEyzorYtizhlZUD9+qBLuIT5/TU9zVBbXowItYp5i2VnlHO87DC+FfN
 RVxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1780407848; x=1781012648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 b=x1Qs5+oXvzHsQrFTwhH892GFPI5RD5c+G+2ofea0/EjEbfaIjJw0YDitvjl4t7zdTl
 kBGJRCsrP2V9x2d90a9B7lKyG3lLRBfC6vqWoCemAst0Gec9aTE5umqPOFb1eUKOKo+A
 +zy5rs2Ee0oAp9ws9OQXZ7rUzygreSsxmChKYd/oiiciUm2G2XlHyIABWxaX3EVYUIhm
 AWVYQos0nJcWNkyHYPkQ7cbAt0R+SFckJ01KAG1fLvsBdV+JyTaox3Dhd8mi0Pr+sdAX
 KEAhZF/tgIi7RvpTy31tp4fufRE8RNvfJFIqYJqGJxPZ6EKkpstCeaNPCqA90dYneQZE
 IZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780407848; x=1781012648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82dEe/gKwhXZVRLk9OdQ2RS4d20ckRZa2yqh09EPZPE=;
 b=iEepgE7NcnFIhv2VmEFduHD3xbOTBTfzdtiEWrsxq24Hyo10NLmLf6xMkxuRzu/iZY
 3XWex+1B+UQvGCWbjisUYbsHtW49Cr9DBUhiDNEjc4kfE0TYDxGOzH5EGNOUEsSq9yik
 ibk/HCmVj0shc9ozK2HfvYjxG65OTQJ1uQ5nVBQJC2qZKArkfYt9m9qjPAVZmE1n9rpa
 zqwfXv+O9guD9otWGbV5TJ/GXGlX3iGGp44x6yWRc0M12WezngQhyyrUqrRxBn/smOQ/
 BFMHlQUxlcP+0BGXHxNwCF5t11+fTgX46OsKdq1mRvxslinkiCM0MWCBZFTGx5tKBmU+
 5gOw==
X-Gm-Message-State: AOJu0YwVd7TyTqF+gtEigcoZ+OEFTzpBp8+NNjCmeYd4mxriQKUO0YBD
 9nRfiZPGFfVKVsrNHA4hXCSsTb+UsoJPq4XZdTTeN0UGaD5AYqCm08+3/Z5ncvjopGUlvEupNTV
 ChKzvxImUc2ClMAW6rlorM8uxnKntaZdjty3GR9YH5g==
X-Gm-Gg: Acq92OE4POJGOUM5e5dEDdWTFlfdLKOFZmsDTeIg5GHNhWF+5mjS1fXb8yy9MB6je51
 DbF5okUiEV3rfBPNhDEbJZ8Qp4Ynq4UA6RE0mJv+vKIdYaTDRYp3OjkeTpecBPSJPuEU2afcyg8
 gb9kRlsjZ7LO6XF+Fbx61DAJ9EC6/RnelhBx367FFGM8ytdWKIqKxsyh7WZRlMehYmfc0oIxkGU
 I/H8KgQ8B52oUYAyqwmuAxaNbvKApPOj74mU9g/ALEGsi8K9nY0wf05UYGdzYykXH63+wCzLcCo
 lk6TWfnyUnA/d0wb2qXq/mK/RYDdg9OVvPtoSUprmzI6vc6Ib3KXRhq3YUm+1QcobRuXWTgEfDo
 8Ax9kE1vOgLPubW0hrX5X4Pcqud+zph2Y2e8biefW13nwp1U=
X-Received: by 2002:a05:6402:a50e:b0:67f:9124:8815 with SMTP id
 4fb4d7f45d1cf-68c8cc29ecfmr4897371a12.17.1780407848188; Tue, 02 Jun 2026
 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512190019.228440-1-guilherme.bozi@usp.br>
In-Reply-To: <20260512190019.228440-1-guilherme.bozi@usp.br>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 2 Jun 2026 10:43:56 -0300
X-Gm-Features: AVHnY4KfJ5TFV44CTzJXc_Y5_RuCxlXUjuKa27M2A4_OGavaoTMNEMI_WfjiQ1Y
Message-ID: <CAJgF-xu=wPXkdSD-HwjDheSWXvokcCg9nZ3_ku12=0N9i96yaA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/amd/display: convert GPIO translation logic to
 lookup tables
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jun 2026 08:57:50 +0000
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

Gentle ping on this series. Thanks.

Kind regards,
Guilherme Ivo

On Tue, May 12, 2026 at 4:00=E2=80=AFPM Guilherme Ivo Bozi
<guilherme.bozi@usp.br> wrote:
>
> This series converts the GPIO HW translation logic used by
> multiple DCN generations from large switch statements to
> static lookup tables with shared helper functions.
>
> The new implementation reduces duplicated translation logic
> across generations and makes the GPIO mappings easier to
> maintain and extend.
>
> The series introduces generic GPIO translation helpers first,
> followed by per-generation conversions.
>
> The following generations were converted:
>
>   - dcn10
>   - dcn20
>   - dcn21
>   - dcn30
>   - dcn315
>   - dcn32
>   - dcn401
>   - dcn42
>
> The dce60, dce80, dce110 and dce120 implementations were
> left unchanged for now.
>
> dce60 and dce80 contain special switch-case handling paths
> that currently do not map cleanly to the new table-based
> representation, so they were intentionally excluded from
> this refactor.
>
> No functional changes intended.
>
> Guilherme Ivo Bozi (9):
>   drm/amd/display: add GPIO HW translation helpers
>   drm/amd/display: convert dcn10 GPIO translation to lookup tables
>   drm/amd/display: convert dcn20 GPIO translation to lookup tables
>   drm/amd/display: convert dcn21 GPIO translation to lookup tables
>   drm/amd/display: convert dcn30 GPIO translation to lookup tables
>   drm/amd/display: convert dcn315 GPIO translation to lookup tables
>   drm/amd/display: convert dcn32 GPIO translation to lookup tables
>   drm/amd/display: convert dcn401 GPIO translation to lookup tables
>   drm/amd/display: convert dcn42 GPIO translation to lookup tables
>
>  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
>  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
>  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
>  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
>  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
>  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
>  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
>  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
>  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
>  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
>  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
>  11 files changed, 1274 insertions(+), 2035 deletions(-)
>
> --
> 2.47.3
>
