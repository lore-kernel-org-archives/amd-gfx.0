Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F029C7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C057710E248;
	Mon, 12 Jun 2023 13:16:50 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD1B10E232;
 Mon, 12 Jun 2023 13:16:48 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-51f64817809so520710a12.1; 
 Mon, 12 Jun 2023 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686575807; x=1689167807;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eA2sr1M9c34UdOdZs+TMXPtvn4Llqwatvd3QJKT+LE8=;
 b=R7eAdajXSu82dALhdSYhTgUQBq6Th11vhQedZIhWyY8sFSKsyaUMYvrRVMroq3l2yN
 40IlM1PFgpf1rBRCvRMQP+W0Ae2zBiY2RcNpaJb1/w0ISK5kwC/U9jXP4MFW/qMvLQgL
 j115wKXdZT4NecUzOk09FQuYW9juwzTc30bGRqoC3sHjJ8oibytZANBqnKK7ZIexzrtR
 AAGFkN2pRXa4rEJCbOw7UtcuPH2dGMrMDXHfR85j2u5bdgZmuBzKYzxXOZNU4OrMBnwL
 dfllP7ws1a5OBM1IITRYHnQzArHBmiCfNPedeNqHzy9zICxeJcnh1dOOcBVCp0yDyJwR
 r/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686575807; x=1689167807;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eA2sr1M9c34UdOdZs+TMXPtvn4Llqwatvd3QJKT+LE8=;
 b=kHi5o81XYHooUFOy4kqjlT72LP0kjtUe2GyWDT/veekL6eOW+cwApaOgyonyrjx/K+
 M0de3c83j5SRTL+sUtAP7BN26+c0iEZkZ249u0z+EbO7oj3Juds5qDcg/Y5LzihGCNjZ
 mJt4e1mWaB99w3C0dmbTySVWsTeGIJnAewft7YBWattDVQza5JaOb878mLJEIM8JFqCv
 mLjBEvogaPXNWWHv+0ZGarOwKrLFP84owR4U3WDjD0mhGUByUh9aMBapPvr0vCxXDQGs
 G6NsGu95sX31/zqrK2C//ma4daPOeU2V/BOS5atFuhWhs16sBMKOAVF1LerL0l/9ZNh+
 SKvg==
X-Gm-Message-State: AC+VfDy1khJy6DLZBozXWNLj0FsxTmjHwL/ZIi4/9uRAYIKszlQcrZdY
 ddO+9ub2MEn+LBwqhrp12n3aZMjL7sL5pQZW
X-Google-Smtp-Source: ACHHUZ6Z3JKGscE4hKMtJF0Tp2D9XM4/xwQMzFLQgnGfOE7kFjtOmSyJgtJf5fQZRf3XbcyevFAd2w==
X-Received: by 2002:a17:90b:3a86:b0:23b:4bce:97de with SMTP id
 om6-20020a17090b3a8600b0023b4bce97demr10167931pjb.4.1686575807463; 
 Mon, 12 Jun 2023 06:16:47 -0700 (PDT)
Received: from [10.104.2.174] (zz20184013906F627101.userreverse.dion.ne.jp.
 [111.98.113.1]) by smtp.gmail.com with ESMTPSA id
 iw5-20020a170903044500b001b3ddff2b4csm851075plb.120.2023.06.12.06.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 06:16:46 -0700 (PDT)
Message-ID: <a82c1578-a920-2f8a-7e53-edf615d6c4ee@gmail.com>
Date: Mon, 12 Jun 2023 22:16:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Subject: Re: [PATCH 06/13] drm/amdgpu: use the new drm_exec object for CS v2
To: ckoenig.leichtzumerken@gmail.com
References: <20230504115159.2245-7-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20230504115159.2245-7-christian.koenig@amd.com>
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
Cc: arunpravin.paneerselvam@amd.com, felix.kuehling@amd.com,
 francois.dugast@intel.com, dri-devel@lists.freedesktop.org,
 luben.tuikov@amd.com, dakr@redhat.com, amd-gfx@lists.freedesktop.org,
 thomas_os@shipmail.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Chrisitan,
> On May 4, 2023, at 20:51, Christian König <ckoenig.leichtzumerken@gmail.com  <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> Use the new component here as well and remove the old handling.
>
> v2: drop dupplicate handling

It seems that after dropping the duplicate handling, locking of VM PDs on global BO list is basically broken everywhere,
as bo->tbo.base.resv == vm->root.bo->tbo.base.resv for AMDGPU_GEM_CREATE_VM_ALWAYS_VALID

Perhaps we need to bring dup handling back?

Tatsuyuki

