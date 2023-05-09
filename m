Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D814C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 07:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA8810E333;
	Tue,  9 May 2023 07:05:55 +0000 (UTC)
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F40610E161;
 Tue,  9 May 2023 02:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1683600348; bh=vp74XIan1ANEVyHsQKiLAwzK0BEDTnhRfeu9TTwcxnw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eogatlY2OBxYO/oXSD7pNEPqBGGnCz/GXeJE1R+P/ww5WtGJ9WkrPvNb3WcfE1CSR
 79DAB4H00v/SkOmA1t+QPvyHggVWvfl6HOVua+7qAz1lsLoIVfKiiUzW/H4btv5hX8
 9dbBytwDLP9DfJLfkw/+h7uv+lQEf3H6icu2nrfM=
Received: from [100.100.57.122] (unknown [58.34.185.106])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1FAC3600BD;
 Tue,  9 May 2023 10:45:48 +0800 (CST)
Message-ID: <a257a400-0660-8190-9dec-f0c1fa084eea@xen0n.name>
Date: Tue, 9 May 2023 10:45:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [V3] drm/amdgpu/display: Enable DC_FP for LoongArch
Content-Language: en-US
To: Sui Jingfeng <15330273260@189.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>
References: <20230508030941.476694-1-chenhuacai@loongson.cn>
 <1b888568-b1f4-c764-7212-5a940fb8454a@189.cn>
 <12123b79-d680-4ed4-d14f-fedd0eb73b29@189.cn>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <12123b79-d680-4ed4-d14f-fedd0eb73b29@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 09 May 2023 07:05:53 +0000
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
Cc: loongson-kernel@lists.loongnix.cn, Xuefeng Li <lixuefeng@loongson.cn>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023/5/9 00:34, Sui Jingfeng wrote:
> I have tested glmark2 on ls3a5000 with this patch applied,
> 
> I have also bought a better gpu (vega 56), which is on the way.
> 
> currently only have a rx550 at hand.
> 
> I pasted the performance score here, how about this score?
> 
> Does this looks normal?
> 
> [snip of frame-rates mostly in the 7000s for the best cases]

This is irrelevant, because RX 550 isn't DCN so the code path being 
modified here doesn't get executed at all.

Though, the results look similar to what I've seen on my setup (3A5000 + 
LS7A1000 + RX 6400), presumably because the write-combining optimization 
cannot be used with current LS7A systems, meaning the system is 
bottlenecked by all the MMIO's. I also see best case frame-rates in the 
7000s range.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

