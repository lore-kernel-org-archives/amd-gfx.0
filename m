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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AABC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B7220782
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCpQc4ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B7220782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EDB6EA70;
	Mon, 16 Nov 2020 20:24:22 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE74A6EA70;
 Mon, 16 Nov 2020 20:24:21 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id s13so533323wmh.4;
 Mon, 16 Nov 2020 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o3Z+43KIEICEWS2L8j2bmVE/5+HRWrEhS/yLpOikoIM=;
 b=sCpQc4ahqDRT3np/JQ6Beh9fP6YZ8V6G7+ssWGWNP74sNXIQeCaz5kkqFQcEYLDm6Z
 3EaTDKBUTYFfZnejsb2BIzRIAomsmTb6Afsy/jR48vwVjGDRDfKETnSTLAlNoN0inPXO
 8qiPc1GYSVHMys19d8ZlosMijFAycvlMQTsP36T1Bh4kSriMOfD4FvhiWXev6yigqJfk
 HgqIRJLd6LV0yGgdVhYhFcfGF9UbPhvkCody+Ac7jJouRtIWjODnOuCG6qmt4Gd0/pyw
 +NkJ1FSh/N2yRQt0dLaz8p745VeneXuahBE7wej7AKE63K7gP14buRsj09PSnAPhWyVO
 iS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o3Z+43KIEICEWS2L8j2bmVE/5+HRWrEhS/yLpOikoIM=;
 b=Vr2InebhV33vS8fdQZWVpki+LC7mmnmkj7owJ6ooxYAP4Rw1hsykqbLtWw97yP07rb
 aSkepziLGZcpZ+vBp5vwUmqR4XryAuc3DjM4a+3zRkdY0eR+eLMHcY+Ch798PLNiGS6/
 paJUkqiODYrdFZIAmTx2RBNaEc5W6xr/Z6InkcgLa0UYfOcLqDaN4PO4LasklLF/af4b
 YrAayRl0Pn/JvW2CCzpFs2RrcsALPUd1PUrZ5H8Les6DaHpEscJFAom3LjjXSlH5SuAn
 0tCz8ngCA0sXWKIE/GrexkuF6t2vCkGWyONfuoEhpGccI3wm/mN63GdLoEM1CN0vSHf8
 /Gyg==
X-Gm-Message-State: AOAM533H4bpV5p44fAzw4g0htFdWWy5xPfAtu8yYl7UHM/1gH+WHTtKb
 91O07pTGG84bDWAHer8FwuC3XyFtGCpN14AV78U=
X-Google-Smtp-Source: ABdhPJyu4W8gYrZdZFx4N8IBWXzzjYuaxtGP9pzEfpctgiXMe5i6OvPoeHbrqrhbVmQr8zkJzkeIVC6ykK96E1qmIj8=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr635655wmb.39.1605558260600;
 Mon, 16 Nov 2020 12:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-30-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-30-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:24:09 -0500
Message-ID: <CADnq5_OCfgqoa6oGwM+YnO6T7WVVMSu3xRi4R7tYczfBAB1LLQ@mail.gmail.com>
Subject: Re: [PATCH 29/43] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s
 prototype to shared header
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
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmM6MTU3MDo1OiB3YXJu
aW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHNpX21jX2xvYWRfbWljcm9jb2Rl4oCZ
IFstV21pc3NpbmctcHJvdG90eXBlc10KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtz
IQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jICAgICB8ICAxICsK
PiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oICAgICB8IDMxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyB8ICAyICst
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9zaS5jCj4gaW5kZXggZDA0MDcxNDVjMDdiNS4uODg3MzFiNzljOGY1NyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpLmMKPiBAQCAtMzksNiArMzksNyBAQAo+ICAjaW5jbHVkZSAicmFkZW9uX2F1ZGlvLmgi
Cj4gICNpbmNsdWRlICJyYWRlb25fdWNvZGUuaCIKPiAgI2luY2x1ZGUgInNpX2JsaXRfc2hhZGVy
cy5oIgo+ICsjaW5jbHVkZSAic2kuaCIKPiAgI2luY2x1ZGUgInNpZC5oIgo+Cj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9zaS5oCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAwLi4wYTUw
MThlZjE2NmUyCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
c2kuaAo+IEBAIC0wLDAgKzEsMzEgQEAKPiArLyogc2kuaCAtLSBQcml2YXRlIGhlYWRlciBmb3Ig
cmFkZW9uIGRyaXZlciAtKi0gbGludXgtYyAtKi0KPiArICoKPiArICogQ29weXJpZ2h0IDIwMTEg
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgo+ICsgKgo+ICsgKiBQZXJtaXNzaW9uIGlzIGhl
cmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYQo+
ICsgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBm
aWxlcyAodGhlICJTb2Z0d2FyZSIpLAo+ICsgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRo
b3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uCj4gKyAqIHRoZSBy
aWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBz
dWJsaWNlbnNlLAo+ICsgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQg
dG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKPiArICogU29mdHdhcmUgaXMgZnVybmlzaGVk
IHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKPiArICoKPiAr
ICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ug
c2hhbGwgYmUgaW5jbHVkZWQgaW4KPiArICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0
aW9ucyBvZiB0aGUgU29mdHdhcmUuCj4gKyAqCj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURF
RCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCj4gKyAq
IElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0Yg
TUVSQ0hBTlRBQklMSVRZLAo+ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBB
TkQgTk9OSU5GUklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKPiArICogVEhFIENPUFlSSUdI
VCBIT0xERVIoUykgT1IgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VT
IE9SCj4gKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJB
Q1QsIFRPUlQgT1IgT1RIRVJXSVNFLAo+ICsgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBD
T05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IKPiArICogT1RIRVIgREVB
TElOR1MgSU4gVEhFIFNPRlRXQVJFLgo+ICsgKi8KPiArCj4gKyNpZm5kZWYgX19TSV9IX18KPiAr
I2RlZmluZSBfX1NJX0hfXwo+ICsKPiArc3RydWN0IHJhZGVvbl9kZXZpY2U7Cj4gKwo+ICtpbnQg
c2lfbWNfbG9hZF9taWNyb2NvZGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICsKPiAr
I2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fU0lfSF9fICovCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpX2RwbS5jCj4gaW5kZXggYzY4YWIyZmIxYWMyMy4uMzJiNjk3OTY1YzA2NCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+IEBAIC0zMiw2ICszMiw3IEBACj4gICNpbmNsdWRlICJy
YWRlb25fYXNpYy5oIgo+ICAjaW5jbHVkZSAibmlfZHBtLmgiCj4gICNpbmNsdWRlICJzaV9kcG0u
aCIKPiArI2luY2x1ZGUgInNpLmgiCj4gICNpbmNsdWRlICJzaWQuaCIKPgo+ICAjZGVmaW5lIE1D
X0NHX0FSQl9GUkVRX0YwICAgICAgICAgICAweDBhCj4gQEAgLTE3MjEsNyArMTcyMiw2IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc2lfcG93ZXJ0dW5lX2RhdGEgcG93ZXJ0dW5lX2RhdGFfaGFpbmFu
ID0KPgo+ICBzdHJ1Y3QgZXZlcmdyZWVuX3Bvd2VyX2luZm8gKmV2ZXJncmVlbl9nZXRfcGkoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+Cj4gLWV4dGVybiBpbnQgc2lfbWNfbG9hZF9taWNy
b2NvZGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICBleHRlcm4gdm9pZCB2Y2VfdjFf
MF9lbmFibGVfbWdjZyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgYm9vbCBlbmFibGUpOwo+
Cj4gIHN0YXRpYyBpbnQgc2lfcG9wdWxhdGVfdm9sdGFnZV92YWx1ZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
