Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68696C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A9A6195D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9A6195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7BC6ECF9;
	Wed,  2 Jun 2021 16:24:01 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED5F6EB14;
 Wed,  2 Jun 2021 16:24:00 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so2897999otc.12; 
 Wed, 02 Jun 2021 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cZmDB0R8MYQqdnFyr5kHgXADjM/v40Bk8pYmSEReiu8=;
 b=F2U7lDM58wl86JVA1xx0TFZsmY+sP2repFNTtnLXvAyoTyVb2DTr52JEIZr7nQzXZy
 P1kneitgTOhGVeSgMP1nlppsALjNo//w7ADbiCMxLeE+FqeNqWKc/+8Huo/0rofqphuO
 g14rUobx7YSbZqaQXt8mdxVRi2Z5MXfqHS3hAl+0Owh2keTbCkZyg4aH/CjfuX2hOkcr
 BMq4hwdV54azgJ0fwA/2+THNgEqPevpLeMVoBif67GgdcVLfVVe6U5iyOhX9NqftZ7FX
 OQsyvo81qBEfuURklq7nsVhmqx6tiTtq/yjGYxPY8h/JqmYT17nfjmW4OfpVHsRgVW67
 atbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cZmDB0R8MYQqdnFyr5kHgXADjM/v40Bk8pYmSEReiu8=;
 b=t6yIKjBTSZ19wPuRjNSaYb6f5R+rO40Eodk8O9yCG4hBuj9UnRLF9Oiue0VeSuGSv2
 Bi+b4c/7Vlm6PeEs3HQjuF/9gGDqmrk/ifW5h+kOgRz+M0kFs3qkMFuNWTFUGJvDw3vE
 zf8Tlv/VuFgT67GShPElC+gfnrEgu5ZgYsypyb2oQs1X7zNfAoX8sBqMp7D/KRC+WRmh
 DLCSHkJKtinkBNfNJUrmjTM8D3KFr3R0W3aZpDqjxQr8KzkSwlwZ4PPVQaxJEG5+lmZp
 muP3jC80MkwaIaFVqEsv5o9h4yxyIeFSPAWGtkk5ruefaoIRrJWOsKHP4Z6MkvrdLxC6
 E3TQ==
X-Gm-Message-State: AOAM533BOPACXfUGUCNFIwmGmP6RYhGpIctSE1395u3Z6vypCMo0gCBC
 iY7JRgNZ2kflxsYUliFYcwQ41noaj8iL3HkrFfo9ioljEuM=
X-Google-Smtp-Source: ABdhPJz1BaV5VzBqVZFn1mtftXfq2NvR/yvqHSfO4Le2Pj/qDgFg26ZzK8ynsMmLvPKySfldKZGgP9zN7tvy/eu1WKg=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr26590805otl.311.1622651039670; 
 Wed, 02 Jun 2021 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-17-lee.jones@linaro.org>
In-Reply-To: <20210602143300.2330146-17-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jun 2021 12:23:48 -0400
Message-ID: <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
Subject: Re: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
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

T24gV2VkLCBKdW4gMiwgMjAyMSBhdCAxMDozMyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9k
dWxlcy9oZGNwL2hkY3BfcHNwLmM6Mzc0OjIyOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5
cGUgZm9yIOKAmG1vZF9oZGNwX2hkY3AxX2dldF9saW5rX2VuY3J5cHRpb25fc3RhdHVz4oCZCj4g
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6Mjg6Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfZC5oOjU2ODo0Mzogd2Fybmlu
ZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJpZGUtaW5pdF0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJj
ZS5jOjE1NzoxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1tQ1JUQzBfRENGRV9N
RU1fTElHSFRfU0xFRVBfQ05UTOKAmQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmg6MTcwOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyDigJhTUknigJkKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjE4MzozOiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MOKAmQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTg3OjM6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh0cmFuc2Zvcm1fcmVnc+KAmQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2VfNl8wX2QuaDo1
Njg6NDM6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJh4Zm1fcmVnc1swXS5EQ0ZF
X01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZKQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6MTU3OjE0OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8g4oCYbW1DUlRDMF9EQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRM4oCZCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFuc2Zv
cm0uaDoxNzA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFNSSeKAmQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNl
LmM6MTgzOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhYRk1fQ09NTU9OX1JFR19M
SVNUX0RDRTYw4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzoxODc6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmHRyYW5zZm9ybV9yZWdz4oCZCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2lu
Y2x1ZGUvYXNpY19yZWcvZGNlL2RjZV82XzBfZC5oOjY0NTo0Mzogd2FybmluZzogaW5pdGlhbGl6
ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJpZGUtaW5pdF0KPgo+IENjOiBIYXJyeSBXZW50
bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFt
ZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBD
YzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgo+IENjOiBNYXVybyBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJh
bnNmb3JtLmggfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZS9kY2VfdHJhbnNmb3JtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV90cmFuc2Zvcm0uaAo+IGluZGV4IGNiY2UxOTRlYzdiODIuLmU5OGI1ZDQxNDE3MzkgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNm
b3JtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFu
c2Zvcm0uaAo+IEBAIC0xNjYsOCArMTY2LDcgQEAKPiAgICAgICAgIFNSSShTQ0xfRl9TSEFSUF9D
T05UUk9MLCBTQ0wsIGlkKQo+Cj4gICNkZWZpbmUgWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MChp
ZCkgXAo+IC0gICAgICAgWEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9CQVNFKGlkKSwgXAo+IC0g
ICAgICAgU1JJKERDRkVfTUVNX0xJR0hUX1NMRUVQX0NOVEwsIENSVEMsIGlkKQo+ICsgICAgICAg
WEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9CQVNFKGlkKQoKSSBiZWxpZXZlIERDRkVfTUVNX0xJ
R0hUX1NMRUVQX0NOVEwgc2hvdWxkIGJlIGtlcHQgaGVyZSBhbmQgaXQgc2hvdWxkCmJlIHJlbW92
ZWQgZnJvbQpYRk1fQ09NTU9OX1JFR19MSVNUX0RDRTYwX0JBU0UoKSB0byBhbGlnbiB3aXRoIG90
aGVyIGFzaWNzLgoKQWxleAoKPiAgI2VuZGlmCj4KPiAgI2RlZmluZSBYRk1fU0YocmVnX25hbWUs
IGZpZWxkX25hbWUsIHBvc3RfZml4KVwKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
