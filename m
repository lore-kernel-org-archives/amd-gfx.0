Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A4C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 21:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CCF10E443;
	Mon,  6 Feb 2023 21:22:18 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFDF10E44A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 21:22:16 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1442977d77dso16783469fac.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nxr8FKyyFI0IRGZk8/b9cX4+zuqHKyzjx/4GmJbR22U=;
 b=WasBatVn+AEwRl2NTdauo6P76XdOa0+9WJKJ+diVdtxkAvG473mPVpc+HyD0VZ2WBe
 0FoizrdvM2dhZxnjTVmYJgDX9SWzpDtEv2wLDzbYtbRMwPtqaZlE/wwNVnXh1cHLXSZy
 W8zF2fNukq0AcBbn7CgLTy2QbHvcifnlu5uvses9yyDv10Cc7hiEa7IGmCizFHJ4ANEm
 LdPmKnxxp1tHxOH7M/Ghkngme0RliSUpcuG1A7AqF/MpZmnWAbSvqNfLu2Sm/XRViyJ0
 5z3h5gwd8nYDutbFDNMllcwDFajtre0WCJdlMAiVY9RBXnKZlCVLt6CITEcEH2vv0z3i
 fOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nxr8FKyyFI0IRGZk8/b9cX4+zuqHKyzjx/4GmJbR22U=;
 b=thdXVzpAXg29wWJ2gcu2vmxJMUexiksawgdKGPIrl3GBejQo7PlZNy4CxPWvmpnwS6
 ZTLSGFCN7fLUPLayn7VBZyJ/7n/dvldPSDdPrrsZtX32I/wBtAkbwwz8Z2wUkdyx7xSg
 igb+zdHzYQCfln1A6WOD3boKxwO3gXKHg9wk87qB65thcv8XPs9kNaX9St7aF15XSDR0
 4YsV1jw6KzYn9PeShYZYdX7Gvuc+Q5iawbJBYjM32YU6iiv7Szo7CfdAMDPLGvdizg6F
 ZugYWoYnq2nKagvcxmluBnftBB/q3RQ1jwRejRdXHQ8rMLRmMWDPiCPbZdXy+bbWxT5h
 j2xQ==
X-Gm-Message-State: AO0yUKUSgl3Uzghlg8O1FKFvI8/48f45+5pqtdPvKhJnwXNHIPY3fl0e
 e0zOnNgvU6/5RT40YJWH/n0pxkkp8DAlxh0NTZ4dtMSE
X-Google-Smtp-Source: AK7set8FqKSgiBmkEHYZL2w+RBILT6ThLHgsBsndzExYivpS2ej7nsjSLI55a1srTvdxzPd7MRW3OH5+j6iee9OkrZY=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr139741oab.96.1675718535481; Mon, 06
 Feb 2023 13:22:15 -0800 (PST)
MIME-Version: 1.0
References: <rEMJPv8L9uDl7PSSJ_OtbkCcM9ABocJ_Mk8DuSUQpaB2fPEPNB6EBBo7XLlCKqsfF5bCz5jvr9CFt1pVzb37_KZBldUNBMcf2-2B3xDNVN0=@protonmail.com>
In-Reply-To: <rEMJPv8L9uDl7PSSJ_OtbkCcM9ABocJ_Mk8DuSUQpaB2fPEPNB6EBBo7XLlCKqsfF5bCz5jvr9CFt1pVzb37_KZBldUNBMcf2-2B3xDNVN0=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 16:22:04 -0500
Message-ID: <CADnq5_O__w5jkOoUALv96hybKP8qJs-=wcQAhcxy5kbiBg_vCw@mail.gmail.com>
Subject: Re: gpu_metrics does not provide 'current_gfxclk', 'current_uclk',
 'average_cpu_power' & 'temperature_core' on AMD Ryzen 7000 CPU
To: sfrcorne <sfrcorne@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 9:22 AM sfrcorne <sfrcorne@protonmail.com> wrote:
>
> Hello,
>
> I hope this is the correct place to ask my question. I was not sure if I =
should have opened a new issue on Gitlab or send an email here, since I don=
't know know whether this is a bug or intended behaviour.
>
> The question is about the new AMD Ryzen 7000 CPU's. These new CPU's have =
an iGPU and consequently provide a gpu_metrics file for monitoring the GPU/=
CPU (APU?). This file is used by programs like Mangohud, that try to read (=
among other values) the following 4 values:
>  - current_gfxclk
>  - current_uclk
>  - average_cpu_power
>  - temperature_core
> However it appears that on AMD Ryzen 7000 CPU's these 4 values are not pr=
ovided/updated in the gpu_metrics file. Other values like 'average_core_pow=
er', 'temperature_l3' and the other 'current_<x>clk' are also not provided/=
updated but these are not used by Mangohud at the moment.
>
> Is this intentional or a bug? And will this be fix and/or will support fo=
r these 4 values be added in the future?

What specific CPU/APU is this?  I don't recall off hand how mangohud
queries this stuff, but you can take a look at the hwmon interfaces
exposed by the driver or if you want the whole metrics table, you can
use umr to fetch and decode it via the kernel interface.  That will
allow you to verify that the firmware is producing the proper data.

Alex
