Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E0C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951E46140B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E46140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5046689FE6;
	Tue, 15 Jun 2021 06:48:18 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C90889FE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 06:48:17 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id nb6so496314ejc.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=2cNnp2YTbCI5m/oIGFWN6SnzvFNrJOrq5Imlm6/MjiM=;
 b=USmcRqtP/ua+3Um+s8suhZUcL+GVHem/XO8uNV6GFel1XrkH8oH2+zlrwTk/iBiDJE
 FAzfXByl9O0mLfFtQm63GVsVx6npPY5SwymVXl8GbuicoRZMQsKo8NsTh1WBM8f06x9E
 s44C7DQNe6XwM6b9qFzab/VsFvqqVnZfJhnExxoQDamv7uP4+HS4O6bLf7ZZc6xSQCX+
 P/T2JA2F+uocThdXIcQEKvDDQC6Gtb09LM2KknbsKE9+XHP9Z0tFayehZSQc00cAJFhk
 zuu0P4USSovBVWO4zkr1YQRzH6nxR+1AMJJ9sZIWw4BUaeA0MPKDtYh6cjt2uRhdBb/D
 Tugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2cNnp2YTbCI5m/oIGFWN6SnzvFNrJOrq5Imlm6/MjiM=;
 b=OW1JQ3NxW2m9QOPK27SAhpi4mcQmHUyEn5CPBGKn6c0h8eJg6Lp9pJ3K1Ip+4Xev9K
 MyPU9YTg6u3PXP7ZRUqX7y/KGp/023TW9nJVHLrpP0p+MXcquSPOCSGgdpuOINKJuU5s
 mWstnubkab40awR4P572CfYOds5QURQFzkEoVMZBBs4V3ZNfGWtrzJEiv9gFxgXL1Pn/
 F0X5baZv/jmQ07ltriAUyqOSI43iwlwM/YOGZOstb7ioAu03rE9+jwWq6WVD8uAZvKsL
 WIU3z1gOwp0GCBkBNc6/fhvecaIcVFulFCPv45wWSfdsyJvjH4/S9Ui8TH2Jvh6a9+1V
 yOhQ==
X-Gm-Message-State: AOAM531gKYFYP2lU3/hZ75LFWkQuX7Ut39gqISlyziIR1Z2Zq48VhBbQ
 Pd4QMXRMlQrDoWM4T7HN++LhZukWglA=
X-Google-Smtp-Source: ABdhPJygtjV5qn/cpcMczLpCdCy/Ty/ke66GnKZjyKx+/AWXe7C/4WQQhEXETYbeeIZITg4XEjpYOg==
X-Received: by 2002:a17:906:fa13:: with SMTP id
 lo19mr19706849ejb.468.1623739696111; 
 Mon, 14 Jun 2021 23:48:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c?
 ([2a02:908:1252:fb60:f438:4e93:3853:400c])
 by smtp.gmail.com with ESMTPSA id a2sm9192240ejp.1.2021.06.14.23.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 23:48:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Use spinlock_irqsave for pasid_lock
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210614220702.11246-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1a53512d-8efc-4b88-22e1-be263cb9abb0@gmail.com>
Date: Tue, 15 Jun 2021 08:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614220702.11246-1-Felix.Kuehling@amd.com>
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

QW0gMTUuMDYuMjEgdW0gMDA6MDcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBUaGlzIHNob3Vs
ZCBmaXggYSBrZXJuZWwgTE9DS0RFUCB3YXJuaW5nIG9uIFZlZ2ExMDoKPiBbICAxNDkuNDE2NjA0
XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IFsgIDE0OS40MjA4NzddIFdBUk5J
Tkc6IGluY29uc2lzdGVudCBsb2NrIHN0YXRlCj4gWyAgMTQ5LjQyNTE1Ml0gNS4xMS4wLWtmZC1m
a3VlaGxpbiAjNTE3IE5vdCB0YWludGVkCj4gWyAgMTQ5LjQyOTc3MF0gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiBbICAxNDkuNDM0MDUzXSBpbmNvbnNpc3RlbnQge0hBUkRJUlEt
T04tV30gLT4ge0lOLUhBUkRJUlEtV30gdXNhZ2UuCj4gWyAgMTQ5LjQ0MDA1OV0gc3dhcHBlci8z
LzAgW0hDMVsxXTpTQzBbMF06SEUwOlNFMV0gdGFrZXM6Cj4gWyAgMTQ5LjQ0NTE5OF0gZmZmZjlh
YzgwZTAwNWQ2OCAoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jayl7Py4rLn0tezI6Mn0sIGF0
OiBhbWRncHVfdm1fZ2V0X3Rhc2tfaW5mbysweDI1LzB4OTAgW2FtZGdwdV0KPiBbICAxNDkuNDU2
MjUyXSB7SEFSRElSUS1PTi1XfSBzdGF0ZSB3YXMgcmVnaXN0ZXJlZCBhdDoKPiBbICAxNDkuNDYx
MTM2XSAgIGxvY2tfYWNxdWlyZSsweDI0Mi8weDM5MAo+IFsgIDE0OS40NjQ4OTVdICAgX3Jhd19z
cGluX2xvY2srMHgyYy8weDQwCj4gWyAgMTQ5LjQ2ODY0N10gICBhbWRncHVfdm1faGFuZGxlX2Zh
dWx0KzB4NDQvMHgzODAgW2FtZGdwdV0KPiBbICAxNDkuNDc0MTg3XSAgIGdtY192OV8wX3Byb2Nl
c3NfaW50ZXJydXB0KzB4YTgvMHg0MTAgW2FtZGdwdV0KClRoaXMgaXMgYWN0dWFsbHkgYSBmYWxz
ZSBwb3N0aXZlLCBidXQgdGhlIHBhdGNoIGlzIG9rIHNpbmNlIGl0J3MgdGhlIAplYXNpZXN0IHdh
eSB0byBmaXggdGhpcyA6KQoKPiAuLi4KPgo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyB8IDkgKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiBpbmRleCAzYjZjMGI0OGQwYjEuLjBiNjM2ODZmYzMxYSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTMzOTQsMTEgKzMzOTQsMTIg
QEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1MzIgcGFzaWQsCj4gICB7Cj4gICAJYm9vbCBpc19jb21wdXRlX2NvbnRleHQgPSBmYWxzZTsK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290Owo+ICsJdW5zaWduZWQgbG9uZyBpcnFmbGFnczsK
PiAgIAl1aW50NjRfdCB2YWx1ZSwgZmxhZ3M7Cj4gICAJc3RydWN0IGFtZGdwdV92bSAqdm07Cj4g
ICAJaW50IHI7Cj4gICAKPiAtCXNwaW5fbG9jaygmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2Nr
KTsKPiArCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGly
cWZsYWdzKTsKPiAgIAl2bSA9IGlkcl9maW5kKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2lkciwg
cGFzaWQpOwo+ICAgCWlmICh2bSkgewo+ICAgCQlyb290ID0gYW1kZ3B1X2JvX3JlZih2bS0+cm9v
dC5iYXNlLmJvKTsKPiBAQCAtMzQwNiw3ICszNDA3LDcgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxl
X2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgcGFzaWQsCj4gICAJfSBlbHNl
IHsKPiAgIAkJcm9vdCA9IE5VTEw7Cj4gICAJfQo+IC0Jc3Bpbl91bmxvY2soJmFkZXYtPnZtX21h
bmFnZXIucGFzaWRfbG9jayk7Cj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT52bV9t
YW5hZ2VyLnBhc2lkX2xvY2ssIGlycWZsYWdzKTsKPiAgIAo+ICAgCWlmICghcm9vdCkKPiAgIAkJ
cmV0dXJuIGZhbHNlOwo+IEBAIC0zNDI0LDExICszNDI1LDExIEBAIGJvb2wgYW1kZ3B1X3ZtX2hh
bmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHBhc2lkLAo+ICAgCQln
b3RvIGVycm9yX3VucmVmOwo+ICAgCj4gICAJLyogRG91YmxlIGNoZWNrIHRoYXQgdGhlIFZNIHN0
aWxsIGV4aXN0cyAqLwo+IC0Jc3Bpbl9sb2NrKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2sp
Owo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywgaXJx
ZmxhZ3MpOwo+ICAgCXZtID0gaWRyX2ZpbmQoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfaWRyLCBw
YXNpZCk7Cj4gICAJaWYgKHZtICYmIHZtLT5yb290LmJhc2UuYm8gIT0gcm9vdCkKPiAgIAkJdm0g
PSBOVUxMOwo+IC0Jc3Bpbl91bmxvY2soJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jayk7Cj4g
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGly
cWZsYWdzKTsKPiAgIAlpZiAoIXZtKQo+ICAgCQlnb3RvIGVycm9yX3VubG9jazsKPiAgIAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
