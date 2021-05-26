Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5BC4708C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4078E60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4078E60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574C66ECFA;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A03C6E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:40 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id 16so236494wmj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YRtghyBemkM1f6IZ3GpJkWOqFfzHliaTl7AQXunGZzc=;
 b=Y24P+kDZguBC+oVfwlOZFjooki7OrpJfb708/HImocxi6jC/uZws/ZGaZeCPgRGhsP
 6rH5ZxL4BMZNfhpJiJ4g9XZYsk6YsowF9AlC7gvmBOEjVd1FoWoo67zki9tmuOORdyc4
 SGdDw0BRw6nQ1CtrpdaCr0X3IS2WzJZs0HZ6AwQi1zhcuxR+rwOzbH2sbIuq5ZORCIeP
 yq97uTNUjojtB0lP0QMQsNZRkVT9jOrCJu+Doa5X69vt5c6nB+i0o/f+KRMc+AV5jE1Q
 rkYALgXhiGAs5SFxc/CIMVtGA+ypcoa6H5FoJ/9EGVWi9SpMhDkZxDwhgUoc2YLpQnab
 LzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YRtghyBemkM1f6IZ3GpJkWOqFfzHliaTl7AQXunGZzc=;
 b=GGksvO87mTkae2y0TU4EsAcjm5xMDrXnEfSplrdhisj+eNebaTMhEHsObJ5c3bLIZW
 KbY4jZt/1l/jFbKfvBTnbN37wb+kUZaUc4YHuskC0EB4JGh2xQ6it26r2Y71qAgjCK2s
 hefaXPxld0HutCA58Fakpci5yraGdy3BAqEbe36eUriXqYw8nNl6JhW7uBVXm+jmmznj
 uqM/IhQ1ga+iPVcLhNV7kIwloNTgSU0w3J0F8K6lyAKWv3EIjiFQemv+P69KxKkoVGvt
 IBWha8RBu5iKWqX1xh9ZL74QqMG/Bv4MNGepA7hCcFbMZqcBEzpI8vHLEtFbrv2SA0ly
 IXjA==
X-Gm-Message-State: AOAM533N7+jrx5SzEtCec1+5RcuNuS+ayl/S13TrJV/jO4BFBRiEXZb2
 eNI9D0kebhbtXI3G0cLubpnSaw==
X-Google-Smtp-Source: ABdhPJx9vfcxXeT3oxlu5PcMyEPJqgiMaOfRGR7HD4cfqeoJ6OCvXxTjHoGViev/C4hAPtm4WP+X6g==
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr2365738wms.150.1622018858606; 
 Wed, 26 May 2021 01:47:38 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:38 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/34] drm/amd/display/dc/bios/command_table_helper: Fix
 function name for 'dal_cmd_table_helper_transmitter_bp_to_atom()'
Date: Wed, 26 May 2021 09:47:00 +0100
Message-Id: <20210526084726.552052-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVs
cGVyLmM6MTI3OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciB0cmFuc2xhdGVfdHJh
bnNtaXR0ZXJfYnBfdG9fYXRvbSgpLiBQcm90b3R5cGUgd2FzIGZvciBkYWxfY21kX3RhYmxlX2hl
bHBlcl90cmFuc21pdHRlcl9icF90b19hdG9tKCkgaW5zdGVhZAoKQ2M6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2Zm
LWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlci5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZV9oZWxw
ZXIuYwppbmRleCA1Yjc3MjUxZTA1OTA5Li5lMzE3YTM2MTUxNDc3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlci5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVs
cGVyLmMKQEAgLTExNCw3ICsxMTQsNyBAQCBib29sIGRhbF9jbWRfdGFibGVfaGVscGVyX2NvbnRy
b2xsZXJfaWRfdG9fYXRvbSgKIH0KIAogLyoqCi0gKiB0cmFuc2xhdGVfdHJhbnNtaXR0ZXJfYnBf
dG9fYXRvbSAtIFRyYW5zbGF0ZSB0aGUgVHJhbnNtaXR0ZXIgdG8gdGhlCisgKiBkYWxfY21kX3Rh
YmxlX2hlbHBlcl90cmFuc21pdHRlcl9icF90b19hdG9tIC0gVHJhbnNsYXRlIHRoZSBUcmFuc21p
dHRlciB0byB0aGUKICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29ycmVz
cG9uZGluZyBBVE9NIEJJT1MgdmFsdWUKICAqIEB0OiB0cmFuc21pdHRlcgogICogcmV0dXJuczog
b3V0cHV0IGRpZ2l0YWxUcmFuc21pdHRlcgotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
