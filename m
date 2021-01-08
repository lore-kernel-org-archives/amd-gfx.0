Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869FC43381
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9E32399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9E32399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF296E902;
	Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948286E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:26 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id t30so10182670wrb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EprdkygQQeeC3xFfzaC8MU1I4kxvwWaMs/mQ4lWUqWY=;
 b=QgbTBp7NIQ6cMjQpN9ajxDDhoxzEh3uB8E0xPXcX72UNdYf3NJAQMX2HmAolEzEQCl
 APJ9C/UfuCn5kvTUIkCcN3eOgy3d0WNKC4zdca3c0tNvyoDo5vpp31Bviol4UInGfPWM
 sIACr/f+bwjh+pKNVXolQnElxLlEcLNhIKmYhXOvo+Rgp6qz6rF6zXuIievOaQUMY8oD
 Ot7ptexOlSpzw+tA4Gvu9OKRvIz+CxeRf8y9hkBWePe9ACdGkaiKJmuI7oC5/CzVt/c/
 iqSdtGROS+v1QFwtpLBeBnUYJ2/Nydb+q208F74w1qbwtz0/kiZqxOvkI+To3yVcw6nM
 ewXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EprdkygQQeeC3xFfzaC8MU1I4kxvwWaMs/mQ4lWUqWY=;
 b=EuyH2kZdfnglla/rvq91o5A7JqvaApZhHf3sd10fdT0L6Y1Pouc+zGtYSKw+S3wsj5
 SaGiYgdmrXwIBUuxR3heyb7veIvl45UEu3fmn4mYv2Pdd2jvFHHmiTMuPODA2NdLNJ2i
 SRR1TKS+oK1aLAyjtQ9wo3rFTivq2ebf83c5zy996sNCD/KFEqDZvtqO6R0HmdQ2T9Sg
 QiIuk+Gwy7tdSKcLpX/divypsolpLWdgP0WfzhjeZRN8rAxY1+1eNWSY7HLMEp9LjB2f
 HcyKz0Bkhx4XUaOM8bzs+vvl5GGsOdsgNY1rFVmfVlqIy7Kez5MqfKuBR80/cTtxwjue
 rtxg==
X-Gm-Message-State: AOAM530p/i/6lJbyAqYgYqDDrx/OaPUefV6AqKqx+UfYVG7sjHdLvupf
 Kk1vUbOFAZBKo3SFOQuqFyC/PQ==
X-Google-Smtp-Source: ABdhPJxZLiuupBgjimOBLQ9o78NI5+Pncd6QzWuKFO7HA12438j7MXJ1/hp4hVpMp/a39pOJnz8tug==
X-Received: by 2002:adf:e688:: with SMTP id r8mr5166369wrm.20.1610136925233;
 Fri, 08 Jan 2021 12:15:25 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:24 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/40] drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs: Demote
 non-kernel-doc comment blocks
Date: Fri,  8 Jan 2021 20:14:31 +0000
Message-Id: <20210108201457.3078600-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: Eryk Brol <eryk.brol@amd.com>, Leo Li <sunpeng.li@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVn
ZnMuYzo2OTk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ20nIG5vdCBk
ZXNjcmliZWQgaW4gJ2RtdWJfdHJhY2VidWZmZXJfc2hvdycKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmM6Njk5OiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkYXRhJyBub3QgZGVzY3JpYmVkIGlu
ICdkbXViX3RyYWNlYnVmZmVyX3Nob3cnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jOjc0Mzogd2FybmluZzogRnVuY3Rp
b24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbScgbm90IGRlc2NyaWJlZCBpbiAnZG11Yl9md19zdGF0
ZV9zaG93JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX2RlYnVnZnMuYzo3NDM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBt
ZW1iZXIgJ2RhdGEnIG5vdCBkZXNjcmliZWQgaW4gJ2RtdWJfZndfc3RhdGVfc2hvdycKCkNjOiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVu
Zy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+CkNjOiBF
cnlrIEJyb2wgPGVyeWsuYnJvbEBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5j
CmluZGV4IDExNDU5ZmIwOWEzNzIuLmQ2NDVmM2U0NjEwZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMK
QEAgLTY5MSw3ICs2OTEsNyBAQCBzdGF0aWMgc3NpemVfdCBkcF9waHlfdGVzdF9wYXR0ZXJuX2Rl
YnVnZnNfd3JpdGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191cwogCXJldHVybiBzaXpl
OwogfQogCi0vKioKKy8qCiAgKiBSZXR1cm5zIHRoZSBETUNVQiB0cmFjZWJ1ZmZlciBjb250ZW50
cy4KICAqIEV4YW1wbGUgdXNhZ2U6IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRncHVf
ZG1fZG11Yl90cmFjZWJ1ZmZlcgogICovCkBAIC03MzUsNyArNzM1LDcgQEAgc3RhdGljIGludCBk
bXViX3RyYWNlYnVmZmVyX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQogCXJl
dHVybiAwOwogfQogCi0vKioKKy8qCiAgKiBSZXR1cm5zIHRoZSBETUNVQiBmaXJtd2FyZSBzdGF0
ZSBjb250ZW50cy4KICAqIEV4YW1wbGUgdXNhZ2U6IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkv
MC9hbWRncHVfZG1fZG11Yl9md19zdGF0ZQogICovCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
