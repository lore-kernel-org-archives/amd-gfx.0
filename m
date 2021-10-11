Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8903360C4B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8903360C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BA66E441;
	Mon, 11 Oct 2021 08:33:33 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45B66E441
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:33:31 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id e3so19921179wrc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=fYW63GZTQny6QMG3gXPhN2/jn8ltuKIHPE96zCtv1JE=;
 b=LOzj2oyz8ClsrZLLGTfohl5RH94KltQ/W63fVzA2HNOfQF1PSjUd28EH8P7bdewl1M
 +sQJHlSImS9zUBaS3xvAH/xBsSc3da8qi/R5EwYNhil1Io7+0KyRDkoc2+NmmrBrAHRq
 O3EUWYRlMU4GfCpDyf580cy2+SwEMGczkAsYfK/kNoDl5f19cz5DSLucZqmFnxtgafCI
 lNs41zpBdsLUdbHx+JIIpeL5EoC76JkewTRRaIqDu8wGQtHJTpyuniM3PgYHwp3dr34w
 lCB+9/QxlVQehQsCXMwrIogEi8N+B70VAuiB9kNAoS0hMhbo+4y/bwxDQXVvLcgze3mM
 UZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fYW63GZTQny6QMG3gXPhN2/jn8ltuKIHPE96zCtv1JE=;
 b=XZjHM1+skpRfV/NmYTEoD3xyebRZgtV6voUS77w6ROH70PawstnafGabdMfQdYwqO9
 okpJbmStbpXPjEiDiEDLmGqkG+xf2WNPAsAOy9Yni3lnC/k85clNJN2imnlu5E5/UzQD
 SWDVsyW69khDN2KIW80ZbfUb1jJD4QnS5X3VqoBaR1BfwgVgC0nvTLq4Lz1e/tln0P6S
 0zqPxym4+NF9K1SzghU1Pi1DgrVmua8nDSeWkKHjxL4Wyso4XCmhIPNCG936T9ZZ25ef
 WYpVZakjWs5E/yDFnbjxkjJfWaA8qSFuak2uXMrR24zrbeTd0ZOQ/43FS+tGgrDxs6h4
 DpQQ==
X-Gm-Message-State: AOAM533baiTxA8yARsOqXQKL1JDBLmULNwAI2TrSZYMdjV1qD8AVehXA
 Z7m0uKfD1Rn7jYUfRvKIBCg=
X-Google-Smtp-Source: ABdhPJz87O/VXG/DVPz860A9Or0XPO45xjEWDUsxJC0gfFK0dpdz2EpfnUZJBSGQ4OyKkgsLP214HQ==
X-Received: by 2002:a05:6000:1681:: with SMTP id
 y1mr22721553wrd.340.1633941210274; 
 Mon, 11 Oct 2021 01:33:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a75c:41fc:3f29:351c?
 ([2a02:908:1252:fb60:a75c:41fc:3f29:351c])
 by smtp.gmail.com with ESMTPSA id f17sm7652852wru.69.2021.10.11.01.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Oct 2021 01:33:29 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Siqueira for AMD DC
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 rodrigo.siqueira@amd.com
References: <20211008212122.230566-1-harry.wentland@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b959093f-3000-82de-402c-e0e6b32184fe@gmail.com>
Date: Mon, 11 Oct 2021 10:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008212122.230566-1-harry.wentland@amd.com>
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

Am 08.10.21 um 23:21 schrieb Harry Wentland:
> He's been helping maintain it for quite a while now. Make
> it official.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24d520c4b157..b107ddb306de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,6 +876,7 @@ F:	include/uapi/linux/psp-sev.h
>   AMD DISPLAY CORE
>   M:	Harry Wentland <harry.wentland@amd.com>
>   M:	Leo Li <sunpeng.li@amd.com>
> +M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>   L:	amd-gfx@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/agd5f/linux.git

