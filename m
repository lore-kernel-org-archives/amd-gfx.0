Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 06:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C57611B52F;
	Fri, 20 May 2022 06:22:43 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C37411B533
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 06:22:43 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id j4so5095774edq.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2qNVFmiF/TTMdfF9KQaUQuxRKJ4iuZ6iN+QlrxgUKnA=;
 b=SFqt9UOrMboZYYQDF1PI76h4elHYHxG9uQtEJeGv3ZvDqDMBr9VzkLWaLhdRXWG2SH
 1+OV1sAY8Wvdbb4ZXAE7Eh3aPpJXBYh7e276E8QCCCTG5NowqLGohiwSS7H/Rztz5Otg
 pklPeKeyiicDHIjwDmwePAzTtGdZxNGc8bqZCIwQ9qebOzQbOYT3XXStluuiQzNYZ0+M
 /gy0KzA1+HEkAzFNAH5aiH6H2FBLjYakLk/CzQaew8o9P6mP2jA31s0L/AG+MW4SBP14
 Yg6At+iZtGX/4zp151xto235Yk3ipky07JrMfaNrC0pagnGaq/1J/nqO8kbOZYlQEphS
 gjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2qNVFmiF/TTMdfF9KQaUQuxRKJ4iuZ6iN+QlrxgUKnA=;
 b=BYbF0HHWQSttvnwxCjXKW+aLaUcTP1XnhWk5Q4Iq84NWAqlTZ4/ATsfL4uGakQaACg
 hG7qMHVGbL0zKKMvWW4/dyL7G7VZvDtmTFbMmO5woAaU7oN9ooVmzjErdHs5s7aPu6PY
 fEgE/eSrQn1/WWChXRAZZ3uEffdXHIj5rqBPPjlurT1F/qTBUE4HbM3J3I180SD5JOlC
 yh/nL6D9jVGAoAnJiiEldQyHyYA+j1nIjBXqdybotp0Zr2jZjaqwxJqhLgeEiNbFtt8c
 L/keG5TMvK0jWJhcprORP+l9kjFt1BFBNRuascHof7kcyrJHaX0DOxeZIUNF0lZmtf0l
 T0lQ==
X-Gm-Message-State: AOAM531H3VdM1fyXQXuF+YfMmpGvIa6pmGylLTSnEjYqV0eubLCUNOzc
 RrjZiNdXn+yvn3UU34vM6sg=
X-Google-Smtp-Source: ABdhPJw53K8igu5RpJ7t4nDpoJn09N8/AdK9nO7GxYmBWHaKQiibcUV7d6mxgSlKXJ6K0kEE0Sds7g==
X-Received: by 2002:aa7:d6c3:0:b0:42a:cc78:1764 with SMTP id
 x3-20020aa7d6c3000000b0042acc781764mr9089918edr.134.1653027761559; 
 Thu, 19 May 2022 23:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f:9303:6022:1507?
 ([2a02:908:1256:79a0:66f:9303:6022:1507])
 by smtp.gmail.com with ESMTPSA id
 qs24-20020a170906459800b006f3ef214dabsm2886921ejc.17.2022.05.19.23.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 23:22:41 -0700 (PDT)
Message-ID: <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
Date: Fri, 20 May 2022 08:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Content-Language: en-US
To: Lai Jiangshan <jiangshanlai@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
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
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.05.22 um 02:47 schrieb Lai Jiangshan:
> On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
>> 'drm/amdgpu: Switch to delayed work from work_struct.
>>
>> I will just reiterate here -
>>
>> We need to be able to do non blocking cancel pending reset works
>> from within GPU reset. Currently kernel API allows this only
>> for delayed_work and not for work_struct.
>>
> I'm OK with the change.
>
> With an updated changelog:
>
> Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>

Good morning guys,

for the patch itself Reviewed-by: Christian König <christian.koenig@amd.com>

And just for the record: We plan to push this upstream through the drm 
branches, if anybody has any objections to that please speak up.

Thanks,
Christian.

>
>
> Thanks
> Lai

