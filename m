Return-Path: <SRS0=JyXF=HI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7CDC433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Feb 2021 00:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6421065015
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Feb 2021 00:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6421065015
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007726F53F;
	Sat,  6 Feb 2021 00:47:38 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527916F53F
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Feb 2021 00:47:37 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id i63so5428302pfg.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Feb 2021 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=UutOf8E+D3HQLpJazh8Q3BGxvcggSWW32AuDGMRndI0=;
 b=qUAa3cLgI/DX92+7ib6Er8eNLQSXFbcddiYNDFQlW2OvS/4o7k71tcaH+EWSt8w+yD
 OyO/Lh3Yt5jNpa5jyDZ4xV8Y7F/nt40bPOVcIQIAbr5oUPwpmhWk8Q0l01VF7irZtL2y
 /IZWYWBGeI8Y4ZapPofLG4QWZafHwOmJN9Bunwf8xXcHdVkIXIS3fBLXrCddRm4u8MPY
 KMAV2ifTEjsl2pW22KQjJ3cWI+f4Ml/hQ7y5JyRYZgGErjfvWWfuRoGvp/i7fyRY6LMn
 3Ezv5Hb9zmaeqAvpkEh/PL/LqVnhDCiMS31TG0Gyr24arNtLZAcszUD+E8gjt5FdOqTj
 gr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UutOf8E+D3HQLpJazh8Q3BGxvcggSWW32AuDGMRndI0=;
 b=hAxRGs4T0gRFoGpTvv4vhZs7QYnla68J41gHcAQLa8tEgcIkL6bzi1+akKmMGt8NJQ
 st5g+dJ9LydVj73fM86XUNMkxRj7KGhizKPnbgg3S5CK+/L+PUbBSFgyVpA0bW1MoomK
 ROKMmJ1Wb1Hq/6mwVr9OuZgdSSUd1FZC77TRX9tC/XHn91IpN99gZL/MOFat9zMLIv3J
 VzV/VsKKKi8Rb19lPxMqffYTIwN/LDgV0BDiSBgkdDKkMldWe3p9jUjusdbtSQ3Pfpc0
 1OEnZ14FNsX1fB+japz4ByTUG1HtT2btotfcrtJRVb9GiKnHAdE6oQF1+R6YnTFTKlji
 YkRA==
X-Gm-Message-State: AOAM532QyKWginKSADlEgNkcdK+sFyQB4QFBuWYng2NYrEQLJEkezpHp
 tlL0g8m+BeVZly897gyodiGn4O4oKVXqjSd4XD/5Debw
X-Google-Smtp-Source: ABdhPJx/gAdiHayVOfjGRZ98pIp4DKThK871d0+Gp8NMOo6mZ8GoMTq3qqZqzlB0MyQckeY8GR2x/nWLF8RxrUDxshY=
X-Received: by 2002:a62:4e10:0:b029:1c9:9015:dc5b with SMTP id
 c16-20020a624e100000b02901c99015dc5bmr7188760pfb.30.1612572456544; Fri, 05
 Feb 2021 16:47:36 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 5 Feb 2021 19:47:00 -0500
Message-ID: <CAAxE2A4EvpSwAgGucFq-KySskiiE-PKuKVB_KiwEKi3tbqL5MA@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: fix CGTS_TCC_DISABLE register offset on gfx10.3
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="00000000000072981b05baa048e6"
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

--00000000000072981b05baa048e6
Content-Type: multipart/alternative; boundary="00000000000072981705baa048e4"

--00000000000072981705baa048e4
Content-Type: text/plain; charset="UTF-8"

Please review.

Thanks,
Marek

--00000000000072981705baa048e4
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Please review.</div><div><br></div><div>Thanks,</div><div>Marek<br></div></div>

--00000000000072981705baa048e4--

--00000000000072981b05baa048e6
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-fix-CGTS_TCC_DISABLE-register-offset-on-g.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-fix-CGTS_TCC_DISABLE-register-offset-on-g.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkszy8s60>
X-Attachment-Id: f_kkszy8s60

RnJvbSA1YTZjZjk3YjllYjE3OTFjNjcyMjM2MmE2MDQyN2E0M2EyMTMwZjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogVGh1LCA0IEZlYiAyMDIxIDAyOjQ2OjIwIC0wNTAw
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IENHVFNfVENDX0RJU0FCTEUgcmVnaXN0
ZXIgb2Zmc2V0IG9uIGdmeDEwLjMKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0
L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRo
aXMgZml4ZXMgaW5jb3JyZWN0IFRDQyBoYXJ2ZXN0aW5nIGluZm8gcmVwb3J0ZWQgdG8gdXNlcnNw
YWNlLgpUaGUgaW1wYWN0IHdhcyBhIHZlcnkgdmVyeSB0aW55IHBlcmZvcm1hbmNlIGRlZ3JhZGF0
aW9uICh1bm5lY2Vzc2FyeQpHTDIgY2FjaGUgZmx1c2hlcykuCgpTaWduZWQtb2ZmLWJ5OiBNYXJl
ayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jIHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggOGFjMmFmMjI1NDM2Li40NWQxMTcyYjdiZmYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC03MCw2ICs3MCwxMSBAQAog
I2RlZmluZSBHQl9BRERSX0NPTkZJR19fTlVNX1BLUlNfX1NISUZUICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDgK
ICNkZWZpbmUgR0JfQUREUl9DT05GSUdfX05VTV9QS1JTX01BU0sgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgw
MDAwMDcwMEwKIAorI2RlZmluZSBtbUNHVFNfVENDX0RJU0FCTEVfZ2NfMTBfMyAgICAgICAgICAg
ICAgICAgMHg1MDA2CisjZGVmaW5lIG1tQ0dUU19UQ0NfRElTQUJMRV9nY18xMF8zX0JBU0VfSURY
ICAgICAgICAxCisjZGVmaW5lIG1tQ0dUU19VU0VSX1RDQ19ESVNBQkxFX2djXzEwXzMgICAgICAg
ICAgICAweDUwMDcKKyNkZWZpbmUgbW1DR1RTX1VTRVJfVENDX0RJU0FCTEVfZ2NfMTBfM19CQVNF
X0lEWCAgIDEKKwogI2RlZmluZSBtbUNQX01FQ19DTlRMX1NpZW5uYV9DaWNobGlkICAgICAgICAg
ICAgICAgICAgICAgIDB4MGY1NQogI2RlZmluZSBtbUNQX01FQ19DTlRMX1NpZW5uYV9DaWNobGlk
X0JBU0VfSURYICAgICAgICAgICAgIDAKICNkZWZpbmUgbW1STENfU0FGRV9NT0RFX1NpZW5uYV9D
aWNobGlkCQkJMHg0Y2EwCkBAIC05OCwxMCArMTAzLDYgQEAKICNkZWZpbmUgbW1HQ1JfR0VORVJB
TF9DTlRMX1NpZW5uYV9DaWNobGlkCQkJMHgxNTgwCiAjZGVmaW5lIG1tR0NSX0dFTkVSQUxfQ05U
TF9TaWVubmFfQ2ljaGxpZF9CQVNFX0lEWAkwCiAKLSNkZWZpbmUgbW1DR1RTX1RDQ19ESVNBQkxF
X1ZhbmdvZ2ggICAgICAgICAgICAgICAgMHg1MDA2Ci0jZGVmaW5lIG1tQ0dUU19UQ0NfRElTQUJM
RV9WYW5nb2doX0JBU0VfSURYICAgICAgIDEKLSNkZWZpbmUgbW1DR1RTX1VTRVJfVENDX0RJU0FC
TEVfVmFuZ29naCAgICAgICAgICAgICAgICAweDUwMDcKLSNkZWZpbmUgbW1DR1RTX1VTRVJfVEND
X0RJU0FCTEVfVmFuZ29naF9CQVNFX0lEWCAgICAgICAxCiAjZGVmaW5lIG1tR09MREVOX1RTQ19D
T1VOVF9VUFBFUl9WYW5nb2doICAgICAgICAgICAgICAgIDB4MDAyNQogI2RlZmluZSBtbUdPTERF
Tl9UU0NfQ09VTlRfVVBQRVJfVmFuZ29naF9CQVNFX0lEWCAgICAgICAxCiAjZGVmaW5lIG1tR09M
REVOX1RTQ19DT1VOVF9MT1dFUl9WYW5nb2doICAgICAgICAgICAgICAgIDB4MDAyNgpAQCAtNDkz
OCwxNSArNDkzOSwxMiBAQCBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfZ2V0X3RjY19pbmZvKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogCS8qIFRDQ3MgYXJlIGdsb2JhbCAobm90IGluc3RhbmNl
ZCkuICovCiAJdWludDMyX3QgdGNjX2Rpc2FibGU7CiAKLQlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlw
ZSkgewotCWNhc2UgQ0hJUF9WQU5HT0dIOgotCQl0Y2NfZGlzYWJsZSA9IFJSRUczMl9TT0MxNShH
QywgMCwgbW1DR1RTX1RDQ19ESVNBQkxFX1ZhbmdvZ2gpIHwKLQkJCQlSUkVHMzJfU09DMTUoR0Ms
IDAsIG1tQ0dUU19VU0VSX1RDQ19ESVNBQkxFX1ZhbmdvZ2gpOwotCQlicmVhazsKLQlkZWZhdWx0
OgorCWlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9TSUVOTkFfQ0lDSExJRCkgeworCQl0Y2Nf
ZGlzYWJsZSA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1DR1RTX1RDQ19ESVNBQkxFX2djXzEwXzMp
IHwKKwkJCSAgICAgIFJSRUczMl9TT0MxNShHQywgMCwgbW1DR1RTX1VTRVJfVENDX0RJU0FCTEVf
Z2NfMTBfMyk7CisJfSBlbHNlIHsKIAkJdGNjX2Rpc2FibGUgPSBSUkVHMzJfU09DMTUoR0MsIDAs
IG1tQ0dUU19UQ0NfRElTQUJMRSkgfAotCQkJCVJSRUczMl9TT0MxNShHQywgMCwgbW1DR1RTX1VT
RVJfVENDX0RJU0FCTEUpOwotCQlicmVhazsKKwkJCSAgICAgIFJSRUczMl9TT0MxNShHQywgMCwg
bW1DR1RTX1VTRVJfVENDX0RJU0FCTEUpOwogCX0KIAogCWFkZXYtPmdmeC5jb25maWcudGNjX2Rp
c2FibGVkX21hc2sgPQotLSAKMi4yNS4xCgo=
--00000000000072981b05baa048e6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000072981b05baa048e6--
