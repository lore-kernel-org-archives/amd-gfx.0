Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3217CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Dec 2022 22:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F61F10E0F6;
	Fri, 30 Dec 2022 22:07:54 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9193010E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Dec 2022 22:07:51 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id fc4so53686011ejc.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Dec 2022 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Tf9wHz9LIX7DhchpdK3x/gnSm+Z1o3ftUsHqNbpCsp8=;
 b=WcPQsvx8ad43srUWQEAE+kF7FH6rlnOmrzSTEWDaQnIdYvBmuSFc8kEYy1oRFoYMpT
 fSvtroPWjHMkFgMF2F1I0bxqonItxJzejUcYL6fZxvL6lwdOlYz1BT2xLsk0UiJktSmZ
 DoBZTFRkcOMJ8xgHV0MN8Azuqw8HN/GhBabFg7I6xxVR0v046ulQptPBRx97Nhz3HFFg
 HKY+F3G7HpqCzZCa6030h6nOsfaX7TafBY2mzZ+gTUaMcW4psIrKYNCAU43gNBGXNiez
 QLh2AnN98wIPwGAAEUTzE1eaSzTPOkJiWBYaaLeoZzTorqWp/fyPUtuZbkeo8tSiTM0V
 Q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tf9wHz9LIX7DhchpdK3x/gnSm+Z1o3ftUsHqNbpCsp8=;
 b=8QDEDqinUwGCidZ8tQKmGHUzovIpj8qJKFWvdHOigS5hMHn+05AxWParKIMKncNDqB
 MUXbVL4nYo35CM/JX8Z1Z/wVjvjuA2O0Xnj9N7BB7HbKVrDfmuX6xFyr0ttSPiiUEEL1
 Gs8CnkkwUAEHc8J2M5J23MPDqqmbwsaEji6vekq/pKjlLXklPg8Ddr+OjPmTRIfCZKdA
 3rXX58+38pSU2xfrqP7PON4Rb1zvlu4M4fSxidEnyATIUUbqjKv9BJRiqUI68qFqDFTq
 jW9tzNYoj3mawEyMOuXUpqCHr9PfYyoyt1+GzuDlsc8ybt5ylOjXjrR0dFGOyVQAGY93
 omYQ==
X-Gm-Message-State: AFqh2kok7PZeYDztEKhnWZ62gxej23hX8IWtVgfypuKJkb130KmhJzn2
 Fq2c+zAko02ZJOpjIwG9SY/inVWMZTAi1UfytiGnAKa5rUY=
X-Google-Smtp-Source: AMrXdXuCWzD/G6tYHa201QEF59dgODG13fF1XMjR9Eppaic7CgurifMKqCt68H8NleTPnUXDIB/mbz+Yqtx658y+NFg=
X-Received: by 2002:a17:906:40cf:b0:7c1:ff6:615b with SMTP id
 a15-20020a17090640cf00b007c10ff6615bmr1877389ejk.118.1672438069636; Fri, 30
 Dec 2022 14:07:49 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 30 Dec 2022 17:07:13 -0500
Message-ID: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
Subject: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the INFO
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="0000000000000cfadb05f112d5f7"
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

--0000000000000cfadb05f112d5f7
Content-Type: multipart/alternative; boundary="0000000000000cfad805f112d5f5"

--0000000000000cfad805f112d5f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For computing PCIe bandwidth in userspace and troubleshooting PCIe
bandwidth issues.

For example, my Navi21 has been limited to PCIe gen 1 and this is
the first time I noticed it after 2 years.

Note that this intentionally fills a hole and padding
in drm_amdgpu_info_device.

Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

The patch is attached.

Marek

--0000000000000cfad805f112d5f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For computing PCIe bandwidth in userspace and troubleshoot=
ing PCIe<br>bandwidth issues.<br><br>For example, my Navi21 has been limite=
d to PCIe gen 1 and this is<br>the first time I noticed it after 2 years.<b=
r><br>Note that this intentionally fills a hole and padding<br>in drm_amdgp=
u_info_device.<br><br><div>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:marek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><div><br><=
/div><div>The patch is attached.</div><div><br></div><div>Marek<br></div><b=
r></div>

--0000000000000cfad805f112d5f5--

--0000000000000cfadb05f112d5f7
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-return-the-PCIe-gen-and-lanes-from-the-IN.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-return-the-PCIe-gen-and-lanes-from-the-IN.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lcb2e0850>
X-Attachment-Id: f_lcb2e0850

RnJvbSA1YzVmNWI3MDczMjdiMDMwYTIyODI3Nzc3NGYwZjljOWQyNGIwNzg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogU2F0LCAyNCBEZWMgMjAyMiAxNzo0NDoyNiAtMDUw
MApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiByZXR1cm4gdGhlIFBDSWUgZ2VuIGFu
ZCBsYW5lcyBmcm9tIHRoZSBJTkZPCiBpb2N0bApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKRm9yIGNvbXB1dGluZyBQQ0llIGJhbmR3aWR0aCBpbiB1c2Vyc3BhY2UgYW5kIHRyb3Vi
bGVzaG9vdGluZyBQQ0llCmJhbmR3aWR0aCBpc3N1ZXMuCgpGb3IgZXhhbXBsZSwgbXkgTmF2aTIx
IGhhcyBiZWVuIGxpbWl0ZWQgdG8gUENJZSBnZW4gMSBhbmQgdGhpcyBpcwp0aGUgZmlyc3QgdGlt
ZSBJIG5vdGljZWQgaXQgYWZ0ZXIgMiB5ZWFycy4KCk5vdGUgdGhhdCB0aGlzIGludGVudGlvbmFs
bHkgZmlsbHMgYSBob2xlIGFuZCBwYWRkaW5nCmluIGRybV9hbWRncHVfaW5mb19kZXZpY2UuCgpT
aWduZWQtb2ZmLWJ5OiBNYXJlayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICAzICsrLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMTQgKysrKysrKysrKysrKy0KIGluY2x1
ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oICAgICAgICAgICB8ICAzICsrLQogMyBmaWxlcyBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCBiOGNmYTQ4ZmIyOTYuLjE1NWY5MDViMDBjOSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTA3LDkgKzEwNywxMCBA
QAogICogLSAzLjQ5LjAgLSBBZGQgZ2FuZyBzdWJtaXQgaW50byBDUyBJT0NUTAogICogLSAzLjUw
LjAgLSBVcGRhdGUgQU1ER1BVX0lORk9fREVWX0lORk8gSU9DVEwgZm9yIG1pbmltdW0gZW5naW5l
IGFuZCBtZW1vcnkgY2xvY2sKICAqICAgICAgICAgICAgVXBkYXRlIEFNREdQVV9JTkZPX1NFTlNP
UiBJT0NUTCBmb3IgUEVBS19QU1RBVEUgZW5naW5lIGFuZCBtZW1vcnkgY2xvY2sKKyAqICAgMy41
MS4wIC0gUmV0dXJuIHRoZSBQQ0llIGdlbiBhbmQgbGFuZXMgZnJvbSB0aGUgSU5GTyBpb2N0bAog
ICovCiAjZGVmaW5lIEtNU19EUklWRVJfTUFKT1IJMwotI2RlZmluZSBLTVNfRFJJVkVSX01JTk9S
CTUwCisjZGVmaW5lIEtNU19EUklWRVJfTUlOT1IJNTEKICNkZWZpbmUgS01TX0RSSVZFUl9QQVRD
SExFVkVMCTAKIAogdW5zaWduZWQgaW50IGFtZGdwdV92cmFtX2xpbWl0ID0gVUlOVF9NQVg7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggOTAzZTg3NzBlMjc1Li5m
YmEzMDZlMGVmODcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAg
LTQyLDYgKzQyLDcgQEAKICNpbmNsdWRlICJhbWRncHVfZ2VtLmgiCiAjaW5jbHVkZSAiYW1kZ3B1
X2Rpc3BsYXkuaCIKICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCisjaW5jbHVkZSAiYW1kX3BjaWUu
aCIKIAogdm9pZCBhbWRncHVfdW5yZWdpc3Rlcl9ncHVfaW5zdGFuY2Uoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiB7CkBAIC03NjYsNiArNzY3LDcgQEAgaW50IGFtZGdwdV9pbmZvX2lvY3Rs
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZSAqZmls
cCkKIAljYXNlIEFNREdQVV9JTkZPX0RFVl9JTkZPOiB7CiAJCXN0cnVjdCBkcm1fYW1kZ3B1X2lu
Zm9fZGV2aWNlICpkZXZfaW5mbzsKIAkJdWludDY0X3Qgdm1fc2l6ZTsKKwkJdWludDMyX3QgcGNp
ZV9nZW5fbWFzazsKIAkJaW50IHJldDsKIAogCQlkZXZfaW5mbyA9IGt6YWxsb2Moc2l6ZW9mKCpk
ZXZfaW5mbyksIEdGUF9LRVJORUwpOwpAQCAtNzk4LDcgKzgwMCw2IEBAIGludCBhbWRncHVfaW5m
b19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2Zp
bGUgKmZpbHApCiAJCWRldl9pbmZvLT5udW1fcmJfcGlwZXMgPSBhZGV2LT5nZnguY29uZmlnLm1h
eF9iYWNrZW5kc19wZXJfc2UgKgogCQkJYWRldi0+Z2Z4LmNvbmZpZy5tYXhfc2hhZGVyX2VuZ2lu
ZXM7CiAJCWRldl9pbmZvLT5udW1faHdfZ2Z4X2NvbnRleHRzID0gYWRldi0+Z2Z4LmNvbmZpZy5t
YXhfaHdfY29udGV4dHM7Ci0JCWRldl9pbmZvLT5fcGFkID0gMDsKIAkJZGV2X2luZm8tPmlkc19m
bGFncyA9IDA7CiAJCWlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCiAJCQlkZXZfaW5mby0+
aWRzX2ZsYWdzIHw9IEFNREdQVV9JRFNfRkxBR1NfRlVTSU9OOwpAQCAtODUyLDYgKzg1MywxNyBA
QCBpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0
YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQogCiAJCWRldl9pbmZvLT50Y2NfZGlzYWJsZWRfbWFz
ayA9IGFkZXYtPmdmeC5jb25maWcudGNjX2Rpc2FibGVkX21hc2s7CiAKKwkJLyogQ29tYmluZSB0
aGUgY2hpcCBnZW4gbWFzayB3aXRoIHRoZSBwbGF0Zm9ybSAoQ1BVL21vYm8pIG1hc2suICovCisJ
CXBjaWVfZ2VuX21hc2sgPSBhZGV2LT5wbS5wY2llX2dlbl9tYXNrICYgKGFkZXYtPnBtLnBjaWVf
Z2VuX21hc2sgPj4gMTYpOworCQlkZXZfaW5mby0+cGNpZV9nZW4gPSBmbHMocGNpZV9nZW5fbWFz
ayk7CisJCWRldl9pbmZvLT5wY2llX251bV9sYW5lcyA9CisJCQlhZGV2LT5wbS5wY2llX21sd19t
YXNrICYgQ0FJTF9QQ0lFX0xJTktfV0lEVEhfU1VQUE9SVF9YMzIgPyAzMiA6CisJCQlhZGV2LT5w
bS5wY2llX21sd19tYXNrICYgQ0FJTF9QQ0lFX0xJTktfV0lEVEhfU1VQUE9SVF9YMTYgPyAxNiA6
CisJCQlhZGV2LT5wbS5wY2llX21sd19tYXNrICYgQ0FJTF9QQ0lFX0xJTktfV0lEVEhfU1VQUE9S
VF9YMTIgPyAxMiA6CisJCQlhZGV2LT5wbS5wY2llX21sd19tYXNrICYgQ0FJTF9QQ0lFX0xJTktf
V0lEVEhfU1VQUE9SVF9YOCA/IDggOgorCQkJYWRldi0+cG0ucGNpZV9tbHdfbWFzayAmIENBSUxf
UENJRV9MSU5LX1dJRFRIX1NVUFBPUlRfWDQgPyA0IDoKKwkJCWFkZXYtPnBtLnBjaWVfbWx3X21h
c2sgJiBDQUlMX1BDSUVfTElOS19XSURUSF9TVVBQT1JUX1gyID8gMiA6IDE7CisKIAkJcmV0ID0g
Y29weV90b191c2VyKG91dCwgZGV2X2luZm8sCiAJCQkJICAgbWluKChzaXplX3Qpc2l6ZSwgc2l6
ZW9mKCpkZXZfaW5mbykpKSA/IC1FRkFVTFQgOiAwOwogCQlrZnJlZShkZXZfaW5mbyk7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oCmluZGV4IGZlN2Y4NzFlMzA4MC4uZjdmYzczMjVmMTdmIDEwMDY0NAotLS0g
YS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaApAQCAtMTA1Myw3ICsxMDUzLDcgQEAgc3RydWN0IGRybV9hbWRncHVfaW5mb19k
ZXZpY2UgewogCV9fdTMyIGVuYWJsZWRfcmJfcGlwZXNfbWFzazsKIAlfX3UzMiBudW1fcmJfcGlw
ZXM7CiAJX191MzIgbnVtX2h3X2dmeF9jb250ZXh0czsKLQlfX3UzMiBfcGFkOworCV9fdTMyIHBj
aWVfZ2VuOwogCV9fdTY0IGlkc19mbGFnczsKIAkvKiogU3RhcnRpbmcgdmlydHVhbCBhZGRyZXNz
IGZvciBVTURzLiAqLwogCV9fdTY0IHZpcnR1YWxfYWRkcmVzc19vZmZzZXQ7CkBAIC0xMTA5LDYg
KzExMDksNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2RldmljZSB7CiAJX191NjQgaGlnaF92
YV9tYXg7CiAJLyogZ2Z4MTAgcGFfc2NfdGlsZV9zdGVlcmluZ19vdmVycmlkZSAqLwogCV9fdTMy
IHBhX3NjX3RpbGVfc3RlZXJpbmdfb3ZlcnJpZGU7CisJX191MzIgcGNpZV9udW1fbGFuZXM7CiAJ
LyogZGlzYWJsZWQgVENDcyAqLwogCV9fdTY0IHRjY19kaXNhYmxlZF9tYXNrOwogCV9fdTY0IG1p
bl9lbmdpbmVfY2xvY2s7Ci0tIAoyLjI1LjEKCg==
--0000000000000cfadb05f112d5f7--
