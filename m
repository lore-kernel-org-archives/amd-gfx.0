Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9632C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B38A99A64;
	Wed, 13 Jul 2022 20:41:14 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302A699A16
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:40:45 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id v7so55031pfb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2izuw3b6CY3C2bpErtejUyL+XN/ca0tS3/ecJTr2WVg=;
 b=FS/DlMzuhgtjp0FHhoNu179kPvuygez5Dc/AJShi2OgnfLzoX5s05ZNQBfdDYCRJGg
 SWrcCQEMxT78B3DpYT1S3YeFk02QXViEEDJs8Fhs9yBAjROVYAhAWpeGbZot9RxyPr+y
 eUnRcHdX/ieWg6zojOCBfEGVwfUP2QO4StpNJnmPzHC5ZdtMwMyN1iq561V8gl/3KrfY
 Nyx8U8NxdY60ZFrMk5UMGQ8GXd+ydDVD0MYl3PsFefG2RF8L3yQr+qSYyoDzJgwsRiFG
 elj2/WYKbnsAPTUehRfq52gsV7XvvSInQCSbyNgx2KJj5KvCpQt+15S5beOcvs+/XpDC
 WQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2izuw3b6CY3C2bpErtejUyL+XN/ca0tS3/ecJTr2WVg=;
 b=KVbQCQUp+EeEjwfCuRGfNQMyKLIq1ImyGqc3znmtvsd3f43P0vNaN7xjDYKAY/UuxX
 v9s6pfeku1a1PIq9w2JcJm3aq01QSEp9i+JuLNb/7wgktxvEmBe7UBZ8tPLjsQVayUwr
 LRrSWIGtTC0np0RwBuATqIsYcpZLY2VObn/2wLG52aIrM4ldF532F+HULtQj6Piqo1QT
 qjI9/HNuaJGnXJHm+KNny58yyst+VYoRCJIyiD5vi6nkx2lG0+iriFzsMHeOS+XPfC2P
 O5Fxa82hSI9BIHSWLDIJ/czupjV1uYLMFHjvbBVbsokPw7dYDpXYWzqS3avxMOcBAaCr
 OwsQ==
X-Gm-Message-State: AJIora9P49saI+HB/lron0u94AtFHVnQDU98sduEiZ4uPYkCvNIhxyzs
 Rp65XOM79PCqyKNLz24y/Qk=
X-Google-Smtp-Source: AGRyM1uK17h0xK/cQK0JEnNk5fEEoDCzli9QA+bpk8q7ElV5jpQTvkPfmTAKCTkF9cn76KYhdbTBMA==
X-Received: by 2002:a63:e552:0:b0:419:8dfb:386e with SMTP id
 z18-20020a63e552000000b004198dfb386emr4373697pgj.143.1657744844703; 
 Wed, 13 Jul 2022 13:40:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b0016c2da4e73fsm9226144plb.106.2022.07.13.13.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:40:43 -0700 (PDT)
Message-ID: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
Date: Wed, 13 Jul 2022 13:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc6
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:41:13 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/13/22 13:21, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> There may be a patch that solves that, but it's never been submitted to
>> my patch system:
>>
>> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> 
> That patch looks sane to me, but I guess Guenter would need to check
> ... Guenter?
> 

That patch is (and has been) in linux-next for a long time,
as commit d2ca1fd2bc70, and with the following tags.

     Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
     Reported-by: Guenter Roeck <linux@roeck-us.net>
     Tested-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

So, yes, it fixes the problem. I don't know where it is pulled from, though.
I thought that it is from Russell's tree, given his Signed-off-by:,
but I never really checked.

Guenter
