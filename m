Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB43C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267BB60E54
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 267BB60E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F716E8AE;
	Thu, 11 Nov 2021 13:43:05 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36866E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 13:43:04 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id d3so9882760wrh.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9MOmGLXhyJgvzScNkS5DQc5G+Ok5VdlwcZJ5Hw1GFD0=;
 b=p9cZ3+uq/pb/PNgQcGsixqYuwW6hs5Kf9KYyEvwOdPSP61JrrAplWP95PQZ4/rYLLk
 U7YHU8DXQ0hKE0gC2o08yTfU9gmrNTqxZcvppt4wYAoLHn94yIhmvAgFf+mnopcplLNx
 SuF8/NBBteP6fiIT86LCtgKZe7nIvrcLbgJKPxLwZCRzojAVY7GZm7VZUKUASMFg+bJA
 NnOefq9mJehOiKKRGbRoYoZpJRKVpZs/HxPMqAa7qgEgtHORebIIwh0nHQ/yQNZ+pOK8
 x04tfrnilNfbzuXzin1+OmhHQdelf9GUMuOmkfmKMymHGZNLJ0LIQtt6TTjyfewpaQzp
 SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9MOmGLXhyJgvzScNkS5DQc5G+Ok5VdlwcZJ5Hw1GFD0=;
 b=0wR3uIhRgwiYXo/X0sNR/uX/56w7csCICMBQWZ7GDAWdGWzoceVO7U9eRNmhngOToC
 YZ7bgiiux5oVUtqyTJKGqc/hKpyS7C9Jx1grGiwmkMQNb1HSQiHk3Eoo+tS6hRG39U0Q
 MJwYS+IFhdg2iSjB/CBJliMO5sr5lDcevLQFy5I5QyZhjvguXNY12KCmE7d0knpz1KyK
 EsmJME1cPkBfz2m5CBSs2bARAK3dQ+cTM/WMO/aD1SJuNyJtwnXprXpzaIBHX+HXRbEV
 Q5jaPILke+Jl7lUnOEt99U3Nig0piabU2Iqqv8zRl+q0MozSpcaaymBj+da843RipkYY
 yEtA==
X-Gm-Message-State: AOAM531lP4hdipuYGkvjBaxkRwST0VxNsEGATvAUvUFe1Z57HjDqccLO
 iqrpel1yjf5shFi3+vciaQZ3RdoZXp8=
X-Google-Smtp-Source: ABdhPJyDyS2Q8Uggz3KeMj11ibPZZSbIB6JYQ2SncDNjNc7ZiDYzxyPrxWKB+9G3FDMJAK3mT39EKw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr8778175wro.320.1636638183358; 
 Thu, 11 Nov 2021 05:43:03 -0800 (PST)
Received: from [192.168.178.21] (p4fc204a3.dip0.t-ipconnect.de. [79.194.4.163])
 by smtp.gmail.com with ESMTPSA id q4sm3044320wrs.56.2021.11.11.05.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Nov 2021 05:43:02 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, philip yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <5e646384-ce7a-9a80-f97c-ae9592e39bbc@amd.com>
 <6e566851-0372-b33b-011b-197d8321b875@gmail.com>
 <865585bf-84ac-ea2b-7e1d-a13aca7e4caf@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f2005799-7371-9cfd-d3bb-7a531914175e@gmail.com>
Date: Thu, 11 Nov 2021 14:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <865585bf-84ac-ea2b-7e1d-a13aca7e4caf@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 11.11.21 um 13:13 schrieb Felix Kuehling:
> Am 2021-11-11 um 2:00 a.m. schrieb Christian König:
>> Am 11.11.21 um 00:36 schrieb Felix Kuehling:
>>> On 2021-11-10 9:31 a.m., Christian König wrote:
>>> [SNIP]
>>> Aren't we processing interrupts out-of-order in this case. We're
>>> processing newer ones before older ones. Is that the root of the
>>> problem because it confuses our interrupt draining function?
>> Good point.
>>
>>> Maybe we need to detect overflows in the interrupt draining function
>>> to make it wait longer in that case.
>> Ideally we should use something which is completely separate from all
>> those implementation details.
>>
>> Like for example using the timestamp or a separate indicator/counter
>> instead.
> Even a timestamp will be broken if the interrupt processing function
> handles interrupts out of order.

We can easily detect if the timestamp is going backwards and so filter 
out stale entries.

> I think we need a different amdgpu_ih_process function for IH ring 1 the
> way we set it up to handle overflows. Because IH is just overwriting
> older entries, and we can't read entire IH entries atomically, we have
> to use a watermark. If IH WPTR passes the watermark, we have to consider
> the ring overflowed and reset our RPTR. We have to set RPTR far enough
> "ahead" of the current WPTR to make sure WPTR is under the watermark.
> And the watermark needs to be low enough to ensure amdgpu_irq_dispatch
> can read out the next IH entry before the WPTR catches up with the RPTR.
>
> Since we don't read the WPTR on every iteration, and out page fault
> handling code can take quite a while to process one fault, the watermark
> needs to provide a lot of buffer. Maybe we also need to read the WPTR
> register more frequently if the last read was more than a jiffy ago.

I think trying to solve that with the IH code or hardware is the 
completely wrong approach.

As I said before we need to something more robust and using the 
timestamp sounds like the most logical approach to me.

The only alternative I can see would be to have a hardware assisted flag 
which tells you if you had an overflow or not like we have for IH ring 0.

E.g. something like the following:
1. Copy the next N IV from the RPTR location.
2. Get the current WPTR.
3. If the overflow bit in the WPTR is set update the RPTR to something 
like WPTR+window, clear the overflow bit and repeat at #1.
4. Process the valid IVs.

The down side is that we are loosing a lot of IVs with that. That is 
probably ok for the current approach, but most likely a bad idea if we 
enable the CAM.

Regards,
Christian.

>
> Whenever an overflow (over the watermark) is detected, we can set a
> sticky overflow bit that our page fault handling code can use to clean
> up. E.g. once we start using the CAM filter, we'll have to invalidate
> all CAM entries when this happens (although I'd expect overflows to
> become impossible once we enable the CAM filter).
>
> Thanks,
>    Felix
>

