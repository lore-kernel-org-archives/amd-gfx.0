Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE29C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 15:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B95164DEF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 15:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B95164DEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101F16E986;
	Thu, 28 Jan 2021 15:25:27 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCEE6E984
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 15:25:25 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id 16so5950202ioz.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1gePIAaInQWN5YqooM/J4U5arnmWFA3AAFJXuX5h5cI=;
 b=gjB248j6jbeTirWkNUrHNcNxA7CPKBsAFqwxby0qhq0nT9P5phjS1ZqptneHAD1+03
 blwtiUsxr5NdJNvajfuL9fMlAap++WqfyWpS31QiXe+9/V67N9NMW4okHeL94tgJ8qx7
 +VYhE5SHPeusQ0SHUWO2s/+cBTEitg7bqSxlk4OoPwrWTrbgmy+GOp6FBS7FSRpAZfD8
 5TAIEXesDW5LpX25bSosLiOlVAWkMPy14rC/vHKavRPIyMWak2Dgk62TBXKpmUgO0162
 HHjSGP027XqZxS9JzUdkiD6M4IyYE8EUyfdrlaeDHnhyEmmEwlA7bJ+DDKdgpVAeZ3AB
 cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=1gePIAaInQWN5YqooM/J4U5arnmWFA3AAFJXuX5h5cI=;
 b=knw7JSlrlA7Cdf+0RUK3WBUb2iMLcc5f0b5TygrwBHgin4H9aje/g0P5eZevzD9hCL
 q7Fz4cQOVBrqYNli13QQrJGBI+VM2TGBW4v1h5I/uqgD5XzQczG9tRVHW4NbJmu5e2rY
 j7rpyIOgoy4zjVLRz1rpyaPBVe3WaB+UhIBoyUmHypoWo0aJFCj647tZ++Xz84TpnHFC
 lReyTE/ayuK8W0j7CKVGxWS+4UMqnqdDPODFsZqRcSsre7u0cxoqNz9HODQRedUygf9A
 xLHQL5Nli0R9Ah0UVE51ytNbmIbD6AffjPUaHlJkhN+khODwdnpsi9nHt+fK2xA3yr4O
 +51w==
X-Gm-Message-State: AOAM530dafWknd9YIBjiDShasj86nqy8EcV6CkRrXNVPyc8dTMfuvo+T
 QoZs6EWgzE95Q6y7UYsB4gE=
X-Google-Smtp-Source: ABdhPJyoCTG3ufq1BPhswwJP6yBRyS6rZakPIk54awCllDtRETt/KamrCa4lns2j/CBrhns/cWBK6w==
X-Received: by 2002:a5e:8812:: with SMTP id l18mr59838ioj.149.1611847525031;
 Thu, 28 Jan 2021 07:25:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n193sm2268497iod.21.2021.01.28.07.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 07:25:24 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: Nirmoy <nirmodas@amd.com>, christian.koenig@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210128143554.61100-1-nirmoy.das@amd.com>
 <20210128143554.61100-2-nirmoy.das@amd.com>
 <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
 <a44f5a1a-4be3-06a0-764d-23918a51698f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4cd8a507-f472-3394-55c2-b55fee588040@gmail.com>
Date: Thu, 28 Jan 2021 16:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a44f5a1a-4be3-06a0-764d-23918a51698f@amd.com>
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
Cc: Alan.Harrison@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDEuMjEgdW0gMTY6MjEgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxLzI4LzIxIDM6NDkg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI4LjAxLjIxIHVtIDE1OjM1IHNjaHJp
ZWIgTmlybW95IERhczoKPj4+IEVuYWJsZSBnZnggd2F2ZSBsaW1pdGluZyBmb3IgZ2Z4IGpvYnMg
YmVmb3JlIHB1c2hpbmcgaGlnaCBwcmlvcml0eQo+Pj4gY29tcHV0ZSBqb2JzIHNvIHRoYXQgaGln
aCBwcmlvcml0eSBjb21wdXRlIGpvYnMgZ2V0cyBtb3JlIHJlc291cmNlcwo+Pj4gdG8gZmluaXNo
IGVhcmx5Lgo+Pgo+PiBUaGUgcHJvYmxlbSBoZXJlIGlzIHdoYXQgaGFwcGVucyBpZiB5b3UgaGF2
ZSBtdWx0aXBsZSBoaWdoIHByaW9yaXR5IAo+PiBqb2JzIHJ1bm5pbmcgYXQgdGhlIHNhbWUgdGlt
ZT8KPgo+Cj4gQUZBSVUsIGluIHRoYXQgY2FzZSBxdWFudHVtIGR1cmF0aW9uIHdpbGwgY29tZSBp
bnRvIGVmZmVjdC4gVGhlIHF1ZXVlIAo+IGFyYml0ZXIgd2lsbCBzd2l0Y2gKPgo+IHRvIG5leHQg
aGlnaCBwcmlvcml0eSBhY3RpdmUgcXVldWUgb25jZSBxdWFudHVtIGR1cmF0aW9uIGV4cGlyZXMu
IFRoaXMgCj4gc2hvdWxkIGJlIHNpbWlsYXIgdG8gd2hhdAo+Cj4gd2UgYWxyZWFkeSBoYXZlLCBt
dWx0aXBsZSBub3JtYWwgcHJpb3JpdHkgam9icyBzaGFyaW5nIEdQVSByZXNvdXJjZXMgCj4gYmFz
ZWQgb24gQ1BfSFFEX1FVQU5UVU0uCj4KPiBRVUVVRV9EVVJBVElPTiByZWdpc3RlciB2YWx1ZS4K
ClllYWgsIGJ1dCB3aGVuIHRoZSBmaXJzdCBoaWdoIHByaW9yaXR5IGpvYiBjb21wbGV0ZXMgaXQg
d2lsbCByZXNldCAKbW1TUElfV0NMX1BJUEVfUEVSQ0VOVF9HRlggYmFjayB0byB0aGUgZGVmYXVs
dCB2YWx1ZS4KCkhhdmUgeW91IGNvbnNpZGVyZWQgdGhhdD8KClRoYW5rcywKQ2hyaXN0aWFuLgoK
Pgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1veQo+Cj4KPj4KPj4gQ2hyaXN0aWFuCj4+Cj4+Pgo+Pj4g
U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+Pj4gLS0tCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDkgKysrKysrKysr
Cj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIAo+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4gaW5kZXggMDI0ZDBhNTYzYTY1Li5l
ZTQ4OTg5ZGZiNGMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2li
LmMKPj4+IEBAIC0xOTUsNiArMTk1LDEwIEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0
IGFtZGdwdV9yaW5nIAo+Pj4gKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsCj4+PiDCoMKgwqDCoMKg
IGlmICgoaWItPmZsYWdzICYgQU1ER1BVX0lCX0ZMQUdfRU1JVF9NRU1fU1lOQykgJiYgCj4+PiBy
aW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5m
dW5jcy0+ZW1pdF9tZW1fc3luYyhyaW5nKTsKPj4+IMKgICvCoMKgwqAgaWYgKHJpbmctPmZ1bmNz
LT5lbWl0X3dhdmVfbGltaXQgJiYgam9iICYmCj4+PiArwqDCoMKgwqDCoMKgwqAgam9iLT5iYXNl
LnNfcHJpb3JpdHkgPj0gRFJNX1NDSEVEX1BSSU9SSVRZX0hJR0gpCj4+PiArwqDCoMKgwqDCoMKg
wqAgcmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdChyaW5nLCB0cnVlKTsKPj4+ICsKPj4+IMKg
wqDCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5pbnNlcnRfc3RhcnQpCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmluZy0+ZnVuY3MtPmluc2VydF9zdGFydChyaW5nKTsKPj4+IMKgIEBAIC0yOTUsNiAr
Mjk5LDExIEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nIAo+Pj4g
KnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsCj4+PiDCoMKgwqDCoMKgIHJpbmctPmN1cnJlbnRfY3R4
ID0gZmVuY2VfY3R4Owo+Pj4gwqDCoMKgwqDCoCBpZiAodm0gJiYgcmluZy0+ZnVuY3MtPmVtaXRf
c3dpdGNoX2J1ZmZlcikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfcmluZ19lbWl0X3N3
aXRjaF9idWZmZXIocmluZyk7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChyaW5nLT5mdW5jcy0+ZW1p
dF93YXZlX2xpbWl0ICYmIGpvYiAmJgo+Pj4gK8KgwqDCoMKgwqDCoMKgIGpvYi0+YmFzZS5zX3By
aW9yaXR5ID49IERSTV9TQ0hFRF9QUklPUklUWV9ISUdIKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJp
bmctPmZ1bmNzLT5lbWl0X3dhdmVfbGltaXQocmluZywgZmFsc2UpOwo+Pj4gKwo+Pj4gwqDCoMKg
wqDCoCBhbWRncHVfcmluZ19jb21taXQocmluZyk7Cj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+
Pj4gwqAgfQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3Qzc0
MjgwYmU0NjU4ZDQyOWMwY2Q4MDhkOGMzOWJlMTQ5JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ3NDQyMTU2MTE3MzM3NCU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1UQTJ1aDQwVTVDJTJGaHJ2c2hXM3FxODVC
YnViS2wlMkZMaFNwQzcyNVhpcjlXUSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
