Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D14C2BA18
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 07:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F44206F8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 07:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvEC1v1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F44206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C116E233;
	Mon,  6 Apr 2020 07:03:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9D36E233
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 07:03:37 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id s8so13907153wrt.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fAnYfrrZJRWB/rls5RAP7gbPHUtkVOpQJWpzfm9AHi0=;
 b=fvEC1v1F5vkkQ7LcAgvRqGrazol4uJYMXQuTAElNF+DKxmeG1nZd768BlH9F3pFNXo
 IIlu/cYrL0fsyUB1RQuXOeMXf19E4NWHiSuKGo+v3m2elGyjR39NUDgHpWFpCthc4cJo
 Hgwtizh3xjbRgPT7+N4BY0RpwWt60riTDOiMKXNh+uRR71rUUSyVcCisIun46JRK0Zeq
 WkJX2oOxNKaHpuu5g+JrQ6SNuXi/zkwQ5T7Wlw5FPPjiPRk2i48QvDnVW/s+SI3PH4mJ
 t45+NrCSA4cCi1H3e0O+DOzSEhjjM9qCU6VxaFLvCMdeB8VDOVRSk0T0QMWq7Lf2C8C6
 Txvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=fAnYfrrZJRWB/rls5RAP7gbPHUtkVOpQJWpzfm9AHi0=;
 b=Pq/VbCb+SbClHdp8r78LzwKIgkMYN7PzvXezbllRo4/xlDtWxEr70sOFcYSW1Y8cjW
 s9XxgGyp/i35YMJFpRTaBfYUUjyIzruBw5dX6TOQI2Xk/D4rCVvZ+4APz9taskig2f6Y
 zXES6PajTG722G1b6eZbj1Jf7glzWNneaSL1g7VZnGXxPv7RxHKYitL+/N66fObl0Itq
 OvovpFg5jsswhwgwJMCoxevSo2EAMMh0E/SHj9dDVJP72diinGaD59m7n1wa+76EFYiA
 TxdT1pUmYzEPWymwyZ0HMwRsHcalSEtUf+vkj1i6LGfB0llyJje2FTy0ZMZnJ7N6z9Fv
 JvWQ==
X-Gm-Message-State: AGi0Pub8mT5Buoi6l5frxcwJ3IqAw49O6TU9f4vkpVtHhPArMQ/4R6Vf
 h61eFp9X8PS2hcO63hGoFN59325Y
X-Google-Smtp-Source: APiQypJKlyB2gHhtfz/koMJMU6ZkqqbApid5tPfF6T7PeVdTkehEyN00O8EG4qwt3pgfjMfCNyrc0w==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr21953928wrp.420.1586156615646; 
 Mon, 06 Apr 2020 00:03:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k184sm9779721wmf.9.2020.04.06.00.03.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2020 00:03:34 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
To: James Zhu <jamesz@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 James Zhu <James.Zhu@amd.com>
References: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OwEiyjtfoy4ri+wMt9KTL7cZirrKJFhsQmYncPHSeH-g@mail.gmail.com>
 <62cc4dea-88aa-15cc-cc54-9f5fc5fdea38@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fd093239-d748-a232-8f96-666753f99a82@gmail.com>
Date: Mon, 6 Apr 2020 09:03:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <62cc4dea-88aa-15cc-cc54-9f5fc5fdea38@amd.com>
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDQuMjAgdW0gMTc6NTQgc2NocmllYiBKYW1lcyBaaHU6Cj4KPiBPbiAyMDIwLTA0LTAz
IDExOjM3IGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4gT24gRnJpLCBBcHIgMywgMjAyMCBh
dCA4OjUyIEFNIEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+IHdyb3RlOgo+Pj4gVkNOIHNo
YXJlZCBtZW1vcnkgbmVlZHMgcmVzdG9yZSBhZnRlciB3YWtlIHVwIGR1cmluZyBTMyB0ZXN0Lgo+
PiBIb3cgYmlnIGlzIHRoZSBzaGFyZWQgbWVtb3J5P8KgIEl0IG1pZ2h0IGJlIGJldHRlciB0byBh
bGxvY2F0ZSB0aGUKPj4gbWVtb3J5IG9uY2UgYXQgc3dfaW5pdCBhbmQgdGhlbiBmcmVlIGl0IGlu
IHN3X2ZpbmkgcmF0aGVyIHRoYW4KPj4gYWxsb2NhdGluZyBhbmQgZnJlZWluZyBpbiBldmVyeSBz
dXNwZW5kL3Jlc3VtZS4KPgo+IEhpIEFsZXgsCj4KPiBBZnRlciBhbGlnbm1lbnQsIGl0IGlzIG9u
bHkgNGsuIEkgY2FuIGNoYW5nZSBpdCBhcyB5b3Ugc3VnZ2VzdC4KCkRvZXMgdGhpcyBuZWVkcyB0
byBzdGF5IGF0IHRoZSBzYW1lIHBsYWNlIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWU/CgpTZWUgd2Ug
b25seSBiYWNrdXAgdGhlIGZpcm13YXJlIG1hbnVhbGx5IGJlY2F1c2Ugd2Ugb3RoZXJ3aXNlIGNh
bid0IApndWFyYW50ZWUgdGhhdCBpdCB3aWxsIGJlIG1vdmVkIGJhY2sgdG8gdGhlIHNhbWUgcGxh
Y2UgYWZ0ZXIgcmVzdW1lLgoKSWYgdGhhdCBpc24ndCBhbiBpc3N1ZSBmb3IgdGhlIHNoYXJlZCBi
byB3ZSBjb3VsZCBqdXN0IHVucGluIGl0IG9uIApzdXNwZW5kIGFuZCBwaW4gaXQgYWdhaW4gb24g
cmVzdW1lLgoKQlRXOiBXaGF0IGlzIHRoYXQgdXNlZCBmb3IgYW5kIHdoeSBjYW4ndCBpdCBiZSBw
YXJ0IG9mIHRoZSBWQ04gZmlybXdhcmUgQk8/CgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPiBCZXN0
IFJlZ2FyZHMhCj4KPiBKYW1lcwo+Cj4+Cj4+IEFsZXgKPj4KPj4+IFNpZ25lZC1vZmYtYnk6IEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDI2IAo+Pj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysKPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCB8wqAg
MSArCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIAo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+IGluZGV4IGQ2NTNhMTgu
LjU4OTEzOTAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
Ywo+Pj4gQEAgLTIwNSw2ICsyMDUsNyBAQCBpbnQgYW1kZ3B1X3Zjbl9zd19maW5pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGopKQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGt2ZnJlZShhZGV2LT52Y24uaW5zdFtqXS5zYXZl
ZF9zaG1fYm8pOwo+Pj4gYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT52Y24uaW5zdFtqXS5m
d19zaGFyZWRfYm8sCj4+PiAmYWRldi0+dmNuLmluc3Rbal0uZndfc2hhcmVkX2dwdV9hZGRyLAo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh2b2lkIAo+Pj4gKiopJmFkZXYtPnZjbi5p
bnN0W2pdLmZ3X3NoYXJlZF9jcHVfYWRkcik7Cj4+PiBAQCAtMjU0LDYgKzI1NSwxOCBAQCBpbnQg
YW1kZ3B1X3Zjbl9zdXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVN
Owo+Pj4KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweV9mcm9taW8o
YWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfYm8sIHB0ciwgc2l6ZSk7Cj4+PiArCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmluc3RbaV0uZndfc2hhcmVkX2Jv
ID09IE5VTEwpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXpl
ID0gYW1kZ3B1X2JvX3NpemUoYWRldi0+dmNuLmluc3RbaV0uZndfc2hhcmVkX2JvKTsKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ciA9IGFkZXYtPnZjbi5pbnN0W2ldLmZ3X3No
YXJlZF9jcHVfYWRkcjsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFk
ZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibyA9IGt2bWFsbG9jKHNpemUsIAo+Pj4gR0ZQX0tF
Uk5FTCk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYtPnZjbi5p
bnN0W2ldLnNhdmVkX3NobV9ibykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4+ICsKPj4+ICsgbWVtY3B5X2Zyb21pbyhh
ZGV2LT52Y24uaW5zdFtpXS5zYXZlZF9zaG1fYm8sIHB0ciwgc2l6ZSk7Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9Cj4+PiBAQCAt
MjkxLDYgKzMwNCwxOSBAQCBpbnQgYW1kZ3B1X3Zjbl9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1lbXNldF9pbyhwdHIsIDAsIHNpemUpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFk
ZXYtPnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9ibyA9PSBOVUxMKQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IGFtZGdwdV9ib19zaXplKGFkZXYt
PnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9ibyk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwdHIgPSBhZGV2LT52Y24uaW5zdFtpXS5md19zaGFyZWRfY3B1X2FkZHI7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmluc3RbaV0uc2F2
ZWRfc2htX2JvICE9IE5VTEwpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBtZW1jcHlfdG9pbyhwdHIsIAo+Pj4gYWRldi0+dmNuLmluc3RbaV0uc2F2
ZWRfc2htX2JvLCBzaXplKTsKPj4+ICsga3ZmcmVlKGFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3No
bV9ibyk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfc2htX2JvID0gTlVMTDsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0gZWxzZQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1lbXNldF9pbyhwdHIsIDAsIHNpemUpOwo+Pj4gwqDCoMKgwqDCoMKg
wqDCoCB9Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gwqAgfQo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCAKPj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+PiBpbmRleCBmNzM5ZTFhLi5i
ZDc3ZGFlIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgK
Pj4+IEBAIC0xOTQsNiArMTk0LDcgQEAgc3RydWN0IGFtZGdwdV92Y25faW5zdCB7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgIGF0b21pY190wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRwZ19l
bmNfc3VibWlzc2lvbl9jbnQ7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIHZvaWTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZndfc2hhcmVkX2NwdV9hZGRyOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCB1aW50NjRfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmd19zaGFy
ZWRfZ3B1X2FkZHI7Cj4+PiArwqDCoMKgwqDCoMKgIHZvaWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqc2F2ZWRfc2htX2JvOwo+Pj4gwqAgfTsKPj4+Cj4+PiDCoCBzdHJ1
Y3QgYW1kZ3B1X3ZjbiB7Cj4+PiAtLSAKPj4+IDIuNy40Cj4+Pgo+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3
QzAxJTdDSmFtZXMuWmh1JTQwYW1kLmNvbSU3QzQ2YzQ3NzMxNjQzMzRlYzcxMmI3MDhkN2Q3ZTRl
YmQ2JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIxNTI1
MDUxODkwMzE0MyZhbXA7c2RhdGE9TWolMkZnZVhLa2lOVkZVVXN5S0Flc0M1ZWFhbkRnJTJGdlFR
cFFlMXJoVDl1ZWslM0QmYW1wO3Jlc2VydmVkPTAgCj4+Pgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
