Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C746DC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 12:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4B28CFC4;
	Wed, 20 Jul 2022 12:50:22 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674C68CFD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 12:50:21 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id b6so10266585wmq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iH4DV4mzOnr0Wqtu8cdfc1pwfzKa6Q9JjoHfrfj4XhE=;
 b=jt3btPi5WFQWy0tLs8rjyNIjOcAXd1Yt4tTq59VSFcxeVn+JQuy7Iig/qPTmjDZ+C/
 5rvqF/oK4wrUoac301GtaRF3juGwN4edRCzyku+0xAKU6HtdMScMC2TGa3YRappzCYtZ
 A4HWMrw5TjjGfNXW0gl2nDiSMIuySskPd5RW7V2lyw53F3RozaWYnvlu/XAuyioL7Y6S
 FHuSkIHseQ32ie9NQmsUjSAWpjdgDlQ9DcUM1/xcTJwqCgNmHK3Ij2DRVwd5evzW2enZ
 BfFa93W6VN9noqQS8GV4aQRA4lYIxyzF/vcHJ+RQ3RrKIxSWPza14PBXjsEaSEKBAq71
 +LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iH4DV4mzOnr0Wqtu8cdfc1pwfzKa6Q9JjoHfrfj4XhE=;
 b=x5ET/GLui7/ag6i/SWYTHFNyCEMJg0Ld/qkaLJj08bWw0aK9LHkXvtWgaLScgAhctO
 PgBCdrHKZUWSqzbQmlRp11ROf2BSyLQ0S0eggGvufZbpHiR+ahn9TJyvpUb17z4gyoXd
 XiNbZF8UofcXWos4YQYwsiBFHGs6OUBbLwp5+PeH11wlcl9iU2itTbA3HfPsF03uaRfR
 5xgvLIdPttdi4XTbjwKh8T+JDj9lq2ObjiHHei97YhDCK+d9WWZGcCyC4VArex2K7pKr
 /eeaXacJo1/5tM7xxFuf4TYt7izVHPBN8ZXgFNd6gbbBtf4cLEVkF8rXwqaWk2LP71YX
 ZQBA==
X-Gm-Message-State: AJIora926VnX2r5hW1hxVfxWoI9so9mDoAWRrrlWXhwIO+CPUw/16Ekq
 sV3Nd6WL+1OmVmEJx7OBKFIOovgwxEw=
X-Google-Smtp-Source: AGRyM1ulK9gelPI93HM9Vj88U7x9T0ijyJAUb0WsaL6fnCWtsXum+SlJ7zsXiH5qcUksEVHMef3utw==
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr1870763wmq.145.1658321419990; 
 Wed, 20 Jul 2022 05:50:19 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:c3a3:a774:9c4e:7491?
 ([2a02:908:1256:79a0:c3a3:a774:9c4e:7491])
 by smtp.gmail.com with ESMTPSA id
 m184-20020a1c26c1000000b003a04722d745sm2336642wmm.23.2022.07.20.05.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jul 2022 05:50:19 -0700 (PDT)
Message-ID: <ee4e323a-38c6-208c-417b-d3101aeee067@gmail.com>
Date: Wed, 20 Jul 2022 14:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: drop non-necessary call trace dump
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220720090640.47497-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220720090640.47497-1-evan.quan@amd.com>
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
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.07.22 um 11:06 schrieb Evan Quan:
> This extra call trace dump comes out in every gpu reset.
> And it gives people a wrong impression that something
> went wrong. Although actually there was not.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I884af405b6b3cd52b9024408a21fd39811a01f4d

Acked-by: Christian König <christian.koenig@amd.com>

And please guys don't add calls to dump_stack() in the future. That's 
really not supposed to be here.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b79ee4ffb879..1b1a70a6da18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4667,7 +4667,6 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   	int i;
>   
>   	lockdep_assert_held(&adev->reset_domain->sem);
> -	dump_stack();
>   
>   	for (i = 0; i < adev->num_regs; i++) {
>   		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);

