Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7BDC10DC1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA9710EA25;
	Fri,  8 Dec 2023 08:37:03 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351A710E12E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 04:17:04 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cfc3a48ab2so14665767b3.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 20:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702009023; x=1702613823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7vp8x0oDP3EbH3U6bJ7KDFrE+BpYL9j1ysozmjTXzU=;
 b=Wv3cuwhM+D3K7idFle1sQiM/tS8GC7eKR8eBYMFXpcCBBBnDR3OD7KRGncrRrhImhv
 PZd+cb8ECuPMetTJZezws6aSOwOp4JCa20QsiV2Ue3/GAEliT/nudsWpimJqgpJtgibf
 e/+UEbHHwikVM3O4ufZuZbnabc3RojG1OTerQPG2/LFZjA+eCMBB0HXV8rT5/8ICmAgR
 +f+03JTb8ruyM2wsLEkOiteUUb6Q0l1ra8QEMJO71MHWpCWNPVGUGJW+zHYnLy063PDD
 YQc5GjkTxiV0WRYOoF22z7X6EV+zlY1zss/UvMUT3ZYAYf7rxr6Fkb5apwnCDkrZXanf
 0RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702009023; x=1702613823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7vp8x0oDP3EbH3U6bJ7KDFrE+BpYL9j1ysozmjTXzU=;
 b=QnMqm7RcgVj/xoJkqCb9vcvI1cnf/AvaFP3dr//NQtWErE47JJuf5FA/T/OmzQ4BFo
 7YJyxJUTmyDv7BEwatQuSQ2X1jt8xPxJIAqGrYYocoXBwO5BqX7bs54+gK55uT/Dhoh0
 QnS8HEZhRgVwxuWHnDlsXhAFbmCRXhMCYJ9ll+IDvUJn0rnREnnja45kFZoOpX4pY9tx
 Y1N22JIViG2lNevopgqdIfWd4KGeba8vr704x2lIUEAl2n6EdaZWejCTlgSRRBUE0vcZ
 SeI5cPBtO6J7P9lQ+Je7z2NH8xBM0mpQCwhfk87mVCGd2mOZQ2o8O7if4837F98+e8nj
 x2nw==
X-Gm-Message-State: AOJu0YzBax2skgvyT9w1A+ftsHcVS2HLmQb0LWoXmp6fvuV7/CoaeDF3
 4kOS2bLWWavKCx4fGQgDersUJA==
X-Google-Smtp-Source: AGHT+IFJ7rl316vQtE3r+S2OEJohJzfcnMzp0IFjlp1x5P7qNhZsNS2qZXmMmO5ixQp4wMXH8QWNgg==
X-Received: by 2002:a0d:e690:0:b0:5d7:1941:abb with SMTP id
 p138-20020a0de690000000b005d719410abbmr3581208ywe.86.1702009023272; 
 Thu, 07 Dec 2023 20:17:03 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:41c5:bf1:860b:1e95?
 ([2600:1700:2000:b002:41c5:bf1:860b:1e95])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a0ce9c5000000b0067ac1c30e80sm468893qvo.120.2023.12.07.20.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 20:17:02 -0800 (PST)
Message-ID: <86d857bf-a833-4529-aba9-391c49a3550b@sifive.com>
Date: Thu, 7 Dec 2023 22:17:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] riscv: Add support for kernel-mode FPU
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-2-samuel.holland@sifive.com>
 <ZV283NfE/K5zLXDD@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZV283NfE/K5zLXDD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 08 Dec 2023 08:37:01 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Palmer Dabbelt <palmer@dabbelt.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 linux-riscv@lists.infradead.org, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christoph,

On 2023-11-22 2:33 AM, Christoph Hellwig wrote:
> On Tue, Nov 21, 2023 at 07:05:13PM -0800, Samuel Holland wrote:
>> +static inline void kernel_fpu_begin(void)
>> +{
>> +	preempt_disable();
>> +	fstate_save(current, task_pt_regs(current));
>> +	csr_set(CSR_SSTATUS, SR_FS);
>> +}
>> +
>> +static inline void kernel_fpu_end(void)
>> +{
>> +	csr_clear(CSR_SSTATUS, SR_FS);
>> +	fstate_restore(current, task_pt_regs(current));
>> +	preempt_enable();
>> +}
> 
> Is there any critical reason to inline these two?  I'd much rather see
> them out of line and exported instead of the low-level helpers.

No, I will define them out of line in v2.

Regards,
Samuel

