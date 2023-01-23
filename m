Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5E0C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 11:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9D210E343;
	Mon, 23 Jan 2023 11:47:43 +0000 (UTC)
Received: from c3po.tilda.center (c3po.tilda.center [108.61.164.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E7D10E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 11:47:41 +0000 (UTC)
Received: from [192.168.111.186] (meka.rs [109.93.255.137])
 by c3po.tilda.center (Postfix) with ESMTPSA id D9B1B34DEA;
 Mon, 23 Jan 2023 12:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tilda.center;
 s=c3po; t=1674474419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgqnjUWNt0d/Dz1ryoeeh+1gGIeZbbc1I1aqgs6X7NM=;
 b=lxj3fPEojCoHIsOKlWt4JnipaL72NsxszGgIcX/Id7hnWDm5a2ktKfR9s270wZDgv7rQY5
 mlUw1M7u2a8znVy22V2eNdCaVCiqu3PSMldzhU0Xtr0EDdULLRxpSlLNdElYUsMj05SCXl
 TWBakqiRnERIQC9yn/UzDrDaLIfDIe4=
Message-ID: <0bca54ad-3626-a3f6-fdfd-09b1d0718564@tilda.center>
Date: Mon, 23 Jan 2023 12:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Minimal kernel version for 7900XT
Content-Language: en-US
To: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
 <CAD=4a=WuexXdWwRQXby0KnG=AQnR0fXsJAu=dNABU4irNgTdBg@mail.gmail.com>
From: =?UTF-8?Q?Goran_Meki=c4=87?= <meka@tilda.center>
In-Reply-To: <CAD=4a=WuexXdWwRQXby0KnG=AQnR0fXsJAu=dNABU4irNgTdBg@mail.gmail.com>
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

On 1/23/23 12:28, Ernst Sjöstrand wrote:> 6.0 should be enough:
 > https://www.phoronix.com/review/rx7900xt-rx7900xtx-linux
 > <https://www.phoronix.com/review/rx7900xt-rx7900xtx-linux>
 >
 > The firmware files is maybe the most complicated part right now...
 >
 > //Ernst
I found that article, too, but what is confusing are two things:
* SLES 15 SP 4 doesn't run on 6.0 but 5.14.21
* Why is there no PCI ID in the kernel source?

Hence my request for help understanding how it even works.

Regards,
meka
