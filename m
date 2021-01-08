Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A62C432C3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25662239A1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25662239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F248C6E908;
	Fri,  8 Jan 2021 20:24:23 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DBA6E8CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:30 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id c133so8745470wme.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w+rKqjsgsMRrWlbR0mS6qqZSklymAWueG82I2hOJ6Ds=;
 b=UjObcNpLmHgcVOeAiK1W8DH7qr/VTvKYYZvqwqgnSssxmyVRRzsJZmTvoKlwdQs01J
 NH7S9Mex2LrJ2/AaEUzm3rNqG8I12C/Xpj1PsvDO1wyi8oGualF6qkSrVPunrDULTTom
 xWhM/2mwjk08/4+J6spoCMxRTl9G0Gw/r0h4588xd8hz4X9VkBA/dx45Yd8tNUUewq6e
 zPICIlZTExobP1md8Ivtbr/c55KpzqTHL5gUtGhOv3CbcwSOfFoXTfvsHz6wLvTGD+4T
 4JJku0UmibFovBql4Ll+pwP24pQJS2iS/Ra4slhfru8dhDevYzSAhuUjzHo1VmJinivG
 6x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w+rKqjsgsMRrWlbR0mS6qqZSklymAWueG82I2hOJ6Ds=;
 b=jWokHL+ZCxzDqs569D2tv33RL+HKn8MqZW9a1BpXvl3QjDSmUtbS7IJKhB38UiEnp2
 sUsznFHznRxIk+aA6Hgs9oCYMzzItDF+gx3ZxcwkQZOXmv8pGI7pKMFjjeRzCWlrKuAn
 ALDSGKxN60G+xdBcCJtTKgZumE4gZKO31hJgLvvGte2e/qDQ0IW5iU6RLBFTpQn9+HOh
 wZMYbobovKWHAK/v/uI8QcBDHeJdcpByScRb1aHe4efeD7eWUUYpH9X5h8YCUrTG3vCL
 RyWWTxSuiXGA37La6/lFnEDYYEWkCMVo9HDZSe9USDaXjnmsQoIGDPDGhQ8C5fVX2mrW
 92lA==
X-Gm-Message-State: AOAM5312wn7dseFW2NFjbEkiGS0Bn/bZLeoDZDiFb7SAU0iXObk9GcDu
 +v6i+oTmuBnfWSQiw6qkkHxflg==
X-Google-Smtp-Source: ABdhPJzB7xilZqzkaJwNBTqYl/8XOYXzJhHqfV3T6uGCy6KkEdJfdWEONiV4H4I/V6KCmnexrpAfPw==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr4508553wmc.186.1610136929497; 
 Fri, 08 Jan 2021 12:15:29 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:28 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/40] drm/amd/display/dc/bios/bios_parser: Make local
 functions static
Date: Fri,  8 Jan 2021 20:14:34 +0000
Message-Id: <20210108201457.3078600-18-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, Igor Kravchenko <Igor.Kravchenko@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmM6MjU4
ODoxNjogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJh1cGRhdGVfc2xvdF9s
YXlvdXRfaW5mb+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYzoyNjkyOjE2OiB3YXJuaW5n
OiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGdldF9icmFja2V0X2xheW91dF9yZWNvcmTi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IElnb3IgS3JhdmNo
ZW5rbyA8SWdvci5LcmF2Y2hlbmtvQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKaW5kZXggMjNhMzczY2E5NGI1Yy4u
ZjA1NGM1ODcyYzYxOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2Jpb3MvYmlvc19wYXJzZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Ymlvcy9iaW9zX3BhcnNlci5jCkBAIC0yNTg1LDcgKzI1ODUsNyBAQCBzdGF0aWMgc3RydWN0IGlu
dGVncmF0ZWRfaW5mbyAqYmlvc19wYXJzZXJfY3JlYXRlX2ludGVncmF0ZWRfaW5mbygKIAlyZXR1
cm4gTlVMTDsKIH0KIAotZW51bSBicF9yZXN1bHQgdXBkYXRlX3Nsb3RfbGF5b3V0X2luZm8oCitz
dGF0aWMgZW51bSBicF9yZXN1bHQgdXBkYXRlX3Nsb3RfbGF5b3V0X2luZm8oCiAJc3RydWN0IGRj
X2Jpb3MgKmRjYiwKIAl1bnNpZ25lZCBpbnQgaSwKIAlzdHJ1Y3Qgc2xvdF9sYXlvdXRfaW5mbyAq
c2xvdF9sYXlvdXRfaW5mbywKQEAgLTI2ODksNyArMjY4OSw3IEBAIGVudW0gYnBfcmVzdWx0IHVw
ZGF0ZV9zbG90X2xheW91dF9pbmZvKAogfQogCiAKLWVudW0gYnBfcmVzdWx0IGdldF9icmFja2V0
X2xheW91dF9yZWNvcmQoCitzdGF0aWMgZW51bSBicF9yZXN1bHQgZ2V0X2JyYWNrZXRfbGF5b3V0
X3JlY29yZCgKIAlzdHJ1Y3QgZGNfYmlvcyAqZGNiLAogCXVuc2lnbmVkIGludCBicmFja2V0X2xh
eW91dF9pZCwKIAlzdHJ1Y3Qgc2xvdF9sYXlvdXRfaW5mbyAqc2xvdF9sYXlvdXRfaW5mbykKLS0g
CjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
