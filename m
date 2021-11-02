Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 22:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4420D60E98
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 22:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4420D60E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ntlworld.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69A2738CF;
	Tue,  2 Nov 2021 22:07:59 +0000 (UTC)
X-Greylist: delayed 1612 seconds by postgrey-1.36 at gabe;
 Tue, 02 Nov 2021 22:07:58 UTC
Received: from smtpq3.tb.ukmail.iss.as9143.net
 (smtpq3.tb.ukmail.iss.as9143.net [212.54.57.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72621738CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 22:07:58 +0000 (UTC)
Received: from [212.54.57.96] (helo=smtpq1.tb.ukmail.iss.as9143.net)
 by smtpq3.tb.ukmail.iss.as9143.net with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <zarniwhoop@ntlworld.com>) id 1mi1Wl-0000x6-2N
 for amd-gfx@lists.freedesktop.org; Tue, 02 Nov 2021 22:41:07 +0100
Received: from [212.54.57.112] (helo=csmtp8.tb.ukmail.iss.as9143.net)
 by smtpq1.tb.ukmail.iss.as9143.net with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <zarniwhoop@ntlworld.com>) id 1mi1Wi-0004Ep-MA
 for amd-gfx@lists.freedesktop.org; Tue, 02 Nov 2021 22:41:04 +0100
Received: from llamedos.mydomain ([81.97.236.130]) by cmsmtp with ESMTPA
 id i1Wim5VOOgJWQi1WimpOZl; Tue, 02 Nov 2021 22:41:04 +0100
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=FuEWQknq c=1 sm=1 tr=0 ts=6181b070 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=ianibVJeSIMaSoCXmGgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
 s=meg.feb2017; t=1635889264;
 bh=iN/Wv7Zpmtoufd2+BysEJfmezMvr+Y+z2bU0wQqxqyc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=wtcj8jkbWFacqZAOIxYAeR2dORAqke95+I1L1Cwwei7a3a+z+B//Ya8UDGRcB3a2C
 O5JzFXRuOx4PNg+G8gGFf/khAaXEp4Hqcya7mjoUp3Au2bdjc4DvDidzQSmPfT78LF
 omlG24B29iBtUHrouS/6Gb0g4dfojcNRFc9Z0kAsG9oFm+x5AR/dAXHV6dnpvE5iPE
 DjjnecFJuIG3AGOycF5ayOaJh5K3YfhIoP73xxAbUgrcNEiRC1UMnL7mB4XumPhZgW
 4LLrnF0SfFAoGGQEYxL78hM1MZmU7FnaRt7kYkpkqhuhD2zMu5czl7kMA2DG3qRBe4
 otXJhX3Lq2pxQ==
Received: by llamedos.mydomain (Postfix, from userid 1000)
 id E619C60C5A; Tue,  2 Nov 2021 21:41:03 +0000 (GMT)
Date: Tue, 2 Nov 2021 21:41:03 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: "Zhu, James" <James.Zhu@amd.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso."
Message-ID: <YYGwb0ukF4h57KW+@llamedos.localdomain>
References: <20211102192324.3402-1-James.Zhu@amd.com>
 <CADnq5_OnTAKba1CzcmrzxZZMwzJqn5WyuLqC7kst7qCoD5cYBQ@mail.gmail.com>
 <DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9@DM5PR12MB1884.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB188414B7F26CEE85C1BF7A0FE48B9@DM5PR12MB1884.namprd12.prod.outlook.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfPXFA+AHb2h5+5JcJfVqRidheLj76PKxEEG7Yd22CsXPUosLhwo2u+Sbog+tHirpehMb4EC0RKxrUwOjpPLdQDW4welP4Xr9tgmof5P/D+jssWYm1F2U
 GBSaCiJ0qzUJROj8o/1AEoQ7zrK7mnfj+pDEsbRKHFELWIg5I8unkSxYcthRSocGcztJ7fNG84RUEVmUKhvGKTkZyKSQSwbONaVVi8qT+REkViUhWWyK/3Rx
 0EAlBPrNfDm85c1CoTgMQzvdZBcStuAOrSeCizCK57VPVD7V0PrBJJVChE1Zy3aj9eOPMXws1PUfiItPOFGzOXuGGguG+uk5d3lyZ0USNZw=
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 02, 2021 at 09:00:04PM +0000, Zhu, James wrote:
> [AMD Official Use Only]
> 
> 
> Hi Alex
> 
> Sure, Let me check it can be merged into one patch.
> 
> 
> Thanks & Best Regards!
> 
> 
> James Zhu
> 

Hi James,

I'm trying to apply these to 5.15.0 (using the dry-run option of
traditional patch, kernel source is from the tarball).

the first one fails:

Reversed (or previously applied) patch detected!  Assume -R? [n]

it will revert:
Hunk #1 succeeded at 924 with fuzz 2 (offset -107 lines).

In anything connected to the kernel, fuzz on a patch worries me.
Should I apply this with patch -p1 -R ?

For the second patch:

checking file drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
Hunk #1 succeeded at 2432 (offset 34 lines).
checking file drivers/gpu/drm/amd/amdkfd/kfd_device.c
Hunk #1 succeeded at 924 with fuzz 2 (offset -107 lines).

Again, note the fuzz in kfd_device.c.

Using 'git apply --check' instead of 'patch' both patches report the
same failure for kfd_device.c:

error: patch failed: drivers/gpu/drm/amd/amdkfd/kfd_device.c:1031
error: drivers/gpu/drm/amd/amdkfd/kfd_device.c: patch does not apply

ĸen
-- 
Vetinari smiled. "Can you keep a secret, Mister Lipwig?"
"Oh, yes, sir. I've kept lots."
"Capital. And the point is, so can I. You do not need to know.”
