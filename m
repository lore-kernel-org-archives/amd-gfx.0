Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DA3C46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 08:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC3710E3A0;
	Tue,  3 Jan 2023 08:31:30 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD06410E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 08:31:28 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 fm16-20020a05600c0c1000b003d96fb976efso20383516wmb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 00:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS7oSs5UaHu4Oi5d3bocmiLSbqCNW4u4bW3c+byimv4=;
 b=hxoVP9GcXhh1QrMjbgNzd2a8kEKlgJeT/Cl6wm5kI4ZL7xST6G+pa1BGpSWtczQvQp
 s2tEGtv+rL0V8F4R/OMrwgE/tM4zURB9e1O/cKB7UMW3uQZq99kwDCE4MS/WYathve3S
 O0yIt2R3S/SAvR0B9YDQwSx5ThfwdPW9BxVGXSFAE/YJSocZzoZ+3h8Lo2iW5RwzegGR
 Sp660PWQHBW5IIWVVP3UN78YRmYLoLxYkyoWrINkxJgBqc2GT7h/fVZrpMVbAIZkxpz5
 X4/lH0JjFbvLjMwA4CP0+nKG5+o1F3FVub79Ok7+al1ngQl0q8QP02WPBIiFkf3f5ycW
 aA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eS7oSs5UaHu4Oi5d3bocmiLSbqCNW4u4bW3c+byimv4=;
 b=aS81GFFtwLH3RNSZIgSPQK9soU5Iq3olCbylzc+RBB29uCSUMTz0YWxg0JjSi+NQPK
 wqqWkRzskDIvmN37M9ioiNV7sPvqnEMDR/l7LQ2q7nWpGs2muvfUt/uE+5xBMsk+duzg
 LFCttI2DkqndRsuPBhMdbhIms4N5pV8/7osACsfsvss7rxUEqEXaIHFX6WdchXPPF+Zx
 OaG/dGqokJ9+Z8pve6flVjxq5CAubD1rmKjwIKCI5gC8Ff8vS8yqleff6siOes9f3ib4
 YbYydeJ8UsHP4YMOS0uwmUEYZmf+Tp/nP//xxQ3XZcMgcogsGg4rF6QaeHgnyujLCwPu
 U5WQ==
X-Gm-Message-State: AFqh2kqHxxGs0D6j862r9ozrlav6OCfvJzYE4sF/a/J3OFRy5uoSrVfh
 KeUANmCzUnJ+vbye/i8H8G4=
X-Google-Smtp-Source: AMrXdXsMchkXIO/Ts709Gm0JHJO0uBWdaaGMPgVht0sQQ7AmU/1Dj5ROweUQjTp5R56FuGtJhOgJaw==
X-Received: by 2002:a7b:c3d6:0:b0:3d3:5ccc:4442 with SMTP id
 t22-20020a7bc3d6000000b003d35ccc4442mr30471667wmj.26.1672734687460; 
 Tue, 03 Jan 2023 00:31:27 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a05600c214200b003b492753826sm41015547wml.43.2023.01.03.00.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 00:31:26 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------8rQSwnVgCQluSh3NS9E0emfZ"
Message-ID: <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
Date: Tue, 3 Jan 2023 09:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------8rQSwnVgCQluSh3NS9E0emfZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sure they can, those files are accessible to everyone.

The massive advantage is that this is standard for all PCIe devices, so 
it should work vendor independent.

Christian.

Am 02.01.23 um 18:55 schrieb Marek Olšák:
> Userspace drivers can't access sysfs.
>
> Marek
>
> On Mon, Jan 2, 2023, 10:54 Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     That stuff is already available as current_link_speed and
>     current_link_width in sysfs.
>
>     I'm a bit reluctant duplicating this information in the IOCTL
>     interface.
>
>     Christian.
>
>     Am 30.12.22 um 23:07 schrieb Marek Olšák:
>>     For computing PCIe bandwidth in userspace and troubleshooting PCIe
>>     bandwidth issues.
>>
>>     For example, my Navi21 has been limited to PCIe gen 1 and this is
>>     the first time I noticed it after 2 years.
>>
>>     Note that this intentionally fills a hole and padding
>>     in drm_amdgpu_info_device.
>>
>>     Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>>
>>     The patch is attached.
>>
>>     Marek
>>
>

--------------8rQSwnVgCQluSh3NS9E0emfZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Sure they can, those files are accessible to everyone.<br>
    <br>
    The massive advantage is that this is standard for all PCIe devices,
    so it should work vendor independent.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 02.01.23 um 18:55 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Userspace drivers can't access sysfs.
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, Jan 2, 2023, 10:54
          Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div> That stuff is already available as current_link_speed
            and current_link_width in sysfs.<br>
            <br>
            I'm a bit reluctant duplicating this information in the
            IOCTL interface.<br>
            <br>
            Christian. <br>
            <br>
            <div>Am 30.12.22 um 23:07 schrieb Marek Olšák:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">For computing PCIe bandwidth in userspace
                and troubleshooting PCIe<br>
                bandwidth issues.<br>
                <br>
                For example, my Navi21 has been limited to PCIe gen 1
                and this is<br>
                the first time I noticed it after 2 years.<br>
                <br>
                Note that this intentionally fills a hole and padding<br>
                in drm_amdgpu_info_device.<br>
                <br>
                <div>Signed-off-by: Marek Olšák &lt;<a
                    href="mailto:marek.olsak@amd.com" target="_blank"
                    rel="noreferrer" moz-do-not-send="true"
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
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8rQSwnVgCQluSh3NS9E0emfZ--
