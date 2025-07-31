Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF811C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 08:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C24510E737;
	Thu, 31 Jul 2025 08:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="MDbD+iDi";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CCE10E737
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 08:41:49 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-af66d49daffso106946966b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1753951308; x=1754556108; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VM9THQ/m4LP5UpfhpMQUkxxu1Pp+ebIQOSQVnwy/jZc=;
 b=MDbD+iDiv2fgxPeFccJQCMzAdc5Op98P5h4BcZUSW3/vzr7MUZ9Tj1FlbQXQXjcykV
 j89qGRpZNk4h+g5UMdf3IWObK7x20pHF1b9BZXKDLX64QAnZm0Faceu1UAZxyzxx+/tj
 fj4vG48T3V5yomIf4GIJcAYutTQbJpChEIe9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753951308; x=1754556108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VM9THQ/m4LP5UpfhpMQUkxxu1Pp+ebIQOSQVnwy/jZc=;
 b=brly2CzhZJzcr5Td8d6mKimcWhFaxkwtLmEG/u4aYQyTBokjFgRuD5/SpsNPrVUyDo
 scfPMVd+V1CVT+RfxPq/pIrE048lexHhdrwzCF9UUaxNMMjDeA/gxy71MtI8OC38NyNA
 UOZK/2UifjejnJ1kRoDxq28TFff3g5i8PRf80eLxxxE9QDWWv4cNDQu/xHd2v3DIZP6M
 Y8jBcUKIborjekd70AatruC1LYp9qlyO0+nC393SLfGm5fo0h0XrgyaDMrrlhij0UssP
 JTxEVfILjJdO88Xc1sq48tfQdkUtLAgZkazlBqh7EHH8uYLqiktq/e4//sp+LevUyDFr
 R+eg==
X-Gm-Message-State: AOJu0Yz/0Zr6I0yr4L8k1TviKbzFjNcMfizZM5gO1LxvuM5sCrNmqbhZ
 YQkg8MH71bCdkEJr6pL6RP3wdLlwm7FkSwq0wesZvcv+C7Fbnipn25lKFTBLQqxsNVQ=
X-Gm-Gg: ASbGncsYR3MCJv65rQq9SOHFvG3Nu+6A5cf0dGxukfoNbl5hr70mH+plA4rbaMVBk9b
 vtd28UpCKaHPf26ncNg/WAczh+H+Glam93TUTWLtsxOHkU0oQnRsEZ4DHVgYjOKxJNi7kUcLG96
 yTWMuSIrkwhM29HhjHmhdFRBC1Q1071qPJBHUIlfXC/RPc7eX4P48gQTJ8QM+dAZ9NFlShymW6K
 7jyq33FVxUNvC7kZO7PxSY6msBUOrpjb+Qx9tJtiO+nCGvIiH99/QtrrrMphqOd9VXqm2yE7PFk
 H7qTEN62guRMEoV+Ad4nmBJeG3R09rZi7wWxNeX6UiU177l/k0ojCrPt8SjdJgrkosYue4AJ/xX
 b8Jyl46jCmOeYA9P3cHH2DqkSVTUQlpsD9PPdHPeVppHuXNvaA3Nk3k4=
X-Google-Smtp-Source: AGHT+IEjZp+amZZtr6D6n7m9eEOPNIoap5IGhtvDqpWGJ5PGPb499LhdmjvVfDjKxqIsVvRkBWceWA==
X-Received: by 2002:a17:907:a909:b0:ade:3bec:ea30 with SMTP id
 a640c23a62f3a-af8fd577e5bmr878571866b.1.1753951307473; 
 Thu, 31 Jul 2025 01:41:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a078bcbsm74641366b.13.2025.07.31.01.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 01:41:46 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:41:44 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: David Francis <David.Francis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, tvrtko.ursulin@igalia.com,
 Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, Christian.Koenig@amd.com,
 dcostantino@meta.com, sruffell@meta.com, simona@ffwll.ch,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
Subject: Re: [PATCH v9] Add CRIU support for amdgpu dmabuf
Message-ID: <aIssSGWNP7pb4eHP@phenom.ffwll.local>
References: <20250725160757.231780-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725160757.231780-1-David.Francis@amd.com>
X-Operating-System: Linux phenom 6.12.30-amd64 
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

On Fri, Jul 25, 2025 at 12:07:54PM -0400, David Francis wrote:
> This patch series adds support for CRIU checkpointing of processes that
> share memory with the amdgpu dmabuf interface.
> 
> This v9 adds padding to the structs to align them.
> 
> Adding Alex Deucher beause these patches add two new amdgpu drm ioctls.

Bit aside, but I think big infrastructure stuff like CRIU support would be
good to cc to dri-devel, as an fyi. I think it's pretty ok to let the
leading driver roll this all in driver specific ways, but keeping the
wider subsystem in the loop on things like that would be good. That's also
kinda what I meant with my cc request, not cc me personally, I get _way_
too much mail myself to stay on top of anything at all.

Thanks, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
