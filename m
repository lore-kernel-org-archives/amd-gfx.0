Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6AC63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D1E206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvu/UfVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D1E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBFE6EB81;
	Fri, 27 Nov 2020 10:14:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CE76E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:02 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 23so2188539wrc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BcIKnQpZCXBlyLSzrwnOmG7IOwmHB9eXMhCgCsu56Io=;
 b=vvu/UfVh3sr3D9noct/cWTDN1mgiOnOg+oz22TAslEDpt+lPXAvTgH8gcxoZukTdnI
 Vnpm0xYCfE3rdiTsH5sOg/KSKJ3NMoqKZcaC7Be9cl+xfq1X2bU0YqiskJyOIufoynQu
 S4QArlHwAi+5WJOdFiqyKoH0JJt8nVKUprx6hv4CK132R6K80EdI77/nheAVXWsrASQp
 VVgAMybtmsm9QLSwb+amML5CCZvWtdhgEi+LX7LWIJrIiY6/AnsZqNwrtEEoq0B//9wa
 yFJjSe9lKZfAWlELH/KQ1DhxPTr+N2FUupYp84sW4gyLdH3uCnk77FFNdU5rMvEEybA3
 5IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BcIKnQpZCXBlyLSzrwnOmG7IOwmHB9eXMhCgCsu56Io=;
 b=UBVGmjqBpKngxkjPkEMVUb8GmxecY8fU7vL7b2GKoZRLt3zCEr5S/KjdKkkNNNvkQc
 D2xRK9XWoqrqEpIEehwoPoOl2knpwDuFa7+p4vwbdJgUJYOt15F2Un7NrzcKs0ZW90wQ
 22fs81xqdRplbQpHwKEySMPzI0jGjNK0AR/4BPUYRpMo6oCu2RWPdpbHiOQSU98p1KaG
 w9sds0f8Xv7SX9ixT2oNYS/F6pn7iiYiHPemu5Yut5hRLp4wkO5P1+koWdOdr1cSwJ5i
 ng7SsihK4mKIFc5EGhQdBPvRqetf4D4YjEyUr9ssQ8cWenqiL8RdZVrmEwtnU/JGf7cb
 UB5w==
X-Gm-Message-State: AOAM532HqXg8VcDYhDmPmyI3U+8AnfKO9L+zc59V0IbJ9oulwFilkQSY
 3itYVYZ30CmdWre5T67zQHLeEF96yfPo+vtc
X-Google-Smtp-Source: ABdhPJwfV1VcB+/Umf4WhhLpnnDC28fKOS4R+SFguNSbBQ9UWdlMDGBsSAqcvfHdLN18AN2SVA0mLw==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr3838073wru.279.1606398181420; 
 Thu, 26 Nov 2020 05:43:01 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:00 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/40] drm/amd/pm/inc/pp_thermal: Mark
 'SMU7Thermal{WithDelay}Policy' as __maybe_unused
Date: Thu, 26 Nov 2020 13:42:10 +0000
Message-Id: <20201126134240.3214176-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhleSBhcmUgdXNlZCBieSBzb21lIHNvdXJjZSBmaWxlcyB3aGljaCBpbmNsdWRlIHBwX3RoZXJt
YWwuaCwgYnV0IG5vdCBhbGwuCgpGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9pbmMvcHBfdGhl
cm1hbC5oOjI4OjQxOiB3YXJuaW5nOiDigJhTTVU3VGhlcm1hbFdpdGhEZWxheVBvbGljeeKAmSBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vaW5jL3BwX3RoZXJtYWwuaDoyODo0MTogd2FybmluZzog
4oCYU01VN1RoZXJtYWxXaXRoRGVsYXlQb2xpY3nigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bt
L2luYy9wcF90aGVybWFsLmg6MzQ6NDE6IHdhcm5pbmc6IOKAmFNNVTdUaGVybWFsUG9saWN54oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9pbmMvcHBfdGhlcm1hbC5oOjM0OjQxOiB3YXJuaW5n
OiDigJhTTVU3VGhlcm1hbFBvbGljeeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
Y29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vaW5jL3Bw
X3RoZXJtYWwuaDozNDo0MTogd2FybmluZzog4oCYU01VN1RoZXJtYWxQb2xpY3nigJkgZGVmaW5l
ZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEV2YW4gUXVhbiA8ZXZh
bi5xdWFuQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3BwX3Ro
ZXJtYWwuaCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9wcF90aGVy
bWFsLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9wcF90aGVybWFsLmgKaW5kZXggM2Uz
MDc2OGY5ZTFjYy4uZjdjNDExODUwOTdlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9pbmMvcHBfdGhlcm1hbC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3Bw
X3RoZXJtYWwuaApAQCAtMjUsMTMgKzI1LDEzIEBACiAKICNpbmNsdWRlICJwb3dlcl9zdGF0ZS5o
IgogCi1zdGF0aWMgY29uc3Qgc3RydWN0IFBQX1RlbXBlcmF0dXJlUmFuZ2UgU01VN1RoZXJtYWxX
aXRoRGVsYXlQb2xpY3lbXSA9CitzdGF0aWMgY29uc3Qgc3RydWN0IFBQX1RlbXBlcmF0dXJlUmFu
Z2UgX19tYXliZV91bnVzZWQgU01VN1RoZXJtYWxXaXRoRGVsYXlQb2xpY3lbXSA9CiB7CiAJey0y
NzMxNTAsICA5OTAwMCwgOTkwMDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMCwgLTI3MzE1MCwgOTkw
MDAsIDk5MDAwfSwKIAl7IDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAx
MjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDB9LAogfTsKIAotc3RhdGljIGNvbnN0IHN0cnVj
dCBQUF9UZW1wZXJhdHVyZVJhbmdlIFNNVTdUaGVybWFsUG9saWN5W10gPQorc3RhdGljIGNvbnN0
IHN0cnVjdCBQUF9UZW1wZXJhdHVyZVJhbmdlIF9fbWF5YmVfdW51c2VkIFNNVTdUaGVybWFsUG9s
aWN5W10gPQogewogCXstMjczMTUwLCAgOTkwMDAsIDk5MDAwLCAtMjczMTUwLCA5OTAwMCwgOTkw
MDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMH0sCiAJeyAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAx
MjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwfSwKLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
