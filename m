Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F1510A3D90
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2A410E8FF;
	Thu, 26 Mar 2026 12:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nngAgGK0";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2311910E053
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 10:45:04 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so738263b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774521903; x=1775126703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n0BAauGmagTbOENQ9IwerF9CZPUvOyYDalEidW4Zs5U=;
 b=nngAgGK0uj4eeFwVhqFgFpj1lFBKQ2zqM0rgTeXNagrvaJeBcsrgp3wXCJoTyNO/5l
 yQvonjaK26oVtZxsLJjXZ7rHg9YdNFAX0d4+YPkf6oKN9zNdW6w8g0tp5AFThedouS0a
 2/Cb61hQhgA9KN6fgVXD8aI02i7lEkHFwEqFM6PdzbusdIK9cCvA5BSH75yt5ieRlJOQ
 4lkeYiuxlYmxd8wwa3xOMMyrjVnjkNhOy0QSIM2kWt/yX5J8ylGlSuT2gSvR+lxMP/qk
 lS7UKy23eKmkjsh3hN0KQ1eZuLoLYiV17ZfS3g5vZwMjmF29QuhhCqRGwBOTy08Z3XlD
 fLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774521903; x=1775126703;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n0BAauGmagTbOENQ9IwerF9CZPUvOyYDalEidW4Zs5U=;
 b=KEgMlxcwZo+c+ZPAnoYHcXJm6UTf5fiO4kkgOMErD62Oxo3ur2D/Hf+M8o0UIkEUMn
 pt23HTC68Xub9dgVJHu1RYRNhlJUKiLufQyKMLFygGNgm5iekenBP+Y6AsWpRKTe0IYv
 ig3IEgJV09ACAGWAVcylrpwbmXCxqrkoHFKv9xqgEVkdDdnA7e+cozcxdKDzihP7j52F
 +2BE487d+NkaHtJZSIh7GNLLuvxUfjrFytz1YCn5o7OBudHx8/toMRErdOk1mJ2U0QKf
 D2aBljNKW/uoQL2lGEYW01RwWhA0KylF8krvPv/HlnePlA1cxMhoT3RN7yJ+w+enNq7X
 maEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJCMBzl8L5AMExKXxluuXPVUlLVRScjEmJRxDdPd94iczxPAaxL4aHxW11c9/xZRNyOK70XBF1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRXm0t3mgcEeLMIVLn++LUsTc+MFXXTNSDXnqv7cs5nr42uhS5
 JposlSKg0I8XgRaFe0kxRAhD67C3cjU9CnI2K0WNEWjaqzqo1neLfp3sHH/TG5DO
X-Gm-Gg: ATEYQzz5qO26yWT7DYoJwY5lNjmoQnj7D4tEALSa6BDzXl9JExgl0K9nNlo0oh5mxUD
 WDWAIJXFvvZ6sYrU1GfO2568dXVDE3ejhBNXNktGrDXg/eN1OiTurNvJ6zxGL75h1nng9PDUyZs
 yUj94j51RZvVCi03DLEPNr+uh6/XWH8HKIL9VxN2NcK6wYWrQgCfJiT84jJyNS+Pk80VGO5UCl5
 LmkAckZeSPbVb354Bea/VrCXAbkeqkLGAOgs34ur3+aVbC01tSQVEDPFncOns41rXbJCrI3Tv0g
 DQxL5+xPQiTmpVA8fMa0+CO+BBOFUAvHNaHG1Foz3tcaN4mhu4l4xVRgSeilzI57dVGy7Vjpqn/
 11cW+X3XDNPdPsUXa7HjLAiOEzSvzynhG17L72M76eTWyvgBJZYM/EaMtzAEpvCPvpcoVZreNqw
 9MSQKrY2ErfxREhOLser9zvA==
X-Received: by 2002:a05:6a00:3c8d:b0:82a:805a:7cc with SMTP id
 d2e1a72fcca58-82c6de6dc69mr6815122b3a.4.1774521903497; 
 Thu, 26 Mar 2026 03:45:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d3c2714sm2284862b3a.48.2026.03.26.03.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:45:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Gaurav Batra
 <gbatra@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
Date: Thu, 26 Mar 2026 16:08:35 +0530
Message-ID: <1ph6ooyc.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
 <5x6knm5q.ritesh.list@gmail.com>
 <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
 <341nolfr.ritesh.list@gmail.com>
 <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Mar 2026 12:50:40 +0000
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

Dan Horák <dan@danny.cz> writes:

> Hi Ritesh,
>
> On Wed, 25 Mar 2026 23:12:16 +0530
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>
>> Gaurav Batra <gbatra@linux.ibm.com> writes:
>> 
>> > Hello Ritesh
>> >
>> > I think, what you are proposing to add dev->bus_dma_limit in the check 
>> > might work. In the case of PowerNV, this is not set, but 
>> > dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
>> > was before.
>> >
>> > Also, since these both are set in LPAR mode, the current patch as-is 
>> > will work.
>> >
>> > Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
>> > not able to lay my hands on a PowerNV box yet.
>> >
>> 
>> It would be this diff then. Note, I have only compile tested it.
>> 
>> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
>> index 73e10bd4d56d..8b4de508d2eb 100644
>> --- a/arch/powerpc/kernel/dma-iommu.c
>> +++ b/arch/powerpc/kernel/dma-iommu.c
>> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>>  }
>>  bool arch_dma_alloc_direct(struct device *dev)
>>  {
>> -       if (dev->dma_ops_bypass)
>> +       if (dev->dma_ops_bypass && dev->bus_dma_limit)
>>                 return true;
>> 
>>         return false;
>> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>> 
>>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>>  {
>> -       if (!dev->dma_ops_bypass)
>> +       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>>                 return false;
>> 
>>         return is_direct_handle(dev, dma_handle);
>
> this seems to fix the amdgpu initialization, full kernel log available
> as https://fedora.danny.cz/tmp/kernel-7.0-rc5.log
>
> Tested-by: Dan Horák <dan@danny.cz>
>

Thanks a lot Dan!

@Gaurav,
In that case, please feel free to take the diff and submit an official
patch (if you think this looks good for all cases). You might want to
test your previous usecase once, so that we don't see any new surprises
there :)

-ritesh
