Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BCC6FD1F
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Mar 2024 13:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13DF10E7D0;
	Sat, 30 Mar 2024 13:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="XEaDS774";
	dkim-atps=neutral
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C21610E164
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 18:04:01 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-368a67fb5eeso6961995ab.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711735379; x=1712340179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdcMw9p8wYMiyXmXvRCHMMbWNQHaQ3aY6vG2uVIiJB8=;
 b=XEaDS774gYmqABsnlTNVIt7xEEvoegQGi6Qkjzu3N8EbwvGszwStqE5ePuEsWSh/gX
 OcTtZXfFhgpuJfpkQteP8gKJmypftJYPd9plC+0F+i9pIqdqvbriIq8sF+9w1xP6Tgb6
 GRA4dZAoroHAh1CKbjXAu8S8evD2S7cn+b8HysDmokmAHtCIDKyjB76BXJ2CAzJ8+4lJ
 aExSEPEgAxZk4T2sZkXdsTLXFhEIc6lyGZKhAtxo4WdIeGIfMmZ8uvIz9rBrWIP7gZQq
 r0jMWLSriaVoITsk5do8uzBEVm+f7HZ/B+HpLX83TgUC0O1V07M3M0oPA/JxO0wtMV1T
 CP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711735379; x=1712340179;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdcMw9p8wYMiyXmXvRCHMMbWNQHaQ3aY6vG2uVIiJB8=;
 b=gPgIiWHbPxGIGbsEnfDyXzUXwML9yTkTslnjVybAhsFXnPdQm9bNaf0/uZ7EBZ0uoP
 f4JyMhp7/HCL4b1DGEF6aBE01p5UhTff4DktfVBaunh3Bki5irxCa/ihKZlDBeC5ncId
 7uyj8+jPxT1ISuh2s1ncjLPO190u9TNsasoToaUDgG1ocotiXjYM6RHjiBBCTbtPLnOA
 a7IYtAanrWDzGuX5AJwhOhIAmW1xoHFVm0CunUwFYVYmsinjXSzX4u9mHjflMZqsjJ3f
 7xtH1cWpRNxcYmlj6lfoGPRYzi0cU7KzPz2adxC7KpAFrO2w9ocWuHPuKL6mjGJhdHCy
 Dz8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcHLtHtMg1OyWuHPD5E8a4U/nGQQkRzhRgF2D+vfNIilxrqp5V0mCPUODbrXHtq0dsJzBTG0eEc41+4gdo8njEPo++jPn+pMT8vj2Dbg==
X-Gm-Message-State: AOJu0YxKbu/I2+RMAgOt2LqU959MYMbb6p/bW1Z2gMXFKX7SJEWlk8Fj
 Pg3FWlmc6xmdimdl6cWKyXwK0objif9tldpo6ZFADtySItHAsNw7Dn9FDNmEqXR9jEtD745woio
 w
X-Google-Smtp-Source: AGHT+IFqMNmDL2GVO2cyYm+vIEEaj43NPiUKo2CRXyyGfQmLknY9TtLFDSxdZDVwWotlePg1wJz6nw==
X-Received: by 2002:a92:ca4e:0:b0:366:ab6f:f6a with SMTP id
 q14-20020a92ca4e000000b00366ab6f0f6amr3003624ilo.24.1711735379197; 
 Fri, 29 Mar 2024 11:02:59 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190]) by smtp.gmail.com with ESMTPSA id
 k4-20020a056e021a8400b003689a9e5017sm1217549ilv.47.2024.03.29.11.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 11:02:58 -0700 (PDT)
Message-ID: <0319d84e-ec4c-45a6-9edd-a606809371d8@sifive.com>
Date: Fri, 29 Mar 2024 13:02:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-11-samuel.holland@sifive.com>
 <d2c3cd78-cdc6-4a39-9804-4f30402751b1@intel.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <d2c3cd78-cdc6-4a39-9804-4f30402751b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 30 Mar 2024 13:31:09 +0000
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

On 2024-03-29 12:28 PM, Dave Hansen wrote:
> On 3/29/24 00:18, Samuel Holland wrote:
>> +#
>> +# CFLAGS for compiling floating point code inside the kernel.
>> +#
>> +CC_FLAGS_FPU := -msse -msse2
>> +ifdef CONFIG_CC_IS_GCC
>> +# Stack alignment mismatch, proceed with caution.
>> +# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>> +# (8B stack alignment).
>> +# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>> +#
>> +# The "-msse" in the first argument is there so that the
>> +# -mpreferred-stack-boundary=3 build error:
>> +#
>> +#  -mpreferred-stack-boundary=3 is not between 4 and 12
>> +#
>> +# can be triggered. Otherwise gcc doesn't complain.
>> +CC_FLAGS_FPU += -mhard-float
>> +CC_FLAGS_FPU += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
>> +endif
> 
> I was expecting to see this (now duplicate) hunk come _out_ of
> lib/Makefile somewhere in the series.
> 
> Did I miss that, or is there something keeping the duplicate there?

This hunk is removed in patch 15/15, after the conversion of lib/test_fpu.c:

https://lore.kernel.org/linux-kernel/20240329072441.591471-16-samuel.holland@sifive.com/

Regards,
Samuel

