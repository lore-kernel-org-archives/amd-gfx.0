Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3AFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 06:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23F110F804;
	Wed, 27 Apr 2022 06:03:19 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A7710F52B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 06:03:18 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id j17so725557pfi.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lGny7vEwo7v5y55PKJOyQZQLPHmlYxnjW85xSYymbI0=;
 b=aS36Jcr4px8LolbIR+CCUTIiDMZszVSbNcRVJeWZun4TxPE/aQjkV3STbs8MzGZoec
 Ycvz90YQS6adA14LDeU/V0RL8RqBwJ8HmetranZXbNzOwDc2qQE4ilCbzhTUOpFmjR4q
 jvIZetiA2IvWsS8SmZZ+9j8WMO+YaLbqnEqAXS8IqIh31ScHg5DymwKRkv/2W70XnTW1
 8IwbqHd0EwdyYEhyGOFTg4G9/9VuTX2RH1gmbreyjucQ1gh9n4qkegwK7qfZa+I6M0AL
 jqG21g93P8fc+ndLwTZihspv2rt7lVyY9vVi6C+YzXInVfbwqOH3EvSVMdwQk50G6ksQ
 wOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lGny7vEwo7v5y55PKJOyQZQLPHmlYxnjW85xSYymbI0=;
 b=mOG32n5ViUKVjU0fCn8Yjie9Y/RkIbhDsLRIFOrNjFiMpctcuOm7MnpJATdYSkfSqp
 cKTre+BhaksoYOpPhv/bOIlVqzPFrRiT6Ki16kWBgNyRFAVGkpXCrZad7IyIeZlB0LjS
 J+YvDZq5W9Bj4aWxgreorBjjq3VsQoZpz2WGKsvCXtfTmrqVDM4+tZU+w72NcU8+VzRj
 SaevQ4UVnh3QLWtY+CFpyoEZYLkgSj4JTBdzWk35Auvq1vVuISVXIluuc1C1gLXND4A2
 /b5sITlf4jj1PcyFsAcRpQpEd+FG6dypfOa43USunhAqIx9VI7flHjqZLK5d29O/Av0G
 /L6A==
X-Gm-Message-State: AOAM533AYlaRL7n0aTyR8duyxqmFqtDWGWxkGL0enFL+kFK+ndFt6QSC
 D/8AxqpfLvGKdHc6ONJVvuxpWVUPlxzLXMcgqe4=
X-Google-Smtp-Source: ABdhPJzUvIoozdzOmURvbqgxN/IXz/xNVJj+Yf4Kvx+R3DsGlfxW5DmFAr/lCMGsbSNzknU1V6cGPEyQYip2a6EFnXM=
X-Received: by 2002:a63:7702:0:b0:3ab:4d62:b68b with SMTP id
 s2-20020a637702000000b003ab4d62b68bmr11545371pgc.452.1651039397827; Tue, 26
 Apr 2022 23:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHvr1OkXJ=z9dnm7ES4gXLkWbHzLHqSkipyqCv5HR7Jvg@mail.gmail.com>
 <8c22f321-2080-8ab5-58d0-39bcd79c246d@gmail.com>
In-Reply-To: <8c22f321-2080-8ab5-58d0-39bcd79c246d@gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Wed, 27 Apr 2022 14:03:07 +0800
Message-ID: <CAHpOOhFiHWkPbWpqCY4=6tDiVszt2BfeZZWrgm+Ui_pB8LFGDw@mail.gmail.com>
Subject: Re: [QUESTION] sdma_v5_2 updates address with an running async dma
 engine
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

Great, thanks! I'll work on a patch then.

~Haohui

On Wed, Apr 27, 2022 at 1:57 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.04.22 um 03:53 schrieb Haohui Mai:
> > Hi,
> >
> > I'm looking at the initialization sequences in sdma_v5_2.c. I'm
> > confused on whether the DMA engine should be activated when updating
> > the MMIO registers. Some clarifications are highly appreciated.
> >
> > Here is the background:
> >   * sdma_v5_2_enable() toggles the HALT bit to enable / disable the
> > async DMA engine
> >   * sdma_v5_2_resume() initializes MMIO registers (e.g., queue
> > addresses) of the DMA engine.
> >   * sdma_v5_2_start() is called when the kernel initializes the device.
> >
> > However, the driver has two paths when updating the MMIO registers,
> > where the DMA engine is activated / deactivated respectively.
> >
> > When amdgpu_sriov_vf(adev) is true:
> >
> >     866         if (amdgpu_sriov_vf(adev)) {
> >     867                 sdma_v5_2_ctx_switch_enable(adev, false);
> >     868                 sdma_v5_2_enable(adev, false);
> >     869
> >     870                 /* set RB registers */
> >     871                 r =3D sdma_v5_2_gfx_resume(adev);
> >     872                 return r;
> >     873         }
> >
> > When amdgpu_sriov_vf(adev) is false:
> >
> >     893         sdma_v5_2_enable(adev, true);
> >     894         /* enable sdma ring preemption */
> >     895         sdma_v5_2_ctx_switch_enable(adev, true);
> >     896
> >     897         /* start the gfx rings and rlc compute queues */
> >     898         r =3D sdma_v5_2_gfx_resume(adev);
> >
> > Furthermore, sdma_v5_2_gfx_resume() re-enables the already active DMA
> > engine when amdgpu_sriov_vf(adev) is false:
> >
> >     728                         /* unhalt engine */
> >     729                         temp =3D
> > RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> >     730                         temp =3D REG_SET_FIELD(temp,
> > SDMA0_F32_CNTL, HALT, 0);
> >     731                         WREG32(sdma_v5_2_get_reg_offset(adev,
> > i, mmSDMA0_F32_CNTL), temp);
> >
> > The behavior seems inconsistent. Looking at the code that re-enables
> > the engine, it seems that the driver assumes a deactivated DMA engine
> > during initialization regardless whether the device is in vf mode or
> > not.
> >
> > Just wondering, is the behavior expected or is it a bug?
>
> Off hand that sounds like a bug to me. The SRIOV code paths are in
> general not that well tested since most testing/bringup happens on bare
> metal.
>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Haohui
>
