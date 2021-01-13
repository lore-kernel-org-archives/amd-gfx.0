Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C8DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AE323102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AE323102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20BF6E160;
	Wed, 13 Jan 2021 08:24:40 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC926E072
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:23 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id g25so3132834wmh.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=alsh2XeMyr5vVnQexuCbyQHtivN65vIRA5rbHXO573w=;
 b=bAWrASxCiSIxj1El5h8krkYAGtj0IJjK+lCYw0nH5o2RjfHSgk0ZHTDO0HIz8u/tqc
 Q/APpYWn63o0iJIf3VvsgVszi1UJDVp9kK+p4Bcn9IwiCgpyWVunbd6MWRzkutYwWb2j
 EcU241Y6oQ5yZNLZqU7V6b13PA4HA1e5MutVOp3LXmfPXW1aV4VrKR03ORye61hY7xcl
 usBFwyWj28mKQb8w1sENpWdtj3EFbWU0s2qEl5ny4VZ7Oihw5ARTXm048YH4vYG7NEm1
 DVN6XvyP3lPeEIuw5M2Kcb5OAc0MkJIgsW4iS9ejHvm79tCm9F/vYlBU4Qogue5t2gMB
 JSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=alsh2XeMyr5vVnQexuCbyQHtivN65vIRA5rbHXO573w=;
 b=jHmtqkHZK224e1bBLTz40LESb90nB/sGbA9xMMU+z9NR6ZYl0Ro64kDcebM8467OFM
 j9Ij41p3hwJvZs2Oh/4wnkQ7Nqj6FELOHk8VP8laavoP4x9b6FVXdWQd0AnoEwU+ovli
 b1UBxg+uHw6bC2ZJP4EVx5b+BDvkFdJcUY08K6w/qz1V7rLuHTWAvNGQWnoDehLhLAa2
 qoE5UUOsctySmBd5kxHCI+1yshCENQE9+PGOW+GNsqn/RZRYgrU08Zq4iiiouF2t38xR
 KvChUE2ueAnJruAB0rsT0M57LX6fBm2rgqLZd7LCx8LySKUVASKcfLBnHcTRFI1FenN7
 DsFw==
X-Gm-Message-State: AOAM533ye9+G0nEnxrTSwB9L4PxCrMRQsiKEm3ckrGQXG/IvXspXQbof
 UxENyBZc5bVOKwyRWsQ/hdZmXQ==
X-Google-Smtp-Source: ABdhPJxBE6EKX9KnLlKhnuQMKm0+HEyRjhrH/tr0CQY+8sLNaK/sTurIqZUswjLTUQD2N40vYWuxTA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr941802wml.99.1610525302047;
 Wed, 13 Jan 2021 00:08:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:21 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/30] drm/amd/display/dc/core/dc_resource: Demote some
 kernel-doc abuses
Date: Wed, 13 Jan 2021 08:07:43 +0000
Message-Id: <20210113080752.1003793-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmM6MTcx
MDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnb2xkX3N0cmVhbScgbm90
IGRlc2NyaWJlZCBpbiAnZGNfaXNfc3RyZWFtX3VuY2hhbmdlZCcKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jOjE3MTA6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3N0cmVhbScgbm90IGRlc2NyaWJlZCBpbiAn
ZGNfaXNfc3RyZWFtX3VuY2hhbmdlZCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jOjE3MjY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ29sZF9zdHJlYW0nIG5vdCBkZXNjcmliZWQgaW4gJ2RjX2lzX3N0cmVh
bV9zY2FsaW5nX3VuY2hhbmdlZCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvY29yZS9kY19yZXNvdXJjZS5jOjE3MjY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ3N0cmVhbScgbm90IGRlc2NyaWJlZCBpbiAnZGNfaXNfc3RyZWFtX3NjYWxp
bmdfdW5jaGFuZ2VkJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9j
b3JlL2RjX3Jlc291cmNlLmM6MTg0Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1l
bWJlciAnZGMnIG5vdCBkZXNjcmliZWQgaW4gJ2RjX2FkZF9zdHJlYW1fdG9fY3R4JwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmM6MTg0
Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbmV3X2N0eCcgbm90IGRl
c2NyaWJlZCBpbiAnZGNfYWRkX3N0cmVhbV90b19jdHgnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYzoxODQzOiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdzdHJlYW0nIG5vdCBkZXNjcmliZWQgaW4gJ2RjX2Fk
ZF9zdHJlYW1fdG9fY3R4JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9jb3JlL2RjX3Jlc291cmNlLmM6MTg3MDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAnZGMnIG5vdCBkZXNjcmliZWQgaW4gJ2RjX3JlbW92ZV9zdHJlYW1fZnJvbV9jdHgn
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3Vy
Y2UuYzoxODcwOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICduZXdfY3R4
JyBub3QgZGVzY3JpYmVkIGluICdkY19yZW1vdmVfc3RyZWFtX2Zyb21fY3R4JwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmM6MTg3MDog
d2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc3RyZWFtJyBub3QgZGVzY3Jp
YmVkIGluICdkY19yZW1vdmVfc3RyZWFtX2Zyb21fY3R4JwoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxo
YXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFu
IEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyB8IDgg
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVz
b3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNl
LmMKaW5kZXggZDQyMzA5MmM0NWRjZC4uMTg1NDEyZDBjMTQyOSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCkBAIC0xNjk3LDcgKzE2
OTcsNyBAQCBzdGF0aWMgYm9vbCBhcmVfc3RyZWFtX2JhY2tlbmRzX3NhbWUoCiAJcmV0dXJuIHRy
dWU7CiB9CiAKLS8qKgorLyoKICAqIGRjX2lzX3N0cmVhbV91bmNoYW5nZWQoKSAtIENvbXBhcmUg
dHdvIHN0cmVhbSBzdGF0ZXMgZm9yIGVxdWl2YWxlbmNlLgogICoKICAqIENoZWNrcyBpZiB0aGVy
ZSBhIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvIHN0YXRlcwpAQCAtMTcxOCw3ICsxNzE4LDcg
QEAgYm9vbCBkY19pc19zdHJlYW1fdW5jaGFuZ2VkKAogCXJldHVybiB0cnVlOwogfQogCi0vKioK
Ky8qCiAgKiBkY19pc19zdHJlYW1fc2NhbGluZ191bmNoYW5nZWQoKSAtIENvbXBhcmUgc2NhbGlu
ZyByZWN0YW5nbGVzIG9mIHR3byBzdHJlYW1zLgogICovCiBib29sIGRjX2lzX3N0cmVhbV9zY2Fs
aW5nX3VuY2hhbmdlZCgKQEAgLTE4MzMsNyArMTgzMyw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXVkaW8g
KmZpbmRfZmlyc3RfZnJlZV9hdWRpbygKIAlyZXR1cm4gMDsKIH0KIAotLyoqCisvKgogICogZGNf
YWRkX3N0cmVhbV90b19jdHgoKSAtIEFkZCBhIG5ldyBkY19zdHJlYW1fc3RhdGUgdG8gYSBkY19z
dGF0ZS4KICAqLwogZW51bSBkY19zdGF0dXMgZGNfYWRkX3N0cmVhbV90b19jdHgoCkBAIC0xODYw
LDcgKzE4NjAsNyBAQCBlbnVtIGRjX3N0YXR1cyBkY19hZGRfc3RyZWFtX3RvX2N0eCgKIAlyZXR1
cm4gcmVzOwogfQogCi0vKioKKy8qCiAgKiBkY19yZW1vdmVfc3RyZWFtX2Zyb21fY3R4KCkgLSBS
ZW1vdmUgYSBzdHJlYW0gZnJvbSBhIGRjX3N0YXRlLgogICovCiBlbnVtIGRjX3N0YXR1cyBkY19y
ZW1vdmVfc3RyZWFtX2Zyb21fY3R4KAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
