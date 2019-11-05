Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD4C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C66D206BA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDBF6EB7D;
	Tue,  5 Nov 2019 23:06:22 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DFC6EB7D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 23:06:21 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b3so17717142wrs.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2019 15:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ao6klbTwafBWq5Qkcpwfx0hZwS1qdb8HsTXvDjNvwsQ=;
 b=Ltyb3u+5BBcCV/iCeAPYLPcQ/LmSyIRtmVSkal+K0sXcTfHDkaaTobUl1brIwIquiB
 Z4yc4CcaObU6IZevwiwtvUm1yTvPYAMBLnnU650zBLMsPgVGRKtCjBvv1G5LTERBNgOC
 uW1qGI35iy3wiqj4PxfAMD46BcbF1VGj5oS3WYOIfNPTVa9lN2LNxW6E66SVylX72+FN
 bGLmg4eK9l9SUn9UorVoKl5/7cIaUsG45zFVsRFCQuWT/DDq6FSsHRddFVC+khJv6H4r
 gIdHHmr6iel0e5hq0MexXq+sjA9ax3108oURCi3ep+NRSdL6pvbHhdiVPLAReVRbGKHH
 lYvQ==
X-Gm-Message-State: APjAAAXxOaILor9B+LUITXg+vJmq45qSFhQeWXw+5dC65TI+4wdizZjj
 WV5ftOH0O9N5yfkpjijHXLExNvNTqPhoTdB5PU4=
X-Google-Smtp-Source: APXvYqwO2lPfInRUG8OvJb8YhWgqarm/ZFx4/HzyubDjeFKoekm+ZQlQVio20FsfYj1+TDZ8m7JRrLw/OxN8bhDKRXw=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr19129415wrw.206.1572995179541; 
 Tue, 05 Nov 2019 15:06:19 -0800 (PST)
MIME-Version: 1.0
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
In-Reply-To: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Nov 2019 18:06:08 -0500
Message-ID:
 <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=ao6klbTwafBWq5Qkcpwfx0hZwS1qdb8HsTXvDjNvwsQ=;
 b=QMpAzhKjvdZVJS6tPU2H2qMIIzCUbzkRBpKpbocIA3VJw5VuCKwlcg7Q9Cjt/E6FzA
 pqwH3LoEbuCSpAcwaNiVj1tddkzYTUAxZ+vCJsto4KFoQfi+smyzXIxTH1iWz4WZ9MkN
 MuQwmAppDrdPTzesbM7uVeSaD0PsQnCC9dFM5aN75Dntcj4ewH05U5/qXJuVF4gZYAg+
 ICo4JFfmvosL1wLSi4ZORQRiigonL976QJooKIxlPF40VfalvOhRjwNCgntQdpY9OnNk
 krMMz0A9VpYNnlGOP230q5wAsyQZ9HL290TOlnkk3PF5DxKFpWWIUM7wqTTQWJ0QDNvl
 48/w==
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105230608.Bz1J6ZKLOjUUtmOKz5BlqeSi-YrCAMQreJQAZo7_xrE@z>

T24gVHVlLCBOb3YgNSwgMjAxOSBhdCA1OjI2IFBNIEh1YW5nLCBKaW5IdWlFcmljCjxKaW5IdWlF
cmljLkh1YW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gVXNpbmcgdW5pZmllZCBWQklPUyBoYXMgcGVy
Zm9ybWFuY2UgZHJvcCBpbiBzcmlvdiBlbnZpcm9ubWVudC4KPiBUaGUgZml4IGlzIHN3aXRjaGlu
ZyB0byBhbm90aGVyIHJlZ2lzdGVyIGluc3RlYWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1
YW5nIDxKaW5odWlFcmljLkh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxOSArKysrKysrKysrKysrKysrLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gaW5kZXggODI5ZDYyMy4uZTQ0YTNlYSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC0zODg1LDkgKzM4ODUsMjIgQEAg
c3RhdGljIHVpbnQ2NF90IGdmeF92OV8wX2dldF9ncHVfY2xvY2tfY291bnRlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKPiAgICAgICAgIHVpbnQ2NF90IGNsb2NrOwo+Cj4gICAgICAgICBt
dXRleF9sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKPiAtICAgICAgIFdSRUczMl9T
T0MxNShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQsIDEpOwo+IC0gICAgICAg
Y2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09V
TlRfTFNCKSB8Cj4gLSAgICAgICAgICAgICAgICgodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAw
LCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTVNCKSA8PCAzMlVMTCk7Cj4gKyAgICAgICBpZiAoYWRl
di0+YXNpY190eXBlID09IENISVBfVkVHQTEwICYmIGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYp
KSB7Cj4gKyAgICAgICAgICAgICAgIHVpbnQzMl90IHRtcCwgbHNiLCBtc2IsIGkgPSAwOwo+ICsg
ICAgICAgICAgICAgICBkbyB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGkgIT0gMCkK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVkZWxheSgxKTsKPiArICAgICAgICAg
ICAgICAgICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JFRkNMT0NLX1RJ
TUVTVEFNUF9NU0IpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGxzYiA9IFJSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX0xTQik7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgbXNiID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19SRUZDTE9DS19USU1FU1RB
TVBfTVNCKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBpKys7Cj4gKyAgICAgICAgICAgICAg
IH0gd2hpbGUgKHVubGlrZWx5KHRtcCAhPSBtc2IpICYmIChpIDwgYWRldi0+dXNlY190aW1lb3V0
KSk7Cj4gKyAgICAgICAgICAgICAgIGNsb2NrID0gKHVpbnQ2NF90KWxzYiB8ICgodWludDY0X3Qp
bXNiIDw8IDMyVUxMKTsKPiArICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgIFdSRUcz
Ml9TT0MxNShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQsIDEpOwo+ICsgICAg
ICAgICAgICAgICBjbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQ
VV9DTE9DS19DT1VOVF9MU0IpIHwKPiArICAgICAgICAgICAgICAgICAgICAgICAoKHVpbnQ2NF90
KVJSRUczMl9TT0MxNShHQywgMCwgbW1STENfR1BVX0NMT0NLX0NPVU5UX01TQikgPDwgMzJVTEwp
Owo+ICsgICAgICAgfQoKSXMgdGhlcmUgYSByZWFzb24gd2UgY2FuJ3QgdXNlIHRoZSBzYW1lIHJl
Z3Mgb24gYmFyZSBtZXRhbCBhbmQgU1ItSU9WPwogSSdkIGxpa2UgdG8gbWluaW1pemUgdGhlIGRl
bHRhcyBpZiBwb3NzaWJsZS4KCkFsZXgKCj4gICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPmdm
eC5ncHVfY2xvY2tfbXV0ZXgpOwo+ICAgICAgICAgcmV0dXJuIGNsb2NrOwo+ICB9Cj4gLS0KPiAy
LjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
