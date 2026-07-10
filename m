Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1817C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296CD10F8EF;
	Fri, 10 Jul 2026 13:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dve8sXe7";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9291810F8EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:38:37 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c9d290216d0so36923a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783690717; cv=none;
 d=google.com; s=arc-20260327;
 b=eqahncVLEhW0a2QmxrPpzBSknvUInvHn/Y1f7widKGxZz77LRt5v2iSqWK2JzqH99s
 oANVyfRhmdLGF6WSDAKoisvnIld6zpS+YVcslgHo6NiWnfFZt7nQ1Z+17wKZcAOjfzoC
 49wKNRry0FuTyKORS2d4v3HFDXB44LMNERTSKocaThJpF69aiZ55MvMfjAaguhTbVE9w
 nXvpd5pCXoWDdnvcusEvWeC5A6T6UMt+yLz49VcDhzXlg22n16LEeeV2qMSTgM45/FPv
 cftGZoByVxoyPvs38MqacpCjmRVB0JTrMLPmg1jrUqDnJEgU3UVOMrFnOkrDJSIPlduH
 Xfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GtVgo0Th6N5kIT7EHs1GOg24WxHLmb+gBKLJLX/7D3I=;
 fh=6oLe7oP4H8RQG1yT+UffGbVNYbdYTb5So1aYgbIc1Yw=;
 b=WTb4Kzh2bOfeItMx4vB0YRPo96kDnsZuy4zikrCDSSb4T7oVzb24Qza4pRotVOud/C
 G2rhB+Ylkxvr3Rqx8Vo6nFuH4Q5QrjEapVpwmee0qRvkHb6I3wU8iU7F7u055JxYrr7P
 O4adxZ3udhQJASrbV8kqXBNS905qFnK77RXGaqA4KYjoej7O18dsgnfUDpyD/WtzmkOX
 V4LRn+tsDUGJvMtIc4y0cg6FUkMjMcJddJHrTHkJt7Wo3lmVnTFicILbGJuVtJxq5UPH
 tKP6SMi09HN75nFresIX98YEP/hphO99G5xCV4pE72UiEs1zOWYQ6KOG39xUzjoF7kcn
 mMOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690717; x=1784295517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GtVgo0Th6N5kIT7EHs1GOg24WxHLmb+gBKLJLX/7D3I=;
 b=dve8sXe7kDjAasSEADlBI5vqlDuIKl3K7OvYqynn92nELG+gUR3/Em1xVmWPcPcQ3F
 rKMkj/YeyFZv2wcNZfBrfPxOGR7QTzdXNbbkA0eeR5bDfkTUtSQYdQ8y+Zg3OVYl0eA8
 WBoOLk7LcgqAZ7Qrdzk5H/Yw3GwK13JSzwNt7lEmg8cJlfax2Yr071AXwv9PDXG5LbvF
 GuHA1wzjjXgmebbVRCe0WjjhR+myH2+Q9+sbAirRrT40dYrO+4fCGVJIP3UoSGwrD3x3
 qRyfTcswBVISXY0LsYtpPNyd84ust54u9D2QB4aJ6mhdfe5cr8MiJX1vqZqY8vruNNxf
 fn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690717; x=1784295517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GtVgo0Th6N5kIT7EHs1GOg24WxHLmb+gBKLJLX/7D3I=;
 b=T6esTNafQJ5FdGH3gC0GMsYe7HWfBSTH4x+0pxD+q6B983VrfU7VjT9ci4JJzISR51
 sIPjnIjbHHvRC6bi5sM6L10jAUz+Mndtf1eIZgC2U/VZdshkfSuLjQjhYtO8fO+wWon7
 iloBJt3+DV7N0f7AbQ3Gy4NpzVaSkC0jH+AFTmF/i30K8UgZ0tSwHkYmNE+ERu7WuE1A
 8lC+cqeYBFmhvjXJ0IRMj9+rqQzyJaIEgpWfzUJ5x9qSL0uHwTJzBVA45BOKx8XmUQNV
 6wtZdTTvPNKPr90twP8qUWBmMDKNCp2my0fuqabuI6nQCABFkV+oL8XKokBrhoZu9Qw+
 727w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXHvPlWOq+Ha0zkyz6n0JKO7u5hNw2bUQVc3+IH2wPSqISLmCX+YxOOeCto7mSjHJrvEyGSOIm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM1dinHyz7At7/RZ1MIod7dmgXmwAqcA7XRrcako2TqlguW0WY
 Xhbz3hWPdqwxc4Q1i85NhxmgP0gsII5pFSimopFPz2rnVIddL5DjifE7UMkoDD5WOjtwCGsqaA2
 GTHTZJE2VSTLj+sJHqEtCW9Ej4/9/O/A=
X-Gm-Gg: AfdE7cmQ/tn5MnMeGiUMSsRRaXzAG2EJQbM6D6ZmOFpUa7lR2matnYyJ72w8N6QvacL
 td4R77W86JPCJrjhXfyGQMuQJAk9rjjVRe2bqtPJmUnTAikGc2K2z0LAD5jmVxjBFfxTix1mzKd
 6d9/0exH3htuKnEoaMrfMTOIH+BTNJQjUUV73IqTBZkpWY6qMlAqy2ips3XDaFzD5L3RiB3WqGM
 J/MRkY4TPYSBQus5viDiaAnzYlUBVzfbJOsZLx0vUD7jxlrNlKLdIxK3kDo82Iwbyi639D9p9qL
 RdtDhR951KFoSQub3bLLG9Z1Wk220qlEJsFvKgnYsqhVCIrzCdsyi2G+IzQ=
X-Received: by 2002:a05:6a20:12d2:b0:3bf:a543:e7da with SMTP id
 adf61e73a8af0-3c0bce50f42mr10058862637.3.1783690717085; Fri, 10 Jul 2026
 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_C3A258C2204BBB82CD35C736076BFC07F806@qq.com>
In-Reply-To: <tencent_C3A258C2204BBB82CD35C736076BFC07F806@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:38:25 -0400
X-Gm-Features: AVVi8CcIkcfNa2DCX0mu7HJpXgHz6IiaY0GlK5uHI4fiH4DPAuGheYhUESnl-Tg
Message-ID: <CADnq5_Oyyvn-PB+1Zwtd1Vf3Lb4MqyTwh_i3o1kr3vKP=GsuVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix __udivdi3 link error
To: 2681643870@qq.com
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, oushixiong@kylinos.cn, 
 yanglinlin <yanglinlin@kylinos.cn>
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

On Fri, Jul 10, 2026 at 3:44=E2=80=AFAM <2681643870@qq.com> wrote:
>
> From: yanglinlin <yanglinlin@kylinos.cn>
>
> When compiling the AMDGPU display driver for 32-bit architectures,
> the linker reports undefined reference to `__udivdi3` in functions
> get_dp_dto_frequency_100hz() and dcn401_get_dp_dto_frequency_100hz().
>
> This is because the code uses 64-bit division (/) on 32-bit systems,
> which GCC cannot handle directly and instead tries to call the missing
> __udivdi3 helper function.
>
> Replace the raw division with div_u64(), the kernel's standard 64-bit
> division helper, to avoid the link error.
>
> Signed-off-by: yanglinlin <yanglinlin@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 7c293917e6fd..9dfb6f132136 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
>                          */
>                         modulo_hz =3D REG_READ(MODULO[inst]);
>                         if (modulo_hz) {
> -                               temp =3D div_u64((uint64_t)clock_hz * dp_=
dto_ref_khz * 10, modulo_hz);
> -                               ASSERT(temp / 100 <=3D 0xFFFFFFFFUL);
> -                               *pixel_clk_100hz =3D (unsigned int)(temp =
/ 100);
> +                               temp =3D clock_hz * dp_dto_ref_khz * 10;
> +                               ASSERT(temp <=3D INT_MAX * modulo_hz * 10=
0);

Shouldn't this be UINT_MAX?

Alex

> +                               *pixel_clk_100hz =3D div_u64(temp, modulo=
_hz * 100);
>                         } else
>                                 *pixel_clk_100hz =3D 0;
>                 } else {
> @@ -1285,13 +1285,12 @@ static bool dcn401_get_dp_dto_frequency_100hz(con=
st struct clock_source *clock_s
>                  *     - target pix_clk_hz =3D (DPDTO INTEGER * DPDTO MOD=
ULO + DPDTO PHASE)
>                  */
>                 temp =3D (unsigned long long)dp_dto_integer * modulo_hz +=
 phase_hz;
> -
> -               if (temp / 100 > 0xFFFFFFFFUL) {
> +               if (temp > (UINT_MAX * 100ULL)) {
>                         /* pixel rate 100hz should never be this high, if=
 it is, throw an assert and return 0  */
>                         BREAK_TO_DEBUGGER();
>                         *pixel_clk_100hz =3D 0;
>                 } else {
> -                       *pixel_clk_100hz =3D (unsigned int)(temp / 100);
> +                       *pixel_clk_100hz =3D div_u64(temp, 100);
>                 }
>
>                 return true;
> --
> 2.25.1
>
