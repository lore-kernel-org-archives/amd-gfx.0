Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF0FC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7073061A07
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7073061A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCD56EB8A;
	Wed, 24 Mar 2021 13:33:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187F96EB33;
 Wed, 24 Mar 2021 13:33:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A3061A01;
 Wed, 24 Mar 2021 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616592827;
 bh=o9N4i7+3noUv0B6lJUnCsQ1a7vxB7qpfn9sOMth9bJM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QjzaBxVXzft4VWeTPw8A5sVm1pW/PtZkCRT8tUJv5DiUqJTMiIZH24/SYzSgH+49I
 RYAMumLPIjY2zQ+ESslZf5u4gCmhk50vC4lo5vjoExtxSBzYt+ta2WDiqNjxlQ3BxU
 zsi/Ue6pet0QxobkUplg9lKCmOPEa7MH4MpV2DHIi/iGErPQhP2mVhjGpVvGP4B51l
 9jiC88NSVAfsOFAw0UaFTU8JCAJhowbU5k+U8P/B4mXUV7d3vQ1u8NerwFk6IpZNoa
 sVLamh7L/6a5kgo7M0OaGFn2/lE5nnE3GCfPZ+8e7lQXaZsipwyLi/xKA7w3fRIhlA
 zHvtDWKLyjdKQ==
Received: by mail-oi1-f182.google.com with SMTP id f9so20785767oiw.5;
 Wed, 24 Mar 2021 06:33:47 -0700 (PDT)
X-Gm-Message-State: AOAM533l+h4KMKKBSMuNiKJzDEaE37Sm73YVZ5a+709t7HH5NQQNwfKE
 15/f9sopNJKhn/ryhK4+d1jVcZyEffP1au5hzgE=
X-Google-Smtp-Source: ABdhPJwLGMq5E9ddat76/h5D6iTzp4r4i2DAaKNqQgKerm3fo6JXWGsSPV4CM9kNFzrRvvQsedNSTb89dqaNsM7Iy0c=
X-Received: by 2002:a05:6808:313:: with SMTP id
 i19mr2358206oie.67.1616592826738; 
 Wed, 24 Mar 2021 06:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210323130430.2250052-1-arnd@kernel.org>
 <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
In-Reply-To: <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 24 Mar 2021 14:33:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Message-ID: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 23, 2021 at 4:57 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 23/03/2021 14.04, Arnd Bergmann wrote:
> >                       if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> > +                             int pos = 0;
> >                               memset(i2c_output,  0, sizeof(i2c_output));
> >                               for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> > -                                     sprintf(i2c_output, "%s 0x%X", i2c_output,
> > +                                     pos += sprintf(i2c_output + pos, " 0x%X",
> >                                               securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
> >                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
>
> Eh, why not get rid of the 256 byte stack allocation and just replace
> all of this by
>
>   dev_info(adev->dev, ""SECUREDISPLAY: I2C buffer out put is: %*ph\n",
> TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
> securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
>
> That's much less code (both in #LOC and .text), and avoids adding yet
> another place that will be audited over and over for "hm, yeah, that
> sprintf() is actually not gonna overflow".
>
> Yeah, it'll lose the 0x prefixes for each byte and use lowercase hex chars.

Ah, I didn't know the kernel's sprintf could do that, that's really nice.

I'll send a follow-up patch, as Alex has already applied the first one.

Alex, feel free to merge the two into one, or just keep as they are.

      Arnd
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
