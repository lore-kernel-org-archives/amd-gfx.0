Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7615CC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAB92399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAB92399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406176E900;
	Fri,  8 Jan 2021 20:24:19 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3CC6E8E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:16:03 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id c124so8713831wma.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rP7mCQegZrZliKSNOE9HhwYeP/t/E6ng+qbUeSsHO9Y=;
 b=homuTJBMLHVxCdzu4xZUN8TgcpEBe07I94kMyeGYMSl7Qgq1qQUc6vh772KKH/7CE4
 jZX7owmzqV8sN9KKvFWA6BrOu0vo3LI9MCr8+l9YCM6aXjuZAs/zkym4Z1S77ihJxS84
 Ly21nzv+rhn4a5PZP837gJI+vKJCphVrU2OMYvLeNravR3zu74QNKK94KT4dLF+W/9dp
 +WBS/y3XlVzEsOYfoAWk69kPFPH+33qM/VxzJsen0OcLde4/9SYtQjKIrV+Ox+nUTgRG
 if8rEJarsSzEx3PAfevqPkBc+Cu5/tDIYkHh7o3JbqTg0vfC5Qqw7CvmQqG98S9qoPKU
 L50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rP7mCQegZrZliKSNOE9HhwYeP/t/E6ng+qbUeSsHO9Y=;
 b=FMsnGiaGeNDDwB8UPtHhmmgAMJqjhQXrCFk6ay8pVX0ZWh6hkVMtvgjRJlcVhjJGyi
 P2X2BNwTIoubTO6LgWf4wX2tipd8y5HoryEcv3r9OalyeQw0It/iJZO5cvGRoQm4X4B4
 wxbTtJQNg+byteHOQGgM3lsqUzn1XU520A8MK/cS9BjmqrHk5nyLXtGfFX7WpX9Gu9XQ
 ZCsNf9L8wWdotMsspkPcQYq4KQZHNxeNJYekf0J77nKziYpPv68Y96rdvdGxW6EGhMI/
 g1a59ZmwhH0jYhqM65Wzfr51K/GEWdpzaB1TpqlJW7ObCLBiRuuUCmDAH4V4amw1IT3+
 DPzQ==
X-Gm-Message-State: AOAM531kNsLHAkO2FE+M3YX9i8ivOIMyvogTS4cyk6gvU2wVDvo8u97A
 ZyOdqsSBWypDkNLk5WQ5TYPgcg==
X-Google-Smtp-Source: ABdhPJzStlWtL4Clq/FRpULdR+OZSgHo1I1acWGIRRA/RpNAf6ipLFu7crmMKMXh2Ch4tl65qHs7ZA==
X-Received: by 2002:a1c:bc41:: with SMTP id m62mr4606670wmf.46.1610136962529; 
 Fri, 08 Jan 2021 12:16:02 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:16:01 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 40/40] drm/amd/display/dc/gpio/hw_factory: Delete unused
 function 'dal_hw_factory_destroy'
Date: Fri,  8 Jan 2021 20:14:57 +0000
Message-Id: <20210108201457.3078600-41-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2h3X2ZhY3RvcnkuYzoxMjM6
Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkYWxfaHdfZmFjdG9yeV9k
ZXN0cm954oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2h3X2ZhY3RvcnkuYyB8IDE0IC0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vaHdfZmFjdG9yeS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vaHdfZmFjdG9yeS5jCmluZGV4IGRhNzNi
ZmIzY2FjZDAuLjkyYzY1ZDJmYTdkNzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9ncGlvL2h3X2ZhY3RvcnkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZ3Bpby9od19mYWN0b3J5LmMKQEAgLTExOSwxNyArMTE5LDMgQEAgYm9vbCBkYWxf
aHdfZmFjdG9yeV9pbml0KAogCQlyZXR1cm4gZmFsc2U7CiAJfQogfQotCi12b2lkIGRhbF9od19m
YWN0b3J5X2Rlc3Ryb3koCi0Jc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKLQlzdHJ1Y3QgaHdfZmFj
dG9yeSAqKmZhY3RvcnkpCi17Ci0JaWYgKCFmYWN0b3J5IHx8ICEqZmFjdG9yeSkgewotCQlCUkVB
S19UT19ERUJVR0dFUigpOwotCQlyZXR1cm47Ci0JfQotCi0Ja2ZyZWUoKmZhY3RvcnkpOwotCi0J
KmZhY3RvcnkgPSBOVUxMOwotfQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
