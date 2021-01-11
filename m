Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539ADC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08AB22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08AB22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E3D6E104;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F66489DDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:39 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id i9so943229wrc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VAJr/GrILhLZ43nh9MNYnDn6VtEAVAp1VLhyj8VjtZY=;
 b=ZKvYlOSzjGWKUDGJudDlR+nNT4HXGZeiYCmcLqgSbXIAWWaMK3TVGyu5ojYZStFVAk
 ucVfGCsMKfaal5fZbPscd/OGWdciwFyLxC9UiSU/y2BCZCdw1+y4SBDTXhDPKrHL36S6
 iBxBetqmGUNT5sVgq5B3rDMbiStK1hSZ/XcRTqC/G0/wurOtC9e+QSqZIxHackHdBx3u
 qg5ntYjG+SQu8YWCFi444oT7avvkhVrdmaV1RbjPqDIv9IxQHmekARKG2jax7yvLhTuW
 HJBjzy9NW7H5Fi2dWH+LIhE/mNsar4fIe37QvruE2KCfoEnKlOt4axe2jydNyMfaPcEG
 PLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VAJr/GrILhLZ43nh9MNYnDn6VtEAVAp1VLhyj8VjtZY=;
 b=lS4wQhnnr5UeV6lM8Ka1z6kRht10CAy5K6+QA9g5Ogy5io9OlwE+c79YWdXYhEKcgy
 yJ+volC/Ek7FIoLb+csxt8f5tnaBvKijHv4BsWoi6pvWw2kg2PehpYdaVgF28YAM8W/n
 h7aeKDApAVNW91Gx+Q4eYgR6MOCWn//qwEbvuLTtgNh2zJpmaqHIsd3wUqkPNq+f4GPp
 htO9qaR8H8qzOmdBR0ysRgxXQcWML5c5Cf752sT7QfJAi4kvx/hkbRMRgeIDX0WhOA7w
 NJScep5ujxoYwPUmvNsxdH0EeMHLrphdtAx/beKsN/6lmkfjzMlw5uMR52Dxztf6hhBe
 wObw==
X-Gm-Message-State: AOAM531WaRLwtnEddmcf3vjTL0i7ybR59DIQzINZZyKftu5pl2Jyp8K6
 LgiKhAYmlbM9SOXXTin9Mgtjhw==
X-Google-Smtp-Source: ABdhPJyLEv5ADsN6eDoo3NVId0gB3w6P/NI6vrkMSf6H7Uqh/VOpd2nc+kz2pDZ5kA3Irm/13zrPRQ==
X-Received: by 2002:adf:d201:: with SMTP id j1mr612338wrh.212.1610392778311;
 Mon, 11 Jan 2021 11:19:38 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/40] drm/amd/display/dc/gpio/diagnostics/hw_translate_diag:
 Include our own header containing prototypes
Date: Mon, 11 Jan 2021 19:18:52 +0000
Message-Id: <20210111191926.3688443-7-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X3Ry
YW5zbGF0ZV9kaWFnLmM6Mzc6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDi
gJhkYWxfaHdfdHJhbnNsYXRlX2RpYWdfZnBnYV9pbml04oCZIFstV21pc3NpbmctcHJvdG90eXBl
c10KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBM
aSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dw
aW8vZGlhZ25vc3RpY3MvaHdfdHJhbnNsYXRlX2RpYWcuYyAgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X3RyYW5zbGF0ZV9kaWFnLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od190cmFuc2xhdGVfZGlhZy5jCmlu
ZGV4IGJmOTA2ODg0NjkyNzEuLmU1MTM4YTVhOGViNWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X3RyYW5zbGF0ZV9kaWFnLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZGlhZ25vc3RpY3MvaHdf
dHJhbnNsYXRlX2RpYWcuYwpAQCAtMjQsNiArMjQsNyBAQAogICovCiAKICNpbmNsdWRlICJkbV9z
ZXJ2aWNlcy5oIgorI2luY2x1ZGUgImh3X3RyYW5zbGF0ZV9kaWFnLmgiCiAjaW5jbHVkZSAiaW5j
bHVkZS9ncGlvX3R5cGVzLmgiCiAKICNpbmNsdWRlICIuLi9od190cmFuc2xhdGUuaCIKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
