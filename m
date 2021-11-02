Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE560C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D22160524
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D22160524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E68720A6;
	Tue,  2 Nov 2021 13:48:49 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CAC6FF98
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 13:48:48 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id i13so789116qvm.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EdWchaWpvzIQ1NfoWxE/g5XRAT2tgrFeZuqPVJPS/RY=;
 b=RVGHjE3p/RG5yBf75HyzePbwdENLrC1hiq4q6CzxhOYTSq5gNKXc1sv7rmeybjP9fO
 WDOHCddeiToqTHw2zflc6+3lAnkJe9q2q+TMGZYZE9IGg5cKNvkWoFapovVymWV2jxiy
 7kQ4ifCQMWr4M3YLiyYEYr8rKTxCJFhUVdzWb9EMnwAiqwPW6rUA3lvk6VV/gLdnWsW2
 8hBh30ItTPFqzzBXjHnOJSTVabVi09oM0sUXOUS9vpIpm7HJBIa5e52a/Ue5gcpfX87I
 6tdVGoRGhy+rMrDWCFUGd9PLiLXJ7vDBBypMZFBvYW3esvHlJE9Fyksyk9JwQj0vIOK4
 0Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EdWchaWpvzIQ1NfoWxE/g5XRAT2tgrFeZuqPVJPS/RY=;
 b=tlhFdD18oTaJqi+3K0PwTYoIzEe6NUffd5Breeaya7A4Ksww+Hb9dwq3zqTRuGSFZD
 o+J/Iyw922gYkqJ8qlhZLQtcROdRf/7bB9VO7A/3On/YGlr2p019m+Rp3SawAb3I51T0
 WQXzXFBVGallYyyySvg/fpRegDBp1GENO9NyEAbCFgU3v/BnPXMoRa96+NZph3NceDXK
 /cL4PzYsutOZq1R6814fJdAdufyl9FCbUOGHJ+4NJyELlhsd72QxKJKyn8E9jC1GTWpE
 UrfiG7G/f54upioPtIi8UcNF59vztDaufDvVIPiq3PjDB1xfx9IE4Nzc8GbEL7vRxhLw
 bH1w==
X-Gm-Message-State: AOAM532wdrfXzXiPUCIrtv2/bGqUpObkbiQq3DljC1Q5d5E6QY8hLH7f
 hCuP5d+gkdQobIhE+XiJYpY=
X-Google-Smtp-Source: ABdhPJyWWv3Q6GhoSZwxCEU8MMQSy7idVcnlcKcdHXh3BSBFdJmOztGuCF27T+rlijCtZGdFPLaalw==
X-Received: by 2002:a05:6214:d8b:: with SMTP id
 e11mr19495670qve.10.1635860927005; 
 Tue, 02 Nov 2021 06:48:47 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::49])
 by smtp.gmail.com with ESMTPSA id w9sm11622056qkp.12.2021.11.02.06.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 06:48:46 -0700 (PDT)
Message-ID: <d8e3eea3-5a92-8a0a-d15d-a1c2f5024ad2@gmail.com>
Date: Tue, 2 Nov 2021 09:48:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: amdgpu support for Ryzen 5XXXG, with integrated graphics: is it?
Content-Language: en-US
To: alexdeucher@gmail.com
References: <446fda20-a635-3b00-4886-661fff4ab0f2@gmail.com>
 <CADnq5_Nr_c7J-WrZfsOEAHQwerM7vgU=dC0JrO+B7wTh40Z_Wg@mail.gmail.com>
From: PGNet Dev <pgnet.dev@gmail.com>
In-Reply-To: <CADnq5_Nr_c7J-WrZfsOEAHQwerM7vgU=dC0JrO+B7wTh40Z_Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: pgnet.dev@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Yes, your device is supported.

gr8, thx!

> If the issue is related to the whether
> or not you can override the ycbcr vs rgb setting for your monitor,

i'm not clear if its a monitor issue, &/or or a (on-die) 'vid card' issue.

that said, most of the rumblings i've found so far _do_ refer to the ycbcr 'vs' rgb setting.

> you've found the relevant threads about that.  To upstream a solution,
> we need to get consensus across drivers on how to handle that and that
> has been a challenge.

'upstream' here meaning ... AMD.com or Kernel.org?

what, if any, additional info from my setup is helpful?

> I believe there are some experimental patches
> on one of the tickets you posted if you want to try them out.

missed them.  looking again ...

if there's anything specific you've in mind, pls feel free to 'point'
