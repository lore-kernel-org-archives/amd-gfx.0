Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ABC4320A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 07:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD92C60F4B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 07:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD92C60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nearce.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D489089BB2;
	Mon,  9 Aug 2021 07:03:50 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C103A898EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 02:26:04 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id y1so25559371iod.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Aug 2021 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nearce-com.20150623.gappssmtp.com; s=20150623;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language;
 bh=Lwqp5j34ANuBdahXRUAeLnQIcf7GJh4Tl0z8JSbrAVw=;
 b=DTOfH74pSgMnjCEIfaKPPJkqDvc6j63yM5i5nYUpGhqXOYXweXOXE3i9mGh4YVtpGU
 p8S+RQ0xgzy9ClZ5fcaJfmyat2X6V4R629hfg2eIlmZxIkmBcLv7XFYbNXXIRXc76Rkg
 Yr756mz+b3R4TgbB+0ZFLc47uoebKdBFzbprPKv9ZKAlRKhly1nbz4OMvoH2qzdRe/bv
 +J3AC9dCOAU0W9SYYchR937fuR3iM7gaGuZoA0DONgFSahAOu+jxFO0vVIbqPXFqRASA
 HhVp4DBJH8ticSdszLQRe+x7+mbCaV8TgLCuUeKptn7zbZiCY5GMFjCubgDeUH+O7uWH
 +nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language;
 bh=Lwqp5j34ANuBdahXRUAeLnQIcf7GJh4Tl0z8JSbrAVw=;
 b=FCkibdZJikVD2tLbexY0jjBuxY5+pgSVy4PHKyGDOsVGczF1faWXp5CPdALje1QHWQ
 zYrOh4Zdd38NqCHRTjmj+WwUNmYEAum2LPi9dIzl4Phr38tL6OlQxeO0s+DO/RiFJjgC
 zgDijqpmaoc0cBLruu+P8bu7iOjQ+4B3E/f+uoqGYJRFawMb2YAeKr6ggBAqUSenHRm7
 udzAeIgzk+exElQqo2iaVh6jSXuf7TCSkSXziJlkT1vYkN3K5b4UkGERVoC6CN8lWAim
 mPjSSo8Hes+Zt+DZw9yZMt0jXNZw9sCVEPs1PDI/rfhYmkWWu6w4cUXdsTDySjsoQWbT
 JM8A==
X-Gm-Message-State: AOAM533XRo/BBLbE6d0sEIIusHNXFx7OVdg9LeXocxc2pE3RlsFXOA/g
 b/izz6SapPRjP3wHdBw3n6/lt3gqrXC8ukk7
X-Google-Smtp-Source: ABdhPJxDjlcA2hHEgaKu8l5ozwmhYNMC54xtKzcKyAIwUE7e3+TxrAk6BMuNYDmCbrslX5LjmnQ3HA==
X-Received: by 2002:a6b:6609:: with SMTP id a9mr140310ioc.8.1628475963868;
 Sun, 08 Aug 2021 19:26:03 -0700 (PDT)
Received: from [192.168.7.39] (cpe-65-25-80-244.neo.res.rr.com. [65.25.80.244])
 by smtp.gmail.com with ESMTPSA id d9sm9364419ilu.9.2021.08.08.19.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Aug 2021 19:26:03 -0700 (PDT)
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?Q2hyaXN0aWFuIEvDg8K2bmln?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
From: Wyatt Childers <wchilders@nearce.com>
Subject: VA-API Regression in Kernel 5.13 for RX 6700 XT
Message-ID: <f2a927f0-65bc-8463-e078-501cc8d177a8@nearce.com>
Date: Sun, 8 Aug 2021 22:26:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------E7ABDAEEA48E32280A051AFD"
Content-Language: en-US
X-Mailman-Approved-At: Mon, 09 Aug 2021 07:03:47 +0000
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
--------------E7ABDAEEA48E32280A051AFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've encountered a bug 
<https://bugzilla.redhat.com/show_bug.cgi?id=1988772> as a user of 
Fedora, that's also mirrored by this 
<https://bugs.archlinux.org/task/71627> Arch Linux bug report. The vast 
majority of VA-API hardware video decoders have disappeared for the RX 
6700 XT GPU.

It seems this happened in the 5.13.x branch, and that it's still a 
problem in 5.14.x (at least Fedora's packaging of 5.14 RC4).

Please let me know if there's any more information I can provide, or if 
this was the wrong place to reach out.

Thanks,

Wyatt


--------------E7ABDAEEA48E32280A051AFD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,</p>
    <p>I've encountered <a moz-do-not-send="true"
        href="https://bugzilla.redhat.com/show_bug.cgi?id=1988772">a bug</a>
      as a user of Fedora, that's also mirrored by <a
        moz-do-not-send="true"
        href="https://bugs.archlinux.org/task/71627">this</a> Arch Linux
      bug report. The vast majority of VA-API hardware video decoders
      have disappeared for the RX 6700 XT GPU. <br>
    </p>
    <p>It seems this happened in the 5.13.x branch, and that it's still
      a problem in 5.14.x (at least Fedora's packaging of 5.14 RC4).</p>
    <p>Please let me know if there's any more information I can provide,
      or if this was the wrong place to reach out.</p>
    <p>Thanks,</p>
    <p>Wyatt<br>
    </p>
  </body>
</html>

--------------E7ABDAEEA48E32280A051AFD--
