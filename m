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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FEC4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213AD217A0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT0sw49x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213AD217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78C76EA63;
	Mon, 16 Nov 2020 20:14:10 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3920E6EA62;
 Mon, 16 Nov 2020 20:14:09 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id u12so12989319wrt.0;
 Mon, 16 Nov 2020 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tlFFgICp87GKZs6ppYHW2rMrLGlJH6xaYF8VswIu2r8=;
 b=WT0sw49xTmzfyuepsj8KVXsdlk1NQkHaKlUQDvqqCND8FHQvwhpnn5uYP+2zZFQqwM
 KNWPU3FwKRP61VymQxCJZHLZV0dAJ45Cps+OhCDc0YK+sXtLuue6vP7BpskUJX7ZUJ57
 qL0/dBLUyqYtQGcva88qLlsGCsI/FuxjDlaUSGLArXtDdLZLUZOBRv2vzC6grY8K6OMs
 wFTCh0+FP/0N8Qt8QntAZM8DbbxAZMinOAJwQN7fck93Z4Nht3bFmEmOoWlJuZ+59Kjd
 6K7gXi2b1wLdOin94HV94OP7+jPb7hOVzRao03uMhSd5WCv9In1zGKphSqfKSpBoH0E/
 kwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tlFFgICp87GKZs6ppYHW2rMrLGlJH6xaYF8VswIu2r8=;
 b=lyCDG3wT/KKFB02RDix3/m1fBjLBbSe6BhDO2QFoPiLhgJDiGCP0JqyIsTjKrJ3iog
 /yvntcIcttTlRNNVjuD1r0a0sTLU+SJMlRMMPUlIyE4p4/E0ojuWFt1r8pp6cKSqcUBX
 HYO6o+gVyPTBzfZyQtn1RFY0YlwdNRxHXlcLROP7nPmw2FN6CuSkX9Ga0972Lcsk9mMx
 ydz78mn8s6cYrROyBCQIJ71oIFhRIdqRzofbk4VH9xbYKamHmUdu9RqaEMenALS/+/Pj
 hmTXjzyImEAGK4z/YGkcIBSos5sX1g2IBQjqZ40tVQJV3KpVCnzO2kvrEdHMtmedzqM5
 g2NQ==
X-Gm-Message-State: AOAM5304fvev1pxE58qCAPW7bmd4Hw5nU3fVrdLiExFYw48iqTJAJySp
 j5tv1p59DUF2iF3m0o88cp82bUOkrfRnMFFVeuU=
X-Google-Smtp-Source: ABdhPJyhVjBfB4XwW22p2f67Xq+c+n49ESvD/mLBvHttBW5MOL3/bbo6s1Z+aAzlKoUDvKA9FP/lfmG14QOnR/KpvmY=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4516760wrj.419.1605557647980; 
 Mon, 16 Nov 2020 12:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-22-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-22-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:13:56 -0500
Message-ID: <CADnq5_MosQTaddZ7-ydRiGjPZ6FZ26F_WXgwV7MN5wmaqdEm0w@mail.gmail.com>
Subject: Re: [PATCH 21/43] drm/radeon/r600_dma: Move
 'r600_gpu_check_soft_reset()'s prototype to shared location
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzggUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYzoxNjE1OjU6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcjYwMF9ncHVfY2hlY2tfc29mdF9y
ZXNldOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gIDE2MTUgfCB1MzIgcjYwMF9ncHVfY2hl
Y2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKPiAgfCBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxp
bmFyby5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwu
b3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkIHdpdGggbWlub3IgY2hh
bmdlcy4gIFRoYW5rcyEKCkFsZXgKCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2
MDAuYyAgICAgfCAgMSArCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5oICAgICB8IDM1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yNjAwX2RtYS5jIHwgIDMgKy0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcjYwMC5oCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAw
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYwo+IGluZGV4IGYwOWI2ZGM1Y2JlYjMu
Ljk0ZTg4MTVlNTA2N2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAw
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYwo+IEBAIC0zOSw2ICszOSw3
IEBACj4KPiAgI2luY2x1ZGUgImF0b20uaCIKPiAgI2luY2x1ZGUgImF2aXZvZC5oIgo+ICsjaW5j
bHVkZSAicjYwMC5oIgo+ICAjaW5jbHVkZSAicjYwMGQuaCIKPiAgI2luY2x1ZGUgInJ2NzcwLmgi
Cj4gICNpbmNsdWRlICJyYWRlb24uaCIKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yNjAwLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuaAo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAwMC4uMmEzOTE1ZjAwMzllNAo+IC0tLSAvZGV2
L251bGwKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuaAo+IEBAIC0wLDAgKzEs
MzUgQEAKPiArLyogcjYwMC5oIC0tIFByaXZhdGUgaGVhZGVyIGZvciByYWRlb24gZHJpdmVyIC0q
LSBsaW51eC1jIC0qLQo+ICsgKgo+ICsgKiBDb3B5cmlnaHQgMTk5OSBQcmVjaXNpb24gSW5zaWdo
dCwgSW5jLiwgQ2VkYXIgUGFyaywgVGV4YXMuCj4gKyAqIENvcHlyaWdodCAyMDAwIFZBIExpbnV4
IFN5c3RlbXMsIEluYy4sIEZyZW1vbnQsIENhbGlmb3JuaWEuCj4gKyAqIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuCj4gKyAqCj4gKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2Yg
Y2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhCj4gKyAqIGNvcHkgb2YgdGhpcyBzb2Z0
d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiks
Cj4gKyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1
ZGluZyB3aXRob3V0IGxpbWl0YXRpb24KPiArICogdGhlIHJpZ2h0cyB0byB1c2UsIGNvcHksIG1v
ZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsCj4gKyAqIGFuZC9v
ciBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3
aG9tIHRoZQo+ICsgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8g
dGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgo+ICsgKgo+ICsgKiBUaGUgYWJvdmUgY29weXJpZ2h0
IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSAoaW5jbHVkaW5nIHRoZSBuZXh0Cj4g
KyAqIHBhcmFncmFwaCkgc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsIGNvcGllcyBvciBzdWJzdGFu
dGlhbCBwb3J0aW9ucyBvZiB0aGUKPiArICogU29mdHdhcmUuCj4gKyAqCj4gKyAqIFRIRSBTT0ZU
V0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBF
WFBSRVNTIE9SCj4gKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhF
IFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAo+ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKPiAr
ICogUFJFQ0lTSU9OIElOU0lHSFQgQU5EL09SIElUUyBTVVBQTElFUlMgQkUgTElBQkxFIEZPUiBB
TlkgQ0xBSU0sIERBTUFHRVMgT1IKPiArICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFO
IEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsCj4gKyAqIEFSSVNJTkcgRlJP
TSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBP
UiBPVEhFUgo+ICsgKiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCj4gKyAqCj4gKyAqLwo+ICsK
PiArI2lmbmRlZiBfX1I2MDBfSF9fCj4gKyNkZWZpbmUgX19SNjAwX0hfXwo+ICsKPiArc3RydWN0
IHJhZGVvbl9kZXZpY2U7Cj4gKwo+ICt1MzIgcjYwMF9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gKwo+ICsjZW5kaWYgICAgICAgICAgICAgICAgICAg
ICAgICAgLyogX19SNjAwX0hfXyAqLwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3I2MDBfZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfZG1hLmMKPiBpbmRl
eCBhZjZjMGRhNDVmMjhhLi44OWNhMjczOGM1ZDRjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjYwMF9kbWEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYw
MF9kbWEuYwo+IEBAIC0yNCwxMCArMjQsOSBAQAo+Cj4gICNpbmNsdWRlICJyYWRlb24uaCIKPiAg
I2luY2x1ZGUgInJhZGVvbl9hc2ljLmgiCj4gKyNpbmNsdWRlICJyNjAwLmgiCj4gICNpbmNsdWRl
ICJyNjAwZC5oIgo+Cj4gLXUzMiByNjAwX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KTsKPiAtCj4gIC8qCj4gICAqIERNQQo+ICAgKiBTdGFydGluZyB3aXRo
IFI2MDAsIHRoZSBHUFUgaGFzIGFuIGFzeW5jaHJvbm91cwo+IC0tCj4gMi4yNS4xCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
