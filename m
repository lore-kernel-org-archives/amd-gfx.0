Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 11:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AED60551
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 11:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4AED60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A8A898AA;
	Mon, 25 Oct 2021 11:23:42 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C27D898AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 11:23:40 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id p14so6220825wrd.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
 b=dcLz/4fMoOzmVl2D+aaGjBKG2ULuC3/o64EkVkImWK67kW3V4mwvpKWoMWuTA7VaYw
 Bg+hj+NxCwOr87qPewiOOkZ0VT4MMcDzpEBDNYRGPXT0GRgINVje/dOiUaQlZSIhXbtE
 FbflKlBYNaekSlStrbDOZJil1+qZvf4BsNbTIaLOJXTgsf0yoON4Mh0U3MOOphN53OpI
 3PAPBIlNXzNcF6AV6XmkshR4Hd36eQrglS4qF+PCBDRZ+w2QwVNm/F5NFro4zyolq+hQ
 8bgafTrKHxRz3FLrauXnlc+TgF4X/GNFaj6lfg7d3xqm4y1l7VFGBukPzqk2a+gFEDEU
 NuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pnAOfuMn5EWMJj8YVjvNcYDnPGOu1OrWcdPGU69i9WU=;
 b=HDzHwPIUfzdJJukybXBipsQVxTRvSoXqEBy9CEjX6SRGcDXKf29/5HgXrJZ45rCRw0
 id/jvKsHmB8y/KyeH35tcST7hJ0duZmoTEWR5BvyfPuGD8MXLTM0Kl1CQ+sORwLSGXQ+
 7REDRhcQKEAbDI1UmSD8I/TfDBrZ/W0mrmgWPGaVvbsWr5wuTa8Z3AInFFR6tZcZl7L2
 W8indMdaxBNRwmKnPoQ/dHWeAxGEU2juu8nbMe+8osYQHzkKNEPuL+wevsAZ5PlZJQaa
 ECY7P6Z5/FodxVRfY8dAf0pEjqWHnJ3pa5Y8I90qf8dY5aA7IFe5LvVsE/XmUooeA+bR
 9puw==
X-Gm-Message-State: AOAM533SBtvNJm24nebVM5+gQGwizckT6FSzs+zntpxHLl4KUPG0zPDr
 2jggme5Dp6kKVFFe3O+4mgA=
X-Google-Smtp-Source: ABdhPJx0t3+Pcy8GZqhqvya20QCKopu7PsZvwn6w0Fdd4q31S3HmDFYbbvzQoRHLvC2Af/Pma2lIXA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr22842373wrv.206.1635161019070; 
 Mon, 25 Oct 2021 04:23:39 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j7sm20229073wmq.32.2021.10.25.04.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 04:23:38 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 it+linux-iommu@molgen.mpg.de
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Date: Mon, 25 Oct 2021 13:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Paul,

not sure how the IOMMU gives out addresses, but the printed ones look 
suspicious to me. Something like we are using an invalid address like -1 
or similar.

Can you try that on an up to date kernel as well? E.g. ideally bleeding 
edge amd-staging-drm-next from Alex repository.

Regards,
Christian.

Am 25.10.21 um 12:25 schrieb Paul Menzel:
> Dear Linux folks,
>
>
> On a Dell OptiPlex 5055, Linux 5.10.24 logged the IOMMU messages 
> below. (GPU hang in amdgpu issue #1762 [1] might be related.)
>
>     $ lspci -nn -s 05:00.0
>     05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, 
> Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 OEM] [1002:6611] 
> (rev 87)
>     $ dmesg
>     […]
>     [6318399.745242] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffff0c0 flags=0x0020]
>     [6318399.757283] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffff7c0 flags=0x0020]
>     [6318399.769154] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffe0c0 flags=0x0020]
>     [6318399.780913] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xfffffffec0 flags=0x0020]
>     [6318399.792734] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffe5c0 flags=0x0020]
>     [6318399.804309] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffd0c0 flags=0x0020]
>     [6318399.816091] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffecc0 flags=0x0020]
>     [6318399.827407] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffd3c0 flags=0x0020]
>     [6318399.838708] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffc0c0 flags=0x0020]
>     [6318399.850029] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
> [IO_PAGE_FAULT domain=0x000c address=0xffffffdac0 flags=0x0020]
>     [6318399.861311] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffc1c0 flags=0x0020]
>     [6318399.872044] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffc8c0 flags=0x0020]
>     [6318399.882797] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffb0c0 flags=0x0020]
>     [6318399.893655] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffcfc0 flags=0x0020]
>     [6318399.904445] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffb6c0 flags=0x0020]
>     [6318399.915222] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffa0c0 flags=0x0020]
>     [6318399.925931] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffbdc0 flags=0x0020]
>     [6318399.936691] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffa4c0 flags=0x0020]
>     [6318399.947479] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffff90c0 flags=0x0020]
>     [6318399.958270] AMD-Vi: Event logged [IO_PAGE_FAULT 
> device=05:00.0 domain=0x000c address=0xffffffabc0 flags=0x0020]
>
> As this is not reproducible, how would debugging go? (The system was 
> rebooted in the meantime.) What options should be enabled, that next 
> time the required information is logged, or what commands should I 
> execute when the system is still in that state, so the bug (driver, 
> userspace, …) can be pinpointed and fixed?
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
>      "Oland [Radeon HD 8570 / R7 240/340 OEM]: GPU hang"

