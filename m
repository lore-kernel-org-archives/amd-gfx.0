Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3CCA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8911E205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561A86E897;
	Mon, 28 Oct 2019 14:08:02 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D976E897
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:08:00 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p4so10035322wrm.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 07:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d/47im9brVsJSTkMNILhiZRSBCNfo+zwZlKSgFnsmGs=;
 b=fuwHt/HKeFC3nzULnCztD20qLwLw2noLpvy24EsCBquXCQMtYwcDQHQFHTv1QYJdVj
 Ni6IDBBYeKoPu/Ka39Ef7Iej91Ra41nokhT1qz1r1ZuHHtO3TLi8CzfMAefMYTBDmTl2
 GlDJKklxYlFEIo31pDD2OKRKcpQ2xq8i6CJ7pFpdmhW3jvxA75+t5OTmWtarI1FU5q0H
 m5GmSl4Tt+fMyzb8SCciJJg6teZTBkMGLutOdu8FjHHyrBIcjmt5BqbbvB00GyGBcai2
 Dx6O7DcbbYFT7QFcfPhI0GsxpyAF7EG8e6itFXMbpIXYAWPBvUyMuRvgW8JQJbmX+LdS
 94HQ==
X-Gm-Message-State: APjAAAUoVi7+6Z/370TTcf6NaNRuwgnFx8XroWjuJPoxozlF2AF25S+S
 2/se47NsV+DlOCMrwRQWmmwaa2FqptUDMdqPwdw=
X-Google-Smtp-Source: APXvYqz4rOIvSdNKPGhhOzTx+kL8Bk0ytJVzgnAvIbIIvMJqbEsbhkQB2tK2ydYBjlczSIdAjvKw8xeM6QiEVHZRRe8=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr15791854wrr.50.1572271679494; 
 Mon, 28 Oct 2019 07:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 10:07:47 -0400
Message-ID:
 <CADnq5_Mky3rf8x2f1VJinDO02fQ8UBEW-iDL5nUHrAsSXQKHVg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=d/47im9brVsJSTkMNILhiZRSBCNfo+zwZlKSgFnsmGs=;
 b=DES0NVXXyc1jwo4feKDitsOYMf089nFp8uRQsS9h55Ob/Y8Wr5Qv1vWwZG2ozqcJWG
 hG9yXunShV2fEDREybw2fhcRFjoYK2ZPofnlP2+D9hElaa8Q8priLJpU2tggW4tKujDe
 c4M9ryHKMiFAMO2w/y4LRVQTknjzUeEmL6B7rBQ6wRS9DVyKVfQvwSKOK3aG6oUfjJYH
 cE9To10KIO7p/7G+IwM653KsrpZHgEp7PP8wi7vh5fRzLV8xaRH9bqteFbq3BlOtAUjx
 spLW3iOkMOXm2NsiFRcwxaFanKJDltufbGXAQXa9ytt+pm2K8s1eJW3z5k+K8OOM7Dzx
 NUBw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "for 3.8" <stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140747.ysIdwGwlGWmuQ2ucmcPavZYc6Vk9VS_F_xiABoDYq04@z>

T24gRnJpLCBPY3QgMjUsIDIwMTkgYXQgNDo0NCBQTSBLeWxlTWFobGt1Y2gKPGttYWhsa3VjQGxp
bnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBLeWxlIE1haGxrdWNoIDxrbWFobGt1
Y0BsaW51eC52bmV0LmlibS5jb20+Cj4KPiBEdXJpbmcga2V4ZWMgc29tZSBhZGFwdGVycyBoaXQg
YW4gRUVIIHNpbmNlIHRoZXkgYXJlIG5vdCBwcm9wZXJseQo+IHNodXQgZG93biBpbiB0aGUgcmFk
ZW9uX3BjaV9zaHV0ZG93bigpIGZ1bmN0aW9uLiBBZGRpbmcKPiByYWRlb25fc3VzcGVuZF9rbXMo
KSBmaXhlcyB0aGlzIGlzc3VlLgo+IEVuYWJsZWQgb25seSBvbiBQUEMgYmVjYXVzZSB0aGlzIHBh
dGNoIGNhdXNlcyBpc3N1ZXMgb24gc29tZSBvdGhlcgo+IGJvYXJkcy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IEt5bGUgTWFobGt1Y2ggPGttYWhsa3VjQGxpbnV4LnZuZXQuaWJtLmNvbT4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuYyB8IDE0ICsrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwo+IGluZGV4IDllNTUwNzYuLjQ1
MjhmNGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwo+IEBAIC0zNzksMTEg
KzM3OSwyNSBAQCBzdGF0aWMgaW50IHJhZGVvbl9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBk
ZXYsCj4gIHN0YXRpYyB2b2lkCj4gIHJhZGVvbl9wY2lfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYg
KnBkZXYpCj4gIHsKPiArI2lmZGVmIENPTkZJR19QUEM2NAo+ICsgICAgICAgc3RydWN0IGRybV9k
ZXZpY2UgKmRkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4gKyNlbmRpZgo+ICsKPiAgICAg
ICAgIC8qIGlmIHdlIGFyZSBydW5uaW5nIGluIGEgVk0sIG1ha2Ugc3VyZSB0aGUgZGV2aWNlCj4g
ICAgICAgICAgKiB0b3JuIGRvd24gcHJvcGVybHkgb24gcmVib290L3NodXRkb3duCj4gICAgICAg
ICAgKi8KPiAgICAgICAgIGlmIChyYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwoKSkKPiAgICAgICAg
ICAgICAgICAgcmFkZW9uX3BjaV9yZW1vdmUocGRldik7Cj4gKwo+ICsjaWZkZWYgQ09ORklHX1BQ
QzY0Cj4gKyAgICAgICAvKiBTb21lIGFkYXB0ZXJzIG5lZWQgdG8gYmUgc3VzcGVuZGVkIGJlZm9y
ZSBhCj4gKyAgICAgICAgKiBzaHV0ZG93biBvY2N1cnMgaW4gb3JkZXIgdG8gcHJldmVudCBhbiBl
cnJvcgo+ICsgICAgICAgICogZHVyaW5nIGtleGVjLgo+ICsgICAgICAgICogTWFrZSB0aGlzIHBv
d2VyIHNwZWNpZmljIGJlY2F1YXNlIGl0IGJyZWFrcwo+ICsgICAgICAgICogc29tZSBub24tcG93
ZXIgYm9hcmRzLgo+ICsgICAgICAgICovCj4gKyAgICAgICByYWRlb25fc3VzcGVuZF9rbXMoZGRl
diwgdHJ1ZSwgdHJ1ZSwgZmFsc2UpOwo+ICsjZW5kaWYKPiAgfQo+Cj4gIHN0YXRpYyBpbnQgcmFk
ZW9uX3Btb3BzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+IC0tCj4gMS44LjMuMQo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
