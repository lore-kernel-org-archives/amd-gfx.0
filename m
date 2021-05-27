Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC888C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6868613B0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6868613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA6D6EE1B;
	Thu, 27 May 2021 04:12:59 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE866E8C5;
 Thu, 27 May 2021 04:12:58 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so3170333otp.11; 
 Wed, 26 May 2021 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wAtRRMb1FBGzO+jQIGrd+HIGuJW9STgbsAS6K+V97RQ=;
 b=HuW+0u6qUbeGkEDLvz7I2oy9Mc8OAbS1xNk5cVRIHHTMPu3qv3rBsTxByh3rpGW21a
 UOQSJhQdd+f3D185abbIMjJ2tMotDyk2KQ59iHE4DhpjxSmJjdY50esGah5i4BH2Sxdi
 8EiHVgeT9GQcqotkfiZCgSOI8X+Ub6+TL6JrT5L1Y+LwelzQHywdvv5dpdhFnKDJTAZc
 kaghpeLh4X77oaWOsCWtbqp1cG3c2JvGPOrlUqpeKe1wAB7LPMEngj7S6KmDGoftBT0m
 n/10XZfuyxymxLXV+3ci3/T8i4lGUdaveLHS9uwkqE3rBjgBogEN0ypopdFVp+zDMUxT
 sYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wAtRRMb1FBGzO+jQIGrd+HIGuJW9STgbsAS6K+V97RQ=;
 b=ZQaqKPujx2sVbkYBiVdZ5PJ6VgoNJmFxk97S1XDhRaN/UH203YEHR/0QPMG/DY1YKG
 SN0tuHTGLKQf3rG0Fb1+c00M5NG85jzu2SpxHiRTZNg3zT/xv6ErOAg1NWFX57KGtNIR
 iuEC7iDbR4myQnhWD/PFZNRpBc6TmPUocEETmt9cmSosj1FLslQ6Sz1dTvs/5p6SuxeY
 1aabznPW73W3jbGrhAgzyAW/SusC0W13avRHqOz+ZM4OOzcu19y+JA8H+amAu8wylh+M
 QvVSkb7bP+INYMiL+/bQNTS97ytxxf9ZGUu4uDROQ46mSqqtSgi8V6HBsQon8ATx8eDh
 4Kjg==
X-Gm-Message-State: AOAM5339bTOD0BFezh1ZIOyMy1rvUR2KJRl4ZUauVkTyq7QWUoqFeaN4
 HwJ6B67EyUptHKhbKbbsr6+Rhte6AtsxkbolYTaoXuvSffc=
X-Google-Smtp-Source: ABdhPJwZ4Ix3NcRn/6nTGZbbXYbkWrttOSD2i6IYoabkkdQes4mjHf1EiB4EJLDbj4Ps2yyCovGYGLpZQFalG5HV6jo=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1254263otl.311.1622088777455; 
 Wed, 26 May 2021 21:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-17-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-17-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:12:46 -0400
Message-ID: <CADnq5_PmyZyZLO1N0q2fMM9NKPYYiMhbPBfgFyeOAWgi-i1MFg@mail.gmail.com>
Subject: Re: [PATCH 16/34] drm/amd/display/dc/dce/dce_transform: Remove
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

T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgNDo0OCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
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
WEZNX0NPTU1PTl9SRUdfTElTVF9EQ0U2MF9CQVNFKGlkKQoKSSBiZWxpZXZlIHRoaXMgc2hvdWxk
IGJlIGtlcHQgYW5kIGl0IHNob3VsZCBiZSByZW1vdmVkIGZyb20KWEZNX0NPTU1PTl9SRUdfTElT
VF9EQ0U2MF9CQVNFKCkuCgpBbGV4Cgo+ICAjZW5kaWYKPgo+ICAjZGVmaW5lIFhGTV9TRihyZWdf
bmFtZSwgZmllbGRfbmFtZSwgcG9zdF9maXgpXAo+IC0tCj4gMi4zMS4xCj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
