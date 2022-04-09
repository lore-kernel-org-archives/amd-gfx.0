Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AF2C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 14:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72ACC10E8DA;
	Sat,  9 Apr 2022 14:27:21 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFBE10E504
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 14:27:19 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id q26so13055931edc.7
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Apr 2022 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=VnRqAxbBSJiOT0qnggIVf3Uo/0FEFMXAxgN78+BZAGA=;
 b=kwBSLc6wR8xpV8lonIJ07GU/O0s570O8AqLJ9/YhVJx3j0vrexLv1sPXKQUIu+YB5m
 Z/l1QRYCYKshHTLufUNZYr5SjhLhUas6xPBvR5nI9zWlr4u+q5Y00pUswmG8ce67QLjy
 8fY8d6JJDvuWvmm7tKcBbY5f/JZNvWXrWdv9cqn2QnOJwdm4aVn3yX0ePzJgBkCQDsaI
 cW7rVwZtD5fH8Bcmy5PHrRrrSr4+Vo9KcvOTBVEW2zI8qG/qQNotURH9lHdhuZ04VmPO
 go3KKcPU35O9/ZRly0kJBroHo9qI27wr0HzfmiLI4k4Vie+jSlwSbEeMDK/DK5KWiQ5u
 A2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VnRqAxbBSJiOT0qnggIVf3Uo/0FEFMXAxgN78+BZAGA=;
 b=Lb8xI3lmsUoI5e7LTmhur9wFM3hrBajJanXaAsDEK7AqwfnCW1avxFkVQYaa88ARCL
 S5Pi7NWRT6jXqlZYUe7h5ctG1YMsd6OczGyUWht30Ye8vp9JIgXSkOaCMM4EO1iAAiN9
 FAzI99/qxBE960f7j7H0BmeX/XevopGDuKIS+ea+8yz7g75bf9XxcKKPqnYCpssWqzQ/
 s2tl0h26m03xI2n3kx4ZOezjPPdxMQHWPhg2MsIFabs9EWIGR7TIWgpMKAA+tn59W9oL
 yrOBtdOf7LAZwsOyBA1konlQoVTeQRDdhdRrhGJxbdmaOjGMmm0mVIJvJVr6dQvj8lRW
 mM/w==
X-Gm-Message-State: AOAM532C7B7B1sBQQ++xCCVAc7b+V1IM9QqeCwJZqjKwnexANwPd3bt3
 wFSoKkIobLaddSF+jK/OkzbErChNBbE=
X-Google-Smtp-Source: ABdhPJzTUgfQOGe92yo7zilHLXxu6T6oEquhi3ZjKO0CdO2hjB40oOgTPTVfjPB2CJk0W/EIuH/8Dw==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id
 y13-20020a056402440d00b004129e8a5e51mr24747197eda.362.1649514438081; 
 Sat, 09 Apr 2022 07:27:18 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:1f4f:2923:d7f1:41f2?
 ([2a02:908:1252:fb60:1f4f:2923:d7f1:41f2])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a170906468c00b006e874be7420sm553215ejr.60.2022.04.09.07.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Apr 2022 07:27:17 -0700 (PDT)
Message-ID: <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
Date: Sat, 9 Apr 2022 16:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
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
Cc: thomas.hellstrom@linux.intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.04.22 um 19:25 schrieb Mikhail Gavrilov:
> On Fri, 8 Apr 2022 at 19:27, Christian König <christian.koenig@amd.com> wrote:
>> Please test the attached patch, it just re-introduce the lock without
>> doing much else.
>>
>> And does your branch contain the following patch:
>>
>> commit d18b8eadd83e3d8d63a45f9479478640dbcfca02
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Wed Feb 23 14:35:31 2022 +0100
>>
>>       drm/amdgpu: install ctx entities with cmpxchg
>>
>>       Since we removed the context lock we need to make sure that not two
>> threads
>>       are trying to install an entity at the same time.
>>
>>       Signed-off-by: Christian König <christian.koenig@amd.com>
>>       Fixes: 461fa7b0ac565e ("drm/amdgpu: remove ctx->lock")
>>       Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> The all listed games are now working with an attached patch.
> Also flood messages "WARNING: CPU: 31 PID: 51848 at
> drivers/dma-buf/dma-fence-array.c:191
> dma_fence_array_create+0x101/0x120" has gone.

That's unfortunately not the end of the story.

This is fixing your problem, but reintroducing the original problem that 
we call the syncobj with a lock held which can crash badly as well.

Going to take a closer look on Monday. I hope you can test a few more 
patches to help narrow down what's actually going wrong here.

Thanks,
Christian.

>
> Thanks.
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>

