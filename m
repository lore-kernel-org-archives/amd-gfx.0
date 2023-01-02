Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC79C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 08:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A1710E3AD;
	Tue,  3 Jan 2023 08:32:36 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC2F10E34D;
 Mon,  2 Jan 2023 15:08:13 +0000 (UTC)
Received: from [192.168.2.142] (109-252-113-89.nat.spd-mgts.ru
 [109.252.113.89])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C7E706602CBE;
 Mon,  2 Jan 2023 15:08:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1672672092;
 bh=jnnk18nRFYsCLsviawzvIOu5POilnSP/O8RxFDUWJ64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=axfWo4ZIaKPo8pD4W93FerJ5svgX4DWVN+9Cs7desuiyoRF31RMLlWi1chFgwEhq4
 R8Z+qlmg5OSlALlQyxON1+UuI0mSLrmlVzrotY3gPYOWgFA0GQsN0CZJmf0Td2n8/C
 HQxFxtrNSStbO5ndHxOWxgwCHf8UHi886vhbDJCf3pX9gjaxl1vPD6UhWzlvpb8yEO
 H/G4H986uDg0Q9T41cjKARiJFzQQUjbov2hhLqLPGb1uDwlD8d9au8N26QsXtEM3bU
 YZrIa/m9GJ/5VOfpZp6y7FKWWaGkyXUMdoNqm5GHhQILb0783W6u3PXznquHXG+LdH
 7kRrMi2xgvhrw==
Message-ID: <f3407008-325c-5c39-3b1a-818d262803af@collabora.com>
Date: Mon, 2 Jan 2023 18:08:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 12/13] drm/scheduler: rework entity flush, kill and fini
Content-Language: en-US
To: youling 257 <youling257@gmail.com>
References: <CAF6AEGv=GJm5Hyea7a0oDgWDYXw72HwTB4sreeppYVEKCsw0Ew@mail.gmail.com>
 <20230101182907.1662-1-youling257@gmail.com>
 <6ef84968-2874-49b0-9fbc-bdc897382b0e@collabora.com>
 <CAOzgRda9JCguwJa6UT+q7hJ7pzcfxhJU5rxjTmoCb79DtWMqOw@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAOzgRda9JCguwJa6UT+q7hJ7pzcfxhJU5rxjTmoCb79DtWMqOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 03 Jan 2023 08:32:32 +0000
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
Cc: jonathan@marek.ca, ckoenig.leichtzumerken@gmail.com,
 dri-devel@lists.freedesktop.org, robdclark@gmail.com, luben.tuikov@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/2/23 17:17, youling 257 wrote:
> which patch?

https://patchwork.freedesktop.org/patch/512652/

I applied it to next-fixes

-- 
Best regards,
Dmitry

