Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3EFC531DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 12:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FBE10E7AA;
	Tue, 20 Aug 2024 12:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cy5ZaKV6";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFBE10E51E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 08:33:54 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso56661251fa.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724142832; x=1724747632; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5kRnByWmsKhVArjrRFDNHDxrF14nEzo7Pzp9EWl+Fwk=;
 b=cy5ZaKV6AqKBCWRkh8s5crDXchbT3F0v5LnJn/2sogNQlYFtLwxg88WIP3u1WRHCyi
 RL1hjNbSy5RiR16aouZWXWpdcriZe8hZJudD4SjwMm/CXJ/aQt1j4Ty7l4mw0eMQKfdM
 Bl0MOA02FK3iuKSaRiHawJSu7LSuUOGtn4qYDWk9LwgUuzsX24xWxuaBglkEDH7q5irf
 4xga6JaBsut4moODkRaHZgcZzY6IaHl+Ny0zSMs1bIUsCntzFEoXhLbivuqrCRz9RORy
 v4synGXnXfOqkeUf8h/VEJEFoyfhVVaBuu8F33j6nc7r5Q1QsPbF5CFE2dznhCCQUH1z
 94IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724142832; x=1724747632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5kRnByWmsKhVArjrRFDNHDxrF14nEzo7Pzp9EWl+Fwk=;
 b=HvyybSQBK2tzS78zrCvDa+XRLmcABVM97ZhumBysIL/6hYoeSrwWoCURvheKc0pphL
 Q2jS49WN2514tBIOoP9Z1/grtKOFUM00d8mXNALB0rdfPO8mCe91BJ1EP4wxiIw4QZhL
 GuThRWzrC3k4qbXrnwMKwzSyb467jx5rqhq+5SfHm8OkX23fk8YpqWcAevQUmdRs4bmD
 hnzfs0n9YQ2dMH2ID/8oIqKoYcMoqkNYGwr9vt+3Yq0SVbC90FIT3jQ6SUuM4nbs8Y7T
 o1v+jeC5fSi4NIhHweAKvf18NFf9n8BvXsxrhEV9K4lHo3BMrsg/M8IoUr7plkKBgCRB
 n6ug==
X-Gm-Message-State: AOJu0YxPIPagVMfZhObdz0rDdfD7DoLR8fsbtLskRXDcnjEY/BQJkadK
 RJuQHGOnC4wqm3eG8g4mM8ppwPjTR8da7mDFpaoMAyW8a6oUOl+ANcM6d3kqwCDcwZgLH7o0z9Q
 iyD5dHBU5YhokmpAKgLcDs9H6qMo=
X-Google-Smtp-Source: AGHT+IH+dheU1JIFDef0DPSQsIvWYyFoah4h+3treGt6yyU4NYCM1FAjluQYVkW2hDFCJiFBWDn54G71qA0FTvcwyrg=
X-Received: by 2002:a2e:d01:0:b0:2ec:4acf:97dc with SMTP id
 38308e7fff4ca-2f3be583fc3mr88871201fa.11.1724142831988; Tue, 20 Aug 2024
 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
 <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
In-Reply-To: <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
From: Andrew Worsley <amworsley@gmail.com>
Date: Tue, 20 Aug 2024 18:33:40 +1000
Message-ID: <CA+Y=x3ndV+HyeH2c4258Cq7rQWKf2UOtpJ-a_SJv4Y9CjduFVQ@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000000bdf380620194902"
X-Mailman-Approved-At: Tue, 20 Aug 2024 12:55:35 +0000
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

--0000000000000bdf380620194902
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok - hacked out a patch that allows 6.11-rc4 to boot with out hanging
- just disabling the "mes" stuff.

See attached patch

Yeah !

Andrew


On Tue, 20 Aug 2024 at 00:13, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 19, 2024 at 9:55=E2=80=AFAM Andrew Worsley <amworsley@gmail.c=
om> wrote:
> >
> > The v6.11-rc4 linux hangs during amdgpu start up where as the v6.10.0
> > is fine. I had to take a photo of the screen (see attachment) from
> > which I generated
> > the following summary:
> >
> >     Booting linux v6.11-rc4 :
> > ...
> > amdgpu: Virtual CRAT table created for CPU
> > amdgpu: Topology: Add CPU node
> > initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0xF111:0x00=
05 0xC2).
> > register mmio base: 0x90500000
> > register mmio size: 524288
> > add ip block number 0 <soc21_common>
> > add ip block number 1 <gmc_v11_0>
> > add ip block number 2 <ih_v6_0>
> > add ip block number 3 <psp>
> > add ip block number 4 <smu>
> > add ip block number 5 <dm>
> > add ip block number 6 <gfx_v11_0>
> > add ip block number 7 <sdma_v6_0>
> > add ip block number 8 <vcn_v4_0>
> > add ip block number 9 <jpeg_v4_0>
> > add ip block number 10 <mes_v11_0>
> > amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
> > amdgpu: ATOM BIOS: 113-PHXGENERIC-001
> > amdgpu 0000:c1:00.0: Direct firmware load for
> > amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> > amdgpu 0000:c1:00.0: amdgpu: try to fall back to amdgpu/gc_11_0_1_mes.b=
in
....

--0000000000000bdf380620194902
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-Fix-amdgpu-hang-on-boot-by-reverting-f9d8c5c7855d8f3.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-amdgpu-hang-on-boot-by-reverting-f9d8c5c7855d8f3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0263r290>
X-Attachment-Id: f_m0263r290

RnJvbSA1MzVjNWE3M2I5NDU2MTViZDFlYTkwZGIxZDZkMzMxZmE5Njc3MjUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgV29yc2xleSA8YW13b3JzbGV5QGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAyMCBBdWcgMjAyNCAxNjozNzozNiArMTAwMApTdWJqZWN0OiBbUEFUQ0hdIEZp
eCBhbWRncHUgaGFuZyBvbiBib290IGJ5IHJldmVydGluZwogZjlkOGM1Yzc4NTVkOGYzZTRjM2U2
Nzg3NzdkMDJhNDkwNDZlYWZiMC4KTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0
L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClJl
dmVydCAiZHJtL2FtZGdwdS9nZng6IGVuYWJsZSBtZXMgdG8gbWFwIGxlZ2FjeSBxdWV1ZSBzdXBw
b3J0IgpEaXNhYmxlIHRoZSBtZXMgc3R1ZmYgLSBub3cgZG9lc24ndCBoYW5nIG9uIG15IEFNRCBS
eXplbuKEoiA3MDQwIFNlcmllcyBmcmFtZXdvcmsgMTZpbmNoICBsYXB0b3AKLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCA0NCArKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKaW5kZXggYzc3MGNiMjAxZTY0
Li5mMmZlNzg3NGM2ZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMK
QEAgLTUwOSwxNiArNTA5LDYgQEAgaW50IGFtZGdwdV9nZnhfZGlzYWJsZV9rY3Eoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIGludCB4Y2NfaWQpCiAJaW50IGksIHIgPSAwOwogCWludCBqOwog
Ci0JaWYgKGFkZXYtPmVuYWJsZV9tZXMpIHsKLQkJZm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5u
dW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7Ci0JCQlqID0gaSArIHhjY19pZCAqIGFkZXYtPmdmeC5u
dW1fY29tcHV0ZV9yaW5nczsKLQkJCWFtZGdwdV9tZXNfdW5tYXBfbGVnYWN5X3F1ZXVlKGFkZXYs
Ci0JCQkJCQkgICAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tqXSwKLQkJCQkJCSAgIFJFU0VUX1FV
RVVFUywgMCwgMCk7Ci0JCX0KLQkJcmV0dXJuIDA7Ci0JfQotCiAJaWYgKCFraXEtPnBtZiB8fCAh
a2lxLT5wbWYtPmtpcV91bm1hcF9xdWV1ZXMpCiAJCXJldHVybiAtRUlOVkFMOwogCkBAIC01NjEs
MTggKzU1MSw2IEBAIGludCBhbWRncHVfZ2Z4X2Rpc2FibGVfa2dxKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBpbnQgeGNjX2lkKQogCWludCBpLCByID0gMDsKIAlpbnQgajsKIAotCWlmIChh
ZGV2LT5lbmFibGVfbWVzKSB7Ci0JCWlmIChhbWRncHVfZ2Z4X2lzX21hc3Rlcl94Y2MoYWRldiwg
eGNjX2lkKSkgewotCQkJZm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzOyBp
KyspIHsKLQkJCQlqID0gaSArIHhjY19pZCAqIGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzOwotCQkJ
CWFtZGdwdV9tZXNfdW5tYXBfbGVnYWN5X3F1ZXVlKGFkZXYsCi0JCQkJCQkgICAgICAmYWRldi0+
Z2Z4LmdmeF9yaW5nW2pdLAotCQkJCQkJICAgICAgUFJFRU1QVF9RVUVVRVMsIDAsIDApOwotCQkJ
fQotCQl9Ci0JCXJldHVybiAwOwotCX0KLQogCWlmICgha2lxLT5wbWYgfHwgIWtpcS0+cG1mLT5r
aXFfdW5tYXBfcXVldWVzKQogCQlyZXR1cm4gLUVJTlZBTDsKIApAQCAtNjU3LDkgKzYzNSw2IEBA
IGludCBhbWRncHVfZ2Z4X2VuYWJsZV9rY3Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGlu
dCB4Y2NfaWQpCiAJdWludDY0X3QgcXVldWVfbWFzayA9IDA7CiAJaW50IHIsIGksIGo7CiAKLQlp
ZiAoYWRldi0+ZW5hYmxlX21lcykKLQkJcmV0dXJuIGFtZGdwdV9nZnhfbWVzX2VuYWJsZV9rY3Eo
YWRldiwgeGNjX2lkKTsKLQogCWlmICgha2lxLT5wbWYgfHwgIWtpcS0+cG1mLT5raXFfbWFwX3F1
ZXVlcyB8fCAha2lxLT5wbWYtPmtpcV9zZXRfcmVzb3VyY2VzKQogCQlyZXR1cm4gLUVJTlZBTDsK
IApAQCAtNjc4LDEwICs2NTMsOSBAQCBpbnQgYW1kZ3B1X2dmeF9lbmFibGVfa2NxKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBpbnQgeGNjX2lkKQogCQlxdWV1ZV9tYXNrIHw9ICgxdWxsIDw8
IGFtZGdwdV9xdWV1ZV9tYXNrX2JpdF90b19zZXRfcmVzb3VyY2VfYml0KGFkZXYsIGkpKTsKIAl9
CiAKLQlhbWRncHVfZGV2aWNlX2ZsdXNoX2hkcChhZGV2LCBOVUxMKTsKLQogCURSTV9JTkZPKCJr
aXEgcmluZyBtZWMgJWQgcGlwZSAlZCBxICVkXG4iLCBraXFfcmluZy0+bWUsIGtpcV9yaW5nLT5w
aXBlLAotCQkga2lxX3JpbmctPnF1ZXVlKTsKKwkJCQkJCQlraXFfcmluZy0+cXVldWUpOworCWFt
ZGdwdV9kZXZpY2VfZmx1c2hfaGRwKGFkZXYsIE5VTEwpOwogCiAJc3Bpbl9sb2NrKCZraXEtPnJp
bmdfbG9jayk7CiAJciA9IGFtZGdwdV9yaW5nX2FsbG9jKGtpcV9yaW5nLCBraXEtPnBtZi0+bWFw
X3F1ZXVlc19zaXplICoKQEAgLTcxOSwyMCArNjkzLDYgQEAgaW50IGFtZGdwdV9nZnhfZW5hYmxl
X2tncShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IHhjY19pZCkKIAogCWFtZGdwdV9k
ZXZpY2VfZmx1c2hfaGRwKGFkZXYsIE5VTEwpOwogCi0JaWYgKGFkZXYtPmVuYWJsZV9tZXMpIHsK
LQkJZm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzOyBpKyspIHsKLQkJCWog
PSBpICsgeGNjX2lkICogYWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3M7Ci0JCQlyID0gYW1kZ3B1X21l
c19tYXBfbGVnYWN5X3F1ZXVlKGFkZXYsCi0JCQkJCQkJJmFkZXYtPmdmeC5nZnhfcmluZ1tqXSk7
Ci0JCQlpZiAocikgewotCQkJCURSTV9FUlJPUigiZmFpbGVkIHRvIG1hcCBnZnggcXVldWVcbiIp
OwotCQkJCXJldHVybiByOwotCQkJfQotCQl9Ci0KLQkJcmV0dXJuIDA7Ci0JfQotCiAJc3Bpbl9s
b2NrKCZraXEtPnJpbmdfbG9jayk7CiAJLyogTm8gbmVlZCB0byBtYXAga2NxIG9uIHRoZSBzbGF2
ZSAqLwogCWlmIChhbWRncHVfZ2Z4X2lzX21hc3Rlcl94Y2MoYWRldiwgeGNjX2lkKSkgewotLSAK
Mi4zOS4yCgo=
--0000000000000bdf380620194902--
