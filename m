Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC7C4360C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B2561163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2561163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06306F461;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1BA6F418
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:04 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id d11so17358739wrw.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=erxm+Xcrd7+qygxkCLKKNU6rbI+w3lNDzPu8B/httcU=;
 b=OE1cmOeal6mPQ3zY2RJYNzLtzyM0CyRa/eBZHVQFbLPbo4XxFRKmFTfyjaRvKhOasA
 hsZjqbS+YYSXLp0jBQp9nvLozK2NuK4+EZXBYKlK/zb+ZI5ALEfDhcrouqo71EsiWyGl
 dpRYBbKFuPPVmDWnZFYucI6qPiXCOW2SI0++B+paB0abLzPN8pmtpqj9s8MZBLSLa1gF
 BOS1Y4mjTQipSdmTUML3II0zTQleLPhan2VJ4IaVPVI178JIN2NNaiQYqUFo4xEbJysy
 fCafIbHV0mLWXiEuaeESdDWjMqZIMKDL2IfpqSl0N6fhknVAhAmOTzgb1DAV0LKz/mT1
 XpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=erxm+Xcrd7+qygxkCLKKNU6rbI+w3lNDzPu8B/httcU=;
 b=nqFLPn4NCdYnXHRrpuLH0oE7mlvIUsa0wuA5L/JP2ORYoEFvax+3kyNAr7k8I0gDnw
 cmEFzbwvhTzTwlnFLWm9gf5wbM7/j+jxX7Nv0u0g9J4JdyPElAEWc/+kpbHT2AOt3J5i
 HEbuAaOaVFUHsjRt94Gj5Z7my66udfcwyV4P+Jpo8KslX9Vrl8farfu+lPWqiyEcqyfM
 R+XYkwZFJqoB1GBRNQZYYB2HpkpzCK7dCW+SDQdYiLq4xtkMhNB723iuvhIUwRK/AKzk
 3Itp99ObQ58rYf0sMHGOGgRumshLnnKTLNraIne7PcKpojfAO9HkSvDtuL6zkrzsIh7K
 sLrw==
X-Gm-Message-State: AOAM530ZYqwXp79Nel7Il8frRAxNv7nG3zkXX7itgDZ/Avp5I2+VJAsZ
 tFljt3ED2OZcD1XzzFF/Rq0TMQ==
X-Google-Smtp-Source: ABdhPJzC65qtzUVA+gIP2kmGgel53QLMcK/7hJnqDkaigOHVU54rfgzhY6XVPlH7o1hAbiiYYuUonw==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4037179wrt.189.1621512183252; 
 Thu, 20 May 2021 05:03:03 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:02 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/38] drm/amd/amdgpu/amdgpu_debugfs: Fix a couple of misnamed
 functions
Date: Thu, 20 May 2021 13:02:21 +0100
Message-Id: <20210520120248.3464013-12-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYzoxMDA0OiB3YXJuaW5nOiBleHBl
Y3RpbmcgcHJvdG90eXBlIGZvciBhbWRncHVfZGVidWdmc19yZWdzX2dmeG9mZl93cml0ZSgpLiBQ
cm90b3R5cGUgd2FzIGZvciBhbWRncHVfZGVidWdmc19nZnhvZmZfd3JpdGUoKSBpbnN0ZWFkCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jOjEwNTM6IHdhcm5pbmc6
IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfZ2Z4b2ZmX3N0YXR1
cygpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfZGVidWdmc19nZnhvZmZfcmVhZCgpIGluc3Rl
YWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
Q2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IGJjYWYyNzFiMzli
ZjUuLmE5YmJiMDAzNGUxZWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZWJ1Z2ZzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYwpAQCAtOTkwLDcgKzk5MCw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1
Z2ZzX2dwcl9yZWFkKHN0cnVjdCBmaWxlICpmLCBjaGFyIF9fdXNlciAqYnVmLAogfQogCiAvKioK
LSAqIGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfZ2Z4b2ZmX3dyaXRlIC0gRW5hYmxlL2Rpc2FibGUgR0ZY
T0ZGCisgKiBhbWRncHVfZGVidWdmc19nZnhvZmZfd3JpdGUgLSBFbmFibGUvZGlzYWJsZSBHRlhP
RkYKICAqCiAgKiBAZjogb3BlbiBmaWxlIGhhbmRsZQogICogQGJ1ZjogVXNlciBidWZmZXIgdG8g
d3JpdGUgZGF0YSBmcm9tCkBAIC0xMDQxLDcgKzEwNDEsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRn
cHVfZGVidWdmc19nZnhvZmZfd3JpdGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2Vy
ICpidQogCiAKIC8qKgotICogYW1kZ3B1X2RlYnVnZnNfcmVnc19nZnhvZmZfc3RhdHVzIC0gcmVh
ZCBnZnhvZmYgc3RhdHVzCisgKiBhbWRncHVfZGVidWdmc19nZnhvZmZfcmVhZCAtIHJlYWQgZ2Z4
b2ZmIHN0YXR1cwogICoKICAqIEBmOiBvcGVuIGZpbGUgaGFuZGxlCiAgKiBAYnVmOiBVc2VyIGJ1
ZmZlciB0byBzdG9yZSByZWFkIGRhdGEgaW4KLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
