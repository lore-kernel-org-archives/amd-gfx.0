Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98894C38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6765C208CA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4hWsJAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6765C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F04F6EABF;
	Fri,  8 May 2020 09:25:01 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3EF6EABF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 09:25:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m12so4571975wmc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2020 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+nxsTTlfV/u0jwZn/TO5mPoNlHEmuq0DYDNUO1pegAM=;
 b=O4hWsJAkzLXQzKczEt2RPT4AMJqEPZutkOd0y2G31n4xvOA5t+iSx+Xm6E/qKBq7rT
 fzeakLIpCnZN/KXSfvOz5ugiUeKyt1fGxdkvW+/DrT5fEG4v5bqalRkOu0z5sBcCr/Xa
 0qa7v63YN0oFHAWu/skRUQOI3XHyAuBNIkBiVjhWmucfFRQZ259UA/khuqQBoUw9eyPB
 +ebuOrDs8ztLMGeLTF9xJ2KaUYDdacEyL2YdcYIiOVhFYIMTmJSDa7gyzB/zA1PHsCn+
 q5kYFcWs10Pp1670Usb3lC7mm/vI9FqEtE61ivTURZxMvWIoYRErBPExT0T9nRtCoEjr
 DxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+nxsTTlfV/u0jwZn/TO5mPoNlHEmuq0DYDNUO1pegAM=;
 b=jW2719w+O7p5FwKwaUwe9vI3/T8Nqu82UWejnFXIAKpHGbgybs6eBF8ecBKXQOUs9e
 FlYUXqPwje6wzMSIFluMWyVJjj55VGNJgTA+V+NP08400IFvheW4BZS/77vx0FBRl+aT
 1WoQp4/kg0Wy3L4Kgs/rUJUe/82dND6TNDhYtBXKQFa3bcWc6K+NYj6q1zdYA97ELMb/
 JVLyShjYrdXBLibw46SR798Ar4HPogfh2Yx641/YyUqk624TP3ByYdjXGvxvPhXTpe3i
 8jHkwHgBPvIwhfrnH/Vl29XAMrYyV10wWzeSDoPNUmAX6NdJPWf0BcWVF/6ZTllUW29M
 SIrQ==
X-Gm-Message-State: AGi0PuYe0El0/flLxdD2Q9v0hKL7pnp/v3/dRMSwr7JjiTrRSoShEBdC
 hGcILsiDr9iil8IbUkDtu1I=
X-Google-Smtp-Source: APiQypJ1uU04iiHO/CwpJd81ECUaBUO5Ajd5DJhn64jTkYTb2KO1Ak4B71x/MnH/f9j/k5nu+O0naw==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr15939217wmy.13.1588929899477; 
 Fri, 08 May 2020 02:24:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 1sm12271955wmz.13.2020.05.08.02.24.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 May 2020 02:24:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: implement soft_recovery for gfx10
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200505164216.138189-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <69adaf85-5a3a-10d4-6d86-4b9c980f2997@gmail.com>
Date: Fri, 8 May 2020 11:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200505164216.138189-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDUuMDUuMjAgdW0gMTg6NDIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gU2FtZSBhcyBnZng5
LiAgVGhpcyBhbGxvd3MgdXMgdG8ga2lsbCB0aGUgd2F2ZXMgZm9yIGh1bmcKPiBzaGFkZXJzLgo+
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDE0
ICsrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCBkZGI0ODVlMWU5NjMu
LjI3YzYzYThmNjk4YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
Cj4gQEAgLTc2OTAsNiArNzY5MCwxOSBAQCBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfcmluZ19lbWl0
X3JlZ193cml0ZV9yZWdfd2FpdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAJCQkJCQkJ
ICAgcmVmLCBtYXNrKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCBnZnhfdjEwXzBfcmluZ19z
b2Z0X3JlY292ZXJ5KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiArCQkJCQkgdW5zaWduZWQg
dm1pZCkKPiArewo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+
ICsJdWludDMyX3QgdmFsdWUgPSAwOwo+ICsKPiArCXZhbHVlID0gUkVHX1NFVF9GSUVMRCh2YWx1
ZSwgU1FfQ01ELCBDTUQsIDB4MDMpOwo+ICsJdmFsdWUgPSBSRUdfU0VUX0ZJRUxEKHZhbHVlLCBT
UV9DTUQsIE1PREUsIDB4MDEpOwo+ICsJdmFsdWUgPSBSRUdfU0VUX0ZJRUxEKHZhbHVlLCBTUV9D
TUQsIENIRUNLX1ZNSUQsIDEpOwo+ICsJdmFsdWUgPSBSRUdfU0VUX0ZJRUxEKHZhbHVlLCBTUV9D
TUQsIFZNX0lELCB2bWlkKTsKPiArCVdSRUczMl9TT0MxNShHQywgMCwgbW1TUV9DTUQsIHZhbHVl
KTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkCj4gICBnZnhfdjEwXzBfc2V0X2dmeF9lb3BfaW50
ZXJydXB0X3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJCSAgICAgIHVp
bnQzMl90IG1lLCB1aW50MzJfdCBwaXBlLAo+IEBAIC04MTA1LDYgKzgxMTgsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92MTBfMF9yaW5nX2Z1bmNzX2dmeCA9
IHsKPiAgIAkuZW1pdF93cmVnID0gZ2Z4X3YxMF8wX3JpbmdfZW1pdF93cmVnLAo+ICAgCS5lbWl0
X3JlZ193YWl0ID0gZ2Z4X3YxMF8wX3JpbmdfZW1pdF9yZWdfd2FpdCwKPiAgIAkuZW1pdF9yZWdf
d3JpdGVfcmVnX3dhaXQgPSBnZnhfdjEwXzBfcmluZ19lbWl0X3JlZ193cml0ZV9yZWdfd2FpdCwK
PiArCS5zb2Z0X3JlY292ZXJ5ID0gZ2Z4X3YxMF8wX3Jpbmdfc29mdF9yZWNvdmVyeSwKPiAgIAku
ZW1pdF9tZW1fc3luYyA9IGdmeF92MTBfMF9lbWl0X21lbV9zeW5jLAo+ICAgfTsKPiAgIAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
