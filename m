Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2980C35242
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 18:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C909B20714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 18:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEUIod4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C909B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FF86E064;
	Tue, 11 Feb 2020 18:21:15 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497366E064
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 18:21:14 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t3so13672349wru.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ds4blAahlOYnUDAciV7fEin+yzIN1JFYz2S9Jb4fVKc=;
 b=kEUIod4mRtcmHsntXDY0FNwJTzmsCKga69+UznI77QQzaVx+3+ITv6Ygo3eWOimJwD
 mR8rFQV4fflyH6eQQ/R2H43Mh7DTjVBdFS4xTehxT2s/jL145bLtfMML5/nX7Mngt1Er
 kgq3lbTN2tdwz6heoO7KG9Ya0FtuokYjFolRXwkwanpcXwn46DEW8TS4YJJTpXFMIxUZ
 vBUGuhXSU3/h4TSWys26UjdjhDdertaX0WPTSz37qAynmlxC6LmwplVlqhMamUsDXs4h
 EVtrYJyvcIaLno6VZVwPaGTWgQLZGNgW9E8qqsnp+Ljj5V1piaoDWG9Sl4yhggxEIayC
 bNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ds4blAahlOYnUDAciV7fEin+yzIN1JFYz2S9Jb4fVKc=;
 b=DvJ5nvtM4yBWFNbFQlq8YpTAgBv6b/P4CIAAJSNheCLFxjC6ecFk98qRdsdWyGwpqu
 MIIEsZqb5H9HMHDaeP69lrQANQIHLTAikk/tvQZcFX7JA8uZB6+tznpBwlEsHBQKNEog
 TpwlF/rJQ5ha2SiUcLBgAz1tocieyju+9wQXbB8vSoIMMR98XgtnVVlaNV4FqWJlFAaA
 nn+g0NyabK52y0FJ5OAYB0GXogCz1oFNfhJL7xx9EajwePRHVnQM3UWC7wN1LOWgFwl/
 qDQ2xI/9igY9ILqOF6t01PvWH08058xcrDuJrvn9LSlY2pp0jPDIwbEyJiYO5HHFRmQa
 WBKA==
X-Gm-Message-State: APjAAAVfjiK4b1FGdrvzvzv1bqR60172wNWIMvh/UHsy3CMpL8ibWgW4
 JWESO1pdx9L/I/HmSG1ULLd5x/Jdhnw7BD/BZ2V2uQ==
X-Google-Smtp-Source: APXvYqyfnpYBP0tIg8N3H/Xnsm1jmSMc6rsTZCC/g+67j+aDoMjlxACLMpOJg77rj31vE1ErsngE8EHZr9xJR7IBHdc=
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr10339243wrm.150.1581445272758; 
 Tue, 11 Feb 2020 10:21:12 -0800 (PST)
MIME-Version: 1.0
References: <CAEQFVGa9tzYgZeGLs5UY6yHfSHNZ0+Uqo3rTUzPjO+d7E2o-bA@mail.gmail.com>
 <ab79188c-70fd-5f35-71f6-bf6bcf773c94@amd.com>
In-Reply-To: <ab79188c-70fd-5f35-71f6-bf6bcf773c94@amd.com>
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Tue, 11 Feb 2020 19:20:50 +0100
Message-ID: <CAEQFVGbBq4oags-e8MTNB9vtDaX_5Ayr7w+wN0tLN1xEBVVjcQ@mail.gmail.com>
Subject: Re: Raven: freeze at 'modprobe amdgpu' in early console with
 android-x86
To: Felix Kuehling <felix.kuehling@amd.com>, "Yu, Qiang" <Qiang.Yu@amd.com>
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
Cc: Chih-Wei Huang <cwhuang@android-x86.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On Mon, Jan 27, 2020 at 10:34 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> I've seen hangs on a Raven AM4 system after the Ubuntu upgrade to kernel
> 5.3. I am able to work around it by disabling stutter mode with the
> module parameter amdgpu.ppfeaturemask=0xfffdbfff. If that doesn't help,
> you could also try disabling GFXOFF with amdgpu.ppfeaturemask=0xfffd3fff.
>
> Regards,
>    Felix

I have tried with the grub kernel cmdline mentioned, but the freeze is
still happening at 'modprobe amdgpu'

Is there an explicit list of kernel module dependencies that I could
check in our kernel defconfig?

I have also added Qiang, in case he may have ever seen the issue in
his former Android experience
KR

Mauro
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
