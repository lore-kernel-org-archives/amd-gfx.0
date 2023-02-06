Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0EDC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 09:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADC810E165;
	Mon,  6 Feb 2023 09:05:27 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F245010E165
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 09:05:25 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id k13so2241480wrh.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1J0JUS1qL9f3qLMn0MlBLAV2XA1i/PE4jSoGrKMow6Q=;
 b=HkFupsagGjFcwVUuzj9Jdev2TdJiXHkupmWZuvpJf7ahnrxk4c6M85+/RM0QHr2+am
 HnbFfY9F/N0oLGeTMiH+zhxm4TuTC8Ftiu/wyds15gaV104w41evRCTknnAtFkevFs4G
 6MNCY8DlHea9tddfnxgxBYBleYCUfuM+7T/tLd85aPiC90VqVtJoXY/AOhlxcdZMeSex
 +9H6YLqgIupNJzVo9xfdoTMNEpfiIY+YRkXlkJikY0AseIeGIFCpqcRjc6ISnpzMiPH2
 nd+I++64QTd+IFYrXaHVn35EQtaLa/QW7F/wGFtyFTSgYvd1FkAg8lek63wlTPphXAT9
 13bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J0JUS1qL9f3qLMn0MlBLAV2XA1i/PE4jSoGrKMow6Q=;
 b=dTM8mu8NgCF7/zOmJ+5DLRtaPOb8Aqfac4CyN+53bIyIto3Q9Uw77G8akquJGGOyMx
 bICH/+RQh3ECqKlglEmItSN/MfYU+RCty7/Wi8wpYFvQUPIaTaFABjgLHN1nwX4cP5sS
 s2OWwtCO8nX/way2NWkfBjuO/Y8rRh3YTRLDLHN1QS7g+gY2ksUFE1GFRcXfaQT+kDZG
 3uI7Qo7NAII/6JWFzPW7nzDYzD34H4TERUprk/lU7H3CQMR/c59J7yf7CcskvDDyDI+a
 KvyLy9BZs+gIlbLU+24h6UHj6gW8TypavIAYMw9K4uOzEFvK3dQkGkVU2Z7ODb2I6cs4
 7IEQ==
X-Gm-Message-State: AO0yUKV9r9upvPQpEDbj2kwgFlOacMBWgoFsabrrP4HzcOiTAKSN95tZ
 TlRZrXq7Dl7L9D9WZFug82k=
X-Google-Smtp-Source: AK7set9HMZRt8m6DIkQC/uJxaZmX0NbcbIs0qA0k47d/om9RfPy0JxqpVPqxPhR3XD5XmWptZehq7Q==
X-Received: by 2002:a05:6000:1ce:b0:2bf:bf32:70c with SMTP id
 t14-20020a05600001ce00b002bfbf32070cmr14839172wrx.47.1675674324535; 
 Mon, 06 Feb 2023 01:05:24 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d6e8a000000b002bdda9856b5sm8336379wrz.50.2023.02.06.01.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 01:05:24 -0800 (PST)
Message-ID: <3c2f16a9-64f2-9124-afc4-43af37fb82fa@gmail.com>
Date: Mon, 6 Feb 2023 10:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: expose more memory stats in fdinfo
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A6Y=++EP8vqzqjGQ3kfh2=JC7PKGoyJvfw9pFVL2UcNJg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A6Y=++EP8vqzqjGQ3kfh2=JC7PKGoyJvfw9pFVL2UcNJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Just two nit picks:

+    seq_printf(m, "drm-evicted-visible-vram:\t%llu KiB\n",
+           stats.evicted_visible_vram/1024UL);

For the values not standardized for all DRM drivers we might want to use 
amd as prefix here instead of drm.

+    uint64_t requested_gtt;        /* how much userspace asked for */

We used to have automated checkers complaining about comments after members.

Kerneldoc complicent comments look like this:

                 /* @timestamp replaced by @rcu on dma_fence_release() */
                 struct rcu_head rcu;

Apart from that looks good to me.

Regards,
Christian.

Am 30.01.23 um 07:56 schrieb Marek Olšák:
> Hi,
>
> This will be used for performance investigations. The patch is attached.
>
> Thanks,
> Marek

