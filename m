Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B8C63699
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A021122242
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4DRu6ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A021122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187496E5A1;
	Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86566E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:17 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c17so9947887wrc.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4fbIgQuSd7qx2Uw2PNoVR5q/2EBKr9ikJs14+3PNgZs=;
 b=n4DRu6udIoyajnEV5cYhZElN9i8TgkAMzWGe2XXO8ZJAtYQn5MO7IMOTwcJKM7snU9
 JqPnyBnWOlcnU/T21rzOcwxuyqy/YqZQIRnFwrNhrXPMSSPdiF3vagDOA9lzf7m8sCkS
 P6upsPYAj91zk7+AQIlxbK4GxzVVMlYDAmdq7JzKe742gAi6bOyd1aJpogxYwpxPjfam
 6fh/2Jnt7GS3QFBfKuPgxTxVRHEsqcST5Z/5kex7Nd3qOzjB5szFrz1oHxHH1vSwV6nm
 JdwijeFcrJb6v608c3XTw2RKXAfMl3ruV4hyrimERbrJ75RNT8ou4IwZ4nP+zsSXYXX9
 niRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4fbIgQuSd7qx2Uw2PNoVR5q/2EBKr9ikJs14+3PNgZs=;
 b=IKDngeDeo1pm6ztHRnkxK470gpSfCqk8mwN+nnMQJUW0jqBiEqI5sYEoP1aBY6R4/L
 zAdTGOqG/RIPENgZJNIH/i1yQ35ehLNY3HrEUCiRuAdggCqerteIzzM2//x9/R+N+1mR
 BoHCeSnHmoaLDkZPX6DS2sA+3WgNHg65X0LNZfYoPmJNXckAWn6jCfvofcBp7KDE2l2X
 2X+Jbj4V3mqiJW2k3VjLQ8Oo9gXZDg97VefvaitgFMnX/N8QEx2GkPrzKVRSvycQO3DD
 7k31s6ocnmkRialNO2mu3PKDCnvQzyMq+kg9qBoIXkh1iZOe32BJ690eIqjhrpGTnFgy
 /jPA==
X-Gm-Message-State: AOAM530yg++9lenGnbeXaWE2CmpzOIxXp3JhGFuoUTC3xZniJ9zTA1SY
 r0zR+Lpw9iYM0lGEuz/8AfP8nA==
X-Google-Smtp-Source: ABdhPJwRAPuVH+2vvmutSjwOa8Cia0gPuinTJS19FPHN1ooaNyDBXHTCw7kmrU3q3Z5aPZKc7t1QmA==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr3518812wre.282.1605275416485; 
 Fri, 13 Nov 2020 05:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 28/40] drm/amd/amdgpu/amdgpu_ras: Make local function
 'amdgpu_ras_error_status_query' static
Date: Fri, 13 Nov 2020 13:49:26 +0000
Message-Id: <20201113134938.4004947-29-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjE0ODI6Njogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhhbWRncHVfcmFzX2Vycm9yX3N0YXR1c19xdWVyeeKAmSBb
LVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXgg
Zjg5YTk5MTk5OTQyOC4uOWQxMWI4NDdlNmVmZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwpAQCAtMTQ3Miw4ICsxNDcyLDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jh
c19sb2dfb25fZXJyX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB9CiAKIC8q
IFBhcnNlIFJkUnNwU3RhdHVzIGFuZCBXclJzcFN0YXR1cyAqLwotdm9pZCBhbWRncHVfcmFzX2Vy
cm9yX3N0YXR1c19xdWVyeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJc3RydWN0IHJh
c19xdWVyeV9pZiAqaW5mbykKK3N0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZXJyb3Jfc3RhdHVzX3F1
ZXJ5KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJCQkgIHN0cnVjdCByYXNfcXVlcnlf
aWYgKmluZm8pCiB7CiAJLyoKIAkgKiBPbmx5IHR3byBibG9jayBuZWVkIHRvIHF1ZXJ5IHJlYWQv
d3JpdGUKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
