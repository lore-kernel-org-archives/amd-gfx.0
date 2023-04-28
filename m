Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E9CC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 09:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D19810ECA9;
	Fri, 28 Apr 2023 09:47:57 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7272C10E3B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 09:47:55 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-94f1d0d2e03so1449632166b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682675273; x=1685267273;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IbPptrjbKEw99HUtcQHahvD4+muIGS8TpgJoCAfxg6E=;
 b=P0ZWFJ6F1zknX7Sr4hl6Dm7JkIXHkNU8fJ37Ko655WrbhL0fSuzwttpfvQ3Xsq0Pil
 Q/EpmGIeyyJ80j9oq8g8k9T5fuJjnvMYF9cIOOUE82R7O6FnIZplnOZnVVo7/7Zsm2s7
 heEqCIKjnZPFNwJ1E2+/SHMCG9qz2q+jp96PGNyjjKIYsmz3FPn3QKEAcOU/REZxQS+p
 zazmW72HpirLN3jf5MdQe7i2V7oFbwX83YX4VghBnDdqwieVwqxG52//zHKt87jZEvMI
 a5S0L2/diLMH0lacjOgyy2hHRZQAdNMzynrLWN8hludH/k37FwsSq+E/bU47mIDpbqe+
 7q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682675273; x=1685267273;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IbPptrjbKEw99HUtcQHahvD4+muIGS8TpgJoCAfxg6E=;
 b=EWFLyikDLuAOi/I4mn1IfWn8vhZwVNMxelnBoE/0ZFU0IgVb4QRoLXucT7kuDYsSzs
 oHayDzls+RkB7GCdVPFWzVhfD6iIatS4SiTmyigDOsxLi/9NzNM8jlQw81A9SlTD61Hx
 6hIzBkvL5PDkxIuA/i4RKDTjUfrAgUaHactKrcyYgP4Z1PV4zmpLiCNuQpq6mlulpMNq
 9+VJoaidR9KcGDDxzrHGBSwZnSeOCR95i4fwQTpGW+6ZVDht1BmXBlWCJ/lsXy9eU38c
 A83EsYZuEaX5p4mnro1/4xU7Ga5XnioCaVPEqxEWw4K4UxxJmtsP71/xJqheOmNY06ce
 d16A==
X-Gm-Message-State: AC+VfDy6bMieJrqeeiD73y3E9g+ZYjHc3WfUGz+UsaLZLGaoBYDl2vnl
 xYd/5hl5UFwcSqG3rEDL18qKyEemVoIZ+C9oLQ4wCtzEcKI=
X-Google-Smtp-Source: ACHHUZ7fcLHleJa1vrutWkOH0PO3A2BOwLdVViChilkw9/+JLMD12DMHmJUjX/o7/qn9FLcN0nVP5Dzn1sV2ZsV/mwg=
X-Received: by 2002:a17:906:ef0d:b0:94b:d57e:9d4e with SMTP id
 f13-20020a170906ef0d00b0094bd57e9d4emr4266572ejs.3.1682675273302; Fri, 28 Apr
 2023 02:47:53 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 28 Apr 2023 05:47:17 -0400
Message-ID: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
Subject: drm/amd/display: disable display DCC with retiling due to worse power
 consumption
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="000000000000f0d59c05fa625d64"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000f0d59c05fa625d64
Content-Type: multipart/alternative; boundary="000000000000f0d59a05fa625d62"

--000000000000f0d59a05fa625d62
Content-Type: text/plain; charset="UTF-8"

Hi,

It's attached for review.

Thanks,
Marek

--000000000000f0d59a05fa625d62
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Hi,</div><div><br></div><div>It&#39;s attached for review.<br></div><div><br></div><div>Thanks,<br></div><div>Marek<br></div></div>

--000000000000f0d59a05fa625d62--

--000000000000f0d59c05fa625d64
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amd-display-disable-display-DCC-with-retiling-du.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-disable-display-DCC-with-retiling-du.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lh0dct740>
X-Attachment-Id: f_lh0dct740

RnJvbSA1YzA2OGUwMGE5ZjI4NjY1N2ExYTUzNmJhNTE3ZDVhNzZiY2YzODhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogRnJpLCAyOCBBcHIgMjAyMyAwNTo0MTo1MiAtMDQw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogZGlzYWJsZSBkaXNwbGF5IERDQyB3
aXRoIHJldGlsaW5nIGR1ZSB0bwogd29yc2UgcG93ZXIgY29uc3VtcHRpb24KTUlNRS1WZXJzaW9u
OiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJh
bnNmZXItRW5jb2Rpbmc6IDhiaXQKClNpZ25lZC1vZmYtYnk6IE1hcmVrIE9sxaHDoWsgPG1hcmVr
Lm9sc2FrQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG1fcGxhbmUuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbV9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fcGxhbmUuYwppbmRleCAzMjI2Njg5NzM3NDcuLjI2MDYwN2M4MWQ3YyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1fcGxhbmUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9wbGFuZS5jCkBAIC0xMzYsNiArMTM2LDE0IEBAIHZvaWQgYW1kZ3B1X2RtX3BsYW5l
X2ZpbGxfYmxlbmRpbmdfZnJvbV9wbGFuZV9zdGF0ZShjb25zdCBzdHJ1Y3QgZHJtX3BsYW5lX3N0
YXRlCiAKIHN0YXRpYyB2b2lkIGFkZF9tb2RpZmllcih1aW50NjRfdCAqKm1vZHMsIHVpbnQ2NF90
ICpzaXplLCB1aW50NjRfdCAqY2FwLCB1aW50NjRfdCBtb2QpCiB7CisJLyogRGlzcGxheWFibGUg
RENDIHdpdGggcmV0aWxpbmcgaXMga25vd24gdG8gaW5jcmVhc2UgcG93ZXIgY29uc3VtcHRpb24K
KwkgKiBvbiBHRlggMTAuMy43LiBEaXNhYmxlIGl0IG9uIGFsbCBjaGlwcyB1bnRpbCB3ZSBoYXZl
IGV2aWRlbmNlIHRoYXQKKwkgKiBpdCBkb2Vzbid0IHJlZ3Jlc3MgcG93ZXIgY29uc3VtcHRpb24u
IFRoaXMgZWZmZWN0aXZlbHkgZGlzYWJsZXMKKwkgKiBkaXNwbGF5YWJsZSBEQ0Mgb24gZXZlcnl0
aGluZyBleGNlcHQgUmF2ZW4yLgorCSAqLworCWlmIChBTURHUFVfRk1UX01PRF9HRVQoRENDX1JF
VElMRSwgbW9kKSkKKwkJcmV0dXJuOworCiAJaWYgKCEqbW9kcykKIAkJcmV0dXJuOwogCi0tIAoy
LjI1LjEKCg==
--000000000000f0d59c05fa625d64--
