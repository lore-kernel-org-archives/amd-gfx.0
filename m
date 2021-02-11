Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6909DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 20:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C0164DDF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 20:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C0164DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAF96EE72;
	Thu, 11 Feb 2021 20:34:24 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF136EE0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 18:29:41 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id f14so11542829ejc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JcGKU1fnidQkmSGH9avIkcypP9Cg5TIYjIacUubUOs0=;
 b=WaFOTuIrn5qQQZXqEBuWD15obQCbqOF0j/QQtZZiOVENm+UjkLkpIdYiWAXLBFWMlK
 VDURq5Wres9IMbZLFGOX3YVU1hSP3giOFulUXH+iO8TkwZMDaRwN5xrjSw/0ehFUymb5
 S2810+SBG19DCcvJwVn+zKDnX5md4x2CryMsj4oKcdmJjJf6qdd80rVaZ4hNB6yqqotv
 JbSlAmUMuSsUmdcK8SpI2gNEJakC5DqL1jQ7N5mOw4UTxzehNGStl7rA3kP+1cwjl8Rt
 qIsSkMfpDNnwTOVqtziVruHpkapAFfAs2/RVzRifNa+R/uuREAvdcALetVO5oFFx4A1D
 bvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JcGKU1fnidQkmSGH9avIkcypP9Cg5TIYjIacUubUOs0=;
 b=a4+wY1OTAkd/fJ74cyAiq4qkc8RbZAiIp9zCDZpr0wWQoV8uI6Qv+U/agYzllMEXS+
 jyhJqdjxUBXv8ubMNpT997LOvxeSI6i+E7/M81gYfyGZDfaUgrC2gUFCuidpclvd1V7B
 tEgKwrJpqaRqFzto/tNwXAQPqOVH1PwKhHie80+nUu2huW0BJXAGYruISTstPpHRLctl
 k0P8xcvUV0NbJ78a8Av8P/Ozbmm0mopBWEjP+JV+ZReypM4GSNwB6FY64OGpzqdd0zJQ
 LY2ZpOAn48fM3ZhaySO+FAPnbfZm7K+Kuj9Lvoe7EcTqPn52ubLkkVFkuOjMA74ZJNRt
 Pxnw==
X-Gm-Message-State: AOAM532EFjW6jd55vvwl/HM032x+iK71CaaS9mCWQA7bbjXxiWzstn1f
 SeiGlgjqVAI4BARSPwNXQ5cVKeuPZm4=
X-Google-Smtp-Source: ABdhPJyetVa+bbjHMG5QP5D11oihZK28dKaDRBwpY08xgOTz+LPhZ5hI+WElunhnOJLxDRW28oDpKw==
X-Received: by 2002:a17:906:19c3:: with SMTP id
 h3mr9557786ejd.429.1613068180692; 
 Thu, 11 Feb 2021 10:29:40 -0800 (PST)
Received: from toluca.home.arpa
 (p200300d21f2195000000000000001d74.dip0.t-ipconnect.de.
 [2003:d2:1f21:9500::1d74])
 by smtp.gmail.com with ESMTPSA id dv17sm2634592ejb.25.2021.02.11.10.29.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Feb 2021 10:29:40 -0800 (PST)
From: =?UTF-8?q?Jan=20Kokem=C3=BCller?= <jan.kokemueller@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add FPU wrappers to
 dcn21_validate_bandwidth()
Date: Thu, 11 Feb 2021 19:28:43 +0100
Message-Id: <20210211182843.10541-1-jan.kokemueller@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Feb 2021 20:34:23 +0000
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?q?Jan=20Kokem=C3=BCller?= <jan.kokemueller@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZGNuMjFfdmFsaWRhdGVfYmFuZHdpZHRoKCkgY2FsbHMgZnVuY3Rpb25zIHRoYXQgdXNlIGZsb2F0
aW5nIHBvaW50IG1hdGguCk9uIG15IG1hY2hpbmUgdGhpcyBzb21ldGltZXMgcmVzdWx0cyBpbiBz
aW1kIGV4Y2VwdGlvbnMgd2hlbiB0aGVyZSBhcmUKb3RoZXIgRlBVIHVzZXJzIHN1Y2ggYXMgS1ZN
IHZpcnR1YWwgbWFjaGluZXMgcnVubmluZy4gVGhlIHNjcmVlbiBmcmVlemVzCmNvbXBsZXRlbHkg
aW4gdGhpcyBjYXNlLgoKV3JhcHBpbmcgdGhlIGZ1bmN0aW9uIHdpdGggRENfRlBfU1RBUlQoKS9E
Q19GUF9FTkQoKSBzZWVtcyB0byBzb2x2ZSB0aGUKcHJvYmxlbS4gVGhpcyBtaXJyb3JzIHRoZSBh
cHByb2FjaCB1c2VkIGZvciBkY24yMF92YWxpZGF0ZV9iYW5kd2lkdGguCgpUZXN0ZWQgb24gYSBB
TUQgUnl6ZW4gNyBQUk8gNDc1MFUgKFJlbm9pcikuCgpCdWc6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2OTg3ClNpZ25lZC1vZmYtYnk6IEphbiBLb2tlbcO8
bGxlciA8amFuLmtva2VtdWVsbGVyQGdtYWlsLmNvbT4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCAgMiArLQogLi4uL2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIHwgMjAgKysrKysrKysrKysrKysrKystLQogMiBmaWxl
cyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKaW5k
ZXggNWVkMThjYWM1N2U4Li5mOWRhYmUyMjVkYjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCkBAIC0zMjQ1LDcgKzMy
NDUsNyBAQCBzdGF0aWMgbm9pbmxpbmUgYm9vbCBkY24yMF92YWxpZGF0ZV9iYW5kd2lkdGhfZnAo
c3RydWN0IGRjICpkYywKIGJvb2wgZGNuMjBfdmFsaWRhdGVfYmFuZHdpZHRoKHN0cnVjdCBkYyAq
ZGMsIHN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCwKIAkJYm9vbCBmYXN0X3ZhbGlkYXRlKQogewot
CWJvb2wgdm9sdGFnZV9zdXBwb3J0ZWQgPSBmYWxzZTsKKwlib29sIHZvbHRhZ2Vfc3VwcG9ydGVk
OwogCURDX0ZQX1NUQVJUKCk7CiAJdm9sdGFnZV9zdXBwb3J0ZWQgPSBkY24yMF92YWxpZGF0ZV9i
YW5kd2lkdGhfZnAoZGMsIGNvbnRleHQsIGZhc3RfdmFsaWRhdGUpOwogCURDX0ZQX0VORCgpOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jl
c291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVz
b3VyY2UuYwppbmRleCA2NzQzNzY0Mjg5MTYuLjA3MmY4Yzg4MDkyNCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKQEAg
LTEzMjksOCArMTMyOSw4IEBAIHN0YXRpYyBib29sIGRjbjIxX2Zhc3RfdmFsaWRhdGVfYncoCiAJ
cmV0dXJuIG91dDsKIH0KIAotYm9vbCBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGgoc3RydWN0IGRj
ICpkYywgc3RydWN0IGRjX3N0YXRlICpjb250ZXh0LAotCQlib29sIGZhc3RfdmFsaWRhdGUpCitz
dGF0aWMgbm9pbmxpbmUgYm9vbCBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGhfZnAoc3RydWN0IGRj
ICpkYywKKwkJc3RydWN0IGRjX3N0YXRlICpjb250ZXh0LCBib29sIGZhc3RfdmFsaWRhdGUpCiB7
CiAJYm9vbCBvdXQgPSBmYWxzZTsKIApAQCAtMTM4Myw2ICsxMzgzLDIyIEBAIGJvb2wgZGNuMjFf
dmFsaWRhdGVfYmFuZHdpZHRoKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBkY19zdGF0ZSAqY29udGV4
dCwKIAogCXJldHVybiBvdXQ7CiB9CisKKy8qCisgKiBTb21lIG9mIHRoZSBmdW5jdGlvbnMgZnVy
dGhlciBiZWxvdyB1c2UgdGhlIEZQVSwgc28gd2UgbmVlZCB0byB3cmFwIHRoaXMKKyAqIHdpdGgg
RENfRlBfU1RBUlQoKS9EQ19GUF9FTkQoKS4gVXNlIHRoZSBzYW1lIGFwcHJvYWNoIGFzIGZvcgor
ICogZGNuMjBfdmFsaWRhdGVfYmFuZHdpZHRoIGluIGRjbjIwX3Jlc291cmNlLmMuCisgKi8KK2Jv
b2wgZGNuMjFfdmFsaWRhdGVfYmFuZHdpZHRoKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBkY19zdGF0
ZSAqY29udGV4dCwKKwkJYm9vbCBmYXN0X3ZhbGlkYXRlKQoreworCWJvb2wgdm9sdGFnZV9zdXBw
b3J0ZWQ7CisJRENfRlBfU1RBUlQoKTsKKwl2b2x0YWdlX3N1cHBvcnRlZCA9IGRjbjIxX3ZhbGlk
YXRlX2JhbmR3aWR0aF9mcChkYywgY29udGV4dCwgZmFzdF92YWxpZGF0ZSk7CisJRENfRlBfRU5E
KCk7CisJcmV0dXJuIHZvbHRhZ2Vfc3VwcG9ydGVkOworfQorCiBzdGF0aWMgdm9pZCBkY24yMV9k
ZXN0cm95X3Jlc291cmNlX3Bvb2woc3RydWN0IHJlc291cmNlX3Bvb2wgKipwb29sKQogewogCXN0
cnVjdCBkY24yMV9yZXNvdXJjZV9wb29sICpkY24yMV9wb29sID0gVE9fRENOMjFfUkVTX1BPT0wo
KnBvb2wpOwotLSAKMi4zMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
