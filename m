Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A4C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F522083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr+Vmi6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F522083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4236E9FC;
	Thu,  7 May 2020 15:11:02 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388FE6E9FA;
 Thu,  7 May 2020 15:11:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s8so6841608wrt.9;
 Thu, 07 May 2020 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rLELSkIkXqc4MjKeYvGm92qJZ3Zy9onyXpkjbBhy6wg=;
 b=Yr+Vmi6QKlnofxOYiNtwd3eAoXde2UhusYr5PcDyQb5Z0Q9cLezYKD/VJtzOzfR5xu
 fd19PV2zRLEhANF8hyKJJvBU/zWK/xen+TJ8UZbAdaFqN20+qNCke0BmfE042HaBY/p3
 EOWFnlGN9cSqctiNA8dM3UnFj2LjE8W8K91UFnP56MkgmmwkmT4L2n8aos6fSsfPWM/T
 yDzb1ZUpi/+1byj1vqHXbCaN/Cq1l0+3Gi8+CCGbZbII8WNsFvimC7QW3bskOuvA4xAn
 7F2L0UvG2ZRdp6SNhnTL8AJHzvPFH8kzdoIgoXV/QLK21JGlkG22hwcby4W58H0ngVKe
 DhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rLELSkIkXqc4MjKeYvGm92qJZ3Zy9onyXpkjbBhy6wg=;
 b=QOpy9+8n0/TXtAvfceDacO6XlJTODGtNvEzdKB/Il1GJvT0BcGpzxMyK0ibTxk+KTs
 COs3J52VwdZ9WaImV+dQZUwgHK5Ckip//mwqGR9No5GHEvJMqMYGqnTjspF2Url4A+C8
 oDslHKGI15vg2CFOk5+CwE0PNwTUnA8h0AbbPnHok+zKe+efjaDzPXH1ILafijmRHQGt
 Ydb9VFe7yxZpB1XdMATtjx52WekQoLbIpsDwLFVyE6DVIdf7H3Ga04XE2eLqDXYAfU6C
 /ykpiZChUcJEKRF5Sq0W41xkerQaQjMZKsacfjrOOeY4W3XsPSBquXCp2/8P5QQ/L0zl
 dWjw==
X-Gm-Message-State: AGi0Pubqgv5TnWMAf+rkO4D4vMPlyt4iuOCGclHAcBuKdFLc2T3AOyZ6
 rCHe+FmtZ+JVC8ETZcbiQN+EYQj/
X-Google-Smtp-Source: APiQypKaNSaGj3/LMepeWJU0dApnhwNxtE8TWXTJaCbSNqB3o/LoIfwsHTqlbZro+OBCI6xtsDPPag==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr14981243wrs.94.1588864259352; 
 Thu, 07 May 2020 08:10:59 -0700 (PDT)
Received: from arch-x1c3.cbg.collabora.co.uk
 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
 by smtp.gmail.com with ESMTPSA id b66sm8704247wmh.12.2020.05.07.08.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:10:58 -0700 (PDT)
From: Emil Velikov <emil.l.velikov@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 06/36] drm/amdgpu: use the unlocked drm_gem_object_put
Date: Thu,  7 May 2020 16:07:52 +0100
Message-Id: <20200507150822.114464-7-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507150822.114464-1-emil.l.velikov@gmail.com>
References: <20200507150822.114464-1-emil.l.velikov@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, emil.l.velikov@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClRoZSBkcml2
ZXIgZG9lcyBub3QgaG9sZCBzdHJ1Y3RfbXV0ZXgsIHRodXMgdXNpbmcgdGhlIGxvY2tlZCB2ZXJz
aW9uIG9mCnRoZSBoZWxwZXIgaXMgaW5jb3JyZWN0LgoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkZpeGVzOiBhMzk0
MTQ3MTZjYTAgKCJkcm0vYW1kZ3B1OiBhZGQgaW5kZXBlbmRlbnQgRE1BLWJ1ZiBpbXBvcnQgdjki
KToKU2lnbmVkLW9mZi1ieTogRW1pbCBWZWxpa292IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCmluZGV4IDQzZDhlZDdkYmQwMC4u
NjUyYzU3YTNiODQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZG1hX2J1Zi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFf
YnVmLmMKQEAgLTU4Nyw3ICs1ODcsNyBAQCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKmFtZGdwdV9n
ZW1fcHJpbWVfaW1wb3J0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiAJYXR0YWNoID0gZG1hX2J1
Zl9keW5hbWljX2F0dGFjaChkbWFfYnVmLCBkZXYtPmRldiwKIAkJCQkJJmFtZGdwdV9kbWFfYnVm
X2F0dGFjaF9vcHMsIG9iaik7CiAJaWYgKElTX0VSUihhdHRhY2gpKSB7Ci0JCWRybV9nZW1fb2Jq
ZWN0X3B1dChvYmopOworCQlkcm1fZ2VtX29iamVjdF9wdXRfdW5sb2NrZWQob2JqKTsKIAkJcmV0
dXJuIEVSUl9DQVNUKGF0dGFjaCk7CiAJfQogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
