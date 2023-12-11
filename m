Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0965C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 14:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6021289EB1;
	Mon, 11 Dec 2023 14:47:50 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7281E89EB1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 14:47:48 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c3f68b79aso22735205e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702306067; x=1702910867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLQKNWG31bmCq0uh5A9lLXoIJmaU/L7EJU4AARQ0Ljs=;
 b=LUFy25ZQ4eM3SMRY32p1aKMB51rwyzSnSz/NslKHz1JoMjf5D0qc1D6J0zJ5s4UthL
 wFiBpM7dLtiYtNYnDSLfMgH0onTNC3GIZ1HQb+BuIKN4BdEj4XJLJFUHFXVjwfi4A6my
 nYIXvuZ1TigTJQvlyNVEhNCsQZclHevoJz0swAXvMzis78d4w0mo2Wys7i/t1akDB794
 M1mga2pz2yLCno6zSMVEx7PfsGrMqqZePFbY2aZG6Izuxu2Ikjozm0+eb2nsGBE2Uhvc
 ZwQhBOknzarC2gHQLfmtiFMu9F1BtGs8V6vmLMC7Wb1oWCGyux/l/dqHZqa4qdZD2M+V
 YZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702306067; x=1702910867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLQKNWG31bmCq0uh5A9lLXoIJmaU/L7EJU4AARQ0Ljs=;
 b=nR6bkBkG59DZ7efvMbn23gHMNFhh+YXacJ67vlJAp9yfrq51C3p6/zLmUwDpDk3cEx
 dtJohmmnJkeoYLfoC4jdv0igow12K4WtCSW7O+ke2TOiQPYCY2A2fREhIp9xwsEmljCB
 KFkocqvyxGljsMgaRP8cYLFALmOeeC1eUsZjzaA/Fs9tl4je1KdlSF6NCoVWm025PmRS
 j2zFYaPBhtWBYXztikvF+lmAMcTeIMIhccOr7V/BXnFe7b8AbHKUOWwuFhnnqq7acJJm
 k/3M7R9UJMpwIosrf6TIoa4iel1B8ko7zLC9TGx83YcyINQgf27OiIKvauEOcFh6fJgJ
 ghUg==
X-Gm-Message-State: AOJu0Yw8E/n494lmOXYDx5Y79MyFcNnS3DQ8oxBpkBA1b9qgGepYMzUm
 JiJgSo7WIgcNMtZxD9Zipio=
X-Google-Smtp-Source: AGHT+IF1d0IaNijH6Bm1hFHuDUlx6lg2VgfOkfHQEI2ZtSYN4OIU6MwLG3o2uV10SPGBR9o7dLaMKw==
X-Received: by 2002:a7b:ce0f:0:b0:402:f501:447c with SMTP id
 m15-20020a7bce0f000000b00402f501447cmr2596452wmc.0.1702306066508; 
 Mon, 11 Dec 2023 06:47:46 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a5d55c6000000b0033340aa3de2sm8711065wrw.14.2023.12.11.06.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 06:47:46 -0800 (PST)
Message-ID: <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com>
Date: Mon, 11 Dec 2023 15:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
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
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.12.23 um 12:02 schrieb Hans de Goede:
> Hi Wifi and AMDGPU maintainers,
>
> Here is a pull-request for the platform-drivers-x86 parts of:
>
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>
>  From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu driver changes on top.

The few comments I had for the amdgpu patches were addressed and I 
honestly don't have time to take a detailed look at the general framework.

So perfectly fine to merge that stuff from my side. Alex or Mario might 
have some additional comments, but I think they will give their go as well.

Regards,
Christian.

>
> This only adds kernel internal API, so if in the future the API needs work that can be done.
>
> I've not merged this branch into pdx86/for-next yet, since I see little use in merging it without any users. I'll merge it once either the wifi or amdgpu changes are also merged
> (and if some blocking issues get identified before either are merged I can prepare a new pull-request fixing the issues).
>
> Regards,
>
> Hans
>
>
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
>
>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-amd-wbrf-v6.8-1
>
> for you to fetch changes up to 58e82a62669da52e688f4a8b89922c1839bf1001:
>
>    platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature (2023-12-11 11:33:44 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between pdx86 amd wbrf branch and wifi / amdgpu due for the v6.8 merge window
>
> platform-drivers-x86-amd-wbrf-v6.8-1: v6.7-rc1 + AMD WBRF support
> for merging into the wifi subsys and amdgpu driver for 6.8.
>
> ----------------------------------------------------------------
> Ma Jun (2):
>        Documentation/driver-api: Add document about WBRF mechanism
>        platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature
>
>   Documentation/driver-api/index.rst |   1 +
>   Documentation/driver-api/wbrf.rst  |  78 +++++++++
>   drivers/platform/x86/amd/Kconfig   |  14 ++
>   drivers/platform/x86/amd/Makefile  |   1 +
>   drivers/platform/x86/amd/wbrf.c    | 317 +++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_amd_wbrf.h      |  91 +++++++++++
>   6 files changed, 502 insertions(+)
>   create mode 100644 Documentation/driver-api/wbrf.rst
>   create mode 100644 drivers/platform/x86/amd/wbrf.c
>   create mode 100644 include/linux/acpi_amd_wbrf.h
>

