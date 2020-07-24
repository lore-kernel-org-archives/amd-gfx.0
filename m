Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E2C433FC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC0C20748
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8XN67FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC0C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB6C6E4C1;
	Fri, 24 Jul 2020 07:19:43 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567866E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 07:19:42 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id a21so8927141ejj.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nQTmIVF+1X/yL0AONv6RMH40CFbh8WWsvna1j4Kfsbk=;
 b=B8XN67FReJbvZTUvcdHUWtzs7OjwmlFN2XZA83UBg7aaBLkN0IUREWgDcocunhxaqK
 Yh9tY4WnohMS1pnMTFH11BG5hm2lFWivvOWT8XWdAF6S9Q5eSlE+fODkNN5YuQXIXW9U
 7ui35wYkCfrd5m0vOvOiJKnWkbK9WPiuZyMxeYlF/syw9qnqp47hAr6+QV4UAc5zvdYG
 YuOM0W5OabK2JuwM58iYIy2fS1bqWULvHc74z4l4CTDvGCJAM8Z1X4wRPKvWeBAyisHg
 sViDzmc1O4f7o1JXwFNx4G5fpKxbcEVDX1lICj9Nm8WqfxanjSqiOF/HtW1M7cNtiP3c
 q5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nQTmIVF+1X/yL0AONv6RMH40CFbh8WWsvna1j4Kfsbk=;
 b=KuTItV2msP4OCsWVn8kmyUjm3wVyK6wX+hOBXW5XuefYTW02aHVsQKlrg/4PfRKeK1
 R/nJ8YL1WM1XEPbPDtoU7OfVpwXuHwKqcr9hwfCij/xUXCqs6gwz384I9jnRaYYWdzig
 R2KG4ZJ6Kvati18GmvcPtYABolFgB4Mf/GMXt7KkLRQLXwGyAf8a1C6Zr84+7x0SXNAc
 4WAKz3QwLG6JY24dZUuk6yuMOyHK6o8ykyZfMI3VaDqF5iYPhm9TnyAm72s3Xkq/KDlZ
 urfZeaZLAksr1f9qvpq2JKrLY+c3tTNZMGXW/8FznT6rt3REldTcwCJ0jzBVrYdzBe1k
 elhw==
X-Gm-Message-State: AOAM531+ewppToy9sI9+/lVmresSFAiKtWtwogKH3OOJRFA7F38vDI5L
 MmYxpFdrtWxrLk9KtKgz8dYhA1dN
X-Google-Smtp-Source: ABdhPJzWJ1l70cb8LuVZ3qYwVvwxZg5fWhEdwy3pCsDrFTsa2EkqMFIm9cJEPf6bukokuH1y6vrPfw==
X-Received: by 2002:a17:906:1ec3:: with SMTP id
 m3mr8032032ejj.197.1595575180142; 
 Fri, 24 Jul 2020 00:19:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id bw7sm102640ejb.5.2020.07.24.00.19.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Jul 2020 00:19:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu/vcn3.0: remove extra asic type check
To: "Liu, Leo" <Leo.Liu@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1595520621-8216-1-git-send-email-James.Zhu@amd.com>
 <1595520621-8216-2-git-send-email-James.Zhu@amd.com>
 <DM5PR12MB178761CADC6EA0661B33ACF2E5760@DM5PR12MB1787.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <01fe10c5-110d-cbc4-f0ca-b5c3d77d393d@gmail.com>
Date: Fri, 24 Jul 2020 09:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB178761CADC6EA0661B33ACF2E5760@DM5PR12MB1787.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9y
IGJvdGguCgpBbSAyMy4wNy4yMCB1bSAyMToyOCBzY2hyaWViIExpdSwgTGVvOgo+IFRoZXNlIDIg
cGF0Y2hlcyBhcmU6Cj4KPiBSZXZpZXdlZC1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgo+
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSmFtZXMgWmh1Cj4gU2Vu
dDogSnVseSAyMywgMjAyMCAxMjoxMCBQTQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBaaHUsIEphbWVzIDxKYW1lcy5aaHVAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFU
Q0ggMi8yXSBkcm0vYW1kZ3B1L3ZjbjMuMDogcmVtb3ZlIGV4dHJhIGFzaWMgdHlwZSBjaGVjawo+
Cj4gdmNuIGlwIGJsb2NrIGlzIGFscmVhZHkgc2VsZWN0ZWQgYmFzZWQgb24gQVNJQyB0eXBlIGR1
cmluZyBzZXRfaXBfYmxvY2tzLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5a
aHVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18w
LmMgfCAyOSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjNfMC5jCj4gaW5kZXggOTEwYTRhMy4uNGVkZDVjNCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYwo+IEBAIC04OCwyMyArODgsMjAgQEAgc3RhdGljIGlu
dCB2Y25fdjNfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKPiAgIAkJYWRldi0+dmNuLm51bV9l
bmNfcmluZ3MgPSAxOwo+ICAgCj4gICAJfSBlbHNlIHsKPiAtCQlpZiAoYWRldi0+YXNpY190eXBl
ID09IENISVBfU0lFTk5BX0NJQ0hMSUQpIHsKPiAtCQkJdTMyIGhhcnZlc3Q7Cj4gLQkJCWludCBp
Owo+IC0KPiAtCQkJYWRldi0+dmNuLm51bV92Y25faW5zdCA9IFZDTl9JTlNUQU5DRVNfU0lFTk5B
X0NJQ0hMSUQ7Cj4gLQkJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyBp
KyspIHsKPiAtCQkJCWhhcnZlc3QgPSBSUkVHMzJfU09DMTUoVkNOLCBpLCBtbUNDX1VWRF9IQVJW
RVNUSU5HKTsKPiAtCQkJCWlmIChoYXJ2ZXN0ICYgQ0NfVVZEX0hBUlZFU1RJTkdfX1VWRF9ESVNB
QkxFX01BU0spCj4gLQkJCQkJYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnIHw9IDEgPDwgaTsKPiAt
CQkJfQo+ICsJCXUzMiBoYXJ2ZXN0Owo+ICsJCWludCBpOwo+ICsKPiArCQlhZGV2LT52Y24ubnVt
X3Zjbl9pbnN0ID0gVkNOX0lOU1RBTkNFU19TSUVOTkFfQ0lDSExJRDsKPiArCQlmb3IgKGkgPSAw
OyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgaSsrKSB7Cj4gKwkJCWhhcnZlc3QgPSBSUkVH
MzJfU09DMTUoVkNOLCBpLCBtbUNDX1VWRF9IQVJWRVNUSU5HKTsKPiArCQkJaWYgKGhhcnZlc3Qg
JiBDQ19VVkRfSEFSVkVTVElOR19fVVZEX0RJU0FCTEVfTUFTSykKPiArCQkJCWFkZXYtPnZjbi5o
YXJ2ZXN0X2NvbmZpZyB8PSAxIDw8IGk7Cj4gKwkJfQo+ICAgCj4gLQkJCWlmIChhZGV2LT52Y24u
aGFydmVzdF9jb25maWcgPT0gKEFNREdQVV9WQ05fSEFSVkVTVF9WQ04wIHwKPiAtCQkJCQkJQU1E
R1BVX1ZDTl9IQVJWRVNUX1ZDTjEpKQo+IC0JCQkJLyogYm90aCBpbnN0YW5jZXMgYXJlIGhhcnZl
c3RlZCwgZGlzYWJsZSB0aGUgYmxvY2sgKi8KPiAtCQkJCXJldHVybiAtRU5PRU5UOwo+IC0JCX0g
ZWxzZQo+IC0JCQlhZGV2LT52Y24ubnVtX3Zjbl9pbnN0ID0gMTsKPiArCQlpZiAoYWRldi0+dmNu
LmhhcnZlc3RfY29uZmlnID09IChBTURHUFVfVkNOX0hBUlZFU1RfVkNOMCB8Cj4gKwkJCQkJQU1E
R1BVX1ZDTl9IQVJWRVNUX1ZDTjEpKQo+ICsJCQkvKiBib3RoIGluc3RhbmNlcyBhcmUgaGFydmVz
dGVkLCBkaXNhYmxlIHRoZSBibG9jayAqLwo+ICsJCQlyZXR1cm4gLUVOT0VOVDsKPiAgIAo+ICAg
CQlhZGV2LT52Y24ubnVtX2VuY19yaW5ncyA9IDI7Cj4gICAJfQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
