Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB5C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4612075C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4612075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E816E313;
	Tue, 26 Nov 2019 12:20:11 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADB86E30F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 12:20:09 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so22209658wrr.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 04:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GEq3EfvaYNkaRWa37zSJ6Fk62LSWy/fRUCFLuX40ISY=;
 b=auvsfLRxMDRFotKLtp2i18jMi8XpuOAUBas1/BIg7OFd1fiSYP/SrfX0sgvl/wHzlL
 fUPSRI4uqFYz48QFBl77nNzPZQJ6lK388xCuWavLsjZAHlLCEpt7fSWikCWHZuCQP2SZ
 0IcWJuk6WBvfGsUppyCoPMh3ucY11PW1ximXbgHdpw4iYFAghiUsmZY7/pM3VCNXATUj
 HVMQob1+ykyGPI9L/yE6GZNLzjxMKkgzrJFabpMfadJZ5QpJEtuM1d8AA3KlIO66fdYV
 3oQzWEn4mG/robGlVR1yUtNp9SstXgxOFHr8GXP2TOVeAHxO5YyzeVv+nvQZv3Mle1G0
 +YsQ==
X-Gm-Message-State: APjAAAX4H143LyPCAjOlEcYl9ypbUilejzUNce0VZjLh8kNpXY0Z/Cu1
 G4j0ZBDY2FQtAK0uG0Q32z4OogWD
X-Google-Smtp-Source: APXvYqw5IwGbQi1IabGDOzIyuIYhFtJ5f9ZHDka9Z2A8UnPbWrJgzcXIGpeqhx/4mZn8gxFPsxFOjg==
X-Received: by 2002:adf:f048:: with SMTP id t8mr38932273wro.237.1574770807885; 
 Tue, 26 Nov 2019 04:20:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 2sm14593657wrq.31.2019.11.26.04.20.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 04:20:07 -0800 (PST)
Subject: Re: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <74af5d01-6d42-113e-9e74-4e481bb6bf2d@gmail.com>
Date: Tue, 26 Nov 2019 13:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GEq3EfvaYNkaRWa37zSJ6Fk62LSWy/fRUCFLuX40ISY=;
 b=NZCLeRn2DXWDcCvdppCf/AQAzm1zyFpSl42c4NPXAzYOlrhKkqoa3jG1ZfsmJAkVxt
 dWNKt/pimnayu92Ky3hy3PhI3TQybiS3P74swZjTIH+DJVh8Q5zjRUMPkzq+dD0VWxVd
 iAT0Y4MD7sxQYsSRWwFPpMMDNN422R77MLVIuGtpfYBptsMPEK49n/docLIN09W1tgNq
 rdjzZ+fihfHoW4mxsvXgVano8hR/OFn1Kvz8Il0ZaLTglkDnGtQ2Iia90eDUEYsiqLQ/
 coT7ET3ELLg6Msm526FsuUuCJ/gn3ZW7DcPPBukEBzM79hV0XXz6XGqt6iqra8XvS7ah
 njYQ==
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126122006.gWpwcrvAsz8NyP0kib_goEryr9aY5xyJIKbLiPKOsyE@z>

QW0gMjYuMTEuMTkgdW0gMTI6NTAgc2NocmllYiBNb25rIExpdToKPiBvdGhlcndzZSB0aGUgZmx1
c2hfZ3B1X3RsYiB3aWxsIGhhbmcgaWYgd2UgdW5sb2FkIHRoZQo+IEtNRCBiZWN1YXNlIHRoZSBz
Y2hlZHVsZXJzIGFscmVhZHkgc3RvcHBlZAo+Cj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1v
bmsuTGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IGluZGV4
IDMyMWY4YTkuLjRiYjRkMjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYwo+IEBAIC0zMjYsNyArMzI2LDggQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dw
dV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAKPiAg
IAlpZiAoIWFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzX2VuYWJsZWQgfHwKPiAgIAkgICAgIWFkZXYt
PmliX3Bvb2xfcmVhZHkgfHwKPiAtCSAgICBhZGV2LT5pbl9ncHVfcmVzZXQpIHsKPiArCSAgICBh
ZGV2LT5pbl9ncHVfcmVzZXQgfHwKPiArCQlyaW5nLT5zY2hlZC5yZWFkeSA9PSBmYWxzZSkgewoK
R29vZCBjYXRjaCwgYnV0IHlvdSBhcmUgc29tZWhvdyBtZXNzaW5nIHVwIHRoZSBpbmRlbnRhdGlv
biBoZXJlLgoKV2l0aCB0aGF0IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gICAJCWdtY192MTBfMF9m
bHVzaF92bV9odWIoYWRldiwgdm1pZCwgQU1ER1BVX0dGWEhVQl8wLCAwKTsKPiAgIAkJbXV0ZXhf
dW5sb2NrKCZhZGV2LT5tbWFuLmd0dF93aW5kb3dfbG9jayk7Cj4gICAJCXJldHVybjsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
