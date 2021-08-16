Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17089C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 08:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA73861B05
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 08:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA73861B05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDA489B60;
	Mon, 16 Aug 2021 08:28:08 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBB289BAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 08:27:56 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 o1-20020a05600c5101b02902e676fe1f04so10852852wms.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=jWgea3f1OgBTn/fYbKr9riDuwCnWm76VWQzYS/5nWRY=;
 b=rbyyJ6kf86mVDurveCVnbcnQ5br798/w7X4+wzamXCaZuzVcQEla5nBeUeJYM4kJkX
 iwVZiiTpTakWrbxVV5liLAmP21taVDuY1uWYmq95eOCdH5AGUq6VExhxKwFVxaq32i9w
 wW0lq4G1lE2dtII4lHziCbVafQhkynpx2xwJ6eq1pJMom4ZB3cu89cbOF2QUsjFUqnVg
 Mu3+np8zY337rS4oXLJwy0sg7FCpqAeXMEZdA/8QfLujVOEInP6dADcoaDU1zHyFX5Tx
 1yKmdKErk0vTQWeSMxlePMhCEQZU7V/2vDfIsrrREoWpjtmVdISdgN/zvI/Wl1akEb1r
 b5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=jWgea3f1OgBTn/fYbKr9riDuwCnWm76VWQzYS/5nWRY=;
 b=jkO1/x2QBLbmdwpYyV+NT8VV0eSGXGPWTASyXDUCwJ+vxr8ydJ7S06GRZAeoGshgDL
 OaCBvNy9rmUOaSl35ueFf/5/hOcjlnUNaljyWtTHnZV1JIRRXQEgLM8AGfDhNlqX9jgO
 mj71L7z0CzCIHLcwuYIkrdi3mH/SokOB6hdE7/EBal1OnDACaQ+RHhmo9lUf1wCdyojm
 tLAty6iv3YJZUb/sdasGRcCqoQnXPnN8uiKp0LVbyc+1UAiOdCXxumN/LUFaZbofXYbt
 7CNyFT2xC8PAfXSbJ2meh5ZWR64YjiMI3VuYa71l3gvGt/XzMHwtD0tfGh4gysopWSxc
 wIYg==
X-Gm-Message-State: AOAM531nUgNXmOFiNC6Nsh/mRCORPy/h+JGOC3j5GqVC+tUr5kKftbMp
 H5tZrHXrTmc1jSAAMTXP0/LOeoxrGWQ=
X-Google-Smtp-Source: ABdhPJzHksOKqWRmXSQHyfIpyGaQ2q+IrNcJNXvso/V99CuyvteEJ3hSBcnRc0AjWvHNaj2M608MsA==
X-Received: by 2002:a05:600c:2181:: with SMTP id
 e1mr14477398wme.64.1629102475083; 
 Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7d83:fd8:eb16:8605?
 ([2a02:908:1252:fb60:7d83:fd8:eb16:8605])
 by smtp.gmail.com with ESMTPSA id o17sm9127340wmp.13.2021.08.16.01.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 01:27:54 -0700 (PDT)
Subject: Re: VA-API Regression in Kernel 5.13 for RX 6700 XT
To: Wyatt Childers <wchilders@nearce.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?Q2hyaXN0aWFuIEvDg8K2bmln?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <f2a927f0-65bc-8463-e078-501cc8d177a8@nearce.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d6b523be-a781-10eb-f6d4-bbdd27913c06@gmail.com>
Date: Mon, 16 Aug 2021 10:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2a927f0-65bc-8463-e078-501cc8d177a8@nearce.com>
Content-Type: multipart/alternative;
 boundary="------------1C5F17F03E202EFA1439BAEB"
Content-Language: en-US
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
--------------1C5F17F03E202EFA1439BAEB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wyatt,

adding Leo as well.

Question is what do you mean with "majority of VA-API hardware video 
decoders have disappeared" ?

Do you have a dmesg? Or the output of vainfo?

Thanks,
Christian.

Am 09.08.21 um 04:26 schrieb Wyatt Childers:
>
> Hi,
>
> I've encountered a bug 
> <https://bugzilla.redhat.com/show_bug.cgi?id=1988772> as a user of 
> Fedora, that's also mirrored by this 
> <https://bugs.archlinux.org/task/71627> Arch Linux bug report. The 
> vast majority of VA-API hardware video decoders have disappeared for 
> the RX 6700 XT GPU.
>
> It seems this happened in the 5.13.x branch, and that it's still a 
> problem in 5.14.x (at least Fedora's packaging of 5.14 RC4).
>
> Please let me know if there's any more information I can provide, or 
> if this was the wrong place to reach out.
>
> Thanks,
>
> Wyatt
>


--------------1C5F17F03E202EFA1439BAEB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Wyatt,<br>
    <br>
    adding Leo as well.<br>
    <br>
    Question is what do you mean with "majority of VA-API hardware video
    decoders have disappeared" ?<br>
    <br>
    Do you have a dmesg? Or the output of vainfo?<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.08.21 um 04:26 schrieb Wyatt
      Childers:<br>
    </div>
    <blockquote type="cite"
      cite="mid:f2a927f0-65bc-8463-e078-501cc8d177a8@nearce.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <p>Hi,</p>
      <p>I've encountered <a moz-do-not-send="true"
          href="https://bugzilla.redhat.com/show_bug.cgi?id=1988772">a
          bug</a> as a user of Fedora, that's also mirrored by <a
          moz-do-not-send="true"
          href="https://bugs.archlinux.org/task/71627">this</a> Arch
        Linux bug report. The vast majority of VA-API hardware video
        decoders have disappeared for the RX 6700 XT GPU. <br>
      </p>
      <p>It seems this happened in the 5.13.x branch, and that it's
        still a problem in 5.14.x (at least Fedora's packaging of 5.14
        RC4).</p>
      <p>Please let me know if there's any more information I can
        provide, or if this was the wrong place to reach out.</p>
      <p>Thanks,</p>
      <p>Wyatt<br>
      </p>
    </blockquote>
    <br>
  </body>
</html>

--------------1C5F17F03E202EFA1439BAEB--
