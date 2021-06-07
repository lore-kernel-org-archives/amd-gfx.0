Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C084CC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 21:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A8611BD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 21:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A8611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4CF6E9C6;
	Mon,  7 Jun 2021 21:30:03 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5FD6E9C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 21:30:02 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so18259150otg.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rzFYWetiEtoq5a7URcH3QkyWw+8V1fE3UnEbMseWXpA=;
 b=qIMJ6nFwOL9RWYtzaFsHQQxXM84Dhd0TTQuXFQIRURnxLoEr71ssh1Yoe1G2SgBXAz
 JID6IWi3LGUek3oaF/ItOHKpSra/vtaHXI0u2gmRC1He9tUYdz28k7mTiGK+dJ1JoujP
 /Xx+6+xnZpMhj39EeYRtbe8/2WQ+ecrHlPWpEhSfEklS5AFZqwXPsTlayyiJnnrlhXzt
 fmIKKmtVKg1NrQQyEtb28Ss2dYBabHT1SJfVvFvOuM1ZexWphjNRJ9t5tGL2Hct7bzc0
 yo3y6g/wfJbpfy2SOvTN2bCtnqc3K8d9hI88Feb5AeC/hcEvi6XYQ3vaaDrgzZP6wqpR
 AkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rzFYWetiEtoq5a7URcH3QkyWw+8V1fE3UnEbMseWXpA=;
 b=YTFvMa3lbxJZf1032zL10GAaTi956tN3pc8JtsXZElYOKQIxNbtxsLm3LmFnNYUDOi
 GQM6qqbX/uFuNy2GAVXMUVzxTmwPkXh4pf/dT1wX88f3kMyxQgz4IeoqrM48FBL7K0no
 vXqHsIfxHDG6DrG3Ajxv8lWkG+vZgBndEdj+zKbcDur2xJxDidOj2iQM86RhOrAo7e8c
 l1ZPNBks5wOwoRBEbLActmnMzKNbqghEob8le1hYfLbxknJUXFYzN9ezd335anC+7wKk
 WRXDyGv6zgyZY2a251HT7zwHqhOBKjs41j9oQKApvU8O6hyWbJocAhT4W+MkChsviGp9
 5JOw==
X-Gm-Message-State: AOAM532c/VylxKvHWtziKc5uw/4NktK7Sg7y4frFpWBT2jyfKvAeB7ij
 3cq841eo2WOpzud1cLkgH7hKiHGT3x3WtTZrmUw=
X-Google-Smtp-Source: ABdhPJzXTLlN/+Dt+0iw55Jfo7SCwIKWcrL28623tFa+BVHEF3t0jfhTIQHjHUB1lGPtbMeSFgzyXh6yMIIcPSDJEO0=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr12575051otr.23.1623101402056; 
 Mon, 07 Jun 2021 14:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210607202841.2120465-1-alexander.deucher@amd.com>
 <CAD=4a=Vgy4-i07wd3LLD4YUUgtKrZKz6Jw4trvOSZX6D12_T4w@mail.gmail.com>
In-Reply-To: <CAD=4a=Vgy4-i07wd3LLD4YUUgtKrZKz6Jw4trvOSZX6D12_T4w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jun 2021 17:29:50 -0400
Message-ID: <CADnq5_MPALW461FDzku65D=eq8qFsqAMp+R_WBjMpCvJ-6yP3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gNywgMjAyMSBhdCA0OjU0IFBNIEVybnN0IFNqw7ZzdHJhbmQgPGVybnN0cEBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBkb2Vzbid0IHRoaXMgcGF0Y2ggYXBwbHkgdGhl
IGNoYW5nZSB0byBWQ04xLjAgYWxzbywgd2hpY2ggaGFzIHRoYXQgYnVnIHlvdSBtZW50aW9uZWQ/
Cj4KCk5vcGUuICBWQ04xLjAgdXNlcyB2Y25fdjFfMF9pZGxlX3dvcmtfaGFuZGxlcigpIGFuZAp2
Y25fdjFfMF9yaW5nX2JlZ2luX3VzZSgpIGFzIHRoZXkgaGF2ZSBvdGhlciBzcGVjaWFsIGhhbmRs
aW5nIGluCmFkZGl0aW9uIHRvIHRoaXMuCgpBbGV4CgoKPiBSZWdhcmRzCj4gLy9Fcm5zdAo+Cj4g
RGVuIG3DpW4gNyBqdW5pIDIwMjEga2wgMjI6Mjkgc2tyZXYgQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPjoKPj4KPj4gRHJvcCBkaXNhYmxpbmcgb2YgZ2Z4b2ZmIGR1cmlu
ZyBWQ04gdXNlLiAgVGhpcyBhbGxvd3MgZ2Z4b2ZmCj4+IHRvIGtpY2sgaW4gYW5kIHBvdGVudGlh
bGx5IHNhdmUgcG93ZXIgaWYgdGhlIHVzZXIgaXMgbm90IHVzaW5nCj4+IGdmeCBmb3IgY29sb3Ig
c3BhY2UgY29udmVyc2lvbiBvciBzY2FsaW5nLgo+Pgo+PiBWQ04xLjAgaGFkIGEgYnVnIHdoaWNo
IHByZXZlbnRlZCBpdCBmcm9tIHdvcmtpbmcgcHJvcGVybHkgd2l0aAo+PiBnZnhvZmYsIHNvIHdl
IGRpc2FibGVkIGl0IHdoaWxlIHVzaW5nIFZDTi4gIFRoYXQgc2FpZCwgbW9zdCBhcHBzCj4+IHRv
ZGF5IHVzZSBnZnggZm9yIHNjYWxpbmcgYW5kIGNvbG9yIHNwYWNlIGNvbnZlcnNpb24gcmF0aGVy
IHRoYW4KPj4gb3ZlcmxheSBwbGFuZXMgc28gaXQgd2FzIGdlbmVyYWxseSBpbiB1c2UgYW55d2F5
LiBUaGlzIHdhcyBmaXhlZAo+PiBvbiBWQ04yKywgYnV0IHNpbmNlIHdlIG1vc3RseSB1c2UgZ2Z4
IGZvciBjb2xvciBzcGFjZSBjb252ZXJzaW9uCj4+IGFuZCBzY2FsaW5nIGFuZCByYXBpZGx5IHBv
d2VyaW5nIHVwL2Rvd24gZ2Z4IGNhbiBuZWdhdGUgdGhlCj4+IGFkdmFudGFnZXMgb2YgZ2Z4b2Zm
LCB3ZSBsZWZ0IGdmeG9mZiBkaXNhYmxlZC4gQXMgbW9yZQo+PiBhcHBsaWNhdGlvbnMgdXNlIG92
ZXJsYXkgcGxhbmVzIGZvciBjb2xvciBzcGFjZSBjb252ZXJzaW9uCj4+IGFuZCBzY2FsaW5nLCB0
aGlzIHN0YXJ0cyB0byBiZSBhIHdpbiwgc28gZ28gYWhlYWQgYW5kIGxlYXZlCj4+IGdmeG9mZiBl
bmFibGVkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5jIHwgMiAtLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gaW5kZXggMWRjMTFkYmQ2MmI3
Li42NDdkMmMzMWU4YmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNuLmMKPj4gQEAgLTM5Myw3ICszOTMsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVf
d29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPj4gICAgICAgICB9Cj4+Cj4+
ICAgICAgICAgaWYgKCFmZW5jZXMgJiYgIWF0b21pY19yZWFkKCZhZGV2LT52Y24udG90YWxfc3Vi
bWlzc2lvbl9jbnQpKSB7Cj4+IC0gICAgICAgICAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFk
ZXYsIHRydWUpOwo+PiAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJn
YXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIEFNRF9QR19TVEFURV9HQVRFKTsKPj4gICAgICAgICAgICAgICAgIHIgPSBhbWRn
cHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFkZXYsIFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZJ
REVPLAo+PiBAQCAtNDEzLDcgKzQxMiw2IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3Vz
ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+ICAgICAgICAgYXRvbWljX2luYygmYWRldi0+
dmNuLnRvdGFsX3N1Ym1pc3Npb25fY250KTsKPj4KPj4gICAgICAgICBpZiAoIWNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yaykpIHsKPj4gLSAgICAgICAgICAgICAg
IGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+PiAgICAgICAgICAgICAgICAgciA9
IGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoYWRldiwgUFBfU01DX1BPV0VSX1BST0ZJ
TEVfVklERU8sCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSk7Cj4+ICAg
ICAgICAgICAgICAgICBpZiAocikKPj4gLS0KPj4gMi4zMS4xCj4+Cj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
