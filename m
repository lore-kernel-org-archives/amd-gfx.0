Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09261C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 09:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D610A20671
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 09:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="zSA3ckhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D610A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905AC6E2F0;
	Thu, 14 May 2020 09:42:22 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA746E2EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 09:42:21 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id l17so3035652wrr.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fZiEC2K23zLMT8KRL68tkPRKohIVJ9CsA9MsK8lB52g=;
 b=zSA3ckhFAgCkmUWtR8IF6mxcg60OeB44Ll1Lfl7HPoMWw0SUrWBxgSpx4Aa/TYl+VC
 YTR20HmdXw/o3OLip2YP1HC+nrEmPsyVpcmzVf9Rflp+dHh6LuTSUM1PEKWLvDAg1p2A
 M0ajz1+vO4tN04PqOTphFUxbpxDLULAoYF9aDAiKsKBxageAX2w1IACsojl0AXHAIe6U
 w5zttAzUqgAnWvHCNe1ZP8qnGrhZhtKHlkNXVOscC0xUhSRZUNKEoV6TxGHQM8BxOwgZ
 T1QM564xos56MUtsQqbp5LnoRgdwURADaD4NxQ4UM5YiNRFQ3fgdu4huZoVziiF9uklq
 LdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fZiEC2K23zLMT8KRL68tkPRKohIVJ9CsA9MsK8lB52g=;
 b=CrrPtCPVUQbHWSe3EA69DfN5ClDqsUDGHr/L54ehuH/m9U/Oauefr/wUuFCGl35o1N
 aJTRrvxSOKUxbvD/wRCzo4PJuudbktzT3wHwHNlt+7Loj002atbtsJ5TIMTm0/Q9nGBH
 c0cboARn1/Vs0eDNIXaA9iwpV9EtRVpa+rkbp26hpDB2ckIqK66No2Zn1SreOWnZHAF2
 A7msfLDokN3pBVyBZYbZtriSVMvgfX1jVTLxS39Zhty1iMD8xSTomJqgF8YVUYJAgcLA
 mtmBT+1fTUC5c3nxBgrV2SO2miHDQUVRxnUICf2RJvVKkrWy5q1mOEa9w7BIhlDIcCLl
 EREw==
X-Gm-Message-State: AOAM5318B5T4YXt8yUywBOHM2liLzRzEeBrJZsRjE9INYTfcWaWpbR0h
 tLYrYopAtRqB+WQr9Xzm2Td3E+dEt7JW4vBrRoMl0Q==
X-Google-Smtp-Source: ABdhPJyQU4+w/M7rlpEiA7nQy/vxeqxavGw8m8A1PsvMhf0bO07lAqD1CJUFd5k5voUwLVhi67zXnfMz7vyVSA2y6HI=
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr4399816wrw.256.1589449339465; 
 Thu, 14 May 2020 02:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200430212951.3902-1-alexander.deucher@amd.com>
In-Reply-To: <20200430212951.3902-1-alexander.deucher@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 14 May 2020 10:40:41 +0100
Message-ID: <CAPj87rM6nvr-pspfz9PaPiV9kkSM+=rh_YMaPXqaBZv37Yc-Yw@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-next-5.8
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Thu, 30 Apr 2020 at 22:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> UAPI:
> - Add amdgpu UAPI for encrypted GPU memory
>   Used by: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/4401

Did this ever go through uAPI review? It's been pushed to the kernel
before Mesa review was complete. Even then, Mesa only uses it when
behind a magic environment variable, rather than through the EGL
extensions which have been specifically designed for protected content
(EGL_EXT_protected_content, protected_surface, etc). The winsys
usecase was based on a Wayland system which seems like it will only
work when composition bypass is available - not using any of the
Wayland protected-content extensions, and it's completely unclear what
will happen if composition bypass can't actually be achieved.

I don't think this should be landing before all those open questions
have been answered. We're trying to come up with a good and coherent
story for handling protected content, and I'd rather not see AMD
landing its own uAPI which might completely contradict that.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
