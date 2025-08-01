Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A5AC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 19:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D2710E316;
	Fri,  1 Aug 2025 19:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G/oQn2qZ";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8ED10E316
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 19:30:04 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4ab9ba884c6so31427081cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754076603; x=1754681403; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:subject:references:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=m6rB8rRTxjCFRmvz0siJG7G8spBr1O1w7MDvJ3SsXU8=;
 b=G/oQn2qZKdrAumUUMZLHVvVaDG20fceNTHjg4khYKsHA242alhVYa5OWVPgL+Yiiii
 HeLk4OpahsgStolm6dGk0jG3lpF04A8kPDkL/3nw8UYVq+s0pBZ0142PqwACnX7J/6k1
 nXCyeH7zwEPYxKJzSCUpPZd93PZiOLElGywFuKYhBJy6wPIsNj222AwjxzLSSjUN/+kz
 qWwRq89RvYPTMpAc0Ec6loE0X0n+uiLnFePhGHqhPkYLM2i1Y1bgPUFpa+JQ8pI3EAlx
 T2DOdGtUl8H/w3jvHW65s3G7wSl2o8yT/XQJKgjFyuonScvCMgaqAc5P3n2JMU3dY5sG
 Ajag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754076603; x=1754681403;
 h=in-reply-to:from:content-language:subject:references:to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m6rB8rRTxjCFRmvz0siJG7G8spBr1O1w7MDvJ3SsXU8=;
 b=w9tw3sNhP/l+xzsEH/PqL86bJ+OhH+ixW7/VslO48+GAAZhW2FFHy8whcOoxklEcIb
 /8aNnuy5WV6Kw1so4Pfwfd0WIrjMl2XEGH8Y6wYFALdIYmxsEF9QUQEc/dQAcpuROvep
 nDwio382NMJ3jep6Rl+QL8xK9IK8F6NPBBSdlc5hyCXLv3YAGPx27tEdYaphnSdMSmiw
 E1vwkFir4TjC5z5hShqeni2Cp+w+47sI5WhntQ1GkDpGNv1cy47EMP6ODmP03iCW2BXB
 KY9c7XI9GKYZJ9cXnVHkHTrHUorcxOSvpP+tJbTEK7ckuk8x7RlkIWDmI9fYpVyG07FL
 O4zg==
X-Gm-Message-State: AOJu0Yyf4W1lGr0be3IMAOPgEcXEUhSvRDTxLddq7/lULbY+PdU9t1bD
 1BVJopISU6dJhkrACxkv+UfIkU4cvHrag4QOg4TsLkyqZ2a+mCFFGOSxJMecpJl7
X-Gm-Gg: ASbGnctB4NzzxInvILxdLyTXH7u/7rCfSLGQVl26RQFgSlwBFJiZ/cplGHN17jT6ujt
 NUVemGPnEsR1qpwu9eZEdSnTfBoDectZ2cR2G2v/OHay4xcSIhOkGYV7atPYIRtSkS4Ab4PYRqX
 xwfIlurEq6eI9/Cx9763v0zyTXPY9fI2X80DLMJOWQqL/FRwuWQhsg+aIiBwOkC2KDwASOUYrGO
 Q/8EX4n8kw7EsOVJUOQeEasO7ZIKmrnXNZ0+QYSLU6uiResd2nltIWLGst+V9QTYxXTEGLNGiXY
 DGUoDXWYINOcOAo2VxHKV7+A7sA0H0E84lUpIBapvslXyIkiXce5GN9JmnunlvbmPrE5MoWrk+n
 FS5gO+3Q7Ch860Hy1qc1Q89z+XesHtxVSDJ0=
X-Google-Smtp-Source: AGHT+IEBnLWAf7kV20gYz6mU/8WQbOOmEYHT3gYZNsdWYbh0UNdUNu0t2aCzlwJuenvajwtZtQlqLg==
X-Received: by 2002:a05:622a:1303:b0:4a9:8bb9:55d0 with SMTP id
 d75a77b69052e-4aef18cc5a6mr99344261cf.25.1754076602640; 
 Fri, 01 Aug 2025 12:30:02 -0700 (PDT)
Received: from [10.0.0.246] ([104.251.39.208])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4aeeedba71csm24169781cf.50.2025.08.01.12.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 12:30:02 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------XlOtaQh1plFdngnYh0631bQd"
Message-ID: <382a6232-c500-4d5e-96d4-0444947130ea@gmail.com>
Date: Fri, 1 Aug 2025 15:30:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
References: <20250723155813.9101-12-timur.kristof@gmail.com>
Subject: Re: [PATCH 11/20] drm/amd/display: Implement DCE analog link encoders
Content-Language: en-US-large
From: Alexandre Demers <alexandre.f.demers@gmail.com>
In-Reply-To: <20250723155813.9101-12-timur.kristof@gmail.com>
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

This is a multi-part message in MIME format.
--------------XlOtaQh1plFdngnYh0631bQd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> We support two kinds of analog connections:
> 
> 1. VGA, which only supports analog signals:
> For VGA, we need to create a link encoder that only works with the
> DAC without perturbing any digital transmitter functionality.
> This is achieved by the new dce110_analog_link_encoder_construct.
> 
> 2. DVI-I, which allows both digital and analog signals:
> The DC code base only allows 1 encoder per connector, and the
> preferred engine type is still going to be digital. So, for DVI-I
> to work, we need to make sure the pre-existing link encoder can
> also work with analog signals.
> 
> Signed-off-by: Timur Kristóf <timur.kristof at gmail.com <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>>
> ---
>  .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++
>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  21 ++--
  
  I have the same comment about the use of "dce110_" prefix under general/global DCE code that I left on the previous patch.
  
  For consistency with the current code, I understand why this prefix is used, but I'd gladly clean this up once the patches have landed in if there is a common agreement.
  
  Alexandre

--------------XlOtaQh1plFdngnYh0631bQd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>&gt; We support two kinds of analog connections:
&gt; 
&gt; 1. VGA, which only supports analog signals:
&gt; For VGA, we need to create a link encoder that only works with the
&gt; DAC without perturbing any digital transmitter functionality.
&gt; This is achieved by the new dce110_analog_link_encoder_construct.
&gt; 
&gt; 2. DVI-I, which allows both digital and analog signals:
&gt; The DC code base only allows 1 encoder per connector, and the
&gt; preferred engine type is still going to be digital. So, for DVI-I
&gt; to work, we need to make sure the pre-existing link encoder can
&gt; also work with analog signals.
&gt; 
&gt; Signed-off-by: Timur Kristóf &lt;<a
    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
    data-bcup-haslogintext="no">timur.kristof at gmail.com</a>&gt;
&gt; ---
&gt;  .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++
&gt;  .../drm/amd/display/dc/dce/dce_link_encoder.h |  21 ++--
 
 I have the same comment about the use of "dce110_" prefix under general/global DCE code that I left on the previous patch.
 
 For consistency with the current code, I understand why this prefix is used, but I'd gladly clean this up once the patches have landed in if there is a common agreement.
 
 Alexandre</pre>
  </body>
</html>

--------------XlOtaQh1plFdngnYh0631bQd--
