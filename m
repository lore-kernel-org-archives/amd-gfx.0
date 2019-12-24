Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD331C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FE220663
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWBwKBOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F12F6E34B;
	Tue, 24 Dec 2019 18:00:59 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84AB6E34B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 18:00:57 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id c9so20384545wrw.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EsCnnwx1N8hIBTj0xE7rBxakA3G8kLxK36JQeT506Ws=;
 b=eWBwKBObAhdExuWQPm/a2fEFk5jfuKcygm9X41Fy6XpTFBpju3vygKfu5cgJ2Bew9q
 HWrT63jjgxDhx/7KykC/RZ7noeKY80RF4CTOFslxnwUgoFuJeZhY2bG+5DF+/jZqQUxz
 zC2ER5+p1C7in7Dga++jHXthKUT++TATMP+jJfGF+8rhu+0Y3L/h9VWt89ULwyCHOQAp
 twbbYvfe8qOo2yleZKdP3XUlRgviHEoHfl4cYikuNDLNqecLTc1B4IgM4JsG+4rYkXFS
 jzciJmhf/KvPIOGfAJ3JPLHUFbaL+SQEF85FNqg98wHloGItqYic/i4SphpvwpaiWQuL
 CJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EsCnnwx1N8hIBTj0xE7rBxakA3G8kLxK36JQeT506Ws=;
 b=RQguc0Nuab4mWRJ4HvxifzPiFEyUz14Ka/+k0nAbnd93kAA7Hy/Eo7kVbb5lf3pH3J
 UqY5PFipA1bzLPthV9gp8YUhZtWhOSa0OHjCDQT8bDSg/3aOQzCu7ck7C36D3mCdWyIF
 PlqCBgmRX+7vFuOQlZRxlURQCRWr6IDzdZSfWaHibOORQPAJDmM7F9qfdpgAfTg8e7rn
 4WhSUTIZA94FcgYL2mmajO89k5umsx8I0pOYXx8TYNJyW069p71HNldWgem1UfYLWSRB
 bLbhDVQH/BZG1DaaCRDO2J2QL6h+Wep+BUMi2zj09gBQG/tdVNFT6VOMW7gPbe6MC2eA
 yuWw==
X-Gm-Message-State: APjAAAVH7QfvJjyYH+Ui4guxmK4cdIyeXD6RlMY2YrkpWmRo5Ah+a2Ml
 nVY0M/N9fu5PkMjSy1Yy2D9dqu7UmfaM2+wuMvQ=
X-Google-Smtp-Source: APXvYqxup/yC7kEbAghLgT/qPXqO3mv4BQ68pRWTDUNi1w9V01FUhfiycz9jqZsnWmjUuz0Cn3AkQDRK/pOKETBWqnw=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr36284395wru.40.1577210456443; 
 Tue, 24 Dec 2019 10:00:56 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxOWf=0T9vd6u4-qasWPzzKZoafrz_02+A40=KGZkgrow@mail.gmail.com>
In-Reply-To: <CAGzVRjxOWf=0T9vd6u4-qasWPzzKZoafrz_02+A40=KGZkgrow@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Dec 2019 13:00:45 -0500
Message-ID: <CADnq5_NVW1u9fJjA6xq3s-o+3XFLW4wajANN27ohAY=Hm4ZudA@mail.gmail.com>
Subject: Re: polaris12_mc.bin error
To: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBEZWMgMjQsIDIwMTkgYXQgMTozOCBBTSBZdXN1ZiBBbHTEsXBhcm1hawo8eXVzdWZh
bHRpMTk5N0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gSGVsbG8sIEkganVzdCBjb21waWxlZCBteSA0
LjE5IGtlcm5lbCB3aXRoIGFtZGdwdSBkcml2ZXIgKGFtZGdwdSBhcyBidWlsdGluKS4gVGhlIGRy
aXZlciBpcyBnaXZpbmcgbWUgIC0yIGVycm9yIGJlY2F1c2Ugb2YgcG9sYXJpczEyX21jLmJpbiBk
aWQgbm90IGZvdW5kLiBJIGNvdWxkbid0IGZpbmQgdGhhdCBmaWxlIGFueXdoZXJlLiBIb3cgY2Fu
IGkgZ2V0IHBvbGFyaXMxMl9tYy5iaW4gYW5kIHdoZXJlIHNob3VsZCBJIHBsYWNlIGl0ID8KPgoK
SWYgeW91IGFyZSBidWlsZGluZyBhbWRncHUgaW50byB5b3VyIGtlcm5lbCwgeW91IG5lZWQgdG8g
YnVpbGQgdGhlCmZpcm13YXJlIGludG8gdGhlIGtlcm5lbCB0b28uICBJZiB5b3UgYXJlIHVzaW5n
IGFuIGluaXRyZCwgeW91IG5lZWQgdG8KaW5jbHVkZSB0aGUgZmlybXdhcmUgaW4gdGhlIGluaXRy
ZC4gIFRoZSBmaXJtd2FyZSBpcyB1c3VhbGx5IGluCi9saWIvZmlybXdhcmUsIGJ1dCBtYXkgdmFy
eSBhIGJpdCBkZXBlbmRpbmcgb24geW91ciBkaXN0cm8uCgpBbGV4Cgo+IERtZXNnOgo+IFsgICAg
NS40MjUzMjNdIFtkcm1dIGFtZGdwdSBrZXJuZWwgbW9kZXNldHRpbmcgZW5hYmxlZC4KPiBbICAg
IDUuNDI5MDY2XSBhbWRncHUgMDAwMTowMTowMC4wOiBydW50aW1lIElSUSBtYXBwaW5nIG5vdCBw
cm92aWRlZCBieSBhcmNoCj4gWyAgICA1LjQyOTYwOV0gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5l
bCBtb2Rlc2V0dGluZyAoUE9MQVJJUzEyIDB4MTAwMjoweDY5ODcgMHgxNzg3OjB4MjM4OSAweDgw
KS4KPiBbICAgIDUuNDM3MDkxXSBbZHJtXSByZWdpc3RlciBtbWlvIGJhc2U6IDB4MjAyMDAwMDAK
PiBbICAgIDUuNDQ1MzAzXSBbZHJtXSByZWdpc3RlciBtbWlvIHNpemU6IDI2MjE0NAo+IFsgICAg
NS40NDgyODhdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMCA8dmlfY29tbW9uPgo+IFsgICAg
NS40NTE4NjRdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMSA8Z21jX3Y4XzA+Cj4gWyAgICA1
LjQ1NTM1MV0gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAyIDx0b25nYV9paD4KPiBbICAgIDUu
NDU4ODMzXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDMgPHBvd2VycGxheT4KPiBbICAgIDUu
NDYyNDEwXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDQgPGRtPgo+IFsgICAgNS40NjUzNzZd
IFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgNSA8Z2Z4X3Y4XzA+Cj4gWyAgICA1LjQ2ODg2NF0g
W2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciA2IDxzZG1hX3YzXzA+Cj4gWyAgICA1LjQ3MjQzOF0g
W2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciA3IDx1dmRfdjZfMD4KPiBbICAgIDUuNDc1OTI5XSBb
ZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDggPHZjZV92M18wPgo+IFsgICAgNS40Nzk1MzBdIFtk
cm1dIFVWRCBpcyBlbmFibGVkIGluIFZNIG1vZGUKPiBbICAgIDUuNDgyNDExXSBbZHJtXSBVVkQg
RU5DIGlzIGVuYWJsZWQgaW4gVk0gbW9kZQo+IFsgICAgNS40ODU2NDddIFtkcm1dIFZDRSBlbmFi
bGVkIGluIFZNIG1vZGUKPiBbICAgIDUuNzE3OTMyXSBBVE9NIEJJT1M6IDExMy1FUjE2QkZDLTAw
MQo+IFsgICAgNS43MjA0MTJdIFtkcm1dIEdQVSBwb3N0aW5nIG5vdy4uLgo+IFsgICAgNS44NDMx
NjBdIFtkcm1dIHZtIHNpemUgaXMgNjQgR0IsIDIgbGV2ZWxzLCBibG9jayBzaXplIGlzIDEwLWJp
dCwgZnJhZ21lbnQgc2l6ZSBpcyA5LWJpdAo+IFsgICAgNS44NTAxNzVdIGFtZGdwdSAwMDAxOjAx
OjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciBhbWRncHUvcG9sYXJpczEyX21jLmJpbiBm
YWlsZWQgd2l0aCBlcnJvciAtMgo+IFsgICAgNS44NTgxODddIG1jOiBGYWlsZWQgdG8gbG9hZCBm
aXJtd2FyZSAiYW1kZ3B1L3BvbGFyaXMxMl9tYy5iaW4iCj4gWyAgICA1Ljg2Mzc1Ml0gW2RybTou
Z21jX3Y4XzBfc3dfaW5pdCBbYW1kZ3B1XV0gKkVSUk9SKiBGYWlsZWQgdG8gbG9hZCBtYyBmaXJt
d2FyZSEKPiBbICAgIDUuODcwNTAxXSBbZHJtOi5hbWRncHVfZGV2aWNlX2luaXQgW2FtZGdwdV1d
ICpFUlJPUiogc3dfaW5pdCBvZiBJUCBibG9jayA8Z21jX3Y4XzA+IGZhaWxlZCAtMgo+IFsgICAg
NS44Nzc5MThdIGFtZGdwdSAwMDAxOjAxOjAwLjA6IGFtZGdwdV9kZXZpY2VfaXBfaW5pdCBmYWls
ZWQKPiBbICAgIDUuODgyMzY1XSBhbWRncHUgMDAwMTowMTowMC4wOiBGYXRhbCBlcnJvciBkdXJp
bmcgR1BVIGluaXQKPiBbICAgIDUuODg2NzIyXSBbZHJtXSBhbWRncHU6IGZpbmlzaGluZyBkZXZp
Y2UuCj4gWyAgICA1Ljg5MDA1NF0gYW1kZ3B1OiBwcm9iZSBvZiAwMDAxOjAxOjAwLjAgZmFpbGVk
IHdpdGggZXJyb3IgLTIKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
