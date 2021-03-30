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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890BEC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD2617ED
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD2617ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFA96E8A0;
	Tue, 30 Mar 2021 10:38:51 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB736E8A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 10:38:50 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id ce10so24097141ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=mnpLKPb/Hx9EcFgpaJwKfwEPRAt4VKyt9d7AtJ7Bj2g=;
 b=Fur8RgmUGOxxNoHXHLjpznfOl5VYu19YQIg393AMm6lhWSVPDNro8uNrjmp4DSuItD
 S7yFMQbB7KbjwMq6L925fDr0DCkz4KP8A3OgB3UFUQxVwRNVDgBmAxJ7nzrM+i42GQSf
 XYfVJyFH0pFYbn3WGy1wROiTy27cbJ64+avxNNbiLpkupSagxza9pK4Bb8R5o6BbEY51
 YvPxN0NtcteZfon+gXD6alqyDbltyNW0lg03hReBRrChfvzQH/xGVsTYbhZMFXup0qls
 rsvnD2FWDnvLUUi7OVui6/EIARycLhp5NQOTZNvwpKNXbAN4wZvS+BTGhKR9w6AgcwNv
 CFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mnpLKPb/Hx9EcFgpaJwKfwEPRAt4VKyt9d7AtJ7Bj2g=;
 b=AHOYnrtklJEj4h56BT8MtcJmsDMTduH+6kPm6hSr+Q+/ilnj8VBxLu4R4BVActDOoc
 etKs9yCz7QaFH9jTD1C7UERrUOB2wNsA3kwgXsA2wecgF6YKiEU0XUhBgPlJxgUw+ZcG
 yE4e2E6jOElTpJw5GBrNWkSEDSFaMgsVP7jPtbyXvXRgn0KVqeTGYxrLPx1Ta80c1k4N
 w13WmaNSQo5S95XvAgsVExlMGLR245ts6ntYm0wDjWSEk4ce3BD+GLABUPnCo1eM9YCP
 oTmvZad5h4c3wL2DIDaCeyBhihrrHVmp5YIMVi7yARjdx9GWiD8oh6HNz6yL8T5Valvi
 BVaw==
X-Gm-Message-State: AOAM5308u+Dt3V50Zpf4+/R2wlV4qfWL2/KA5vhg6upWlI+lvuIAsirA
 k8Z3eMYxQDGSDxqKgr+4t7I=
X-Google-Smtp-Source: ABdhPJzhgVdhKelWJk4PPNP8HydM7YRcTOhUeaQHND/ax1Kk+KnIffg2Q7N35sUnRj3cEQR8+lXZNw==
X-Received: by 2002:a17:906:5203:: with SMTP id
 g3mr31692067ejm.95.1617100729091; 
 Tue, 30 Mar 2021 03:38:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id f3sm9779890ejd.42.2021.03.30.03.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 03:38:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: fix NULL pointer dereference
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Hawking.Zhang@amd.com
References: <20210330100229.26435-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <34904a56-726c-fb28-fd21-a3425f51d72b@gmail.com>
Date: Tue, 30 Mar 2021 12:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330100229.26435-1-guchun.chen@amd.com>
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

QW0gMzAuMDMuMjEgdW0gMTI6MDIgc2NocmllYiBHdWNodW4gQ2hlbjoKPiB0dG0tPnNnIG5lZWRz
IHRvIGJlIGNoZWNrZWQgYmVmb3JlIGFjY2Vzc2luZyBpdHMgY2hpbGQgbWVtYmVyLgo+Cj4gQ2Fs
bCBUcmFjZToKPiAgIGFtZGdwdV90dG1fYmFja2VuZF9kZXN0cm95KzB4MTIvMHg3MCBbYW1kZ3B1
XQo+ICAgdHRtX2JvX2NsZWFudXBfbWVtdHlwZV91c2UrMHgzYS8weDYwIFt0dG1dCj4gICB0dG1f
Ym9fcmVsZWFzZSsweDE3ZC8weDMwMCBbdHRtXQo+ICAgYW1kZ3B1X2JvX3VucmVmKzB4MWEvMHgz
MCBbYW1kZ3B1XQo+ICAgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KzB4
NzhiLzB4OGIwIFthbWRncHVdCj4gICBrZmRfaW9jdGxfYWxsb2NfbWVtb3J5X29mX2dwdSsweDEx
OC8weDIyMCBbYW1kZ3B1XQo+ICAga2ZkX2lvY3RsKzB4MjIyLzB4NDAwIFthbWRncHVdCj4gICA/
IGtmZF9kZXZfaXNfbGFyZ2VfYmFyKzB4OTAvMHg5MCBbYW1kZ3B1XQo+ICAgX194NjRfc3lzX2lv
Y3RsKzB4OGUvMHhkMAo+ICAgPyBfX2NvbnRleHRfdHJhY2tpbmdfZXhpdCsweDUyLzB4OTAKPiAg
IGRvX3N5c2NhbGxfNjQrMHgzMy8weDgwCj4gICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0NC8weGE5Cj4gUklQOiAwMDMzOjB4N2Y5N2YyNjRkMzE3Cj4gQ29kZTogYjMgNjYgOTAg
NDggOGIgMDUgNzEgNGIgMmQgMDAgNjQgYzcgMDAgMjYgMDAgMDAgMDAgNDggYzcgYzAgZmYgZmYg
ZmYgZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgYjggMTAgMDAgMDAgMDAgMGYg
MDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCA0MSA0YiAyZCAwMCBmNyBk
OCA2NCA4OSAwMSA0OAo+IFJTUDogMDAyYjowMDAwN2ZmZGI0MDJjMzM4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMTAKPiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwN2Y5N2YzY2M2M2EwIFJDWDogMDAwMDdmOTdmMjY0ZDMxNwo+IFJEWDogMDAwMDdmZmRi
NDAyYzM4MCBSU0k6IDAwMDAwMDAwYzAyODRiMTYgUkRJOiAwMDAwMDAwMDAwMDAwMDAzCj4gUkJQ
OiAwMDAwN2ZmZGI0MDJjMzgwIFIwODogMDAwMDdmZmRiNDAyYzQyOCBSMDk6IDAwMDAwMDAwYzQw
MDAwMDQKPiBSMTA6IDAwMDAwMDAwYzQwMDAwMDQgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjog
MDAwMDAwMDBjMDI4NGIxNgo+IFIxMzogMDAwMDAwMDAwMDAwMDAwMyBSMTQ6IDAwMDA3Zjk3ZjNj
YzYzYTAgUjE1OiAwMDAwN2Y4ODM2MjAwMDAwCj4KPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hl
biA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KClllYWggSSBoYWQgdGhpcyBvbmUgb24gbXkgVE9ETyBs
aXN0IGFzIHdlbGwuCgpGb3Igbm93IHRoZSBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4sIGJ1dCBJJ20gbm90IDEwMCUgc3VyZSBp
ZiB0aGlzIGlzIHRoZSByaWdodCBmaXguCgpQbGVhc2Uga2VlcCBhbiBleWUgb3BlbiBpZiBhbnli
b2R5IGNvbXBsYWlucyBhYm91dCBpc3N1ZXMgd2l0aCB0aGlzIApwYXRjaCwgaWYgeWVzIHdlIG5l
ZWQgdG8gZ2V0IGJhY2sgdG8gdGhlIGRyYXdpbmcgYm9hcmQuCgpDaHJpc3RpYW4uCgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggZTAwMjYzYmNjODhiLi43MjJlZmQ4
NjcxOGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAg
LTg2Nyw3ICs4NjcsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdHRtX3R0X3VucGluX3VzZXJwdHIo
c3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsCj4gICAJCURNQV9CSURJUkVDVElPTkFMIDogRE1BX1RP
X0RFVklDRTsKPiAgIAo+ICAgCS8qIGRvdWJsZSBjaGVjayB0aGF0IHdlIGRvbid0IGZyZWUgdGhl
IHRhYmxlIHR3aWNlICovCj4gLQlpZiAoIXR0bS0+c2ctPnNnbCkKPiArCWlmICghdHRtLT5zZyB8
fCAhdHRtLT5zZy0+c2dsKQo+ICAgCQlyZXR1cm47Cj4gICAKPiAgIAkvKiB1bm1hcCB0aGUgcGFn
ZXMgbWFwcGVkIHRvIHRoZSBkZXZpY2UgKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
