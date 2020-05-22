Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C26C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 07:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3BB2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 07:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjoNhfQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3BB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF066E330;
	Fri, 22 May 2020 07:05:22 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB456E330
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 07:05:22 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id be9so8543038edb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=z7/sgKwNZCdecDqzA9ft2N7E0mYAnEB+sRKQ8GFmOwA=;
 b=jjoNhfQewb7aDQObJ2ruDQqgVViOyPOyFRM3t2n2MUOzrOIac5lN/GCaGgjuhzfCd1
 AfrKdhpnSc7BR2Sz2s/hzJpkOYEhMuZKrtyMX3bDcIHjB8h16A2E0FD9jj/kA+C8qbfp
 0I5NCZ4VoksyiEF3XRFdA0SxbXSt68Tj7VR0lay58p1vZKFNrJbNyGxcwVzVSGGTRXze
 vpHqWEpwaYlO2TDZ37/kwlN7bmAM1BjzABwnIEyS8Hi3tgkmGuRpVEHG8n2sNKIN9ACb
 093dXudeMDTKRy5YvbXUkYpW8OeXfW1n2MF3H7Yuk5KHUCr93E/WNeQP0YaGE6ZIbVJ2
 qFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=z7/sgKwNZCdecDqzA9ft2N7E0mYAnEB+sRKQ8GFmOwA=;
 b=hCezJNK6H8R6QNATKmt15eFJ1P0JFaxpdOOQGlRNG4rvSypzRDeduJHmwXaIaqyjoX
 i52Spn+IVHFNyC/YOjYSX9lFeWsCPtbFTuRDRKVfhVfhxxWByGM08Br3RKL27HLRxaNC
 B1U6v+Pu3Escjb8rO0ftsRyo6Wyo1qIWL8/C4G0xGhSqvG2DU6u3KeFLMUbVxKYovH+h
 yXU6SXnWuEFfIzTjUk8ZSxA1j0PqbyRyt3Erpt/o7V1beQXn1NPVoEAbTu56tjn9P/j4
 aeonBLEDg+IGY/36PD/gChbhFVGsPAYm/gjoe608LxyzUqywuF4x1Ft/aN2KYsmkfQpC
 7vcQ==
X-Gm-Message-State: AOAM533SlWWLAv1mNAP6LKZLIK0fXE/Vsmz5d3NfgnTE8dEFSm1R7LVf
 ISplVgcjPQwvZG6zFtp3BqY=
X-Google-Smtp-Source: ABdhPJxSyUqpQt3BV9fu7iR+KYL+Bx4gi9mQZYmCVY9G4C0DJSRxBLltE0AYTJyzqAwKy+ILzcHIig==
X-Received: by 2002:a05:6402:658:: with SMTP id
 u24mr1886840edx.213.1590131121016; 
 Fri, 22 May 2020 00:05:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k27sm7087570eji.18.2020.05.22.00.05.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 May 2020 00:05:20 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200515183135.626855-1-alexander.deucher@amd.com>
 <CADnq5_P16h9KJ=gT3wfGU8Kg0XjrJVwZoFNqJC3U4G4_LNO37A@mail.gmail.com>
 <DM6PR12MB2619A8D79000000FD8A48210E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1e3292a3-0c81-6117-ef08-050b97eea4b8@gmail.com>
Date: Fri, 22 May 2020 09:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB2619A8D79000000FD8A48210E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDIyLjA1LjIwIHVtIDA4OjA2IHNjaHJpZWIgUXVhbiwgRXZhbjoKPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBQYXRjaDEsIDIgYXJlIHJl
dmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IFBhdGNoMyBpcyBhY2tl
ZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPgo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcgo+IFNlbnQ6IFRodXJzZGF5LCBNYXkg
MjEsIDIwMjAgMTA6MTYgUE0KPiBUbzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBtb3ZlIGRpc2Nv
dmVyeSBnZnggY29uZmlnIGZldGNoaW5nCj4KPiBQaW5nIG9uIHRoaXMgc2VyaWVzPyAgSXQgZml4
ZXMgYW4gb3JkZXJpbmcgaXNzdWUgZm9yIHJhdmVuMi4KPgo+IEFsZXgKPgo+IE9uIEZyaSwgTWF5
IDE1LCAyMDIwIGF0IDI6MzEgUE0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
IHdyb3RlOgo+PiBNb3ZlIGl0IGludG8gdGhlIGZ3X2luZm8gZnVuY3Rpb24gc2luY2UgaXQncyBs
b2dpY2FsbHkgcGFydCBvZiB0aGUKPj4gc2FtZSBmdW5jdGlvbmFsaXR5Lgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IC0tLQo+
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDcgKysrLS0t
LQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gaW5k
ZXggY2M0MWU4ZjVhZDE0Li5iYWIxYmU3YWJkZjAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gQEAgLTE2MTcsOCArMTYxNywxMCBAQCBzdGF0
aWMgaW50IGFtZGdwdV9kZXZpY2VfcGFyc2VfZ3B1X2luZm9fZncoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAoY29uc3Qgc3RydWN0IGdwdV9p
bmZvX2Zpcm13YXJlX3YxXzAgKikoYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZnctPmRhdGEgKwo+
Pgo+PiBsZTMyX3RvX2NwdShoZHItPmhlYWRlci51Y29kZV9hcnJheV9vZmZzZXRfYnl0ZXMpKTsK
Pj4KPj4gLSAgICAgICAgICAgICAgIGlmIChhbWRncHVfZGlzY292ZXJ5ICYmIGFkZXYtPmFzaWNf
dHlwZSA+PSBDSElQX05BVkkxMCkKPj4gKyAgICAgICAgICAgICAgIGlmIChhbWRncHVfZGlzY292
ZXJ5ICYmIGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX05BVkkxMCkgewo+PiArICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfZGlzY292ZXJ5X2dldF9nZnhfaW5mbyhhZGV2KTsKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gcGFyc2Vfc29jX2JvdW5kaW5nX2JveDsKPj4gKyAgICAg
ICAgICAgICAgIH0KPj4KPj4gICAgICAgICAgICAgICAgICBhZGV2LT5nZnguY29uZmlnLm1heF9z
aGFkZXJfZW5naW5lcyA9IGxlMzJfdG9fY3B1KGdwdV9pbmZvX2Z3LT5nY19udW1fc2UpOwo+PiAg
ICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5jb25maWcubWF4X2N1X3Blcl9zaCA9Cj4+IGxlMzJf
dG9fY3B1KGdwdV9pbmZvX2Z3LT5nY19udW1fY3VfcGVyX3NoKTsKPj4gQEAgLTE3NjgsOSArMTc3
MCw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9lYXJseV9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQo+PiAgICAgICAgICBpZiAocikKPj4gICAgICAgICAgICAgICAgICBy
ZXR1cm4gcjsKPj4KPj4gLSAgICAgICBpZiAoYW1kZ3B1X2Rpc2NvdmVyeSAmJiBhZGV2LT5hc2lj
X3R5cGUgPj0gQ0hJUF9OQVZJMTApCj4+IC0gICAgICAgICAgICAgICBhbWRncHVfZGlzY292ZXJ5
X2dldF9nZnhfaW5mbyhhZGV2KTsKPj4gLQo+PiAgICAgICAgICBhbWRncHVfYW1ka2ZkX2Rldmlj
ZV9wcm9iZShhZGV2KTsKPj4KPj4gICAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkg
ewo+PiAtLQo+PiAyLjI1LjQKPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJG
bGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NldmFuLnF1YW4lNDBhbWQuY29t
JTdDYjY5MmQxNjNkZWEwNGE4ZDlmMzIwOGQ3ZmQ5MThjYmQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjU2NjczOTIxOTgzNDAwJmFtcDtzZGF0YT1ta054
aTZwbWtKQ3BJV05tekhoZG1NazYlMkJjWVIlMkJBWUpjd3dDdm9EaGxxcyUzRCZhbXA7cmVzZXJ2
ZWQ9MAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
