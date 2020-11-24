Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E7C63777
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B79C20715
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j93ka3XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B79C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F13A6E488;
	Tue, 24 Nov 2020 16:15:32 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E9D6E323;
 Tue, 24 Nov 2020 16:15:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id s13so3427327wmh.4;
 Tue, 24 Nov 2020 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NcGZEMoE8/OoazRbMXmgCCoABg8lK7yn+JEu89ArpnQ=;
 b=j93ka3XDSybeGE/pqWJYn2ugb5acGTe1U1xoLFPC3rS+FnLngGQ/CEdhDnhgXYkDYB
 ywPtr1zK89hhYJTSWiLxhqTtKnVjmycWxyxMn/+PD1zNxsCTBuYniOq8ObFSt+8av8Zy
 NsBOY6/hQStk/JA904y+gj4bVxZ9SnKiXk6I+x3LBHwieKqhS97HUGRD/f14srocrcVp
 hQD44Pt3ZsYUibWqgxNuslN+xiuChSOIqMFO+dx8AxGNNJ6Fc7jJjwbTWd8h08aB7Tf3
 IW6i51J7etgCp/XOGQ5jmHa2nASp7EkCzZvE7ACmQePc4lnrzN07casFyNrGJJM56u87
 o03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NcGZEMoE8/OoazRbMXmgCCoABg8lK7yn+JEu89ArpnQ=;
 b=LXIKfFa8noPrcjcYA8d5ebBBiLCvLXOWpfHyEe2gVaEf23NSnQmCT+Wuu8362i3Sl3
 ICP/pQAV4QkLcSwBwyCNT2nznl4n+tVGIcpFwdL6opEruLVcD4YPjwBD1/kFSdbxbfz8
 UBhTRdg8fAFm+K4tZMlYWrdMznXvrstaSk4Giun2uGuPYSEJdRHTQQoDKAYI9azkaVyB
 GCRxUGUK2RZ0gSrPs3HmP5PAHW1HvKI1xRhnARLLum3hvpi9k23vXIatvMAXSFs/9Q1/
 hut74g7XIL4dIk3n8Ihw/bdSN6Rh/ZBY/KscvebTbTMqgkHd4XBTOt/BNO3XhopOAVsK
 atZw==
X-Gm-Message-State: AOAM530jJL2oHBE/EueZiKRt88kdu/x8jXL5fHGKJKsdsVKPK+HiUErO
 fkrxO9rgp3i7jViYI0oJdz/PobfgK5joJtIt4zw=
X-Google-Smtp-Source: ABdhPJwdaQ/TVaitOeF10AIFPfnBOC2nVg3yhW7E8XK9B1wAPPrx3uQi4eK71spnQFsMJKjFcCrifF9nuFQukBrEL7s=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5277089wmi.70.1606234529909; 
 Tue, 24 Nov 2020 08:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-29-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-29-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 11:15:18 -0500
Message-ID: <CADnq5_OH+qgkPK-W+Gw7WXEEGDY2RO0VYQZ4HWZB31ZAiWs8mQ@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/include/sienna_cichlid_ip_offset: Mark
 top-level IP_BASE as __maybe_unused
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
 Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoyMCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zaWVubmFfY2ljaGxpZF9yZWdfaW5pdC5jOjI4Ogo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9pbmNsdWRlL3NpZW5uYV9jaWNobGlkX2lwX29mZnNldC5oOjE4NjoyOTog
d2FybmluZzog4oCYVVNCMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1j
b25zdC12YXJpYWJsZT1dCj4gIDE4NiB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBVU0Iw
X0JBU0UgPSB7IHsgeyB7IDB4MDI0MkE4MDAsIDB4MDVCMDAwMDAsIDAsIDAsIDAgfSB9LAo+ICB8
IF5+fn5+fn5+fgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL3NpZW5u
YV9jaWNobGlkX2lwX29mZnNldC5oOjE3OToyOTogd2FybmluZzog4oCYVU1DX0JBU0XigJkgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAgMTc5IHwgc3Rh
dGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIFVNQ19CQVNFID0geyB7IHsgeyAweDAwMDE0MDAwLCAw
eDAyNDI1ODAwLCAwLCAwLCAwIH0gfSwKPiAgfCBefn5+fn5+fgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9pbmNsdWRlL3NpZW5uYV9jaWNobGlkX2lwX29mZnNldC5oOjE1ODoyOTog
d2FybmluZzog4oCYU0RNQTFfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
Y29uc3QtdmFyaWFibGU9XQo+ICAxNTggfCBzdGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgU0RN
QTFfQkFTRSA9IHsgeyB7IHsgMHgwMDAwMTI2MCwgMHgwMDAwQTAwMCwgMHgwMDAxQzAwMCwgMHgw
MjQwMkMwMCwgMCB9IH0sCj4gIHwgXn5+fn5+fn5+fgo+Cj4gTkI6IFNuaXBwZWQgbG90cyBvZiB0
aGVzZQo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBD
YzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgo+IENjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4g
Q2M6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRo
YW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9zaWVubmFf
Y2ljaGxpZF9pcF9vZmZzZXQuaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL3NpZW5uYV9jaWNobGlkX2lwX29mZnNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL3NpZW5uYV9jaWNobGlkX2lwX29mZnNldC5oCj4gaW5kZXggMDY4MDBjNmZhMDQ5NS4u
YjA3YmMyZGQ4OTVkYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
c2llbm5hX2NpY2hsaWRfaXBfb2Zmc2V0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvc2llbm5hX2NpY2hsaWRfaXBfb2Zmc2V0LmgKPiBAQCAtMzMsNyArMzMsNyBAQCBzdHJ1
Y3QgSVBfQkFTRV9JTlNUQU5DRQo+ICBzdHJ1Y3QgSVBfQkFTRQo+ICB7Cj4gICAgICBzdHJ1Y3Qg
SVBfQkFTRV9JTlNUQU5DRSBpbnN0YW5jZVtNQVhfSU5TVEFOQ0VdOwo+IC19Owo+ICt9IF9fbWF5
YmVfdW51c2VkOwo+Cj4KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIEFUSFVCX0JBU0Ug
PSB7IHsgeyB7IDB4MDAwMDBDMDAsIDB4MDI0MDhDMDAsIDAsIDAsIDAgfSB9LAo+IC0tCj4gMi4y
NS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
