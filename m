Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7366C433E9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD4A22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD4A22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8486E102;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D9089F6F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:12 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id y17so903166wrr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m6qinHvszbHKv20eCXlyTbSvavsiU8PbuOK8tq0MfV4=;
 b=U5WrAgLJ8zefgyYItfLqzBpx5oezBJvkiQLUCDgp7ycKfwDXDoTHty7FA+6ZV6b97D
 NN8TEmkq6DHq42uIgNLTOIEbRfkfbccMZETj/PMttJ2Y98DpPLI7id8ONWPkZT731Swt
 hJJbrMWLZs18go/1pgQ7/kTCSsK0LKmq1XTQYWl3hcHa9ku9VZArcO/7bdZBuG24mUHU
 jAsVtScfwlqZe499JuK+JNDp8T/I9067L96PqehBzZQY3UhKNs+wF/BO/EZyNbuy46m7
 DLB9O/gv8+AwO5AWSR0m98Ok8PU080KcvTE0cbgwxMiXuFobeFEEJbPYMBsdP5jApnat
 Z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m6qinHvszbHKv20eCXlyTbSvavsiU8PbuOK8tq0MfV4=;
 b=t93jOw9971HceJrEX0d7+6ZjNbnDhpLk7tQNvOVjipV7KOAvHb8rdFbZIWjEUmIV5a
 L4UNbWlzeZ492vUoLcZIBgkTu+wISu5DS4e8sUkj3PsPEIAT2rn25GbyU0XzZvsNVQuQ
 Q+jQHRcYNs4LllV9NKWsZg3kWO+YrHWP/cPHoX0K62YARFT640EdXaCE/OeSINhV6cN3
 i4BhV2btUDb8cdgxDVmRDaEEbtXysffWHHqSlZ7yaZ/rXjjw7NPEXu+7NzoivkEGHf+3
 KgSglK6UMaF7sGGQgFFxgAzt9oflc6PVLqN0S6H4f4JvecwazmGqdWIxV6jcVgPGDM2M
 bjLw==
X-Gm-Message-State: AOAM530+urrIPpf9+83XQKLptdI3SjToMeKpHbULnggHY/QmZrISTvEY
 X7uqbn/R666c4aIuFtAHeJOOJQ==
X-Google-Smtp-Source: ABdhPJw9iB23UMo+bsaBTwuBmXwlBwb8fjpQuEWOiOMMgFvtZM8pnezg4Eom59nkxXii3Xp2BqKlnw==
X-Received: by 2002:adf:d085:: with SMTP id y5mr606162wrh.41.1610392810705;
 Mon, 11 Jan 2021 11:20:10 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/40] drm/amd/display/dc/dce110/dce110_mem_input_v: Include
 our own header, containing prototypes
Date: Mon, 11 Jan 2021 19:19:17 +0000
Message-Id: <20210111191926.3688443-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX21lbV9pbnB1
dF92LmM6MTAzNDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEx
MF9tZW1faW5wdXRfdl9jb25zdHJ1Y3TigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX21lbV9pbnB1dF92LmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX21lbV9pbnB1dF92LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9tZW1faW5wdXRfdi5j
CmluZGV4IDE5YjE5NzYxMzliNjkuLjhiYmI0OTkwNjdmNzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX21lbV9pbnB1dF92LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfbWVtX2lucHV0X3Yu
YwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgImluYy9kY2VfY2FsY3MuaCIKIAogI2luY2x1
ZGUgImRjZS9kY2VfbWVtX2lucHV0LmgiCisjaW5jbHVkZSAiZGNlMTEwX21lbV9pbnB1dF92Lmgi
CiAKIHN0YXRpYyB2b2lkIHNldF9mbGlwX2NvbnRyb2woCiAJc3RydWN0IGRjZV9tZW1faW5wdXQg
Km1lbV9pbnB1dDExMCwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
