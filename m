Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3998DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 06:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AA460F6D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 06:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05AA460F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944FF6EAAB;
	Thu, 16 Sep 2021 06:27:18 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518F76EAAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 06:27:17 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id s24so3921071wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=Z5LsTqfaUOJ/rKjI94Suht9SvPoHsLWriUPqeWVDito=;
 b=LXlKk8RlIqcJne6q7WDbkBl/p0rXQaX9k0z/2m27y4j7XqomURf9C5u9n96FdMKjpt
 m6TGhxcVQ3d19p10/hPXni4JTMtnyM5Ya3OwYm8Sre9EhseapquSZf8ceO8RJrhxo/ok
 kgkAkf5ssTOCN2s+wXWea453Sk6KGxHt86R2eNESNgbudTHKXzLWy7f/8sp3NzQRdBrd
 yt1+gfhhwScupFGT3DjRF30nYVnP6R7CrZyicOE7TQRLHa0WarhrZSOOvdKk6xZ3VgKe
 zRwSsaCT21qPx4TtPzQZl3LIitkL0mYyoqUohkASx4mRyK5XTUpZkx/CpJLgCPj3wmNM
 aDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Z5LsTqfaUOJ/rKjI94Suht9SvPoHsLWriUPqeWVDito=;
 b=vo5adH5gKHLpUeUj2LccYU3tFvvXxpTe0ZbnH2NxMdefFnFh8Yu+7iRiAm1SRd82YW
 IIL/zr6M//FHnXGW+j+numyPViQ0PfWNSSnJctTHsdhwGFDysPQ54NvxJawLgZOIKUge
 k3whSnppdWwei5QOludQG6tX+9CpZDJkxaKrkKX+ptRngIAejymSAmL2bxY6HoRaX9bp
 yr3TUmp/0uLeqcLDQtwM5UWHtyTqEV2HkknXtCDW1gwuD5aT2o0ge799My4o3hMHcR94
 t99ABD8Mgr9iswCIfuxHMsTW2/Rt4djUUHJgRDR8ARd9ey4TVflj/v9xemmPC9KD1ZY4
 Ls1A==
X-Gm-Message-State: AOAM533/Pl6u4Rc/uWdmbicTbPpvoUGjmYI8dnY0ubEWgN3va+amqTun
 PsEfmXmLiauGSt7wQopX79WvJquHD8AyJnI3
X-Google-Smtp-Source: ABdhPJyqAhPaKSXBJPYjVsl8TDD20xa2+VsvYWRAPDdxxG1XUcjIPEYH439ggkhvYH6RnQ6nZEdw9g==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr7972032wmj.151.1631773635696; 
 Wed, 15 Sep 2021 23:27:15 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id v17sm2141974wrr.69.2021.09.15.23.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 23:27:15 -0700 (PDT)
Subject: Re: DRM IOCTLS come regularly(every minute) still even after screen
 off
To: "Quan, Evan" <Evan.Quan@amd.com>, =?UTF-8?Q?=27Michel_D=c3=a4nzer=27?=
 <michel@daenzer.net>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "'amd-gfx@lists.freedesktop.org'" <amd-gfx@lists.freedesktop.org>
References: <DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4ded93f1-e6b1-06c3-9f03-b6135911392c@gmail.com>
Date: Thu, 16 Sep 2021 08:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------17B963B27232339583B13EA5"
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
--------------17B963B27232339583B13EA5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Good morning,

for the background I advised to contact you Michel since we couldn't 
find an explanation.

Alex explanation might be correct, but the CS seems to come from the X 
server and is always roughly 60 seconds after going into power save.

Any idea what that could be?

Thanks,
Christian.

Am 16.09.21 um 05:15 schrieb Quan, Evan:
>
> [AMD Official Use Only]
>
>
> Hi Michel,
>
> After the system idle for a while, the screen will be off(blank out) 
> and AMD GPU will be put into a very low power state(BACO) due to runpm.
>
> However, I found there will be still DRM IOCTLS(which I paste below) 
> coming regularly.
>
> And those IOCTLS(especially those for AMDGPU) will wake and back our 
> GPU into normal state.
>
> To me, that’s a little weird as the system was just left there for 
> nothing. I do not know what and why these DRM IOCTLs come for.
>
> Per Alex, it seems “desktop environments poll for display updates at 
> regular intervals”. Do you also think so? Or any other insights?
>
> /[68528.542455] [drm] comm="gnome-shel:cs0" pid=1306, dev=0xe281, 
> auth=1, AMDGPU_CS/
>
> /[68531.186534] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.197027] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.205649] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.216308] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.224912] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.233533] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.242097] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.250631] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.259269] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.267788] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.276401] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.284942] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.293477] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETRESOURCES/
>
> /[68531.302091] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETRESOURCES/
>
> /[68531.310689] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_LIST_LESSEES/
>
> /[68531.319346] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_LIST_LESSEES/
>
> /[68531.327880] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.336495] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.344985] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.355652] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.364217] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.372657] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.381089] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPBLOB/
>
> /[68531.389519] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPBLOB/
>
> /[68531.398702] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.407148] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.415572] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.424147] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.432682] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.441192] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.449754] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.458232] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.466723] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.475140] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.483608] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPBLOB/
>
> /[68531.492056] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.500520] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.508919] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.517270] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.525752] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.534235] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.542665] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.551169] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.559684] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.568152] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.576624] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.585143] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.593620] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.602075] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.610515] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.618989] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETPROPERTY/
>
> /[68531.627481] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.636060] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.644614] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.653131] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.661702] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.670250] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.678805] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.687356] [drm] comm="Xorg" pid=1035, dev=0xe201, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.695931] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.704526] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.713078] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.731981] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.740552] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.759552] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.768152] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETRESOURCES/
>
> /[68531.776663] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETRESOURCES/
>
> /[68531.785214] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_LIST_LESSEES/
>
> /[68531.793774] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_LIST_LESSEES/
>
> /[68531.802380] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.810882] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.819460] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.838377] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.847004] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.866051] [drm] comm="Xorg" pid=1035, dev=0xe200, auth=1, 
> DRM_IOCTL_MODE_GETCONNECTOR/
>
> /[68531.874725] [drm] comm="Xorg:cs0" pid=1133, dev=0xe201, auth=1, 
> AMDGPU_CS/
>
> BR
>
> Evan
>


--------------17B963B27232339583B13EA5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Good morning,<br>
    <br>
    for the background I advised to contact you Michel since we couldn't
    find an explanation.<br>
    <br>
    Alex explanation might be correct, but the CS seems to come from the
    X server and is always roughly 60 seconds after going into power
    save.<br>
    <br>
    Any idea what that could be?<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 16.09.21 um 05:15 schrieb Quan,
      Evan:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheadera4477989" style="margin:0" align="Left"><span
          style="font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD
          Official Use Only]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">Hi Michel,<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">After the system idle for a while, the
          screen will be off(blank out) and AMD GPU will be put into a
          very low power state(BACO) due to runpm.<o:p></o:p></p>
        <p class="MsoNormal">However, I found there will be still DRM
          IOCTLS(which I paste below) coming regularly.<o:p></o:p></p>
        <p class="MsoNormal">And those IOCTLS(especially those for
          AMDGPU) will wake and back our GPU into normal state.<o:p></o:p></p>
        <p class="MsoNormal">To me, that’s a little weird as the system
          was just left there for nothing. I do not know what and why
          these DRM IOCTLs come for.<o:p></o:p></p>
        <p class="MsoNormal">Per Alex, it seems “<span
            style="font-size:12.0pt;color:black">desktop environments
            poll for display updates at regular intervals”. Do you also
            think so? Or any other insights?</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><i>[68528.542455] [drm]
            comm="gnome-shel:cs0" pid=1306, dev=0xe281, auth=1,
            AMDGPU_CS<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.186534] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.197027] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.205649] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.216308] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.224912] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.233533] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.242097] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.250631] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.259269] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.267788] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.276401] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.284942] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.293477] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.302091] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.310689] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.319346] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.327880] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.336495] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.344985] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.355652] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.364217] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.372657] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.381089] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.389519] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.398702] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.407148] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.415572] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.424147] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.432682] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.441192] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.449754] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.458232] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.466723] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.475140] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.483608] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.492056] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.500520] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.508919] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.517270] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.525752] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.534235] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.542665] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.551169] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.559684] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.568152] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.576624] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.585143] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.593620] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.602075] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.610515] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.618989] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.627481] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.636060] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.644614] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.653131] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.661702] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.670250] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.678805] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.687356] [drm] comm="Xorg"
            pid=1035, dev=0xe201, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.695931] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.704526] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.713078] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.731981] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.740552] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.759552] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.768152] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.776663] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.785214] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.793774] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.802380] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.810882] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.819460] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.838377] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.847004] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.866051] [drm] comm="Xorg"
            pid=1035, dev=0xe200, auth=1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i></p>
        <p class="MsoNormal"><i>[68531.874725] [drm] comm="Xorg:cs0"
            pid=1133, dev=0xe201, auth=1, AMDGPU_CS<o:p></o:p></i></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">BR<o:p></o:p></p>
        <p class="MsoNormal">Evan<o:p></o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------17B963B27232339583B13EA5--
