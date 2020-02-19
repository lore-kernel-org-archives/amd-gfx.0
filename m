Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A77C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8FD208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfKkIW8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8FD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8656E3F2;
	Wed, 19 Feb 2020 15:02:56 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3F86E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:02:54 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id s144so559961wme.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oYcrgyyfBbgokBk3R9j0He+CUXv+dP9vmhA1EKZTg6k=;
 b=rfKkIW8YSTFe2IB3DVACAcU9ODVqsSPMtqfDEu6puJ0vAPvHB/r+H5nl9ZAfb2CehM
 0bUARxonmKjasfn+BTbPdQr97cLVE5UHB1k1DnhYtg/9v68V5or19MGkIbPoyM8gjVVb
 6v9kr4GSJi8M+gNIhxLjqT9pBpbxUkOfhQuwQxwNzLISxCKpu3X44U/czqm72wY9RAmh
 l5Dv/MGlMege9YcuGpzMhANm5j/sf+dMCEu+qR7bT6cMtXAmKekwJgXOwTJ2Oy97+Y/L
 atE4mUG4U5pPc7hF62CdpMRxXOfH+NT2rg6xaANYuI62h+H1mhCmkdHweAM3rlJGfrLe
 Kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oYcrgyyfBbgokBk3R9j0He+CUXv+dP9vmhA1EKZTg6k=;
 b=evDXDBd9esG3fbdcPI4IUdrkQSuxmWBDaW6RKbTXL/XHGav6FJpwOzERZZl7CWYc5Y
 NYL/mgzbWuQQ06Z1fE7Ha/SXjML53nAniTavxgYP9pnYsf31XvtFtWWRYsTzlFbuoEVz
 05PL0jQqY4bMYffIGuEdY8UyY2g77wPN+BEk0NenT8hACioY+z8gS1fb2kD5czv1V7cV
 Jl3n7o3QpgRgalWrk2WEpIzipsm78MlHoDW8kQJ9tKTA4S/fnCCtmtA/YTctQWnhdPYa
 0yqD797bDjx2CkQY2L6Zdv14adnqGmBgTdCeCYf+7VxVqw/Rj1TkHVgineosl06zW/mg
 n6Kg==
X-Gm-Message-State: APjAAAU4ORd0Sdkqz9m7iDg/HuQhM58cLhPot8qUw/Y33X8SKBzy9g8m
 Q+1SQcCdCqJw0Ib8yDakp9BrZeut
X-Google-Smtp-Source: APXvYqxmFcEb3xjKGPBhRyLvDiEPuhvOVGS3J82lBPIzQr/7U6vZQ2IF0/CkIfKJ37K2tCUKZOXmTg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr11252093wmi.152.1582124573435; 
 Wed, 19 Feb 2020 07:02:53 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:4054:9e4d:fa6d:3d9f])
 by smtp.gmail.com with ESMTPSA id y7sm41455wrr.56.2020.02.19.07.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 07:02:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com, luben.tuikov@amd.com, Marek.Olsak@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
Date: Wed, 19 Feb 2020 16:02:51 +0100
Message-Id: <20200219150251.123917-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQgd2hpbGUgbWFwcGluZyBCT3MuCgpPdGhl
cndpc2UgUERzIGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24ndCB3YWl0IGZvcgp1cGRhdGVz
IHRvIGZpbmlzaCBhbmQgY2FuIGNhdXNlIGNvcnJ1cHRpb25zLgoKdjI6IHJlYmFzZWQgb24gZHJt
LW1pc2MtbmV4dAoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpGaXhlczogOTBiNjljZGM1ZjE1OSBkcm0vYW1kZ3B1OiBzdG9wIGFkZGlu
ZyBWTSB1cGRhdGVzIGZlbmNlcyB0byB0aGUgcmVzdiBvYmoKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE0ICsrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCmluZGV4IGQxNjIzMWQ2YTc5MC4uZWY3M2ZhOTRmMzU3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtNTg4LDggKzU4OCw4IEBAIHZvaWQg
YW1kZ3B1X3ZtX2dldF9wZF9ibyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKIHsKIAllbnRyeS0+cHJp
b3JpdHkgPSAwOwogCWVudHJ5LT50di5ibyA9ICZ2bS0+cm9vdC5iYXNlLmJvLT50Ym87Ci0JLyog
T25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpvYiAqLwotCWVudHJ5LT50di5udW1fc2hh
cmVkID0gMjsKKwkvKiBUd28gZm9yIFZNIHVwZGF0ZXMsIG9uZSBmb3IgVFRNIGFuZCBvbmUgZm9y
IHRoZSBDUyBqb2IgKi8KKwllbnRyeS0+dHYubnVtX3NoYXJlZCA9IDQ7CiAJZW50cnktPnVzZXJf
cGFnZXMgPSBOVUxMOwogCWxpc3RfYWRkKCZlbnRyeS0+dHYuaGVhZCwgdmFsaWRhdGVkKTsKIH0K
QEAgLTE1OTEsNiArMTU5MSwxNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJZ290byBlcnJvcl91bmxvY2s7CiAJ
fQogCisJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgeworCQlzdHJ1Y3QgYW1kZ3B1X2Jv
ICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKKworCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxl
ZCh2bS0+bGFzdF9kaXJlY3QpKQorCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2Rp
cmVjdCwgdHJ1ZSk7CisKKwkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVs
YXllZCkpCisJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7
CisJfQorCiAJciA9IHZtLT51cGRhdGVfZnVuY3MtPnByZXBhcmUoJnBhcmFtcywgb3duZXIsIGV4
Y2x1c2l2ZSk7CiAJaWYgKHIpCiAJCWdvdG8gZXJyb3JfdW5sb2NrOwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
