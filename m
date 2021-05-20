Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72062C43611
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7DE61001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7DE61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C1A6F463;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AD26F418
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:34 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 f6-20020a1c1f060000b0290175ca89f698so5255145wmf.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nynxxR/OsBCzgQqs0HwpEzxLm2OUnGw35ueUBnmCZ5g=;
 b=UVushAvSHMxa0C5XeIr0bdnDeei0Y1WMhTJYIgy8dRMkWcdNb44elX1h9GjF+D91/g
 3k64urbysVJKIrBU6PzA9VQ3NsXOwtgj13lRJYOyJYsJA3e0j/9qshxBzBZ6TtR5YRPe
 y/FRBOgs+Ef7wwJovho+qJW4lgNU1EePROSRQxihFEpoh+ATXkOFcIUpzwu4AUnPeVOm
 EeRD4yDhkcOrQtK2qkzw9DlMihFqF2Kcnh/TOt5xZU2mcps7qvrMLId8Ald+2NeO/5nr
 4koCiRAM+2HJ0uXudQpe77PWXptcGWavHthevwz9C/nmG0EBxHYBX7QkwZ5OVHTnadHs
 /Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nynxxR/OsBCzgQqs0HwpEzxLm2OUnGw35ueUBnmCZ5g=;
 b=OQYUsCl1YHC5KEFTBPoAHIA2d83pqBDbo6nMSHvRzPxPML36C5Akq5UWzUvxrkBozY
 fXMvjIUietPHl6s39aumEQF8KUb4LHO4U/EfD+szKthvx4BAkz55wP9Y0zMHkHp1vqG+
 f5REqvyhn5Uw1l10sq8irGJuTd+dXy9n9i8Hv+ceHfWEpyKXxKohVdMfgbvLZ9x+Jnmk
 KjsMHsC9mtYmwZVrYV4U5GftC7HSIbSw4aeZZBxNoS+v4es7R8oCdLzIwEqUHbVYgOjj
 jyzXaXK20bxBGfpkryRaDZgoX3fsrJDYR4f0BgaQjFOo8/W1mHapq3XZI6xA+p1L+4NL
 +kzg==
X-Gm-Message-State: AOAM533YSXBycDQR88UrfAxInEdFCleqeCCeMlAyUX8aDIHnWxUjErfJ
 mK7PqjSSSvzX1ILQe6+cNGPtdw==
X-Google-Smtp-Source: ABdhPJwMr2S46p+INbbf4IlG3gi+W3uNAXiPXWi5P3w8PnLPD7lw+1iFRHCGlUXFBNZ3FsCYsPxzCA==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr3317496wmq.138.1621512213083; 
 Thu, 20 May 2021 05:03:33 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:32 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/38] drm/amd/amdgpu/sdma_v2_4: Correct misnamed function
 'sdma_v2_4_ring_emit_hdp_flush()'
Date: Thu, 20 May 2021 13:02:41 +0100
Message-Id: <20210520120248.3464013-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmM6MjgxOiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBzZG1hX3YyXzRfaGRwX2ZsdXNoX3JpbmdfZW1pdCgpLiBQcm90b3R5cGUg
d2FzIGZvciBzZG1hX3YyXzRfcmluZ19lbWl0X2hkcF9mbHVzaCgpIGluc3RlYWQKCkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNl
bXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YyXzQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjJfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92Ml80LmMKaW5kZXggOWYwZGRhMDQwZWM4OC4uNDUwOWJkNGNjZTJkNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80LmMKQEAgLTI3MSw3ICsyNzEsNyBAQCBzdGF0aWMgdm9p
ZCBzZG1hX3YyXzRfcmluZ19lbWl0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKIH0KIAog
LyoqCi0gKiBzZG1hX3YyXzRfaGRwX2ZsdXNoX3JpbmdfZW1pdCAtIGVtaXQgYW4gaGRwIGZsdXNo
IG9uIHRoZSBETUEgcmluZworICogc2RtYV92Ml80X3JpbmdfZW1pdF9oZHBfZmx1c2ggLSBlbWl0
IGFuIGhkcCBmbHVzaCBvbiB0aGUgRE1BIHJpbmcKICAqCiAgKiBAcmluZzogYW1kZ3B1IHJpbmcg
cG9pbnRlcgogICoKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
