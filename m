Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B9CC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C5C217F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5C217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E416EE0B;
	Wed,  6 Nov 2019 17:23:29 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7944E89C52;
 Wed,  6 Nov 2019 17:23:27 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j15so6224266wrw.5;
 Wed, 06 Nov 2019 09:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g2JUiV4cEMJ74EzA5CndgILOeZzbhz+aAeWFMe6S868=;
 b=Kwzi2trsrFr4mnqlLLbsyK5Vgg4soo3tFt9msJ7ejQWvxJ9BJ/tc2l7Lrmf/qE0nCd
 a/OMe2UDQheTcqfTzu1jraRpOn5zvpKw+Ytxs3duwmuAGir5z6gifqh6k176bYfCEbTh
 1NB8RwoxOK22W3PgN0I4/CU9HMarBKBPUxNqINBRbmOgjZuUAOWt8lMwe4lilkDuIagn
 3+mgviPNxCol1MsmfY48rldxE0Vazn8CM4Hwl134ochwgO2FBxjjdfPwnO7ZbhirtvOO
 OSfyXDkK6qoemdlTNn16Rah7WlIqULP1xPyLuVbCmDzfhAtIuYdJQDZy+iqr6e72+A85
 Z1gw==
X-Gm-Message-State: APjAAAXFc62h7LUMdK9oeGupcS3Mn8yV5a/Ul8RYcKfWczP2zzOZEAbv
 SETLbMhvhV7ZruxUboEAnaSNyu4D0oC+onQUudk=
X-Google-Smtp-Source: APXvYqyayQQbMyVmhEdowaJu+OzAwAXm3V5BG2Ss0sHIDjOI7FfL2E25/DMgXUkarNQ141qCBId2+p5LN2ULiVsCDTs=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3682762wre.11.1573061006001;
 Wed, 06 Nov 2019 09:23:26 -0800 (PST)
MIME-Version: 1.0
References: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
 <a3b2cc0c-2c0a-fcae-3750-9e51da46b872@amd.com>
In-Reply-To: <a3b2cc0c-2c0a-fcae-3750-9e51da46b872@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 12:23:14 -0500
Message-ID:
 <CADnq5_Nmxt9W-+QG_xmFzfWmbLM8Pv2GGnnhiA_NC8fuyz70kA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix double reference dropping
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g2JUiV4cEMJ74EzA5CndgILOeZzbhz+aAeWFMe6S868=;
 b=Wue/yaUEyKPQr5wZetfab8vqI/MzdYXYoInZoTyhPJLpCYE/99obFndF7Ijg2299pI
 qApCkDaCbIpuu+bLWLuYrR1rnklZf6mp2lQ5KbVyQCwBpSSps9NStPbeZMAoYo9Z+BGX
 EyXL8v5yoqddilskkPETIFCNQf/ylZt+vDiJLAPwVdohUgaeCx2PsHyQbJx6gH10WDUw
 S/jyaAJw7WUXXTOKsXSSChRc9DJ2/lnRuWnsX2geUc6FCKDi8vvPEERMRU9JlmgcoEgJ
 iCfpuXOXOPcA6R4ZtBVe8uJaph/NvmK47Csb/8TMxj1PMsyOHTZO+IGcl8jraJMdrGRD
 EQ1A==
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Pan Bian <bianpan2016@163.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106172314.2iPnn5Q0jyAGWve5TkQVgbURRTtUotk2UOZYgyEw0iE@z>

T24gV2VkLCBOb3YgNiwgMjAxOSBhdCA3OjQ4IEFNIEtvZW5pZywgQ2hyaXN0aWFuCjxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMDYuMTEuMTkgdW0gMTI6MzUgc2Nocmll
YiBQYW4gQmlhbjoKPiA+IFRoZSByZWZlcmVuY2UgdG8gb2JqZWN0IGZlbmNlIGlzIGRyb3BwZWQg
YXQgdGhlIGVuZCBvZiB0aGUgbG9vcC4KPiA+IEhvd2V2ZXIsIGl0IGlzIGRyb3BwZWQgYWdhaW4g
b3V0c2lkZSB0aGUgbG9vcC4gVGhlIHJlZmVyZW5jZSBjYW4gYmUKPiA+IGRyb3BwZWQgaW1tZWRp
YXRlbHkgYWZ0ZXIgY2FsbGluZyBkbWFfZmVuY2Vfd2FpdCgpIGluIHRoZSBsb29wIGFuZAo+ID4g
dGh1cyB0aGUgZHJvcHBpbmcgb3BlcmF0aW9uIG91dHNpZGUgdGhlIGxvb3AgY2FuIGJlIHJlbW92
ZWQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+
Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxleAoKPiA+IC0tLQo+ID4gdjI6IGZpeCB0aGUg
YnVnIGluIGEgbW9yZSBjb25jaXNlIHdheQo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYyB8IDYgKystLS0tCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYwo+ID4gaW5kZXggNjQ5ZTY4YzQ0
NzliLi5kMTQ5NWUxYzkyODkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9iZW5jaG1hcmsuYwo+ID4gQEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGludCBh
bWRncHVfYmVuY2htYXJrX2RvX21vdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2ln
bmVkIHNpemUsCj4gPiAgIHsKPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnRfamlmZmllczsK
PiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgZW5kX2ppZmZpZXM7Cj4gPiAtICAgICBzdHJ1Y3QgZG1h
X2ZlbmNlICpmZW5jZSA9IE5VTEw7Cj4gPiArICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsK
PiA+ICAgICAgIGludCBpLCByOwo+ID4KPiA+ICAgICAgIHN0YXJ0X2ppZmZpZXMgPSBqaWZmaWVz
Owo+ID4gQEAgLTQ0LDE2ICs0NCwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV9iZW5jaG1hcmtfZG9f
bW92ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgc2l6ZSwKPiA+ICAgICAg
ICAgICAgICAgaWYgKHIpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBleGl0X2RvX21v
dmU7Cj4gPiAgICAgICAgICAgICAgIHIgPSBkbWFfZmVuY2Vfd2FpdChmZW5jZSwgZmFsc2UpOwo+
ID4gKyAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPiA+ICAgICAgICAgICAgICAg
aWYgKHIpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBleGl0X2RvX21vdmU7Cj4gPiAt
ICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+ID4gICAgICAgfQo+ID4gICAgICAg
ZW5kX2ppZmZpZXMgPSBqaWZmaWVzOwo+ID4gICAgICAgciA9IGppZmZpZXNfdG9fbXNlY3MoZW5k
X2ppZmZpZXMgLSBzdGFydF9qaWZmaWVzKTsKPiA+Cj4gPiAgIGV4aXRfZG9fbW92ZToKPiA+IC0g
ICAgIGlmIChmZW5jZSkKPiA+IC0gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4g
PiAgICAgICByZXR1cm4gcjsKPiA+ICAgfQo+ID4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
