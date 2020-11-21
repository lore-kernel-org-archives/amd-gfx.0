Return-Path: <SRS0=rJdP=E3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BBC56202
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Nov 2020 14:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1933622226
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Nov 2020 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJGwAChI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1933622226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C6F6E9C5;
	Sat, 21 Nov 2020 14:16:19 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570C96E9C2;
 Sat, 21 Nov 2020 14:16:18 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id a15so12471610edy.1;
 Sat, 21 Nov 2020 06:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cWbe+faF7Z9jmuI34DwJhG4F0zapIRTPqrZ5fN3wlY8=;
 b=aJGwAChI2O84q7upTiJecj/pkcc6IYI7xouxebF6axYLOsZIV9Ahtr7oPIRMz9EAS+
 JtMpD6a5f/h+qrwjTzGz07Hm2Xl+2n+vw8kE16Hb3Y0AaUvXzDCqWEraUMBylOOitzsW
 w4yXui7m2yGxmmlxUV+t9Y8FHYJ1iOZ5CauGczlJv4XlddnUqV9eQgyQyiwNuP9/65o/
 BTH57BlyqrfaTfzQqh76FyWZrKvOirEtFGyYGUXq+DNs7aUPmnVHa8hOi2A63dn8HVA9
 cEefPhqgnno7rN4Rd7tQzkEZzR27peTWzO4s6WWpdV6gBYyaBmHWld9uvD1L3cIE3Xd3
 Lelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=cWbe+faF7Z9jmuI34DwJhG4F0zapIRTPqrZ5fN3wlY8=;
 b=NbNdQ3tJIcBkDC6U0lV5DG+93IUxEQhZQROFA9oewE5Wi1wfBZ2XNGEZtsoGL6dWCW
 ofcqBa8tZRinNn5mzEbgY81LBmMzq6fkgwCdWv4fTf16iCWZobwxGnBzQR7IL+nbRYDf
 6jeXnTXUgsMq3viBHRiKtf8MHnhsbLPdH38d45vmFUz6G26psBL1mLMluDTsNh3N091p
 MDtlLwPo4VtaTz7z3jpdGBSH3bWph2/efSLEI/qIcFWrLzobeO/x8amuTCt+blWuR4EW
 I6YfwO16qELYXlNw7XoZZ9JI/jgWRTOpXiRexNtOJYtGhcNJlmt7I+76VFGWP0JghI5C
 b4/w==
X-Gm-Message-State: AOAM530rroLQK1Zlc4brU7OrWo206F00dXDaexZg+H9tAgSfGIBlkhUG
 /mkiJW98q4epzSOjAcc1SWCaAJCedyg=
X-Google-Smtp-Source: ABdhPJy+eb82/6Ya4UN+Ma+8Ux/B5sog/VHVbU3YzcV42dzpPbsEXAx7UqQ/XYQkFVawxP6mQu2USA==
X-Received: by 2002:aa7:d711:: with SMTP id t17mr40096679edq.83.1605968177066; 
 Sat, 21 Nov 2020 06:16:17 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id bt16sm2488397ejb.89.2020.11.21.06.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2020 06:16:16 -0800 (PST)
Subject: Re: [PATCH v3 02/12] drm: Unamp the entire device address space on
 device unplug
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, robh@kernel.org, l.stach@pengutronix.de,
 yuq825@gmail.com, eric@anholt.net
References: <1605936082-3099-1-git-send-email-andrey.grodzovsky@amd.com>
 <1605936082-3099-3-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <54329aa5-ef57-3209-13b7-abd02683f9fc@gmail.com>
Date: Sat, 21 Nov 2020 15:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605936082-3099-3-git-send-email-andrey.grodzovsky@amd.com>
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

QW0gMjEuMTEuMjAgdW0gMDY6MjEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBJbnZhbGlk
YXRlIGFsbCBCT3MgQ1BVIG1hcHBpbmdzIG9uY2UgZGV2aWNlIGlzIHJlbW92ZWQuCj4KPiB2Mzog
TW92ZSB0aGUgY29kZSBmcm9tIFRUTSBpbnRvIGRybV9kZXZfdW5wbHVnCj4KPiBTaWduZWQtb2Zm
LWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9kcnYuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9k
cnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHJ2LmMKPiBpbmRleCAxMzA2OGZkLi5kNTUwZmQ1
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHJ2LmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vZHJtX2Rydi5jCj4gQEAgLTQ3OSw2ICs0NzksOSBAQCB2b2lkIGRybV9kZXZfdW5w
bHVnKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCj4gICAJc3luY2hyb25pemVfc3JjdSgmZHJtX3Vu
cGx1Z19zcmN1KTsKPiAgIAo+ICAgCWRybV9kZXZfdW5yZWdpc3RlcihkZXYpOwo+ICsKPiArCS8q
IENsZWFyIGFsbCBDUFUgbWFwcGluZ3MgcG9pbnRpbmcgdG8gdGhpcyBkZXZpY2UgKi8KPiArCXVu
bWFwX21hcHBpbmdfcmFuZ2UoZGV2LT5hbm9uX2lub2RlLT5pX21hcHBpbmcsIDAsIDAsIDEpOwo+
ICAgfQo+ICAgRVhQT1JUX1NZTUJPTChkcm1fZGV2X3VucGx1Zyk7Cj4gICAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
