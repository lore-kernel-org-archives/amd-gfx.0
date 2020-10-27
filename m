Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51812C388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D3221527
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEb5hegL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D3221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3816A6EB8D;
	Tue, 27 Oct 2020 15:19:46 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4DC6EB8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 15:19:44 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id w1so2368385wrm.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FpCB6AcU2j83FBKMMEcbO2XaAM/fKhtac2ptlt54zxA=;
 b=fEb5hegLXcXRPXS9UIWEbsx0uAWMiaQFRNjnvvGC8rbvml1y7FxKr8/s++olg6rDdo
 oxliErD8S28iw3+FRKr3IARtwGqnoHy8ZrMtP2g0WHEJrP/wHmj+fLutn35nQzG8RCmW
 qaNDySM0vJx6tJ9o1twmnP69v00rzrhtVNGHC43ZqFLgjvBnGyrRzbDR4mJxLXOvggtx
 2h9eBxv9ZJNf5yvY2ite4i+7dfJGzOfLjy6ksojzbcUU5dBWXAIXczUrmImRGb8Kk/ZV
 nLHybIJM1BgxFrvIl+cZaivs9Yqxfnf7BmqB3nW4yTl03xYRmdMwnOfjObEl8H9YDrHH
 kdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FpCB6AcU2j83FBKMMEcbO2XaAM/fKhtac2ptlt54zxA=;
 b=CxyOhKqJIn1VroUT5FfQmWdyMdOMhSGYFyXDVnKOwgPRqMmeZqM2xPWBBunjCRsBMk
 kbP4WXrAONpqSVC44/ht5nC1v3Ir/AqyHqcyBAL+dsD7weOy5KEfnxRh+V7miq57Iw7z
 Z0e3RMtB0+jR8nK0o6Q8g10zFx3jRdCwB8jaSinrt2M55g/wynINlGGIGMY9O+b6oWsc
 Jl/zth16O2CcKTCAFbBQvrLuHvb28mRw5dcqjEuqQTTWgXzZK3dwK/vKmMJsioRgdR7w
 /Vryp02nFD49UeE3F4fu9N5g6nYAcFGri5GAkAT3lxKjJ110PPH4/tmdsjbqNQs9c7JJ
 qB6w==
X-Gm-Message-State: AOAM531c4QbmmCVLUUoxoKpevLgs4ZIVUUMR/oTMCC6EmwGaERZKt/VA
 SBLQu1OCEM2Ei0ZBSclzshyg6tKpUxiuFjbGLQS3XKSJ
X-Google-Smtp-Source: ABdhPJzu/ghNwyaYzHY2Uy0YCxIuzX74W9nECxCkLiHiCGx+vLJ1KZ8sNXwi+m5DEi7t1QfgGTltaM9IBdE869blKm8=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr3413010wrn.362.1603811983302; 
 Tue, 27 Oct 2020 08:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175045.1064936-1-alexander.deucher@amd.com>
In-Reply-To: <20201026175045.1064936-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2020 11:19:32 -0400
Message-ID: <CADnq5_Panm5jhT+m5UJUjSC3P_joC6QoJ_K9jN+P6PqDpZKLyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix indentation in
 defer_delay_converter_wa()
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZz8KCk9uIE1vbiwgT2N0IDI2LCAyMDIwIGF0IDE6NTAgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gRml4ZXMgdGhpcyB3YXJuaW5nOgo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jOiBJ
biBmdW5jdGlvbiDigJhkZWZlcl9kZWxheV9jb252ZXJ0ZXJfd2HigJk6Cj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmM6Mjg1OjI6IHdh
cm5pbmc6IHRoaXMg4oCYaWbigJkgY2xhdXNlIGRvZXMgbm90IGd1YXJkLi4uIFstV21pc2xlYWRp
bmctaW5kZW50YXRpb25dCj4gICAyODUgfCAgaWYgKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2
X2lkID09IERQX0JSQU5DSF9ERVZJQ0VfSURfMDA4MEUxICYmCj4gICAgICAgfCAgXn4KPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYzoy
OTE6Mzogbm90ZTogLi4udGhpcyBzdGF0ZW1lbnQsIGJ1dCB0aGUgbGF0dGVyIGlzIG1pc2xlYWRp
bmdseSBpbmRlbnRlZCBhcyBpZiBpdCB3ZXJlIGd1YXJkZWQgYnkgdGhlIOKAmGlm4oCZCj4gICAy
OTEgfCAgIGlmIChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rldl9pZCA9PSBEUF9CUkFOQ0hfREVW
SUNFX0lEXzAwNjAzNyAmJgo+ICAgICAgIHwgICBefgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jIHwgMTQgKysrKysrKy0tLS0tLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2Rk
Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYwo+
IGluZGV4IGVmMGY1MGRiNDkwNy4uNTRiZWRhNGQ0ZTg1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jCj4gQEAgLTI4MywxNSAr
MjgzLDE1IEBAIHN0YXRpYyB1aW50MzJfdCBkZWZlcl9kZWxheV9jb252ZXJ0ZXJfd2EoCj4gICAg
ICAgICBzdHJ1Y3QgZGNfbGluayAqbGluayA9IGRkYy0+bGluazsKPgo+ICAgICAgICAgaWYgKGxp
bmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2X2lkID09IERQX0JSQU5DSF9ERVZJQ0VfSURfMDA4MEUx
ICYmCj4gLSAgICAgICAgICAgICAgICFtZW1jbXAobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZf
bmFtZSwKPiAtICAgICAgICAgICAgICAgICAgICAgICBEUF9EVklfQ09OVkVSVEVSX0lEXzQsCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2
X25hbWUpKSkKPiArICAgICAgICAgICAhbWVtY21wKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2
X25hbWUsCj4gKyAgICAgICAgICAgICAgICAgICBEUF9EVklfQ09OVkVSVEVSX0lEXzQsCj4gKyAg
ICAgICAgICAgICAgICAgICBzaXplb2YobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkp
KQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZGVmZXJfZGVsYXkgPiBJMkNfT1ZFUl9BVVhfREVG
RVJfV0FfREVMQVkgPwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmVyX2RlbGF5IDogSTJD
X09WRVJfQVVYX0RFRkVSX1dBX0RFTEFZOwo+IC0gICAgICAgICAgICAgICBpZiAobGluay0+ZHBj
ZF9jYXBzLmJyYW5jaF9kZXZfaWQgPT0gRFBfQlJBTkNIX0RFVklDRV9JRF8wMDYwMzcgJiYKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAhbWVtY21wKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2
X25hbWUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUF9EVklfQ09OVkVSVEVS
X0lEXzUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YobGluay0+ZHBj
ZF9jYXBzLmJyYW5jaF9kZXZfbmFtZSkpKQo+ICsgICAgICAgaWYgKGxpbmstPmRwY2RfY2Fwcy5i
cmFuY2hfZGV2X2lkID09IERQX0JSQU5DSF9ERVZJQ0VfSURfMDA2MDM3ICYmCj4gKyAgICAgICAg
ICAgIW1lbWNtcChsaW5rLT5kcGNkX2NhcHMuYnJhbmNoX2Rldl9uYW1lLAo+ICsgICAgICAgICAg
ICAgICAgICAgRFBfRFZJX0NPTlZFUlRFUl9JRF81LAo+ICsgICAgICAgICAgICAgICAgICAgc2l6
ZW9mKGxpbmstPmRwY2RfY2Fwcy5icmFuY2hfZGV2X25hbWUpKSkKPiAgICAgICAgICAgICAgICAg
cmV0dXJuIGRlZmVyX2RlbGF5ID4gSTJDX09WRVJfQVVYX0RFRkVSX1dBX0RFTEFZXzFNUyA/Cj4g
ICAgICAgICAgICAgICAgICAgICAgICAgSTJDX09WRVJfQVVYX0RFRkVSX1dBX0RFTEFZXzFNUyA6
IGRlZmVyX2RlbGF5Owo+Cj4gLS0KPiAyLjI1LjQKPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
