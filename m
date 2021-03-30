Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EBC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334C961987
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334C961987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5186E879;
	Tue, 30 Mar 2021 08:38:00 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F79B6E879
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:37:59 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id u21so23518088ejo.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=vVsUoLiecxzk0+61TMQ1WxckKqDBLl/PmABbd75FOLk=;
 b=iN1IK2NUn4b+rvcxv6YFXog0Rtf8rYanV/1BIUiIfT/Efr+dDxPrQiNgZJfzkkCFna
 3/lViHdgpEqM+rwhCevF1r82yRyguroz8aQyf8XUxR6rdvBUmcUBGT7vBlAk7Q+i4Kpp
 A6+ymFlWnZG+g/xxhirMjKVV/xPN5uZ9/qV+D6FfDwHg1sNSFZAUZkpram+t9bvXW3wE
 mBNL64WEysDEe8FmjVWttoZtDU2EZyjN3X5y79FX9dgJ7DOF9qzKJ2Wswf6VPfzxsZvK
 eNa0/Z7XYEV7q9KzY9UKTQIebhPlgMAZBopYsgwd6f2n3A4wOxtk9dKC04Rd49m3vDwx
 T9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vVsUoLiecxzk0+61TMQ1WxckKqDBLl/PmABbd75FOLk=;
 b=NadFJv6Lc5NJ8El71F0ge4eDmKAcJ+jcUNbgW7YN8aEkLyNhrZoCKMsfwIT/1SEfyY
 iDkuVIChOnTTtOdvybanVvXmoIYkv/KB30aMLhepcYWv1yYgxJJTUhW6/kcVcgiu48x8
 JPhIHkm7lFz86QdSU3xf159AZsaGooc2Il7k/m4FdQzWw5u1AcO04TjD0ZXPdbTGGpo4
 E4Cw13kwpr7kpcvZDr8/Th8fCBXHDwYah+zcSOhE96Qj+AjgSy9Enox25ifXpEkbsu05
 6lxY495i0k7mPEboOCJoZQ+f5H/m5JqjhBgHVdsbmSpbvFRUVDhHLEZGXh0ZNwoqT3rT
 EdqQ==
X-Gm-Message-State: AOAM531uuFcqrB0r7PVzxwO/lXVFuL3oviQMZywtc4V0eRuxXwBmCXHc
 Qw5GtnueSmj3vVLnzPfjtBwTAMgiwqU=
X-Google-Smtp-Source: ABdhPJydr1pNBZDkMy9wV1IsJPK1hPe4Az4KW3VghaptSGbnuywgTIPpUo5eyffqEob0lq0UBdLJKQ==
X-Received: by 2002:a17:906:b318:: with SMTP id
 n24mr31536563ejz.372.1617093478158; 
 Tue, 30 Mar 2021 01:37:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id g12sm9695710eje.120.2021.03.30.01.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 01:37:57 -0700 (PDT)
Subject: Re: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
 <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <a9a978f1-fbd6-a90a-d966-ab2ebc2bc4f5@gmail.com>
 <BY5PR12MB41156DDEF8EAF5CE77B2AD598F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <df01f5bf-b4f0-9e93-0ef7-0caee4633fb7@gmail.com>
Date: Tue, 30 Mar 2021 10:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB41156DDEF8EAF5CE77B2AD598F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
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

SGkgRW1pbHksCgphcyBJIHNhaWQgYWRkIGEgV0FSTl9PTigpIGFuZCBsb29rIGF0IHRoZSBiYWNr
dHJhY2UuCgpJdCBjb3VsZCBiZSB0aGF0IHRoZSBiYWNrdHJhY2UgdGhlbiBqdXN0IHNob3dzIHRo
ZSBnZW5lcmFsIGNsZWFudXAgCmZ1bmN0aW9ucywgYnV0IGl0IGlzIGF0IGxlYXN0IGEgc3RhcnQu
CgpPbiB0aGUgb3RoZXIgaGFuZCBpZiB5b3Ugb25seSBzZWUgdGhpcyBzb21ldGltZXMgdGhlbiB3
ZSBoYXZlIHNvbWUga2luZCAKb2YgcmFjZSBjb25kaXRpb24gYW5kIG5lZWQgdG8gZGlnIGRlZXBl
ci4KCkNocmlzdGlhbi4KCkFtIDMwLjAzLjIxIHVtIDEwOjE5IHNjaHJpZWIgRGVuZywgRW1pbHk6
Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+
Cj4gSGkgQ2hyaXN0aWFuLAo+ICAgICAgIFllcywgSSBhZ3JlZSBib3RoIHdpdGggeW91LiBCdXQg
dGhlIGlzc3VlIG9jY3VycyByYW5kb21seSBhbmQgaW4gdW5sb2FkIGRyaXZlciBhbmQgaW4gZmFp
cmx5IGxvdyByYXRlLiBJdCBpcyBoYXJkIHRvIGRlYnVnIHdoZXJlIGlzIHRoZSBtZW1vcnkgbGVh
ay4gQ291bGQgeW91IGdpdmUgc29tZSBzdWdnZXN0aW9uIGFib3V0IGhvdwo+IHRvIGRlYnVnIHRo
aXMgaXNzdWU/Cj4KPgo+IEJlc3Qgd2lzaGVzCj4gRW1pbHkgRGVuZwo+Cj4KPgo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPj4gU2VudDogVHVlc2RheSwgTWFyY2ggMzAsIDIwMjEg
MzoxMSBQTQo+PiBUbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IENoZW4sIEpp
YW5zb25nIChTaW1vbikKPj4gPEppYW5zb25nLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNi82XSBkcm0vYW1kZ3B1OiBG
aXggZHJpdmVyIHVubG9hZCBpc3N1ZQo+Pgo+PiBHb29kIG1vcm5pbmcsCj4+Cj4+IHllcyBKaWFu
c29uZyBpcyByaWdodCB0aGF0IHBhdGNoIGlzIHJlYWxseSBub3QgYSBnb29kIGlkZWEuCj4+Cj4+
IE1vdmluZyBidWZmZXJzIGNhbiBpbmRlZWQgaGFwcGVuIGR1cmluZyBzaHV0ZG93biB3aGlsZSBz
b21lIG1lbW9yeSBpcwo+PiBzdGlsbCByZWZlcmVuY2VkLgo+Pgo+PiBKdXN0IGlnbm9yaW5nIHRo
ZSBtb3ZlIGlzIG5vdCB0aGUgcmlnaHQgYXBwcm9hY2gsIHlvdSBuZWVkIHRvIGZpbmQgb3V0IHdo
eSB0aGUKPj4gbWVtb3J5IGlzIG1vdmVkIGluIHRoZSBmaXJzdCBwbGFjZS4KPj4KPj4gWW91IGNv
dWxkIGFkZCBzb21ldGhpbmcgbGlrZSBXQVJOX09OKGFkZXYtPnNodXRkb3duKTsKPj4KPj4gUmVn
YXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+PiBBbSAzMC4wMy4yMSB1bSAwOTowNSBzY2hyaWViIERl
bmcsIEVtaWx5Ogo+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1
dGlvbiBPbmx5XQo+Pj4KPj4+IEhpIEppYW5zb25nLAo+Pj4gICAgICAgIEl0IGRvZXMgaGFwcGVu
LCAgbWF5YmUgaGF2ZSB0aGUgcmFjZSBjb25kaXRpb24/Cj4+Pgo+Pj4KPj4+IEJlc3Qgd2lzaGVz
Cj4+PiBFbWlseSBEZW5nCj4+Pgo+Pj4KPj4+Cj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4+PiBGcm9tOiBDaGVuLCBKaWFuc29uZyAoU2ltb24pIDxKaWFuc29uZy5DaGVuQGFtZC5j
b20+Cj4+Pj4gU2VudDogVHVlc2RheSwgTWFyY2ggMzAsIDIwMjEgMjo0OSBQTQo+Pj4+IFRvOiBE
ZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPj4+PiBDYzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT4KPj4+PiBTdWJq
ZWN0OiBSRTogW1BBVENIIDYvNl0gZHJtL2FtZGdwdTogRml4IGRyaXZlciB1bmxvYWQgaXNzdWUK
Pj4+Pgo+Pj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24g
T25seV0KPj4+Pgo+Pj4+IEkgc3RpbGwgd29uZGVyIGhvdyB0aGUgaXNzdWUgdGFrZXMgcGxhY2U/
IEFjY29yZGluZyB0byBteSBodW1ibGUKPj4+PiBrbm93bGVkZ2UgaW4gZHJpdmVyIG1vZGVsLCB0
aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBrb2JqZWN0IGZvciB0aGUKPj4+PiBkZXZpY2Ugd2ls
bCBub3QgcmVhY2ggemVybyB3aGVuIHRoZXJlIGlzIHN0aWxsIHNvbWUgZGV2aWNlIG1lbQo+Pj4+
IGFjY2VzcywgYW5kIHNodXRkb3duIHNob3VsZCBub3QgaGFwcGVuLgo+Pj4+Cj4+Pj4gUmVnYXJk
cywKPj4+PiBKaWFuc29uZwo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mCj4+Pj4gRW1pbHkgRGVuZwo+Pj4+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMwLCAyMDIx
IDEyOjQyIFBNCj4+Pj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4gQ2M6
IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Cj4+Pj4gU3ViamVjdDogW1BBVENIIDYv
Nl0gZHJtL2FtZGdwdTogRml4IGRyaXZlciB1bmxvYWQgaXNzdWUKPj4+Pgo+Pj4+IER1cmluZyBk
cml2ZXIgdW5sb2FkaW5nLCBkb24ndCBuZWVkIHRvIGNvcHkgbWVtLCBvciBpdCB3aWxsIGludHJv
ZHVjZQo+Pj4+IHNvbWUgY2FsbCB0cmFjZSwgc3VjaCBhcyB3aGVuIHNhX21hbmFnZXIgaXMgZnJl
ZWQsIGl0IHdpbGwgaW50cm9kdWNlCj4+Pj4gd2FybiBjYWxsIHRyYWNlIGluIGFtZGdwdV9zYV9i
b19uZXcuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFt
ZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jIHwgMyArKysKPj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Pj4KPj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+PiBpbmRleCBl
MDAyNjNiY2M4OGIuLmYwNTQ2YTQ4OWUwZCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+PiBAQCAtMzE3LDYgKzMxNyw5IEBAIGludCBhbWRncHVf
dHRtX2NvcHlfbWVtX3RvX21lbShzdHJ1Y3QKPj4+PiBhbWRncHVfZGV2aWNlICphZGV2LCAgc3Ry
dWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOyAgaW50IHIgPSAwOwo+Pj4+Cj4+Pj4gK2lmIChh
ZGV2LT5zaHV0ZG93bikKPj4+PiArcmV0dXJuIDA7Cj4+Pj4gKwo+Pj4+IGlmICghYWRldi0+bW1h
bi5idWZmZXJfZnVuY3NfZW5hYmxlZCkgeyAgRFJNX0VSUk9SKCJUcnlpbmcgdG8gbW92ZQo+Pj4+
IG1lbW9yeSB3aXRoIHJpbmcgdHVybmVkIG9mZi5cbiIpOyAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4g
LS0KPj4+PiAyLjI1LjEKPj4+Pgo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpcwo+Pj4+IHRzLmZyCj4+Pj4gZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0KPj4+Pgo+PiBnZngmYW1wO2Rh
dGE9MDQlN0MwMSU3Q0ppYW5zb25nLkNoZW4lNDBhbWQuY29tJTdDMWI0YzcxZDdiOTYyNDcKPj4g
NmEzNjc1MDhkOGYzMzYyZjQwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3Cj4+IEM2Mzc1MjY3NjEzNTQ1MzIzMTElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBdwo+PiBNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXQKPj4gYT1SeFJuWlcwZm13aktTR01OMW5mNmtJSFJk
QVBWczlKNU9CbHVEWWhSNnZRJTNEJmFtcDtyZXNlcnZlZAo+Pj4+ID0wCj4+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
Cj4+PiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0KPj4gZ2Z4
JmFtcDtkYXRhPTA0JTdDMDElN0NFbQo+PiBpbHkuRGVuZyU0MGFtZC5jb20lN0NmZmFjYjQ3MTVh
ZmY0YmE0MzM2ODA4ZDhmMzRhZjYyZCU3QzNkZDg5NjFmZTQKPj4gODg0ZQo+PiA2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUyNjg1MDU3ODU4NTMwMiU3Q1Vua25vd24lN0NUCj4+IFdG
cGJHWnNiMwo+PiBkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUKPj4gM0QlNwo+PiBDMTAwMCZhbXA7c2RhdGE9dTI2SlBBU21K
T0Y1bmtYRlNKUDg5UGlVVUZlaHZ6ZiUyQjJxeFFNJTJGZ1Q5RWsKPj4gJTNEJmFtcAo+Pj4gO3Jl
c2VydmVkPTAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
