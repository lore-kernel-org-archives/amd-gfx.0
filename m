Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191EC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 07:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2EB214F1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 07:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im9PVvhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2EB214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0ED86E357;
	Fri, 11 Sep 2020 07:35:48 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E22F6E357
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 07:35:48 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id ay8so8948409edb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=j3f7hKIlnpa1YNj9GTqvRSM302Gd2TnvYezQjPe5ma0=;
 b=im9PVvhgnX29BQzZiTPMKz4V6XtPFj+RRSopHuE/n8GDwz1ABPx2hL5ggDcrybRJ/d
 Bdz79vZ2brJLbjKvZvR7qoC0Hnv5zBO6xf5zwYIKfmUL6XA7cF7lx5osplE9q+TngOEy
 EePZFdYIRL0HPXX7w7Nyc6mfTQ5e2JKfT3fjw5ISy49kndH61FtOd/Oqcz9FX8dzBH7U
 KOSEcfuo1NUcHSOISsGqMcvnNrKb+krhjvXjTxioXuIlLjEdsM86r8J5Yr5czypSwvCp
 GJQsnvGx81Q3ank4Qsc+7cBmmxuzRfSdQEQAb1jonrZrEMtrkIs0QExtKR2goPMFIknY
 MGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=j3f7hKIlnpa1YNj9GTqvRSM302Gd2TnvYezQjPe5ma0=;
 b=O/dEsBrOZdxMJ3xqwFgJr8pB96T78JhN/BLOM0QCdnzUryz7F3047wtUJD0NODFZTD
 May5Epg13GwkV5YxQQU1IupLb9DRfBosdsvTvs0BNuX8NYAH7FSYBb75cQybTnHTvHyo
 2nFL28bttzGemdA/mN9BN/7vqTiHwO774vBM8PT/Pz8udsTg9GbqW7TgwWTBmMs9GmY2
 x2jriYLI02H8vcDmNgp087STdz9U7Z5G2DQWAsqFNrHsg/PBUsCy4Njs0hqxwpo2vqtt
 KBCvKI/MEh2TWXwfA01exSv8MplAUB+PDaAORpS8HdYoeHyIZDE30Iqfcn0AELKZKNQv
 W2VA==
X-Gm-Message-State: AOAM533AvTSWVOmQ17P0P3WttZi/EQRTNg9puSUkg+TR0+VNU5bEX7aj
 GcxZk5whFppMZXxxN/+Dqo4=
X-Google-Smtp-Source: ABdhPJwUOt1TrZDR3vwB7MJhmhFpkAdxmF0hR/vN9xiT9s1DtV7R+zgLljx3ZB8pAmAzF9sRzDwt5Q==
X-Received: by 2002:a05:6402:12d1:: with SMTP id
 k17mr643370edx.323.1599809746761; 
 Fri, 11 Sep 2020 00:35:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y14sm987883eje.10.2020.09.11.00.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 00:35:46 -0700 (PDT)
Subject: Re: [PATCH] drm/radeon: revert "Prefer lower feedback dividers"
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: kai.heng.feng@canonical.com, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200909111655.1102-1-christian.koenig@amd.com>
Message-ID: <f4505fa5-99a1-0010-7832-2d0e8e2c4410@gmail.com>
Date: Fri, 11 Sep 2020 09:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909111655.1102-1-christian.koenig@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZywgd2UgbmVlZCB0byByZXZlcnQgdGhpcyBBU0FQLgoKQ2hyaXN0aWFuLgoKQW0gMDkuMDku
MjAgdW0gMTM6MTYgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IFR1cm5zIG91dCB0aGlzIGJy
ZWFrcyBhIGxvdCBvZiBkaWZmZXJlbnQgaGFyZHdhcmUuCj4KPiBUaGlzIHJldmVydHMgY29tbWl0
IDUyMmZmM2E4YjZkNzNhMzEwODRiNGIwODdiNDU4ZjdmYTBhYzFlMTQuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAyICstCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKPiBpbmRleCA3YjY5ZDZkZmU0NGEuLmUwYWU5MTFl
ZjQyNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKPiBAQCAt
OTMzLDcgKzkzMyw3IEBAIHN0YXRpYyB2b2lkIGF2aXZvX2dldF9mYl9yZWZfZGl2KHVuc2lnbmVk
IG5vbSwgdW5zaWduZWQgZGVuLCB1bnNpZ25lZCBwb3N0X2RpdiwKPiAgIAo+ICAgCS8qIGdldCBt
YXRjaGluZyByZWZlcmVuY2UgYW5kIGZlZWRiYWNrIGRpdmlkZXIgKi8KPiAgIAkqcmVmX2RpdiA9
IG1pbihtYXgoZGVuL3Bvc3RfZGl2LCAxdSksIHJlZl9kaXZfbWF4KTsKPiAtCSpmYl9kaXYgPSBt
YXgobm9tICogKnJlZl9kaXYgKiBwb3N0X2RpdiAvIGRlbiwgMXUpOwo+ICsJKmZiX2RpdiA9IERJ
Vl9ST1VORF9DTE9TRVNUKG5vbSAqICpyZWZfZGl2ICogcG9zdF9kaXYsIGRlbik7Cj4gICAKPiAg
IAkvKiBsaW1pdCBmYiBkaXZpZGVyIHRvIGl0cyBtYXhpbXVtICovCj4gICAJaWYgKCpmYl9kaXYg
PiBmYl9kaXZfbWF4KSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
