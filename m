Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B5C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 14:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDB310E51A;
	Tue, 28 Mar 2023 14:14:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E772310E033
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gcsnh3j1ZT2Qp4IpT8X2uWlLe9X56/gIBfM35K5LtZQ=; b=Nf/QWUoyKkNu7lp48h8uNZzllH
 XPgsELMvD6ZaX1GRyXOueTGXom3lf7zHdRuLOmYc03vlNbZ1VjkRMZ/BDLmb9HYgrHCcIQ8qa3q4H
 3QcCASCg8XJ7B0lgw/wpzl6wBXLplQf5zlfqoktPIa6wQOTW8oVUSbXLyc8Kz9+8ecNxn8C5zKsPc
 xnvXr6ycHxIX0KkiZYzufWIbQ4sZqJVtISuhXgg0NFE9B0uVJxOhfYE34sgTUBlGXSMjH5gDk9EXQ
 PDOW1bu8ddSnV1ihV068c5wMOja1/HR2vJWwtYo8pjd1kROvTTGiadb6nD+h7cOyzWGXSliKuqbWN
 wFiWpAKg==;
Received: from [191.255.122.45] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ph88U-009vlK-7p; Tue, 28 Mar 2023 14:09:10 +0200
Message-ID: <22de375f-9b97-047f-edc1-2cfa3ac960c0@igalia.com>
Date: Tue, 28 Mar 2023 09:09:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Content-Language: en-US
To: "Yang, WenYou" <WenYou.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
 <DM6PR12MB353134DD69F58F5C9D3FFA8DFD8B9@DM6PR12MB3531.namprd12.prod.outlook.com>
 <49ef6b76-6e49-d7ee-377b-0cb700f5da71@igalia.com>
 <DM6PR12MB35312CF3EAB7E9CF6092665FFD889@DM6PR12MB3531.namprd12.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <DM6PR12MB35312CF3EAB7E9CF6092665FFD889@DM6PR12MB3531.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Mar 2023 14:14:34 +0000
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
Cc: "Li, Ying" <YING.LI@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 28/03/2023 03:07, Yang, WenYou wrote:
> [AMD Official Use Only - General]
> [...]
>> Hi Wenyou, thank you for the clarification and for the interesting patch set!
>>
>> So, just so I can understand: is it expected that gamers disable SMT? I heard
>> some games got their performance improved, but not sure the reason...if you
>> have thoughts on that, I'm pretty interested!
> Hi Guilherme,
> 
> No, it not. It is not to disable SMT.
> 
> Yes, there is a commit to get performance improved.
> https://github.com/torvalds/linux/commit/a8fb40966f19ff81520d9ccf8f7e2b95201368b8
> 
> Best Regards,
> Wenyou

Thanks, this one is present in Deck's kernel for a while.
Cheers,


Guilherme
