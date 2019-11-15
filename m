Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866ABC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628562073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297026E82D;
	Fri, 15 Nov 2019 15:13:19 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C336E82D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 15:13:17 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id t8so11145713qtc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 07:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8OUAQseDczngC5uzokl8ms9DlUGMOU2N0lwMmyBzB+8=;
 b=EAcMbEvvZYPiffDgRaM5heejwStA8S8/AsQv03tUGJxCHYporK1tZ5fxe99mLatTng
 Msj4HeSkESLZjlXz1Hwpj6z5exTZGsRclAKMJ4uDhmPED2NnUhGxX/P9DQ3v1z/3Bkdb
 N1oejqFSyB3UKYfvy+Taq5Qu6govCDdSPrvGr66zbTXcs+btSn6+xzJldNQeATIr06zv
 KrJUr7zoODyJfiPoveu+rLMT+MQ5HZgV2pgyqpFhUTB8aRCo/5xjsIrED6u0v/Gi7ecM
 KuBakxjiEP1D/il3ud8BJUaoj96FjjK9XlH/d5EG5NWNl7/XlBLGMNpexb0E5hzVT/hf
 qMow==
X-Gm-Message-State: APjAAAWNfD0aOzsskEBnTWrrrIGU7Vjd0ERzysRIZ3Qm/XnAWHppHNSE
 1yn8cS+TD+tY9nFExpzYTe+ClGfc
X-Google-Smtp-Source: APXvYqw8tFPWE+FKQJRaHUOU28d+Z7RISOsgj35lTPVDHKzhN71y4NpbItzDPi64L10jMwZ9+AKh8Q==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr14457268qtr.146.1573830796084; 
 Fri, 15 Nov 2019 07:13:16 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id d39sm5131397qtc.23.2019.11.15.07.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:13:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: revert wait in pipelock"
Date: Fri, 15 Nov 2019 10:13:08 -0500
Message-Id: <20191115151308.578774-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8OUAQseDczngC5uzokl8ms9DlUGMOU2N0lwMmyBzB+8=;
 b=HJp2Q5kO2+WIKzoIuxH32e07/qm2IeG8ZKhtKuZl2LV26e2R2GlQdibSu7Bj1TKmCT
 AJRvIS277dpDLYTNmZAnzOIx1unz52BqgL0CdczbJ9LTAwrv/G1EZZBylnUtWuDcWTpB
 8kpKuc+10f6XP3oNUWaOmU/LMwjX+lML5ofa+UUZorbCcShqWiOUwDyumBW0aIC0yLCF
 B+esHdxbeymawPgerADuwiH0ngpieiWVl2JDnDM5S6xoaeJSEiOBbJbJc/ctyyIoBxzY
 /b4dFqN793+gd2of/UYMs1K8uKNyBcIcqJfBXzgljVl8Uz154f+xuj3H2kMDL0r5VtxD
 0xXA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115151308.MqsaI11VI5PoKlFdws3Gc4sQb9rPfgBmzPSLqcYCqDc@z>

VGhpcyByZXZlcnRzIGNvbW1pdCA2MTcwODlkNTgzN2EzYWE0MTY3YTljNGFmYjM0OTI5ZTBkNTI4
MDVkLgoKVGhpcyBjYXVzZXMgaGFuZ3MgaW4gc29tZSBnYW1lcy4KCkJ1ZzogaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDUxNjkKQnVnOiBodHRwczovL2J1Z3Mu
ZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMTIyNjYKQnVnOiBodHRwczovL2J1Z3pp
bGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2OQpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMgfCAxMSArKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCmluZGV4IDAwNDZhMDk5YzllOS4uOWI0
NDg4ZWYyN2QxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfaHdzZXEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfaHdzZXEuYwpAQCAtMTAzMyw2ICsxMDMzLDE3IEBAIHZvaWQgZGNuMjBfcGlwZV9j
b250cm9sX2xvY2soCiAJaWYgKHBpcGUtPnBsYW5lX3N0YXRlICE9IE5VTEwpCiAJCWZsaXBfaW1t
ZWRpYXRlID0gcGlwZS0+cGxhbmVfc3RhdGUtPmZsaXBfaW1tZWRpYXRlOwogCisJaWYgKGZsaXBf
aW1tZWRpYXRlICYmIGxvY2spIHsKKwkJd2hpbGUgKHBpcGUtPnBsYW5lX3Jlcy5odWJwLT5mdW5j
cy0+aHVicF9pc19mbGlwX3BlbmRpbmcocGlwZS0+cGxhbmVfcmVzLmh1YnApKQl7CisJCQl1ZGVs
YXkoMSk7CisJCX0KKworCQlpZiAocGlwZS0+Ym90dG9tX3BpcGUgIT0gTlVMTCkKKwkJCXdoaWxl
IChwaXBlLT5ib3R0b21fcGlwZS0+cGxhbmVfcmVzLmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBf
cGVuZGluZyhwaXBlLT5ib3R0b21fcGlwZS0+cGxhbmVfcmVzLmh1YnApKQl7CisJCQkJdWRlbGF5
KDEpOworCQkJfQorCX0KKwogCS8qIEluIGZsaXAgaW1tZWRpYXRlIGFuZCBwaXBlIHNwbGl0dGlu
ZyBjYXNlLCB3ZSBuZWVkIHRvIHVzZSBHU0wKIAkgKiBmb3Igc3luY2hyb25pemF0aW9uLiBPbmx5
IGRvIHNldHVwIG9uIGxvY2tpbmcgYW5kIG9uIGZsaXAgdHlwZSBjaGFuZ2UuCiAJICovCi0tIAoy
LjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
