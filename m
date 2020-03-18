Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF52C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 08:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB66C2076C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 08:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+u7IH1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB66C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1FE6E87E;
	Wed, 18 Mar 2020 08:03:18 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12016E879
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 08:03:17 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id z12so2088106wmf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9IH4AFAE2jOAn4Itdm/F7GaoNUYzfdMfMkDb0Me85k8=;
 b=W+u7IH1jPoW7+RgYxmZ1YNZ0qaIOM8CaaaREIIOqhigQ2iRfCD+tUqSV3QoIZV7Pon
 ogdQDrPrGX8z1dnjuVI9yzvGvdvL5TXqUScE3sMJw0RtcJOlD/H6bEsnuBjXsnHX0gz1
 +lPmYFgZQ2s0apWgCeGqnUvyPTXfSXP5Zt3k9KhBnciKnOEs5cky/7Qp0ar+U5JI/2b1
 HqYZBfUMkGNDkzPllQbduyH+IzRtisH78gTT3UnhmyiNVKiESdNmsiqr0M9EtjkAmu0a
 EiFwTdWDJKPR1Rmpm8Ri/sabB0cABMK2DQbBEQPMKlibBB632aildLWC94i8xKiwzk87
 9bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=9IH4AFAE2jOAn4Itdm/F7GaoNUYzfdMfMkDb0Me85k8=;
 b=LR9IfA3ZXknOs5xJLgnRtqPNsBpwkh6APk3iuVuyyZivN4VMvaVlX/5RKqhHEmQMwa
 MHcCY3foaZaFXDkfEJZT5zjtqcsSBCKKem3MInkP+zPPgC2jzUC3KFeN75l/LTdKSzV3
 zqMZ06oDJ/oUnyBbxvgey4Sh37u2xChcsi+U9WBxNsXWf7XlE2yzaY33hiQH+EZ3Hs+N
 HGnBhGhZSUEC1CCNGWZ1Gy8K65/pfCHdSE6UHdyviH/IQs827MRu7HoJaMpl4mA9/FoV
 f0ANa4rJ2khMFsivxe08lOqmyfwK5a4iZI95gnoKzQQ6HnEjsYmYbjEVvXdV16u1wRDB
 mAPQ==
X-Gm-Message-State: ANhLgQ1MyVqraSNi+is3VVjDUkM7tePiEK/7sbCSkgAHRsCIeVTTKjXH
 79e7t1Di4DehR0kLezdx+HfE7r4X
X-Google-Smtp-Source: ADFU+vtw7N7dAHLHR9c69TvyTB7KlxwG70mVj2zZOonCUgzO1KF8D8L+tChuzy2V5QH3SMIDLYZb5A==
X-Received: by 2002:a7b:c7d9:: with SMTP id z25mr3923134wmk.25.1584518596446; 
 Wed, 18 Mar 2020 01:03:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q7sm8846228wrd.54.2020.03.18.01.03.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:03:16 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200316132235.82022-1-christian.koenig@amd.com>
 <9e4b394a-59e3-cae7-1dd2-63c0a692cefb@gmail.com>
 <CD744AEA-A602-4E04-B754-CF21019A65D5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1a896b9d-e256-5b46-7e0f-1e39405b8f82@gmail.com>
Date: Wed, 18 Mar 2020 09:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CD744AEA-A602-4E04-B754-CF21019A65D5@amd.com>
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGtleSBwb2ludCBpcyB0aGF0IDEwbXMgc2hvdWxkIGJlIHN1ZmZpY2llbnQgdGhhdCBlaXRo
ZXIgdGhlIG1vdmUgb3IgCnRoZSB1cGRhdGUgaXMgZmluaXNoZWQuCgpPbmUgYWx0ZXJuYXRpdmUg
d2hpY2ggY2FtZSB0byBteSBtaW5kIHdvdWxkIGJlIHRvIGFkZCB0aGUgZXhjbHVzaXZlIApmZW5j
ZSBhcyBzaGFyZWQgYXMgd2VsbCBpbiB0aGlzIGNhc2UuCgpUaGlzIHdheSB3ZSB3b24ndCBuZWVk
IHRvIGJsb2NrIGF0IGFsbC4KCkNocmlzdGlhbi4KCkFtIDE4LjAzLjIwIHVtIDA5OjAwIHNjaHJp
ZWIgUGFuLCBYaW5odWk6Cj4gSSB3b25kZXIgaWYgaXQgcmVhbGx5IGZpeCBhbnl0aGluZyB3aXRo
IHN1Y2ggc21hbGwgZGVsYXkuIGJ1dCBpdCBzaG91bGQgYmUgbm8gaGFybSBhbnl3YXkuCj4KPiBS
ZXZpZXdlZC1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+Cj4+IDIwMjDlubQz
5pyIMTjml6UgMTU6NTHvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IFBpbmc/IFhpbmh1aSBjYW4gSSBnZXQgYW4gcmIg
Zm9yIHRoaXM/Cj4+Cj4+IFRoYW5rcywKPj4gQ2hyaXN0aWFuLgo+Pgo+PiBBbSAxNi4wMy4yMCB1
bSAxNDoyMiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0
IHdlIGNhbid0IGFkZCB0aGUgY2xlYXIgZmVuY2UgdG8gdGhlIEJPCj4+PiB3aGVuIHRoZXJlIGlz
IGFuIGV4Y2x1c2l2ZSBmZW5jZSBvbiBpdCBzaW5jZSB3ZSBjYW4ndAo+Pj4gZ3VhcmFudGVlIHRo
ZSB0aGUgY2xlYXIgZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0aGUKPj4+IGV4Y2x1c2l2ZSBv
bmUuCj4+Pgo+Pj4gVG8gZml4IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0aW9uIGFuZCB3YWl0IGZv
ciBhbnkgcG90ZW50aWFsCj4+PiBleGNsdXNpdmUgZmVuY2Ugd2l0aCBhIHNtYWxsIHRpbWVvdXQg
YmVmb3JlIGFkZGluZyB0aGUKPj4+IHNoYXJlZCBjbGVhciBmZW5jZS4KPj4+Cj4+PiB2MjogZml4
IHdhcm5pbmcKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jIHwgNDMgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+Pj4gICAxIGZp
bGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gaW5kZXggNWJlYzY2ZTZiMWY4
Li40OWM5MWRhYzM1YTAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwo+Pj4gQEAgLTE2MSwxMCArMTYxLDExIEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3Rf
Y2xvc2Uoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCj4+PiAgICAgCXN0cnVjdCBhbWRncHVf
Ym9fbGlzdF9lbnRyeSB2bV9wZDsKPj4+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwgZHVwbGlj
YXRlczsKPj4+ICsJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOwo+Pj4gICAJc3RydWN0
IHR0bV92YWxpZGF0ZV9idWZmZXIgdHY7Cj4+PiAgIAlzdHJ1Y3Qgd3dfYWNxdWlyZV9jdHggdGlj
a2V0Owo+Pj4gICAJc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmE7Cj4+PiAtCWludCByOwo+Pj4g
Kwlsb25nIHI7Cj4+PiAgICAgCUlOSVRfTElTVF9IRUFEKCZsaXN0KTsKPj4+ICAgCUlOSVRfTElT
VF9IRUFEKCZkdXBsaWNhdGVzKTsKPj4+IEBAIC0xNzgsMjggKzE3OSwzNiBAQCB2b2lkIGFtZGdw
dV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLAo+Pj4gICAJciA9
IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMoJnRpY2tldCwgJmxpc3QsIGZhbHNlLCAmZHVwbGljYXRl
cyk7Cj4+PiAgIAlpZiAocikgewo+Pj4gICAJCWRldl9lcnIoYWRldi0+ZGV2LCAibGVha2luZyBi
byB2YSBiZWNhdXNlICIKPj4+IC0JCQkid2UgZmFpbCB0byByZXNlcnZlIGJvICglZClcbiIsIHIp
Owo+Pj4gKwkJCSJ3ZSBmYWlsIHRvIHJlc2VydmUgYm8gKCVsZClcbiIsIHIpOwo+Pj4gICAJCXJl
dHVybjsKPj4+ICAgCX0KPj4+ICAgCWJvX3ZhID0gYW1kZ3B1X3ZtX2JvX2ZpbmQodm0sIGJvKTsK
Pj4+IC0JaWYgKGJvX3ZhICYmIC0tYm9fdmEtPnJlZl9jb3VudCA9PSAwKSB7Cj4+PiAtCQlhbWRn
cHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKPj4+ICsJaWYgKCFib192YSB8fCAtLWJvX3ZhLT5y
ZWZfY291bnQpCj4+PiArCQlnb3RvIG91dF91bmxvY2s7Cj4+PiAgIC0JCWlmIChhbWRncHVfdm1f
cmVhZHkodm0pKSB7Cj4+PiAtCQkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOwo+Pj4g
KwlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKPj4+ICsJaWYgKCFhbWRncHVfdm1fcmVh
ZHkodm0pKQo+Pj4gKwkJZ290byBvdXRfdW5sb2NrOwo+Pj4gICAtCQkJciA9IGFtZGdwdV92bV9j
bGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsKPj4+IC0JCQlpZiAodW5saWtlbHkocikpIHsK
Pj4+IC0JCQkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFnZSAiCj4+PiAt
CQkJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7Cj4+PiAtCQkJfQo+
Pj4gICAtCQkJaWYgKGZlbmNlKSB7Cj4+PiAtCQkJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2Us
IHRydWUpOwo+Pj4gLQkJCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPj4+IC0JCQl9Cj4+PiAtCQl9
Cj4+PiAtCX0KPj4+ICsJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNl
KTsKPj4+ICsJaWYgKHIgfHwgIWZlbmNlKQo+Pj4gKwkJZ290byBvdXRfdW5sb2NrOwo+Pj4gKwo+
Pj4gKwlyID0gZG1hX3Jlc3Zfd2FpdF90aW1lb3V0X3JjdShiby0+dGJvLmJhc2UucmVzdiwgZmFs
c2UsIGZhbHNlLAo+Pj4gKwkJCQkgICAgICBtc2Vjc190b19qaWZmaWVzKDEwKSk7Cj4+PiArCWlm
IChyID09IDApCj4+PiArCQlyID0gLUVUSU1FRE9VVDsKPj4+ICsJaWYgKHIpCj4+PiArCQlnb3Rv
IG91dF91bmxvY2s7Cj4+PiArCj4+PiArCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUp
Owo+Pj4gKwlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPj4+ICsKPj4+ICtvdXRfdW5sb2NrOgo+Pj4g
KwlpZiAodW5saWtlbHkociA8IDApKQo+Pj4gKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQg
dG8gY2xlYXIgcGFnZSAiCj4+PiArCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglbGQp
XG4iLCByKTsKPj4+ICAgCXR0bV9ldV9iYWNrb2ZmX3Jlc2VydmF0aW9uKCZ0aWNrZXQsICZsaXN0
KTsKPj4+ICAgfQo+Pj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
