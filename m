Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96187C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 13:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5045320767
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx+gpPb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5045320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B0789FC0;
	Wed, 18 Mar 2020 13:53:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA9489FC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 13:53:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id n8so3468707wmc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0AG6m3caMRPzGqrUHzrB5kmBuk3lrA8RDG4SSgGyN3c=;
 b=Tx+gpPb0+Qs+/hQ7rmaTPpi0c5WEJPJzXqYIsAiIVUcSQylroROu+EcK+nnRBrB2rU
 FGwiE/onxRuknxjO6VYLwmU/qHt5qbqkLbRu6hVvPro5+pq9w/UBncDc0BIg6P6Dn1wI
 7xENGiGvLY2TmdrR5TGSJFM2dAzLx0I5jTsW1iQLFztmSm+T41nLm1Ola5DLrOM7uhMT
 Kl35Q2SwEtp/f82vNz5Gy8bpOnNntsggtXv1Fb+XATYEAvMnYcN8ULWhbif3oamBfqdv
 bX0N16NNj5ZVE/UvjnpBd8e54Pdfc/0Y0+A+wG3HhLqsZ6kle/FrSYgLjZp5YXUCykvM
 7CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0AG6m3caMRPzGqrUHzrB5kmBuk3lrA8RDG4SSgGyN3c=;
 b=KRMrvVVn+0BOPlfOZh8ieZVzI/Wyg8vT0f/rgxDHGxHddyLzD/tw10WNYW91DFYMyD
 RB5KWkCXmOY3/xEgtr7CUWUPcVHNUGHQTkHMW8jNqAAGfKiTDm8MFeSpcbg3KiJPcAF8
 DooYTvuhBaf/sT29Eh/AlkLiA+skd5NSRQP0NLZXX0bkA3B6cdDm5CngWVGrQTUI62A/
 k3mYcMGFptzS+QNSuvqLq7NCX5N3YqbEjirsOQux4QbraqxlKen+/169nZv6/QpeyviM
 4CkS3dXOspvNM9BSvyOx50mu/U5mHSgdFA8d+ctavM73B2jPmwCUekC2PPq0dXxlad4g
 oTOw==
X-Gm-Message-State: ANhLgQ2/0GNIQp78Bom4yPMnMQjZkG2sikH74guhVTwakjucWoDvGY/Y
 79KccqpI1ZXZkJtz6/eyqz3yWJSM+zB3lA5Un8M=
X-Google-Smtp-Source: ADFU+vuWNLioVUaFkmQRFpMN5Q0Jb+pDUmASM75UElVxkOSrjUJGWZ50BEodqWCgdkcpRWk0tcmJGHXS8omx9yTXa2w=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5380310wmb.73.1584539598139;
 Wed, 18 Mar 2020 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAETxV2a+OdyQ_tB0jFHA6n1Ci7kPH6ATBSuHNo4Uq_AuZEFEqg@mail.gmail.com>
In-Reply-To: <CAETxV2a+OdyQ_tB0jFHA6n1Ci7kPH6ATBSuHNo4Uq_AuZEFEqg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Mar 2020 09:53:05 -0400
Message-ID: <CADnq5_PryLuSMHW_NuJHq7RKDxNR5-8+qEdK7WfxAg-1YNSE5w@mail.gmail.com>
Subject: Re: amdgpu kernel oops?
To: Tristan Vroom <tristan.a.vroom@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2020 at 6:24 PM Tristan Vroom <tristan.a.vroom@gmail.com> wrote:
>
> I don't have a lot of experience reading kernel logs, so I apologize if I misread something, but it seems like I'm having some trouble with amdgpu in kernel 5.5.9.
>
> Here's the gist of the bug.

Does this patch fix the issue?
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next&id=6c62ce8073daf27ae3fd03b6929d6cea3887eeb2

Alex

>
> Thank you for your help.
>
> Tristan
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
