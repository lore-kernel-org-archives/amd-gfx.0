Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78614C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D47221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMR+27u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D47221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D9E6E57A;
	Fri, 13 Nov 2020 17:34:42 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252026E57A;
 Fri, 13 Nov 2020 17:34:42 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so9336450wme.1;
 Fri, 13 Nov 2020 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VAyRswQxOnE6Ap+njfI0flgqY+hikjcd7/92aKeFkMM=;
 b=HMR+27u7jJk5vhJ569WZ7eXznF+zmqX6C4McpG7f9LD7IlIFIqEwlBmnaep+Fihfew
 dTgAP2gtCdi3y1dsiowwSsbWfE1AVyQvA+9uoFSv5qfzXt7xzvMOd4wNMVJQZahzBGdG
 msy7+qg/YCdHrefph+iKduSkyVhYSog4ejmUj5I47Ln3r/eTtag3+vkqq3RjKGQXaLdh
 T/bkq1TxX3CZMFTHMD6Pei63UPmFcy8kBCvF3HPC/cIOuDck1UuMB7iUdBOHdO1mtg8S
 4rmcV0lQZvMn3bpo95XEBjWMO1yyz31E1IXmZj5FdOmxUuyJsskugHd4xEbJzBf/4OhR
 ByrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VAyRswQxOnE6Ap+njfI0flgqY+hikjcd7/92aKeFkMM=;
 b=E6ZtAoCzz6KF2emeBq+cRECYeopAOuZx5SgSqCjmJcPHjXituI8E3d9qQze04h5/g2
 j0tUCP/5TioVe48J0v3+T9zuJ12JRvXUuxXzisTH7ivg4ge3Ke969dZaMzcFn9cXS78s
 2nce5bL4RhDtG37q3+5/lAx2NcIi+c3lymbcnUSvR8V5EGdJmlmKLHW7aXqbaan897vF
 A1ceHLMLctgl9HESEOKRjkXEHzpWchFaMe2G32N04VxRzfnnpB48fT9J7BekmOD3rcm6
 CFuS1YC0t2OAjucfMWOAtrcrSX6Dbxlh/HjpqBv85W3OYgrC6LBoKZFKMYGTjDLlhP46
 Apqg==
X-Gm-Message-State: AOAM532U16D1MNPWMuxXZRFn5QTlHrzOmD55KNjOpuIXedGAVwQRLxpu
 BDldSfEAZ9ilnrXGCSKA/GNWmz8L2mlOlHjSpNc=
X-Google-Smtp-Source: ABdhPJy4iOo+ylGkeKNUPzwbvjwMLxPrnmH/CR+FHDNMKer1Mk+qrvdkkKTV72Mkm/NtsbEFHTufjI2HFoejyctSz+g=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr3554153wmb.39.1605288878659;
 Fri, 13 Nov 2020 09:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-38-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-38-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:34:27 -0500
Message-ID: <CADnq5_MxBB7Zqa-L=PVXuWzhGAQOtMttn8juh8hVrO7zLfnzJA@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/amdgpu/smu_v11_0_i2c: Provide descriptions
 for 'control' and 'data' params
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

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMu
YzoyMjU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2NvbnRyb2wnIG5v
dCBkZXNjcmliZWQgaW4gJ3NtdV92MTFfMF9pMmNfdHJhbnNtaXQnCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYzozMjU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ2NvbnRyb2wnIG5vdCBkZXNjcmliZWQgaW4gJ3NtdV92MTFfMF9pMmNf
cmVjZWl2ZScKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2kyYy5jOjMy
NTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZGF0YScgbm90IGRlc2Ny
aWJlZCBpbiAnc211X3YxMV8wX2kyY19yZWNlaXZlJwo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4K
PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVf
djExXzBfaTJjLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2kyYy5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2kyYy5jCj4gaW5kZXggN2Zi
MjQwYzQ5OTBjYS4uNWM3ZDc2OWFlZTNmYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zbXVfdjExXzBfaTJjLmMKPiBAQCAtMjEyLDYgKzIxMiw3IEBAIHN0YXRpYyB1aW50MzJf
dCBzbXVfdjExXzBfaTJjX3BvbGxfcnhfc3RhdHVzKHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJv
bCkKPiAgLyoqCj4gICAqIHNtdV92MTFfMF9pMmNfdHJhbnNtaXQgLSBTZW5kIGEgYmxvY2sgb2Yg
ZGF0YSBvdmVyIHRoZSBJMkMgYnVzIHRvIGEgc2xhdmUgZGV2aWNlLgo+ICAgKgo+ICsgKiBAY29u
dHJvbDogSTJDIGFkYXB0ZXIgcmVmZXJlbmNlCj4gICAqIEBhZGRyZXNzOiBUaGUgSTJDIGFkZHJl
c3Mgb2YgdGhlIHNsYXZlIGRldmljZS4KPiAgICogQGRhdGE6IFRoZSBkYXRhIHRvIHRyYW5zbWl0
IG92ZXIgdGhlIGJ1cy4KPiAgICogQG51bWJ5dGVzOiBUaGUgYW1vdW50IG9mIGRhdGEgdG8gdHJh
bnNtaXQuCj4gQEAgLTMxMyw3ICszMTQsOSBAQCBzdGF0aWMgdWludDMyX3Qgc211X3YxMV8wX2ky
Y190cmFuc21pdChzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wsCj4gIC8qKgo+ICAgKiBzbXVf
djExXzBfaTJjX3JlY2VpdmUgLSBSZWNlaXZlIGEgYmxvY2sgb2YgZGF0YSBvdmVyIHRoZSBJMkMg
YnVzIGZyb20gYSBzbGF2ZSBkZXZpY2UuCj4gICAqCj4gKyAqIEBjb250cm9sOiBJMkMgYWRhcHRl
ciByZWZlcmVuY2UKPiAgICogQGFkZHJlc3M6IFRoZSBJMkMgYWRkcmVzcyBvZiB0aGUgc2xhdmUg
ZGV2aWNlLgo+ICsgKiBAZGF0YTogUGxhY2Vob2xkZXIgdG8gc3RvcmUgcmVjZWl2ZWQgZGF0YS4K
PiAgICogQG51bWJ5dGVzOiBUaGUgYW1vdW50IG9mIGRhdGEgdG8gdHJhbnNtaXQuCj4gICAqIEBp
MmNfZmxhZzogRmxhZ3MgZm9yIHRyYW5zbWlzc2lvbgo+ICAgKgo+IC0tCj4gMi4yNS4xCj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
