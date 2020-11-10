Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C37C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A634F20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2cAylpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A634F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983D589C8D;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD5089BFE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:34 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d142so4345115wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OiQsD+EhT8Lfi4WTa7HEKxexbw01KKvzh7y2CIqIZUI=;
 b=w2cAylpRUwyxpJxnkGOH1jYHVFj+w4ZCRrbjx0+dHVK/k1SkFYcPeOrIv+gyvgruNi
 Y9pmut0MJLCqKVCoxh64xgrnCLtmBui1QC8BuC7C9/SyEufCphx7aeEWfu9jvC3U9III
 ZceExYSW02hI3ANgMEoVc/gxUujRkVafXEX36lKkxEJdphEcj+Nt4JFH1GUruisyFyb+
 29utA9JZezZormWyyDou7bDSGqHFbvgM5R5KhivIJLJ50sK25XDmyMYhwevxCu0Ro86Q
 gL5NDS6YAntMe0J1XRsZ/gdpqa72ODvsBFQ7YoDDIP0oYwu/XnoqidkCr8GBJVcGfCnd
 WUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OiQsD+EhT8Lfi4WTa7HEKxexbw01KKvzh7y2CIqIZUI=;
 b=CxqP4KXbGFVlWA74A1heLHBfK5yfda+bjxY50vWq/XFjiV+v8XBnIZkGnSQB3eKXzJ
 Ehu7W/F88BJZlhxdAUzVIQIr2qSphCDq3hGonX9iEhKJhnH8AOoIIZHBiwEJUIdh1HQo
 hFCEhjh4HK+QrZXpcmoj4FCeTrFCHjGGKeFpfeexfggx/7xrttON2sgiWzT00osDcocT
 jtOCent7fof3ftUjhAQoBydfPlKA46OB7bL7LTKRnkViZkfyYwIVPK0k5AedOIY9t/bI
 SEAOUZXYifaPU9ybh7lWg5ADbo/sJGlh36GC0SalCQcjPfJA0sSt2B4td+BpxOGi0+si
 leKw==
X-Gm-Message-State: AOAM530nNmguHz8Dj9dzyu3CPgJEAItissg4+CjbgRPzjCmm/BnmeNQJ
 g6Hb9HaqzQCREl2MCqZp1+vGbw==
X-Google-Smtp-Source: ABdhPJxCAbP1NBquixJByR3TRuiCtWqX8gVya2e2rBLdVzy1l0jSVoFnzm7ZOkv+OY8g7NTUfw0erw==
X-Received: by 2002:a1c:660b:: with SMTP id a11mr663260wmc.159.1605036692771; 
 Tue, 10 Nov 2020 11:31:32 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:32 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/30] drm/radeon/radeon_mn: Supply description for 'cur_seq'
 even if it is unused
Date: Tue, 10 Nov 2020 19:30:55 +0000
Message-Id: <20201110193112.988999-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbW4uYzo1MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAnY3VyX3NlcScgbm90IGRlc2NyaWJlZCBpbiAncmFkZW9uX21uX2ludmFs
aWRhdGUnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX21uLmMgfCAxICsKIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX21uLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9tbi5j
CmluZGV4IDk3YjliNmRkNmRkM2IuLjNjNGM0MjEzYTdiNTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX21uLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fbW4uYwpAQCAtNDEsNiArNDEsNyBAQAogICoKICAqIEBtbjogb3VyIG5vdGlmaWVyCiAg
KiBAcmFuZ2U6IHRoZSBWTUEgdW5kZXIgaW52YWxpZGF0aW9uCisgKiBAY3VyX3NlcTogdW51c2Vk
CiAgKgogICogV2UgYmxvY2sgZm9yIGFsbCBCT3MgYmV0d2VlbiBzdGFydCBhbmQgZW5kIHRvIGJl
IGlkbGUgYW5kCiAgKiB1bm1hcCB0aGVtIGJ5IG1vdmUgdGhlbSBpbnRvIHN5c3RlbSBkb21haW4g
YWdhaW4uCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
