Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB84CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5720020873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5720020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0711D6E8E1;
	Mon, 28 Oct 2019 15:00:53 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2C36E8E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 15:00:51 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id p4so10236626wrm.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=imFympAsLmoT10TXyD9GzGj79EKWpiMPMCaA4f4n5tA=;
 b=juXgNJxOSXZn2AUtwizPxVxrIruD9zUF4KDTmKLMWYtWkuiOl2QmfMzI+xTfHsl/Fa
 AL9nAG/1110bO79FOXH5FSL+3dBGUuoeYdbg/Qk7/zVcInJVsNn19dg3zO3s+0oD7a07
 yZ1eGio3SuslC5IUUQ3EeeSYyDdNB/2xQHs1XvGObQV6IBVeCONEfok14Rpa2TDOcy0M
 7gQfaHfraTMZWJARb0AgWaKyLXf9h6vlD4t3iKjsHcuD/LEAJkFTZCI7BgUQ8SZZLcI9
 EeyPQtuioy2NCBxtvLA+vcqd+tVfygwO18miv3MGNFutHS2jkWGqsKDDaxOIg3Gl5PBA
 e+Dw==
X-Gm-Message-State: APjAAAVHrAG8c6ENw6sLH4LnKnqEhrPWrLp1P4PMlLOx0cnzFFrHnXZ6
 vMp3l6/mLVHvqsbRKnVqP5PAZyPP
X-Google-Smtp-Source: APXvYqwJqFOB3z4p5Dt3Z5rXqpTGtdUd5sn74N42YemDg6Yx1MT3La8gbgXWROmaC6mh6Ltp0tRL3A==
X-Received: by 2002:a05:6000:11d2:: with SMTP id
 i18mr16192671wrx.109.1572274849660; 
 Mon, 28 Oct 2019 08:00:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b196sm14676853wmd.24.2019.10.28.08.00.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Oct 2019 08:00:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: add independent DMA-buf export v7
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191025121603.51204-1-christian.koenig@amd.com>
 <CADnq5_Mk2_1hOgrDTGLZOH7gh2Rb3LDtSL8buiVtwbum0=p+LQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6acd5e75-c565-ac87-6a74-7e6d42e98663@gmail.com>
Date: Mon, 28 Oct 2019 16:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Mk2_1hOgrDTGLZOH7gh2Rb3LDtSL8buiVtwbum0=p+LQ@mail.gmail.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=imFympAsLmoT10TXyD9GzGj79EKWpiMPMCaA4f4n5tA=;
 b=cn1sGe/KKlHMoYrqA6gsW5EzESzubfdUJPoPaUXP3e18fow/BJK02EXULh0eb4AAVK
 n71AOvgO2gFY07H7wMy4V1cQYD6YG4Zzl9mvLtZwKraesdptBIJPP26ukbpsr4TxzKWA
 aWCfitSEKLlRLkPBer9oCFg9JtxkW38+AbGzqaWkhOgmcv6tghrmSFKp0a4cVkmW+vbb
 nH1YEMNwegOYkVvPi56TYfXbuo+k5SlHcIqGYvwgFoqDiVo8Q5VVzdJ5rRSeJ4yiT54D
 f+1s/6xOANoYp0jWUUYk9rhBu3PSaH79raLNaqjZ7dJvjbcRfGWup8M0PsG1bOYJkifG
 XnLw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028150047.xzWHVOzbZi6gLe1CPWYHE7ZSVCQjdiWJ-qrjLcMAPQs@z>

QW0gMjYuMTAuMTkgdW0gMDA6MzIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gRnJpLCBPY3Qg
MjUsIDIwMTkgYXQgODoxNiBBTSBDaHJpc3RpYW4gS8O2bmlnCj4gPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4gW1NOSVBdCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5kZXggNmYwYjc4OWEwYjQ5Li5iMzE5MjU0NTM3
YjggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
Pj4gQEAgLTMxLDYgKzMxLDcgQEAKPj4gICAgKi8KPj4gICAjaW5jbHVkZSA8bGludXgvbGlzdC5o
Pgo+PiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWJ1
Zi5oPgo+IElzIHRoaXMgY2hhbmdlIGludGVuZGVkPwoKTm9wZSwgdGhhdCBhY3R1YWxseSBiZWxv
bmdzIGludG8gYSBmb2xsb3cgdXAgcGF0Y2guCgpHaXZlIG1lIGEgc2Vjb25kIHRvIGZpeCB0aGF0
IHVwLCBhbnkgb3RoZXIgY29tbWVudCBvbiB0aGlzIHNlcmllcyA/CgpUaGFua3MsCkNocmlzdGlh
bi4KCj4KPiBBbGV4Cj4KPj4gICAjaW5jbHVkZSA8ZHJtL2FtZGdwdV9kcm0uaD4KPj4gICAjaW5j
bHVkZSA8ZHJtL2RybV9jYWNoZS5oPgo+PiAtLQo+PiAyLjE3LjEKPj4KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
