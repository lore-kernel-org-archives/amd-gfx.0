Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467FBC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 23:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB4664FEE
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 23:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB4664FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E8B6EC83;
	Fri,  5 Mar 2021 23:09:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD79E6EC83
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614985740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INtltMQ8IOgtpKXNlNYBjd3Byy7FpGGzQNtL7sdAvE4=;
 b=SbBDgWpsnzhH+WGuVWvdIXeNJGTAWmnH0BwQ0U3fg2N0bpbCgXcQBkgaStRddCicpBhUxN
 Ne7JvzSzWU8P9rqzv1psNKqWC5hOcX3GsQ/ZzBJxDPSMVnyw6eJVBCgXvFV/6GQL8JSdFL
 aM0H687sRW11zzQqKyw2lQGnfb/OPC0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-8s9dkB2VMcmHa77yIvSdmw-1; Fri, 05 Mar 2021 18:08:57 -0500
X-MC-Unique: 8s9dkB2VMcmHa77yIvSdmw-1
Received: by mail-qv1-f70.google.com with SMTP id q104so2671397qvq.20
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 15:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
 :in-reply-to:references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=INtltMQ8IOgtpKXNlNYBjd3Byy7FpGGzQNtL7sdAvE4=;
 b=pax2ezCmYDZbA/G1k44xAvw9Skv3xE2wI7mxcFTKs++k65Z08AFOpipCxgmx9hwYAk
 lAajolIevPbvHbz+dpjxNQPAPIW40dTsrLAguLmnQV4Zg0Xmzuzfk4I/3g27kFUjha4J
 wXnLMA0Kd90Se7TUt/oBwjnDvOkCzHHvx9fqb3gjjeanwFa2gewW33E0KmfcLXgMgu2p
 F9KeOl0g44694dqa9T0Lw865yicCPCOE/d5tfsU6HG++w53vlq8Iw2FxOsnCUql+SIfZ
 y4gw9WU02Sz77yHDvYHv/IwaUOWJnJwe/398d/8nyq63I1NR1CrqgFSYLDUEedlpprL2
 Y/cA==
X-Gm-Message-State: AOAM533/DnqXN8GgmlNKSGk6X9Bh5pis3mdxU0RfnCBgCh6Ikec8SVyR
 Ju/aPDeiquh7+yF4A2pkZTdJecIDLw5m0JfLY5HblfpVKIegJyat8gRSGHUUmWoRQ1Qq2Vf621u
 WukYucgDAJct6f+mrStImLeh3uw==
X-Received: by 2002:ac8:6f2f:: with SMTP id i15mr11230783qtv.36.1614985736920; 
 Fri, 05 Mar 2021 15:08:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQ+ZPtj5zydTQtAX2vJn4hi/DJI3NkSKVWyfA4AlU04bAZIGY319HYcTskZRFVZwn5MhnpJQ==
X-Received: by 2002:ac8:6f2f:: with SMTP id i15mr11230766qtv.36.1614985736670; 
 Fri, 05 Mar 2021 15:08:56 -0800 (PST)
Received: from Whitewolf.lyude.net
 (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id d12sm2930495qth.11.2021.03.05.15.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 15:08:56 -0800 (PST)
Message-ID: <644d4643c1be3714ae9e7a643a528586d793dbe1.camel@redhat.com>
Subject: Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
From: Lyude Paul <lyude@redhat.com>
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
Date: Fri, 05 Mar 2021 18:08:55 -0500
In-Reply-To: <20210304200851.4937-1-Anson.Jacob@amd.com>
References: <20210304200851.4937-1-Anson.Jacob@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Reply-To: lyude@redhat.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGVzdGVkLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgoKVGhhdCBqdXN0IGxlYXZl
cyB0aGUgS0FTQU4gZXJyb3IgZnJvbSByZWFkX2luZGlyZWN0X2F6YWxpYV9yZWcsIHRoYW5rcyBm
b3IgdGhlCmZpeCEKCk9uIFRodSwgMjAyMS0wMy0wNCBhdCAxNTowOCAtMDUwMCwgQW5zb24gSmFj
b2Igd3JvdGU6Cj4gSWYgZ2V0X251bV9zZG1hX3F1ZXVlcyBvciBnZXRfbnVtX3hnbWlfc2RtYV9x
dWV1ZXMgaXMgMCwgd2UgZW5kIHVwCj4gZG9pbmcgYSBzaGlmdCBvcGVyYXRpb24gd2hlcmUgdGhl
IG51bWJlciBvZiBiaXRzIHNoaWZ0ZWQgZXF1YWxzCj4gbnVtYmVyIG9mIGJpdHMgaW4gdGhlIG9w
ZXJhbmQuIFRoaXMgYmVoYXZpb3VyIGlzIHVuZGVmaW5lZC4KPiAKPiBTZXQgbnVtX3NkbWFfcXVl
dWVzIG9yIG51bV94Z21pX3NkbWFfcXVldWVzIHRvIFVMTE9OR19NQVgsIGlmIHRoZQo+IGNvdW50
IGlzID49IG51bWJlciBvZiBiaXRzIGluIHRoZSBvcGVyYW5kLgo+IAo+IEJ1ZzogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTQ3Mgo+IFJlcG9ydGVkLWJ5
OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEph
Y29iIDxBbnNvbi5KYWNvYkBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IC0tLQo+IMKgLi4uL2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2VfcXVldWVfbWFuYWdlci5jwqDCoCB8IDE3ICsrKysrKysrKysrKysrKy0tCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2Vy
LmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdl
ci5jCj4gaW5kZXggYzM3ZTljNGIxZmI0Li5lN2EzYzQ5NjIzN2YgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+
IEBAIC0xMTI4LDYgKzExMjgsOSBAQCBzdGF0aWMgaW50IHNldF9zY2hlZF9yZXNvdXJjZXMoc3Ry
dWN0Cj4gZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkKPiDCoAo+IMKgc3RhdGljIGludCBpbml0
aWFsaXplX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtKQo+IMKgewo+ICvC
oMKgwqDCoMKgwqDCoHVpbnQ2NF90IG51bV9zZG1hX3F1ZXVlczsKPiArwqDCoMKgwqDCoMKgwqB1
aW50NjRfdCBudW1feGdtaV9zZG1hX3F1ZXVlczsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHByX2Rl
YnVnKCJudW0gb2YgcGlwZXM6ICVkXG4iLCBnZXRfcGlwZXNfcGVyX21lYyhkcW0pKTsKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9pbml0KCZkcW0tPmxvY2tfaGlkZGVuKTsKPiBAQCAtMTEz
Niw4ICsxMTM5LDE4IEBAIHN0YXRpYyBpbnQgaW5pdGlhbGl6ZV9jcHNjaChzdHJ1Y3QgZGV2aWNl
X3F1ZXVlX21hbmFnZXIKPiAqZHFtKQo+IMKgwqDCoMKgwqDCoMKgwqBkcW0tPmFjdGl2ZV9jcF9x
dWV1ZV9jb3VudCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoGRxbS0+Z3dzX3F1ZXVlX2NvdW50ID0g
MDsKPiDCoMKgwqDCoMKgwqDCoMKgZHFtLT5hY3RpdmVfcnVubGlzdCA9IGZhbHNlOwo+IC3CoMKg
wqDCoMKgwqDCoGRxbS0+c2RtYV9iaXRtYXAgPSB+MFVMTCA+PiAoNjQgLSBnZXRfbnVtX3NkbWFf
cXVldWVzKGRxbSkpOwo+IC3CoMKgwqDCoMKgwqDCoGRxbS0+eGdtaV9zZG1hX2JpdG1hcCA9IH4w
VUxMID4+ICg2NCAtIGdldF9udW1feGdtaV9zZG1hX3F1ZXVlcyhkcW0pKTsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgbnVtX3NkbWFfcXVldWVzID0gZ2V0X251bV9zZG1hX3F1ZXVlcyhkcW0pOwo+ICvC
oMKgwqDCoMKgwqDCoGlmIChudW1fc2RtYV9xdWV1ZXMgPj0gQklUU19QRVJfVFlQRShkcW0tPnNk
bWFfYml0bWFwKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHFtLT5zZG1hX2Jp
dG1hcCA9IFVMTE9OR19NQVg7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkcW0tPnNkbWFfYml0bWFwID0gKEJJVF9VTEwobnVtX3NkbWFfcXVl
dWVzKSAtIDEpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBudW1feGdtaV9zZG1hX3F1ZXVlcyA9IGdl
dF9udW1feGdtaV9zZG1hX3F1ZXVlcyhkcW0pOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChudW1feGdt
aV9zZG1hX3F1ZXVlcyA+PSBCSVRTX1BFUl9UWVBFKGRxbS0+eGdtaV9zZG1hX2JpdG1hcCkpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRxbS0+eGdtaV9zZG1hX2JpdG1hcCA9IFVM
TE9OR19NQVg7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkcW0tPnhnbWlfc2RtYV9iaXRtYXAgPSAoQklUX1VMTChudW1feGdtaV9zZG1hX3F1
ZXVlcykgLSAxKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBJTklUX1dPUksoJmRxbS0+aHdfZXhj
ZXB0aW9uX3dvcmssIGtmZF9wcm9jZXNzX2h3X2V4Y2VwdGlvbik7Cj4gwqAKCi0tIApTaW5jZXJl
bHksCiAgIEx5dWRlIFBhdWwgKHNoZS9oZXIpCiAgIFNvZnR3YXJlIEVuZ2luZWVyIGF0IFJlZCBI
YXQKICAgCk5vdGU6IEkgZGVhbCB3aXRoIGEgbG90IG9mIGVtYWlscyBhbmQgaGF2ZSBhIGxvdCBv
ZiBidWdzIG9uIG15IHBsYXRlLiBJZiB5b3UndmUKYXNrZWQgbWUgYSBxdWVzdGlvbiwgYXJlIHdh
aXRpbmcgZm9yIGEgcmV2aWV3L21lcmdlIG9uIGEgcGF0Y2gsIGV0Yy4gYW5kIEkKaGF2ZW4ndCBy
ZXNwb25kZWQgaW4gYSB3aGlsZSwgcGxlYXNlIGZlZWwgZnJlZSB0byBzZW5kIG1lIGFub3RoZXIg
ZW1haWwgdG8gY2hlY2sKb24gbXkgc3RhdHVzLiBJIGRvbid0IGJpdGUhCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
