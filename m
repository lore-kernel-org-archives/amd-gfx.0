Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63024C282DE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2AF10EBB9;
	Fri,  7 Mar 2025 15:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZWVtNUfZ";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17BF10EBB9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:01:03 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-72a0cd5d622so232069a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741359663; x=1741964463; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VID+CLQoelZvnJbu32xRCHX4r7b45EecFeUyMd3/9Es=;
 b=ZWVtNUfZ2fPVfKJ+hrDYTkdvNwjGr29qOp5cueIgnzJ8hrcq1b5s+2+rYin16LrJJk
 Rhh8tcXRYvjSGYNTWSnJNIyLa5XCmqpAgco7Rl8abTzVfWFzIPwuaMhoIpH0drgYHFvS
 427SWfjpCqywzQb8OFhURVBgqoChGyPqfjwaCJ6hVwHV6le2+mzDm7WajkW/osNFWPuM
 umZNx+tgco09XWNydNudZEnpS6is31zEpCl3zGcfTvU383DubAlwRqAeMQ0KshHWBBAN
 72+cJytupwn8qPNXSaFclcWx5yY73kpanuTFqJKRSxhA9HxTN5a0j5KQxx0RgJTLZhEI
 d6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741359663; x=1741964463;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VID+CLQoelZvnJbu32xRCHX4r7b45EecFeUyMd3/9Es=;
 b=cmcnFE5i5QZ9BM/5bG8dJzedoJfxGKg2E3LgAUrt7EkVd/JbdeJQk5lrz42NilouR+
 AKglgdcUmjdCSUqnurQsbSqlDGx25ai5p4noRBtJ2hJu48gDrXzuCiXSesJHLVUujlux
 vLXBCVuGpLKr7cVCkBZwaMj3nEyyPZ9kvhSKMpgCHeO6cJRNWmeQPGTx4rJL//Ghybgs
 ZELkBQOGVaRUOp64d3Dg0qGAlP5b1tcM9wcwtOHUPsr25QT0fgXMkKhGeNF39wODcYJQ
 fn7d3jJYz95C65P/0r1v8hGcqHjFyMlbINTOBlVocHLVVKqkxb1NYZtnbSOKx2OLNsnA
 HsnA==
X-Gm-Message-State: AOJu0YzQIH4gsyPJGUpN1nwi08bovdP/La6SPGo+e7u62qDuRu5Xjh81
 iahd6vWe4/nCuYjRhN6uGrDZL1Xy74FOVLNL7eknPzA2BTRndFwtG3NimW7oePzJxJLVL6OAOUB
 nVc8WUeeMwLgm1+Usq1sNA1D18TRwh9ty
X-Gm-Gg: ASbGncvUL9kMyzdhex3rspmbB/JjhvpIebdbRfR4WEf4UNl0yI09bRtMtNJlKOWlgFP
 jZLcfU0t11BdpJxArbdOfe63Tz7Z6Yvp5bWfsm0RpgPTE9qbxAArPqCi3FWkooG+J9RqaEvkQmp
 HZwwhy0sCGDKXJNyUHwiZLer+KVss=
X-Google-Smtp-Source: AGHT+IHwxAeDQqdngfHDBIxyEg0gw4GlGo8YvF1lXXlZ63athiu1ausPWe/wRkFeoNhgVFgMUMYEGs+9DNZpzufolWM=
X-Received: by 2002:a05:6830:6e14:b0:727:3bd1:7b96 with SMTP id
 46e09a7af769-72a3a92073emr539036a34.5.1741359662637; Fri, 07 Mar 2025
 07:01:02 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 7 Mar 2025 10:00:25 -0500
X-Gm-Features: AQ5f1Jq2RIrHN6eLF4RDSqTRxKaIewFXF2BrfvGU53-OekZa1XrHA-1VgX0WtAI
Message-ID: <CAAxE2A5D6Mrd7HSmG778N=ps+o3Cg85XEBCQuKhu+cpQcrVEFQ@mail.gmail.com>
Subject: [PATCH] drm/amd/display: allow 256B DCC max compressed block sizes on
 gfx12
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="0000000000001e4647062fc1e40c"
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

--0000000000001e4647062fc1e40c
Content-Type: multipart/alternative; boundary="0000000000001e4646062fc1e40a"

--0000000000001e4646062fc1e40a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The hw supports it.

Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--0000000000001e4646062fc1e40a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The hw supports it.<br><br>Signed-off-by: Marek Ol=C5=A1=
=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.com">marek.olsak@amd.com</a>&=
gt;<br>---<br>=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>=C2=A0drivers/gpu/drm/=
amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-<br>=C2=A02 files changed, 3 =
insertions(+), 2 deletions(-)</div>

--0000000000001e4646062fc1e40a--

--0000000000001e4647062fc1e40c
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amd-display-allow-256B-DCC-max-compressed-block-.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-allow-256B-DCC-max-compressed-block-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7ywikm40>
X-Attachment-Id: f_m7ywikm40

RnJvbSAwMmY4OWMxMWRjYTY5YzY1NTVmOGJhZDc1Yzg0YjUwMTI2YzUzNTU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogRnJpLCA3IE1hciAyMDI1IDA5OjU3OjQ1IC0wNTAw
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBhbGxvdyAyNTZCIERDQyBtYXggY29t
cHJlc3NlZCBibG9jayBzaXplcyBvbgogZ2Z4MTIKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1U
eXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6
IDhiaXQKClRoZSBodyBzdXBwb3J0cyBpdC4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIE9sxaHDoWsg
PG1hcmVrLm9sc2FrQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jICAgICAgICAgICAgICAgICB8IDMgKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wbGFuZS5jIHwgMiArLQogMiBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jCmluZGV4IGIxNjFkYWE5MDAxOTguLmY2ZjhlMGIwNTBiNGQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTEyNCw5ICsxMjQsMTAgQEAK
ICAqIC0gMy42MC4wIC0gQWRkIEFNREdQVV9USUxJTkdfR0ZYMTJfRENDX1dSSVRFX0NPTVBSRVNT
X0RJU0FCTEUgKFZ1bGthbiByZXF1aXJlbWVudCkKICAqIC0gMy42MS4wIC0gQ29udGFpbnMgZml4
IGZvciBSVi9QQ08gY29tcHV0ZSBxdWV1ZXMKICAqIC0gMy42Mi4wIC0gQWRkIEFNREdQVV9JRFNf
RkxBR1NfTU9ERV9QRiwgQU1ER1BVX0lEU19GTEFHU19NT0RFX1ZGICYgQU1ER1BVX0lEU19GTEFH
U19NT0RFX1BUCisgKiAtIDMuNjMuMCAtIEdGWDEyIGRpc3BsYXkgRENDIHN1cHBvcnRzIDI1NkIg
bWF4IGNvbXByZXNzZWQgYmxvY2sgc2l6ZQogICovCiAjZGVmaW5lIEtNU19EUklWRVJfTUFKT1IJ
MwotI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTYyCisjZGVmaW5lIEtNU19EUklWRVJfTUlOT1IJ
NjMKICNkZWZpbmUgS01TX0RSSVZFUl9QQVRDSExFVkVMCTAKIAogLyoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BsYW5lLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wbGFuZS5jCmlu
ZGV4IGRjZjJiOTg1NjZlYWEuLjMzMDBhYjE2NTdkZDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BsYW5lLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcGxhbmUuYwpAQCAtNjk3
LDcgKzY5Nyw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9wbGFuZV9hZGRfZ2Z4MTJfbW9kaWZp
ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXVpbnQ2NF90IG1vZF80ayA9IHZlciB8
IEFNRF9GTVRfTU9EX1NFVChUSUxFLCBBTURfRk1UX01PRF9USUxFX0dGWDEyXzRLXzJEKTsKIAl1
aW50NjRfdCBtb2RfMjU2YiA9IHZlciB8IEFNRF9GTVRfTU9EX1NFVChUSUxFLCBBTURfRk1UX01P
RF9USUxFX0dGWDEyXzI1NkJfMkQpOwogCXVpbnQ2NF90IGRjYyA9IHZlciB8IEFNRF9GTVRfTU9E
X1NFVChEQ0MsIDEpOwotCXVpbnQ4X3QgbWF4X2NvbXBfYmxvY2tbXSA9IHsxLCAwfTsKKwl1aW50
OF90IG1heF9jb21wX2Jsb2NrW10gPSB7MiwgMSwgMH07CiAJdWludDY0X3QgbWF4X2NvbXBfYmxv
Y2tfbW9kW0FSUkFZX1NJWkUobWF4X2NvbXBfYmxvY2spXSA9IHswfTsKIAl1aW50OF90IGkgPSAw
LCBqID0gMDsKIAl1aW50NjRfdCBnZngxMl9tb2RpZmllcnNbXSA9IHttb2RfMjU2aywgbW9kXzY0
aywgbW9kXzRrLCBtb2RfMjU2YiwgRFJNX0ZPUk1BVF9NT0RfTElORUFSfTsKLS0gCjIuNDMuMAoK
--0000000000001e4647062fc1e40c--
