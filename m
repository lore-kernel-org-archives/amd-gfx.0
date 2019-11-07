Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B96DC5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 11:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4B521882
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 11:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4B521882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475586F659;
	Thu,  7 Nov 2019 11:28:17 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0963A6F659
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 11:28:16 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id h3so2539009wrx.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 03:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=dDspoWPHhgt/txZ0UI2CnAOnhKbH5qslbTxvMCjmVnk=;
 b=rCMPjVmFiH8yVahtFd9dySO+3GAu6jVH4nkZEcRINzx64+BgqPeCBaVQdIDqs7oyXx
 DNqXyfeHlmlMePENhfgTTeXsFaWhBQ5Mw0CX8hlJXwscMgWkAZ5Irlx4cdQAx9QVWWlJ
 yAh0Dvf7ieJMHllL0JXsLX6Rh+6Ad7G40o8ln4ZzzQc9jB1RmDQKBOjSg37h/B6wOlM4
 UtAVRSzcb2s7VI5jMCIddBvKLvjse1WUIA1XJQaOD8hsnwee+oM+68RgkU8m3MIXuoYT
 4z+pLDZSvZhH5dZvKVk6kLkVhuNkHvxt3gFj2gSz/v4QAWx+uOkoHXIQ/HAyoXoPL/O8
 Sl3w==
X-Gm-Message-State: APjAAAU+Kdl/2Ecj++6EvQaqviYzelH2iP8jX3yOtUdOc+dnSD9w0AzF
 cL336aT+hmNy48lWj18/Bvm9KVqn
X-Google-Smtp-Source: APXvYqy7eTB9ujYOvd7b/wCiwa3jqXXWhHLoEdxtI4XnZXxl480K3Yj0GgxhT2CFfb6vn+AsztNMWg==
X-Received: by 2002:a5d:4047:: with SMTP id w7mr2376411wrp.270.1573126094487; 
 Thu, 07 Nov 2019 03:28:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z13sm2126146wrm.64.2019.11.07.03.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 03:28:13 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
Date: Thu, 7 Nov 2019 12:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dDspoWPHhgt/txZ0UI2CnAOnhKbH5qslbTxvMCjmVnk=;
 b=ZdxjwRVrAQ7HCsi6wuBFUYCEoEFx9NRCAm1SLkCwk531QQL+QEbaqkE4Chqc+QJI9h
 4owZyxX3ivosxsLDYalLn4kgIAEqvcce70ZT6AXC5TLk8nqjZl4K8QYGVECQPDqGmLme
 Rn+sbwze0MQN63EyqGrHLOcjPMc9qZQUiM5h2Mhpmceno87ha+yXOfOkyUJXnJAFlcsn
 HNlVk3Xf/ppVaNOlMQDjCnNJKHeOhALJ/dIbiJQxLNOh3y/P4mgWUE5BCUYseaMiEFP+
 SdIKdtko9N9iDJmqc/QrBFp2NtArQYBsol5AtrSKavBOuaIJGK1HofemqyOHUL5zth6s
 E4dw==
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
Message-ID: <20191107112812.Fj6mBQaPE4pT_PPWGisAG_05BlUUmgtSrXSVJQyuwOo@z>

QW0gMDcuMTEuMTkgdW0gMTE6MjUgc2NocmllYiBFbWlseSBEZW5nOgo+IFdoZW4gdGhlIGpvYiBp
cyBhbHJlYWR5IHNpZ25hbGVkLCB0aGUgc19mZW5jZSBpcyBmcmVlZC4gVGhlbiBpdCB3aWxsIGhh
cwo+IG51bGwgcG9pbnRlciBpbiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyLgoKTkFLLCB0aGUg
c19mZW5jZSBpcyBvbmx5IHNldCB0byBOVUxMIHdoZW4gdGhlIGpvYiBpcyBkZXN0cm95ZWQuIFNl
ZSAKZHJtX3NjaGVkX2pvYl9jbGVhbnVwKCkuCgpXaGVuIHlvdSBzZWUgYSBqb2Igd2l0aG91dCBh
biBzX2ZlbmNlIHRoZW4gdGhhdCBtZWFucyB0aGUgcHJvYmxlbSBpcyAKc29tZXdoZXJlIGVsc2Uu
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1p
bHkuRGVuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgIDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRf
bWFpbi5jICAgICB8IDExICsrKysrKy0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKPiBpbmRleCBlNmNlOTQ5Li41YThmMDhlIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC00MDc1LDcgKzQwNzUsNyBA
QCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPiAgIAkgKgo+ICAgCSAqIGpvYi0+YmFzZSBob2xkcyBhIHJlZmVyZW5jZSB0byBwYXJlbnQg
ZmVuY2UKPiAgIAkgKi8KPiAtCWlmIChqb2IgJiYgam9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCAm
Jgo+ICsJaWYgKGpvYiAmJiBqb2ItPmJhc2Uuc19mZW5jZSAmJiBqb2ItPmJhc2Uuc19mZW5jZS0+
cGFyZW50ICYmCj4gICAJICAgIGRtYV9mZW5jZV9pc19zaWduYWxlZChqb2ItPmJhc2Uuc19mZW5j
ZS0+cGFyZW50KSkKPiAgIAkJam9iX3NpZ25hbGVkID0gdHJ1ZTsKPiAgIAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXggMzE4MDljYS4uNTZjYzEwZSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gQEAgLTMzNCw4ICszMzQsOCBA
QCB2b2lkIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFk
KQo+ICAgCj4gICAJCQlzcGluX2xvY2soJnJxLT5sb2NrKTsKPiAgIAkJCWxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZShlbnRpdHksIHRtcCwgJnJxLT5lbnRpdGllcywgbGlzdCkgewo+IC0JCQkJaWYg
KGJhZC0+c19mZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQgPT0KPiAtCQkJCSAgICBlbnRpdHktPmZl
bmNlX2NvbnRleHQpIHsKPiArCQkJCWlmIChiYWQtPnNfZmVuY2UgJiYgKGJhZC0+c19mZW5jZS0+
c2NoZWR1bGVkLmNvbnRleHQgPT0KPiArCQkJCSAgICBlbnRpdHktPmZlbmNlX2NvbnRleHQpKSB7
Cj4gICAJCQkJCWlmIChhdG9taWNfcmVhZCgmYmFkLT5rYXJtYSkgPgo+ICAgCQkJCQkgICAgYmFk
LT5zY2hlZC0+aGFuZ19saW1pdCkKPiAgIAkJCQkJCWlmIChlbnRpdHktPmd1aWx0eSkKPiBAQCAt
Mzc2LDcgKzM3Niw3IEBAIHZvaWQgZHJtX3NjaGVkX3N0b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1
bGVyICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCkKPiAgIAkgKiBUaGlzIGl0ZXJh
dGlvbiBpcyB0aHJlYWQgc2FmZSBhcyBzY2hlZCB0aHJlYWQgaXMgc3RvcHBlZC4KPiAgIAkgKi8K
PiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShzX2pvYiwgdG1wLCAmc2NoZWQt
PnJpbmdfbWlycm9yX2xpc3QsIG5vZGUpIHsKPiAtCQlpZiAoc19qb2ItPnNfZmVuY2UtPnBhcmVu
dCAmJgo+ICsJCWlmIChzX2pvYi0+c19mZW5jZSAmJiBzX2pvYi0+c19mZW5jZS0+cGFyZW50ICYm
Cj4gICAJCSAgICBkbWFfZmVuY2VfcmVtb3ZlX2NhbGxiYWNrKHNfam9iLT5zX2ZlbmNlLT5wYXJl
bnQsCj4gICAJCQkJCSAgICAgICZzX2pvYi0+Y2IpKSB7Cj4gICAJCQlhdG9taWNfZGVjKCZzY2hl
ZC0+aHdfcnFfY291bnQpOwo+IEBAIC0zOTUsNyArMzk1LDggQEAgdm9pZCBkcm1fc2NoZWRfc3Rv
cChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAq
YmFkKQo+ICAgCQkJICoKPiAgIAkJCSAqIEpvYiBpcyBzdGlsbCBhbGl2ZSBzbyBmZW5jZSByZWZj
b3VudCBhdCBsZWFzdCAxCj4gICAJCQkgKi8KPiAtCQkJZG1hX2ZlbmNlX3dhaXQoJnNfam9iLT5z
X2ZlbmNlLT5maW5pc2hlZCwgZmFsc2UpOwo+ICsJCQlpZiAoc19qb2ItPnNfZmVuY2UpCj4gKwkJ
CQlkbWFfZmVuY2Vfd2FpdCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVkLCBmYWxzZSk7Cj4gICAK
PiAgIAkJCS8qCj4gICAJCQkgKiBXZSBtdXN0IGtlZXAgYmFkIGpvYiBhbGl2ZSBmb3IgbGF0ZXIg
dXNlIGR1cmluZwo+IEBAIC00MzgsNyArNDM5LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RhcnQoc3Ry
dWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgYm9vbCBmdWxsX3JlY292ZXJ5KQo+ICAgCSAq
IEdQVSByZWNvdmVycyBjYW4ndCBydW4gaW4gcGFyYWxsZWwuCj4gICAJICovCj4gICAJbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZlKHNfam9iLCB0bXAsICZzY2hlZC0+cmluZ19taXJyb3JfbGlzdCwg
bm9kZSkgewo+IC0JCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gc19qb2ItPnNfZmVuY2UtPnBh
cmVudDsKPiArCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IHNfam9iLT5zX2ZlbmNlID8gc19q
b2ItPnNfZmVuY2UtPnBhcmVudCA6IE5VTEw7Cj4gICAKPiAgIAkJYXRvbWljX2luYygmc2NoZWQt
Pmh3X3JxX2NvdW50KTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
