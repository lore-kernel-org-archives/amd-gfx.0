Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C479C64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D97206F9
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCAWe+v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D97206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C34B89F2D;
	Tue,  1 Dec 2020 19:41:27 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175F289F2D;
 Tue,  1 Dec 2020 19:41:26 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id p126so3055622oif.7;
 Tue, 01 Dec 2020 11:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ceg6uRVcVSL9wT3YtP/QD1TGNQLWKegOeS5Bb86s4gI=;
 b=pCAWe+v9IIUAG+DZMgT2pr5/+Ty924IWTrpYsnjDlfg9BTcGw7wzxEcvziDSIa3qJx
 IpEs2d5GYDTYCzmXVsJKPlMIayD08Nqv0faiea3YOy6Syd3RmYHr6z3i+mkTW2TdhVj9
 yzJgr/XSCd20IAaS/KD8f3kTzI4KDlxDpl3w8L8TIdGX9nPDPE9hWt7R79hx/7uMib+6
 hK9oXprGTJ6gmpYo8PGwSSukW+oSr2VUSQRFxJG7S2J8rLt3JpD34yQRrGsSo+l4pM19
 FjmYxQfBJ1kMFRIYnaKkJPSnsfUz+r33fmJwhTd/RP2/dC0V5Hirlh0rxTeYpUSeS68X
 0IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ceg6uRVcVSL9wT3YtP/QD1TGNQLWKegOeS5Bb86s4gI=;
 b=rUKP496Rz5O+nP49lCNSSmo1JZZY7z4Rxop/v+vx+t8ghSAobt0sQ1ZVXlAyHOkTse
 B5XY25mPgh5/yOuuoK6QZpZImRpuh049aOQAgcOgoo0glm1VTzW+hRe5OdCaZFVprIvV
 9N+0cn4vVG6RhPoM97gqjHynnoalULymwwIgRuPQ3Oiy98Cc5AuAEm9md64aY0/Yrig+
 uove0m9vNeSQzUUVCwvr4iLvpSKbZAsKSi0ZpVv0UXdaBlLZ7YRO3i3/mETy1HEbQ27Z
 Z6go56E6nEyp/cV2kuNJR9JU/cZKQE/Y8hOG9G5E2MW5hiAnUZXXmtITojOqcD1To/6a
 IEiw==
X-Gm-Message-State: AOAM532RSC5/ttpnGizVa7ffj1AjxCRRCaexNy8mo1iJa0M6E1EyiXmR
 tl/P1d0ZzxEzjN3VTTn7fONx7UVW683uYpL0Yiw=
X-Google-Smtp-Source: ABdhPJzaUYRENbRF5AjUOGhsw16kD7TwgpunPbwNMQzGnEtx23qMxG6NhsbK1kDo1mmu5rtvUqg3kfZ9FtIzfxH9q7I=
X-Received: by 2002:a54:4608:: with SMTP id p8mr2790019oip.5.1606851685414;
 Tue, 01 Dec 2020 11:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-35-lee.jones@linaro.org>
 <CADnq5_On90z1w=_usmjA7kHFVig3uHg4VJRecDraYZv8cmRAUQ@mail.gmail.com>
 <b5050f44-9542-2ae3-c019-c9821f978cc8@amd.com>
In-Reply-To: <b5050f44-9542-2ae3-c019-c9821f978cc8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Dec 2020 14:41:14 -0500
Message-ID: <CADnq5_PtbAeAxsxHB4=gYf2=Gqc=vQTz5oRpTiwzaAFkpuC5AQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use
 'gnu_printf' format notation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBEZWMgMSwgMjAyMCBhdCAxOjU5IFBNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwMS4xMi4yMCB1bSAxOTo0MiBzY2hyaWVi
IEFsZXggRGV1Y2hlcjoKPiA+IE9uIFRodSwgTm92IDI2LCAyMDIwIGF0IDg6NDQgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4gPj4gRml4ZXMgdGhlIGZvbGxvd2lu
ZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4gPj4KPiA+PiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmM6IElu
IGZ1bmN0aW9uIOKAmGRtX2R0bl9sb2dfYXBwZW5kX3bigJk6Cj4gPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jOjM0
NToyOiB3YXJuaW5nOiBmdW5jdGlvbiDigJhkbV9kdG5fbG9nX2FwcGVuZF924oCZIG1pZ2h0IGJl
IGEgY2FuZGlkYXRlIGZvciDigJhnbnVfcHJpbnRm4oCZIGZvcm1hdCBhdHRyaWJ1dGUgWy1Xc3Vn
Z2VzdC1hdHRyaWJ1dGU9Zm9ybWF0XQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYzozNzU6Mzogd2FybmluZzog
ZnVuY3Rpb24g4oCYZG1fZHRuX2xvZ19hcHBlbmRfduKAmSBtaWdodCBiZSBhIGNhbmRpZGF0ZSBm
b3Ig4oCYZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRlIFstV3N1Z2dlc3QtYXR0cmlidXRl
PWZvcm1hdF0KPiA+Pgo+ID4+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4KPiA+PiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gPj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+PiBDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPj4gQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KPiA+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+ID4+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+IENjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyB8IDEgKwo+ID4+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCj4gPj4g
aW5kZXggYjdkN2VjM2JhMDBkNy4uMjRhODE2NDJiYWEyNiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPiA+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9o
ZWxwZXJzLmMKPiA+PiBAQCAtMzE4LDYgKzMxOCw3IEBAIHZvaWQgZG1fZHRuX2xvZ19iZWdpbihz
dHJ1Y3QgZGNfY29udGV4dCAqY3R4LAo+ID4+ICAgICAgICAgIGRtX2R0bl9sb2dfYXBwZW5kX3Yo
Y3R4LCBsb2dfY3R4LCAiJXMiLCBtc2cpOwo+ID4+ICAgfQo+ID4+Cj4gPj4gK19fcHJpbnRmKDMs
IDQpCj4gPiBDYW4geW91IGV4cGFuZCBhIGJpdCBvbiB3aGF0IHRoaXMgZG9lcz8KPgo+IEJlZW4g
YSB3aGlsZSBzaW5jZSBJIGxvb2tlZCBpbnRvIHNvbWV0aGluZyBsaWtlIHRoaXMsIGJ1dCBJSVJD
IHRoaXMKPiBtZWFucyB0aGF0IHBhcmFtZXRlciAzIChtc2cpIGlzIGNvbnNpZGVyZWQgYSBwcmlu
dGYgZm9ybWF0IHN0cmluZyBhbmQKPiB0aGUgdHlwZXMgb2YgcGFyYW1ldGVyIDQgYW5kIGZvbGxv
d2luZyBjaGVja2VkIGFnYWluc3QgdGhhdC4KPgo+IExvb2tzIGNvcnJlY3QgdG8gbWUuCgpUaGFu
a3MuICBBcHBsaWVkLgoKQWxleAoKCj4KPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBBbGV4Cj4gPgo+
ID4+ICAgdm9pZCBkbV9kdG5fbG9nX2FwcGVuZF92KHN0cnVjdCBkY19jb250ZXh0ICpjdHgsCj4g
Pj4gICAgICAgICAgc3RydWN0IGRjX2xvZ19idWZmZXJfY3R4ICpsb2dfY3R4LAo+ID4+ICAgICAg
ICAgIGNvbnN0IGNoYXIgKm1zZywgLi4uKQo+ID4+IC0tCj4gPj4gMi4yNS4xCj4gPj4KPiA+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+IGRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKPiA+PiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
ZHJpLWRldmVsJmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3
QzUwYmRiZDJmYjdhNTQwMGU5MWMwMDhkODk2MjhkMTFjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMSU3QzYzNzQyNDQ1MDA1MzE4MTc4MyU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1hZnpTU3UlMkZiYTAlMkZRaXdPYW1l
SlJPNVNnczVqb1JQb25kV1F4JTJCeVFaWmxVJTNEJmFtcDtyZXNlcnZlZD0wCj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
