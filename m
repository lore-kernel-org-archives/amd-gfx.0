Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20350C7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 14:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885D910E122;
	Mon, 22 May 2023 14:03:43 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E199B10E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 14:03:41 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-19615d6ef9eso4760282fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684764220; x=1687356220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zf8Ase7Y+Qj0Vij4c1vaAbVXLgo+1VxMHaBHZAiyw4s=;
 b=IB9zFTlbpT7KW7XMHz3+BMNIqXIbTfqsECvv5KibXwQBo882QYj1xrPkfp55cOGNqI
 Zvl9cJyYbxC2/5jhKtrzAvXK4jgA4lvmIyDC+FoFwB6U2rlOgMpGQhts1E3yWmLDYz0G
 5Ra6c0Xyjg2lqeH72cVJCw7/K88B9DC5aBtEFJh6giT/P+N4bWuiccL284D4EuO2HHG+
 YDGpZSgohSy1y5Ieu1F1yuUEj92uKIkvNW+BYI6tbs8KWaKhGy3c8VOV0bIVlYEgQEie
 NsAvfnUBDqFdGf9Ty/Rogg2cMofD0o19SKgs9kc71VkeOi9sYgQryRsvTigLQHOle6Jj
 x1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684764220; x=1687356220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zf8Ase7Y+Qj0Vij4c1vaAbVXLgo+1VxMHaBHZAiyw4s=;
 b=gE77TDXsnTGIzxcUS7gKwiHAyjX+E2mQeNl15GYVsuFu5NcHMBygokeTzYTf9B76ab
 ay6+Y+TaLK/bzA4SQD+YK3Z3UjzajBv+n/ROC1C5iOVNRl0/9KNpqT7xVTsjRYmEaeWT
 vSCj7eQ+9jYSwsEtlcjI5fLdehgDRhTZ8QD1eDGtKKhU6Kr0SsXdacapEFRdRQ4OlaB4
 CfN2gjkOL/1hQ3N8f4eX2EmO/FO+/kbAKmSXtXdcsi5INFUdX3A55sXHJSt27YYxUAaY
 Oy00hSjBrSnTGpGpMQEN21C9aCfPAqProZ2dbcKXgT6lAMjJvefI3A4s5tMcJGLJbJkJ
 ahTA==
X-Gm-Message-State: AC+VfDyPJ3r0n79KbhX/wpv/I0LcAnbjulyvHldosvl4EAmJR1TNHoUs
 LIRVoSsbBLJBv49vqkIUIWc32n6wgttIeL3y22JFNE+1scE=
X-Google-Smtp-Source: ACHHUZ4H42F0qNHSueQi7aeOlD9zrlPvinkGHOZloIxaldXKf3GxovCKPaEskKmM0oWmoZE4NDhhk7qb/TMKeYAo3bs=
X-Received: by 2002:a05:6870:4148:b0:199:c5d9:2462 with SMTP id
 r8-20020a056870414800b00199c5d92462mr6388681oad.7.1684764220602; Mon, 22 May
 2023 07:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABKykwm30UKMWmzPhN3DDsDa7L1x-DhP7rPMVMvqAwzPk2sDFg@mail.gmail.com>
In-Reply-To: <CABKykwm30UKMWmzPhN3DDsDa7L1x-DhP7rPMVMvqAwzPk2sDFg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 10:03:29 -0400
Message-ID: <CADnq5_M08MkS0FZvF71SH79guXa0nGo5V-BDc7N4q-=3D+vV2w@mail.gmail.com>
Subject: Re: [QUESTION] gfvhub_v2_1 updates CNTL regs before initialize
 related page table address
To: Zibin Liu <ghostfly23333@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 20, 2023 at 1:34=E2=80=AFAM Zibin Liu <ghostfly23333@gmail.com>=
 wrote:
>
> Hi,
>
> I'm looking at the initialization sequences in gfxhub_v2_1.c. I'm confuse=
d on whether the GCVM_CONTEXT1_CNTL CNTL reg can be written before the corr=
esponding GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and GCVM_CONTEXT1_PAGE_TABLE_=
END_ADDR reg is written.
>
> Here is the background:
>  * gfxhub_v2_1_setup_vmid_config() enables GPU clients to use GPUVM VMIDs=
 to access memory.
>
> The code related to this questions is below:
>
>  324               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
>  325                                   i * hub->ctx_distance, tmp);
>
>  326               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_=
START_ADDR_LO32,
>  327                                   i * hub->ctx_addr_distance, 0);
>  328               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_=
START_ADDR_HI32,
>  329                                   i * hub->ctx_addr_distance, 0);
>  330               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_=
END_ADDR_LO32,
>  331                                   i * hub->ctx_addr_distance,
>  332                                   lower_32_bits(adev->vm_manager.max=
_pfn - 1));
>  333               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_=
END_ADDR_HI32,
>  334                                   i * hub->ctx_addr_distance,
>  335                                   upper_32_bits(adev->vm_manager.max=
_pfn - 1));
>
> Just wondering, is the behavior expected or is it a bug?

As long as the memory hub is idle, I don't think there are any
ordering requirements for programming it.  I suppose if you wanted to
be really safe, you could set VM_CONTEXT1_CNTL.ENABLE_CONTEXT=3D0 before
programming everything and then set it to 1 at the end.

Alex

>
> Thanks,
> Zibin Liu
>
>
