Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC6C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2013B20848
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwCkCT6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2013B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF99D6EE2E;
	Tue, 11 Feb 2020 11:39:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F266EE2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:39:33 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z3so11963644wru.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=froL+qLihQcN9A2+zcbSmTnp2TA1NNYhl9loJe76Xfw=;
 b=LwCkCT6SztRcHE5PGnsK41Mo6pwTDFY5nmxaW/iSIjmUMf/H6Y2VoQ1ApJJQGJ+lVp
 z6hTVbEYwNhekU5bOiNVhCl24ok9Xf9At6/ZdANjgV2l8Xj1b5eoVhEMVJAWsrb/Mysw
 obDswYnRAke7q7QvW1lyQLQWkPy6rYkevJpF+oywNljQfjFaEsHrxHkNMFMLPrI+FJ3a
 3PB1iJUeQzR44KfZ9thUsqACdcZMoQiXwSLDBrDb7dVNwyKq7bAxIawPS2aoD8I/nZO0
 8OsGQRha7Q0Az7VUGtgkyJp8iSN3aInDhdmZ5FDJtLyV7EllI2TD+/8BecxavSDJJ5G+
 tlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=froL+qLihQcN9A2+zcbSmTnp2TA1NNYhl9loJe76Xfw=;
 b=EoLo7ChlCcfSdAYj34+M6293o7xRcFUULtcqvjXktNRZvHPAgb2i2L0VKyNLE0Yd54
 IjIAaBPCV/KIXEYmOpkRT64iMm17CtI0zA6gmA5nxivODfZelxKtAsye4auLcYgiyNBL
 r3W9TwNRvALQJfGkScuikHYW2Xe0LrZ3CVUxzh/ScYG3CK/0yjNAxGyM7Ubtqj/mtAcz
 gjl6PtUyR92nfc3K+Q8nczhbOoBrBX2GFrRG9IxXEOndsAGEBFTEALPKWrw0f+f+p9H9
 7y6VDsD0+4NFV0sm/gghVV7SMbU56o0KyUBp2dOSb4jPSTorrpOL+rlXxUisqWtpDMH4
 Bh3g==
X-Gm-Message-State: APjAAAXnYbGyuMu1WvPHYmVBPh7Xz7sn66dIpelyn3w6r52GtwY/eqvc
 H7Q6BAj7eD/+u5xpnSML9ZY=
X-Google-Smtp-Source: APXvYqyC+ip8lI8EOB1rTZb0/gt1DUk02NYRtNo8feN+4sRRd1E7j8NmfytoekJtLUu8aVx3AksPZQ==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr8149442wru.52.1581421171798;
 Tue, 11 Feb 2020 03:39:31 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v22sm3317316wml.11.2020.02.11.03.39.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 03:39:31 -0800 (PST)
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
Date: Tue, 11 Feb 2020 12:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good on first glance, but Marek and/or Pierre can probably better 
judge than me.

Christian.

Am 11.02.20 um 12:22 schrieb Huang Rui:
> So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdgpu tests
> still use the legacy interface. So we would like to make amdgpu tests verify the
> amdgpu_cs_submit_raw2 API.
>
> Thanks,
> Ray
>
> Huang Rui (4):
>    amdgpu: use alloca for dependencies and sem_dependencies
>    amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submit
>    amdgpu: remove the un-used chunk_array
>    amdgpu: clean up the cs structure variable
>
>   amdgpu/amdgpu_cs.c | 36 +++++++++++++-----------------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
