Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FFCC352A2
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED91A21741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxWMGkng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED91A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D92E6EA89;
	Thu,  6 Feb 2020 14:30:56 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275996EA89
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 14:30:55 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id s10so202275wmh.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ci2qPyR6iYGs3+iwxdA3XcA1C1U6ctkfBMycfTZfnvE=;
 b=WxWMGkngZPKuNw5yD+lBjD5IFnop+HAInkmmqVRUGfms2ALexl2h/iAcJc58ZfSWi/
 Q+SqQx6bH9CUL/QPt+uhlpVI7E/oplE0llxnqm4ZLZ/wW0lswkyUSe35uI9L6/E3/ObD
 UC+yRDu6khsE7nf9o5SfepCSD2GKEhYbK3jt6h/Oao+zmLs+0aBAfbDL9NrrgO1sbv3X
 Ek1qvrsHeyckGQlBleJCXnghR2vyDkuueq6BJ2Bbhjlc4FP1x87FqI+sc2VtG+shmGjB
 DgHIYeYhskOW4VoEPqCKk2CXQ7ePBpRsvoXcu72Zxg90cqUiP8sYLoQObqSblZNBBnaQ
 x8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ci2qPyR6iYGs3+iwxdA3XcA1C1U6ctkfBMycfTZfnvE=;
 b=jtbbBFDT7tfOXEFZJBSIsmudUGWzxeb87vG/X5nNw5OFFJsAmSLAsAVwJyZ1oPrYwZ
 ywW7gUk+vYGePdrZckOwy0csUaGgfQxfpuKNfKCWvq9xRaUiHe36k3VUap5xMWwughRR
 tMsPxq9akPj4z3q3xtxpHT6LIAdweD6zOq08gYlm+gcmXwdic1qeHK2YXvDSlIcgrE44
 u27UIHJXb4VhNsVteH1m7HGiZvaNVW/VQ7zaGWai8LcZyw6ICkjmbtu80joJQYAd+dzm
 UxEciSoNrZtORvpUMt1m6f779BekpL8cDXB9p4i8FoeF3y/TiXtJR4kG+WA+PI9uvxnZ
 59Kw==
X-Gm-Message-State: APjAAAUp8D1R5o9RIg/GPKGID+4QHQvOHztXe5plGfHVg2pTh/TYLMCX
 x3aLBMntqGQJkCoZ9Xezoig8H9XC
X-Google-Smtp-Source: APXvYqwHxOMqcmecDNricNh9sgBBWUmSq6gAnS527Q8tmwNiAGKSB2ny94eO6yeSGvpxPmYaROHizw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr4968045wmj.170.1580999453595; 
 Thu, 06 Feb 2020 06:30:53 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:28f7:e4aa:841b:b35])
 by smtp.gmail.com with ESMTPSA id a198sm3878344wme.12.2020.02.06.06.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 06:30:53 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 2/4] drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2
Date: Thu,  6 Feb 2020 15:30:49 +0100
Message-Id: <20200206143051.25809-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206143051.25809-1-christian.koenig@amd.com>
References: <20200206143051.25809-1-christian.koenig@amd.com>
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

VGhpcyBzaG91bGQgc3BlZWQgdXAgZGVidWdnaW5nIFZSQU0gYWNjZXNzIGEgbG90LgoKdjI6IGFk
ZCBIRFAgZmx1c2gvaW52YWxpZGF0ZQoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogSm9uYXRoYW4gS2ltIDxKb25hdGhh
bi5LaW1AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpp
bmRleCBiZTRlNmMzM2Q3ZTMuLjhmNDg0OWY5NGZiMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTg4LDYgKzE4OCwzMiBAQCB2b2lkIGFtZGdwdV9k
ZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGxvZmZfdCBwb3Ms
CiAJdWludDMyX3QgaGkgPSB+MDsKIAl1aW50NjRfdCBsYXN0OwogCisKKyNpZmRlZiBDT05GSUdf
NjRCSVQKKwlsYXN0ID0gbWluKHBvcyArIHNpemUsIGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6
ZSk7CisJaWYgKGxhc3QgPiBwb3MpIHsKKwkJdm9pZCBfX2lvbWVtICphZGRyID0gYWRldi0+bW1h
bi5hcGVyX2Jhc2Vfa2FkZHIgKyBwb3M7CisJCXNpemVfdCBjb3VudCA9IGxhc3QgLSBwb3M7CisK
KwkJaWYgKHdyaXRlKSB7CisJCQltZW1jcHlfdG9pbyhhZGRyLCBidWYsIGNvdW50KTsKKwkJCW1i
KCk7CisJCQlhbWRncHVfYXNpY19mbHVzaF9oZHAoYWRldiwgTlVMTCk7CisJCX0gZWxzZSB7CisJ
CQlhbWRncHVfYXNpY19pbnZhbGlkYXRlX2hkcChhZGV2LCBOVUxMKTsKKwkJCW1iKCk7CisJCQlt
ZW1jcHlfZnJvbWlvKGJ1ZiwgYWRkciwgY291bnQpOworCQl9CisKKwkJaWYgKGNvdW50ID09IHNp
emUpCisJCQlyZXR1cm47CisKKwkJcG9zICs9IGNvdW50OworCQlidWYgKz0gY291bnQgLyA0Owor
CQlzaXplIC09IGNvdW50OworCX0KKyNlbmRpZgorCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYt
Pm1taW9faWR4X2xvY2ssIGZsYWdzKTsKIAlmb3IgKGxhc3QgPSBwb3MgKyBzaXplOyBwb3MgPCBs
YXN0OyBwb3MgKz0gNCkgewogCQl1aW50MzJfdCB0bXAgPSBwb3MgPj4gMzE7Ci0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
