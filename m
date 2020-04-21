Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D8C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D658E20857
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKqgbDJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D658E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7366E434;
	Tue, 21 Apr 2020 09:10:08 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9EC6E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 09:10:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t14so15529435wrw.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a02chLMp/lDgP2h+kDp131xz/gFueRkXvI7DzqEvemA=;
 b=UKqgbDJoYm5jrkM3qLXnEnP4v8oQyYl+G5tJS4yG7qPlUNADw5Z2r7A53agGczETcI
 ZWBejQvoqMBkhYYAEg7aaJOzbBXqDKBs942xPqX9OEdr3aRiDhugFf0mgTkWx5K4BM3L
 MiglrEu1gRfv6J/NS6v1afhhnQP5jEsg+BFVvgrS/4dfJH0Bi3hIgR5ZS74fqNV4Wqo2
 oMWgPIwx4GEpxNN1vZ8XbFFRr8lgbbKzF2XXfMhrz3rwo4IHT4q0BpmTa8uL/1Jm4K+n
 PS5g1ei0XdjRD7bi9GlDKyH4iZdbhIWZpYOpw8AYiQReaOUHneiUin8enaHr3aLYC3cZ
 B6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a02chLMp/lDgP2h+kDp131xz/gFueRkXvI7DzqEvemA=;
 b=fMblDe5lj0J3f/MSPqWaAMjtCXQeUiWvbSS9mlWZx6OWqQ2jy8cXHmvQ/+avWeeFiQ
 eL67IJm2NywXlrKh49i0Prlm3V4TqXAsJTmeGc6HMkm09o842E00G5eJSGzu68lql4v7
 7SLhGQY5DeYV9PEFNgdFscuX51k6Y9mX8orpXp5GtKL/lO8JiliYoVEiQqj2jXa802A5
 sBjGOk1mHePRXlQvC3Jg01kbSmwmXrbB9RqCZRffeK8Ro4tNFT1+iu9fWbxewew+7at7
 lgWzxS8lDUvpzjPu5t6iWp2CCKf0ZIJg6sT+D3fFGFJYGtjruSyAyraN3Vk1+WlWPX2P
 SyjA==
X-Gm-Message-State: AGi0PuZnuR5yoWZdxee8klA/SPy4XbSdx7tnUzvKyFaicnjxui0G/dC/
 PHnECLNCIE6YBFABndvgKfiZvu2j
X-Google-Smtp-Source: APiQypJcHkpEthOicSzSmKp8BqNw/KndXoltD0geVIALkYiNc2OWySSi/mqzIWVSTpHY8S5wgjfqVw==
X-Received: by 2002:a5d:464d:: with SMTP id j13mr23415065wrs.269.1587460206192; 
 Tue, 21 Apr 2020 02:10:06 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7833:1411:6069:2e5b])
 by smtp.gmail.com with ESMTPSA id i17sm2787295wru.39.2020.04.21.02.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:10:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Monk.Liu@amd.com, Yintian.Tao@amd.com, Jacob.He@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup SPM VMID update
Date: Tue, 21 Apr 2020 11:10:04 +0200
Message-Id: <20200421091004.130041-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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
Cc: Frans.Gu@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIFJMQyBTUE0gY29uZmlndXJhdGlvbiByZWdpc3RlciBjb250YWlucyB0aGUgaW5mb3JtYXRp
b24gaG93IHRoZSBtZW1vcnkKYWNjZXNzIGlzIG1hZGUgKFZNSUQsIE1UWVBFLCBldGMuLi4uKSB3
aGljaCBzaG91bGQgYWx3YXlzIGJlIGNvbnNpc3RlbnQuCgpTbyBpbnN0ZWFkIG9mIGEgcmVhZCBt
b2RpZnkgd3JpdGUgY3ljbGUgb2YgdGhlIFZNSUQgYWx3YXlzIHVwZGF0ZQp0aGUgd2hvbGUgcmVn
aXN0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA3
ICstLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgIHwgNyArLS0t
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICB8IDcgKy0tLS0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgfCA3ICstLS0tLS0KIDQgZmls
ZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDBhMDNlMmFkNWQ5NS4uMmE2NTU2MzcxMDQ2
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNzAzMCwxMiArNzAz
MCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3VwZGF0ZV9nZnhfY2xvY2tfZ2F0aW5nKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCiBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfdXBkYXRlX3Nw
bV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCB2bWlkKQogewotCXUz
MiBkYXRhOwotCi0JZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwp
OwotCi0JZGF0YSAmPSB+UkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSzsKLQlkYXRh
IHw9ICh2bWlkICYgUkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSykgPDwgUkxDX1NQ
TV9NQ19DTlRMX19STENfU1BNX1ZNSURfX1NISUZUOworCXUzMiBkYXRhID0gUkVHX1NFVF9GSUVM
RCgwLCBSTENfU1BNX01DX0NOVEwsIFJMQ19TUE1fVk1JRCwgdm1pZCk7CiAKIAlXUkVHMzJfU09D
MTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjdfMC5jCmluZGV4IGIyZjEwZTM5ZWZmMS4uYTkyNDg2Y2QwMzhmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMKQEAgLTM1NzAsMTIgKzM1NzAsNyBAQCBzdGF0
aWMgaW50IGdmeF92N18wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAK
IHN0YXRpYyB2b2lkIGdmeF92N18wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdW5zaWduZWQgdm1pZCkKIHsKLQl1MzIgZGF0YTsKLQotCWRhdGEgPSBSUkVHMzIo
bW1STENfU1BNX1ZNSUQpOwotCi0JZGF0YSAmPSB+UkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURf
TUFTSzsKLQlkYXRhIHw9ICh2bWlkICYgUkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfTUFTSykg
PDwgUkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfX1NISUZUOworCXUzMiBkYXRhID0gUkVHX1NF
VF9GSUVMRCgwLCBSTENfU1BNX1ZNSUQsIFJMQ19TUE1fVk1JRCwgdm1pZCk7CiAKIAlXUkVHMzIo
bW1STENfU1BNX1ZNSUQsIGRhdGEpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8w
LmMKaW5kZXggZmM2YzJmMmJjNzZjLi40NGZkZGE2OGRiOTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYwpAQCAtNTYxMywxMiArNTYxMyw3IEBAIHN0YXRpYyB2b2lkIGdmeF92
OF8wX3Vuc2V0X3NhZmVfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogc3RhdGlj
IHZvaWQgZ2Z4X3Y4XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCB2bWlkKQogewotCXUzMiBkYXRhOwotCi0JZGF0YSA9IFJSRUczMihtbVJMQ19T
UE1fVk1JRCk7Ci0KLQlkYXRhICY9IH5STENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9NQVNLOwot
CWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBSTENf
U1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7CisJdTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxE
KDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlkKTsKIAogCVdSRUczMihtbVJMQ19T
UE1fVk1JRCwgZGF0YSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRl
eCA1NGVkZWQ5YTZhYzUuLmIzNmZiZjk5MTMxMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jCkBAIC00OTUwLDEyICs0OTUwLDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF91cGRh
dGVfZ2Z4X2Nsb2NrX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogc3RhdGlj
IHZvaWQgZ2Z4X3Y5XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCB2bWlkKQogewotCXUzMiBkYXRhOwotCi0JZGF0YSA9IFJSRUczMl9TT0MxNShH
QywgMCwgbW1STENfU1BNX01DX0NOVEwpOwotCi0JZGF0YSAmPSB+UkxDX1NQTV9NQ19DTlRMX19S
TENfU1BNX1ZNSURfTUFTSzsKLQlkYXRhIHw9ICh2bWlkICYgUkxDX1NQTV9NQ19DTlRMX19STENf
U1BNX1ZNSURfTUFTSykgPDwgUkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfX1NISUZUOwor
CXUzMiBkYXRhID0gUkVHX1NFVF9GSUVMRCgwLCBSTENfU1BNX01DX0NOVEwsIFJMQ19TUE1fVk1J
RCwgdm1pZCk7CiAKIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRh
KTsKIH0KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
