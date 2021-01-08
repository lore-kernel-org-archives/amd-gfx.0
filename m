Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA7DC4332B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28862399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28862399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF816E909;
	Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186966E8E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:56 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id a6so8732562wmc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qIhMmTlrgLqGKZHl8cf8zzphKFqEw09UTmu2NuirXK8=;
 b=i15bgqSq9ykGyz3gETyCT7w+EtHlx00MftV3j03IlIh377fbzIy+8wNbC6kfg0Txi6
 MVyYPJhXGEOWYgkShWn/U2+kiLs9a1CXSRknF3aZeUg6F2AJI7WFtapb4NoNF59k3+IY
 pHJ3u7G9Ytbq7xjqL80iGO2CxSF6zikmkWHaZhwnsMdPwp+4hHUj8dJe84C3u9XjsSqI
 zVBLkvbRa/EBuAsT4KBWrk/fL2Fupd7vj9HgeeoC0KYkR+hZQWvmq1hDw/U9JY6IS6pG
 IbRGIRUn+cTUiwoT/c9lNtoqm7qDm9V2gkvsUS5Qy4CfKVfoH/z+X0pKBz4xwGHzOUXo
 +kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qIhMmTlrgLqGKZHl8cf8zzphKFqEw09UTmu2NuirXK8=;
 b=QOj0/YYs8EyrEZ1mmD1jiQk1mpHeR7pXPUGqjnp1itlWttgRLBjqZGqhwcGuAdZ7Lt
 aInFv9JH3V+ToVKmeR9/a4sj+8T3BntIQrVuTnmwSRxzAn/sWFWcpxEyG0SpNKZxr8z4
 JokFdnM5FsuFvA0ACdV7Di4y1unTWQez8NfvZftqNEPyOR28lntEOQx5rSwdAd4wOEgP
 vW8DZxgXAlprGD8v4397Xjo2bVrQxJ+uGKV5ujANdbGWFFkiMK7OmmA2ZxO/EpTavDcx
 zfcstgD1BY6rObqKOJ/n2Hw76lMQ5P+beAbUC2ZktgUd6Q+M+x/95/am1fqoJeyI8xk4
 0BCg==
X-Gm-Message-State: AOAM531KJ9oAYDfEGJv5WomoaA6WSNjMg5Szg5M6VPiEWjmaCBts3Y3I
 p/6XZMSCW6yd3H4xGJD0jZziRw==
X-Google-Smtp-Source: ABdhPJxmWksPcclm4wz0bxTyjDV49a125dTEZ+hkFdDIjT796ez7ZjUCcvThJZrXg4TXponqtUxAIg==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr4496283wmb.146.1610136954798; 
 Fri, 08 Jan 2021 12:15:54 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:54 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 35/40] drm/amd/display/dc/bios/command_table: Remove unused
 variable and associated comment
Date: Fri,  8 Jan 2021 20:14:52 +0000
Message-Id: <20210108201457.3078600-36-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYzog
SW4gZnVuY3Rpb24g4oCYYWRqdXN0X2Rpc3BsYXlfcGxsX3Yy4oCZOgogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYzoxNDYyOjExOiB3
YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYcGl4ZWxfY2xvY2tfMTBLSHpfaW7igJkgWy1XdW51
c2VkLXZhcmlhYmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
PgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Nv
bW1hbmRfdGFibGUuYyB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90
YWJsZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJs
ZS5jCmluZGV4IGRkODkzYTExNzY5NzkuLjY2ZmUxZDE4MTA3ODkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlLmMKQEAgLTE0NTcs
MTAgKzE0NTcsNiBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgYWRqdXN0X2Rpc3BsYXlfcGxsX3Yy
KAogewogCWVudW0gYnBfcmVzdWx0IHJlc3VsdCA9IEJQX1JFU1VMVF9GQUlMVVJFOwogCi0JLyog
V2UgbmVlZCB0byBjb252ZXJ0IGZyb20gS0h6IHVuaXRzIGludG8gMTBLSHogdW5pdHMgYW5kIHRo
ZW4gY29udmVydAotCSAqIG91dHB1dCBwaXhlbCBjbG9jayBiYWNrIDEwS0h6LS0+S0h6ICovCi0J
dWludDMyX3QgcGl4ZWxfY2xvY2tfMTBLSHpfaW4gPSBicF9wYXJhbXMtPnBpeGVsX2Nsb2NrIC8g
MTA7Ci0KIAlicC0+Y21kX2hlbHBlci0+ZW5jb2Rlcl9pZF90b19hdG9tKAogCQlkYWxfZ3JhcGhp
Y3Nfb2JqZWN0X2lkX2dldF9lbmNvZGVyX2lkKGJwX3BhcmFtcy0+ZW5jb2Rlcl9vYmplY3RfaWQp
KTsKIAlicC0+Y21kX2hlbHBlci0+ZW5jb2Rlcl9tb2RlX2JwX3RvX2F0b20oYnBfcGFyYW1zLT5z
aWduYWxfdHlwZSwgZmFsc2UpOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
