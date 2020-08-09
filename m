Return-Path: <SRS0=+Fjx=BT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE94C433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBD7206A1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLoyquRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBD7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761A6E115;
	Sun,  9 Aug 2020 23:59:03 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB936E170
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2020 02:11:01 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id x5so4760274wmi.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2020 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=KpAo+FfJlilkpAREGzFNdGpnqlhg3TDH8XYFS3haQrQ=;
 b=jLoyquRcjzflBE5UT+eONKMUX7r18NEx0dzv0pW8Xg01jtuN8tS2ZCahvOlxUblfku
 xfDkyPMZdV8DFG3nFniK97PGFDxpLV6B4DHCVyFZ1YydmRJj1scd7+a5XohNLoCnu6xm
 LUjC0NPMZ8YHUzwtMOXET/hjFvOwVpo/BsnJmjJyFQG6g5vW4AlBY1TPue5XLpxsJdig
 R9BTrMzDqX5CGvXUnpZRjy+uXBPsCKLJrXKkiTnO4ROVmpb0VYXhB8DkrsD2pgz51yUf
 OJhoHpP0O0HbJ4iN0+qRp1uSbj9nFrKg9jgey216hxGMFF10HXGDrAEmvZ5Iuk+3tcBr
 h7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=KpAo+FfJlilkpAREGzFNdGpnqlhg3TDH8XYFS3haQrQ=;
 b=OIaPXneA4KzlOjnfNVoILFX6kQJIL/MbD3YaBB7quljt0g4aORDn09LFMoul8QTSn8
 Tm3It1l7pTXrZyJqtiNDme1OecvA1he71KqZuor/INDA6iNzyA11y1Yj/ItO4q2V/MaJ
 g8iZuiEYfWVbiTO8ywn44QwjG6KZvd8HsrDc6ZWrhNmSOLkW/XZLHMH+bltnI6oloHfm
 nylEGD83w50iaanOGUQXwqhKCg3rR27iY8gDTVydek/27426Hx/k5sK8pdY6c7Q1gciT
 gtc+PpJJAjjsnuCrADwCgoCAyhvqj7At3mcXqJsJLJ1sxOwf+O42BZpydrHmhD6lrMXn
 pLjA==
X-Gm-Message-State: AOAM5312MpU3l8pHnCMjbbmBGWtf3PUoXBZ09FB2zWDwX0q0V/jt6kFG
 9+IVFOD/9yiFh4vnU6tYqIiwmt+7voA/Euq0oyCiEjBW
X-Google-Smtp-Source: ABdhPJzXGI5fPvYaPA9bzQykMfsARxFPvljEr5e5RXZfv4wHIbrRK4bKCPVdNGxH7ka/TxGJITjWSd0JLoKovBuLxRs=
X-Received: by 2002:a1c:40b:: with SMTP id 11mr18941888wme.116.1596939060124; 
 Sat, 08 Aug 2020 19:11:00 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Wright <bearoso@gmail.com>
Date: Sat, 8 Aug 2020 21:10:49 -0500
Message-ID: <CA+3_KcDvzjTwARb1w4d5YfW9Y99ZaxVex+G7R7SzB5SoPsYBpQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] drm/amd/display: Use hw lock mgr
To: eryk.brol@amd.com, amd-gfx@lists.freedesktop.org, wyatt.wood@amd.com
X-Mailman-Approved-At: Sun, 09 Aug 2020 23:59:03 +0000
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
Content-Type: multipart/mixed; boundary="===============0558390079=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0558390079==
Content-Type: multipart/alternative; boundary="0000000000006823d805ac68597d"

--0000000000006823d805ac68597d
Content-Type: text/plain; charset="UTF-8"

Just curious, but I noticed this new lock manager isn't being used because
of the definitive false return value in display/dc/dce/dmub_hw_lock_mgr.c:
should_use_dmub_lock.
Was this supposed to be enabled?

From: Wyatt Wood <wyatt.w...@amd.com>
>
> [Why]
> Feature requires synchronization of dig, pipe, and cursor locking
> between driver and fw.
>
> [How]
> Set flag to force psr to use hw lock mgr.
>
> Signed-off-by: Wyatt Wood <wyatt.w...@amd.com>
> Reviewed-by: Anthony Koo <anthony....@amd.com>
> Acked-by: Eryk Brol <eryk.b...@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 82e67bd81f2d..5167d6b8a48d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -233,8 +233,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>         copy_settings_data->frame_cap_ind                       =
> psr_context->psrFrameCaptureIndicationReq;
>         copy_settings_data->debug.bitfields.visual_confirm      =
> dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
>                                                                         true :
> false;
> +       copy_settings_data->debug.bitfields.use_hw_lock_mgr     = 1;
>         copy_settings_data->init_sdp_deadline                   =
> psr_context->sdpTransmitLineNumDeadline;
> -       copy_settings_data->debug.bitfields.use_hw_lock_mgr     = 0;
>
>         dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
>         dc_dmub_srv_cmd_execute(dc->dmub_srv);
> --
> 2.25.1
>
>

--0000000000006823d805ac68597d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just curious, but I noticed this new lock manager isn=
&#39;t being used because of the definitive false return value in=C2=A0disp=
lay/dc/dce/dmub_hw_lock_mgr.c:<span style=3D"color:rgb(0,0,0);font-size:13.=
3333px">should_use_dmub_lock.</span></div><div>Was this supposed to be enab=
led?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<pre style=3D"font-family:courier,&quot;courier new&quot;,monospace;font-si=
ze:14px;white-space:pre-wrap;margin-top:0px;margin-bottom:0px;color:rgb(0,0=
,0)">From: Wyatt Wood &lt;<a href=3D"mailto:wyatt.w...@amd.com">wyatt.w...@=
amd.com</a>&gt;

[Why]
Feature requires synchronization of dig, pipe, and cursor locking
between driver and fw.</pre><pre style=3D"font-family:courier,&quot;courier=
 new&quot;,monospace;font-size:14px;white-space:pre-wrap;margin-top:0px;mar=
gin-bottom:0px;color:rgb(0,0,0)">[How]
Set flag to force psr to use hw lock mgr.

Signed-off-by: Wyatt Wood &lt;<a href=3D"mailto:wyatt.w...@amd.com">wyatt.w=
...@amd.com</a>&gt;
Reviewed-by: Anthony Koo &lt;<a href=3D"mailto:anthony....@amd.com">anthony=
....@amd.com</a>&gt;
Acked-by: Eryk Brol &lt;<a href=3D"mailto:eryk.b...@amd.com">eryk.b...@amd.=
com</a>&gt;
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c=20
b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 82e67bd81f2d..5167d6b8a48d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -233,8 +233,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmu=
b,
        copy_settings_data-&gt;frame_cap_ind                       =3D=20
psr_context-&gt;psrFrameCaptureIndicationReq;
        copy_settings_data-&gt;debug.bitfields.visual_confirm      =3D=20
dc-&gt;dc-&gt;debug.visual_confirm =3D=3D VISUAL_CONFIRM_PSR ?
                                                                        tru=
e :=20
false;
+       copy_settings_data-&gt;debug.bitfields.use_hw_lock_mgr     =3D 1;
        copy_settings_data-&gt;init_sdp_deadline                   =3D=20
psr_context-&gt;sdpTransmitLineNumDeadline;
-       copy_settings_data-&gt;debug.bitfields.use_hw_lock_mgr     =3D 0;
=20
        dc_dmub_srv_cmd_queue(dc-&gt;dmub_srv, &amp;cmd);
        dc_dmub_srv_cmd_execute(dc-&gt;dmub_srv);
--=20
2.25.1</pre></blockquote></div>

--0000000000006823d805ac68597d--

--===============0558390079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0558390079==--
