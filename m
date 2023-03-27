Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F64C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 14:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B090D10E112;
	Mon, 27 Mar 2023 14:09:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB27510E112
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JiClbRbsIcDqqB89+70pCfZb8JlxxwU0EW0xyTf5NwU=; b=m2L6YWFjirJRC3EBu3vYh5UKN2
 zbcw4B0CI8DkENLDf1QUDDxBSK5T7BKtloT+LNebzrPaIPvduQTNxUQf2017U58VUfQCrqqmdbcFu
 DZGqHqNxwBz/obgTFfi5eRzPLjktpavwfopTQjPkt0wOhFsB4y7BJw79x+DfocQ9FjqaNLW/rhrD6
 4i/do81yQtOk+evPzoLDWLgWu6TTa+x5ZPz9e8nt9m96W6NCVfpjYV6MuBCwvm7pa5rc1DpeaJmmJ
 946ncuQEFd40J3xSLAHOdbxeDVJecDLn+M+5zKrDqWVecibAYIQ+cKnxaUEZWA0Pq0UN/h0bQ76aS
 xUAp6Bfg==;
Received: from [191.13.19.82] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pgnWc-009Fbo-Eq; Mon, 27 Mar 2023 16:08:42 +0200
Message-ID: <49ef6b76-6e49-d7ee-377b-0cb700f5da71@igalia.com>
Date: Mon, 27 Mar 2023 11:08:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Content-Language: en-US
To: "Yang, WenYou" <WenYou.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
 <DM6PR12MB353134DD69F58F5C9D3FFA8DFD8B9@DM6PR12MB3531.namprd12.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <DM6PR12MB353134DD69F58F5C9D3FFA8DFD8B9@DM6PR12MB3531.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 27 Mar 2023 14:09:18 +0000
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

On 26/03/2023 23:49, Yang, WenYou wrote:
> Hi Guilherme,
> 
> Thank you for your attention on the patch set.
> The purpose of the patch set is to improve the performance when playing the game.
> 
> Best Regards,
> Wenyou

Hi Wenyou, thank you for the clarification and for the interesting patch
set!

So, just so I can understand: is it expected that gamers disable SMT? I
heard some games got their performance improved, but not sure the
reason...if you have thoughts on that, I'm pretty interested!

Cheers,


Guilherme
