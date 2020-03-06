Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5DCC10F25
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 15:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3386B20409
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 15:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv0LZ7JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3386B20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90216ED37;
	Fri,  6 Mar 2020 15:04:23 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD736ED35;
 Fri,  6 Mar 2020 15:04:21 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id y17so2744642wrn.6;
 Fri, 06 Mar 2020 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uQo+onlAVtJ3GHr3tLcvsDuaRm22ad3z+Ip5pQRZGMM=;
 b=Uv0LZ7JLdXobW0yW7yAiXIDLVuFtlgv76uN2T9nQxPSlXOU61ShhrrAnDt7AnjPZxT
 /YsXLo2Yz+oaERo1Kob4RlagjqMDlVjKEOqf2ciWP+owaGBaB+mPB8e5z6INiNq13XNc
 Ranm5uaBEYZZKM1LPUF518iZN0efHfTyJdoWvtpb2blSk0nt3D21LCmVl2oVzV2UDAYt
 Jlfm1FeqZMtrLTfDo4Bk21qo9syZq3buJ9YGbo/bLKdipqOq6LySb4tLR1WYjFaT0LRs
 YAzF+wt7teVS8qTyZaPYpvrlyaItZHEHwVnD4YaTsfMMrrEo3v5BaaWGUGncBY2tOfjW
 7F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uQo+onlAVtJ3GHr3tLcvsDuaRm22ad3z+Ip5pQRZGMM=;
 b=I3SIVx7vVz74yOCVZwpj7pvnhveUOhS64l2snVF1zRraLaHxKLUjrouUd3Rq7oEnCi
 Nr3Yvmau9VLLl4PeVXgM6L3dY2f2gjgpe/rwhVyVeHaNRWFiJvjoWwi/Ew5DSR2IwdTf
 r9VzcdsHxKOc8/8ggv/LKn6pAHaokousbzF5+LuN/y1mUSXrAB3kAP4gQAMDr7lHdIaS
 hdJHC5rjW68N8w3GNd9MXsa3sAOrpchK+KdCl8YVYRyuvOfNVcXc6KjFkTCh/GsKRzje
 wet4xI7U4mqhIHXBNXAhWgO6Ia3U9bSq7zcgS4BrNugNcnqg7bN4tZNh/zOv3oNApwZS
 3cdg==
X-Gm-Message-State: ANhLgQ2jFzwUY0b8PtqJcZOxjDuPG8bsY/8ObIbhb9/ZThS6m6xacQPI
 HZanVKZOkJvFVTeBXzDa6YeZzVzCfCRR54VsrmqDnQ==
X-Google-Smtp-Source: ADFU+vsr6D0PkKil40QwwtdvSXbB4f9PzRdvcySOtkCAQzQa7MCPgZGbPx+lQraPpMGVtaLQjg8T+eGfWmAbNfp/wfM=
X-Received: by 2002:a5d:534e:: with SMTP id t14mr4575113wrv.374.1583507060321; 
 Fri, 06 Mar 2020 07:04:20 -0800 (PST)
MIME-Version: 1.0
References: <8N050z-kDUI3K6yjVnSIW52u4n8Q8SdAiAlWcmlMHx83oMerf70JNWvSl20GN_5ETbg92aBksrR1bGO2f3ADv3DnI5eEWIYMGFqD8F8v7Uw=@protonmail.com>
In-Reply-To: <8N050z-kDUI3K6yjVnSIW52u4n8Q8SdAiAlWcmlMHx83oMerf70JNWvSl20GN_5ETbg92aBksrR1bGO2f3ADv3DnI5eEWIYMGFqD8F8v7Uw=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Mar 2020 10:04:08 -0500
Message-ID: <CADnq5_PPJ7iBMyQN0OVnDh3Kf9H6==tesD6dDFVEzV7w6X6c9g@mail.gmail.com>
Subject: Re: [PATCH] Corrected the core clock speed for AMD HAINAN
To: Yassine Oudjana <y.oudjana@protonmail.com>
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
Cc: "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
 "airlied@linux.ie" <airlied@linux.ie>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please send a proper patch using git format-patch.  Have you actually
tested this patch?  Can you provide the details of your specific
board?  The reason the clock as forced lower was due to stability
issues with the higher clocks on most HAINAN boards.  If it's working
for you, I'd suggest just removing your specific board from that
override check.

Alex

On Fri, Mar 6, 2020 at 3:03 AM Yassine Oudjana <y.oudjana@protonmail.com> wrote:
>
> Empty Message
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
