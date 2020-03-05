Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0AC3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AAD2073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4O2XReh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AAD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCF06E25B;
	Thu,  5 Mar 2020 11:30:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A51E6E25B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:30:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id m3so5339721wmi.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Dhw2AoffvYsoFAaAKFnKrqZqtsRTOlPZSiDJnw6JDzQ=;
 b=Z4O2XRehVYSwOwEYvV6AYGkXr1zo6T9jtjGBDv8I7LsjiMabxH7gVpWsbEvLbOsX2T
 L6VdmtQ8oeJRu+WEQqROWX/JMsEM6Eh5a+bxYukbRsDk3mr+TgIRdkYTIwvMnipJEHjZ
 EHOab4vZ07M1G/NC/WXY+oNpuMdyGWps9j9qv3ixWt7Tyu172CFWlV9F6xVv4+bsZMAB
 NauePpbCeliskH+yeUP0akyYLMnmQnH8pH6KoMmz/cPGBTXHsoB+o8ZW5W4PP4hoRdZj
 hJZdCSW7tQWXcGV/TvzISrf+d5JYlp7Xv53P/VIEwVgeC0j/9Nr03RXcmKEhWgMiUbUz
 Wi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Dhw2AoffvYsoFAaAKFnKrqZqtsRTOlPZSiDJnw6JDzQ=;
 b=DSGUAvclQse4Ixe506U//bdFdz0MqwMT8s1j6/d+VyA2mNchZ+G8dePmYvS96m+vlB
 gyb3XpwRc0/Pm+zT64/GA0XGmeu7etU/DvN0cwRTBMaP47wwDkmamnoVjh5SEI13xLpJ
 ED/NtdBzm8BOSh8lyB9F9UTRug06rjfI4PqoqnMy8xM7ex+FtH0NF656Jafu67Ugbz2a
 5LPuWYw5dTpTFJS3z4jnsY4WvpAADCdROQTIWGWGOwy04tE0HS4mQ3c+HlP59CRPu2OI
 6XXX7KM76SkiK+twtuNt3uHyqBOb9PY+8gjktJBaArgt6mNdr/ut4LcFZNNsJKJMRskS
 EdWw==
X-Gm-Message-State: ANhLgQ1eTH/1Ia7SN7P822d3IWlhv6yclygZ7JCFIdVWfnlrpB92nGSU
 zKBU9iih6JcQsH1Z/oqttqhqjR97
X-Google-Smtp-Source: ADFU+vu3VWMyI8tHBy7RKpxH2Ikcm/FftZhBOWv11qcYGG8LmXzHRCRfiDNsSmIhX4q92L/L5e+jtg==
X-Received: by 2002:a05:600c:2194:: with SMTP id
 e20mr8174586wme.15.1583407817683; 
 Thu, 05 Mar 2020 03:30:17 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y3sm9571040wmi.14.2020.03.05.03.30.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 03:30:17 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: Add more comments on GFX9 user CP queue MQD
 workaround
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200304194051.9189-1-Yong.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <180859fd-cfc2-4c93-169e-ca8e1af7d361@gmail.com>
Date: Thu, 5 Mar 2020 12:30:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304194051.9189-1-Yong.Zhao@amd.com>
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

QW0gMDQuMDMuMjAgdW0gMjA6NDAgc2NocmllYiBZb25nIFpoYW86Cj4gQmVjYXVzZSB0b28gbWFu
eSB0aGluZ3MgYXJlIGludm9sdmVkIGluIHRoaXMgd29ya2Fyb3VuZCwgd2UgbmVlZCBtb3JlCj4g
Y29tbWVudHMgdG8gYXZvaWQgcGl0ZmFsbHMuCj4KPiBDaGFuZ2UtSWQ6IEk1ZDc5MTcyOTZkZDVm
NWVkYjQ1OTIxMTE4Y2Y4ZTdkNzc4ZDQwZGUxCj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZ
b25nLlpoYW9AYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jICAgICAgICB8ICA1ICsrKystCj4gICAuLi4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl92OS5jICAgIHwgMTggKysrKysrKysrKysrKysrLS0tCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggMTk0N2EzMjZkZTU3Li4xMGY2ZjRi
MjFiNDQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAg
LTEwNDEsNyArMTA0MSwxMCBAQCBpbnQgYW1kZ3B1X3R0bV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICAJCWlmIChyKQo+ICAgCQkJZ290byBnYXJ0X2JpbmRfZmFpbDsK
PiAgIAo+IC0JCS8qIFBhdGNoIG10eXBlIG9mIHRoZSBzZWNvbmQgcGFydCBCTyAqLwo+ICsJCS8q
IFRoZSBtZW1vcnkgdHlwZSBvZiB0aGUgZmlyc3QgcGFnZSBkZWZhdWx0cyB0byBVQy4gTm93Cj4g
KwkJICogbW9kaWZ5IHRoZSBtZW1vcnkgdHlwZSB0byBOQyBmcm9tIHRoZSBzZWNvbmQgcGFnZSBv
Zgo+ICsJCSAqIHRoZSBCTyBvbndhcmQuCj4gKwkJICovCj4gICAJCWZsYWdzICY9IH5BTURHUFVf
UFRFX01UWVBFX1ZHMTBfTUFTSzsKPiAgIAkJZmxhZ3MgfD0gQU1ER1BVX1BURV9NVFlQRV9WRzEw
KEFNREdQVV9NVFlQRV9OQyk7Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+IGluZGV4IDQzNmI3ZjUxODk3OS4uNWIxMTE5MGZmNmU2
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdl
cl92OS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3Y5LmMKPiBAQCAtODcsOSArODcsMjEgQEAgc3RhdGljIHN0cnVjdCBrZmRfbWVtX29iaiAqYWxs
b2NhdGVfbXFkKHN0cnVjdCBrZmRfZGV2ICprZmQsCj4gICAJaW50IHJldHZhbDsKPiAgIAlzdHJ1
Y3Qga2ZkX21lbV9vYmogKm1xZF9tZW1fb2JqID0gTlVMTDsKPiAgIAo+IC0JLyogRnJvbSBWOSwg
IGZvciBDV1NSLCB0aGUgY29udHJvbCBzdGFjayBpcyBsb2NhdGVkIG9uIHRoZSBuZXh0IHBhZ2UK
PiAtCSAqIGJvdW5kYXJ5IGFmdGVyIHRoZSBtcWQsIHdlIHdpbGwgdXNlIHRoZSBndHQgYWxsb2Nh
dGlvbiBmdW5jdGlvbgo+IC0JICogaW5zdGVhZCBvZiBzdWItYWxsb2NhdGlvbiBmdW5jdGlvbi4K
PiArCS8qIEZvciBWOSBvbmx5LCBkdWUgdG8gYSBIVyBidWcsIHRoZSBjb250cm9sIHN0YWNrIG9m
IGEgdXNlciBtb2RlCj4gKwkgKiBjb21wdXRlIHF1ZXVlIG5lZWRzIHRvIGJlIGFsbG9jYXRlZCBq
dXN0IGJlaGluZCB0aGUgcGFnZSBib3VuZGFyeQo+ICsJICogb2YgaXRzIHJlZ3VsYXIgTVFEIGJ1
ZmZlci4gU28gd2UgYWxsb2NhdGUgYW4gZW5sYXJnZWQgTVFEIGJ1ZmZlcjoKPiArCSAqIHRoZSBm
aXJzdCBwYWdlIG9mIHRoZSBidWZmZXIgc2VydmVzIGFzIHRoZSByZWd1bGFyIE1RRCBidWZmZXIK
PiArCSAqIHB1cnBvc2UgYW5kIHRoZSByZW1haW5pbmcgaXMgZm9yIGNvbnRyb2wgc3RhY2suIEFs
dGhvdWdoIHRoZSB0d28KPiArCSAqIHBhcnRzIGFyZSBpbiB0aGUgc2FtZSBidWZmZXIgb2JqZWN0
LCB0aGV5IG5lZWQgZGlmZmVyZW50IG1lbW9yeQo+ICsJICogdHlwZXM6IE1RRCBwYXJ0IG5lZWRz
IFVDICh1bmNhY2hlZCkgYXMgdXN1YWwsIHdoaWxlIGNvbnRyb2wgc3RhY2sKPiArCSAqIG5lZWRz
IE5DIChub24gY29oZXJlbnQpLCB3aGljaCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgVUMgdHlwZSB3
aGljaAo+ICsJICogaXMgdXNlZCB3aGVuIGNvbnRyb2wgc3RhY2sgaXMgYWxsb2NhdGVkIGluIHVz
ZXIgc3BhY2UuCj4gKwkgKgo+ICsJICogQmVjYXVzZSBvZiBhbGwgdGhvc2UsIHdlIHVzZSB0aGUg
Z3R0IGFsbG9jYXRpb24gZnVuY3Rpb24gaW5zdGVhZAo+ICsJICogb2Ygc3ViLWFsbG9jYXRpb24g
ZnVuY3Rpb24gZm9yIHRoaXMgZW5sYXJnZWQgTVFEIGJ1ZmZlci4gTW9yZW92ZXIsCj4gKwkgKiBp
biBvcmRlciB0byBhY2hpZXZlIHR3byBtZW1vcnkgdHlwZXMgaW4gYSBzaW5nbGUgYnVmZmVyIG9i
amVjdCwgd2UKPiArCSAqIHBhc3MgYSBzcGVjaWFsIGJvIGZsYWcgQU1ER1BVX0dFTV9DUkVBVEVf
TVFEX0dGWDkgdG8gaW5zdHJ1Y3QKPiArCSAqIGFtZGdwdSBtZW1vcnkgZnVuY3Rpb25zIHRvIGRv
IHNvLgo+ICAgCSAqLwo+ICAgCWlmIChrZmQtPmN3c3JfZW5hYmxlZCAmJiAocS0+dHlwZSA9PSBL
RkRfUVVFVUVfVFlQRV9DT01QVVRFKSkgewo+ICAgCQltcWRfbWVtX29iaiA9IGt6YWxsb2Moc2l6
ZW9mKHN0cnVjdCBrZmRfbWVtX29iaiksIEdGUF9LRVJORUwpOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
