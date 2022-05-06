Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198C1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 08:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C3F10E416;
	Fri,  6 May 2022 08:03:45 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58EA10E416
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 08:03:44 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id q14so8342971ljc.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=6F41mRp4zpNWqTmL3ML/TZgLRmfR37uVeFtOFbwguuA=;
 b=J66/TiRZ94uLRcOCM5hogpnMFXIXG1D8ChJg0j2oAv6p0eTjaz29NDH1VR2Su5FJXz
 43AOjJqx3pUxPRiPEW3BsUFWbT27c5ajT2QcDKWue4lzIGGDU9HlVVaK72Fh0HPt2REb
 WQNipG7SjepzUasechA9xKg+JhUu0JaBk/MBP/GdjNfRQMiw0obexRKxECl+1JuoDNQG
 BzntRWk+zvsVNBuGInu2Z2TZjbtRXThcgh/wAOy+MEqGq5JW1qgLp50QMS8ZOZhR2pXr
 Nfa5InMtFuGtXbUcfdGEZibHXElq7iGAXa2cVhCjYOrVnuwqYk1SC+APq9R7hU5BAqTI
 fXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=6F41mRp4zpNWqTmL3ML/TZgLRmfR37uVeFtOFbwguuA=;
 b=DaEMfBCdr98WAEnkXEpgxx5jueUob+ILDWCm5Z71TrnGDkGvx0yZ7k0xNbrfFR+0lk
 fY5wvfiG7y8YqLT7Q0TPIYV9kXAK0CZO77j1moDSoqlMohCKedy8n3AkDOaiM6GdOjfw
 XnNwFoJHrDhbqNynrsmlCWIjGpgXrNIaj2ffbIwGJmci2NtY99gwz5vuUKs70uuwWaLI
 i3wTIahUcIa7MgZLo45pLNRHOP+b5p9lVAf/bahRE5jktFEZkmYIJwREZtpT9DAGGbkl
 WrM5E23AqY1NE2W6uImLfg9QiN4ZsuP58qlVJ/wyxk4HMqQChcqNGUsiv2nn3WE4T4gs
 7Ltw==
X-Gm-Message-State: AOAM531ThQNP65f4SrA77/sl5yiyB11TlUeluCJUvRZATztXzU2Sq9xg
 CWhNvQFaNynyA22KQaj+Ce+JuYaRHAcCp7FEwnCWwrBDtFg=
X-Google-Smtp-Source: ABdhPJzIVmh3wUKDqn5di6ce8yHV5WEWkQr0jHvjdUUoXjUgyDs3LK2B+hT9heLDwnnW5tyRULz3J6rtfXCjw0I24VI=
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id
 n19-20020a2ebd13000000b002461ff86da1mr1302841ljq.219.1651824222024; Fri, 06
 May 2022 01:03:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:a81:b0:13c:1acf:f8c9 with HTTP; Fri, 6 May 2022
 01:03:40 -0700 (PDT)
From: Amol <suratiamol@gmail.com>
Date: Fri, 6 May 2022 13:33:40 +0530
Message-ID: <CA+nuEB93EJAHEKzOYUPtY-vVkuzZsZM7cvoLsGUQxYEUxjOV8g@mail.gmail.com>
Subject: Re: [cedar] DMA ring test timeout [solved]
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: suratiamol@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/05/2022, Amol <suratiamol@gmail.com> wrote:
> Hello,
>
> While trying to program the HD 7350 Cedar GPU to run with DPM
> under the 157MHz/200MHz sclk/mclk powerstate, for single_display,
> and with forced LOW performance on the SMC, the DMA ring seems
> to hang.
>
. . .
. . .
>
> Does this mean that the GPU doesn't support running DMA ring at the
> lowest perf profile (157Mhz/200MHz)? I do still believe that this
> situation might be a result of faulty/missing programming on my part,
> though I am not sure what exactly it is that is at fault or is missing.

The mc_reg_table was being populated with invalid entries.

Thanks,
Amol
