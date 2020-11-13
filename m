Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC9EC61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9652422226
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1p0NVuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9652422226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9C36E578;
	Fri, 13 Nov 2020 14:28:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C086E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:49:49 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id s13so8549312wmh.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6/SblzwLdOmJ9tWarQDFSbsr05Zj/WUad2ODh3SNdKc=;
 b=Y1p0NVuHUW4H9XgyeNEWCXTCVdtUlbV30yUCoYgsuqo4Y01RdEjka3nughIasrl1gp
 /eqiX+NbO1uIk+A3G8OtTbt0AwZXPnEaxkpnpoX0txhxN5lZMtgFsh2BUkU/LiDjdh36
 Ly8Ij7JoJsu4OIEFMhMk9bCFS5nA+jHJAv1qyMPRlaq1hSyddSb1ydx+hp1xs0J3hShO
 zbbnJdr/fBEncMp+JHcFJNpQqw0FQ5p88wQWyBocKZ+5TV7ehN7RQUtW07XFUDBVEgF8
 7dkkhHl5fRILzvVR8k65Yiax9xqCgRdFaUy/6BoiRrP+EWD61nsmY8gCMlxu2+ru4vjv
 k0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6/SblzwLdOmJ9tWarQDFSbsr05Zj/WUad2ODh3SNdKc=;
 b=pCWNdatm/PzW7KxmwTV9kIWVJHk6Ae7+D+10hVj5zoFZsliyZcsVqU+jlCfoAxU24t
 3HglXOdweDDrmnGr53i3rOR7d4OapJuDZoNSI3h+gkCuT9rokp+kAxoqz4LsBLB1Cwaf
 NY+prgcYlWD6USVN9JMNTGGHW3LaZmDzrNx22VlOayvNdlbtSWAK5HLIFqIX7t9SSUcA
 a5G1hF3ilIhHgo7Igw++m31ntQvXPG7J39pjiDf/NyWqxvWhFy9jfQq0epUe8E23OeCj
 TZzsa68YkB+0aNpQQ/W+nnkUA6HkGqAalnsHFpUyMW8gi+PLieoJjIaKfstqcCt62ja+
 6FEQ==
X-Gm-Message-State: AOAM533cWRr+QbDjOgTFnmoRaF7Gp6ODyauLLi6KVfBPZ8eOrElzndEk
 imUAJUys0uR9dRuYNjQOxU+dVw==
X-Google-Smtp-Source: ABdhPJxrcuhGfoNe9QQTIoT/4z4aQpdapdF6KKqt0Msq0U2GXATSYUSIF5p6At39W9yFD+O2Ih7GmA==
X-Received: by 2002:a1c:c286:: with SMTP id s128mr2672526wmf.88.1605275388627; 
 Fri, 13 Nov 2020 05:49:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:49:48 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/40] drm/amd/amdgpu/amdgpu_ring: Fix misnaming of param
 'max_dw'
Date: Fri, 13 Nov 2020 13:49:03 +0000
Message-Id: <20201113134938.4004947-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzoxNjg6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ21heF9kdycgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3Jp
bmdfaW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmM6MTY4OiB3
YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdtYXhfbmR3JyBkZXNjcmlwdGlvbiBp
biAnYW1kZ3B1X3JpbmdfaW5pdCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5v
cmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5h
cm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jpbmcu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKaW5kZXggYTIzYjIw
Nzk2OTZhMS4uMWE2MTJmNTFlY2Q5ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmluZy5jCkBAIC0xNTQsNyArMTU0LDcgQEAgdm9pZCBhbWRncHVfcmluZ191bmRvKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZykKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVy
CiAgKiBAcmluZzogYW1kZ3B1X3Jpbmcgc3RydWN0dXJlIGhvbGRpbmcgcmluZyBpbmZvcm1hdGlv
bgotICogQG1heF9uZHc6IG1heGltdW0gbnVtYmVyIG9mIGR3IGZvciByaW5nIGFsbG9jCisgKiBA
bWF4X2R3OiBtYXhpbXVtIG51bWJlciBvZiBkdyBmb3IgcmluZyBhbGxvYwogICogQGlycV9zcmM6
IGludGVycnVwdCBzb3VyY2UgdG8gdXNlIGZvciB0aGlzIHJpbmcKICAqIEBpcnFfdHlwZTogaW50
ZXJydXB0IHR5cGUgdG8gdXNlIGZvciB0aGlzIHJpbmcKICAqIEBod19wcmlvOiByaW5nIHByaW9y
aXR5IChOT1JNQUwvSElHSCkKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
