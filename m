Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4666CA9EC9
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 12:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA4C10EBEE;
	Sat, 10 Oct 2026 12:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jlbo2d9s";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB38010EA9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 16:51:16 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso8282966b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 09:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564675; cv=none;
 d=google.com; s=arc-20260327;
 b=Mig9GI0cq/VA9RZIQnUQuLDGPmvXz7XaE625RTlxHlN2WzyIKzD5ymbaOtHq1EMXIr
 yD7mfD4TVuWX2go/B/Jm78kmYLuws+xRtYXSFvzh6KHUxCD7stvKspPjOU4mDlAUf7Mi
 3teJgwZ1fWqZZ6EAJ8n9ZXSL+aDFHmfAQuS8NQNLV3VHUzgfXYi95b8tJHcTqHvR/BaP
 SPBFxo7G8z8yGmQta5ACh00SGSo3g/R32SHCECKNrOlix0OiC+49ain9A03O3Ve9Xr9H
 JTbBG/FUIxjLNYQxs8XjBRi+HEaz5IqQ6VjhsqGwqDVmopeL7lHDt2zMDhdyVB/+4BTJ
 FLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
 fh=k7HO2/ZixOCSDmfLp8IomlOm0jVvBFhxUOjZKuWcCZ8=;
 b=NAxECwsegIcUQBLVzqO1C73RD4j/63Qjzc8ffdja/YCSRroeMOVnrFcSSD7hYoJRhR
 7ITlcV65f3iLsYzCAY5Ibhs1yIKhms+DgYzxKuyh0QfnQZp4/PIem9LoeJClLmQvFdNT
 Ds/dmi50AS89W+yQ7JfF97i21GqPkIDQL4HyVBL9N+GqJO1ESPyD9wjubeZI/EE8i3K5
 Ssnd7be0yXzoNGT3p/5w8Y9wypwtkTF2NBh3zzuknpT8r9ddrOZCszdPR9hTcc32vbPr
 rS3+9/bKOm2y1h2eyrLSl69gfib/WFxGszpWLysdD9v7NPbnhPUHsU9xJftOUpOQXxxc
 MJdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791564675; x=1792169475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
 b=jlbo2d9sFSdl9HryWuPUmEp/nYy1ZN1Y8K3X+Pap5XFqfO8ecOgIcZ69Y7fIBpZOox
 b7JY+2hiKbTitiQY2v+2bOBzG2tDJqfNhJD6d+xympBQ6HhILBsCt0728z8uWEYOt2Dk
 ozq5sKrU6n5mGo8EPdSvpA7wMvOyp/Ow1VcL2dmlW7l7UVp33/cikXuZHD6piLvv8YNx
 5Jj74wbUq4aVo6et0DwIz6Y5sZYc6sW32Zq7VUDLnYADY35YDoA1bkfl0MDeb80NGY7k
 Oj/3+pHFw+6DJKU0wNUbkqLXqcT4ivT0hw14FHsO7De52xJN34b54IwhnMSWXvX0HzZK
 riRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791564675; x=1792169475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+8Tekpu+Ng6nSgWyCgi0KryBmJKh+vqeWpWiW1vi4I=;
 b=h7BAY5FxasQsX9BmWn6nYxXsqmuB3lzlrUPrVvTDS0hzuhH1rkvnHYGa3+UdGGM9DA
 bDhnuCb+/bU8FxAZfGF/DgvOHi4rCnvzMMJrE0j/RMShD3CsbcEop7MZmV7AnNUd+xh+
 +Vo/CdpVuJVIi8yGc4HzRriuQvGpcLjSZDHPXpZ3Fm3JGP6j0mfCvDNGFyvHPpJvmLYy
 ydH6UiJNF4fKdUmsD9DzFS3dUpNHcjJ7LIMklo1Rayovh3qZQ4klyiRBnQ+SfWQKCU/L
 SYj67r4q9fFc5cWVDrxIfUSGaQzHkpxFkSL/ODFrV/vufO8jT/2b8b72aFkYOpqxOxwF
 190g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1Xr704W/kviy7XhbftW3AvKJTE2D0F7L47bRopNIQP4s//1ObDoScUpRXbNIRLomQoAcyDidO@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLB7W6qY49QVw4ELnZZqE5LnWYUOyH5XyfEspMWK44LpUK2WJBb
 mQeKSoUe9x3g6QCpaP98fxnWggRFoxQjwj4WggTyCU0hsgq+6NZvU6WZZk1GmDoKy9ecM7vq1oy
 fCCukzNTY0M5/IEOT/B2nR05bIS/oHiY=
X-Gm-Gg: AYBFou2JP+4H0onMiym7n6qfJ3tZxClhx7bNHYPp8Zm8836IwyZQRfgwiiJG4hxpds9
 bjF0IWijVlhjw+pW2mTOG6zHTsNWgDdcrDVTvWJOBSVPm4dFbrAmmlOC2IoroqEg1/CmT49NVJY
 IcXbvv5ExRnzHmr1eDBgV913SBeMWwaEiYGCYWfpD5BAlyV87z+H34Au34UcWI5J592uasveUGM
 hSD7ymTQqIRBXfC+L8z8wYMliKFE8vqhC+2LM5G7apTjgqDUyYWusGXmtgLIyYEFykhKOa+yS4y
 h/JXXOy9+LnEbE8n5qvK9vp3hR6SAuKz0cZTuvz7b00TEeQvBR3LGDk+jw0cnVpHMmez1mdMGpO
 Rmdmn6qDPH0WIHgh3W+R/cSGJkcLd0YLyuBkdc/VyOmVV8uruCShYCF/4Im8g0K61nySo9OGSH4
 J4exPa2Oaaqkqldk+U0veF
X-Received: by 2002:a17:907:7b8a:b0:c2e:855:3375 with SMTP id
 a640c23a62f3a-c31aa05d48dmr267328266b.30.1791564674847; Fri, 09 Oct 2026
 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261009161832.GA980777@bhelgaas>
In-Reply-To: <20261009161832.GA980777@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Fri, 9 Oct 2026 12:51:03 -0400
X-Gm-Features: AclHuK-7AfAFQYv2cTll8HDVHIrz5FK0KVf6exm9S66osr63JbCL-_swxrWvd6k
Message-ID: <CABZrw2EnZzKCdJc2oCtm14YuDndpj=uAV+MRCmYEfimy_Zv5jg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v7.3
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver OHalloran <oohall@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, 
 Aditya Garg <aditya.garg@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 10 Oct 2026 12:37:50 +0000
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

I am now producing a draft quirk that uses the known device IDs and
models for you. Will post shortly.


On Fri, Oct 9, 2026 at 12:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b9=
35:
>
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3=
-fixes-4
>
> for you to fetch changes up to 79c168e2aa957ed0054c93db17caba653b95e377:
>
>   PCI/AER: Skip error recovery on false alarms (2026-10-08 14:33:04 -0500=
)
>
> This fixes some GPU initialization regressions caused by eddba19b8b5f
> ("PCI/AER: Support Advisory Non-Fatal Errors"), which appeared in v7.3-rc=
1.
> That commit also caused a MacBookPro16,1 spontaneous power-off regression=
;
> I expect a fix for that next week.
>
> ----------------------------------------------------------------
>
>   - Skip error recovery if no unmasked errors were signaled, which fixes
>     GPU initialization regressions caused by new Advisory Non-Fatal Error
>     support (Lukas Wunner)
>
> ----------------------------------------------------------------
> Lukas Wunner (1):
>       PCI/AER: Skip error recovery on false alarms
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
