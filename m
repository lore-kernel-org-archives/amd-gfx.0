Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8892C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F79208E4
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 19:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdYGp+gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F79208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493E76EA56;
	Thu,  7 May 2020 19:48:08 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6BB6EA56
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 19:48:07 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id y3so7865963wrt.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aUkQPbRDA4bwhOXERfaTBls21bXB1iv/eKw/x3hsU7c=;
 b=PdYGp+grizW5KL9EEPkj14ss5Ck/VO6CnP3Gbf2CKrYKdRA8rQ0aWaYIXlmOdxkVR3
 JyGLiMqme5z6S4VT/TwuBW7bE1Uv+hmGGo7pOUrBTEXVuYW2B0xWuGpp06tIJD8ptng7
 qixXmq/TmC20fPpMEjtUIfLONzqBe/Eowv1C9E57aopl+0hJDpBRaQXD7XyTZSautmnj
 thhplMfC0PaHBllGXDoFSB16mkFFnsg9wn2nJed8XYMHB6ilghXWvPRXbPyMWJYaV+bK
 Lp/ZGccYongEEbeiNNbmq7aI+DuYJkQ/2kByM3dLnPiemH7PRStavsTH2J/TWxQbholy
 lojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aUkQPbRDA4bwhOXERfaTBls21bXB1iv/eKw/x3hsU7c=;
 b=lhI1f43KXJP1xW6S62CqWIGZr1SKOvWku4IVEn22CKHu0Df6YdVXfKdiIbgb5feO3M
 Mpc3vPfShfluMYo7zWqmxdwrs0X3xU4p1tPtHcbsj9LITL+4Tl8Z4Xs5MThA7mT9psyb
 oKNBvhqCkvC991qleZ7kN8WGDD7Ven2Ok5ovupoi0jfc/ChzG2pzRilsI0d5O/ocuQYw
 rNDuEkO7T1Jq7mQG2zM7zz3GL2XkAdQGVoc25fEBNqjL4engFLy0DiPsikL+myAQND+i
 8+VnSY05FmyywfuQQpQil7w9wL5gVqO+vDKXlpEMMYiqtx2AJdoJ8AvBW9aJmv9R/PCn
 8N2A==
X-Gm-Message-State: AGi0PuZAgXAn2hey6fdVQUap5WxmkKmJwxh7f36QjR6PXxDhPhOECqOr
 zQ9nYMGNfWoUBMJTXER7HSDUsMkl5t48qNSQUZY=
X-Google-Smtp-Source: APiQypIbaZDpOuzvVPlZK6Rye7K5M+VxAzW3H/leKxXIsGlmuR2TXxRmX/mASUZIvYpIjnlsZBVETA8kd73MCF+oi54=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr18185588wrq.374.1588880886193; 
 Thu, 07 May 2020 12:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200507191935.GD1799@routi.mrns.nl>
In-Reply-To: <20200507191935.GD1799@routi.mrns.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 15:47:55 -0400
Message-ID: <CADnq5_PXvbCPCM=e30buKQ=8baPp7-bNijP9E68qygzAUC-vgA@mail.gmail.com>
Subject: Re: builtin display using amdgpu gives a black screen on macbook pro
 13, 3
To: D Marinus <dmarinus@mrns.nl>
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

On Thu, May 7, 2020 at 3:36 PM D Marinus <dmarinus@mrns.nl> wrote:
>
> Hi!
>
> Since I've updated the linux kernel to 5.6 my builtin display of my
> Apple Macbook Pro 13,3 is blank. The following bug reports have been
> opened:
>
> https://github.com/Dunedan/mbp-2016-linux/issues/142
> https://bugzilla.kernel.org/show_bug.cgi?id=207589
> https://bugzilla.redhat.com/show_bug.cgi?id=1829174
>
>
> xrandr gives the following message
> xrandr: Output eDP is not disconnected but has no modes
>
> the /sys/kernel/debug/vgaswitcheroo/switch entry is missing
>
> lspci gives:
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Baffin [Radeon RX 460/560D / Pro
> 450/455/460/555/555X/560/560X] (rev ef)
>
> Any thoughts on the cause or fix? What would be helpful information?

Macs handle hybrid graphics differently than other systems.  Maybe
some change related to the mac mux driver?  A bisection would be
helpful.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
