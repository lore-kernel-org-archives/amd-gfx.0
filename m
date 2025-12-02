Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA1CFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 08:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376FE10E580;
	Tue,  2 Dec 2025 08:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P532wrAP";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15ED310E50C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 02:31:43 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-29844c68068so55435305ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 18:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764642702; x=1765247502; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=+gp3h6PDJrFjQ/i9BEQXXsbli1Le18PxsqaLSK45JE0=;
 b=P532wrAPHjTw5TpnLlQgPwbsPV5/TUaviNfuKDyPRxScbMIYfQJsQ5IfzN5YUuBxPV
 CQVBCrqlgkVGdQeQg4z3RKtxD+YMUkV7gB5y1thKiHx1MKtFBzYIcaFdACRbTiCJ16qj
 0fAbi3wqzSI8b0gvwuI3FNrgjO4moYWiN5xQB7Q2ur7h5AiHd2TTb5JJcPbUsbJNlluo
 ZE7l/QRo3aLZHGSsSy9kENSqVb7MQMBm7M+4KS0XPHMkz15oNopoezuAr39XQXzBmKCb
 ZrmBwR16vlu8o6Y3pVfeuLetitY4lXaj6tT+yFJ3h7a9j6KW017sCJcz4dfQoaqgaxVq
 Koqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764642702; x=1765247502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+gp3h6PDJrFjQ/i9BEQXXsbli1Le18PxsqaLSK45JE0=;
 b=hFuZ/HGWnaatBXWBffvp6QmRf4oFbuXkYsJDswJ5Oo8Vo6KhxxcWbsl9uyHn5eqb0T
 oBK4n0QrM7WD1EO+1QmBw9xs6DXrTxmT+hHAaKuoorwFl5rZq8q532eSKvelNLCWk1Tg
 McKaaBE6lLnUHnLmWUS92FraV3I8f3HnoSIYHuKrQbAC+lk4S4/mYoT9wvFxkqtrv4An
 R+Ob+/rTzunRj/q0WnmKG1z2eNXovVvMrce/TLiCjrQOKYJqBuzLCprLa0Tkk7IuEtHv
 0kOqVwVlTl3Sdk2F94Izx3uRV4irB52Xufl/9ysFvFk3CGfj2eslrvgv5spqe8g8sYDV
 KjAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEKe2mHXEEBewX8oVHcf7ktQnq8pOerQUh0m6v03kXfgMx5LJfyu5fRALKv7LbukWn6w1v2Ntu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWgpu9JJXQq61fab3bhtcSKKL2qMk0AyGCRp4ig6wjkdsA+J+J
 lLfYgm7iCIHP8IQFDBbCcpoE4jPMk67a9NrMqn8n/caqiefKOS49rQV6
X-Gm-Gg: ASbGnctGQa9Kn4Xaz8z746vmDnFHvuo8q2AxcHpUuQMZTWLr7eM9PClmRDvHpMwCtjj
 h+r5JO6TpbGysCsR+LmigjtN61quVnQVlHxWM+jKj9IBvn8tZWIj7fv/ZmHLbasRX9RY5raCER7
 ednEMFVn4wVm7hqxaflL82WAyx6Zr8zXTorBR5ilW7y8RmAfPAw9/7h4HI8P8zfWw7B0V6u5AFZ
 2x9odf2qYwQPSOzBJZZKe+xqu8egIR8yfZp8NpTMnghMRd3dUHq8wB3ZQ1673o29AkH/LMp1NS1
 KDhvu/Uc/0s6qi969RJ5FrniTrECacMx/tmcP0ZOkbjAIG9zOxdEvogwNaO+kzvhdv6YBmch8VZ
 sxwdVK7vWiSTIwBcR1jvPnUE8nwOKWvq7P5tH6ganSk47yy/meeQTi8RG2e24NtXWCM/N7BbFVm
 rG/x9eq+ml5OtnF67hwyXHDb4=
X-Google-Smtp-Source: AGHT+IGOriu2yyUHY9yb8FJoC+gkKNWxweR3s4/nUAw2SsEdpRaUGaSBOcwYKvayoTNR6hvb42S4fw==
X-Received: by 2002:a05:7022:6285:b0:119:e56b:9580 with SMTP id
 a92af1059eb24-11c9d61285bmr23737179c88.5.1764642702387; 
 Mon, 01 Dec 2025 18:31:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11dcaed5f6bsm79049292c88.1.2025.12.01.18.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 18:31:41 -0800 (PST)
Date: Mon, 1 Dec 2025 18:31:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.18 amdgpu build error
Message-ID: <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
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

On Mon, Dec 01, 2025 at 03:17:49PM -0700, Shuah Khan wrote:
> Hi Alex,
> 
> I am seeing the following make error on Linux 6.18.
> I started seeing build failures since rc7 and rc6
> build was just fine on the same config file.
> 
> LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
> drivers/gpu/drm/amd/amdgpu/amdgpu.o: error: objtool: elf_init_reloc: .rela.orc_unwind_ip: reloc 39935 already initialized!
> make[6]: *** [scripts/Makefile.build:503: drivers/gpu/drm/amd/amdgpu/amdgpu.o] Error 255
> make[6]: *** Deleting file 'drivers/gpu/drm/amd/amdgpu/amdgpu.o'
> make[5]: *** [scripts/Makefile.build:556: drivers/gpu/drm/amd/amdgpu] Error 2
> make[4]: *** [scripts/Makefile.build:556: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:556: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
> make[1]: *** [/linux/linux_6.18/Makefile:2010: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> I tried "make clean" and "make distclean" just in case, still see
> the same error.
> 

My test system does not report any problems. What is the configuration
and compiler ?

Thanks,
Guenter
