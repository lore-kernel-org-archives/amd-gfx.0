Return-Path: <SRS0=G9GP=6J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6FC55185
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 08:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1504720700
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 08:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXhmWcF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1504720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA336E1CE;
	Sat, 25 Apr 2020 08:52:40 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99B96E1CE
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 08:52:39 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id n16so5830369pgb.7
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ctlPDgj24GiDAIvWdR6uHDcUEbowURBX809f9wr5nas=;
 b=sXhmWcF9bCTZsy7QBBMdYlm3SJ3cFAmZF4C6X5Tbv+L++JwrnpO2KDpvG7lmQftd6f
 PpXy3iSy6fP6ZSK7eQgPlfRlzGiePDdbBFsK5wjcWROPwGy61eGm42d8lwdZdXlv2weh
 0uV38us+AFvdN2GI5JOO39PFFwr8gZo/V29hstJa/G6Vgnn6b9lyY0LzoepJ/J54z6n0
 nBOVjB6bn6H3swsxnWUYPxhpuXQU0rFDc1b4t0j+/PbjvXfJlgJgovkPMhti72y5nmvb
 x9pSa7aF7Gy9xP/Nua+rrNpUQAiWuayrpNFJ/6/qyNKHqRvWmj/cMG3MJiZb/FOnbO+I
 6ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ctlPDgj24GiDAIvWdR6uHDcUEbowURBX809f9wr5nas=;
 b=nYwaL5JasmpgMAmCbN8es8XxbRqGw+Dp5dNAGiNWzk+DcoWDPnwblcIaUAmaRvMY8J
 8qYihnEUt2AFWwD43BrZDM9FmflItMQyjjfmDRy5ik/qmRT+rJuvYj8v3vjaP8DtyxvK
 hPVbh2NJt9APXxlUx3NTh9dkrdfc2vuNU5WJm8FhECJg0XfIs23mTC1immst1szAD9bZ
 COw4bR85Mx+1WkyJBxg54zx0xsrEDGbNYTcesddL8H/xVlPp4RxAvZ04hTFeHEPfIgfJ
 /OXaoRHqUX6E6o0Xkncni660kRZeiVa+deL2xRaTtOsLx5Lux9QCw4tKdlKHbdmtsxEJ
 a7gw==
X-Gm-Message-State: AGi0PuYk3jXhQVYQjeRu6jXGoeP+Ct9y38CxPvvZJnWYTLqCFRc/8WTI
 IjAIficu8HP1aVUlNHCIidu7fq0Vmdha2TsJ4+6n5t+u
X-Google-Smtp-Source: APiQypLRyJiwD32BBlA7LPO23HeHoiNZRQ2xBeuGb7Dxy2u09G9h6Tqf+aIAW0NBrIVT2S63sW9vlVIL0vVaOAYPJ30=
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr13177903pgm.233.1587804759082; 
 Sat, 25 Apr 2020 01:52:39 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 25 Apr 2020 04:52:02 -0400
Message-ID: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
Subject: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="000000000000a3636b05a4199a4c"
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

--000000000000a3636b05a4199a4c
Content-Type: multipart/alternative; boundary="000000000000a3636805a4199a4a"

--000000000000a3636805a4199a4a
Content-Type: text/plain; charset="UTF-8"

This should fix SDMA hangs on gfx10.

Marek

--000000000000a3636805a4199a4a
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>This should fix SDMA hangs on gfx10.<br></div><div><br></div><div></div><div></div><div>Marek<br></div></div>

--000000000000a3636805a4199a4a--

--000000000000a3636b05a4199a4c
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-invalidate-L2-before-SDMA-IBs.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-invalidate-L2-before-SDMA-IBs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k9fdvw780>
X-Attachment-Id: f_k9fdvw780

RnJvbSA0Nzg2NzFmNTc3NTUxZjA2YjY4ZTI1NjRhMjBiZGZiNjE4MDZhODAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogU2F0LCAyNSBBcHIgMjAyMCAwNDoyMzowMSAtMDQw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGludmFsaWRhdGUgTDIgYmVmb3JlIFNETUEg
SUJzCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1V
VEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5OiBNYXJl
ayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYyAgICAgICAgICB8ICAzICsrLQogLi4uL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYXZpMTBfc2RtYV9wa3Rfb3Blbi5oICAgIHwgMTYgKysrKysrKysrKysrKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgICAgICAgICAgIHwgMTQgKysrKysr
KysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKaW5kZXggZDM3N2M1ZDE3
YmI4Li4wMTc3ODkyZTYwOWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMKQEAgLTg2LDkgKzg2LDEwIEBACiAgKiAtIDMuMzUuMCAtIEFkZCBkcm1fYW1kZ3B1X2luZm9f
ZGV2aWNlOjp0Y2NfZGlzYWJsZWRfbWFzawogICogLSAzLjM2LjAgLSBBbGxvdyByZWFkaW5nIG1v
cmUgc3RhdHVzIHJlZ2lzdGVycyBvbiBzaS9jaWsKICAqIC0gMy4zNy4wIC0gQWRkIEFNREdQVV9J
Ql9GTEFHX0VNSVRfTUVNX1NZTkMKKyAqIC0gMy4zOC4wIC0gTDIgaXMgaW52YWxpZGF0ZWQgYmVm
b3JlIFNETUEgSUJzLCBuZWVkZWQgZm9yIGNvcnJlY3RuZXNzCiAgKi8KICNkZWZpbmUgS01TX0RS
SVZFUl9NQUpPUgkzCi0jZGVmaW5lIEtNU19EUklWRVJfTUlOT1IJMzcKKyNkZWZpbmUgS01TX0RS
SVZFUl9NSU5PUgkzOAogI2RlZmluZSBLTVNfRFJJVkVSX1BBVENITEVWRUwJMAogCiBpbnQgYW1k
Z3B1X3ZyYW1fbGltaXQgPSAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbmF2aTEwX3NkbWFfcGt0X29wZW4uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25h
dmkxMF9zZG1hX3BrdF9vcGVuLmgKaW5kZXggMDc0YTlhMDljMGE3Li5hNWI2MGM5YTI0MTggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9zZG1hX3BrdF9vcGVu
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX3NkbWFfcGt0X29wZW4u
aApAQCAtNzMsNiArNzMsMjIgQEAKICNkZWZpbmUgU0RNQV9PUF9BUUxfQ09QWSAgMAogI2RlZmlu
ZSBTRE1BX09QX0FRTF9CQVJSSUVSX09SICAwCiAKKyNkZWZpbmUgU0RNQV9HQ1JfUkFOR0VfSVNf
UEEJCSgxIDw8IDE4KQorI2RlZmluZSBTRE1BX0dDUl9TRVEoeCkJCQkoKCh4KSAmIDB4MykgPDwg
MTYpCisjZGVmaW5lIFNETUFfR0NSX0dMMl9XQgkJCSgxIDw8IDE1KQorI2RlZmluZSBTRE1BX0dD
Ul9HTDJfSU5WCQkoMSA8PCAxNCkKKyNkZWZpbmUgU0RNQV9HQ1JfR0wyX0RJU0NBUkQJCSgxIDw8
IDEzKQorI2RlZmluZSBTRE1BX0dDUl9HTDJfUkFOR0UoeCkJCSgoKHgpICYgMHgzKSA8PCAxMSkK
KyNkZWZpbmUgU0RNQV9HQ1JfR0wyX1VTCQkJKDEgPDwgMTApCisjZGVmaW5lIFNETUFfR0NSX0dM
MV9JTlYJCSgxIDw8IDkpCisjZGVmaW5lIFNETUFfR0NSX0dMVl9JTlYJCSgxIDw8IDgpCisjZGVm
aW5lIFNETUFfR0NSX0dMS19JTlYJCSgxIDw8IDcpCisjZGVmaW5lIFNETUFfR0NSX0dMS19XQgkJ
CSgxIDw8IDYpCisjZGVmaW5lIFNETUFfR0NSX0dMTV9JTlYJCSgxIDw8IDUpCisjZGVmaW5lIFNE
TUFfR0NSX0dMTV9XQgkJCSgxIDw8IDQpCisjZGVmaW5lIFNETUFfR0NSX0dMMV9SQU5HRSh4KQkJ
KCgoeCkgJiAweDMpIDw8IDIpCisjZGVmaW5lIFNETUFfR0NSX0dMSV9JTlYoeCkJCSgoKHgpICYg
MHgzKSA8PCAwKQorCiAvKmRlZmluZSBmb3Igb3AgZmllbGQqLwogI2RlZmluZSBTRE1BX1BLVF9I
RUFERVJfb3Bfb2Zmc2V0IDAKICNkZWZpbmUgU0RNQV9QS1RfSEVBREVSX29wX21hc2sgICAweDAw
MDAwMEZGCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCmluZGV4IDc2NGY0NTVh
ZGE3NS4uYjU0NGJhZjMwNmYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y1XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAu
YwpAQCAtNDEwLDYgKzQxMCwxOCBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y1XzBfcmluZ19lbWl0X2li
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIAl1bnNpZ25lZCB2bWlkID0gQU1ER1BVX0pPQl9H
RVRfVk1JRChqb2IpOwogCXVpbnQ2NF90IGNzYV9tY19hZGRyID0gYW1kZ3B1X3NkbWFfZ2V0X2Nz
YV9tY19hZGRyKHJpbmcsIHZtaWQpOwogCisJLyogSW52YWxpZGF0ZSBMMiwgYmVjYXVzZSBpZiB3
ZSBkb24ndCBkbyBpdCwgd2UgbWlnaHQgZ2V0IHN0YWxlIGNhY2hlCisJICogbGluZXMgZnJvbSBw
cmV2aW91cyBJQnMuCisJICovCisJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QS1RfSEVB
REVSX09QKFNETUFfT1BfR0NSX1JFUSkpOworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDApOwor
CWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIChTRE1BX0dDUl9HTDJfSU5WIHwKKwkJCQkgU0RNQV9H
Q1JfR0wyX1dCIHwKKwkJCQkgU0RNQV9HQ1JfR0xNX0lOViB8CisJCQkJIFNETUFfR0NSX0dMTV9X
QikgPDwgMTYpOworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDB4ZmZmZmZmODApOworCWFtZGdw
dV9yaW5nX3dyaXRlKHJpbmcsIDB4ZmZmZik7CisKIAkvKiBBbiBJQiBwYWNrZXQgbXVzdCBlbmQg
b24gYSA4IERXIGJvdW5kYXJ5LS10aGUgbmV4dCBkd29yZAogCSAqIG11c3QgYmUgb24gYSA4LWR3
b3JkIGJvdW5kYXJ5LiBPdXIgSUIgcGFja2V0IGJlbG93IGlzIDYKIAkgKiBkd29yZHMgbG9uZywg
dGh1cyBhZGQgeCBudW1iZXIgb2YgTk9Qcywgc3VjaCB0aGF0LCBpbgpAQCAtMTYzNCw3ICsxNjQ2
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBzZG1hX3Y1XzBfcmlu
Z19mdW5jcyA9IHsKIAkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fV1JFRyAqIDMgKwogCQlTT0Mx
NV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJVCAqIDYgKiAyICsKIAkJMTAgKyAxMCArIDEwLCAv
KiBzZG1hX3Y1XzBfcmluZ19lbWl0X2ZlbmNlIHgzIGZvciB1c2VyIGZlbmNlLCB2bSBmZW5jZSAq
LwotCS5lbWl0X2liX3NpemUgPSA3ICsgNiwgLyogc2RtYV92NV8wX3JpbmdfZW1pdF9pYiAqLwor
CS5lbWl0X2liX3NpemUgPSA1ICsgNyArIDYsIC8qIHNkbWFfdjVfMF9yaW5nX2VtaXRfaWIgKi8K
IAkuZW1pdF9pYiA9IHNkbWFfdjVfMF9yaW5nX2VtaXRfaWIsCiAJLmVtaXRfZmVuY2UgPSBzZG1h
X3Y1XzBfcmluZ19lbWl0X2ZlbmNlLAogCS5lbWl0X3BpcGVsaW5lX3N5bmMgPSBzZG1hX3Y1XzBf
cmluZ19lbWl0X3BpcGVsaW5lX3N5bmMsCi0tIAoyLjE3LjEKCg==
--000000000000a3636b05a4199a4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000a3636b05a4199a4c--
