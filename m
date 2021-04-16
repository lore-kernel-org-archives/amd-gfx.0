Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD4C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47B760238
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47B760238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6C06EC7E;
	Fri, 16 Apr 2021 16:57:24 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307C66EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:38:06 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id n2so42447624ejy.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I8mWOth0SK24IkrgdA5t1Y60F5TC0397g52f7X8Rsig=;
 b=YgMDFePlDrbu+lfm/PqgYEnXq98IKmEE0loDCtjkfHsTCMpAqMSDSjSYx714+3DxwP
 sqWegEyqCp6hLKtv9sHQ3EY82v4t8frAeIWli699zbPAb40ZEiBEaw4QPxu4w63nO9cB
 KHuWXBQLE38YoaknaLtK242G6dcoG3qqnb4sXYX5R1NGPq/CEXHvxiHxdnLKTkhav9VT
 d5PwX9lVNlJCGvNS/uKWUMm0C3PLBjQW4xtOybaxuBcKZOVkTF1eiTg3+dod3uTSasqB
 6BDP78jpXknUPSDKOij9kcO1wkGkQeV+VEcLB6h7VbZ6fQUxzDiymRrTsnO2qA7yYH1c
 CIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I8mWOth0SK24IkrgdA5t1Y60F5TC0397g52f7X8Rsig=;
 b=qRjwwtONPddSXBt1Aukbcl/EHDOu2y3oP+xuy5HL3+zGbSpTL8q8Fk0zE1lyxFlaev
 jHB1t+mxytufBUrJQqClUsoTeQgmk3aYZhJIH8xwj8f/pluPLzG+55GS8x4cletLcU+N
 ya3KATqt/cqL6qKgj9kppFzNd7cB8eYTBIcgFSsIm5OVISiw9OjxRTIriYZ4RAsc1riy
 3lHnroOgJqCysMyVBdjfLo5JJXdO/EOBQfvXExiB+m9faXC1mtw2YGLPv0gh/IMKuPb0
 8s6ncX5XHNcmlRjX5KNljaNvU7LcvHLC3m9+MJ69ueAKKm9eeSIRYr1YqAPxgkebGNHW
 PoeA==
X-Gm-Message-State: AOAM532kd8euunBWv4qBRFivvoekK/+51GjSydtL2NUKya5m1bvTMPSo
 LZvN4fkvlvKNvhmCch8fTrBp9g==
X-Google-Smtp-Source: ABdhPJwB+j4w26WCbdC8MZ2fDdqzcj3geypeOzbRKQYNfP0KVkmEKSezvqx2DhR7+h5BUh8BM1TP8A==
X-Received: by 2002:a17:907:9691:: with SMTP id
 hd17mr8782424ejc.205.1618583884824; 
 Fri, 16 Apr 2021 07:38:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 07:38:04 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 33/40] drm/amd/amdgpu/amdgpu_ring: Provide description for
 'sched_score'
Date: Fri, 16 Apr 2021 15:37:18 +0100
Message-Id: <20210416143725.2769053-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 16:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzoxNjk6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ3NjaGVkX3Njb3JlJyBub3QgZGVzY3JpYmVkIGluICdhbWRn
cHVfcmluZ19pbml0JwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5jCmluZGV4IDY4ODYyNGViZTQyMTEuLjdiNjM0YTE1MTdmOWMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwpAQCAtMTU4LDYgKzE1
OCw3IEBAIHZvaWQgYW1kZ3B1X3JpbmdfdW5kbyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAg
KiBAaXJxX3NyYzogaW50ZXJydXB0IHNvdXJjZSB0byB1c2UgZm9yIHRoaXMgcmluZwogICogQGly
cV90eXBlOiBpbnRlcnJ1cHQgdHlwZSB0byB1c2UgZm9yIHRoaXMgcmluZwogICogQGh3X3ByaW86
IHJpbmcgcHJpb3JpdHkgKE5PUk1BTC9ISUdIKQorICogQHNjaGVkX3Njb3JlOiBvcHRpb25hbCBz
Y29yZSBhdG9taWMgc2hhcmVkIHdpdGggb3RoZXIgc2NoZWR1bGVycwogICoKICAqIEluaXRpYWxp
emUgdGhlIGRyaXZlciBpbmZvcm1hdGlvbiBmb3IgdGhlIHNlbGVjdGVkIHJpbmcgKGFsbCBhc2lj
cykuCiAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgZXJyb3Igb24gZmFpbHVyZS4KLS0gCjIuMjcu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
