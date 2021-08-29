Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB1EC4320A
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD99560F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD99560F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD50789CF1;
	Mon, 30 Aug 2021 07:17:53 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8820989D66
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Aug 2021 17:34:52 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id q21so21602328ljj.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Aug 2021 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=+tyqDIpy9lHRPLEmWy2u7JRjZCjvRQis9Naz0mJ7yyE=;
 b=oySpogacRpk+LnLteHTL+o2IoGe71EsG5C/4mD9Ax0r26rFKnrzw9z2VMz7rcjWYdc
 fw15ujivpp8Md4Kz+u3+j5zTzZXJiQewWAE4GSmX9MTAvudRvByxHXJXNQdGFllvo7sQ
 UpzpElBsMS+G0kQ8F1v9FWXYIqJrnhEeHHG0whVXni+ClRcl/iR82bXJwuhzKEthXthJ
 ORUXsDpKMu73UHfW5j9naMJXJmM8qQFP6v/Ip8EsTMGtY3IatnNlmQYXvFgQIPS4W4AC
 mbTaJKjGXFD+yXlIHk3PXnXm4FqfLSp8OfbI2W2nH/bGqDrhsDDYoKIx17rBFZ4FBat4
 x2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+tyqDIpy9lHRPLEmWy2u7JRjZCjvRQis9Naz0mJ7yyE=;
 b=m94p7T5U/0zpkDRBokhQ3ceOIna8DGS9HmH3kcASQ+1BrMaRucNzvZ4PXCMYuwBkoM
 X3XJ3guBw6sj+5lFl/HqJkxS9+4V6jOQT2eOzkW1KBHF2tZymbSSbxOLCzg/8tcR0UuS
 DB/mc5LhWI9+PUNA6UUQE7OupM+Yisks3qySiGf3Bo8TFV2MKaDzjvKNuu4VHG1cbI9c
 WmcsD1+BtVzqec9pGI1f4Ae4DUG4iVqCuUybk6hMC3c4q/SnkGyMvasLUDQJzpzyxIra
 SkeAXhlVlvgxvmffkFNFQPIRTcEIij6v2YxqzZZ5z9uGprzzvfjK8ekqxvvEXjmxFCbH
 j3nQ==
X-Gm-Message-State: AOAM530Xt4owTjvP0PfFOmJQLpFFaH0QhRqjBDgdWkjMX8K5OG7kTTF/
 tKomReIEr1Kn4GcGgZ2Pudw=
X-Google-Smtp-Source: ABdhPJxNAUdpNwROozWgJHg/GNiHjvth3ssRdC8Jhxxk0/TA5hltCIGQaZPDWWSVf9B733nuKb+aAA==
X-Received: by 2002:a2e:8610:: with SMTP id a16mr17648219lji.66.1630258490789; 
 Sun, 29 Aug 2021 10:34:50 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
 by smtp.gmail.com with ESMTPSA id r23sm1508814ljd.86.2021.08.29.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Aug 2021 10:34:50 -0700 (PDT)
Date: Sun, 29 Aug 2021 20:34:48 +0300
From: Kari Argillander <kari.argillander@gmail.com>
To: Skyler =?utf-8?Q?M=C3=A4ntysaari?= <lists@samip.fi>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
Message-ID: <20210829173448.3cwk4rz6wfxfxdpj@kari-VirtualBox>
References: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
X-Mailman-Approved-At: Mon, 30 Aug 2021 07:17:52 +0000
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

On Sun, Aug 29, 2021 at 06:38:39PM +0300, Skyler Mäntysaari wrote:
> Hello everyone on the list,

This is universal kernel list and it is not read by many. I have added
hopefully right list (amd-gfx@lists.freedesktop.org).

> Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel

I have no influence or knowledge about this driver, but I still try to
help because it seems good bug report. Have you test with 5.13.13 or
5.14-rc7. Does this work with some other kernel? If needed can you git
bisect if needed? You will probably get some support for it if needed.

	Argillander

> I thought that this should probably be discussed here,  so I came
> across weird issue to me which is driver crashing while trying to get
> one of my monitors working on Gentoo.  I would like to ask here how
> that would happen that the Display appears to jump from DisplayPort-6
> (physical port) to DisplayPort-7 (which doesn't exist physically)? Has
> anyone else experienced this?
> 
> It seems that the driver sees a rather large amount of inputs for the
> GPU, even though I only have 4, 3 of which are DisplayPort, and the
> issue monitor is also on DisplayPort. 
> 
> Hardware:
> CPU: AMD Ryzen 5800X
> GPU: AMD Radeon RX 6800
> System Memory: 32GB of DDR4 3200Mhz
> Display(s): BenQ Zowie XL2430 (1080p), DELL U2414H (1080p), DELL U2415 (1920x1200)
> Type of Diplay Connection: All are connected via Display-Port
> 
> Related DRM issue:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1621 which includes
> logs too.
> 
> 
> Best regards,
> Skyler Mäntysaari
