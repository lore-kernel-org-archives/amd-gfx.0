Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA80C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C383561184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C383561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02A86F460;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F786F411
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:07 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso4931112wmc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OmMgm22TVdmn0YlU70PwNW8OaCfk/LhHrn8mYGM1ILk=;
 b=QD/KEVmze2nJBsl72X+9/4makCpNLgnhq9kHYQtB0j4vPW1YZXrU1khxF3fGuZU0h+
 ZPx91P2Ne+MJofYJYv5eKK7Yft2hMjg3D7P89z+qpLWEu9oeG6N31skJJsST4qDrmNuL
 ySurx8C8e78/4JZjFHBzSggFMTGDA1MPBXw05kOtgeBccYfmGiCg/i8VWeoCenhST8s3
 okGcBzBiUXfR8+BF1kkNK6mjF301dRzRn875g/Zz6dy9mlYT5wmxs++2gIlYPo+WBEGW
 VwU0WXfkvJCZBLqh2oTsGKIhfsdLjBIrutsQI0UPvKw8CSfIyIxy42lR1AHIt+/e9wWS
 nUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OmMgm22TVdmn0YlU70PwNW8OaCfk/LhHrn8mYGM1ILk=;
 b=lTuVMhUFPXI0AhCj+HiuhiDZIDtLjLb20pFykim02Gq53TTpGQ786BZtb/g8K0q8bu
 b3Aw+ImJONZNKEcPvQ/j/lFykjLVXPgidCDsj5o/BdOdGIUK2rdokyO78WNAZDQ/chex
 lqy/6/qy7MJkITWOubqaEbemdkx9T6i0DWjasNj8JaONOhL+XuDmXgiK8cuqafgAdbWP
 XUO+llRbx5c4TGrXVPMGBa3GanIpxPwrRDgTbaj74k5n7MZLH+hYXHA61prdXmQJ1Iiz
 K/a/o6QlJ9odtgOcqsUeLdkQf1xhELpkrZ7FXWX4JgJ40cisei234a9qNlyJeK+K8MWy
 GP/Q==
X-Gm-Message-State: AOAM530ShwMpUF+9wLWH2/c6EQWx5N4bJo/Awe+uyuc/YIpja3CU5b+Y
 ENcf/mbRg/q2RMq9VECfVMkxjA==
X-Google-Smtp-Source: ABdhPJxIRwowWq6Q6Jk0qbvu6pd7yWq+Mmva8O37/LRH9s85uRpcjtEb6krZZtsukcUmk7nXDt3tAw==
X-Received: by 2002:a1c:bbc3:: with SMTP id l186mr3700393wmf.38.1621512186295; 
 Thu, 20 May 2021 05:03:06 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:05 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/38] drm/amd/amdgpu/gfx_v7_0: Repair function names in the
 documentation
Date: Thu, 20 May 2021 13:02:24 +0100
Message-Id: <20210520120248.3464013-15-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYzoyMTI2OiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBnZnhfdjdfMF9yaW5nX2VtaXRfaGRwKCkuIFByb3RvdHlwZSB3YXMgZm9y
IGdmeF92N18wX3JpbmdfZW1pdF9oZHBfZmx1c2goKSBpbnN0ZWFkCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjdfMC5jOjIyNjI6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUg
Zm9yIGdmeF92N18wX3JpbmdfZW1pdF9pYigpLiBQcm90b3R5cGUgd2FzIGZvciBnZnhfdjdfMF9y
aW5nX2VtaXRfaWJfZ2Z4KCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYzozMjA3OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBnZnhfdjdfMF9y
aW5nX2VtaXRfdm1fZmx1c2goKS4gUHJvdG90eXBlIHdhcyBmb3IgZ2Z4X3Y3XzBfcmluZ19lbWl0
X3BpcGVsaW5lX3N5bmMoKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5h
cm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzog
bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCmluZGV4IGMzNWZk
ZDJlZjJkNGQuLjY4NTIxMmMzZGRhZTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92N18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3
XzAuYwpAQCAtMjExNiw3ICsyMTE2LDcgQEAgc3RhdGljIGludCBnZnhfdjdfMF9yaW5nX3Rlc3Rf
cmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiB9CiAKIC8qKgotICogZ2Z4X3Y3XzBfcmlu
Z19lbWl0X2hkcCAtIGVtaXQgYW4gaGRwIGZsdXNoIG9uIHRoZSBjcAorICogZ2Z4X3Y3XzBfcmlu
Z19lbWl0X2hkcF9mbHVzaCAtIGVtaXQgYW4gaGRwIGZsdXNoIG9uIHRoZSBjcAogICoKICAqIEBy
aW5nOiBhbWRncHVfcmluZyBzdHJ1Y3R1cmUgaG9sZGluZyByaW5nIGluZm9ybWF0aW9uCiAgKgpA
QCAtMjI0Miw3ICsyMjQyLDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y3XzBfcmluZ19lbWl0X2ZlbmNl
X2NvbXB1dGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogICogSUIgc3R1ZmYKICAqLwogLyoq
Ci0gKiBnZnhfdjdfMF9yaW5nX2VtaXRfaWIgLSBlbWl0IGFuIElCIChJbmRpcmVjdCBCdWZmZXIp
IG9uIHRoZSByaW5nCisgKiBnZnhfdjdfMF9yaW5nX2VtaXRfaWJfZ2Z4IC0gZW1pdCBhbiBJQiAo
SW5kaXJlY3QgQnVmZmVyKSBvbiB0aGUgcmluZwogICoKICAqIEByaW5nOiBhbWRncHVfcmluZyBz
dHJ1Y3R1cmUgaG9sZGluZyByaW5nIGluZm9ybWF0aW9uCiAgKiBAam9iOiBqb2IgdG8gcmV0cmll
dmUgdm1pZCBmcm9tCkBAIC0zMTk2LDcgKzMxOTYsNyBAQCBzdGF0aWMgaW50IGdmeF92N18wX2Nw
X3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIH0KIAogLyoqCi0gKiBnZnhfdjdf
MF9yaW5nX2VtaXRfdm1fZmx1c2ggLSBjaWsgdm0gZmx1c2ggdXNpbmcgdGhlIENQCisgKiBnZnhf
djdfMF9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAtIGNpayB2bSBmbHVzaCB1c2luZyB0aGUgQ1AK
ICAqCiAgKiBAcmluZzogdGhlIHJpbmcgdG8gZW1pdCB0aGUgY29tbWFuZHMgdG8KICAqCi0tIAoy
LjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
