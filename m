Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A6C2BB1D
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 01:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121A20771
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 01:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDFue9IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6261E6EC51;
	Sat, 18 Apr 2020 01:07:19 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2FA6EC51
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2020 01:07:18 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id u65so1886859pfb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Na6hzXMcUO4mC8YWzqRQdBN4vB0f91VKDXckzy2UUs8=;
 b=sDFue9ITE5MpHdwSvT1AvTlf94omVQi+v+3n8upYfNYEnRW6xXIDtCauKxKlUNDsei
 6l9m3RuQuwpawcCnxKyYuiegemGgiYJsmB8pWEYrz2hAaTwa7vG1uWVK1XEMsfYkDDef
 3DLlte3dD97O74AutbGrFCcZ7KSBGp78h2ktYXprkqRNUv9SGZa6oivZQgeVDeYEZQ5+
 dPYuChDxyftGjYb3IuYSoOSZMcDSrPdGz4xIMYbQfMNMg5b2YMOXFY6cXyPkVqVItlrq
 2VJk0lLUNOaNVwJwiQ0WE2PcfdZO3nTim016I+LetMaq5qOCaHFqeoasUCeUkPtGBvEM
 gsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Na6hzXMcUO4mC8YWzqRQdBN4vB0f91VKDXckzy2UUs8=;
 b=rTAzPXl8RlBwxY/RYkecLa21bePuYTzMormo6lTaDvjD7PF3CeB8b9V8ssbWwhYVAo
 BZNf9rQ6bJG3D+u83OUoYRvYGDY/izAfK9qGKc68GekQGEwMpXd60+EQvnOlyyvgUhK1
 4vY07XkGt72zOHj3wHbCDWsug3Scz+bQV6kC6qNdTkwlJ03pb1Cl2o4eFX3Ef/4pq5N5
 vr3Qb/9okg1buO6Z40NhhK+vqfvkZtmtBpE2D+PeITYbrfoR8CeQsqwOcDcVx3Hwinij
 IAFIm4tgeihwtLV9Oux2JMNJ1/e4y7U2U0JANU0tUgNwOLkKq8p3qMvYo5FTwEu9gQC2
 MQxA==
X-Gm-Message-State: AGi0PuZJjeFFrWZK17aWM7geLqs5d+VqBYOKejnilIwEsU1QhF/6rXm/
 ZG1GC/gmU+pgBKDjNIfx5gmRSoatveEdmAk8lK2WWyoR
X-Google-Smtp-Source: APiQypJxmLs6A7mijU/1tXVLG8Y5+erpdcs+iwmKowyuWIyOq+ZuCrfgPygVN3zLg7qSMfXxD94E0DDFzrUR3ZcO6YU=
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr5655013pgm.233.1587172036523; 
 Fri, 17 Apr 2020 18:07:16 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 17 Apr 2020 21:06:40 -0400
Message-ID: <CAAxE2A4YRokWUdNBhy_Tse4W51waGmrgjvs86XdZ0MNibXe+xw@mail.gmail.com>
Subject: drm/amdgpu: add tiling flags from Mesa
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="0000000000006ffce305a38649bc"
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

--0000000000006ffce305a38649bc
Content-Type: multipart/alternative; boundary="0000000000006ffcde05a38649ba"

--0000000000006ffcde05a38649ba
Content-Type: text/plain; charset="UTF-8"

Hi,

This is needed for displayable DCC on gfx10. Mesa will add the first flag
soon or after DAL starts using it on gfx10.

Please review.

Thanks,
Marek

--0000000000006ffcde05a38649ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>This is needed for displ=
ayable DCC on gfx10. Mesa will add the first flag soon or after DAL starts =
using it on gfx10.<br></div><div><br></div><div>Please review.</div><div><b=
r></div><div>Thanks,</div><div>Marek<br></div></div>

--0000000000006ffcde05a38649ba--

--0000000000006ffce305a38649bc
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-add-tiling-flags-from-Mesa.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-add-tiling-flags-from-Mesa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k94x5r450>
X-Attachment-Id: f_k94x5r450

RnJvbSBiMDg5NmIyZGFjNjVjZTA4ZWU4YmZhMzE2MWIyOGNmYzgxM2IzYTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogRnJpLCAxNyBBcHIgMjAyMCAyMDo1MDozMCAtMDQw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCB0aWxpbmcgZmxhZ3MgZnJvbSBNZXNh
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpEQ0NfSU5ERVBFTkRFTlRfMTI4QiBp
cyBuZWVkZWQgZm9yIGRpc3BsYXlibGUgRENDIG9uIGdmeDEwLgpTQ0FOT1VUIGlzIG5vdCBuZWVk
ZWQgYnkgdGhlIGtlcm5lbCwgYnV0IE1lc2EgdXNlcyBpdC4KClNpZ25lZC1vZmYtYnk6IE1hcmVr
IE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5jb20+Ci0tLQogaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmggfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oCmluZGV4IDVmN2E0ZjUzZTVmMi4uNzA3MmIyNGFhOWUyIDEwMDY0NAotLS0g
YS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaApAQCAtMzU0LDYgKzM1NCwxMCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdXNl
cnB0ciB7CiAjZGVmaW5lIEFNREdQVV9USUxJTkdfRENDX1BJVENIX01BWF9NQVNLCQkweDNGRkYK
ICNkZWZpbmUgQU1ER1BVX1RJTElOR19EQ0NfSU5ERVBFTkRFTlRfNjRCX1NISUZUCQk0MwogI2Rl
ZmluZSBBTURHUFVfVElMSU5HX0RDQ19JTkRFUEVOREVOVF82NEJfTUFTSwkJMHgxCisjZGVmaW5l
IEFNREdQVV9USUxJTkdfRENDX0lOREVQRU5ERU5UXzEyOEJfU0hJRlQJNDQKKyNkZWZpbmUgQU1E
R1BVX1RJTElOR19EQ0NfSU5ERVBFTkRFTlRfMTI4Ql9NQVNLCQkweDEKKyNkZWZpbmUgQU1ER1BV
X1RJTElOR19TQ0FOT1VUX1NISUZUCQkJNjMKKyNkZWZpbmUgQU1ER1BVX1RJTElOR19TQ0FOT1VU
X01BU0sJCQkweDEKIAogLyogU2V0L0dldCBoZWxwZXJzIGZvciB0aWxpbmcgZmxhZ3MuICovCiAj
ZGVmaW5lIEFNREdQVV9USUxJTkdfU0VUKGZpZWxkLCB2YWx1ZSkgXAotLSAKMi4xNy4xCgo=
--0000000000006ffce305a38649bc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000006ffce305a38649bc--
