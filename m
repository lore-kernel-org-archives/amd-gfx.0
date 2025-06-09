Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B2C71148
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A4910E8DE;
	Fri, 13 Jun 2025 16:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=r26.me header.i=@r26.me header.b="Sp/sfUli";
	dkim-atps=neutral
X-Greylist: delayed 52952 seconds by postgrey-1.36 at gabe;
 Mon, 09 Jun 2025 17:16:47 UTC
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1256289C5E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
 s=protonmail3; t=1749489401; x=1749748601;
 bh=Mmv4D6m6HZ+ZCvrc/3Fib8VNrQQAmGDeQVCJzexSH1o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Sp/sfUliJPKaIXzhyIwSNHr07c8lSllRGAfnv0Us/I1R4BXWlM5ppZHIGf2APhns5
 O6Py5r5qNTtNW2Dz6scY3VF0+7pP7uJuCjTUaa0rwNRaBaXiPMbCCV52KX0aILwaCq
 D4ZGm3ocDCTL0wIcRUYmp3TsIVyoX0isX6388SfHO8Y3wHhgTPrPBYqMWsm/KSYuX6
 9u8seYphZwyoSn1z5LghRI34dIUzY12awr1f7Yp4gdKm+5nrx1s59tH5Hs5KatvHea
 EO4h3CtqlqwWijy8CRWy5YSupjkaNB1ULt+R4o7zjuA0kMJJ6uJ1j1oTf9JKvTDHE/
 IUwP6lsLmdN2g==
Date: Mon, 09 Jun 2025 17:16:37 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu fails to load external RX 580 since PCI:
 Allow relaxed bridge window tail sizing for optional resources
Message-ID: <onf2nAzOEySlZFoS5IQLCqqJAtiw3K7HmeH7CAghzunYBhYB8NqDT8UAfHHkpG_gWUbQp4flZFWsNyot9HGMELLXeM1oVu71lLB3GKL1AZY=@r26.me>
In-Reply-To: <21d41e66-d019-31c7-1e73-fed80cf54965@linux.intel.com>
References: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me>
 <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com>
 <w3gGcmhWNmeGetzLnhgkjfx0JTEyIOKN5sDu-uShZ_7JWthMgGP6plgDuhDbkYyaA7vtGbdl1WbMTZ5zM80OyJoqUa69krqDpuhqDangkLY=@r26.me>
 <21d41e66-d019-31c7-1e73-fed80cf54965@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: cff81bdc5bf1b863859f55e89e5955fe24437d45
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Jun 2025 16:05:52 +0000
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

On Monday, June 9th, 2025 at PM 1:07, Ilpo J=C3=A4rvinen <ilpo.jarvinen@lin=
ux.intel.com> wrote:

>
>
> Great, thanks for testing.
>
> If you want, you can give your Tested-by tag so I can include it into the
> official submission of the fix.
>
> --
> i.

That sounds good, thanks!
