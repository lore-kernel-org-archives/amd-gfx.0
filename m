Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66778C10DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 16:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A98E10E4C6;
	Mon, 11 Dec 2023 16:31:47 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF8210E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 16:18:04 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1fb14047fe7so2681637fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702311483; x=1702916283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
 b=auvFmR/jY+UXvG3IrRqVGUwpq6FiQJvbFqeq05+xUbLvVZrNyK9yx0csvNISSFD5lC
 CPxJ/NKREFXlYACQJLIl31mJjXHSx3B4kfY+SSo5idgYBtejV0MkqyNNCxRFeh58XfyC
 oUGx8RbM64+QkZ/5huS9ornDiGoIxzysf7sgZx27JzX3wtevOJebYra/8RGw9uu2ycvx
 Z7fT4JdXc0NcjU3vqj3XlHH6B0wZ9IzP3kYnI965Sh3IMAF6uRgZs1zB3oz9e3PlLSyV
 I73wadP1GNbXn7P7mdkCVIEYHg5r8m8cBeVx6pimBu2/lhOAXJcNkL7B/GG5R/OX6IKU
 smqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702311483; x=1702916283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
 b=qATD5nQYpzILXzSBscIkcTbQ7oTyhf87VoYZekJs5jz4zTo33ZD1lmSVYJzxeb8NEF
 CyfQPZ9OdTtiK7yibZ8ohCfjWj2ZGSEN+DBKbaBRK/4cQ7fh2lHqwliWuOlP2naFFoeg
 5DFYzKLqRPH3VZXTcRV0T4mkr8e0CAsu72QPiqSHhCCOpwOTQ22Oxhs65b7d+RVaH8O6
 Z+QCtPnbmsIRIFZrx0mSGlxQ8xnsYGWk50FFBb5TDLL+tf8xh2ghzeNil/vtPotXZ1rh
 k7jzTeFf5APYuXF8V4ch/jIxZisuU355YegX8LMp+arlFBR3/SSj+Eh9dDZlu0z/kn0/
 YgCA==
X-Gm-Message-State: AOJu0YyTSI474I52wn4mwH+38z2OpBvn20T0OeXIshGPfuELZ0zpxwcA
 Abhi03fjMCcW+HYjPSquEy9dq+b9+k36IbSQycqGIg==
X-Google-Smtp-Source: AGHT+IEC8jdvAnetFbqJVF6lQQw8UXKnB/IQiMsN2t2NyqglmpS9Xy9aZsTAJAYPyNV0NsZe4DU6SA==
X-Received: by 2002:a05:620a:15a8:b0:77d:855d:1b09 with SMTP id
 f8-20020a05620a15a800b0077d855d1b09mr6457241qkk.0.1702311148452; 
 Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e?
 ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a05620a066f00b0077d78afc513sm3014865qkh.110.2023.12.11.08.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Message-ID: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
Date: Mon, 11 Dec 2023 10:12:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXczty+Y6dTDL4Xi@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:31:45 +0000
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
>> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
> 
> Btw, do we even really need the extra variables for compiler flags
> to remove?  Don't gcc/clang options work so that if you add a
> no-prefixed version of the option later it transparently gets removed?

Unfortunately, not all of the relevant options can be no-prefixed:

$ cat float.c 
int main(void) { volatile float f = 123.456; return f / 10; }
$ aarch64-linux-musl-gcc float.c 
$ aarch64-linux-musl-gcc -mgeneral-regs-only float.c 
float.c: In function 'main':
float.c:1:33: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                 ^
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                                     ~~^~~~
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
$ aarch64-linux-musl-gcc -mgeneral-regs-only -mno-general-regs-only float.c 
aarch64-linux-musl-gcc: error: unrecognized command-line option '-mno-general-regs-only'; did you mean '-mgeneral-regs-only'?
$ 

