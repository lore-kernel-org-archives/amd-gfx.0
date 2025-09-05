Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E5ECA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 07:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3CF10E46B;
	Mon,  8 Sep 2025 07:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bsDe8uhh";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ACF10EBAA
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 13:49:16 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so341713966b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757080155; x=1757684955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2v3SNAvl9c4lDwixvSiurUh+pklIj8Im2YiYVg2Us6U=;
 b=bsDe8uhhiZuWRSTAR6vT6si2eYfkEBXKE4hKt9P+Q5tbSvQQFsThQx/fjZcfSedEj5
 7UOMIYwLFNNrtGGYulMmvwHAeF4vU4TZ8LzKNBRX2LlHwCzpBHavh6RvHdrsEk4ndwO5
 nQS4EEC2eeM4i8qFW3FpFal1QfQGK1yBqgglygfZrZaqUFdv/pDYVCF1nUPLs512Aagx
 ZKlrfEUHEr/+KpDcbYe7LUjrJGYDbkMcIO8CKIg1BZ2hIS9hT5gv8oH8CDuXlx73blYC
 1cAMZAvg9wBsn3/6447O9v2JuAxzy3JM+jaCWvinb2KvDh+6v5U5aAm2KZRdFjcD9u9h
 5TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757080155; x=1757684955;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v3SNAvl9c4lDwixvSiurUh+pklIj8Im2YiYVg2Us6U=;
 b=tq+HGSFvB3fWYmRg/VCS6OGo/wV6qPhTt7+7f4R3xAe3pZWXnYJdXIcJamahPIQDii
 246v3iFApYeZ/Strps4xs1vFk4Qwnft9yHdp6WUrZzMxY+jwXYJGTo8cAcmpf9uImgPN
 xpzmRNqibKuD7/Ji9aq0gA2S4g2Nby4a8I+jAzusEDBNZsWTs7LqppMggwnTZIW/QRib
 zpXx/9Fhok63J5QE212+ZJfCVuqTJQgnvhMO+fO7Ki3s2nHn47vccmnRmXCWN5GjyiGw
 EoHy3WROSQaOf+S9ISlV42fZhIPHtxWqb1JQZBHr/oQBkWOxdYLgYBe4BTCv7NyMB7TR
 ws+A==
X-Gm-Message-State: AOJu0Yx23/y7taj/TSK/+jfDtn5kvvxCnkkDWr1ejqhSa80yQCRkLu0h
 8pSy2RR2YqmFDPNSDx9uEmK1wcJlmGVBmlgSFOpB14qZj/IjPu9xg0BDWMFsPlF3
X-Gm-Gg: ASbGncsigJHRBHEfeyUF8Q2hHlV0IHQ/qRbHyTHN6aXWJ6jpk1/fkaKJlT0f7HmS2V0
 p8EVSfclTLAsVH+8hVCk4eKk7XILuzNyJW1U9lSbsv8mvDh0jxQ6sigX4rbA5DYAaQ0q9tBlhnU
 THUxB6ltO07Fp9lqZ6WRHWbl8I+2KqAV8/4SMA7RbNdO1vEuVoSKRBvm8wontPyM//YQXXE7jZv
 b8b5yLE4kz8Bt9OrGcwIk+rIckR9ZFEh4vodKsYfiL+OyYntOQq9yO+PdMjjLAnL0guMHsNyR9a
 WnC2it5KYOWRmFTkXkSm4gaXnMq54kG2x0/G5cah7B6/gLsXNyV7X/XVZO6ApWcuH/ICzBYHU+l
 VHYlAmwsOEitvVTzBVRqn6kCDlaje/1XmETwshpICXz7amqlMjYZjuq/mWlEKlNs=
X-Google-Smtp-Source: AGHT+IErHNrCAl8p+9K0a2P+vS64qDYb8mhvPuDjaW8iM2bQbYhhD9CaMGnIeGhymE553tU+qiTieA==
X-Received: by 2002:a17:907:1ca0:b0:b04:6cf7:75d4 with SMTP id
 a640c23a62f3a-b046cf77727mr941612766b.49.1757080154388; 
 Fri, 05 Sep 2025 06:49:14 -0700 (PDT)
Received: from [192.168.0.20] (89-66-79-203.dynamic.play.pl. [89.66.79.203])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff138a8c1dsm1703494666b.99.2025.09.05.06.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 06:49:14 -0700 (PDT)
Message-ID: <86e351f7-c0ce-449d-9b30-25f667c834d4@gmail.com>
Date: Fri, 5 Sep 2025 15:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD HDMI/DP audio broken after suspend since commit
 50e0bae34fa6
To: Mario Limonciello <superm1@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
 <637bdb82-ca3b-4e11-8c59-d8fc75e6837e@kernel.org>
 <6fd5d5e1-2f4a-4640-a88b-8fc66bf54f75@gmail.com>
 <b033c364-476f-4cdd-8823-2a3bbddd9de4@kernel.org>
 <48206da8-c4a6-4b66-bcc9-7599fc891342@gmail.com>
 <13cba029-8c3d-48df-9f76-8b2ed0fff85d@gmail.com>
 <1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org>
Content-Language: pl-PL, en-GB-large
From: =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>
Autocrypt: addr=prz.kopa@gmail.com; keydata=
 xjMEZbtqRhYJKwYBBAHaRw8BAQdAGojMeKfRebJC5+U3Pk20jCWmOv/wtj0kK+7SRlSeasPN
 JVByemVteXPFgmF3IEtvcGEgPHByei5rb3BhQGdtYWlsLmNvbT7CkwQTFgoAOxYhBDwLVsMk
 0R41tYJQaRDBtFqhE5HJBQJlu2pGAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJ
 EBDBtFqhE5HJnxgBAJ2HbntRTvOAMMDWU0h0Gu8Vxn4MMuyKivIcYXX/mXTlAQCE8c1I1bVI
 5ottwyoAcQIYZz8JhiZu/PMW3YID7iMtD844BGW7akYSCisGAQQBl1UBBQEBB0BfitF05Bez
 rVGUMKVNceXhQOEAzBYPQG2t09xWbwuAWQMBCAfCeAQYFgoAIBYhBDwLVsMk0R41tYJQaRDB
 tFqhE5HJBQJlu2pGAhsMAAoJEBDBtFqhE5HJ9YcA/i/SOJkwwYoWJp+sKFOcrPZSVMPvQ9ry
 wk5oemiTzoJVAP0dYnuEMP3N7zP1I5XkS1TToezcTX5Pc/ytafL+1js+Bw==
In-Reply-To: <1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Sep 2025 07:27:03 +0000
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

On 9/5/25 05:37, Mario Limonciello wrote:

> Have a try with this diff on 6.17-rc4.

I confirm that the issue goes away after applying this patch.
