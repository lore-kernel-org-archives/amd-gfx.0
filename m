Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9464AC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 17:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1E410E10C;
	Mon, 11 Dec 2023 17:41:39 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A912310E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 17:24:56 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5c08c47c055so45862347b3.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 09:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702315496; x=1702920296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
 b=Gmd+DX7G24MbqAQm9YKbdAoKvV3jyb+0+s0G4iHTrF7V/Ly5Xr/7+atKvOrNgqNpYj
 S4hWQ4J+zuoIH4nWU7V0HZRIpvD4yGHROHJAxFnb7UvZpUcv7t5rH/+DJyo4SXwSOX/v
 jmOv39ORMxTNqPev9YtsMgEucD6s83U1Nj5I/YxWE2ZK8XqZ5mEvsI3xV2FEiUK+J99o
 Ue/ImPubT+dNHs0rPEIQMtK8a71C6TS2RsTRUdVbH2w2XLVp7xwEnWmD/KBdyUdzq9ET
 ljGIMFg5KvgrecEya2QvVoQ0z9KQUGRqxVENwvZMRnajEC22r7wRCHG7uJs1VucJ8K+l
 UYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702315496; x=1702920296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
 b=n93zlHLhwGBZaFKUy24BjvktnZ++j7kVj1Cvxpft5i10g5YoX5YxDYnuEcY3ILtUAK
 LScYhTQ4nufPpBDbXsyUZBOedd/UMlwPlgCfFI5oxDUQOJ7m9KCbCMiFNMWs9M3mVMW+
 egsDKxFTMShj9G8Y5fjuxISwSwZZLUbezfvaOFAS/6s+ZstL+0o1g1Zl160ZK8O0rHQk
 A2je26aucfA8pQ39kC4KgLIWR2fEY9uZROb//bM90hSvEcgh3dGdt6XTkrTOlpNIlNVy
 fNupDWaguLr/fGa2vkumpVbG+bj/v55kJk6Uq2Jvj/AbE5tAfYBgjXY4A8bCR7GyvVn4
 RQFQ==
X-Gm-Message-State: AOJu0YyoKK3AsGD8mzf1VCto8jDYuENGosfs9x42ht8Q9mR3nnYQGv2p
 pufGIA/PPr2aXhnd0rion229//hoXlT3lELC0k6twQ==
X-Google-Smtp-Source: AGHT+IHy4FKXKcoa5vr1zWRR7h8ldItNotN+bq27os2Gmy1WmTZV3fGNzyOi2gfObdJOXzxcGBLOzA==
X-Received: by 2002:a05:6214:1fd9:b0:67e:b878:8e48 with SMTP id
 jh25-20020a0562141fd900b0067eb8788e48mr4904522qvb.39.1702311375258; 
 Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e?
 ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a0cf6d1000000b0067a18167533sm3380983qvo.83.2023.12.11.08.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Message-ID: <3f28c1f7-f29c-461f-a90e-58d8e0996cc0@sifive.com>
Date: Mon, 11 Dec 2023 10:16:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
 <ZXc0rAdi7Vo8nbS8@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXc0rAdi7Vo8nbS8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Dec 2023 17:41:36 +0000
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

On 2023-12-11 10:11 AM, Christoph Hellwig wrote:
>> +#ifdef __riscv_f
>> +
>> +#define kernel_fpu_begin() \
>> +	static_assert(false, "floating-point code must use a separate translation unit")
>> +#define kernel_fpu_end() kernel_fpu_begin()
>> +
>> +#else
>> +
>> +void kernel_fpu_begin(void);
>> +void kernel_fpu_end(void);
>> +
>> +#endif
> 
> I'll assume this is related to trick that places code in a separate
> translation unit, but I fail to understand it.  Can you add a comment
> explaining it?

Yes, I can add a comment. Here, __riscv_f refers to RISC-V's F extension for
single-precision floating point, which is enabled by CC_FLAGS_FPU.

