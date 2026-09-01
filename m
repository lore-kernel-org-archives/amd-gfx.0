Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB701C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 05:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F5410E2E5;
	Tue,  1 Sep 2026 05:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rawbw.com header.i=@rawbw.com header.b="d8lMGM7y";
	dkim-atps=neutral
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
 by gabe.freedesktop.org (Postfix) with ESMTP id B1AF710E2E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 05:33:49 +0000 (UTC)
Received: from [192.168.5.3] ([24.6.215.85]) (authenticated bits=0)
 by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 6815XlFE000564
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 31 Aug 2026 22:33:48 -0700 (PDT) (envelope-from yuri@rawbw.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rawbw.com; s=apr2026;
 t=1788240828; bh=SPkh+s1q9WRUbVH6PgfQp3WyPFvgNjhugoQjGNed6uQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=d8lMGM7y5l/tfHONNCt2kQxJVpVJoXviOsArEkdgL6kL3qq6xuhQuXzsVdrFtKZ/n
 fiN/z1KTB8kx/QPkCPVBH/iRxm3DPFGmi/jHRLnnX0g6jIrfs3uPE62aTroD1PsmOn
 RgKNyhJs6cyT0kubSo3O6EMp7rPlvzrPUmSaBLe8=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be
 [192.168.5.3]
Message-ID: <a7a1bc98-3517-4794-8fa3-4ba736e99f1d@rawbw.com>
Date: Mon, 31 Aug 2026 22:33:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: error messages "[drm] Fence fallback timer expired on ring
 gfx_0.0.0" are printed after which Xorg becomes unusable
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <24915fec-468c-48f6-85cc-da7b008b937f@rawbw.com>
 <CADnq5_MAeEZbqsb9-0_7PsDQNgcoHaaUfiNX7Duz2of4+nBubg@mail.gmail.com>
Content-Language: en-US
From: Yuri <yuri@rawbw.com>
In-Reply-To: <CADnq5_MAeEZbqsb9-0_7PsDQNgcoHaaUfiNX7Duz2of4+nBubg@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/31/26 11:47, Alex Deucher wrote:
> Most likely interrupts are not getting delivered on your system for some reason.


This system had a working graphics with the same hardware but then it 
began to hang like this after a system update.

Do you know what to look for in the changes that were checked into the 
kernel?
Just interrupts?


Thank you,

Yuri


