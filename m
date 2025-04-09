Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7249FC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 07:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0835A10E7EA;
	Wed,  9 Apr 2025 07:25:52 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F76810E7B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 02:40:15 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso522024a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 19:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1744166413; x=1744771213;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IOQlV1YENNqfnMcYfC29B125TJM1XhvCjinQE4wwzk8=;
 b=TESGkZB2K0k0Rc0xzUqYhcERh9J59fpIkZA4ng/SToa1Sb9wSnMRaTHVnBNodIxYCn
 B1JNbleNqGyIyM4GsSOdMWoUD73Sm8ZrxtQHJr/ecnD/U38oVbcn+b85dU54A4ZGVUBz
 pp13mtdOh6bnU9CaqHL4/ozh3dNvURgrR4Ji8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744166413; x=1744771213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IOQlV1YENNqfnMcYfC29B125TJM1XhvCjinQE4wwzk8=;
 b=Yv/TquqN7uA6twmd7gUuvakheg5bnSORwI7qFaDK8v+OzVg+WsKFCUHCSMLc9isttM
 oV1o56grsmu8v+NgE70p4wUHaNSgq5b9ej/TeqGHmYGeTxntpWIn0JAxJ2m8jjApJog0
 WKsBVhAuMbaZZhDTdVv8I4BIolwyJdFR7vVyNFT7omrJFS1bDtoEMPYwKonrNnC2zOPl
 YKLsNObmLqAM9prM48Ni83cSDUw/Cge23vNahlrc909JMBuk6KZdz40pYO4s7ACIuRXG
 4E6vk/SCHcuOkuV9mhBxzGzaQa9QkkkZdJxbjiLEN4921AVu3czqvmfkFkeySlbpwJgY
 H2Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkRvxo7mF6YGwYzJC9F9MqbNxeOwMQR2QRH6xmFzF4cJlryvA6PP7eNqjyILegGuYf+o6IpKMn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3HRIeYyDiKxTvqZJthawU/ND+6pxPE3HZ2FeRxmdPm3nuCPBx
 clo7CQMIm17O67VqOW3VqkNrInocAH1jPdQV5bdi7/CsuNn6wkMpjwaPdD6T/guAdeCx1W5qHd8
 grWs=
X-Gm-Gg: ASbGnctH8Ji9Y5jEmCIh+eNPI5eoSu9r3NyrtGWWdQobiR7+VPud7/6BpmO39/kYDaF
 C9PJDTOI8ERPKZJtseW58oOneCLmUbAeVyx28A473XZVDVHKEKYJoKNcn1KYhzfgsK8FSOMO9o4
 CNqFK77xbKB2iynwYYUDkTIPkVQ/QPj3yMFQvqCyu5kWMQVra/AngL3F5yhoaqD8jwKqGw92XR1
 CxOzW3/p6b51ZanegGOB/TjYa2US5R5rltSDwPeJo7e9aBVt+NEPrjYVZXQj38wblVbshSIElCZ
 Y2XOMse4JPPM5gq/DIc7RV5HsZbtT45inYUdTkeA8FImcJR10kezcT6+LuYgI8E+lzhg6CZenbu
 wEI7rMuGDm/8sM4FlhcA=
X-Google-Smtp-Source: AGHT+IGuxUwKc7L5SGRPLJTbR114TFdaZ4G8zVxJNfUwxOy/FrcN5uQAw7D3ZG2wXQre/d+tBE1jOQ==
X-Received: by 2002:a17:906:c156:b0:ac2:d5d3:2b77 with SMTP id
 a640c23a62f3a-aca9c019bd7mr113632766b.8.1744166412755; 
 Tue, 08 Apr 2025 19:40:12 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com.
 [209.85.208.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1cb414dsm12260966b.121.2025.04.08.19.40.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 19:40:12 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso521990a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 19:40:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWG0oLBdkUhPU67iuW5XOfChVybCX7HXjW1U6FedYsWJlFRJ9oprYP3yteGOwLTE5Oj7hQw4XwA@lists.freedesktop.org
X-Received: by 2002:a17:907:86ac:b0:ac7:334d:3217 with SMTP id
 a640c23a62f3a-ac81a611619mr581097266b.12.1744166411592; Tue, 08 Apr 2025
 19:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250408091755.10074-1-arefev@swemel.ru>
 <e6ccef21-3ca5-4b5a-b18a-3ba45859569c@amd.com>
 <bmdour3gw4tuwqgvvw764p4ot3nnltqm4e7n3edlbtpfazvp5c@cqe5dwgc66uy>
 <f8810b13-01d1-4615-b6e2-2e791c48b466@amd.com>
 <qc72y52kt7vuwox4lhk42zligy5bslttselfoexse42mywtpps@ebqijs2tap2t>
 <edc08eb4-63dd-402c-82df-af6898d499a9@amd.com>
 <pmby7iowvxuomsbuxebttosz245j7ngw5enbl72dq675nrgvve@ugkvzeihbtut>
In-Reply-To: <pmby7iowvxuomsbuxebttosz245j7ngw5enbl72dq675nrgvve@ugkvzeihbtut>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Apr 2025 19:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLixL8-iYt1qH0-YvEnVsYtryZaN5Da0qoBBhKsBnumw@mail.gmail.com>
X-Gm-Features: ATxdqUFiHF52bUvLryR7rfFOaLA0UC5CBMTbxxULmYgSReDeZj_UCJwCfpJ84AQ
Message-ID: <CAHk-=whLixL8-iYt1qH0-YvEnVsYtryZaN5Da0qoBBhKsBnumw@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH] drm/amdgpu: check a user-provided number of
 BOs in list
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Denis Arefev <arefev@swemel.ru>, Alex Deucher <alexander.deucher@amd.com>, 
 Simona Vetter <simona@ffwll.ch>, lvc-project@linuxtesting.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Apr 2025 07:25:50 +0000
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

On Tue, 8 Apr 2025 at 09:07, Fedor Pchelkin <pchelkin@ispras.ru> wrote:
>
> > Linus comment is about kvmalloc(), but the code here is using
> > kvmalloc_array() which as far as I know is explicitly made to safely
> > allocate arrays with parameters provided by userspace.

No.

ABSOLUTELY NOTHING CAN ALLOCATE ARRAYS WITH PARAMETERS PROVIDED BY USER SPACE.

All kvmalloc_array() does is to check for overflow on the multiplication.

That does *not* mean that you can then just blindly take user space
input and pass it to kvmalloc_array().

That could easily cause the machine to run out of memory immediately,
for example. Or just cause huge latency issues. Or any number of other
things.

> [27651.163361] WARNING: CPU: 3 PID: 183060 at mm/util.c:657 __kvmalloc_node_noprof+0xc1/0xd0
> [27651.163411] CPU: 3 UID: 0 PID: 183060 Comm: a.out Not tainted 6.13.9-200.fc41.x86_64 #1
> [27651.163412] Hardware name: ASUS System Product Name/PRIME X670E-PRO WIFI, BIOS 3035 09/05/2024
> [27651.163413] RIP: 0010:__kvmalloc_node_noprof+0xc1/0xd0
> [27651.163424] Call Trace:
> That's just
>
>     union drm_amdgpu_bo_list bo_list;
>     int fd, ret;
>
>     memset(&bo_list, 0, sizeof(bo_list));
>
>     fd = open(DEVICE_PATH, O_RDWR);
>
>     bo_list.in.bo_number = 1 << 31;
>     ret = ioctl(fd, DRM_IOCTL_AMDGPU_BO_LIST, &bo_list);

Yes, exactly, and that's bogus code in the DRM layer to just blindly
trust user space.

User space input absolutely has to be validated for sanity.

There's a very real reason why we have things like PATH_MAX.

Could we allocate any amount of memory for user paths, with the
argument that path length shouldn't be limited to some (pretty small)
number?

Sure. We *could* do that.

And that would be a huge mistake. Limiting and sanity-checking user
space arguments isn't just a good idea - it's an absolute requirement.

So that kvmalloc warning exists *exactly* so that you will get a
warning if you do something stupid like just blindly trust user space.

Because no, "doesn't overflow" isn't even remotely a valid limit. A
real limit on memory allocations - and most other things, for that
matter - needs to be about practical real issues, not about something
like  "this doesn't overflow".

            Linus
