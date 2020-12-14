Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C53C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 19:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D14B2255F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 19:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D14B2255F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59826E0ED;
	Mon, 14 Dec 2020 19:17:33 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B276E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 19:17:32 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w5so13819663wrm.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ufmOwKPgQFQAB4ql7EQmK6jhaZylxb/hsIu+JjUm62I=;
 b=LjpuryWAed6pObwmf7bC7xMdnZSZEEOxYjaEvegHWOauiVjiQPN7l1c8To8AdluT/g
 ijkF+SybBpfWOECo358ss/aLN8ys6vRccn3L1oGBaPkR9/rRg+HNsqZEmLxEl7kbgk53
 uDfV7z6j96kNBZ4ti7QxFlGRDnF+AsJjTj63Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ufmOwKPgQFQAB4ql7EQmK6jhaZylxb/hsIu+JjUm62I=;
 b=ICo8C6IbqhcxT93LBeJu2vjIA3qSv5yYKwzmeMxF7PQxZLAZ6ohY+7/QPR2qa+Vjwo
 drRdHiNixpsUY+dzgZmbBw1+rZgWpASLVuTWabO1RNGyNBbsmpBGu+LtX5eOe5q6BctO
 +XLu33R2LZO+pJtthNRvbaEzAE6XlpaCSs5AuqqUPudAduUqkNovRW034vqFqbgqBAUz
 U1YQutOiN6uq+q3j0rn1XYhO7jW/lFB/C4W0qT6OMqeKTTkEkB8kBTsIRmC2IBeqH8lu
 ytHd1tlHcNz/f4RpN2a6O78DSYV8kRoe3MgN4BDySvpLEfDjONpiGZkwE+XiwkADxMhf
 ZWWQ==
X-Gm-Message-State: AOAM532E+oDAa0e7UdzO2UCV1NWTlr1Ab69hS8EVDub6QS+rqSOSDeR8
 i14I7elgzQp9Tox+cPSdMN4Oww==
X-Google-Smtp-Source: ABdhPJwwR4xV9ozVPMY/L90foplvJ9uxsIv/2nhpOxme+jx4PdjnWbkNc/H77/Glz0HZVdCJLiPkIA==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr21901875wrs.80.1607973451522; 
 Mon, 14 Dec 2020 11:17:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r15sm7491720wrq.1.2020.12.14.11.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 11:17:30 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix ttm size refactor fallout
Date: Mon, 14 Dec 2020 20:17:25 +0100
Message-Id: <20201214191725.3899147-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBndWVzcyBDaHJpc3RpYW4gZGlkbid0IGNvbXBpbGUgdGVzdCBhbWRrZmQuCgpGaXhlczogZTEx
YmZiOTlkNmVjICgiZHJtL3R0bTogY2xlYW51cCBCTyBzaXplIGhhbmRsaW5nIHYzIikKQ2M6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IEh1YW5nIFJ1aSA8
cmF5Lmh1YW5nQGFtZC5jb20+ICh2MSkKQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJA
ZmZ3bGwuY2g+CkNjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IERhbmllbCBWZXR0
ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCmluZGV4IDc3OTFkMDc0YmQzMi4uYTk2NDdl
N2Y5OGE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCkBAIC00NTMsNyArNDUzLDcgQEAgc3RhdGljIGludCBhZGRfYm9fdG9fdm0oc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBrZ2RfbWVtICptZW0sCiAJc3RydWN0IGFt
ZGdwdV9ibyAqYm8gPSBtZW0tPmJvOwogCXVpbnQ2NF90IHZhID0gbWVtLT52YTsKIAlzdHJ1Y3Qg
bGlzdF9oZWFkICpsaXN0X2JvX3ZhID0gJm1lbS0+Ym9fdmFfbGlzdDsKLQl1bnNpZ25lZCBsb25n
IGJvX3NpemUgPSBiby0+dGJvLm1lbS5zaXplOworCXVuc2lnbmVkIGxvbmcgYm9fc2l6ZSA9IGJv
LT50Ym8uYmFzZS5zaXplOwogCiAJaWYgKCF2YSkgewogCQlwcl9lcnIoIkludmFsaWQgVkEgd2hl
biBhZGRpbmcgQk8gdG8gVk1cbiIpOwpAQCAtMTI4MSw3ICsxMjgxLDcgQEAgaW50IGFtZGdwdV9h
bWRrZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1KAogCQlzdHJ1Y3Qga2dkX2RldiAqa2dkLCBz
dHJ1Y3Qga2dkX21lbSAqbWVtLCB1aW50NjRfdCAqc2l6ZSkKIHsKIAlzdHJ1Y3QgYW1ka2ZkX3By
b2Nlc3NfaW5mbyAqcHJvY2Vzc19pbmZvID0gbWVtLT5wcm9jZXNzX2luZm87Ci0JdW5zaWduZWQg
bG9uZyBib19zaXplID0gbWVtLT5iby0+dGJvLm1lbS5zaXplOworCXVuc2lnbmVkIGxvbmcgYm9f
c2l6ZSA9IG1lbS0+Ym8tPnRiby5iYXNlLnNpemU7CiAJc3RydWN0IGtmZF9ib192YV9saXN0ICpl
bnRyeSwgKnRtcDsKIAlzdHJ1Y3QgYm9fdm1fcmVzZXJ2YXRpb25fY29udGV4dCBjdHg7CiAJc3Ry
dWN0IHR0bV92YWxpZGF0ZV9idWZmZXIgKmJvX2xpc3RfZW50cnk7CkBAIC0xNDAyLDcgKzE0MDIs
NyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9tYXBfbWVtb3J5X3RvX2dwdSgKIAltdXRleF9s
b2NrKCZtZW0tPmxvY2spOwogCiAJZG9tYWluID0gbWVtLT5kb21haW47Ci0JYm9fc2l6ZSA9IGJv
LT50Ym8ubWVtLnNpemU7CisJYm9fc2l6ZSA9IGJvLT50Ym8uYmFzZS5zaXplOwogCiAJcHJfZGVi
dWcoIk1hcCBWQSAweCVsbHggLSAweCVsbHggdG8gdm0gJXAgZG9tYWluICVzXG4iLAogCQkJbWVt
LT52YSwKQEAgLTE1MDYsNyArMTUwNiw3IEBAIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFw
X21lbW9yeV9mcm9tX2dwdSgKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGdldF9hbWRn
cHVfZGV2aWNlKGtnZCk7CiAJc3RydWN0IGFtZGtmZF9wcm9jZXNzX2luZm8gKnByb2Nlc3NfaW5m
byA9CiAJCSgoc3RydWN0IGFtZGdwdV92bSAqKXZtKS0+cHJvY2Vzc19pbmZvOwotCXVuc2lnbmVk
IGxvbmcgYm9fc2l6ZSA9IG1lbS0+Ym8tPnRiby5tZW0uc2l6ZTsKKwl1bnNpZ25lZCBsb25nIGJv
X3NpemUgPSBtZW0tPmJvLT50Ym8uYmFzZS5zaXplOwogCXN0cnVjdCBrZmRfYm9fdmFfbGlzdCAq
ZW50cnk7CiAJc3RydWN0IGJvX3ZtX3Jlc2VydmF0aW9uX2NvbnRleHQgY3R4OwogCWludCByZXQ7
Ci0tIAoyLjI5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
