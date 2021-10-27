Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A9BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0618460720
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0618460720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2C86E5C0;
	Wed, 27 Oct 2021 14:35:04 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B716E5BF;
 Wed, 27 Oct 2021 14:35:02 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id m22so4640575wrb.0;
 Wed, 27 Oct 2021 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=+E1SJLSdArAsZtkp/v7OuzkWQxv+Z0nONOEXraLGZhk=;
 b=Rwb+cbwEpL56R7PI3JueevN0x1Iyrk8N4y9L6mXlGE7SOhpfr41jUvGYsqe4BEd7IZ
 R2HbO5oL+GaBgVTLJEGp7QFnurF7TmqfZs1mCyPr66KxQCRwPKxYUHWqOb2A6W6vmjFL
 X0218J/olPCUJ7u6SQ6LA9XJaZcZSD6RHpDx+gd3HKYh1rFr3+uK4xy3Ob/T+lVNkHmX
 eQfxdwjDZ4MjydMfWD64+g7F/UoqFXmOg2R+I+ntCWzTMnY2GoIjAMbW9hI33fhADf7j
 W4+QSDjxk7y94f41QJwohgScI1ZxDY2ygtOYrFy5iv0QvZX4pvzSrxKilVZf/fbh0uDo
 7n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+E1SJLSdArAsZtkp/v7OuzkWQxv+Z0nONOEXraLGZhk=;
 b=GllLvBeCruTHwufojMA5sghN1zbfmkQZrwZ0rpo3OUI/G+pgLJok68m80N81LkxVhT
 BTwW1vdayOjbW+Qa2NLAOhya5zhPtK2D8dqjiWxdHO5/LBs8YabY0S71fRdsetrEP0A6
 5bjum9iLDgCx06xml3pwISDjD8UegbdU7xMMqDYdaILHPn7tWIbjJBXqPD+xPiFHUyGx
 ZuaK88kDB+jmPxRavaDzPSFXllTPtZYcmBFe8lBhqjnhf/7fshcSQ4hEs+O7DhePb0QN
 YBFvUuIti/N72FXQ/RzoBYYLCdmA8zMyOfhN98ZmetvHtgZ8fFnKOlvJsLnVYb6RkHMH
 mI4Q==
X-Gm-Message-State: AOAM533XClbm6XZuL2R9HGue6LxON7eYVW4MPVPbT6Dg6Qk69Hj7kzrQ
 +dpE7U/nS9a9zA0l3pOEGaM=
X-Google-Smtp-Source: ABdhPJyaxZ70+HbZx9sb+hVFjSw9chccyuTGkGofNDWPphmJZLndfIjPAGMUu0Xoe+l0LoUvO1HT2w==
X-Received: by 2002:adf:b604:: with SMTP id f4mr41266121wre.111.1635345301155; 
 Wed, 27 Oct 2021 07:35:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1ffc:9265:7616:2569?
 ([2a02:908:1252:fb60:1ffc:9265:7616:2569])
 by smtp.gmail.com with ESMTPSA id t6sm35124wrw.78.2021.10.27.07.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 07:35:00 -0700 (PDT)
Subject: Re: Lockdep spalt on killing a processes
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, chris@chris-wilson.co.uk,
 "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>
References: <73c163b4-1917-1cde-b75f-831ac66f6ea0@amd.com>
 <2090e8e6-4b0a-4b75-a776-64dde1ecdfd5@amd.com>
 <152adb05-e863-525a-f586-ecccb39a4724@gmail.com>
 <5e67d2d2-f5ce-2669-6ad9-7e40c74ce853@amd.com>
 <696ac3f9-4b45-b8a5-5300-79093d2cd1a5@amd.com>
 <2639d027-b6c8-ee09-5e9a-564308949c53@amd.com>
 <cbeac930-84c3-7a62-0b3d-4cef3074139d@gmail.com>
 <da1ed5da-59ad-d12a-906c-c84b7462d8c4@amd.com>
 <bb70e916-e71b-9968-78d9-d7de8fef9e91@amd.com>
 <5c70c6a9-8867-506a-1e7b-32f85589a070@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c5fc1be1-eaec-a57c-79ee-9a63123ed9a2@gmail.com>
Date: Wed, 27 Oct 2021 16:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5c70c6a9-8867-506a-1e7b-32f85589a070@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 27.10.21 um 16:27 schrieb Andrey Grodzovsky:
> [SNIP]
>>
>>> Let me please know if I am still missing some point of yours.
>>
>> Well, I mean we need to be able to handle this for all drivers.
>
>
> For sure, but as i said above in my opinion we need to change only for 
> those drivers that don't use the _locked version.

And that absolutely won't work.

See the dma_fence is a contract between drivers, so you need the same 
calling convention between all drivers.

Either we always call the callback with the lock held or we always call 
it without the lock, but sometimes like that and sometimes otherwise 
won't work.

Christian.

>
> Andrey

