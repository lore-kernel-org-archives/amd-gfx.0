Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6068D11701
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 08:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BAC10E5A2;
	Tue,  2 Dec 2025 08:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UUIidTnj";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8FC10E4A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 22:17:52 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-659400dab22so1706431eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764627471; x=1765232271;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBsLveKm3sICituFz5QEcYKz1j6jARt0OPo3VAXwKyU=;
 b=UUIidTnjSa/djKxgcYMrzc3eV/dk5GxPzncSdyAl1ZrYoG+e8hYhlVTaEcHUMpNYyD
 GCqQSNu8PSJF/C9aw09s4QG75LXB2Z1xsZJBw+Ull/QuPxQMhYB36ujUz7lvdW2HUEaR
 ojuNhGKBepX/6VtE/xw2vVgCuPRWy+jMvh5fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764627471; x=1765232271;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBsLveKm3sICituFz5QEcYKz1j6jARt0OPo3VAXwKyU=;
 b=P1ISV+9CYhdaIRm8jNyymvyGqBxQwoK87SFzIldlfTPxVIHYJGoiXZJqyQGuBON8lR
 SZDpYaxvTY5Brj86Rf65v0wQR3WVTxSGmMYjzITrP6Tg4Y81rbpGdxOyfFx1G51kEKhB
 mGm6ft4FV+ECgX0uPzSA0m8jsxOnp5OajM0YPaTURAHhMoy4Sqor7q+i4KF7juW+HK8X
 yqR3aSXrroDZsYN94jpu/HXCREQoZFRJBwrgx3hwQlHtOzFDzyUesrwtKbmPhtXvQdiJ
 npiyHskGlG+FBoROhm8wqrJ9RUr/RJuZJM5WgfCvgO8p9frgwl2A/x7Gu9txZfxZPDiv
 ZaHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjcfBaymm2k9euW1Lh2H/UI67BDMZc/7xkgn2aKoyfNo2HeVx5+NEV+MSsBfb1wYzihqVmUvyu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymV9M0A0ftBelq5CQjRs/7dQLVNyYyUKGLdwDg07Tkz+qHH8iE
 Q4mNfAgl308H8olN98uSJ2j9BW3UWBCq7poCDs4XbuBpYllbxJhYD3WGrbmAM328+mw=
X-Gm-Gg: ASbGncusCsTymuGdSYkc9jO/fgqmnMU/nSHgrRkpAjme/JmHjmJ4FR6iaJoAL8olwJp
 N7jJ+/n+wxgsyrGGXksFKPkloc0OKg05OpQhg6wgcmJREJ6alnjnVONvZu1Dx8AL0KwY3vjfYiU
 B0mG8FKO7HfzO4M9Xy0ehs1LDNRvApWIbticPBhpBFAhagJRy0qQvpplYgR8FMCTRsV7Zuvpzi/
 EqJPxgYa7PHR5C43FvUhu7v+iJWFpAr8TPhP5QwtNzXKvh72g0tcfKRNg0l/tvMNDRIRnOk/YOr
 h50OPXh0vybPEJHucTXFD2Acp5Maft2bTR5spIV2DGq0anoV47erIBUz2sT6aPsO893vAIpQI9A
 0SjwF9MJL9T8AuM7EAqmp+RUF3UP48EXCxoKP3Rbb1UZgpNx/06F8wk0At3w3xPwYqAfEf3WufF
 IfSfotyCvphIIzKrci11PVOjE=
X-Google-Smtp-Source: AGHT+IGwGazuubSSjxjH+mjuxyXnc2SjhHQSYzG4kYmrbucHzn89mjeC6CXeIgawOINq6D18VrBcqQ==
X-Received: by 2002:a05:6820:2005:b0:657:71ec:5450 with SMTP id
 006d021491bc7-657bdab6274mr10850009eaf.2.1764627471176; 
 Mon, 01 Dec 2025 14:17:51 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933cc2b36sm3189769eaf.12.2025.12.01.14.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 14:17:50 -0800 (PST)
Message-ID: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
Date: Mon, 1 Dec 2025 15:17:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 6.18 amdgpu build error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 02 Dec 2025 08:16:18 +0000
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

Hi Alex,

I am seeing the following make error on Linux 6.18.
I started seeing build failures since rc7 and rc6
build was just fine on the same config file.

LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
drivers/gpu/drm/amd/amdgpu/amdgpu.o: error: objtool: elf_init_reloc: .rela.orc_unwind_ip: reloc 39935 already initialized!
make[6]: *** [scripts/Makefile.build:503: drivers/gpu/drm/amd/amdgpu/amdgpu.o] Error 255
make[6]: *** Deleting file 'drivers/gpu/drm/amd/amdgpu/amdgpu.o'
make[5]: *** [scripts/Makefile.build:556: drivers/gpu/drm/amd/amdgpu] Error 2
make[4]: *** [scripts/Makefile.build:556: drivers/gpu/drm] Error 2
make[3]: *** [scripts/Makefile.build:556: drivers/gpu] Error 2
make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
make[1]: *** [/linux/linux_6.18/Makefile:2010: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

I tried "make clean" and "make distclean" just in case, still see
the same error.

Is this a known problem? I thought I would ask before I go figure
out what's happening.

thanks,
-- Shuah

