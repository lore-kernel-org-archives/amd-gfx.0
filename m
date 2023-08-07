Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A1C001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1D110E31F;
	Mon,  7 Aug 2023 17:09:36 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CCA10E31F;
 Mon,  7 Aug 2023 17:09:35 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bc9de53ee2so3743969a34.2; 
 Mon, 07 Aug 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691428174; x=1692032974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jIgVnoueyGuoTJM9oRGaL0Z4KOks1NDKm3coM6a4k4=;
 b=WU6FhVPUk+c9/0ssmY04UuJ0eweh00NYg8GTji8wHIwKHCVTvv0c2zK1Ug/ujUD6gz
 AnmiDqgBtEyqV4LjOVhMKfL++6kaQljSu6h6VuRc8fgcNqR9iGqBBI98eJESYSCoYxAS
 cP9ZGSIxQjq6IWEArJc6sgnmEymepDhcI2SRsDtJWhZ1MKR3dNWIvSJeHWTUk1SsCjm2
 6KLddPTGeqcsV9V6RHHKDG0YeKXXyJSLRCsoz0kLDObdZcgp+8f0dSBAbjkvvD5Q8QR8
 lYPIHBcFrqIX2DGA1WAb1jluI3jhhlNvZrvmIOeqQOZnHoGJ23J08irJ5dDYO/F6XJJt
 9F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691428174; x=1692032974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jIgVnoueyGuoTJM9oRGaL0Z4KOks1NDKm3coM6a4k4=;
 b=AI/7eJ/03aqc07XcDVfHm+q8kIdISnMJyjd82GuJ7AvRo3iVHoVMCCtdb1EMKMn2hr
 roPMxAtm8xLZQxYIx7JavzvKuDKpFm7O2PdTRruDlYFI1oCnxidno/L7CdiwM1c7uJ2g
 u2w2fkldM8cmddYMil2GqRsf/+LYFRCglkCpYEHmlVuLOp/a778KR0qkEHj9QBHe7ANt
 jNbtmVjNpD9qrwhXRMtzEUMDi+kfS5To5KZJxoQqPkVhdSjoA+64eYJ/YlgXijObR4Ut
 ZHRCy+hhxaEiQvNdQqaUjaZfENZs3TWDL6RcOPH3N84HhE4zrBX+4kLUbv1izc1GvWz+
 dipQ==
X-Gm-Message-State: AOJu0YzJXnBUAklzKv2GwiMj9BR9nB/++YuM+OMepKndJVD5SLAILCAq
 gb3qfVp1DrcCLZoBgrfXV2d4bMfcf1TcF0WDbck=
X-Google-Smtp-Source: AGHT+IHLqGTWbZFxEncDmX3IyGHP0JHruWCMeH47oijw9u9DKLK1nQkjNfF5H4s2S7coBzII3b1PGff7l0Fpo5resTI=
X-Received: by 2002:a4a:d2dd:0:b0:56c:7120:8363 with SMTP id
 j29-20020a4ad2dd000000b0056c71208363mr9754624oos.5.1691428174605; Mon, 07 Aug
 2023 10:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025327.10370-1-sunran001@208suo.com>
In-Reply-To: <20230802025327.10370-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 13:09:23 -0400
Message-ID: <CADnq5_NAFjCLPr-6k7mn_G6TwiYgTTrYGZx-Xn2oqvcd6uaG2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dce110_hw_sequencer.c
To: Ran Sun <sunran001@208suo.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Aug 1, 2023 at 10:53=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open brace '{'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 20d4d08a6a2f..7f306d979c63 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -219,7 +219,7 @@ static bool dce110_enable_display_power_gating(
>         if (controller_id =3D=3D underlay_idx)
>                 controller_id =3D CONTROLLER_ID_UNDERLAY0 - 1;
>
> -       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0){
> +       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0) {
>
>                 bp_result =3D dcb->funcs->enable_disp_power_gating(
>                                                 dcb, controller_id + 1, c=
ntl);
> --
> 2.17.1
>
