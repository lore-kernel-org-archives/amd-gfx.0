Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D69FC38142
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 12:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98B610E1C5;
	Mon, 23 Jan 2023 12:38:02 +0000 (UTC)
Received: from c3po.tilda.center (c3po.tilda.center [108.61.164.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECC210E1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 12:38:01 +0000 (UTC)
Received: from [192.168.111.186] (meka.rs [109.93.255.137])
 by c3po.tilda.center (Postfix) with ESMTPSA id E8C3134E86;
 Mon, 23 Jan 2023 13:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tilda.center;
 s=c3po; t=1674477439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGuGIiagyt88V/SNZpDkeyRewBs7Wy0u1Fikfi57eII=;
 b=SFg3q+9N/rSExq3qp8z4t19Us7oqyGliZUt7Gd/cXKa/KRjzz6T1x4mIKoqcWxNB+kYQGl
 O8dgkvQP/CiSDIZDO5+NrD1rCxHUnm5dypixOW5qJGDpElqZSqJgj+KEmVziY2NrbLW5k9
 ABqJb1S32xHHiNxgz16RtzRv5xN6jpk=
Message-ID: <abf5ca42-5a4f-69e4-d035-9ab862a20df9@tilda.center>
Date: Mon, 23 Jan 2023 13:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Minimal kernel version for 7900XT
To: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
 <CAD=4a=WuexXdWwRQXby0KnG=AQnR0fXsJAu=dNABU4irNgTdBg@mail.gmail.com>
 <0bca54ad-3626-a3f6-fdfd-09b1d0718564@tilda.center>
 <CAD=4a=V3bbhU_QOqF5r9Yzg-OUq0t3uX2eS=qZHWFsm6ain6_g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Goran_Meki=c4=87?= <meka@tilda.center>
In-Reply-To: <CAD=4a=V3bbhU_QOqF5r9Yzg-OUq0t3uX2eS=qZHWFsm6ain6_g@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/23/23 13:34, Ernst Sjöstrand wrote:
> Ah you were looking at the packaged driver installer (usually called 
> "Proprietary" even though most of it is not).
> It will install extra modules so it works with "any" kernel.
> 
> For the upstream Torvalds support I guess you end up in the 
> CHIP_IP_DISCOVERY clause, it's a new method for new cards.
> 
> //Ernst

Ah, so that's it! Thank you for removing "black magic" bits! Much 
appreciated!

Regards,
meka
