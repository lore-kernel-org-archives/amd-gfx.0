Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03571CDD1AE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 13:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957E410EC50;
	Fri, 27 Sep 2024 13:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hALFaWx+";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC8010EC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 13:58:24 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso20181705e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727445502; x=1728050302; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vBG55DtLM+k3AKMBndxK+DDPcAHKa+D+xR1oisNkB4c=;
 b=hALFaWx+eSKCMv0uULaZdJvZW5OVo+/gsYADBGiuxSEE9QyYg3F3FNICpdpbPZzOYA
 3D+HqJ7ri723QSQPCpPWOHdoFtSpOAGeTyGCHs8bwHR0Mz0W3p3mt+lCd2LRM1MHoZaX
 PAjMIRJZutuB7bwiX8WLpJlBOeuDjCcm3WTUO0rPg8o27SeZ4o9r8X66liD9RBJmDhoh
 XSR1ZJCSeDkrfLjRpWN2P70q16Hj+1+ojgHhhjaJhb7/y52eYOsHIXNiJoT3+rMYJuoc
 L77+Bt5UloWsilJJmcpN3FtV2Ue49H6YCpuXLP2gH9nhbShgm9XUsA4mjuIIfwNjir/C
 8fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727445502; x=1728050302;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vBG55DtLM+k3AKMBndxK+DDPcAHKa+D+xR1oisNkB4c=;
 b=pq/H+iQw5S6D58e2QvPJ7Xep012iPMuWml20KDJpr11jW2Jokyn1Vy5j4tqRBsgRgd
 bL5qBOwoO7hRlMynldMwJRctHfyqqJb8tAGfxZyLpi44mL9vN8GTfrzPlgYV9/JSkDf8
 or8SvTt1DpRUz9tg+BsRC8/08MBx6OQmXArZDV/bK/A3qG1+CrQrQggR0Sck3qr6LeNJ
 D/dfuEJovzemn4ZL5APKw+WaBVvfPKQoFI6eY2u6RqAFOXvbSsdUjvDt5rXU+zB6T3DH
 kKqgdkrs1jaX1SeI1FUZtlHJz9AQ8GgYORywVbX4w8lO9JoUb7fT5JNbV9pBaQymbqeX
 9KYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAsSYkbeg26kDU88o9WFtputOTRtoNdurz+mMk3z4DgOyAZeEVeQgLvg4E1Ywd6t+midiqlc7W@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUegWtf22hpd77XE05R6tMT5Zp/dukhhBdLvCRzmSRVfMPJKbj
 XzdahQSlMjZfaSa/toKNeHPVVI9vg8dHXUPg40W2A6kS1Nge0Jev
X-Google-Smtp-Source: AGHT+IGD1xQEyQ8xxKs8ycCkGNCG+4o9iVXZlJPIJ/Nuq8w7/MuEG0tX8MRrwi/Fm86/Gh67856Y0w==
X-Received: by 2002:a05:600c:1e01:b0:42c:b1a4:c3ef with SMTP id
 5b1f17b1804b1-42f5849cd7fmr25941345e9.33.1727445502215; 
 Fri, 27 Sep 2024 06:58:22 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d292sm2633537f8f.22.2024.09.27.06.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 06:58:21 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------P0XDeal60f0VGskJC4abJCeW"
Message-ID: <f1b10af8-b4dd-481b-88f2-ddebc3309d43@gmail.com>
Date: Fri, 27 Sep 2024 15:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD Radeon out of memory causes system instability.
To: James Lawrence <james@egdaemon.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <BE0aVjD8pNALcbd-ZS-4Nc00rErCRqNVp1QYdltXo8SnW5W844fHbukefLZeZYqPxp1-GhcSSMLI6IfQqR4vfKd3NJVWAO20cCsOIfUptLo=@egdaemon.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BE0aVjD8pNALcbd-ZS-4Nc00rErCRqNVp1QYdltXo8SnW5W844fHbukefLZeZYqPxp1-GhcSSMLI6IfQqR4vfKd3NJVWAO20cCsOIfUptLo=@egdaemon.com>
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
--------------P0XDeal60f0VGskJC4abJCeW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.08.24 um 08:02 schrieb James Lawrence:
> Apologies if I'm hitting the wrong mailing list. long time user, first 
> time reporter and all that.

Sorry for the delayed reply  Without a maintainer in CC such requests 
are usually overlooked on the mailing list.

>
> recently my system has been suffering from instability with the 
> graphics system. essentially some application on my system is causing 
> oom for graphics memory.
> normally I'd just expect a hard crash of the application in such a 
> scenario. instead the system enters a spin loop of command submissions,
> slows down dramatically generally resulting in the system freezing up.
>
> There are a couple issues I'd like to point out with the current 
> situation I'm experiencing:
>
>   * most importantly the error message doesn't provide any useful
>     information for tracing the source of the issue. no pid, or other
>     diagnostic information.
>   * its very noisy when trying to debug. I can occasionally drop my
>     system to a separate TTY and the message just spams the entire
>     screen. making it impossible to interact with my system even if I
>     wanted to load up debugging tools to analyze the situation.
>
>
> given the error message I believe this line is the source of the log 
> statement.
> |[drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough memory for command 
> submission!|​
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c#L1431
>
> Generally I'm wondering if there is anything that can be done to 
> improve the experience for end users in such a scenario.
>
> Ideally the system would nuke the misbehaving process similar to how 
> ram ooms are handled.

If you see this message you should get the OOM killer running along with it.

If you don't see this then you probably run into a BUG or something like 
that.

What kernel version are you using and what did you do to trigger that?

Regards,
Christian.


>
> but at a minimum I'd like to be able to figure out how to back track 
> this to the misbehaving process. any help in this regard would be 
> appreciated.
>
>
> Sent with Proton Mail <https://proton.me/> secure email.

--------------P0XDeal60f0VGskJC4abJCeW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 05.08.24 um 08:02 schrieb James Lawrence:<br>
    <blockquote type="cite"
cite="mid:BE0aVjD8pNALcbd-ZS-4Nc00rErCRqNVp1QYdltXo8SnW5W844fHbukefLZeZYqPxp1-GhcSSMLI6IfQqR4vfKd3NJVWAO20cCsOIfUptLo=@egdaemon.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div style="font-family: Arial, sans-serif; font-size: 14px;">Apologies
        if I'm hitting the wrong mailing list. long time user, first
        time reporter and all that.</div>
    </blockquote>
    <br>
    Sorry for the delayed reply  Without a maintainer in CC such
    requests are usually overlooked on the mailing list.<br>
    <br>
    <blockquote type="cite"
cite="mid:BE0aVjD8pNALcbd-ZS-4Nc00rErCRqNVp1QYdltXo8SnW5W844fHbukefLZeZYqPxp1-GhcSSMLI6IfQqR4vfKd3NJVWAO20cCsOIfUptLo=@egdaemon.com">
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">recently
        my system has been suffering from instability with the graphics
        system. essentially some application on my system is causing oom
        for graphics memory.</div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">normally
        I'd just expect a hard crash of the application in such a
        scenario. instead the system enters a spin loop of command
        submissions,</div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">slows
        down dramatically generally resulting in the system freezing up.<br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">There
        are a couple issues I'd like to point out with the current
        situation I'm experiencing:</div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">
        <ul
data-editing-info="{&quot;orderedStyleType&quot;:1,&quot;unorderedStyleType&quot;:2}">
          <li style="list-style-type: &quot;- &quot;;"><span>most
              importantly the error message doesn't provide any useful
              information for tracing the source of the issue. no pid,
              or other diagnostic information.</span></li>
          <li style="list-style-type: &quot;- &quot;;"><span>its very
              noisy when trying to debug. I can occasionally drop my
              system to a separate TTY and the message just spams the
              entire screen. making it impossible to interact with my
              system even if I wanted to load up debugging tools to
              analyze the situation.</span></li>
        </ul>
        <div><br>
        </div>
        <div>given the error message I believe this line is the source
          of the log statement.<br>
        </div>
        <div><code>[drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough
            memory for command submission!</code>​<br>
        </div>
        <div><span><a target="_blank" rel="noreferrer nofollow noopener"
href="https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c#L1431"
              moz-do-not-send="true" class="moz-txt-link-freetext">https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c#L1431</a></span><br>
        </div>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">Generally
        I'm wondering if there is anything that can be done to improve
        the experience for end users in such a scenario.</div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">Ideally
        the system would nuke the misbehaving process similar to how ram
        ooms are handled.</div>
    </blockquote>
    <br>
    If you see this message you should get the OOM killer running along
    with it.<br>
    <br>
    If you don't see this then you probably run into a BUG or something
    like that.<br>
    <br>
    What kernel version are you using and what did you do to trigger
    that?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <br>
    <blockquote type="cite"
cite="mid:BE0aVjD8pNALcbd-ZS-4Nc00rErCRqNVp1QYdltXo8SnW5W844fHbukefLZeZYqPxp1-GhcSSMLI6IfQqR4vfKd3NJVWAO20cCsOIfUptLo=@egdaemon.com">
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;">but
        at a minimum I'd like to be able to figure out how to back track
        this to the misbehaving process. any help in this regard would
        be appreciated.<br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div style="font-family: Arial, sans-serif; font-size: 14px;"><br>
      </div>
      <div class="protonmail_signature_block"
        style="font-family: Arial, sans-serif; font-size: 14px;">
        <div
class="protonmail_signature_block-user protonmail_signature_block-empty">
        </div>
        <div class="protonmail_signature_block-proton"> Sent with <a
            target="_blank" href="https://proton.me/"
            rel="noopener noreferrer" moz-do-not-send="true">Proton Mail</a>
          secure email. </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------P0XDeal60f0VGskJC4abJCeW--
