Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC7606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKQIHS6I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E6C10FB59;
	Wed,  4 Nov 2026 11:12:27 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E6E10F6CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 16:06:05 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-14fc585291cso3460207c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721964; x=1794326764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSehECxM5OmeuNZLHLBGBNwYZB+YaKpkw0khTkFJZnw=;
 b=UKQIHS6IVGfgvNGJc+tBH6TTsIRX5SgJ1mGcwrD0ydp28PTMVFlZ29VLbTh5juch6u
 yJYbXGI6V3zoQmv1j/EFMkX5Y4Dii//sSQDhlfahW1oTxNQjw0+wetHhWrxyp+ogvR2a
 Hx2a7KtI3kuQdf4plIuhxIId+WlSisErCzgMa4dY2V2Ur0NKZEfLyfCltPvRNPHncQOo
 afm+prMza5dDg/BJ9ytOIQT1P7Mg7kI6X86zJ9EkAikJGncmm4DLIM4TT0vrHIBAjoud
 d4U74XdARwr6OZYNIRnJQwcNQdxsqOIAlMFdKv9YZ90bGghuVwn61RkglITPbIn8XUOi
 pcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721964; x=1794326764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSehECxM5OmeuNZLHLBGBNwYZB+YaKpkw0khTkFJZnw=;
 b=zMj+YDCPIzP+8Z3t0cld+xgJnahZqUwMp6fk8EayhJurlH0PhBnA8WsGqOcMzPAKjA
 HviW2ItnOX3OSJMRzZaS4oZN5TEKJWIqYgPgP4teNx+uVlsvBc71x6LSiDG2Lr0VWtMo
 1yqrCZ8HIKjg7zrM+4kPmunWQaVeUVV7+pIe46uA62mvhBNdytzkv6gKeSdmI8+e6HNJ
 HLIDmX1b0Ze+5mFWS2gInZ0GamUyZyPriPagRP80hcB7Kvo7CysC0N342FnfJbHo09Xy
 aRzXTBA1PGDnFuXqvvrWHl2MwxY7mzxu99jAodWfgRUjw/IRWPwVVK/m1ID9l/hnx5eN
 gw4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJxaH3jP2S6y+kga3GDxWw88uMWgTv7ddAAGu5Vg/PhsCiEC0fo9/n7gJ7kKbOuJMWwgMK1J0k@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+a7kcz6DHntSOA4stTe497R37DsIo0DWKJDTS2Z4O7o7dSWN2b
 gilV/ZjB/eLM0Oa9TxSjWXKIx7xTtzqnWVEn3dyI4hcYcAVOO25GuuY=
X-Gm-Gg: AYBFou1XlDV7jy4+GL3iWW/e+psgqWFvag4UWej+1tgC7vSP+ds0u+Q8W/S+QOVjiP6
 Y1+AaS74lpII8GB6lLkuw+/hMlYlAiSHNGOYUxQuDNuzIiBi693YDeFrpa0xf2Pc63s7Bjv5Q4t
 X6QC/c8VOWG83hmU/Yl93/lMun8GXcpmu9/+IWyfY2Yi42uKnbJAnBuKaZm78j1MyIL4IKIeK8Y
 8oNpIAg4LzBa5j7VldBDdScIPN9UJnWk3zEz/PoEgTDx3N4PY6KAuMhDKD7n3ZESrjjRBi41DKX
 8Qx6Ow9Zmyl32yqXPXolXVblpPAkAG5aWSRRixJh7Yt883dnczlwWTq6sxC6ll58hDQlfMdAFEx
 M55QM8f/xNNhf1FhXDipPCEOqiYmixaSVaMj35UZoQSZKQypjaImNi8e+KOTzBvgImqrDi1mEep
 QCxQAzLm1Hbl7/Ir1GgSVG1tAOm5foq/0t8C19FmW8Hry8qzg4SGb8nVaXJQDbw26xta3G9kses
 A/DlwT1Nc1hKJnBbggylDO2ITaBZFBLHBmZu8rSCAdOnSLG5mBWjd0GqlZkCl4dUR7INIiMxBJg
 D3DZx1+XRV9O48dib+VGT9JdyTvpssG9umRvPpevQWvfkZ8w1IDCPX2ES7jd8w==
X-Received: by 2002:a05:7022:f20b:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-1ac56d94b0amr21085882c88.6.1793721963966; 
 Tue, 03 Nov 2026 08:06:03 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.19.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm47910609c88.12.2026.11.03.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:06:03 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dev@deq.rocks, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 simona@ffwll.ch
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Tue,  3 Nov 2026 11:05:53 -0500
Message-ID: <20261103160553.1431-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
References: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I forgot to remove the pptable check.  Can you try a simplified
> version of the patch?  I think all you need to do is delay the UCLK
> DPM enablement until late_init.  Something like the attached patch.
> 
> Alex

Also, i've tested this patch with the 5K patch, the UCLK then just never
gets initialized, so this patch is literally incompatible with 5K.

And also if ur wondering, what patch am i talking about you can see it here:
https://github.com/t2linux/linux-t2-patches/blob/main/7003-amdgpu-add-support-for-5K.patch

I still need to make combine patch (otherwise bad tearing in gnome/mutter), and i need to
enable 5K in EFI aswell to remove the shitty quirk to initialize display eariler than smu,
And make it usable with simpledrm.
