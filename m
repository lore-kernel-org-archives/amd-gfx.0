Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD89C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 08:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE7023121
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 08:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE7023121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEBB6E84A;
	Tue, 19 Jan 2021 08:42:17 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4F6E841;
 Tue, 19 Jan 2021 08:42:15 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id by1so20931028ejc.0;
 Tue, 19 Jan 2021 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=eyWMrLYqzVokjlsFEL7kl7PdBZ0PQHc567l6js3GHEc=;
 b=d/NpMSRM1A9inveKck/EDVQXzZLA11SJKXsF27WrqJrntvOlxvVJvc3yyeIEHAh9Lx
 zJwWo/AYRc4pbMAk8M5FvSoGuH1MgGNBUI7JllU06KUbINgURtw8Ehen7Q267EwUSCY+
 LcQR0bd3gjlPUrwhUG2ol5x/LRlwxcpOysOAfgutHDuhwbLEWOl1V07tzd1u7BsGud65
 HqxTzM0NSFjlLzt7cCC/X0eUOwvfM9+LmJZG/CYrYH47bUSiNg9QQ5yghmZzc/EHGoF0
 3bsx1wkzBecHZt6wnejot4YXZ21lveAqDecjuT0c2oOCxsqeo7L4lGyIJZyCEEAenUAb
 FGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=eyWMrLYqzVokjlsFEL7kl7PdBZ0PQHc567l6js3GHEc=;
 b=L6g//W1ehUAFDXS+xj5Dx+rDcOttnu0F9kQ4ADBRsmhlEj3Pi7qD4cVANWgkuaV8J1
 j0iOMnp0sAt2BoT+Y7tFSUaESrGuZQ8ttenRooyFVvPOCB957uq1Cl6IE/FZ/6jmPamd
 j6TDvYOq7FAz3UOQOMMRkxGbZfrn61Mk6Gd9xRez+R9bkNBfmF0R8DHdYbmoZmb9Rn/2
 GfZ7x3bGeEGeKuHPF1M+ya/Q51mCJOq+JSIrBeskpRNgNNilN3RSQgKNcNjPp3UGNT1j
 nPGjsZwQWaSlwTyCer2aRpglQdscXHMgD8wgbwy/+kiHVMaJ5hSQcP9esak63FCdWAcR
 X6AQ==
X-Gm-Message-State: AOAM530gy1y0x5fSYoagQX5Qf+FCRV9RTQC3qIZUm3AOc828ajEJf/Uy
 E0M2L+vPYgr0rh8QyFgFxak=
X-Google-Smtp-Source: ABdhPJwB4SxaxFU4/CzqtSx5cDzwZ8qyA+2v6HGBcgSlHZkPsmvDI4PCwQrxiA/z01fpU7t/6KkktQ==
X-Received: by 2002:a17:906:b186:: with SMTP id
 w6mr2364859ejy.477.1611045734633; 
 Tue, 19 Jan 2021 00:42:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q9sm6858804ejd.113.2021.01.19.00.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Jan 2021 00:42:14 -0800 (PST)
Subject: Re: [PATCH v4 04/14] drm/sched: Cancel and flush all oustatdning jobs
 before finish.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, robh@kernel.org, l.stach@pengutronix.de,
 yuq825@gmail.com, eric@anholt.net
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-5-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <667cef85-a7e9-fba5-132a-5fb57d7e8b62@gmail.com>
Date: Tue, 19 Jan 2021 09:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611003683-3534-5-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 Harry.Wentland@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBhIGJ1ZyBmaXggYW5kIHNob3VsZCBwcm9iYWJseSBiZSBwdXNoZWQgc2VwYXJhdGVs
eSB0byBkcm0tbWlzYy1uZXh0LgoKQ2hyaXN0aWFuLgoKQW0gMTguMDEuMjEgdW0gMjI6MDEgc2No
cmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBUbyBhdm9pZCBhbnkgcG9zc2libGUgdXNlIGFmdGVy
IGZyZWUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6
b3Zza3lAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9tYWluLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiBpbmRleCA5OTdhYTE1Li45MjYz
N2I3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiBAQCAtODk5
LDYgKzg5OSw5IEBAIHZvaWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVy
ICpzY2hlZCkKPiAgIAlpZiAoc2NoZWQtPnRocmVhZCkKPiAgIAkJa3RocmVhZF9zdG9wKHNjaGVk
LT50aHJlYWQpOwo+ICAgCj4gKwkvKiBDb25maXJtIG5vIHdvcmsgbGVmdCBiZWhpbmQgYWNjZXNz
aW5nIGRldmljZSBzdHJ1Y3R1cmVzICovCj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnNj
aGVkLT53b3JrX3Rkcik7Cj4gKwo+ICAgCXNjaGVkLT5yZWFkeSA9IGZhbHNlOwo+ICAgfQo+ICAg
RVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfZmluaSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
