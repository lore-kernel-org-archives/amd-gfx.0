Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0E9C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 14:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34A810E9C3;
	Mon, 13 Jul 2026 14:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glR+f9W6";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D82110E9C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:17:42 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cc8311c6ddso4664825ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 07:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952262; cv=none;
 d=google.com; s=arc-20260327;
 b=NDv2kh6Qb4vBRy06hRVfrCHmJ2qHJunuDPpfS01uCye9flPxVwN0hn2Ja4V9iSKL3x
 sMxQazyL81+SYJRrv7qitVYQhRxq99iVzV2nSn2Wa5w+igr5mUstwYuRToDrzeVLLR6z
 60btr2ujHLEAVEV44/btyOHKXKVeKlELM4YnnL75zWj3Z7ry5GqEHHqjs7nhSkTzNuXw
 AN3DSbUB6UNQZdcfNMg/X459PXkKP9E6772oAfQqwGoq8Nrn430oyF5NnHNNsZ/KacH0
 k9Zl4AzBraqEs4ugXWKbCYJPcV9H+gyjWMCPJWTEI1i0Ty1vogDnupECAyE2wm0EWPm3
 bt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 fh=617Qhbbr/F15eztTuXYW22/7QVKJPJfvN+/lyFDFHQE=;
 b=IkUy7sdIkjkI2jz53wJSL1xyZ3ZnbI/X6XX6MsIK43DeqFV8oy25f6pUJp1aKFhERg
 abCo+gIT9Gd6aTjonutG6dQggHLrC5tkXgCt+pof+aaIS4eUHGFpnh7DkSBkXTx7V6xv
 NoYeHNxElrBQERg7x3CfhKvit1w64YPHEquSJ4Pu+Ljh6L5t/oIS/7O5joGGCEICEfxu
 Y3XkTAh7ypXn5piRMhhHosQpDrz5Fj1mpn8BXTIhMzGHgr+sW9BeXNr7sCZK7mZiexlA
 LFSJCyWR9fhWfW7ItmUpl5cAa7xwIVPy5lb4Ui6dCQ8bpI33uVEb8stpEnmHwFG1+9T5
 WnWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952262; x=1784557062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 b=glR+f9W666PxY5mZ/E+9X9SJgdEC4M/MqbD9eZM7bsRZsRfQXiXm4qLcguvR/ZBNOS
 xeFLVR3v50G0HZmtVZZyulFXTOcvrh82ZCyrddQNPVT+XaU4URYpkPxPVVUr852ArTWN
 iqFof0KcbKTlV6I5KqyWvol/Vpfk/+k53AlON8103aWrDBZsRIuP4YfPCU6SjHshpLEL
 Cw9WJYdIzrJVOr2n072d777ERtSnExZYC6JFASEXXE+CckGPS83rFwodFb9BQL9XuvLu
 X7bIyJZMJGtXuC5DjTVceC4nfCPJCrV+e1EiUQ30mQE5KhVTe9nntkmasnNTaZOgnosR
 RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952262; x=1784557062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 b=IgM3SZLKn2VVw+iydSfOWjYA6A++HnVmE70eOsBqrDlKPA5zDgEG4XJnRVF6iEVKqa
 KF3QyjUvslhJh+RO0JH4F1sTwcxKrEkxxZMoCOxIAfrNSBqsShb8DQc83JT5nAdswMSw
 KjMkpA5vvkc0E7xvTk8EOqeOS5Xvwg5XhSgZ0XmgbW8IN/edyVsO7wxwG+gQNfIXU+8B
 zOU4sUydGikqgQNEgy6YcorgsOTxTms9Y6flR9loasAstQ995JQsoYH8ZQZ50nsT9oUg
 IPKTt+3sCuHjoVxIzTdnfDfyps9JH1qgeWqJxcxNbMwMd/RvUe/DMcurr11ZBnQdBObc
 ibVQ==
X-Gm-Message-State: AOJu0YzQqNtqktFr9PX39NNwugZWrQCgzz2egO3n5ulPZqdaEqJNEvr3
 7AWnklfq/XCQ1dcU7ANCKlpZGFyPGjDeQrvWbH5wYLy6iAy+55LWYt9MdzkFPCPRR1zsRMBqIXj
 OIiJ1rbs3TVaqT2TbbITwJxWrmSUGagM=
X-Gm-Gg: AfdE7cn6wQ0wyf3lQU3vTn2uU7PciWr92IUM1lq3CqXuQTm78+1EE1Bju63GxzAkboF
 g34FWNjnI/AolEPMLgyQxv+OzbnR84NAO/KFwLl6WMGHl3bT1t+bpEBYqvfoDBIv0C8yWmmBeSv
 U4Yy70Xhwy4IRuC8oqVU7+owDY9FTJ120W5Djsspp+WMkxnyl1dDKY/LOO673LLXSQ5F9mdoFUw
 MKBKxIS+Ilp69IPngtjqmRlGms6hrCt8xg58/06VYvOMoCEXyQhm+trekHwx8Pznfkkf3K3WBIr
 y77+tunCeceDxko3VYJMkfVtwZxGKi1OMXN6ZaEFtqBFwtfs0qAklbLb6QxK6eZDMW3JSw==
X-Received: by 2002:a17:902:fdab:b0:2cc:df15:91e2 with SMTP id
 d9443c01a7336-2ce9f1838d2mr77380885ad.7.1783952261799; Mon, 13 Jul 2026
 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
In-Reply-To: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 10:17:30 -0400
X-Gm-Features: AVVi8CfQIS4rEL1wc5ky61QejnpfLIm4aqhKsrQowe1QPdHtP2twCTzHwUMyN5Y
Message-ID: <CADnq5_Oga9bvHFdYgnq47h+-xznkcOOsi5U18CCaApLg9rSu9w@mail.gmail.com>
Subject: Re: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream
 encoders for DP MST
To: Andriy Korud <a.korud@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org
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

On Sun, Jul 12, 2026 at 11:39=E2=80=AFAM Andriy Korud <a.korud@gmail.com> w=
rote:
>
> From d37cbde6a3b3e57a5dc794514e77fc66e7fa8943 Mon Sep 17 00:00:00 2001
> From: Andriy Korud <a.korud@gmail.com>
> Date: Fri, 10 Jul 2026 12:36:59 +0200
> Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream enco=
ders
> for DP MST
>
> On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital
> DIG stream encoders plus one analog DAC encoder. When assigning a stream
> encoder for a second DisplayPort MST stream, if the preferred digital
> encoder is already acquired, dce100_find_first_free_match_stream_enc_for_=
link()
> falls back to the first free pool entry. That entry may be the analog
> encoder, whose funcs table lacks DP hooks such as dp_set_stream_attribute=
.
> The subsequent atomic commit then dereferences NULL function pointers in
> link_set_dpms_on() and crashes.
>
> Skip encoders without dp_set_stream_attribute when the stream uses a DP
> signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST
> fallback path instead of checking only the link connector signal.
>
> Tested on:
> - GPU: AMD Radeon R7 260X (Bonaire / DCE8)
> - Board: Supermicro C9X299-PG300
> - Setup: DP MST daisy chain, hotplug second monitor or have it connected =
on boot
> - Kernel: 7.1.3 (issue observed since 6.19)
> - Result: kernel oops without patch; dual monitors stable with patch
>
> Signed-off-by: Andriy Korud <a.korud@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5162

I've manually fixed this up, but please use git send email in the
future to avoid having the patch get mangled.

Thanks!

Alex

> ---
> .../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> index b92d4f378d60..beaf2e654672 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> @@ -29,6 +29,7 @@
> #include "stream_encoder.h"
>
> #include "resource.h"
> +#include "signal_types.h"
> #include "clk_mgr.h"
> #include "include/irq_service_interface.h"
> #include "dio/virtual/virtual_stream_encoder.h"
> @@ -992,6 +993,12 @@ struct stream_encoder
> *dce100_find_first_free_match_stream_enc_for_link(
>        for (i =3D 0; i < pool->stream_enc_count; i++) {
>                if (!res_ctx->is_stream_enc_acquired[i] &&
>                                pool->stream_enc[i]) {
> +                       /* DP/MST needs a digital encoder; skip
> analog/no-DP encoders */
> +                       if (dc_is_dp_signal(stream->signal) &&
> +                           (!pool->stream_enc[i]->funcs ||
> +
> !pool->stream_enc[i]->funcs->dp_set_stream_attribute))
> +                               continue;
> +
>                        /* Store first available for MST second display
>                         * in daisy chain use case
>                         */
> @@ -1014,7 +1021,7 @@ struct stream_encoder
> *dce100_find_first_free_match_stream_enc_for_link(
>         * required for non DP connectors.
>         */
>
> -       if (j >=3D 0 && link->connector_signal =3D=3D SIGNAL_TYPE_DISPLAY=
_PORT)
> +       if (j >=3D 0 && dc_is_dp_signal(stream->signal))
>                return pool->stream_enc[j];
>
>        return NULL;
> --
> 2.55.0
