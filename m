Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C8C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 13:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED712070A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBZcnIrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED712070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538E56EA61;
	Tue, 11 Feb 2020 13:41:57 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8326EA61;
 Tue, 11 Feb 2020 13:41:56 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id t2so12466115wrr.1;
 Tue, 11 Feb 2020 05:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aLTztAKkbiINClh1/1dtfsKqGpvUdnYEQYdommfKl2g=;
 b=UBZcnIrSqe2YgQbhrA2MeXR+Kl5wNYB4TzvGgxCjc5Jztarvzl6Q/VlnNvm7twsJ99
 SyJjawJE3hMWiy38MH2Bv6XuGCqWRP/4nmoH4BdWb7fg+KD3XhVqESceGlpizsR4p+MN
 N/MqRXUPDYzhZ8qP0BoYQVUv7KUE4WPjmYv1PdjmTmcEZnkBfW79r6a7FIzmSztWo6Ri
 OgC1phGk/tDcaVsPXzhzUANQ2CF7RVi3z6ZBRE2l4gLvYJZQiYw3q7pVblyXyjAUb2Vl
 0ijZEvCw1jVNcpbMLLn8g69UkQx0YatHGJ3NYGR93O+a/v2BB5Qq6sefhysGZmxUjA6U
 fEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=aLTztAKkbiINClh1/1dtfsKqGpvUdnYEQYdommfKl2g=;
 b=qSmpPCbNHKk3Ipak4RwhFyKoxmbvi5f2J3JaCGIeOtVORjAc5Y2bEqVot1Uul/hT4C
 5out99QqWncR8hxna/5WWQVTgjEWuXWpiO7xKrSg51Ga69De2EHI49m/LZ4YBAXXxedn
 WhUOa2AR6vgeuI+4/ogVWTLojb7WRXDpwPHUwtzDTGzfadaZTbcdnj/dcFTO+cGk7s2Q
 XrMUJhqUEosNCXBqWwlfTgYp9IfeyLxO4weeGYJPrNP+47JQF5A2E54wYPs3LXquFBYb
 8+M5QRaI3ckw+Dw4hqibq/HylFlBlWjOdOlX2GrWXgTC1g3qPFk4J7cwlyGif0xbzF6Z
 Xfzg==
X-Gm-Message-State: APjAAAWiZ/ek2PVWx4/baS6v1ICAsQvP9lAiteVhGiImTrnGRIYsLoon
 idPGKDO7NUb2AH04+syuyE6QUUKI
X-Google-Smtp-Source: APXvYqxnSNrWsOGcb4NZESPQHzopVnS53basUptDy6YbgBIQL/oQswl6qfQXQW+t3TUSsy2ehMhd1Q==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr8951251wrs.143.1581428515208; 
 Tue, 11 Feb 2020 05:41:55 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b17sm5558921wrp.49.2020.02.11.05.41.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 05:41:54 -0800 (PST)
Subject: Re: [PATCH 4/6] drm/ttm: rework BO delayed delete.
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200210150907.20616-1-christian.koenig@amd.com>
 <20200210150907.20616-5-christian.koenig@amd.com>
 <865D83C5-2752-4D2C-B0F8-66CA0B1B0203@amd.com>
 <4C763419-ABC5-4890-BFE4-02DDAD89C0BA@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <40bbab73-7258-0d89-cf41-5a57fba6015f@gmail.com>
Date: Tue, 11 Feb 2020 14:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4C763419-ABC5-4890-BFE4-02DDAD89C0BA@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[SNIP]
>>> +		/*
>>> +		 * Make NO_EVICT bos immediately available to
>>> +		 * shrinkers, now that they are queued for
>>> +		 * destruction.
>>> +		 */
>>> +		if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT) {
>>> +			bo->mem.placement &= ~TTM_PL_FLAG_NO_EVICT;
>>> +			ttm_bo_move_to_lru_tail(bo, NULL);
>> [xh] this should be under lru lock.

Ah, yes good point.

>>
>>> +	BUG_ON(bo->mem.mm_node != NULL);
>>> +	ttm_tt_destroy(bo->ttm);
>> [xh] already destroy it in ttm_bo_cleanup_memtype_use.

Fixed as well.

Going to send that out with those two fixed in a minute.

Thanks,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
