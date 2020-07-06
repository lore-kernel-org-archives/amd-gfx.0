Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F39D20708
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHLmccG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F39D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBCA89F69;
	Mon,  6 Jul 2020 16:16:53 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F9989F69
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 16:16:53 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f7so38705475wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yz2Lu0SuQBxmA1yiSx4cV9N5MOcxP7/bmwy4RMynB00=;
 b=cHLmccG1IfLXxZSXQzHgTrTcO67QvQhmhBayONvjj4l+ywHXzr+gYA06IbHXd2Jn4l
 d58q7JP6OJm93GpaKt7iNjP4/x13IO0ZewWvO3fJW7GCRXgddSWPx7fzz8Vq7cdc2eIK
 23IBTE26v8UK5739T3ZvZ/41HZGoBkQNpIg/D1KHJzxc1S2K6lAbdvbpm2rh7LHNHKkW
 LYwkUZpZtI9Fcqjb2RYhPjUQMUzcIVzHSuokIsqTiJ4lju81JmyYkt4yDK3AqVDLl3fe
 LetIUbf59tTRpIrJV4XWWk7tvRs9Sa49ieF1EdP5KSnCSGrR07AJVBAuQjbFjDn5N4Bn
 dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yz2Lu0SuQBxmA1yiSx4cV9N5MOcxP7/bmwy4RMynB00=;
 b=GRTcpVI0ZljcpdrdXr6Nhs053wrpFbYBcTplP2QWvgeFtksx2XfX7uZbABTzidEZB4
 uuae5HIiUba8JYw0MtMcuj06LHtwgP37ae1dCMdwldxO1pEgOuGO7ZpI5P5FMk+GqQP9
 12g8Zq7RZf4zMxsCtMUJWX0zkkamr2WqgunZJYzKBtF3TBmbZqVN8wcCo1wvlY/XwrYV
 ToquOJa6CL0RnR54V1QqvlxELVYuPs0FF+7Y4momKMm70EDPqoB3z3dkoCh5whs2mguK
 ROfJ/WgtPzasNKiuB9I1BOw77Qgp6AW6cLmM8bwY6ctmXo+gGLMpbRD6g/QMLnwr8CtQ
 O/og==
X-Gm-Message-State: AOAM533X3pu+EevT9C9kToENJBAJs23LkWw3bf/VjO3b1893qywUn8fi
 8fLSfTpkmlRDP+sd72gEyoduh9mWFmhWkmRWb0E=
X-Google-Smtp-Source: ABdhPJw/bbS5gsiasYmCtDJFirI5m3ZZ0tso1ApMUlc26NziFaaNZPdAf8DpkF1PoYjkwEOMZwcJa5SHaGk27O+6aXU=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr51382760wrw.374.1594052211679; 
 Mon, 06 Jul 2020 09:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
 <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
 <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com>
 <897b806e-dba8-710f-6b62-2493e3033417@loongson.cn>
In-Reply-To: <897b806e-dba8-710f-6b62-2493e3033417@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2020 12:16:40 -0400
Message-ID: <CADnq5_M4Dk=+MDc7VdeQ1SN6QpPhkRMX9z84Qo4Q_DMw3xS7+A@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To: Tiezhu Yang <yangtiezhu@loongson.cn>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgSnVsIDIsIDIwMjAgYXQgMTE6NTQgQU0g
VGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdzb24uY24+IHdyb3RlOgo+Cj4gT24gMDcvMDIv
MjAyMCAwNDozOSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+IEFtIDAyLjA3LjIwIHVt
IDEwOjM1IHNjaHJpZWIgVGllemh1IFlhbmc6Cj4gPj4gT24gMDcvMDIvMjAyMCAwNDoyNyBQTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+Pj4gQW0gMDIuMDcuMjAgdW0gMDQ6Mjcgc2Nocmll
YiBUaWV6aHUgWWFuZzoKPiA+Pj4+IFdoZW4gSSB1cGRhdGUgdGhlIGxhdGVzdCBrZXJuZWwsIEkg
c2VlIHRoZSBmb2xsb3dpbmcKPiA+Pj4+ICJfX19fcHRydmFsX19fXyIgYm9vdAo+ID4+Pj4gbWVz
c2FnZXMuCj4gPj4+Pgo+ID4+Pj4gWyAgICAxLjg3MjYwMF0gcmFkZW9uIDAwMDA6MDE6MDUuMDog
ZmVuY2UgZHJpdmVyIG9uIHJpbmcgMCB1c2UgZ3B1Cj4gPj4+PiBhZGRyIDB4MDAwMDAwMDA0ODAw
MGMwMCBhbmQgY3B1IGFkZHIgMHgoX19fX3B0cnZhbF9fX18pCj4gPj4+PiBbICAgIDEuODc5MDk1
XSByYWRlb24gMDAwMDowMTowNS4wOiBmZW5jZSBkcml2ZXIgb24gcmluZyA1IHVzZSBncHUKPiA+
Pj4+IGFkZHIgMHgwMDAwMDAwMDQwMDU2MDM4IGFuZCBjcHUgYWRkciAweChfX19fcHRydmFsX19f
XykKPiA+Pj4+Cj4gPj4+PiBCb3RoIHJhZGVvbl9mZW5jZV9kcml2ZXJfc3RhcnRfcmluZygpIGFu
ZAo+ID4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkKPiA+Pj4+IGhhdmUgdGhl
IHNpbWlsYXIgaXNzdWUsIHRoZXJlIGV4aXN0cyB0aGUgZm9sbG93aW5nIHR3byBtZXRob2RzIHRv
Cj4gPj4+PiBzb2x2ZSBpdDoKPiA+Pj4+ICgxKSBVc2UgIiVwSyIgaW5zdGVhZCBvZiAiJXAiIHNv
IHRoYXQgdGhlIENQVSBhZGRyZXNzIGNhbiBiZQo+ID4+Pj4gcHJpbnRlZCB3aGVuCj4gPj4+PiB0
aGUga3B0cl9yZXN0cmljdCBzeXNjdGwgaXMgc2V0IHRvIDEuCj4gPj4+PiAoMikgSnVzdCBjb21w
bGV0ZWx5IGRyb3AgdGhlIENQVSBhZGRyZXNzIHN1Z2dlc3RlZCBieSBDaHJpc3RpYW4sCj4gPj4+
PiBiZWNhdXNlCj4gPj4+PiB0aGUgQ1BVIGFkZHJlc3Mgd2FzIHVzZWZ1bCBpbiB0aGUgcGFzdCwg
YnV0IGlzbid0IGFueSBtb3JlLiBXZSBub3cKPiA+Pj4+IGhhdmUgYQo+ID4+Pj4gZGVidWdmcyBm
aWxlIHRvIHJlYWQgdGhlIGN1cnJlbnQgZmVuY2UgdmFsdWVzLgo+ID4+Pj4KPiA+Pj4+IFNpbmNl
IHRoZSBDUFUgYWRkcmVzcyBpcyBub3QgbXVjaCB1c2VmdWwsIGp1c3QgcmVtb3ZlIHRoZSBkZWJ1
Zwo+ID4+Pj4gaW5mbyBhYm91dAo+ID4+Pj4gQ1BVIGFkZHJlc3MuCj4gPj4+Pgo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdzb24uY24+Cj4gPj4+Cj4g
Pj4+IFNwbGl0dGluZyBpdCBpbnRvIG9uZSBwYXRjaCBmb3IgcmFkZW9uIGFuZCBvbmUgZm9yIGFt
ZGdwdSBtaWdodCBiZQo+ID4+PiBuaWNlIHRvIGhhdmUuCj4gPj4KPiA+PiBTaG91bGQgSSBzcGxp
dCB0aGlzIHBhdGNoIGludG8gdHdvIHBhdGNoZXMgYW5kIHRoZW4gc2VuZCB2Mz8KPiA+PiBJZiB5
ZXMsIEkgd2lsbCBkbyBpdCBzb29uLgo+ID4KPiA+IEZvciBtZSBpdCdzIG9rIHRvIG1lcmdlIGl0
IGxpa2UgaXQgaXMgbm93Lgo+ID4KPiA+IE9ubHkgQWxleCBjb3VsZCBpbnNpc3RzIHRvIHNwbGl0
IHRoZSBwYXRjaGVzLCBidXQgdGhlbiBoZSB3aWxsCj4gPiBwcm9iYWJseSBkbyBpdCBoaW1zZWxm
Lgo+Cj4gT0ssIHRoZW4gSSB3aWxsIG5vdCBzZW5kIHYzLgo+Cj4gPgo+ID4gVGhhbmtzIGZvciB0
aGUgaGVscCwKPiA+IENocmlzdGlhbi4KPiA+Cj4gPj4KPiA+Pj4KPiA+Pj4gQnV0IGVpdGhlciB3
YXkgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcKPiA+Pj4gPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4gZm9yIHRoZSBwYXRjaC4KPiA+Pj4KPiA+Pj4gVGhhbmtzLAo+ID4+PiBDaHJpc3Rp
YW4uCj4gPj4+Cj4gPj4+PiAtLS0KPiA+Pj4+Cj4gPj4+PiB2MjoKPiA+Pj4+ICAgIC0gSnVzdCBy
ZW1vdmUgdGhlIGRlYnVnIGluZm8gYWJvdXQgQ1BVIGFkZHJlc3Mgc3VnZ2VzdGVkIGJ5Cj4gPj4+
PiBDaHJpc3RpYW4KPiA+Pj4+ICAgIC0gTW9kaWZ5IHRoZSBwYXRjaCBzdWJqZWN0IGFuZCB1cGRh
dGUgdGhlIGNvbW1pdCBtZXNzYWdlCj4gPj4+Pgo+ID4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDUgKystLS0KPiA+Pj4+ICAgZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZmVuY2UuYyAgICAgfCA0ICsrLS0KPiA+Pj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPj4+Pgo+ID4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gPj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gPj4+PiBpbmRleCBk
ODc4ZmU3Li5hMjlmMmY5IDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mZW5jZS5jCj4gPj4+PiBAQCAtNDIyLDkgKzQyMiw4IEBAIGludCBhbWRncHVf
ZmVuY2VfZHJpdmVyX3N0YXJ0X3Jpbmcoc3RydWN0Cj4gPj4+PiBhbWRncHVfcmluZyAqcmluZywK
PiA+Pj4+ICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlwZSA9IGlycV90eXBlOwo+ID4+Pj4g
ICAgICAgcmluZy0+ZmVuY2VfZHJ2LmluaXRpYWxpemVkID0gdHJ1ZTsKPiA+Pj4+ICAgLSAgICBE
Uk1fREVWX0RFQlVHKGFkZXYtPmRldiwgImZlbmNlIGRyaXZlciBvbiByaW5nICVzIHVzZSBncHUK
PiA+Pj4+IGFkZHIgIgo+ID4+Pj4gLSAgICAgICAgICAgICAgIjB4JTAxNmxseCwgY3B1IGFkZHIg
MHglcFxuIiwgcmluZy0+bmFtZSwKPiA+Pj4+IC0gICAgICAgICAgICAgIHJpbmctPmZlbmNlX2Ry
di5ncHVfYWRkciwgcmluZy0+ZmVuY2VfZHJ2LmNwdV9hZGRyKTsKPiA+Pj4+ICsgICAgRFJNX0RF
Vl9ERUJVRyhhZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIK
PiA+Pj4+IDB4JTAxNmxseFxuIiwKPiA+Pj4+ICsgICAgICAgICAgICAgIHJpbmctPm5hbWUsIHJp
bmctPmZlbmNlX2Rydi5ncHVfYWRkcik7Cj4gPj4+PiAgICAgICByZXR1cm4gMDsKPiA+Pj4+ICAg
fQo+ID4+Pj4gICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVu
Y2UuYwo+ID4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jCj4gPj4+
PiBpbmRleCA0M2YyZjkzLi44NzM1YmYyIDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYwo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZmVuY2UuYwo+ID4+Pj4gQEAgLTg2NSw4ICs4NjUsOCBAQCBpbnQgcmFkZW9u
X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdAo+ID4+Pj4gcmFkZW9uX2RldmljZSAqcmRl
diwgaW50IHJpbmcpCj4gPj4+PiAgICAgICB9Cj4gPj4+PiAgICAgICByYWRlb25fZmVuY2Vfd3Jp
dGUocmRldiwKPiA+Pj4+IGF0b21pYzY0X3JlYWQoJnJkZXYtPmZlbmNlX2RydltyaW5nXS5sYXN0
X3NlcSksIHJpbmcpOwo+ID4+Pj4gICAgICAgcmRldi0+ZmVuY2VfZHJ2W3JpbmddLmluaXRpYWxp
emVkID0gdHJ1ZTsKPiA+Pj4+IC0gICAgZGV2X2luZm8ocmRldi0+ZGV2LCAiZmVuY2UgZHJpdmVy
IG9uIHJpbmcgJWQgdXNlIGdwdSBhZGRyCj4gPj4+PiAweCUwMTZsbHggYW5kIGNwdSBhZGRyIDB4
JXBcbiIsCj4gPj4+PiAtICAgICAgICAgcmluZywgcmRldi0+ZmVuY2VfZHJ2W3JpbmddLmdwdV9h
ZGRyLAo+ID4+Pj4gcmRldi0+ZmVuY2VfZHJ2W3JpbmddLmNwdV9hZGRyKTsKPiA+Pj4+ICsgICAg
ZGV2X2luZm8ocmRldi0+ZGV2LCAiZmVuY2UgZHJpdmVyIG9uIHJpbmcgJWQgdXNlIGdwdSBhZGRy
Cj4gPj4+PiAweCUwMTZsbHhcbiIsCj4gPj4+PiArICAgICAgICAgcmluZywgcmRldi0+ZmVuY2Vf
ZHJ2W3JpbmddLmdwdV9hZGRyKTsKPiA+Pj4+ICAgICAgIHJldHVybiAwOwo+ID4+Pj4gICB9Cj4g
Pj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
