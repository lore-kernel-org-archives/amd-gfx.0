Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C51C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BF561090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BF561090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47E96ECE2;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E2A6EC36
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:57 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso15026431wmm.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AktsaW6Bskrl1AG9i/afTuE+QfmnEvj7VSG37dmiSWQ=;
 b=AMLIuKLP7eSD0sQl6i4Ap0vsy36DUSOgzVtp8L5oSEfnpTJCzDcp/yKF22mI0y26sa
 SpDRKYEjS2uXTV5SIW5Vt8N8WRp8mz/NdmqBk3bbvU0awuGVjIZf8aKWVcK80HsUbptz
 RBz5KT8u+J8qZUe3iXi9/qnh67ZzNWd16LXytB8ttHMVFungJYt+R/wb8iI3y55ckGjo
 iKNvXoLB5a9wf23OAC6Jl3Gbg1005Vt3ykvMblCgbv4f3URaUYHZxKliCVHtiqPP2cgA
 gPQ8tMpzPPzPdJdyo/90eMDMW1QWpa13GO/7syQKyh+U67CCcZBpf2LETCS7N+LhXIpS
 ci6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AktsaW6Bskrl1AG9i/afTuE+QfmnEvj7VSG37dmiSWQ=;
 b=mzEIHNCQAazR+MgXmIfmaC9t10pXN/wyieNaORqFMXmSbGo8rJtblKFTWhMMt7/mBA
 OTJWrFcknZakfWeZOarmw9ghQXS4XTicgrTrpgkgEydunJKoobyfwTnhm6I6hhrX8dHz
 eaS2tf4BlXUUjssSp6Vx7S8AM5S0IwDUGUJL/g+YlBwQnmHSWaSB+udGmoN0ysdiYoMc
 tCs9UsO+6wbH12C1jVfAzSpS1xDqpu0g7D5CLxDOSP939wOXuF34jybjecU9LPv5aoeV
 WG1UT75LEUqBZUa3tGBwkomP2gE84HLRHlzZWqkSs3nnx+QoLUgRUSAiJe9VoayPYjG6
 7ixA==
X-Gm-Message-State: AOAM530h1GZpRTU1ZvWZND6CcPMSiV3qFtObakuXyLfmzLsYkQGmf3ZH
 ftqrxqQzxGeKqaq9WAs6PSrVwQ==
X-Google-Smtp-Source: ABdhPJwx3JNUrEk+A41Ghrk79W/6tF7/o6fr6xpd7rM4y6GJ9Wa2Ujsktlv5HTFdW68nwOBkfQ7m0Q==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr28003511wmi.101.1622018875645; 
 Wed, 26 May 2021 01:47:55 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:55 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 24/34] drm/amd/display/modules/hdcp/hdcp_psp: Remove unused
 function 'mod_hdcp_hdcp1_get_link_encryption_status()'
Date: Wed, 26 May 2021 09:47:16 +0100
Message-Id: <20210526084726.552052-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYzoz
NzQ6MjI6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYbW9kX2hkY3BfaGRj
cDFfZ2V0X2xpbmtfZW5jcnlwdGlvbl9zdGF0dXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoK
Q2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxz
dW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVs
ZXMvaGRjcC9oZGNwX3BzcC5jIHwgMTMgLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9t
b2R1bGVzL2hkY3AvaGRjcF9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1
bGVzL2hkY3AvaGRjcF9wc3AuYwppbmRleCAyNmY5NmMwNWUwZWM4Li4wNjkxMGQyZmQ1N2EwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3Bf
cHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNw
X3BzcC5jCkBAIC0zNzEsMTkgKzM3MSw2IEBAIGVudW0gbW9kX2hkY3Bfc3RhdHVzIG1vZF9oZGNw
X2hkY3AxX2xpbmtfbWFpbnRlbmFuY2Uoc3RydWN0IG1vZF9oZGNwICpoZGNwKQogCXJldHVybiBz
dGF0dXM7CiB9CiAKLWVudW0gbW9kX2hkY3Bfc3RhdHVzIG1vZF9oZGNwX2hkY3AxX2dldF9saW5r
X2VuY3J5cHRpb25fc3RhdHVzKHN0cnVjdCBtb2RfaGRjcCAqaGRjcCwKLQkJCQkJCQkgICAgICAg
ZW51bSBtb2RfaGRjcF9lbmNyeXB0aW9uX3N0YXR1cyAqZW5jcnlwdGlvbl9zdGF0dXMpCi17Ci0J
KmVuY3J5cHRpb25fc3RhdHVzID0gTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUF9PRkY7
Ci0KLQlpZiAobW9kX2hkY3BfaGRjcDFfbGlua19tYWludGVuYW5jZShoZGNwKSAhPSBNT0RfSERD
UF9TVEFUVVNfU1VDQ0VTUykKLQkJcmV0dXJuIE1PRF9IRENQX1NUQVRVU19GQUlMVVJFOwotCi0J
KmVuY3J5cHRpb25fc3RhdHVzID0gTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUDFfT047
Ci0KLQlyZXR1cm4gTU9EX0hEQ1BfU1RBVFVTX1NVQ0NFU1M7Ci19Ci0KIGVudW0gbW9kX2hkY3Bf
c3RhdHVzIG1vZF9oZGNwX2hkY3AyX2NyZWF0ZV9zZXNzaW9uKHN0cnVjdCBtb2RfaGRjcCAqaGRj
cCkKIHsKIAlzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCA9IGhkY3AtPmNvbmZpZy5wc3AuaGFuZGxl
OwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
