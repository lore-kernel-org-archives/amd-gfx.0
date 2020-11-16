Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EEC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7F420702
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifKnE5Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7F420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7E96EA5E;
	Mon, 16 Nov 2020 20:09:20 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3688E6EA5E;
 Mon, 16 Nov 2020 20:09:19 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so3007074wrg.7;
 Mon, 16 Nov 2020 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pg6uaDKDYNPDperu96oj5Pj32go0EMzBskVqcWRUwJg=;
 b=ifKnE5TyrOtX4QVZ0FKpawewZ53nJLm99KV7Ro0ExwFgjQ5x79c0u1CqIJJ8xFuJv5
 gK+51TWymqdA37R1DqjBN1S3tZk+1+Z90z6oNROFp1oNx6jR1YMi9VuTNZa/xtiyDxeN
 HdBAbjtr/Qxp3BDby/S4LAHmxV6vQIsc7ElE0Oj874f9rGWi6JXNCjVnSqsGpdomUMgD
 PA8D/IrD1srimFCrsD+Ac7srzfvUGp3A+TzHlf3gu3bQ6f7H1Oh4XILkEGKgMEKZOe6W
 rjPkOtYUF09a0VFO1SJiKgXqNC7zhwS6b77vA6I8ER5XWzp//sagLgqK7Qqfaltc4SUl
 WMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pg6uaDKDYNPDperu96oj5Pj32go0EMzBskVqcWRUwJg=;
 b=VpmlYfjVDro4kmZXhZclo97+k+iF7IVscFP1cIsrC3wBT5UUnKz0als2lrfbIU05V1
 9XHQrdr4f87r170eunwSpcJvHNc/HcqpsFBV44uu5D05Ngstjn1k/9BSlC/bvrmps6lN
 WceptcTLjOHw9ideXr+OM0jxYZ1GBvrxeL7rOqdr53R6cXGb9nzi5por+IDALojw+d+b
 SVlBtEwEbSO/I2KpT+YcW2Dcc4mv9r2VVqbbRsTjlEZortsJCOXtGp5QRBpVjkv0jTo1
 YaDDq81wsHrX5xZZLkLsXFIi8Irn5b50Xp/svnhRciJzhZp6+CxwsRRL9IOIlRqAOGhq
 cuSQ==
X-Gm-Message-State: AOAM531lcrZHGYb66OvYkdJeRm2o4Np8DOqZ9RzGLNrXgDW7eSvuCcJa
 oHJ255J2LA6KF5ufRyLdc3rtY6aVJV5sPLb63Fc=
X-Google-Smtp-Source: ABdhPJwT64UuAgjZK9kFkJMd/Zlx/HK9C7umlQpb+s00D/ZGhxNus/6SRixMlRH+h5U5RxW5C524zCzR6EoE2xknsnI=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21548934wrm.374.1605557357973; 
 Mon, 16 Nov 2020 12:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-20-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:09:07 -0500
Message-ID: <CADnq5_P3Otrk=UeG+G2T8p8NcwGWBrdQSgddhp9tJYi9A_SBXA@mail.gmail.com>
Subject: Re: [PATCH 19/43] drm/radeon/ni_dpm: Move 'ni_get_{pi, ps}()'s into
 shared header
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzggUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5jOjcyNzoyMzog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhuaV9nZXRfcGnigJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQo+ICA3MjcgfCBzdHJ1Y3QgbmlfcG93ZXJfaW5mbyAqbmlfZ2V0X3Bp
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICB8IF5+fn5+fn5+fgo+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL25pX2RwbS5jOjczNDoxNTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhuaV9nZXRfcHPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICA3MzQgfCBz
dHJ1Y3QgbmlfcHMgKm5pX2dldF9wcyhzdHJ1Y3QgcmFkZW9uX3BzICpycHMpCj4gIHwgXn5+fn5+
fn5+Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vbmlfZHBtLmggfCAzICsrKwo+ICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpX2RwbS5jIHwgMyArLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9uaV9kcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmlfZHBtLmgKPiBpbmRleCA2YmJl
ZTkxODA5MDllLi43NGUzMDE5MzY5MDYzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vbmlfZHBtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5oCj4g
QEAgLTI0Nyw0ICsyNDcsNyBAQCB2b2lkIG5pX3NldF91dmRfY2xvY2tfYWZ0ZXJfc2V0X2VuZ19j
bG9jayhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKPgo+ICBib29sIG5pX2RwbV92Ymxhbmtf
dG9vX3Nob3J0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPgo+ICtzdHJ1Y3QgbmlfcG93
ZXJfaW5mbyAqbmlfZ2V0X3BpKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiArc3RydWN0
IG5pX3BzICpuaV9nZXRfcHMoc3RydWN0IHJhZGVvbl9wcyAqcnBzKTsKPiArCj4gICNlbmRpZgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+IGluZGV4IGE4MGEyMTQ0N2E3NmQuLmM2OGFiMmZiMWFj
MjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKPiBAQCAtMzAsNiArMzAsNyBAQAo+ICAj
aW5jbHVkZSAicnY3NzAuaCIKPiAgI2luY2x1ZGUgInJhZGVvbi5oIgo+ICAjaW5jbHVkZSAicmFk
ZW9uX2FzaWMuaCIKPiArI2luY2x1ZGUgIm5pX2RwbS5oIgo+ICAjaW5jbHVkZSAic2lfZHBtLmgi
Cj4gICNpbmNsdWRlICJzaWQuaCIKPgo+IEBAIC0xNzE5LDggKzE3MjAsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNpX3Bvd2VydHVuZV9kYXRhIHBvd2VydHVuZV9kYXRhX2hhaW5hbiA9Cj4gIH07
Cj4KPiAgc3RydWN0IGV2ZXJncmVlbl9wb3dlcl9pbmZvICpldmVyZ3JlZW5fZ2V0X3BpKHN0cnVj
dCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAtc3RydWN0IG5pX3Bvd2VyX2luZm8gKm5pX2dldF9w
aShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gLXN0cnVjdCBuaV9wcyAqbmlfZ2V0X3Bz
KHN0cnVjdCByYWRlb25fcHMgKnJwcyk7Cj4KPiAgZXh0ZXJuIGludCBzaV9tY19sb2FkX21pY3Jv
Y29kZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIGV4dGVybiB2b2lkIHZjZV92MV8w
X2VuYWJsZV9tZ2NnKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJsZSk7Cj4g
LS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
