Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A681DC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 18:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72FE10E8EA;
	Fri,  1 Aug 2025 18:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgRLDLYw";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23ACB10E8F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 18:05:16 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-704c5464aecso17176826d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754071515; x=1754676315; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:reply-to:subject:references:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdhaMeHGqUq9e0C4vxCUeGbK9T2j58zUDF9iQRAtWFg=;
 b=OgRLDLYw+7p2a0MmJ1Wg9YaDEWgQmRzcVQukDd+IQoA9oxNzBAZCyLErIIKxe9L7gQ
 3Kl2/wi00c7y8HCBl9JSvrfUzIgYzCi3oqV/yuae2Q+kOgsA6Fp/6flTaKD2qNFT3/ho
 c3cE9xf4sSsA7OTUxMza6XsbFCt7AI8Y9Qz36Xy9nyUUu8AlTrR9rsmA57cv4mh0PGju
 6S1YpWtNyTvNcTVsyumloeHRMHgZqqO77L16jmmwdMlrb7Y6lg3NPY8PK+n7AYkxEeJ7
 /F1DlgvcRA3WNz1pXxqXzLCBblGgXNFP2y5nXcumDlYt1zmGv62VApHLLqhabknydXbr
 qoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071515; x=1754676315;
 h=in-reply-to:from:content-language:reply-to:subject:references:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BdhaMeHGqUq9e0C4vxCUeGbK9T2j58zUDF9iQRAtWFg=;
 b=nSxWWEZJFVMNir6XYR0d54qmRLbJFXuyYaWW4lyXeJdOBlRiesU9/D2n+D9qdoDlRP
 RAXAnk2ytUGMott/U3DySlnL1AwzhWetFlw7MJ8Ki5/3oFetQWSxPz9/+4uT15VF4+cz
 NIdTpJF/n07TsDIvwBr9x9qOgUFOxV7CMziMountsd/BITcmVY3TCFCvyUKj7izpQvt/
 4BdVW1t+ywXk8Po0Re2B35VGla2R9Iz5r911f4YcFXobDuNCPyoN6+Ps3tYM8KeB59Is
 YpUFHP5UVY/37oW2xlgBeeX3fvWpyTdJpFodCejNi2YMdrSNhG851N+VtgiN6dizMlto
 NB3g==
X-Gm-Message-State: AOJu0Yyugr3FsIvwEKZFavHW0EMMzI6SostGWLaeck/3CbsPwd3cOwzK
 nfMtJYSeSlNkNUMHFm80Kn0wbQyGhr1/IEjhRa8QiKTqljkXTylGurRgXrUoBW9r
X-Gm-Gg: ASbGncvVZWl8eEBddMA7ic+Jf38jcZw0gpgXTaK8SpNyh/T5pmkiQdqXH50wzYYKW6m
 GRbseNtH1Hv6drxoZhruSo8wlyEJS/IMND75TMAnlDiMFu7CPr0DKYubspHHdgVwwn+m1aky9Tj
 Bz/StvtrwD9egFqe1tBlKf83OJEviVtLIvcySUq4BEuyAwdrXuUVYy2RHCvWIPdI9Z8gaQZQFtn
 ojxhq7rwxjnyZPRHOGsLqzI9dMoRHeaGDP4y2sbiqpz83A4lwSA/Sqkt7gprID9r22V774PZdgz
 42u8SWCMxFGQrXYqkdq2rMsOKdEn7qZLpHfcfGbscri4YM/qQFFez37x8sa2QKpClFMRyrIXBKB
 sAUmYIfK5S0avI99IcykzY+hNJeKNlyaEw3xVJWt6NTGnZw==
X-Google-Smtp-Source: AGHT+IE/uj5D/FzJT81lMAenhYPKlrUX3EhD5MV7NQJJDo8H8V1DMZmLjfBVsdNCYrJANtluHNNyDA==
X-Received: by 2002:a05:6214:e4c:b0:707:6f50:755f with SMTP id
 6a1803df08f44-7093630bcfbmr9425226d6.35.1754071514656; 
 Fri, 01 Aug 2025 11:05:14 -0700 (PDT)
Received: from [10.0.0.246] ([104.251.39.208])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-7077cd56de5sm24417946d6.57.2025.08.01.11.05.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 11:05:14 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------3RIrnBf2hVfZbzObdqgWBaIM"
Message-ID: <a90cee9d-4be0-431e-abf7-e55da92c42d5@gmail.com>
Date: Fri, 1 Aug 2025 14:05:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-11-timur.kristof@gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Implement DCE analog stream
 encoders
Content-Language: en-US-large
From: Alexandre Demers <alexandre.f.demers@gmail.com>
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
--------------3RIrnBf2hVfZbzObdqgWBaIM
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

--------------3RIrnBf2hVfZbzObdqgWBaIM
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

--------------3RIrnBf2hVfZbzObdqgWBaIM--
