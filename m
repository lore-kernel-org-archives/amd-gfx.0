Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19285606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FGEK/F05
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCA210E109;
	Mon, 19 Oct 2026 21:24:56 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB2510E109
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 21:24:51 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3550dd02c9cso212011eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445090; cv=none;
 d=google.com; s=arc-20260327;
 b=TmIoLIg7r6F6+BNLDjOIFkPxqt9g/fYi+PZCwReO5XHncwg9XJubgK9GHvaA9zhsQC
 yIibanU9ldjbQm5Oocxk/zhVUVGM6qpDpse5DvGJIpojTCRBT1NLk8IM8SnnWA/otf0D
 /c6du2EVqQwbmhWKs2sclRqhGsrL0hZ8VlZFnt85HzDMAJg2qthQpDtjsk0/qwnI5PKT
 96htrR4jkRfiwfbWWZM8Bk5wguZyTifSn/v4pddh0g03n+KOSTcx5mVfiwm+cpD3L6XN
 uBjO3NrEpMGcUMhYhVHcRW2A8ZW6i8TI5/aPmBMstknsotV8kcIgtw+fMbJtKbhNzURj
 tKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mf7LeEZUtIuxB50fKJ9WLfc1Te7R9CQwLUn2gg70m3w=;
 fh=SIauy9BUskq3jBjJBUgTZ46ItUS65nqA6MiA9UKRM1Q=;
 b=qBHKC4hY+QEAlOBeWT/6N/sy77hO5aHNS5TtKB/L750Zgv9/ceGzBSa4DnpOuJoAP9
 6c9J9y1RV39uNEECszmQ1A2uWkQEhKnQb2afK1iwAHI6+VV8HilSO7HXEVl9k9LEYuEx
 NrFMq92SAOsswFOsqVEvIOxinwgOevXLVTyXQ5jYHLna3QG5WH02ettaO21XtAbPqcUv
 QZVrCXg/RNvkWzkkbQL9QF+kzCkCxYzAqqhUcDKxjtNHvo2Lx/wXpFVE9Miaur+gQtcd
 uAjOxv2kM7Y+UExtiX09GSvQPzkT3UJHIQt4IlGbryVSkWPKININNfwUMC6tPOznJw5A
 PRuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792445090; x=1793049890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mf7LeEZUtIuxB50fKJ9WLfc1Te7R9CQwLUn2gg70m3w=;
 b=FGEK/F05e4Ov2wpYT94qhcb8A7P1Jk02VJraO9KHqS24XaXbFXf2AOYgSJ3FxDa3MG
 0NFifbUZLu/j7rbpI85WXD5CywlSgMBElSrr0L5I7a44e6tE1mjMKZyvbeHUN5Cka20b
 1WK6HLaf2kXTESQ2L5m4erkGHWnqy8sJbRErnBjX8cPyZTIyEK8M+H/jRTSIL5T8H6nL
 bmsRrOcXcoFaN03fA3K5RE7QTaCXo0XC9tcuOaQMtpyM0TJm3KfiBvDhuQ7ho4Heus71
 1iag4bTTMRFpqMXNfXmGQKiVoQ7bTCuXfmtD3kty/X6PNIe0wTmx47yC3x6SHVSJampS
 R7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445090; x=1793049890;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mf7LeEZUtIuxB50fKJ9WLfc1Te7R9CQwLUn2gg70m3w=;
 b=rFHfwru7IIbflSWMc2cktJZseeusWNGqsOgpxbUPvy9Dpl6iPmH2BHA9T1AT27gx/h
 ve8OFE1Tmen4B4Tz7anGZGng27dayVeE+CU2y2TJIsyG2eeM9tpIGRLzn03D4xj0d2Gn
 2Ye0itN/Ejg7SBWazkzHxTFhOKj7/VUyfLOgehKm6uwag9aU+DWOi9QqLbTnl00BJd6f
 eDK9fT0jsc40DZtr3JNUeTgDRLH9XX/PVIOBrXoIQjEmGqrEcC1moihCv1HSXDEzA2Kk
 OhazMZnglxssxaHIkXQGDr08nmcrMv/pngmsBb972YcPpQxTBCzWijYdmOmR7eDB9xMn
 +7aA==
X-Gm-Message-State: AFq9FYJpKYEl6SfytMIbLf3kjK2dHVD5tCR6PTJDKczIBYYNQ3peIbkH
 VkeTI+cZbm0UNRYYM9n4VNEcKRhZTytY/xakI1mA0gS/xUD+DpFpKGwP5gSpJlRrjL/lqHTbL2t
 BlDvwWwBt6Ay6eEc75EAvkORp6giJL2Y=
X-Gm-Gg: AYBFou1EF1yGM1TyyjyaAV6V2zTtyLjbqOKB2uhMC5fcx6rnXypZ6TxYVaUxRZp9yOw
 KhjQuTNu9HukZWnv0kfB3qoXfb5Y3C8wKzsn7jWvWnzvImFWHFb6el8Zb/aNVi0l3FZ0ZZ0NmAq
 OpAXlEwiqUJJafbKAYl+nCdGKJ3F0Ggm01nW/sz+37EHFbO/wCx9WsSaQrjZ2vtVB4+nKPGVUhv
 yvDCjjHD6XczEigSvoxL+UY/AqQDwJWY2cDYPde+rBwxEVa/NAhpAv8L/c/kgN8XKZMDHB65Zt3
 rNFKP4AUilK+skNd4MYAloQfSD7H45LXaV/OZNHeTiLKQqXkGI8yng9zMnCcnXskKdqVL6FWVOe
 ZPGtmnHsh8vii8FlKlMmpbrcGeCE3C+eTn27WDFJkpw==
X-Received: by 2002:a05:701b:280f:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1850fa07d82mr16560508c88.1.1792445090313; Mon, 19 Oct 2026
 14:24:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016031636.575385-1-luigi.lauro@gmail.com>
In-Reply-To: <20261016031636.575385-1-luigi.lauro@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 17:24:39 -0400
X-Gm-Features: AclHuK-YEdHaW3jxdH6fVxaorwIe1l-0S0E3f87MGgvaGT1lwZ4_5URn2262TpI
Message-ID: <CADnq5_O8kPTC8F-hub13z2PonEnGLbet2drZ6aNxrHDBjvQh7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: take a runtime PM reference only when a
 CRTC turns on
To: Luigi Lauro <luigi.lauro@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 5:11=E2=80=AFAM Luigi Lauro <luigi.lauro@gmail.com>=
 wrote:
>
> amdgpu_dm_commit_streams() takes a runtime PM reference for every
> active CRTC that needs a modeset and has a new stream, but
> amdgpu_dm_atomic_commit_tail() drops one only for each CRTC that goes
> from active to inactive. A modeset of a CRTC that is already active (a
> mode change, or anything else that needs a full modeset) therefore
> leaks one reference. Once that has happened, the usage count no longer
> returns to zero with every CRTC off, and the device cannot runtime
> suspend again until reboot. The two also disagree the other way when a
> CRTC turns on without a stream ("Failed to create new stream"): no
> reference is taken, but one is dropped when it turns off.
>
> Take the reference in the loop that counts the disabled CRTCs, on the
> mirror condition: when the CRTC goes from inactive to active, which is
> what the commit that added it intended ("every time we enable a
> previously disabled CRTC"). Each active CRTC then holds exactly one
> reference.
>
> Tested on an RX 9070 XT (Navi 48) over OCuLink, with the change
> backported to 7.2.9: an unplugged connector forced on, then mode A on a
> CRTC, mode B on the same active CRTC, and the CRTC off, three rounds in
> a row. The usage count rose by 3 with the stock module, by 0 with this
> patch, and by 3 again after reloading the stock module.
>
> Fixes: 97028037a38a ("drm/amdgpu: Grab/put runtime PM references in atomi=
c_commit_tail()")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5951
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

Thanks!

Alex

> ---
> Alex asked for this on the issue. It differs from the change tested
> there, which only skipped the get in amdgpu_dm_commit_streams() for a
> CRTC that was already active: with that form, an off-to-on modeset with
> no stream (the "Failed to create new stream" continue) takes no
> reference, and a later modeset of the same CRTC with a stream and then
> an off drops one more than was taken. Pairing the get with the put
> closes both.
>
> Who changes: any system where a CRTC that is already active gets a full
> modeset (a mode change, an HDR or colorspace change). Today each such
> modeset leaks one reference; with this patch it takes none. A CRTC
> turned on without a stream now takes the reference its later turn-off
> drops; I could not exercise that path.
>
> Also tested at rest, on a boot with no leaked references: with nothing
> using the card and its connectors never probed (a TV is attached), it
> runtime suspends to D3hot with this patch after a forced wake, and the
> usage count drops to 0, as it does with the narrower form loaded before
> and after. That test runs no modeset; the rounds above do.
>
> The change applies unchanged to 7.2.y.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c4fee73a0..605f289ac 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4707,8 +4707,6 @@ static void amdgpu_dm_commit_streams(struct drm_ato=
mic_commit *state,
>                         if (dm_old_crtc_state->stream)
>                                 remove_stream(adev, acrtc, dm_old_crtc_st=
ate->stream);
>
> -                       pm_runtime_get_noresume(dev->dev);
> -
>                         acrtc->enabled =3D true;
>                         acrtc->hw_mode =3D new_crtc_state->mode;
>                         crtc->hwmode =3D new_crtc_state->mode;
> @@ -5292,8 +5290,13 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_commit *state)
>  #ifdef CONFIG_DEBUG_FS
>                 enum amdgpu_dm_pipe_crc_source cur_crc_src;
>  #endif
> -               /* Count number of newly disabled CRTCs for dropping PM r=
efs later. */
> -               if (old_crtc_state->active && !new_crtc_state->active)
> +               /*
> +                * One runtime PM reference per active CRTC: take it when=
 the
> +                * CRTC turns on, count it when it turns off for dropping=
 later.
> +                */
> +               if (!old_crtc_state->active && new_crtc_state->active)
> +                       pm_runtime_get_noresume(dev->dev);
> +               else if (old_crtc_state->active && !new_crtc_state->activ=
e)
>                         crtc_disable_count++;
>
>                 dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
> --
> 2.56.0
>
