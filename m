Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C75C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 12:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19836105A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 12:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19836105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6686E94D;
	Mon, 17 May 2021 12:50:53 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686F96E8F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:45:08 +0000 (UTC)
Received: from zn.tnic (p200300ec2f061b00f416f01ed532e4bf.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f06:1b00:f416:f01e:d532:e4bf])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8D211EC0345;
 Mon, 17 May 2021 10:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1621241105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=XT1VDWp+32xfBKa+NxSvVUNJdTSwHiQt0pKtZlWF3Fo=;
 b=d86DH9BA1D5hKYz4TGaXAEu9X9otE1AwGMoowBVFIjgaMq00StL+jcMx4/qnidJVV9KNhT
 R0EiPEh1KkqP1ywZ2e3+g4Y4EEh3z730jfT54rJHWvIaWWRrBVuzD6JNUVSbhoej9Sz+tQ
 PdQc2GDY5dxZIN9sqwkO5b6g0N7ypgs=
Date: Mon, 17 May 2021 10:44:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [5.13-rc1][bug] often hangs for no reason
Message-ID: <YKItC18evdS7efii@zn.tnic>
References: <CABXGCsMA4grweMDnN7_4jepk0w8hBbynMFfHUJv-PrM9STyZUw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABXGCsMA4grweMDnN7_4jepk0w8hBbynMFfHUJv-PrM9STyZUw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 17 May 2021 12:50:53 +0000
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 17, 2021 at 03:27:23AM +0500, Mikhail Gavrilov wrote:
> Hi folks.
> 5.13-rc1 after 5.13-rc0 is a disaster because it hangs and hangs again
> after reboot.
> All hang's have in common is that they all happens in
> smp_call_function_many_cond function (I compared all trace [1], [2],
> [3], [4], [5])
> I do not know if this is a known problem or not, so I'm reporting here.

Looks like some splat, lockdep probably, in amdgpu when it gets loaded.
Maybe locking's botched although the beginning of the splats is missing
for whatever reason...

Adding them to Cc in case they have a better idea.

> Full logs here:
> [1] https://pastebin.com/u7SkKGDT
> [2] https://pastebin.com/fNae4dSL
> [3] https://pastebin.com/jEDMjQDy
> [4] https://pastebin.com/vEMhWGgE
> [5] https://pastebin.com/fvWx5ctR
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
