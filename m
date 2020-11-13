Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F810C4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE8B20715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcRc33Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE8B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7166E56D;
	Fri, 13 Nov 2020 14:28:20 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D79D6E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:06 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p22so8201030wmg.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=46jV9p3NGfHHD7RmZzAF9wCbEXnPQwL3oGoQw/6SZqY=;
 b=jcRc33FqvvXfYZDq2w/hkAOKcF2M6UsYfjQCTBQFmt48Mc/W99snUkSH56/FCyd/sR
 2Icd+6Ibx5xO76vEda91ScW6Obx+2JGyG53DC8PMv/rJQHZCkXaJ2jV3ZsFYzX47Gr/Y
 Ydzw+SuXuP0MYCj+U+iC/209+05xF7z+uajdM4hrF7mw9iWqkycWyjqK/OnZ4XgHuNbT
 s7bFMXSTomsPs8pw3U3BmBp+X+CX8onf+3Wt+M/rszLw4RmUWR4fLEeMphKfw0MltKh4
 nzOAPpOhj5Vnrsr6KrPvwgDOntRpLtFNJy73zF+W6qs6FQ4HgUtNRQqTrb0LcGOnx9Aw
 Lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=46jV9p3NGfHHD7RmZzAF9wCbEXnPQwL3oGoQw/6SZqY=;
 b=lTFBqIVReovQ9A7ifxF5mhnIEzBSLxi6iAgigP1bA52jV3JG3DJeRMvkyupZ7RDjOV
 FLvRSs11Vd+z7vzgtU8Vv1k/o/bS1MONN4YBqO3LVpG0Gv/V9H1QhpHu4Xof/6CSggjZ
 DjpNXfAz64TgxmRwXtqvg7S5txqOqOPzZT28AfrOAXIYJ2JK9Qn/pWnQAvg8wR13W7yG
 4JksR/7/k9ifxNhQ5qWvImvXetvzWqshiOZxpfOS9//IIH7CWyo6FabaQbEGrO8vqsY+
 SjoxXLzyp5Mo4L0KtL225WZ7ebWopiNyOHDJQ/2XknO8Q9E4e2HWv7R09wY953fBSjYX
 QubA==
X-Gm-Message-State: AOAM5335IvQGPAs3/HLYrhyJR7gZCF+nyjrBvu7yF0awzovYlc4GFvWQ
 YCNAO1/9CF7yT8TcJZHB2EzZMw==
X-Google-Smtp-Source: ABdhPJzM5M9flHKJZbmEjS7wmST4v4wEJvRBKQxhpv+CufNQVMmQ8o5VuNY71S/H5cFSMz0jXMkYxg==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr2635450wmq.178.1605275405100; 
 Fri, 13 Nov 2020 05:50:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/40] drm/amd/amdgpu/amdgpu_vram_mgr: Add missing
 descriptions for 'dev' and 'dir'
Date: Fri, 13 Nov 2020 13:49:17 +0000
Message-Id: <20201113134938.4004947-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmM6NjQ4OiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkZXYnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV92
cmFtX21ncl9mcmVlX3NndCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFt
X21nci5jOjY0ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZGlyJyBu
b3QgZGVzY3JpYmVkIGluICdhbWRncHVfdnJhbV9tZ3JfZnJlZV9zZ3QnCgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgMiArKwogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92cmFtX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZyYW1fbWdyLmMKaW5kZXggYzk5YzIxODA3ODVmZS4uZDJkZTJhNzIwYTNkOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKQEAgLTYzNyw2ICs2Mzcs
OCBAQCBpbnQgYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jX3NndChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKICAqIGFtZGdwdV92cmFtX21ncl9mcmVlX3NndCAtIGFsbG9jYXRlIGFuZCBmaWxsIGEg
c2cgdGFibGUKICAqCiAgKiBAYWRldjogYW1kZ3B1IGRldmljZSBwb2ludGVyCisgKiBAZGV2OiBk
ZXZpY2UgcG9pbnRlcgorICogQGRpcjogZGF0YSBkaXJlY3Rpb24gb2YgcmVzb3VyY2UgdG8gdW5t
YXAKICAqIEBzZ3Q6IHNnIHRhYmxlIHRvIGZyZWUKICAqCiAgKiBGcmVlIGEgcHJldmlvdXNseSBh
bGxvY2F0ZSBzZyB0YWJsZS4KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
