Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF5AC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 18:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D338710E02A;
	Fri, 14 Jul 2023 18:24:22 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.36 at gabe;
 Fri, 14 Jul 2023 18:20:00 UTC
Received: from omta038.useast.a.cloudfilter.net
 (omta038.useast.a.cloudfilter.net [44.202.169.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B2E10E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 18:19:59 +0000 (UTC)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
 by cmsmtp with ESMTP
 id K11PqciA0WU1cKNHfq1S2f; Fri, 14 Jul 2023 18:12:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with ESMTPS
 id KNHdq19mIchhoKNHeq0xGT; Fri, 14 Jul 2023 18:12:50 +0000
X-Authority-Analysis: v=2.4 cv=Tb+FCDch c=1 sm=1 tr=0 ts=64b19022
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=wYkD_t78qR0A:10 a=QX4gbG5DAAAA:8
 a=snExLxxF2foCdKK6ZiwA:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KCsVJp5qnfX7Jssk4LxDYEngrFE1DQACmhXzG+7FPBA=; b=M2IOJ51RbQeLWTH+hDTujo/BcT
 FNGZuK6zQ5WsYaZHqy6e15H9gS0lstlxNAYl6nkOh9BrObTSI01DAmMJe+kH1UJWGrbwfRjKj3wVZ
 w+XvmqONUISjI0gjmhcYyH0Shq8M7WpiSJLsFGokjDm3VPjHFrCKY2/l5PKU9/TZ7VaSJR3Kd7u1p
 uTY2pS3Eb6v6ATGGsMcFTfxWmCiptiGBISG4owzTHEMkGc7IF+IN/YI17JqIeJf2KLdhqg8DfDyiN
 J+jUs0Lu3d/IszVp55sQ2rf2wsCXnNhmQPTNBlgQqMxittAJ9wmHEw3lkzaCGock2N4feeHIM7DfP
 vXjo6oYg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55814
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <gustavo@embeddedor.com>) id 1qKNHc-002I2a-1y;
 Fri, 14 Jul 2023 13:12:49 -0500
Message-ID: <442403e3-317e-8744-3348-dc9823c22074@embeddedor.com>
Date: Fri, 14 Jul 2023 12:13:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
 <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qKNHc-002I2a-1y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8])
 [187.162.21.192]:55814
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFfZATea+8p9yUhfY3SaZ/S86Kq0zDUH37cltZGuiuh9JV4p49ErfmnP/r+L4WBdXGLv+xm0QXGIFm4nmAapT4kS9qBRvJBOUVauXRVhYLTPhhZohod5
 hHVLk2BaWaqqNiOrB7VAf1qeD3ju4h6aUBcdGD/Y2y39U9pz8DnnK9bm3+iF4MiQOg/uYjRGRDqw2CML1G40haaQ2uIwExeXn4IT2n6m6fFwXEW54+fY1UrL
X-Mailman-Approved-At: Fri, 14 Jul 2023 18:24:21 +0000
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
Cc: alexander.deucher@amd.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/12/23 08:12, Alex Deucher wrote:
> On Wed, Jul 12, 2023 at 8:04 AM Ricardo Cañuelo
> <ricardo.canuelo@collabora.com> wrote:
>>
>> UBSAN complains about out-of-bounds array indexes on all 1-element
>> arrays defined on this driver:
>>
>> UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelci-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c:1249:61
>>
>> Substitute them with proper flexible arrays.
> 
> + Gustavo, Paulo
> 
> I haven't kept up with the flexible arrays stuff.  Is this equivalent
> to a zero sized array?  We've been bitten by these kind of changes in

In terms of size, yes: the size of each array declaration does not
contribute to the overall size of its containing structure.

However, in these cases, using the DECLARE_FLEX_ARRAY() helper is not
required. Simply removing the '1' from the array declaration will suffice.
This helper was created to declare flex-array members in unions, as well
as in structs that contain no other members aside from the array.

In any case, these changes are not complete, as they're only modifying
the struct declaration, hence the size of the struct is affected. Now
the rest of the code where these structs are involved should be audited
and adjusted to accommodate the change in the sizes of the structs.

> the past.  These structures define the layout of data in a rom image
> on the board.  If the struct size changes, that could lead to errors
> in the code that deals with these structures.
> 
> Alex
> 

Thanks
--
Gustavo
