Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD21C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 11:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B316128B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 11:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8B316128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5476E916;
	Wed, 15 Sep 2021 11:47:19 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEBF6E916
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 11:47:18 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id q26so3399284wrc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Rd3hprGUgWmyfJvv1oVwA/PAdgALCOp/mN/hEBiQcRY=;
 b=V+MFauo1AQjpA+2UwC7e2kze0t/ZKs5lX82aPOiGKDlCfHMZzAKmkydf9CR7+Od7SB
 67wGHTdheRRV3MP+CdfyxHmyfCsqEacoGvvEQ9Q0edRJBIa8NUyzG8kIjpRTnx4s13rc
 mDQTfeQ1IA4UYHjcI/v1YccZLJCw+kF2oJAzD6Z6fbABVHq1QQ4ZV2gDPwS7ESrgRMum
 pcaU/ipji33F/JE/XKn0G03LbQHNkzNL7iL5bUcCizLyXn1hoOtV0Nf/pLunNkRnkAtA
 G7TD0M76pWLpJBmmWEvri0CYbOzrXoRflqzHqBYXmVOttw5yahqATjDU0kkt6JhWZL8Y
 bKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Rd3hprGUgWmyfJvv1oVwA/PAdgALCOp/mN/hEBiQcRY=;
 b=fCmV2189P07xlZj90GG/+mHx6TaDug1DxvICKQBT2eG4OUDoINtqYcHbWerRcTFDpV
 1bWXJMuMhqjkF9ZxyzZU/lCB/tR2DE0spam3CsLZewCdtHWfOeontz715VJCS5ztHZf+
 /myxWCNuuNCG1he1UVZMBTfVywAryoKGpYTfsvmhF7j0p3C4kPV2Oh0RZIFOa4hLlcXd
 x6NF/Z/TM/pCyilkRcr7aPko3BabxUkYWue5Wyhvn20KwgKbBamFItjL38Dq5QllMc+N
 kCLU2ly0z+OBqv8/yds+U6SmrhwJpJkQDd8JMK0VUdxSzwNHkxKdfFXYMQw1rufic6xV
 APTw==
X-Gm-Message-State: AOAM533FTDfESP3dvokiPepUQ8/s7UMDXaU9xSAm7mbICwNBDxuWZEfa
 UW6TXPvM2HDjm9FA/CaCD+TyXpvOQmA=
X-Google-Smtp-Source: ABdhPJw2AcPgaxu2NmFlPoU8WbyQQ+p+Tczq8dH6o8GcWk25V4UH5lrnx7zcughAUwxir68NtEpH5A==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr4718448wrd.24.1631706436828; 
 Wed, 15 Sep 2021 04:47:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d03d:8939:3840:1f95?
 ([2a02:908:1252:fb60:d03d:8939:3840:1f95])
 by smtp.gmail.com with ESMTPSA id b204sm2703850wmb.3.2021.09.15.04.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 04:47:16 -0700 (PDT)
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
 <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
 <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e120f0a4-7600-c938-ac9f-cce6a714da4e@gmail.com>
Date: Wed, 15 Sep 2021 13:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
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



Am 15.09.21 um 12:36 schrieb Mikhail Gavrilov:
> On Wed, 15 Sept 2021 at 14:55, Christian König <christian.koenig@amd.com> wrote:
>> Yes, absolutely. You should see GPU resets and recovery in the system log after that.
> Unfortunately, not one DE will survive a GPU reset. All applications
> will terminate abnormally in fact this would be equivalent to reboot
> (and denial of service). :(

Yeah, very well known bug in the DEs.

The OpenGL robustness extension and Vulkan specification are pretty 
clear what drivers are supposed to do in such a situation, it's just not 
very well handled in userspace.

Regards,
Christian.
