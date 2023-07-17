Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E70EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 13:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C97F10E249;
	Mon, 17 Jul 2023 13:01:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116110E225
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689589550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
 b=C65o/auU4ShkAd4aAQ231+4cpgAPBT4XBKAjNYgSaSLn2wRIIGimgKSlKJCKO2FcbQkCEZ
 gUEBcq4s7B4Em7SOyBdZtjLR8eAvfiWtglZRq14mPT6c3+LSlYLI0AqQa6IOflk3CuqhCV
 ZkDTkrowCvFd4V/3gEll25h7vRXINH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-tCXpbpz4MlanBLNTCumrpA-1; Mon, 17 Jul 2023 06:25:46 -0400
X-MC-Unique: tCXpbpz4MlanBLNTCumrpA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2364627f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 03:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689589545; x=1692181545;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
 b=MNL9UJZHngkXQWZc0TXUcOunRZKT4K0ubc7aKvsAiWfsihQ1gwZ6n2AeCpm4ARNbzM
 W2/jnq9YlisovTk9EWKZJths9c2gZhDbETe4+1Qpmmf6CMdyfMYuKsbzgkbCpt8gmV3D
 hjD0IO4uuAt0fpxwVKQgzjlZGKU4vEzgAzRk8nY9lwjhyYrwvj7WemQRnHy/pF993WYB
 TPYzjs8Q0QcPXWH97KHhIjdNWQZ8MuiDNW0O/XklXiKcXnOOwRfS9DgJedBDa9BDYIdK
 9kZIlphTdjxgk/SFNPuINws2Gh5OXA+posuoCCf2nU8hBYMeRWIgRiBFi8rk9twsBPn0
 wbDQ==
X-Gm-Message-State: ABy/qLb/x8ysjFkrJ73AInQtLaLKg63NrsSnR6d3IGXUrnbqfFNgxFIG
 6OixqniyzdEo1Z7uqn9BoewhjuSlJShyzNrqnF+KpDXZ2aq9a7fGGczK8BAhx5VvrtDZY/gBeU/
 xhX78evBlUooVGJ5RhdSL9Oa5Og==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id
 i1-20020a5d6301000000b00313f54825b9mr10182300wru.40.1689589545445; 
 Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWwgj2gvrTcZVcFzDTLfBjRjMXpKrSXg5bhLw4PXADJbZO+n+htRPdtsID+emCjARx8zYmVw==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id
 i1-20020a5d6301000000b00313f54825b9mr10182288wru.40.1689589545080; 
 Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da?
 (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de.
 [2003:cb:c735:400:2501:5a2e:13c6:88da])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a5d4641000000b0031434936f0dsm18732085wrs.68.2023.07.17.03.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 03:25:44 -0700 (PDT)
Message-ID: <2000511c-d551-5b3d-a9a9-adb4ba3be1f1@redhat.com>
Date: Mon, 17 Jul 2023 12:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] mm: use vma_is_stack() and vma_is_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-3-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-3-wangkefeng.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Jul 2023 13:00:58 +0000
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
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12.07.23 16:38, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   fs/proc/task_mmu.c   | 24 ++++--------------------
>   fs/proc/task_nommu.c | 15 +--------------
>   2 files changed, 5 insertions(+), 34 deletions(-)
> 

Please squash patch #1 and this patch and call it something like

"mm: factor out VMA stack and heap checks"

And then, maybe also keep the comments in these functions, they sound 
reasonable to have.

-- 
Cheers,

David / dhildenb

