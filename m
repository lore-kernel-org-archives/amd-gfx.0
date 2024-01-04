Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D511C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 16:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B51910E4E7;
	Thu,  4 Jan 2024 16:01:00 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343E10E4BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:58:30 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7bb982d0f12so44429539f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1704383909; x=1704988709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+LkB4Vo+u25oWI7sGQO48sDZuLcvpPhc24u586CsWs=;
 b=jAbp757oE03Nclc1jYY36OtweRdU2GqBqK2vt/ebiY5779h1xjfDNdAG6EMMk8CfHm
 XtQQojLM7sBoDUIjsUdDqtLnwwwf1D/wPrtT6FXGdbcbvjx2OGAnm+FQY/oP4rNxVBFj
 KMezXzW5W7ReS8etuI/Jd45ahqRt7g4Ufpij+7kP9bjiVbAhaTUGXghdLZEnHT4RdXzL
 2LdknT+FfCJ/LkE0OOrpMHCavQgK6utESNY8q9JMbfwl68YYRzmniZXDA/an2Vpno2Ae
 eecQlC2sJrN2uTdXiJ1wVa7jF3vgXu0DtHwDls29ZFs4mZDG1HTkqHlYDUuipTP6okB2
 HZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704383909; x=1704988709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+LkB4Vo+u25oWI7sGQO48sDZuLcvpPhc24u586CsWs=;
 b=Qf7ito1MJ0vAqb1HPW4oHEU+iTcHixIJlJRVKXt1u029F5YFqwgQIH8tILSH0qWV1z
 74wBQyWQGDAE7+aDFerwDIF+OcPcInwdF0stsErrh3net0LDtBX2/QQrOXEIIF0q+Dp+
 1KJtEUB1XFVW/lKX3iSSZPFpiKyD8gjQPYjKEpVbu8KOCt2vq7uuErI1gOoeD/cuPQHW
 GTKanWp71QpI/JlF+nNI9NUzWX4ec77zScAKxG8nC5p7zdk3u1D0BqWlmYZe2gZUlyeB
 68nF+V9LjdwqThPz8N7Dpsz+8HbmAqBp/ng0tmUVwgSonQIXmDNzPrDux+cpDlr2r5o4
 Kbzw==
X-Gm-Message-State: AOJu0Ywum9h2TVBam3SzfP2knNUYF7W2FU0GL2iDsPrn7lVig0DxGSUd
 8bct/nHV59yk+zX/oPskPKu0BYsSlN3dD5EVbTx8sD18jEQ=
X-Google-Smtp-Source: AGHT+IH0j3oQCRY8sxvQe5xsZpHeGls13odOGuU65eTJqn0FYIyylaRiHWDyo9dxY5HyEPL4psyAAg==
X-Received: by 2002:a05:6e02:b48:b0:35f:f023:f8e2 with SMTP id
 f8-20020a056e020b4800b0035ff023f8e2mr508987ilu.17.1704383909345; 
 Thu, 04 Jan 2024 07:58:29 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6?
 ([2605:a601:adae:4500:b86c:e734:b34:45c6])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a92d250000000b0035d6559c5b9sm9232707ilg.64.2024.01.04.07.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 07:58:29 -0800 (PST)
Message-ID: <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
Date: Thu, 4 Jan 2024 09:58:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-8-samuel.holland@sifive.com>
 <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 16:00:59 +0000
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
 WANG Xuerui <git@xen0n.name>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Huacai,

On 2024-01-04 3:55 AM, Huacai Chen wrote:
> Hi, Samuel,
> 
> On Thu, Dec 28, 2023 at 9:42 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
>> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
>> the CFLAGS adjustments.
>>
>> Acked-by: WANG Xuerui <git@xen0n.name>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/loongarch/Kconfig           | 1 +
>>  arch/loongarch/Makefile          | 5 ++++-
>>  arch/loongarch/include/asm/fpu.h | 1 +
>>  3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ee123820a476..65d4475565b8 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -15,6 +15,7 @@ config LOONGARCH
>>         select ARCH_HAS_CPU_FINALIZE_INIT
>>         select ARCH_HAS_FORTIFY_SOURCE
>>         select ARCH_HAS_KCOV
>> +       select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
>>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>         select ARCH_HAS_PTE_SPECIAL
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index 4ba8d67ddb09..1afe28feaba5 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -25,6 +25,9 @@ endif
>>  32bit-emul             = elf32loongarch
>>  64bit-emul             = elf64loongarch
>>
>> +CC_FLAGS_FPU           := -mfpu=64
>> +CC_FLAGS_NO_FPU                := -msoft-float
> We will add LoongArch32 support later, maybe it should be -mfpu=32 in
> that case, and do other archs have the case that only support FP32?

Do you mean that LoongArch32 does not support double-precision FP in hardware?
At least both of the consumers in this series use double-precision, so my first
thought is that LoongArch32 could not select ARCH_HAS_KERNEL_FPU_SUPPORT.

Regards,
Samuel

