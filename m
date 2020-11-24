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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644BC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09C420715
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoV+dO27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09C420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236D06E444;
	Tue, 24 Nov 2020 16:16:10 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A8E6E497;
 Tue, 24 Nov 2020 16:16:08 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p8so22908033wrx.5;
 Tue, 24 Nov 2020 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6u3X2EJumnPSVBJDMd67m/oxJY0N46da9Q4A0CHDe4c=;
 b=GoV+dO27QW2/4gv0cmXmmMNWMAcgCho4b8g3F3I8TEaqEQAWE6XvvOVw28ShJXay9b
 cctjltNE6yU/bV5WYUfCfy2qy50Dgn1qT/GxiaSYaWa5pxu98JePq7vgXUN53lGradzB
 1wAP0KYZsCK7//8V5/6lp3bimhzFnV9A5GDIYydjFVcaei8gWKT8cif3nNMe3tiXDHqq
 UeQ2LQMrssZkAcrkkVhYvaPLIEj6BMtTxQfECyeS/MBW/PSuY2PRPy9H2XLIZ1xP6Ew9
 xwhATPGnztcovclO7HvAZKPG5PgZth3WoiuJAL/jsTU0wuRbpDrZdBdGLIf3ovuay/4I
 rtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6u3X2EJumnPSVBJDMd67m/oxJY0N46da9Q4A0CHDe4c=;
 b=S0hVWLzkO0jxmMNy1rTR9bYUfUY9puytrXb9Y/BPa+9Qp4LrAT/blO3i5iK2OMb3T9
 tD1F5pOac16uD3anIjHhhEcqEwe+jaTbtOX7m2zO9JJGGsAEl3xg/fvKpXE0MYLiX37G
 pIHwgwkeInYHWA+cqJpCD4XIZ4kNpJ9Q0sVoZtDaxZWi7vQMH7eUvgWKukntr6d0ujnr
 R1DAkahfuGD260g2CARd5ZoU+3V6hc5vawbGxwRJXBYtDIGJBiMJzYBglof/BtmPEbBa
 3xdX3QTniojpaSFKsD86AsH8YLsJWo45sBn0Q4q0FcHdg2srEP6QpSsDfJfAMlOh0hZE
 hevg==
X-Gm-Message-State: AOAM531m81gQSn+W6ASj57U9OZS8W6S1Oa2/IRw/mezVCtci11QD1o/P
 7r8O8La3yL6rxMGD82AHU82wUZnUggN1/IRMPC0=
X-Google-Smtp-Source: ABdhPJwMVElpfSmNpkqDl6RZr9Iq+NMuM32RVXSSv19l9Z5MpoEmkMzM2eVrMZq66oPV4PL4XC8vSkBuzPWvpdZWvEU=
X-Received: by 2002:adf:8028:: with SMTP id 37mr6158027wrk.111.1606234567277; 
 Tue, 24 Nov 2020 08:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-30-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-30-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 11:15:56 -0500
Message-ID: <CADnq5_NAD7-NzLDsLNhZ_PxrujiSXcVyj1uo=h--c2p9sRjXxg@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/include/vangogh_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoyMCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92YW5nb2doX3JlZ19pbml0LmM6Mjg6Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2luY2x1ZGUvdmFuZ29naF9pcF9vZmZzZXQuaDoyMTA6Mjk6IHdhcm5pbmc6IOKAmFVT
Ql9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1d
Cj4gIDIxMCB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBVU0JfQkFTRSA9IHsgeyB7IHsg
MHgwMjQyQTgwMCwgMHgwNUIwMDAwMCwgMCwgMCwgMCwgMCB9IH0sCj4gIHwgXn5+fn5+fn4KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS92YW5nb2doX2lwX29mZnNldC5o
OjIwMjoyOTogd2FybmluZzog4oCYVU1DX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAgMjAyIHwgc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9C
QVNFIFVNQ19CQVNFID0geyB7IHsgeyAweDAwMDE0MDAwLCAweDAyNDI1ODAwLCAwLCAwLCAwLCAw
IH0gfSwKPiAgfCBefn5+fn5+fgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNs
dWRlL3ZhbmdvZ2hfaXBfb2Zmc2V0Lmg6MTc4OjI5OiB3YXJuaW5nOiDigJhQQ0lFMF9CQVNF4oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIDE3OCB8
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBQQ0lFMF9CQVNFID0geyB7IHsgeyAweDAwMDAw
MDAwLCAweDAwMDAwMDE0LCAweDAwMDAwRDIwLCAweDAwMDEwNDAwLCAweDAyNDFCMDAwLCAweDA0
MDQwMDAwIH0gfSwKPiAgfCBefn5+fn5+fn5+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2luY2x1ZGUvdmFuZ29naF9pcF9vZmZzZXQuaDoxNTQ6Mjk6IHdhcm5pbmc6IOKAmE1QMl9C
QVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4g
IDE1NCB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBNUDJfQkFTRSA9IHsgeyB7IHsgMHgw
MDAxNjQwMCwgMHgwMjQwMDgwMCwgMHgwMEY0MDAwMCwgMHgwMEY4MDAwMCwgMHgwMEZDMDAwMCwg
MCB9IH0sCj4gIHwgXn5+fn5+fn4KPgo+IE5COiBTbmlwcGVkIGxvdHMgb2YgdGhlc2UKPgo+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
PiBDYzogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAg
VGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3Zhbmdv
Z2hfaXBfb2Zmc2V0LmggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS92YW5nb2doX2lwX29mZnNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3Zhbmdv
Z2hfaXBfb2Zmc2V0LmgKPiBpbmRleCAyODc1NTc0YjA2MGU2Li42OTEwNzNlZDc4MGVjIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS92YW5nb2doX2lwX29mZnNldC5o
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3ZhbmdvZ2hfaXBfb2Zmc2V0LmgK
PiBAQCAtMzYsNyArMzYsNyBAQCBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRQo+ICBzdHJ1Y3QgSVBf
QkFTRQo+ICB7Cj4gICAgICBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRSBpbnN0YW5jZVtNQVhfSU5T
VEFOQ0VdOwo+IC19Owo+ICt9IF9fbWF5YmVfdW51c2VkOwo+Cj4KPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBJUF9CQVNFIEFDUF9CQVNFID0geyB7IHsgeyAweDAyNDAzODAwLCAweDAwNDgwMDAwLCAw
LCAwLCAwLCAwIH0gfSwKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
