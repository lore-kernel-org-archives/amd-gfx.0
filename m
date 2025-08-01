Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62194C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 18:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B95010E3D3;
	Fri,  1 Aug 2025 18:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EQBQovt6";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790EE10E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 18:06:38 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-70739d1f07bso19728796d6.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754071597; x=1754676397; darn=lists.freedesktop.org;
 h=in-reply-to:content-language:references:to:reply-to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hb890BurcXj4DDZgfOfgzroxL3HuEJyhT1tkzvQY3JA=;
 b=EQBQovt6riYbydBu6n1X3bRirM67ctnPZFlPmtvJY9cdDKbtxB9jFgLPKl31lK3ndK
 AW4D0EOYkYh/Je56yb1Q3acR01C5J/ZBQil0PgpLNC+xZgMtzxIlWKoVCvBL94h351Qi
 LjWIZ5fkeRhguFc5Id/1hNNQuJMTVuEqQnpn4Nd7h1fWtpi6T1WTO4A4ZsyQ7/4vU5sM
 8sGmwCut6Loqj1vm5N8ktuR5apPaf5wVhaROcEjkZmCMcFhYOarBErUe9tseh+1Y/LRG
 cIFojfRLZiFCzqXS7+CoNBcMpR/I0CV8n+GIRRYCvWmizucVroyy30PuxKbjG7a9svtY
 E3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071597; x=1754676397;
 h=in-reply-to:content-language:references:to:reply-to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hb890BurcXj4DDZgfOfgzroxL3HuEJyhT1tkzvQY3JA=;
 b=gkC2zkmD6/+5o+d/GTX1Ishz0KONZoPhbHMrLWu7SEwDPTdY5fNfuUvjPI4MrGIOf1
 Hmxti7XD7gOaLT35xc78zA7MnqTDHo3o5i08Zd9lXM5m7CWRFQ6jo6aPVcqhpoc4badO
 d7w8/CZ2IPexvrer61YOp4fJhyg+ZgGD32Z0e5UHdyencSfdhBWk+I40ZM/iss4/cx24
 uCXQUG0qAPQv6oIC421fafhfCHwOET2ueunqVIpGIJJzPpBCSUdW1QDaa4nqz8+uPbnp
 oEux2VkMqLTrwwNRMIgFAc3h2PWjEzgigpbr8CEZZ3NE7qH43gfxbFWwD587+Ht9sCDB
 5uTg==
X-Gm-Message-State: AOJu0YzPICod2dY4BiObAhGLF5/5iBiLv+/CFVjnGf4NmoVS2cIu5NvK
 iVF33wz3uveOQEdSEdX/QF2JMvuKeUdd++R2B7khgfrHCu9D5v1RgYBrcVMrFmRL
X-Gm-Gg: ASbGncs6z6KPW+xdfO8utWgNJfZlDSdPx2FVnngR1SHmqZJot2tmdemQ+ngAwKEi2MV
 eonYX7zMjufkovcofeQxtOUXNsJsDEIWy8yPuzZUfK9PyDsbZYIt6ybXICm0czk+dyoHP/KgtA8
 JOtvNpllZAnwm4K11F6WnFS/EaBcHzeOg36JRLJ5LRn+BQC2Jqozjpv+yuRW+G1mpxOmxy3fJTk
 irLmZ5Y90UULAYW8Tcr3PkLFaOGal9JXc55xVWrRDvwO/O4L0iROXxWYUaLazUJG90sggb1M0Y/
 vgSHcmXNbG3aTOwwGnS2cn3g5f/WcBL4Y5psBVD1BA/ntS3yKwZLUizNoTIdQE+YbzKjPzv+JJ8
 9uJsijkwD7/RsViZux3pgMehrctEFEMVoSmc=
X-Google-Smtp-Source: AGHT+IGE7369nov4/kAaHLBV3d0pMvsgWyc15OSgw5zF60mgnegRXkemKN3PWr80IUB1zL7AIVYgtw==
X-Received: by 2002:ad4:5d47:0:b0:707:5c4f:f0c9 with SMTP id
 6a1803df08f44-709365356c5mr9998076d6.16.1754071597036; 
 Fri, 01 Aug 2025 11:06:37 -0700 (PDT)
Received: from [10.0.0.246] ([104.251.39.208])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-7077ca58d36sm24757486d6.38.2025.08.01.11.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 11:06:36 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------94zCwNJ4jY0mIARozJpnQK0a"
Message-ID: <b3de4c61-6852-4223-915f-e3d40da97c92@gmail.com>
Date: Fri, 1 Aug 2025 14:06:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Implement DCE analog stream
 encoders
To: amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
References: <20250723155813.9101-11-timur.kristof@gmail.com>
Content-Language: en-US-large
In-Reply-To: <20250723155813.9101-11-timur.kristof@gmail.com>
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
Reply-To: alexandre.f.demers@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------94zCwNJ4jY0mIARozJpnQK0a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Add stream encoders for DCE6-10 only, because there are definitely
> graphics cards with analog connectors out there with these DCE
> versions. I am not aware of newer ones.

> Considering that all stream encoder functions currently have to do
> with digital streams, there is nothing for an analog stream
> encoder to do, making them basically a no-op.
> That being said, we still need some kind of stream encoder to
> represent an analog stream, and it is beneficial to split them from
> digital stream encoders in the code to make sure they don't
> accidentally write any DIG* registers.
> 
> Signed-off-by: Timur Kristóf <timur.kristof at gmail.com <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>>
> ---
>  .../drm/amd/display/dc/dce/dce_stream_encoder.c    | 14 ++++++++++++++
>  .../drm/amd/display/dc/dce/dce_stream_encoder.h    |  5 +++++
>  .../display/dc/resource/dce100/dce100_resource.c   |  6 ++++++
>  .../amd/display/dc/resource/dce60/dce60_resource.c |  8 ++++++++
>  .../amd/display/dc/resource/dce80/dce80_resource.c |  8 ++++++++
>  5 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> index 1130d7619b26..f8996ee2856b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> @@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(
>  	enc110->se_shift = se_shift;
>  	enc110->se_mask = se_mask;
>  }
> +
> +static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
> +
> +void dce110_analog_stream_encoder_construct(
> +	struct dce110_stream_encoder *enc110,
> +	struct dc_context *ctx,
> +	struct dc_bios *bp,
> +	enum engine_id eng_id)
> +{
> +	enc110->base.funcs = &dce110_an_str_enc_funcs;
> +	enc110->base.ctx = ctx;
> +	enc110->base.id = eng_id;
> +	enc110->base.bp = bp;
> +}

  Since we are adding analog stream encoder support only up to DCE10, wouldn't it be better if the prefix "dce100_" was used instead? I know there are a few functions in there that use "dce110_" as prefix and are replaced by functions specific to the DCE versions that behave differently (we even have dce60_ and dce80_ in the current patch), but this seems off otherwise.
  
  IMO, if thie DCE code should be revisited, "dce_" should be the general prefix instead of "dce110_", with "dceXY_" being specific (as it is right now).
  Alexandre

--------------94zCwNJ4jY0mIARozJpnQK0a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>&gt; Add stream encoders for DCE6-10 only, because there are definitely
&gt; graphics cards with analog connectors out there with these DCE
&gt; versions. I am not aware of newer ones.</pre>
    <pre>&gt; Considering that all stream encoder functions currently have to do
&gt; with digital streams, there is nothing for an analog stream
&gt; encoder to do, making them basically a no-op.
&gt; That being said, we still need some kind of stream encoder to
&gt; represent an analog stream, and it is beneficial to split them from
&gt; digital stream encoders in the code to make sure they don't
&gt; accidentally write any DIG* registers.
&gt; 
&gt; Signed-off-by: Timur Kristóf &lt;<a
    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
    data-bcup-haslogintext="no">timur.kristof at gmail.com</a>&gt;
&gt; ---
&gt;  .../drm/amd/display/dc/dce/dce_stream_encoder.c    | 14 ++++++++++++++
&gt;  .../drm/amd/display/dc/dce/dce_stream_encoder.h    |  5 +++++
&gt;  .../display/dc/resource/dce100/dce100_resource.c   |  6 ++++++
&gt;  .../amd/display/dc/resource/dce60/dce60_resource.c |  8 ++++++++
&gt;  .../amd/display/dc/resource/dce80/dce80_resource.c |  8 ++++++++
&gt;  5 files changed, 41 insertions(+)
&gt; 
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
&gt; index 1130d7619b26..f8996ee2856b 100644
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
&gt; @@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(
&gt;  	enc110-&gt;se_shift = se_shift;
&gt;  	enc110-&gt;se_mask = se_mask;
&gt;  }
&gt; +
&gt; +static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
&gt; +
&gt; +void dce110_analog_stream_encoder_construct(
&gt; +	struct dce110_stream_encoder *enc110,
&gt; +	struct dc_context *ctx,
&gt; +	struct dc_bios *bp,
&gt; +	enum engine_id eng_id)
&gt; +{
&gt; +	enc110-&gt;base.funcs = &amp;dce110_an_str_enc_funcs;
&gt; +	enc110-&gt;base.ctx = ctx;
&gt; +	enc110-&gt;base.id = eng_id;
&gt; +	enc110-&gt;base.bp = bp;
&gt; +}

 Since we are adding analog stream encoder support only up to DCE10, wouldn't it be better if the prefix "dce100_" was used instead? I know there are a few functions in there that use "dce110_" as prefix and are replaced by functions specific to the DCE versions that behave differently (we even have dce60_ and dce80_ in the current patch), but this seems off otherwise.
 
 IMO, if thie DCE code should be revisited, "dce_" should be the general prefix instead of "dce110_", with "dceXY_" being specific (as it is right now).
 Alexandre</pre>
  </body>
</html>

--------------94zCwNJ4jY0mIARozJpnQK0a--
