Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DFC388F9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27D622267
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIOV8EvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27D622267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82FE6F5EB;
	Thu, 22 Oct 2020 16:41:33 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9746E1D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 16:09:52 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F28324182;
 Thu, 22 Oct 2020 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603382991;
 bh=TmqdKEDpzokkSYBf6Olofb6ooIl6uJH+k5K1oSNqZM4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HIOV8EvPe2pW2/o3i3ejjqBhurg00S5aYWhvZGtMiF5NFfGSZRLpxAO1UZ5uVRYpw
 rD+qYb9o3RX1ZBOcNiT7cY8FPobLmy6gWSR931g9f239/iKOmrIs8gzEXlC0tyWsL/
 p3wEZNxxZ9phcMbxHMOeX/QWrIYM5IR8sZHs4cgQ=
Date: Thu, 22 Oct 2020 18:10:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 03/11] drm/amd/display: Honor the offset for plane 0.
Message-ID: <20201022161029.GA1979067@kroah.com>
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-4-bas@basnieuwenhuizen.nl>
 <CADnq5_OuXhN-2Raie9V452KrG4ChaguY1q6+Gk19mR86A=Fkog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_OuXhN-2Raie9V452KrG4ChaguY1q6+Gk19mR86A=Fkog@mail.gmail.com>
X-Mailman-Approved-At: Thu, 22 Oct 2020 16:41:32 +0000
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
Cc: Marek Olsak <maraeo@gmail.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "for 3.8" <stable@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Wentland,
 Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 22, 2020 at 11:36:12AM -0400, Alex Deucher wrote:
> On Wed, Oct 21, 2020 at 7:31 PM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
> >
> > With modifiers I'd like to support non-dedicated buffers for
> > images.
> >
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: stable@vger.kernel.org # 5.1.0
> 
> I think you need # 5.1.x- for it to be applied to all stable kernels
> since 5.1 otherwise it will just apply to 5.1.x

Not true, I will try from the number up to the latest version.  So all
should be fine here.

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
