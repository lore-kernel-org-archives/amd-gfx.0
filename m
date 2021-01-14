Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B58C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C979C23B31
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C979C23B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742006E08C;
	Thu, 14 Jan 2021 17:13:33 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0106E08C;
 Thu, 14 Jan 2021 17:13:32 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id i6so5858583otr.2;
 Thu, 14 Jan 2021 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=guVHfTm9U1BbJ/83nhR/rlmHAnSxZweOGvB2OkpNdfs=;
 b=OxmghgygzAMr8wxjWCJJEee0C8Jwm0T6+yMkuV1eCH1EkbAM0dIo0r4/gp8m/0k2xE
 7Qa5+YM9PxFqnTQM7DukVnemh64JZIICF9Ax6eaPt1gtD76gF3Ib1H2use7+JiHExB/L
 u0AySb517onG/CnSK9WORZSNJO0Ubj0ShnFH82rMcfTRG26T18hlR4ugqEFUsOUDAluV
 qgt/cwK7NTIDDXkXy45zHj2sh292EkuBq9J00Oqne1ywZqtA1C7dbTKNkY6NsHH9Lhlb
 8N9lPc/s3KAaHoUjmZcj/IxYIUO+Sp73gM5KhbzER49XbdREhaKccsSSvyxTfN9CDIFa
 M3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=guVHfTm9U1BbJ/83nhR/rlmHAnSxZweOGvB2OkpNdfs=;
 b=daGiCUGb0a64yxE6JWKcoJR0N5iHyqGnXE0YNX4RMFzXR0yeTn4H30jFzKrEVoCNOp
 Q981ucJTs5WUjLk3NsebMc25xurSd6vIc56korKbsGERfyd/m/LprpU1ps7EzrxWPYFH
 8UG7KZ2mGO3yIin/CULpyONAdwPfwQKdE1l4VY4mspWDCqqpgzKtzinV7ZuE+NwmcYxh
 u4z3hmmIigKTo6u16PhIQyufRkPa8GA8GXgTYmNtlblBUwKbSA3Yy71g4dNcy3CXo69L
 KhsGrrLWbvJ4KiQUm8RPwzh7gGH0D1thS3C7d/AoRSisKrNAWekcxSrXjTOVGnzf9O35
 ZLVg==
X-Gm-Message-State: AOAM531U5mbiJwk9Aw60DKYLIWJCQYiXZKBVJDxhFClJ+dNMSoCusbjP
 YRr+j4DMLvnvg2shE4XYhZ1U0toxRMHDgWK7QDk=
X-Google-Smtp-Source: ABdhPJxWusI9+KRrPHC8KWLTRZM+GGkemdF61/Ia3lx6mdt4MMELdMrXbCZkgVx3jgC68JwaFA8CR0ICSLdY6wpV4/A=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr5468841ote.132.1610644412225; 
 Thu, 14 Jan 2021 09:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org>
 <20210113080752.1003793-14-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:13:21 -0500
Message-ID: <CADnq5_MFMvmngNVUVK-u3v9Oz62d+66A2HUCCv0vrwUbOJMzig@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/amd/display/dc/dce60/Makefile: Ignore
 -Woverride-init warning
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMzowOCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6Mjg6Cj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfZC5o
OjU2ODo0Mzogd2FybmluZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJp
ZGUtaW5pdF0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2
MC9kY2U2MF9yZXNvdXJjZS5jOjE1NToxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mG1tQ1JUQzBfRENGRV9NRU1fTElHSFRfU0xFRVBfQ05UTOKAmQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6MTcwOjI6IG5vdGU6
IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTUknigJkKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4MTozOiBub3RlOiBp
biBleHBhbnNpb24gb2YgbWFjcm8g4oCYWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MOKAmQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291
cmNlLmM6MTg1OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh0cmFuc2Zvcm1fcmVn
c+KAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2Rj
ZS9kY2VfNl8wX2QuaDo1Njg6NDM6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJh4
Zm1fcmVnc1swXS5EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZKQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTU1OjE0
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYbW1DUlRDMF9EQ0ZFX01FTV9MSUdIVF9T
TEVFUF9DTlRM4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlL2RjZV90cmFuc2Zvcm0uaDoxNzA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mFNSSeKAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3Jlc291cmNlLmM6MTgxOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhY
Rk1fQ09NTU9OX1JFR19MSVNUX0RDRTYw4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoxODU6Mzogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvIOKAmHRyYW5zZm9ybV9yZWdz4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfZC5oOjY0NTo0Mzogd2Fy
bmluZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJpZGUtaW5pdF0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNv
dXJjZS5jOjE1NToxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1tQ1JUQzFfRENG
RV9NRU1fTElHSFRfU0xFRVBfQ05UTOKAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyDigJhTUknigJkKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4MTozOiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8g4oCYWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MOKAmQo+Cj4gIE5COiBTbmlwcGVk
IGxvdHMgZm9yIHRoZSBzYWtlIG9mIGJyZXZpdHkKPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4g
Q2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+IENjOiBNYXVybyBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFw
cGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlNjAvTWFrZWZpbGUgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
NjAvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvTWFrZWZp
bGUKPiBpbmRleCA3MDM2YzNiZDBmODcxLi5kZGE1OTZmYTFjZDc2IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9NYWtlZmlsZQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9NYWtlZmlsZQo+IEBAIC0yMyw2ICsyMyw4
IEBACj4gICMgTWFrZWZpbGUgZm9yIHRoZSAnY29udHJvbGxlcicgc3ViLWNvbXBvbmVudCBvZiBE
QUwuCj4gICMgSXQgcHJvdmlkZXMgdGhlIGNvbnRyb2wgYW5kIHN0YXR1cyBvZiBIVyBDUlRDIGJs
b2NrLgo+Cj4gK0NGTEFHU19BTUREQUxQQVRIKS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5vID0g
JChjYWxsIGNjLWRpc2FibGUtd2FybmluZywgb3ZlcnJpZGUtaW5pdCkKPiArCj4gIERDRTYwID0g
ZGNlNjBfdGltaW5nX2dlbmVyYXRvci5vIGRjZTYwX2h3X3NlcXVlbmNlci5vIFwKPiAgICAgICAg
IGRjZTYwX3Jlc291cmNlLm8KPgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
