Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F40DD19519
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1CA10E489;
	Mon, 26 Jan 2026 20:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCnD0VcD";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F49510E48A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:25:21 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b7030e2e5fso292117eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 12:25:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769459120; cv=none;
 d=google.com; s=arc-20240605;
 b=f+IbPn/KoSIsjl3cSrXaxh/Lf5OtjXUWeeKrPbYEtXhKwBsLeRraCkAxXhfdDjADec
 UGUOePHSfAA2XlNRXDiKsEOkXrGesH5uHJhNnKJAs5fBwMcYvBfKg4DhCDCVCtPDCTZp
 e2MOES4IleUvwoLZn2YGH2VB+xx2P3EkcLRfxjkX4KMmcWARoMtfFbFZMvdR5BvINa3y
 WFg/5Mls+0elR1mHRyelmMbH7nJA4DxwmE7sGhgG90gASHyvrlJobm74eCaGwOrAGZvo
 +Umq3StzXcOopM5vzSuhuj1Dihkze5RKxLVwouos9qaCYY41uK8kA0XuxrW0/d88T9wU
 PhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TlhXy2+ecr5O5aP2rJabZmdOTWx0wQqUqCyojKq3NqM=;
 fh=1vL1VgJEn231Onyu77UKw3GsDkaLiJx0ZcSpwzuAruA=;
 b=Vc31t7Ml5Jz+w51fUgBNsH+pimTW84mjDyQTTk4UVC+Uj7NJi9JjBNvY2evUfEy5w3
 2spj5KuAWihdCmQbqJg1Wlu9I1/D9gDTDaX42NOl3IfvbYQ7mFUq8HFzV5KhnRKlSps9
 SmeeLR2/fxm3LKwpvCGJ5jXJ+8sdjMGMzzFwzyzH520t26LAMoRt1qur8yUH1jCOy4H8
 gUEZ6n9p2TJ7qVputOiSrJeCiXT5+u3JsHCVSkVcKoEYVTtusR2JmMmlvL8mzSXVfY+/
 2irbe3AkRpZ9zuJU6e8l0eUKC/2xLc1SVPcXo9l4PHvZFGSdzc3iFXMY2+Kn94/zI2Mv
 +rRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769459120; x=1770063920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlhXy2+ecr5O5aP2rJabZmdOTWx0wQqUqCyojKq3NqM=;
 b=TCnD0VcD321Rn93ciBk/QTZNVkYsMFBNp1N62BCSpVQZYY4L5PXEISIhCK0qFLIXfU
 UTe/C+mJOr3g/dr+aJbL1o8adppNSX+J0mJgSh5wlWFwha6M5e380yYGbFqSPwBgUwia
 VRyVzyL3gAQp13NUcGEwoHcrV02SGBOZSh94mPiGio9QQFIwVmG0sGvwviu0eHgelOvx
 qYb0HFv85NclTu+FsaVKPghTLj4C+4GECfaNmdVgL/DRSWRDKeSbL3HEdV68H9A4jZwr
 /p2q8zlzUDK9ZMziggA2MdhHja4EOhsFsBfsRDiBx0Ert+aFqb/XiBHt7Yp63wuFK3GS
 fsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769459120; x=1770063920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlhXy2+ecr5O5aP2rJabZmdOTWx0wQqUqCyojKq3NqM=;
 b=pEC/S5I5bE0olzy65gnKS1FJAKZAXzHpgP9PWyk7j1JtYOnIFLqmzvOlgWBz133mwU
 TMxw9brySs4vQBpeddNFl+AjsK+Atujpl/Ay21drvEkGNIUcCMPA31p59Yk699RMDFuL
 z8RHv++mBGtMvL+Ujv6yb98Qe+8MYjDj8NeEDl9XnRyrKFm0qtgT1DW2779ifIfmbURz
 5qBU9Or39xWRY8aDM3G1kXOza+z45CGtFsNhBHU9DG4EUv9dFK9aI0eZvibNeQgLPtc+
 TnmfWIGdA/7NrC2gZvVvgDTKZwZlxvozBtdkjtaBLN4LO1ZykFPJiQJ11qtWwzjAN2NH
 y7aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq0Dex+RcRg7DRM7XjvKu27pJybQIfT2hD0XqBbaHhJJq9ZDtSDMBXd81yVlZScpmAkH7jX8Rv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+kN04AUsyxh/0Ru8PnJnSw3VvaDsWfjD2QN+6SUPIob3xep6o
 ylQGl0/80xTZNms2z6Ba9V+0O5+uccJzhrJ4pz1w9Gd/tTfMnuP9C9ayK95LOo9jsLO/HT3NDVz
 mQ0iSAlZeCLlsnWY02ohQY3OoNfOOnTA=
X-Gm-Gg: AZuq6aJgEvUfnwNPWIojUIVnKTu9yB0ImHPhgjahPTS1s08P+AYUUSkohOY/S+dZuGk
 qiplGc0vMTZlJuuCDe6f36mPHgqSMY3PFouI9bHI+ODKzOh4lidUsMKLS5qR4vOI4ARy7uS4Q4m
 BgVZ+MtrYdvNdUMj+JGIWjmKo/6mdFsdN81PxIxZvqcF857ELTsMX/LM3oDNATbgdd/506BAk0M
 kYe6kCiwOOwtP4T0KenSsBYx/2VibekFXoksqixVS3GwV7TIpyesIrjjF8gJvEunJAm/hx8
X-Received: by 2002:a05:7300:caa:b0:2b7:2bf3:ce06 with SMTP id
 5a478bee46e88-2b764327d2emr1666763eec.3.1769459120382; Mon, 26 Jan 2026
 12:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20260106125929.25214-6-sunlightlinux@gmail.com>
 <77fa0344-3507-420e-9d77-d454ace55cfd@amd.com>
 <20260126194057.7376-2-sunlightlinux@gmail.com>
In-Reply-To: <20260126194057.7376-2-sunlightlinux@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jan 2026 15:25:09 -0500
X-Gm-Features: AZwV_QgKB7LKTlO7ADNsXDqB9ZYaUCGl-v-GxrYrwM3h0CLKwV5nMT9xESwTTtM
Message-ID: <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 ionut_n2001@yahoo.com, linux-kernel@vger.kernel.org, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jan 26, 2026 at 2:52=E2=80=AFPM Ionut Nechita (Sunlight Linux)
<sunlightlinux@gmail.com> wrote:
>
> From: Ionut Nechita <sunlightlinux@gmail.com>
>
> On Thu, Jan 8 2026 at 13:36, Christian K=C3=B6nig wrote:
>
> > Question is why the KIQ is not up and running before we do anything wit=
h it?
>
> Thank you for the feedback. I completely understand that my patch is
> just a workaround and not proper engineering - you're absolutely right
> that the real issue is KIQ being marked as ready before it's actually
> functional.
>
> I don't have experience with GPU drivers and video subsystems, so I'm
> not familiar with the proper initialization sequence for KIQ. I'd prefer
> not to keep a workaround for this issue in my tree.
>
> Is there a proper fix available, or could you point me in the right
> direction? I'm happy to test any patches on my AMD Cezanne (Renoir)
> hardware where I can reliably reproduce the issue after hibernation.

Can you get a stack trace when this happens so we can see the call chain?

>
> Also, regarding hibernation support: you mentioned that hibernation is
> not generally supported with the driver. Should I expect other issues
> beyond this TLB flush problem, or is this the main blocker?

The biggest issue with hibernation is that it's not compatible with
secure boot so most distros don't officially support it.  The other
issue is that when we go into hibernation, we need to evict the
contents of VRAM somewhere and at the point when that happens, swap is
already offline.  So in a lot of cases, we don't have enough memory to
back up the VRAM contents.  There were patches to the Linux PM core,
but I can't recall if they've all landed yet.  There's also the
possibility that the user's swap partition is too small.

Alex
