Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC79C3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 15:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A748610E359;
	Mon,  2 Jan 2023 15:54:24 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D5910E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 15:54:23 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so60476662ejc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jan 2023 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9L5v0OGjSPodzGxivUzDgssGf/a7z3B1aqWeDgMIJ7k=;
 b=F/jX9mIpKavazyyABThI0mLgqkunJYnJz3EcRkJu+0i/i6cbmiKp57IJ5C29BwxVsE
 MgotWnoH6nQ5osr20Zu8HC6EFGBr8t4VxYuTD1Rd8cl2LdVesL+1+ucaqVk8akLYiu7a
 BxLRZjAiLFHPy5eQ/xN78tJWUOrxPibZxHCmxJppK2WsYTIpphnD0Rd64ceuviQEgykS
 a/lg2epJQWbmhJe2BbMXL95lD56RUykczXTvIgcJBEzpQpcheXr5jaYf8z0UwBM6YkoT
 z2NsLTIwy5iSRZdJ8ZFzof4DycGjsOMH9XtdR0AfCegvdKOJz+2kZXE9jBm08Yo3WhVY
 mPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9L5v0OGjSPodzGxivUzDgssGf/a7z3B1aqWeDgMIJ7k=;
 b=Rzphc4Xl7MzTFPSjP/MNr0me26YgbRl3uOftPsZrPPDfK6yacShhD7Bqf07Fv+AoNX
 98C3jgU5cipwjNqNj1iwXQMfXvEn+sBAPdr96yFyNKLY8Y66Lg0ZyDYGoOPnwHSlsjxm
 hCXbXkymfWb/UzL60JVtHf1A+8CHH4b3/eD0xqZ4c3VjlZm0ozCZ7nvdAfMMY4kDHy/J
 B/BmzH9hFoY5P5fBKJmHGQXkQ0wmNys+01hCHs2WWeymCMx76uA5VF1eSF1IvWTysaCy
 T+o7JdXRPAdWOrWQSw3vGNw6zK+zaIiL7pocPuWZ44Kd3CrYI2CUeEggCmnU76h+YnFi
 wOBA==
X-Gm-Message-State: AFqh2kopzxuqsJiMZv40g6bvEMkUF/kxtZlWvvqkVjsVNqIXQPllIn3q
 H1/Faig59AueLgh/ozvUrBG9HYH5jCg=
X-Google-Smtp-Source: AMrXdXskabmeI2qxI11R/AtfKchUViiA/H/UdS0ggnGiVIk4IYZZ09MevzmLO2d5BEibz9R/Yb3FCw==
X-Received: by 2002:a17:906:7e55:b0:7c1:7442:8b70 with SMTP id
 z21-20020a1709067e5500b007c174428b70mr40370579ejr.75.1672674861442; 
 Mon, 02 Jan 2023 07:54:21 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:8d77:4e27:bb99:9a97?
 ([2a02:908:1256:79a0:8d77:4e27:bb99:9a97])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a170906181200b0077f324979absm12989416eje.67.2023.01.02.07.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jan 2023 07:54:20 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------No71k01nEPlGgYLGLAZ3m02g"
Message-ID: <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
Date: Mon, 2 Jan 2023 16:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
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
--------------No71k01nEPlGgYLGLAZ3m02g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That stuff is already available as current_link_speed and 
current_link_width in sysfs.

I'm a bit reluctant duplicating this information in the IOCTL interface.

Christian.

Am 30.12.22 um 23:07 schrieb Marek Olšák:
> For computing PCIe bandwidth in userspace and troubleshooting PCIe
> bandwidth issues.
>
> For example, my Navi21 has been limited to PCIe gen 1 and this is
> the first time I noticed it after 2 years.
>
> Note that this intentionally fills a hole and padding
> in drm_amdgpu_info_device.
>
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>
> The patch is attached.
>
> Marek
>

--------------No71k01nEPlGgYLGLAZ3m02g
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    That stuff is already available as current_link_speed and
    current_link_width in sysfs.<br>
    <br>
    I'm a bit reluctant duplicating this information in the IOCTL
    interface.<br>
    <br>
    Christian. <br>
    <br>
    <div class="moz-cite-prefix">Am 30.12.22 um 23:07 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">For computing PCIe bandwidth in userspace and
        troubleshooting PCIe<br>
        bandwidth issues.<br>
        <br>
        For example, my Navi21 has been limited to PCIe gen 1 and this
        is<br>
        the first time I noticed it after 2 years.<br>
        <br>
        Note that this intentionally fills a hole and padding<br>
        in drm_amdgpu_info_device.<br>
        <br>
        <div>Signed-off-by: Marek Olšák &lt;<a
            href="mailto:marek.olsak@amd.com" moz-do-not-send="true"
            class="moz-txt-link-freetext">marek.olsak@amd.com</a>&gt;</div>
        <div><br>
        </div>
        <div>The patch is attached.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------No71k01nEPlGgYLGLAZ3m02g--
