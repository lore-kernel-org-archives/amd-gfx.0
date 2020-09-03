Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DDC433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 07:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CF020775
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SExNkR1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CF020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A16F6E197;
	Thu,  3 Sep 2020 07:57:05 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F0C6E197
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 07:57:04 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e17so1863145wme.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3xBYF5cfwh6JPjufmny/81WfMdtcSyq+oRcbcnolf7k=;
 b=SExNkR1DUWj8N6N6cDc2+8fe3g1x5fL2BufgQsztQqFC8GdNezg47ktWp/wKt9ImCE
 8wjnlq369DnslQLTSmgv5aPDcgCInZ3Wc+YGg8ASG98skcIicxWTmEI9ogqr+L2QAipo
 Txo+mLSdio+wl5hUll3HB2lHC+Lmhtxy7CcXbi33q6pZn8svbTJtiKRe9e0ItYQg2t/U
 0BgLnFsgMwnlrVYHqUiyv6VeVk5hHOnak1Y7XLMrwO4GM9xoPBKYY/rapbxqX+BtGJrE
 UeIAaBrXHCaxunbEyVb++XNUazEqYjToTV7reE+d7Rb6q5GdvSBSFnA9fZIAy4osKtd1
 Y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=3xBYF5cfwh6JPjufmny/81WfMdtcSyq+oRcbcnolf7k=;
 b=TKeT9DelWjZ4+z+LF+bO/U6o7qLC6eXiHgIfmbSymKKFV3y+QfRxv1/cLJ9yIGFHBm
 lqeRE//ElnJlNkefcpP93Ze1Ty8ZtNX19w8ZrzzRZ1ri9iQesjpahYQcPvsItERwJgUg
 Y2m9rECpLOShQiLqEr0Mk+aNGL+ACC1ePTdEQ3srh7QRYOFbuibqceTO9XLp+vhEvMtP
 nqzUPlicvMXlbQ71VTBFYnE6PwYesi1qr63QL5Zh1mzvlBbjzZR/lCVRrvUD33/ETeJ2
 TI0rXnB9cS9q4gY63mAnEEM/GQ9n1dcXpztuihl7OIJZKvVjnI/MIUWbLu1RN7sDKAo/
 FSng==
X-Gm-Message-State: AOAM533a1O/NsM1gXye5uOTbkj5W1bmFAetMbeO2hHGEFkUwMiIRx4O3
 01U2+stInN8DvLu/h5MPgF5OHV9ehzY=
X-Google-Smtp-Source: ABdhPJxwjuwzoZLP6pKaUVec9eulTPHRmxT1p1xRNCaAUdsnuW+H42Q3lkOQ9iUvFTddvQ7tnPJ4lQ==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1077291wmc.81.1599119823161; 
 Thu, 03 Sep 2020 00:57:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c18sm3396935wrx.63.2020.09.03.00.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 00:57:02 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v3
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200902152101.2280-1-christian.koenig@amd.com>
 <03C90896-08CE-46DA-B3B0-F755ED4A399F@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <39b0f7fa-bdd0-2c58-205a-c830fb878f36@gmail.com>
Date: Thu, 3 Sep 2020 09:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <03C90896-08CE-46DA-B3B0-F755ED4A399F@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMTg6MTUgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Oeac
iDLml6UgMjM6MjHvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IENhbGN1bGF0ZSB0aGUgY29ycmVjdCB2YWx1ZSBmb3Ig
bWF4X2VudHJpZXMgb3Igd2UgbWlnaHQgcnVuIGFmdGVyIHRoZQo+PiBwYWdlX2FkZHJlc3MgYXJy
YXkuCj4+Cj4+IHYyOiBYaW5odWkgcG9pbnRlZCBvdXQgd2UgZG9uJ3QgbmVlZCB0aGUgc2hpZnQK
Pj4gdjM6IHVzZSBsb2NhbCBjb3B5IG9mIHN0YXJ0IGFuZCBzaW1wbGlmeSBzb21lIGNhbGN1bGF0
aW9uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPj4gRml4ZXM6IDFlNjkxZTI0NDQ4NyBkcm0vYW1kZ3B1OiBzdG9wIGFsbG9j
YXRpbmcgZHVtbXkgR1RUIG5vZGVzCj4+IC0tLQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyB8IDQgKystLQo+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+PiBpbmRleCA4YmMyMjUzOTM5YmUuLjdjYmVlMWE3ZWM4NCAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTE2OTcsNyArMTY5Nyw3IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4+IAkJCQlBTURHUFVfR1BVX1BBR0VTX0lOX0NQVV9QQUdFOwo+PiAJCX0gZWxzZSB7Cj4+
IAkJCWFkZHIgPSAwOwo+PiAtCQkJbWF4X2VudHJpZXMgPSBTNjRfTUFYOwo+PiArCQkJbWF4X2Vu
dHJpZXMgPSBtYXBwaW5nLT5sYXN0IC0gc3RhcnQgKyAxOwo+PiAJCX0KPj4KPj4gCQlpZiAocGFn
ZXNfYWRkcikgewo+PiBAQCAtMTcyNyw3ICsxNzI3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1f
Ym9fc3BsaXRfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gCQkJYWRkciAr
PSBwZm4gPDwgUEFHRV9TSElGVDsKPj4gCQl9Cj4+Cj4+IC0JCWxhc3QgPSBtaW4oKHVpbnQ2NF90
KW1hcHBpbmctPmxhc3QsIHN0YXJ0ICsgbWF4X2VudHJpZXMgLSAxKTsKPj4gKwkJbGFzdCA9IHN0
YXJ0ICsgbWF4X2VudHJpZXMgLSAxOwo+IEkgYW0gbm90IHN1cmUgaWYgd2UgY2FsY3VsYXRlIHRo
ZSBtYXhfZW50cmllcyBieSBub2Rlcy0+c2l6ZS4gZG9lcyBpdCB3b3JrIGluIHRoYXQgY2FzZT8K
Ck9oLCBnb29kIHBvaW50LiBXaGVuIHRoZSBWQSByYW5nZSBiZXR3ZWVuIHN0YXJ0IGFuZCBsYXN0
IGlzIHNtYWxsZXIgdGhhbiAKdGhlIGJ1ZmZlciBpdHNlbGYgd2UgY291bGQgaW5kZWVkIG92ZXJy
dW4gaGVyZS4gR29pbmcgdG8gZml4IHRoYXQuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPj4gCQly
ID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIHZtLCBmYWxzZSwgZmFsc2UsIHJl
c3YsCj4+IAkJCQkJCXN0YXJ0LCBsYXN0LCBmbGFncywgYWRkciwKPj4gCQkJCQkJZG1hX2FkZHIs
IGZlbmNlKTsKPj4gLS0gCj4+IDIuMTcuMQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N4aW5odWku
cGFuJTQwYW1kLmNvbSU3Q2JiMmMyNDU2NTM0ODQyZDI0ZTljMDhkODRmNTNjZmMzJTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM0NjU2ODY3MzcwMzg2OCZh
bXA7c2RhdGE9ckxCM01FMjVBa3lSYVA2a2QzSnhPa3ZxejNpU0toSHU5Ymtabk1NcVM3NCUzRCZh
bXA7cmVzZXJ2ZWQ9MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
