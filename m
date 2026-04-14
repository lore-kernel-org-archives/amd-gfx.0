Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EB2F9D0D1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86ED10E4AF;
	Tue, 14 Apr 2026 13:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjsh8qHT";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D18510E59E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:45:56 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b8095668ebso276376eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 06:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174355; cv=none;
 d=google.com; s=arc-20240605;
 b=PFkDJ0ZoxhDyHy5klVFskeVKVQJK02tcl6Pq31fzyy/kZpIaR6jX0yFU+scBeSlQEK
 ylEYnUCjGlyrI7oPsV0CWKlNZMRjjv4VokepBXzYqXZV/nXL/hW0Ry94aITdf7P/qcun
 dF9kvulFwdvz3XieWCD2sJObAwFicDDnmKloJhzNs88V1Odr4Fyq8h9RDXClpTDTystq
 oE8UTOy3VeJRt9+MR0l9BpgxrPcGHoEQZHNUt2Oo49uw44sC1/rS3KWcZ7J0/FtEShJI
 wxGoRMUnL/j++k4ofAfLGyXUcjuBdac2lRHLoPzTwahSWEVsxt2XvDbRxI/TIiAm4PKM
 cS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 fh=jvz0aBjYf/u3no9IdheOPrVMEb4DDZNUD8OShcFqTzU=;
 b=cxKumMsPkjnP1zewhCXrzyWJL5Io1KbydUS2MKMdZcPQW6Gbs9a6uNyifGSiXjzN32
 +oL5DegQslCP7e1rFyWYpepIH+hw6aURwq/qQWFRTSqKH2cDN7YG3TzKseNzU3j222H+
 OVoG4MyVWTb5mJKWhWjpiDAxnv9DKoV8Lsfeu3SO07GWe07cBNKVtU9xSoTfO3yJq9wf
 yONz68LET+mwbvBRXNGdbH+cZFOQEBoeI2lg8V2697Px5xfWPDrSAev9fPMnAxYLP4yt
 hANjzVyKXQmDevKhxl3chx4Olht6yXDCLPgX/aEwfu9+9LixAhzLcSVbT5nz3k57BpRK
 LqzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776174355; x=1776779155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 b=cjsh8qHT+NL1kQ5dXAYfBsabNAstj+k1aIQlJJF/P1sDkpRtFCvJAsfem40hhZRHzX
 iAOhNHPhJutnHwouko2qUtqVLntiiD14cHPbp9ltPfTXjT+1+dqX+AVjjUS8Z+E8mRms
 yraQyKVXiQXTwf756c1poZxoJOXuj/OuyCvnQCZ8Q2Sy2WBVNNqsLsVBOtKEoN0Q7VgM
 hsBTg6Oz7+UW7XGsvokhwoTPoNWV3KVRVGPl6477tLPRojhTOZbdVDdrRivUkUMxRPLd
 oyREoo5L3EFjqLzu7dv9H8zAfs9ispZjn9LbYv2oiwfaGz2i75sUsTkDJdj8iCKEHDtZ
 1NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174355; x=1776779155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYOfHK/ZyzICl1CErMqKGJ2Pz+BBND+WxitKhXSQRzk=;
 b=Wu74S92y35MjpdV+e++S/wvkWyfeHqnfy3BAm2M8mXlymbPSfTzP8XomO660aGXwr7
 IA9TW/3rRDACYOPdsSEziCTbdm5fRmJLaLjsf5sAZDGxnwD6dK/vTMwueiOlJ90n45ti
 Ay9nzNWwWF2Ae86wG/2/9eHfzPmfS1aAMvUJmKKqTHpVQlpZfYzZv8JY6QYzC3DqoKBe
 FBm7Xy9VTwl9S89QS7uINaI/H1pnqgEQ6IXZbysmSQUGQIVE8SE37+CUiLy4uqNbmVqS
 V+As2uUyFm4xtn9xNQFbCtX3dUKLSmOF9JVUq/BWnlG9McZ9eU1TtDWOAi2ZpFIazSL/
 PKsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cT/vB0rVXMYVSwyFVZUNexNcyMo6cViU3gcljj1a8Ql9e8zdWqr7uoR698Ut2jRMhPyKA8U7+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKPgT7dvYuVycmwS5iOQk1LixZ8lfXneW6VeZCJ7C36OiTqhDd
 qcW8NWsx36c26HLK5lbYOOMylS7FFoRja+bYqCdtp41YhahUz7q2N6ONtlfbfvCHqeDqoaUljLj
 86tLH5B8lgcB8TwGpl6X97+T4wbNg1PA=
X-Gm-Gg: AeBDieuLFyr79ZZ1aYcsH5cxbbINQg3iO3sAGZ7CDZbZBtqUz6OxiUyYBMc8H5yoHja
 63GSIHPmW1gRMrWtsyTFrqbvX5aYTHZIDscaImrfwKFXJBPWkg1KISU5mCCIf7mIvDJaKLbYt9l
 OcBdz/eyAK6Ba6HsFSwgop8Covj+mZdsXZBjN1RmEdHCY761uW/cVkPT+gzXfxhdjRK2+CV0srw
 Eewyz7PJyNeRVgnmx34tYRVasn5YOgbx1g7SPvzGStm3nBfkJbor8VQxki+wGHOamFVkBAjcAtK
 8fj0cMXHiNX0RiLRNbdlX83qfJeNHnIAdJ3cAq5XQsSTFPOsNzDGqXblIwxOaYyymMUYVnPjEmk
 qNqrU
X-Received: by 2002:a05:7301:fa0b:b0:2c7:2cac:814c with SMTP id
 5a478bee46e88-2d58979bc41mr3694192eec.3.1776174355323; Tue, 14 Apr 2026
 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260406225008.2787532-2-werner@verivus.com>
 <20260414050840.244705-1-werner@verivus.com>
 <8892f093-a98b-481e-b01e-4e640d2edc54@amd.com>
 <20260414094721.459068-1-werner@verivus.com>
In-Reply-To: <20260414094721.459068-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:45:43 -0400
X-Gm-Features: AQROBzCrernNciiyxTUg584Ae9KLnD-_2RN0ZVtAyto5bBcJMjMxlTeTPH8_8EY
Message-ID: <CADnq5_Mq2SVsLd1=Ax1285UyEbwybbCeeKXxt4Xy6e7hKX3TAA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Applied thanks!

Alex

On Tue, Apr 14, 2026 at 9:06=E2=80=AFAM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> On Tue, Apr 14, 2026 at 11:26 AM, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
> > The patch looks valid to me, but I think we can drop this CC: stable.
> >
> > Since dump buffers are a kernel only interface the fix has no practical
> > relevance and is only of cosmetic nature.
>
> Ack, please drop it at apply time.
>
> Werner
