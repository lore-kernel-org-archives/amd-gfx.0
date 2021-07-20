Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85EC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 06:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7960E61164
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 06:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7960E61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1846E098;
	Tue, 20 Jul 2021 06:17:29 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBB96E098
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 06:17:27 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id i94so24702914wri.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=YUv373TRbJzpXEjq3/HXrealkqxY3Zrlb077s3lFdTo=;
 b=bOgMs8/xCj3eL2F7zv7VyLj1GImGnX1zf134Xe6YHmA2mts3mLnezy0+UqqSc5zAQr
 rZTYdWF62QMA9Y2AQ9c84CetJ/S9098g1PKmMOTPQsf1Z8qHfW59aSXlBo3gZGfnTHAs
 ZMJF69i0jYBhucxfkoNoN6oQ3ljI8kCA9Mzkot6CtiTX0pNx/Ftgc08KVtmq83kRi8TY
 Zu74g2JPRQSTs+Yfhs+fQ8xzLKYK77YcT2p/vvL3UdrjMb503/9KWYdDpS/9mIxAd3+h
 1lt6uIfOVzluOff/N/ZIJVD1o+J/Hnlc6V49Ch8ASNlS94shqy4wgbnAywPZAL56SnHQ
 A5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YUv373TRbJzpXEjq3/HXrealkqxY3Zrlb077s3lFdTo=;
 b=o9DeeBSZp5Iv31s4ehjMcun/UVCo8AsRCHC+Z+dPLB8lkNGzFs4w2xx2nkb+GSlQPO
 rAmrroO9ls9SG50UEvnbcixXuX7R2OId6uB8hQ7zN7Ji/jCJ1OmlIDIXf4cXawvkT/w8
 NpkEfsbST+24Nrl/K3H8UFSdzQOaqMjMGAvHLkRySKKNj9Dwfyrd8+r6TcH8BW+8aj32
 8wyMoUl4r8JZguVnl+QskXDNUHjSdna3s8LeAFwsmsK8j28LQREnJKc+e2w+w4Sf9E5z
 kXTZUj7htiLeOqQ59vxX+1Y30ldfisuTSQ6KrUBn7T8i2OvgD+7/DcqoJl5KyWzxQ0sn
 xnwg==
X-Gm-Message-State: AOAM533RiXuNw3ldm/ZtVGdtpvFG4uC7nyFSNLK4swYbxrnhkxJtUL+S
 RTKyLN4Ej6Nb6Sr2PWpy+Ng=
X-Google-Smtp-Source: ABdhPJwrP8qAYB5H7g+4sskeYriO2f1L15Hn6rZR7pEzSwo+pLKcVZRB8fz5WUDNgJkBh3jw60V5TA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr34880575wrm.413.1626761846576; 
 Mon, 19 Jul 2021 23:17:26 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8651:5b5e:8648:2fd0?
 ([2a02:908:1252:fb60:8651:5b5e:8648:2fd0])
 by smtp.gmail.com with ESMTPSA id o19sm9990450wmr.18.2021.07.19.23.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 23:17:26 -0700 (PDT)
Subject: Re: [RFC 0/2] Add generic FPU api similar to x86
To: Anson Jacob <Anson.Jacob@amd.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org
References: <20210719195211.520428-1-Anson.Jacob@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cd330e45-f8e0-8751-813a-98f1810881c1@gmail.com>
Date: Tue, 20 Jul 2021 08:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719195211.520428-1-Anson.Jacob@amd.com>
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com, bindu.r@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While you already CCed a bunch of people stuff like that needs to go to 
the appropriate mailing list and not just amd-gfx.

Especially LKML so that other core devs can take a look as well.

Regards,
Christian.

Am 19.07.21 um 21:52 schrieb Anson Jacob:
> This is an attempt to have generic FPU enable/disable
> calls similar to x86.
> So that we can simplify gpu/drm/amd/display/dc/os_types.h
>
> Also adds FPU correctness logic seen in x86.
>
> Anson Jacob (2):
>    ppc/fpu: Add generic FPU api similar to x86
>    drm/amd/display: Use PPC FPU functions
>
>   arch/powerpc/include/asm/switch_to.h      |  29 ++---
>   arch/powerpc/kernel/process.c             | 130 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/display/dc/os_types.h |  28 +----
>   3 files changed, 139 insertions(+), 48 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
