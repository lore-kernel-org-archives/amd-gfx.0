Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCCC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839FE206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE1NeymR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839FE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8B489D2E;
	Tue, 10 Nov 2020 23:36:37 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0545589CE3;
 Tue, 10 Nov 2020 23:36:37 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so128939wme.1;
 Tue, 10 Nov 2020 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1vhq0fZC4oEpfVvFOkQj37w7y2qw+vzKtXNkn44TpOc=;
 b=dE1NeymRsVp6PprpoWlKUxsLKgt9KHMj3DSrY7/9mxq/9tBx/o6SchkxmgNNX3FjP3
 WAMd5d5WTS4ydXIZU/8bA5RrqfD5geVHcPH9QjnfIv066iZDAIMu4hSKmkTNRCMDvG6Z
 S2wQt2cEfWNHbgfuIEQd3aZeErRaGW+MIbc43/OCb1OE3jgx1Le1RU9nnU0KjFS+Laxd
 j8q+nVFJ/muYQ1BNoGfx135NcsTdca+I7X64HqpXD690lM32eyJ5qfSALQKLv7ZJHQqw
 NVR52iiEXXTaD0bWXHpmBOACc9X3DJAElzKOicyuw3F0wACK5Z95Ix6sv5crAM58alrE
 Ir0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1vhq0fZC4oEpfVvFOkQj37w7y2qw+vzKtXNkn44TpOc=;
 b=PNAOIOHy49i8FQwsL0GmTh6+X1M+XLegsCi+SOMb0mGEllyxe7Fd/K9LZGqDJs0dCB
 FHY1EoYm1YbhZphfJSNfmkFZH58Pyr6MrWcdozldlb7g82+9xj4qKNwuurwFSO1VgGWp
 5HbrnnOjJPXbnr2CgS0vYar0CvhPyn9/qqdfUEvkNfznh1ZCaODC5pcZX4EzDxLaLOdE
 2g8Fr0Iz2Qn7K/aruLRGKeXwrGrFs0VOaeCxUcx0ca7Iul9OgG0xcs2J7GHg/njHXbVC
 JjjrbWQeajqmqjkQOnphlsj5lO/uASqVCTE+oi/AgiU1vJ24P+VNaSRa319Ox/WxeDig
 EHIg==
X-Gm-Message-State: AOAM532YycKtEXFikdcXHOR4Wak6V3IgKP6A3Rgll8nzaLcHScKxrAg1
 n4BvQPQjSIapClcXhscsqETbJ5g4YLqeZgcpgr0=
X-Google-Smtp-Source: ABdhPJylcwzZPYC4LfKGtFEWuOFSx7dJ0oAZ1VColKd/icnq0WCIEhmrYrBYFhb/k7UalrAXcnog0wJMOKpqljLhKFc=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr532569wmb.39.1605051395550;
 Tue, 10 Nov 2020 15:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-10-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-10-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 18:36:24 -0500
Message-ID: <CADnq5_N2tjAn458re5Cj+ZY8p3NoXZH9HM=_4k+v_SaVgxo-Eg@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/radeon/radeon_vm: Fix some function parameter
 documentation
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

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmM6MTMxOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdyZGV2JyBub3QgZGVzY3JpYmVk
IGluICdyYWRlb25fdm1fZ2V0X2JvcycKPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
dm0uYzo2NDM6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3N0YXJ0JyBkZXNj
cmlwdGlvbiBpbiAncmFkZW9uX3ZtX3VwZGF0ZV9wYWdlX2RpcmVjdG9yeScKPiAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYzo2NDM6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBw
YXJhbWV0ZXIgJ2VuZCcgZGVzY3JpcHRpb24gaW4gJ3JhZGVvbl92bV91cGRhdGVfcGFnZV9kaXJl
Y3RvcnknCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmM6ODE5OiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpYicgbm90IGRlc2NyaWJlZCBpbiAncmFk
ZW9uX3ZtX3VwZGF0ZV9wdGVzJwo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5j
OjkxNTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYm9fdmEnIG5vdCBk
ZXNjcmliZWQgaW4gJ3JhZGVvbl92bV9ib191cGRhdGUnCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX3ZtLmM6OTE1OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICd2
bScgZGVzY3JpcHRpb24gaW4gJ3JhZGVvbl92bV9ib191cGRhdGUnCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3ZtLmM6OTE1OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1l
dGVyICdibycgZGVzY3JpcHRpb24gaW4gJ3JhZGVvbl92bV9ib191cGRhdGUnCj4gIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmM6MTE1NTogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9u
IHBhcmFtZXRlciAndm0nIGRlc2NyaXB0aW9uIGluICdyYWRlb25fdm1fYm9faW52YWxpZGF0ZScK
Pgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkIHdpdGggYSBzbWFsbCBmaXh1cC4gIFRoYW5rcyEKCkFs
ZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMgfCA4ICsrKy0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMKPiBpbmRleCAyN2IxNGVmZjUzMmNiLi43MWYy
ZWRjYWM2ZWEwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3Zt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jCj4gQEAgLTExOSw2
ICsxMTksNyBAQCB2b2lkIHJhZGVvbl92bV9tYW5hZ2VyX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpCj4gIC8qKgo+ICAgKiByYWRlb25fdm1fZ2V0X2JvcyAtIGFkZCB0aGUgdm0gQk9z
IHRvIGEgdmFsaWRhdGlvbiBsaXN0Cj4gICAqCj4gKyAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBv
aW50ZXIKPiAgICogQHZtOiB2bSBwcm92aWRpbmcgdGhlIEJPcwo+ICAgKiBAaGVhZDogaGVhZCBv
ZiB2YWxpZGF0aW9uIGxpc3QKPiAgICoKPiBAQCAtNjI5LDggKzYzMCw2IEBAIHN0YXRpYyB1aW50
MzJfdCByYWRlb25fdm1fcGFnZV9mbGFncyh1aW50MzJfdCBmbGFncykKPiAgICoKPiAgICogQHJk
ZXY6IHJhZGVvbl9kZXZpY2UgcG9pbnRlcgo+ICAgKiBAdm06IHJlcXVlc3RlZCB2bQo+IC0gKiBA
c3RhcnQ6IHN0YXJ0IG9mIEdQVSBhZGRyZXNzIHJhbmdlCj4gLSAqIEBlbmQ6IGVuZCBvZiBHUFUg
YWRkcmVzcyByYW5nZQo+ICAgKgo+ICAgKiBBbGxvY2F0ZXMgbmV3IHBhZ2UgdGFibGVzIGlmIG5l
Y2Vzc2FyeQo+ICAgKiBhbmQgdXBkYXRlcyB0aGUgcGFnZSBkaXJlY3RvcnkgKGNheW1hbispLgo+
IEBAIC04MDIsNiArODAxLDcgQEAgc3RhdGljIHZvaWQgcmFkZW9uX3ZtX2ZyYWdfcHRlcyhzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKPiAgICoKPiAgICogQHJkZXY6IHJhZGVvbl9kZXZpY2Ug
cG9pbnRlcgo+ICAgKiBAdm06IHJlcXVlc3RlZCB2bQo+ICsgKiBAaWI6IGluZGlyZWN0IGJ1ZmZl
ciB0byB1c2UgZm9yIHRoZSB1cGRhdGUKPiAgICogQHN0YXJ0OiBzdGFydCBvZiBHUFUgYWRkcmVz
cyByYW5nZQo+ICAgKiBAZW5kOiBlbmQgb2YgR1BVIGFkZHJlc3MgcmFuZ2UKPiAgICogQGRzdDog
ZGVzdGluYXRpb24gYWRkcmVzcyB0byBtYXAgdG8KPiBAQCAtOTAwLDggKzkwMCw3IEBAIHN0YXRp
YyB2b2lkIHJhZGVvbl92bV9mZW5jZV9wdHMoc3RydWN0IHJhZGVvbl92bSAqdm0sCj4gICAqIHJh
ZGVvbl92bV9ib191cGRhdGUgLSBtYXAgYSBibyBpbnRvIHRoZSB2bSBwYWdlIHRhYmxlCj4gICAq
Cj4gICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKPiAtICogQHZtOiByZXF1ZXN0ZWQg
dm0KPiAtICogQGJvOiByYWRlb24gYnVmZmVyIG9iamVjdAo+ICsgKiBAYm9fdmE6IHJhZGVvbiBi
dWZmZXIgb2JqZWN0Cj4gICAqIEBtZW06IHR0bSBtZW0KPiAgICoKPiAgICogRmlsbCBpbiB0aGUg
cGFnZSB0YWJsZSBlbnRyaWVzIGZvciBAYm8gKGNheW1hbispLgo+IEBAIC0xMTQ1LDcgKzExNDQs
NiBAQCB2b2lkIHJhZGVvbl92bV9ib19ybXYoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCj4g
ICAqIHJhZGVvbl92bV9ib19pbnZhbGlkYXRlIC0gbWFyayB0aGUgYm8gYXMgaW52YWxpZAo+ICAg
Kgo+ICAgKiBAcmRldjogcmFkZW9uX2RldmljZSBwb2ludGVyCj4gLSAqIEB2bTogcmVxdWVzdGVk
IHZtCj4gICAqIEBibzogcmFkZW9uIGJ1ZmZlciBvYmplY3QKPiAgICoKPiAgICogTWFyayBAYm8g
YXMgaW52YWxpZCAoY2F5bWFuKykuCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
