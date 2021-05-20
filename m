Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD6C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D0C608FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D0C608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51616F4FB;
	Thu, 20 May 2021 19:18:06 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0FC6F4FA;
 Thu, 20 May 2021 19:18:04 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 q17-20020a4a33110000b029020ebab0e615so2108643ooq.8; 
 Thu, 20 May 2021 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=inhHSx4VVdd6VlmWYA1Oc6IjDKgdb7a8vsKxGCF5N0I=;
 b=XCOGtUJUvbDS2LdLMD6oXtSH4CFhzjRz6VqPhCJZs+ccNHknMTPnl1WQOdtBkMofoO
 HP4e8tFBFuyMt7E6B4x4it1C3Zdzy9wMtVfHX7DawfZMYE46Ok1sa5XVvgcIikk/SpSd
 HAh2SogLnOZ9BLXlKj00Y7ocS93RyXZInitiyCQ+YBiFNfrpb6EYJw6Motp5n7Zf3+N3
 05I6EqhujA09IzhZVSp5w5jvO8KUyXhxhfjrSdJqeaWGsnRFxg5vgl1TqVJKX/R4u8xD
 2OPrwRTagsl4gN6C1tWMjGQQ+RSVeCglioCmQiA+GONXMC25aFCi0gOL11WYlQeJbxsP
 GKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=inhHSx4VVdd6VlmWYA1Oc6IjDKgdb7a8vsKxGCF5N0I=;
 b=S+xnBt1JJXL0b1JY1Tqd2yIvcv5Yj+fFgEgQWLEeWWQH88VAA3mgk36nwwIOGho/fF
 3O7zHxvt7nMmx4sUqdVklpEIU8z0fvZQ9FeSkF1AysdsUTa0VGG9b8XEi86Yi3Jh3797
 xIzxILMZOQIXSbB6oB7PQ8RfxOWuuTfHNe1v2bJ0TebLoZh/vAIXZXDAeumgqhCfvCyN
 vW/Y92C6KFNrFg1SQUmmbRrABF8AlwWloavEWZj/dTUecOqswker2B+8ABBZ1rixCpM/
 2gaxETLYh651wH7CanTBvuvFxcyhSCz7XQbJ9GkZbVq8J8c5Se+07IecZtNQ1nswp9oi
 kcrQ==
X-Gm-Message-State: AOAM532IIMLnVaL1WSKYwMs3b9Q9C9Z4b+Xk5QI8lBp5a5wOx/vqbhSq
 svWoNlYQHw6x0UEICWn01YQdEdRa6aEo46LvVA5m3iq2
X-Google-Smtp-Source: ABdhPJzh6BsciXjhKaLIHK8DE7cvwKOEYyYVAA+r2OS+xmgokC8Ab+vei2Pi46Wk1Ws9U1NNJoG21+doLDQ+3RwRenQ=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr4937571oos.72.1621538282712;
 Thu, 20 May 2021 12:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-22-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-22-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:17:51 -0400
Message-ID: <CADnq5_Mk9WkJP4m+mn175H+2btAnrXqhioGM07Ow+x9VtwQKaQ@mail.gmail.com>
Subject: Re: [PATCH 21/38] drm/amd/include/aldebaran_ip_offset: Mark top-level
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaDoyNTk6Mjk6IHdhcm5p
bmc6IOKAmFhHTUkyX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRl
YmFyYW5faXBfb2Zmc2V0Lmg6MjUyOjI5OiB3YXJuaW5nOiDigJhYR01JMV9CQVNF4oCZIGRlZmlu
ZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjI0NToyOTog
d2FybmluZzog4oCYWEdNSTBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
Y29uc3QtdmFyaWFibGU9XQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRl
L2FsZGViYXJhbl9pcF9vZmZzZXQuaDoyMzg6Mjk6IHdhcm5pbmc6IOKAmFdBRkwxX0JBU0XigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6MjMx
OjI5OiB3YXJuaW5nOiDigJhXQUZMMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3Vu
dXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2lu
Y2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjE2MToyOTogd2FybmluZzog4oCYUENJRTBfQkFT
ReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQu
aDoxMTk6Mjk6IHdhcm5pbmc6IOKAmEwySU1VMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2Vk
IFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjExMjoyOTogd2FybmluZzog4oCYTDFJ
TVVQQ0lFMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJp
YWJsZT1dCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFu
X2lwX29mZnNldC5oOjEwNToyOTogd2FybmluZzog4oCYTDFJTVVJT0FHUjBfQkFTReKAmSBkZWZp
bmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaDo5ODoyOTog
d2FybmluZzog4oCYSU9IQzBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
Y29uc3QtdmFyaWFibGU9XQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRl
L2FsZGViYXJhbl9pcF9vZmZzZXQuaDo5MToyOTogd2FybmluZzog4oCYSU9BUElDMF9CQVNF4oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjg0
OjI5OiB3YXJuaW5nOiDigJhJT0FHUjBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9p
bmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaDo2MzoyOTogd2FybmluZzog4oCYRlVTRV9CQVNF
4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5o
OjQ5OjI5OiB3YXJuaW5nOiDigJhEQkdVX0lPMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2Vk
IFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjQyOjI5OiB3YXJuaW5nOiDigJhDTEtf
QkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+
Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFp
cmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPgo+IENjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNl
dC5oIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYWxkZWJhcmFu
X2lwX29mZnNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FsZGViYXJhbl9pcF9v
ZmZzZXQuaAo+IGluZGV4IDY0NGZmZWMyYjBjZTguLmNkZDQyNmI0MWMyMGUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaAo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0LmgKPiBA
QCAtMzAsNyArMzAsNyBAQCBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRSB7Cj4KPiAgc3RydWN0IElQ
X0JBU0Ugewo+ICAgICAgc3RydWN0IElQX0JBU0VfSU5TVEFOQ0UgaW5zdGFuY2VbTUFYX0lOU1RB
TkNFXTsKPiAtfTsKPiArfSBfX21heWJlX3VudXNlZDsKPgo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IElQX0JBU0UgQVRIVUJfQkFTRSA9IHsgeyB7IHsgMHgwMDAwMEMyMCwgMHgwMjQwOEMwMCwgMCwg
MCwgMCwgMCB9IH0sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7
IHsgMCwgMCwgMCwgMCwgMCwgMCB9IH0sCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
