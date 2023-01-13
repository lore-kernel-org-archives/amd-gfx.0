Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4367EC678D4
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA64010EA1D;
	Fri, 13 Jan 2023 15:22:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D7610EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:22:25 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id q10so2067839wrs.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0nN9ne5LVly5O2usN+AVPFxjEj48c/opPwIO+Cybe5U=;
 b=I1pm6fD0hTheocdjpxWstOuL28w1VKyWCm0/vyUYV6cTe7Fs3Dt+hso7voGZ4Wfefm
 3FFU95M+ZSify/cij4TiwGWXmuAylQ0XdfLN/UJ3Iys3ybBuMpReC8iWxZco2/2bg2b8
 H60jP1LyW05DO9zb5nQczdjZpNPIfFTH/oI28CsvImkiTXw1PaPFs3cb/Obh0WcPDd4c
 jj94P+FROO4jji8DGGnokaw5/RvVi245YYt/zB5Yw5znVabaongl0/Y5QLg4ewCRFIGr
 7f5WETTS4q/oHdthHRz1qtukSr/LUFZzCPsMqx4gDgMueqHlVCxeuIxl8UyM8aKjbync
 jsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0nN9ne5LVly5O2usN+AVPFxjEj48c/opPwIO+Cybe5U=;
 b=vZBVyqAV+TkhxSsFTf19FvlPxHhEmhO5Kl8OjdCu7u1dX0pefEV4YH46A+Z0fbZ8ch
 FGxvgkDDlAq94Ne9Dg3F3GPaKEJbDlZ+dHTdO4LKKAqpixPm4ul0m5wKszxpljp08QWq
 YyEyucQPftpWzm0LbNHrtcH8UvkWz4vHxJEoHxYvn1Dc+WQpIPRExnGSxphGVWxuoty0
 33QIZkIOo3u1MP5dUin2lCeC72c3g4YRyTY1XwgacEFzwVcWv7T53YCueoGxNWEeCQjh
 stJnEo8FCrwD+nWfzBHazsod4HXL1bVuM8ObZefW5+43v4HNIcxWLkukTr0Ri2Z/qraj
 4ZUg==
X-Gm-Message-State: AFqh2krVY351rIRkIONz/f2Nw7tQ/iJrLEqoD59z6ojyrN5ma7V4AfsC
 AzgNeOkVYjAV8dPInX1vong=
X-Google-Smtp-Source: AMrXdXumOYJVIeR+L80VaBfg+7EE3ziiM7hvJc28Az+7LMAzDmKLWnJZVSlOj1uopvZsN+XlQMhKhQ==
X-Received: by 2002:a5d:5257:0:b0:2a8:e91d:ad31 with SMTP id
 k23-20020a5d5257000000b002a8e91dad31mr23985107wrc.62.1673623343775; 
 Fri, 13 Jan 2023 07:22:23 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:9fe7:7ab3:383d:1efb?
 ([2a02:908:1256:79a0:9fe7:7ab3:383d:1efb])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adff00e000000b0024cb961b6aesm18778177wro.104.2023.01.13.07.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jan 2023 07:22:23 -0800 (PST)
Message-ID: <bb96bd81-b62b-4f1e-25c9-a9ab66841988@gmail.com>
Date: Fri, 13 Jan 2023 16:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Braiam <braiamp@gmail.com>
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
 <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
 <CAG=7Bt8xY_SHQwNCDgFCSNczBPxjUwjf_yvR_Ox-_XS+DVuJxA@mail.gmail.com>
 <CADnq5_NEznbC8FDjaA+WPqTMLX7nuN7MdvdFWDYNXK_F3y=hQQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NEznbC8FDjaA+WPqTMLX7nuN7MdvdFWDYNXK_F3y=hQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.01.23 um 16:09 schrieb Alex Deucher:
> On Fri, Jan 13, 2023 at 10:05 AM Braiam <braiamp@gmail.com> wrote:
>> AMD RX 590. Forgot to include it. How do I know the blanking period?
> OK polaris falls into the first bucket.  Look at the full modelines.
> E.g., xrandr --verbose.
>
>> Would variable refresh rate mess up with that?
> Probably.

Totally, as far as I know VRR is currently a complete show stopper for 
reclocking the MCLK.

But on the other hand VRR could potentially be used to artificially 
create some overlapping VBLANK period to do the actually reclocking. 
Interesting idea.

We might want to ping Harry or somebody else form the DC team if they 
have thought about that yet.

Christian.

>
> Alex
>
>> On Fri, Jan 13, 2023 at 10:57 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> On Fri, Jan 13, 2023 at 9:47 AM Braiam <braiamp@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I have two monitors with the current following configuration:
>>>>
>>>> Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
>>>> DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
>>>> right x axis y axis) 597mm x 336mm
>>>>     2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
>>>> 143.97   120.00    74.97
>>>> [snip]
>>>> DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
>>>> axis y axis) 597mm x 336mm
>>>>     2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
>>>> 50.01    48.01   144.00   119.99    99.99
>>>> [snip]
>>>> HDMI-A-0 disconnected (normal left inverted right x axis y axis)
>>>> HDMI-A-1 disconnected (normal left inverted right x axis y axis)
>>>> DVI-D-0 disconnected (normal left inverted right x axis y axis)
>>>>
>>>> The pp_profile_mode:
>>>>
>>>> NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
>>>> SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
>>>>    0   BOOTUP_DEFAULT:        -                -                -
>>>>           -                -                -
>>>>    1 3D_FULL_SCREEN *:        0              100               30
>>>>          10               60               25
>>>>    2     POWER_SAVING:       10                0               30
>>>>           -                -                -
>>>>    3            VIDEO:        -                -                -
>>>>          10               16               31
>>>>    4               VR:        0               11               50
>>>>           0              100               10
>>>>    5          COMPUTE:        0                5               30
>>>>           -                -                -
>>>>    6           CUSTOM:        -                -                -
>>>>           -                -                -
>>>>
>>>> I have set their refresh rate to 72.01 which is a mode equal for both,
>>>> and the MCLK wasn't downclocked either. They are branded HP and
>>>> Scepter. Using a vtty doesn't help either.
>>>>
>>>> Is having the exact same monitor really required? If not, how can I
>>>> check what is causing
>>>> the memory clock to be pegged that high?
>>> It depends what GPU you have.  Older ones can only reclock memory
>>> during the vertical blanking period assuming it's long enough as the
>>> whole reclocking process takes a certain amount of time.  If it
>>> doesn't happen during the blanking period you will get visible
>>> glitches on the screen when the reclock happens.  If the vertical
>>> blanking period is not long enough or if the vblank periods are not
>>> aligned when using multiple monitors, the driver doesn't reclock.  The
>>> mode lines (not just the refresh rate) have to be the exact same for
>>> the vblanks to line up when using multiple monitors.  Your best bet is
>>> to take the mode line you want to use from one monitor and apply it to
>>> the other monitor.  Newer GPUs have more flexibility and can reclock
>>> memory in more situations, but there are still some monitors where the
>>> timing may not work out.
>>>
>>> What GPU do you have?
>>>
>>> Alex
>>
>>
>> --
>> Braiam

