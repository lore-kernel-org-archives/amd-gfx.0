Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB5C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1112920733
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="flYiW5mQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1112920733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971FE89FD3;
	Mon, 30 Mar 2020 13:13:56 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E867C89FD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 13:13:55 +0000 (UTC)
Date: Mon, 30 Mar 2020 13:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1585574034;
 bh=3LDaLad3m246iByxXUIGPUcBsoNKIwzI+AUp02R8v3c=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=flYiW5mQLBrW+TiKcvC7EtRs8U/EBJ4Zq1ABl26mwovkCYEUjaoast7hI0e92dqmF
 m2AOT3Cuhzct4GsWO36uYTqeMeH4os91zIRd41MHWhMP3FpV7bUHaTCT1IsXI6lJ55
 fWdMSxZOxm4uIfgBkTyJ8DhUFl2y5CQ0OyqPSa4U=
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: add basic atomic check for cursor plane
Message-ID: <B9sWqLzmtdeSGNQnGEhg8RkGpHRGD0eRxKboCjMgkhR5ZVtLdlEIzoKBWfFnnX0p4Dvl8Chdd68eKpXTtccnAA4a2xeHq2cnHHqg0sv6zGc=@emersion.fr>
In-Reply-To: <8d67af72-a3c0-65a7-2115-5f068ccbfc23@amd.com>
References: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
 <83db678a-a5d2-cf64-65f0-8fece62b2fbd@amd.com>
 <7EkixViMkOWZ8AEOpjSPCtfus4Fq2LWBmsk71_0nAC00BVKDIg7iao_0I2PIQp9Z3_jrQ5cglhuYKkq5CQnuLRunzg4pirlkY6hH3At1gww=@emersion.fr>
 <8d67af72-a3c0-65a7-2115-5f068ccbfc23@amd.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Roman Gilg <subdiff@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Monday, March 30, 2020 3:11 PM, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:

> On 2020-03-30 9:02 a.m., Simon Ser wrote:
>
> > On Monday, March 30, 2020 2:59 PM, Kazlauskas, Nicholas nicholas.kazlauskas@amd.com wrote:
> >
> > > We've been doing these checks for position before but I don't think we
> > > really need them. DC should be disabling the cursor when we ask for a
> > > position completely off the screen.
> > > I think that's better than rejecting the commit entirely at least.
> >
> > I agree DC should be disabling the cursor in this case, however that's
> > not yet implemented right? I think implementing this feature is
> > orthogonal and should be done in a separate patch.
> > This patch simply copies over the cursor checks in the atomic check
> > function.
>
> It's implemented on DCN but I don't remember if we're doing it on DCE.
>
> I guess the drop can be in a separate patch.
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Thanks for the review. I'll try to figure out whether we can drop this
check (from both the atomic check and the other existing check).
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
