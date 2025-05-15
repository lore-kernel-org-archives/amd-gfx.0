Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14333C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 17:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18F010E922;
	Thu, 15 May 2025 17:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="So6gBTpt";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3315E10E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 17:19:42 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-47663aeff1bso13390191cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1747329581; x=1747934381;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=djeSGvZbJa6ox6QXkwy1f8WKqFhODYQZxexAQ4hRWJ8=;
 b=So6gBTptJ6ene1cuRDdQa5lKJpqo1h7/0REhRu0vaw588dEPYGWP6LfeOH6BSOV8n3
 3IzmNN72khdETW/nYcAlcKw9ALQfTO/taAJXeyNVTF6Nrsrf+mjDxJbp8uD7qr3AYV2Q
 dm8yP38P4LnRllZx3SQY790PucDfQ4HMIQYFzoipUiZ7dFRaf4JaFiDE3tRsaWZAsml1
 01muPyixSWlJHFsyteHzYn8pRCy0BnqeShEcMDWNXQ+nVIbSYfYAVin5v7ubJo0YAUH0
 tqA9lBctxbpZVsTGLLBEcXos6ZhMkw+Ky5QofUoelSg5uL3K+gxIfZ5jTAe0ISovULUr
 FWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747329581; x=1747934381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djeSGvZbJa6ox6QXkwy1f8WKqFhODYQZxexAQ4hRWJ8=;
 b=NJcRrqcxQmxOdvGAIF0hHrxlC7ZnFM3cUAg5HRPHB0lWc68a8w2p7QuARZ1nrTiDko
 owjOuckLBNDzt+nOLBQ4dUxvL0Ww0wTk4o7S9ogvY12hsY+APm7MB2QCKvHn+xiM+vZo
 fbZl9sCJIe02zYnbwY/R+HmsWZ3JcMslcorHjpDQ+PTma3xYGzjcEDTNU+wybhae19ZS
 0MuVpVpbjv1YHcnYwbZsrsqMdol/rVHXa5kbfHuc7miLaFnamXWuLAmlSYnu8kawX9uZ
 OE2Arm26Gw7HkRw0qTywk1eSJ3m+QGIZPg9g7hBhr7Hsesm0EXR5cRC3w0AWoRKmDXXo
 jHKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvm3RF2KPHgN+ExMrxTM1JV1+J+rxyPKc66+fCcsjz/eTCCpg15c+GZbT2M56R0VBFq+fTNmqS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy67+CJ4nU3tjTQGDXl90l7XSAx0IIpw7qzCoizVEDoq3VuKvTc
 R775xkX22mqdrYRPKtP6FJqMxD8kavMkujCZ09La3E0DnG07UOoSfp0n7jpEimvn7n4Z7c8e6lZ
 wDXSJSBYEpywi8BX+bTIcH5/7s0MAYgXgVrKgA4j3iw==
X-Gm-Gg: ASbGncv0wg/xiVoMXkJG7ZUOIljWrbkiQb7RlsXsGI3EXSSQLbtowup1rtePwFJxfLR
 NXuv9A2vYqpy2mi9RQ/6K5QkKZZSXU8qOaJGvC6GzIRezHFdbi6xiJ7Vc2O1ZjKvSX0CQOTGciA
 3fy9IXMeu/K638+8A6pqLywpCCFAJpYgU=
X-Google-Smtp-Source: AGHT+IGDFlFXV+bG1rmOB9xbzbAZj/9akbpb1sLaKFgEpL6/OoBCSlIlyULNFs5lTXyKb91w8Ol20BTJhTi5Fc+cUtE=
X-Received: by 2002:a05:622a:a13:b0:494:a208:7e3b with SMTP id
 d75a77b69052e-494ae372dcemr2647701cf.24.1747329581084; Thu, 15 May 2025
 10:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250430011115.223996-1-alex.hung@amd.com>
 <o4MtjqyDUjuFR4Y9Q1IEZlvVQ7Nkggq0v-KtBcH0aM3pTvEq8UcSoUDxefSBVdTmLj_1_a6GmbjU_mRSFinOb44B4bu1u3mMIckuQhhZWCc=@emersion.fr>
 <3bbd4bd7-7217-4a14-b7bb-383226f44f55@amd.com>
In-Reply-To: <3bbd4bd7-7217-4a14-b7bb-383226f44f55@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 15 May 2025 18:19:29 +0100
X-Gm-Features: AX0GCFvbelGcUsJPRRZjTM_xQMwQQ41aCKPXeuguyldeITqpDRCSEvtYx7Aaabg
Message-ID: <CAPj87rNUDdDEopPH+iAF-a=Or6eXH4cMRU8eOj81g_40cq8gdA@mail.gmail.com>
Subject: Re: [PATCH V9 00/43] Color Pipeline API w/ VKMS
To: Harry Wentland <harry.wentland@amd.com>
Cc: Simon Ser <contact@emersion.fr>, Alex Hung <alex.hung@amd.com>,
 Misyl Toad <misyl@froggi.es>, 
 Xaver Hugl <xaver.hugl@gmail.com>, Ribeiro <leandro.ribeiro@collabora.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, leo.liu@amd.com, 
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 victoria@system76.com, daniel@ffwll.ch, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, 
 Arthur Grillo <arthurgrillo@riseup.net>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 15 May 2025 at 15:11, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2025-05-15 05:45, Simon Ser wrote:
> > I've reviewed all of the core DRM patches :)
> >
> > Have there been updates from user-space implementations?
>
> I know Leandro has been working on Weston to make use of
> this and last year Xaver had a prototype in kwin.

Yeah, the Weston patches are marching on. We've still been doing a
little bit of cleanup and prep work in the background to land them,
but we also can't land them until the kernel lands. None of that work
is material to the uAPI though: as said previously, the uAPI looks
completely solid and it's something we can definitely beneficially use
in Weston. (Even if we do need the obvious follow-ons for
post-blending as well ...)

Cheers,
Daniel
