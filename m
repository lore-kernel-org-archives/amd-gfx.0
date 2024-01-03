Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102DEC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96F610E2C9;
	Wed,  3 Jan 2024 14:32:41 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA46310E2C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:32:40 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbd6e37a9bso4139100b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292360; x=1704897160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsRZ3cNQ3EqD82mIk8czFvqiGF9TRQ6cChmJUBEVsTg=;
 b=EGt9s+22dDSlY1Onu+BtfiDNR+6lJkXX0kJVeM8ux2WttnHvzlBHxWcLBP7u7YFl5h
 /LtQv0OF3W+enUB3ZLqJvwD/XRNVtxdQ+upsPSXMvtAutNMNu9dnRPMSDzfNVe2k17YZ
 i1XL4g+MQXWWQJYGFGJA8HE/rpVBkf2fPlLYzDFigGpe/Y86+mm9Cd95ZNoxIY8tklmY
 xPKTOiBujep2PNXrJ01zv+EKZs7XDRInsgZ0F3ZNf7EvCAShZ/1CEtqTANHEaAuSdNTc
 1h8HgXg0mQpLL9l7/+0kfkTOhcTTcwMfWMnwlLPj32t2clqofQo+kbE5G0sAEtidO+xI
 R9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292360; x=1704897160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsRZ3cNQ3EqD82mIk8czFvqiGF9TRQ6cChmJUBEVsTg=;
 b=Rn3QdXUSB0yJG4eZTWXrZnW3DzzUCtFbwC/edTYSl9MP6Uy6mqR85mEAjIGmKyZ80s
 lEFc1wIJkizAiNCc54/aIzYOLxNwbaFF6vHpG8cXf9bJoTqFyzELkNTnfxlpQ/SgplCa
 JkBzQdj4WZ45MElJy6aG2FRXwrRogj2bmVIHIIDRvYB4aOw4GSGf+y7S1QZZPKHSsJDl
 gUOrnicVlwuqY7FKk3ry4IbRVRhkdAKeEX1UKikbga7cQ4NaIYzmXjPBQHQfilu+jml4
 nUrUUgg4ODPBcA+wpFlwsQ5BRGaj0XaVLwQy3PbkTjm7dOAz1qrZnENmFB/+09yUQLPA
 sY+g==
X-Gm-Message-State: AOJu0YxqhhoJFUZHyC865v4hIF+WmefsRTlGH3A2XYzol6kZTVZBphoo
 Y8YUBa5Nhrpc/rEnvQGmyv9CzZz76LY8+MJd9p8=
X-Google-Smtp-Source: AGHT+IFqSkkf3FG3SjL8/vx+fjJCOp31kYjhyXbcFtP+umnPZzfCAXVQ2YwSJNYrkgTVhJhzQk0q5vogp2DnoXrGtqM=
X-Received: by 2002:a05:6870:2254:b0:204:4a24:3a69 with SMTP id
 j20-20020a056870225400b002044a243a69mr21680123oaf.69.1704292359693; Wed, 03
 Jan 2024 06:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-3-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-3-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:32:28 -0500
Message-ID: <CADnq5_MesoLniV9jXZHWvFeJLFiF3AGYJTrMLn=mUDYPhXwO0g@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amd/display: Fix hdcp_psp.c codestyle
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Dec 29, 2023 at 12:43=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> Fix identation for hdcp_psp.c file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/driver=
s/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> index ee67a35c2..8c137d7c0 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> @@ -443,7 +443,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_=
encryption(struct mod_hdcp
>         for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++) {
>
>                 if (hdcp->displays[i].adjust.disable || hdcp->displays[i]=
.state !=3D MOD_HDCP_DISPLAY_ACTIVE)
> -                               continue;
> +                       continue;
>
>                 memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory))=
;
>
> @@ -926,7 +926,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_=
encryption(struct mod_hdcp
>
>         for (i =3D 0; i < MAX_NUM_OF_DISPLAYS; i++) {
>                 if (hdcp->displays[i].adjust.disable || hdcp->displays[i]=
.state !=3D MOD_HDCP_DISPLAY_ACTIVE)
> -                               continue;
> +                       continue;
>
>                 hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.displa=
y_handle =3D hdcp->displays[i].index;
>                 hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.sessio=
n_handle =3D hdcp->auth.id;
> --
> 2.39.2
>
