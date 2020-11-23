Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA5C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 12:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1165720781
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMEWglER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1165720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697C389CD3;
	Mon, 23 Nov 2020 12:31:52 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABB489CD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 12:31:51 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v143so16734761qkb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=E8+q2CxKdRoOM9oKen1Ktpcskt4c6x36f8ymdAIggPs=;
 b=bMEWglERetlK8m0TxcSsT/DWNjl4jAckjmwzdu/6nCMDYgJcC0Yb1I75ZT2qm5ZDWq
 BNsL80Hd38H18Vp4GPyMvat+IUSZM2oFLPbPhlEjcC8YMJoiKRkgZFHtIx+O7MRY6KNr
 j1NnTIsoTs40Oakr5yY0tEspF5kDk3S+L58sjqfa7gN4q4NgMZzsVSL+Dg6k/VJocA5j
 VSyvwq8XF4GFTfOmrq/eCs3mhlBTkLuuXkHje+/V44GPjqYbWlM5CAreKdCwJ2AoxF8r
 igdJqPlCAjaxboJ8UN1hdpkGDFcxEzXBR1xUwmQgcTJQStvn4kyVrarsUz8gg7fi0KbF
 rIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=E8+q2CxKdRoOM9oKen1Ktpcskt4c6x36f8ymdAIggPs=;
 b=qlsUXulRrN/Ayyi+ziF+W8N0xrI5KsDz9OdL9fMlKNoQXapPkSmTadAEchaJiEz4n5
 dFiz6uF+cx2++WTFpETgJm24QZUdLQcQy+KPLoxnkUei50DhoFJ6WnhQVUdlPk3Kkljn
 Z1AKfpKOnZm6DF0Svp7X1+KrOwdCZcXLNs3RtWybEZSb3l+R3xwiK3D4+rU2JMgrg2Io
 K+M05BwV1Lb+cWqigEzBpi/rSUp8Koc1Xtu+0ZOoWQU9BAFb3FVd3xrV6Od5dnkHn4sK
 +JAy6TdA+4inFq7OqsqkJQdx3TZlutqCH9RZORUNX+az/fl19da4JCVR/IVfM3oyVrSG
 /xKw==
X-Gm-Message-State: AOAM533cnLcJOT+D95F0R6qXJiuWvcIY4dHFYaQmGcZDykJ4mxZV4+gZ
 9YmbFICCeG3Cvj976sYwGKmf+9/ysPw=
X-Google-Smtp-Source: ABdhPJypaJnbsZU2Oq8S01lbbsxjChfkVIsPzUdECaRC4d1r7ZPsH7LwNFM+hIJ5PCFhmwdbyVprCA==
X-Received: by 2002:ae9:eb06:: with SMTP id b6mr29794054qkg.321.1606134710347; 
 Mon, 23 Nov 2020 04:31:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p8sm9816424qtc.37.2020.11.23.04.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 04:31:49 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Pierre-eric.Pelloux-prayer@amd.com, Marek.Olsak@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20201118132039.2336-1-christian.koenig@amd.com>
Message-ID: <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
Date: Mon, 23 Nov 2020 13:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118132039.2336-1-christian.koenig@amd.com>
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

UGluZywgUGllcnJlL01hcmVrIGRvZXMgdGhpcyBjaGFuZ2Ugd29ya3MgYXMgZXhwZWN0ZWQ/CgpS
ZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAxOC4xMS4yMCB1bSAxNDoyMCBzY2hyaWViIENocmlzdGlh
biBLw7ZuaWc6Cj4gVGhpcyBhbGxvd3MgZm9yIG9wdGltaXppbmcgdGhlIENQVSByb3VuZCB0cmlw
IGF3YXkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3MuYyAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5j
LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zeW5jLmggfCAgMSArCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI5IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jcy5jCj4gaW5kZXggNzkzNDI5NzZmYTc2Li42OGY5YTRhZGY1ZDIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IEBAIC0xMDE0LDcgKzEwMTQsNyBAQCBzdGF0
aWMgaW50IGFtZGdwdV9zeW5jb2JqX2xvb2t1cF9hbmRfYWRkX3RvX3N5bmMoc3RydWN0IGFtZGdw
dV9jc19wYXJzZXIgKnAsCj4gICAJCXJldHVybiByOwo+ICAgCX0KPiAgIAo+IC0JciA9IGFtZGdw
dV9zeW5jX2ZlbmNlKCZwLT5qb2ItPnN5bmMsIGZlbmNlKTsKPiArCXIgPSBhbWRncHVfc3luY19m
ZW5jZV9jaGFpbigmcC0+am9iLT5zeW5jLCBmZW5jZSk7Cj4gICAJZG1hX2ZlbmNlX3B1dChmZW5j
ZSk7Cj4gICAKPiAgIAlyZXR1cm4gcjsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9zeW5jLmMKPiBpbmRleCA4ZWE2YzQ5NTI5ZTcuLmQwZDY0YWYwNmY1NCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwo+IEBAIC0yOCw2ICsyOCw4IEBACj4g
ICAgKiAgICBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gICAg
Ki8KPiAgIAo+ICsjaW5jbHVkZSA8bGludXgvZG1hLWZlbmNlLWNoYWluLmg+Cj4gKwo+ICAgI2lu
Y2x1ZGUgImFtZGdwdS5oIgo+ICAgI2luY2x1ZGUgImFtZGdwdV90cmFjZS5oIgo+ICAgI2luY2x1
ZGUgImFtZGdwdV9hbWRrZmQuaCIKPiBAQCAtMTY5LDYgKzE3MSwzMSBAQCBpbnQgYW1kZ3B1X3N5
bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLCBzdHJ1Y3QgZG1hX2ZlbmNlICpmKQo+
ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBhbWRncHVfc3luY19mZW5jZV9j
aGFpbiAtIHVucGFjayBkbWFfZmVuY2VfY2hhaW4gYW5kIHN5bmMKPiArICoKPiArICogQHN5bmM6
IHN5bmMgb2JqZWN0IHRvIGFkZCBmZW5jZSB0bwo+ICsgKiBAZjogcG90ZW50aWFsIGRtYV9mZW5j
ZV9jaGFpbiB0byBzeW5jIHRvLgo+ICsgKgo+ICsgKiBBZGQgdGhlIGZlbmNlcyBpbnNpZGUgdGhl
IGNoYWluIHRvIHRoZSBzeW5jIG9iamVjdC4KPiArICovCj4gK2ludCBhbWRncHVfc3luY19mZW5j
ZV9jaGFpbihzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsIHN0cnVjdCBkbWFfZmVuY2UgKmYpCj4g
K3sKPiArCWludCByOwo+ICsKPiArCWRtYV9mZW5jZV9jaGFpbl9mb3JfZWFjaChmLCBmKSB7Cj4g
KwkJaWYgKGRtYV9mZW5jZV9pc19zaWduYWxlZChmKSkKPiArCQkJY29udGludWU7Cj4gKwo+ICsJ
CXIgPSBhbWRncHVfc3luY19mZW5jZShzeW5jLCBmKTsKPiArCQlpZiAocikgewo+ICsJCQlkbWFf
ZmVuY2VfcHV0KGYpOwo+ICsJCQlyZXR1cm4gcjsKPiArCQl9Cj4gKwl9Cj4gKwlyZXR1cm4gMDsK
PiArfQo+ICsKPiAgIC8qKgo+ICAgICogYW1kZ3B1X3N5bmNfdm1fZmVuY2UgLSByZW1lbWJlciB0
byBzeW5jIHRvIHRoaXMgVk0gZmVuY2UKPiAgICAqCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfc3luYy5oCj4gaW5kZXggN2MwZmUyMGM0NzBkLi5iMTQyMTc1YjY1YjYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuaAo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmgKPiBAQCAtNDgsNiArNDgs
NyBAQCBzdHJ1Y3QgYW1kZ3B1X3N5bmMgewo+ICAgCj4gICB2b2lkIGFtZGdwdV9zeW5jX2NyZWF0
ZShzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMpOwo+ICAgaW50IGFtZGdwdV9zeW5jX2ZlbmNlKHN0
cnVjdCBhbWRncHVfc3luYyAqc3luYywgc3RydWN0IGRtYV9mZW5jZSAqZik7Cj4gK2ludCBhbWRn
cHVfc3luY19mZW5jZV9jaGFpbihzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsIHN0cnVjdCBkbWFf
ZmVuY2UgKmYpOwo+ICAgaW50IGFtZGdwdV9zeW5jX3ZtX2ZlbmNlKHN0cnVjdCBhbWRncHVfc3lu
YyAqc3luYywgc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpOwo+ICAgaW50IGFtZGdwdV9zeW5jX3Jl
c3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywK
PiAgIAkJICAgICBzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YsIGVudW0gYW1kZ3B1X3N5bmNfbW9kZSBt
b2RlLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
