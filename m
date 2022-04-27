Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06258C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 01:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9577410E0F3;
	Wed, 27 Apr 2022 01:53:54 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31B110E0F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 01:53:53 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id e24so219017pjt.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=zewmh2a9pR2gBklisjmSCPirfFVMf24e+AJpFmctRg4=;
 b=nwJhclTiemvcY1agaZfSO2k0POcRyFeCz5F5E3PKa3ZZsLFPoEYmOnoLEPB+MBGQpw
 eYk0oj48XYgn7pHzxFFaxXQgXPiOE7pgZTKiXXf3cM6z5BJNeAHIvafSNat0NJ2t4yVu
 exzyU2dMO+/4JG7kguJSZhRdItPZVdzcyhaNPnsR5ll2x3mKocqivZt412/VtPzw0ydJ
 /W7AmF4KM9URIVpOsKauFUZThcwKsIY0tco2XYP7Iv/JsDufDV8sOFVH0sg8N3RSv72I
 sRoXIhq116L5giAPnjWbzkwJqhBczoAFGxpZOZNJFrRqT1j0ns/SqCmqrKm2+CytJMj6
 fshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=zewmh2a9pR2gBklisjmSCPirfFVMf24e+AJpFmctRg4=;
 b=tRiJ659k4khZOsXMgnEcCwylPyi8+8XZ4UkOHnMpKnQLU8+J60+NJKdepV+5SiFwyi
 hB/ooTzSh4cwcBkPimY1RDMXln4Gjy79VXi3Zpc1Yp5u0c4zTmQJnmNvDkJu9srBhrcw
 CPIzUB7KdH2VccedgsXJ8fGw8BIHNmDOmk2Z4QUt6/v/I+szEXi1+7CHOBt24K1B37Qt
 AjrXz0rnvz6zXhG0S802NHionBTBq81YLjqlnYfHnVJU+NoWaUK3btINd8QhsvITNXiG
 5hAGbQz/3WxVkjfFqNgwDD6EK9108mLpu7iFSTrFY3OZisVhRjYRU9jnAPFdBS/lwfsU
 4EJg==
X-Gm-Message-State: AOAM533NF/jMsslk6vcArnRqqwgovkCHSGtwOhwxfc+UBmpZS1AiwI4Z
 1MBMAFSoA3CWpX6iGpwYzcE/RhikMfHTpotq/4nuwlGUGG4=
X-Google-Smtp-Source: ABdhPJxQUICv3NfXrXtbn5SBoilDT6ZJppaMngQjf6qGK68kzNVHCcRunvv3xQRj+qCOjjeY7Pgx4WxbsXw5wXGLkXM=
X-Received: by 2002:a17:902:f64c:b0:156:4349:7e9b with SMTP id
 m12-20020a170902f64c00b0015643497e9bmr26785164plg.139.1651024433220; Tue, 26
 Apr 2022 18:53:53 -0700 (PDT)
MIME-Version: 1.0
From: Haohui Mai <ricetons@gmail.com>
Date: Wed, 27 Apr 2022 09:53:41 +0800
Message-ID: <CAHpOOhHvr1OkXJ=z9dnm7ES4gXLkWbHzLHqSkipyqCv5HR7Jvg@mail.gmail.com>
Subject: [QUESTION] sdma_v5_2 updates address with an running async dma engine
To: amd-gfx@lists.freedesktop.org
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I'm looking at the initialization sequences in sdma_v5_2.c. I'm
confused on whether the DMA engine should be activated when updating
the MMIO registers. Some clarifications are highly appreciated.

Here is the background:
 * sdma_v5_2_enable() toggles the HALT bit to enable / disable the
async DMA engine
 * sdma_v5_2_resume() initializes MMIO registers (e.g., queue
addresses) of the DMA engine.
 * sdma_v5_2_start() is called when the kernel initializes the device.

However, the driver has two paths when updating the MMIO registers,
where the DMA engine is activated / deactivated respectively.

When amdgpu_sriov_vf(adev) is true:

   866         if (amdgpu_sriov_vf(adev)) {
   867                 sdma_v5_2_ctx_switch_enable(adev, false);
   868                 sdma_v5_2_enable(adev, false);
   869
   870                 /* set RB registers */
   871                 r = sdma_v5_2_gfx_resume(adev);
   872                 return r;
   873         }

When amdgpu_sriov_vf(adev) is false:

   893         sdma_v5_2_enable(adev, true);
   894         /* enable sdma ring preemption */
   895         sdma_v5_2_ctx_switch_enable(adev, true);
   896
   897         /* start the gfx rings and rlc compute queues */
   898         r = sdma_v5_2_gfx_resume(adev);

Furthermore, sdma_v5_2_gfx_resume() re-enables the already active DMA
engine when amdgpu_sriov_vf(adev) is false:

   728                         /* unhalt engine */
   729                         temp =
RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
   730                         temp = REG_SET_FIELD(temp,
SDMA0_F32_CNTL, HALT, 0);
   731                         WREG32(sdma_v5_2_get_reg_offset(adev,
i, mmSDMA0_F32_CNTL), temp);

The behavior seems inconsistent. Looking at the code that re-enables
the engine, it seems that the driver assumes a deactivated DMA engine
during initialization regardless whether the device is in vf mode or
not.

Just wondering, is the behavior expected or is it a bug?

Thanks,
Haohui
