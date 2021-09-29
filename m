Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D52C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 21:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AA861503
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 21:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90AA861503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1586E283;
	Wed, 29 Sep 2021 21:12:54 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D226E283
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 21:12:52 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so4582460otq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GJAybNRRW8vmslO6OLs3HA8I3B2T+E/Q9FLhtiTa+4U=;
 b=HIU/V6Z8baKk3HeG1TsfKRIad3hPke9bQeLdPT3HSkDBGQRlRcBvUVxj9bVUCWYcx1
 ljB7awkxv60u80NRqa8MI8JAyPSPolyhqeBAHrwlG+S0RiA2oUDwNtaTmg3MhuuZmj9I
 YDwcMraPY6zsl9OqRzy8gf6QO7Le5LkDGBSZtz60mwHw4G47F9PZ8C85R56nU+PP6Se1
 LhQP7+oP1khK0EgJxS05BYZoTJJJGyp6EhLZUvQnSbZ7wJfgE+W5ta5TGIHB9LP4tmyU
 dsJEbJ3heWec4wk2gKlictq2AUwOosusIvOHzGWvlb3umySGpYIy28LEuRoF02mAlxuh
 xYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GJAybNRRW8vmslO6OLs3HA8I3B2T+E/Q9FLhtiTa+4U=;
 b=hGccOXkhgntkNEpyRadZInYxgDTNUUV581rBKoANaMo1F0Miy8lUInZkSS8Cb6mgIg
 nN2sOpmGrx+KmBA1KDZbvM9mx1NMCHCS2XL77klpWQmkqLOJ1EJoOxo8Eod+iOaD2N/w
 xkhES0exQLiXCzhP5ZUAaovEQBhhSfK5onSqBc7VGgGPGYt1LtLfFiZSdKwfU0ooH7ni
 YI8lzzzNzsiuD8JVkx1E9BSLoLkUVrgXRdhzR+tEPGoMq1taVr/9uGypVK1pVHD0uzj/
 sC8nfwHUo79HyfB4JkTxbO+9ODb3IoeREYpIuUHNZOp+KQGIJFCHeoP50uUFUW2AiIx8
 7rJg==
X-Gm-Message-State: AOAM530szczTUM07Ir8ndhnQjMm8p/H5mJoVMkVR4L680CwK4yTouE+V
 zRSurcf+i67u+pDcbQ9wFwhwKievYhwoVhdGQIY=
X-Google-Smtp-Source: ABdhPJyUbSu8dwBQ0Zf4YoZV6fPIN7FMeUu2vTiooUo+t0afVeESFic+J+dUSdDwOJ9dpwHuVBrlEiXZJgV4rRCwy1Y=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id
 v6mr1849496ota.299.1632949971502; 
 Wed, 29 Sep 2021 14:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <f5d30be9-7980-e44d-0eca-7cfe7c0c1d05@kylinos.cn>
In-Reply-To: <f5d30be9-7980-e44d-0eca-7cfe7c0c1d05@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Sep 2021 17:12:40 -0400
Message-ID: <CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com>
Subject: Re: amdgpu driver halted on suspend of shutdown
To: =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 29, 2021 at 3:25 AM =E6=9D=8E=E7=9C=9F=E8=83=BD <lizhenneng@kyl=
inos.cn> wrote:
>
> Hello:
>
>          When I do loop  auto test of reboot, I found  kernel may halt
> on memcpy_fromio of amdgpu's amdgpu_uvd_suspend, so I remove suspend
> process in amdgpu_pci_shutdown, and it will fix this bug.
>
> I have 3 questions to ask:
>
> 1. In amdgpu_pci_shutdown, the comment explains why we must execute
> suspend,  so I know VM will call amdgpu driver in which situations, as I
> know, VM's graphics card is a virtual card;
>
> 2. I see a path that is commited by Alex Deucher, the commit message is
> as follows:
>
> drm/amdgpu: just suspend the hw on pci shutdown
>
> We can't just reuse pci_remove as there may be userspace still
>      doing things.
>
> My question is:In which situations, there may be  userspace till doing
> things.
>
> 3. Why amdgpu driver is halted on memcpy_fromio of amdgpu_uvd_suspend, I
> haven't launch any video app during reboot test, is it the bug of pci bus=
?
>
> Test environment:
>
> CPU: arm64

I suspect the problem is something ARM specific.  IIRC, we added the
memcpy_fromio() to work around a limitation in ARM related to CPU
mappings of PCI BAR memory.  The whole point of the PCI shutdown
callback is to put the device into a quiescent state (e.g., stop all
DMAs and asynchronous engines, etc.).  Some of that tear down requires
access to PCI BARs.

Alex


>
> Graphics card: r7340(amdgpu), rx550
>
> OS: ubuntu 2004
>
