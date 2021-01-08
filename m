Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472DAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01852399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01852399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635B86E917;
	Fri,  8 Jan 2021 20:24:25 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AE36E8D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:18 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id q75so9453567wme.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SuCvcfeQ9OZsudnyJmzZpphQ6g8eEGgjPIsQH1HjJMU=;
 b=pne4rAbZBHxNVygLejDzerI+GyLe4DR8+s+f+EwFJCm7dbYva47u/bhXWYGv9Kqj6F
 1J+ii3YummtSTnKiXqsYDG7xCGZYoWur28Mb0N2tyOdgYE2VrSNLkGGAmzWqJoCSd3ue
 qmKQ7WIf3Wrgi4mrILRD/f/wJfLd4v98OBmYeHDwQU11lsNI11wulKXu6Glm56eyWrar
 4xfZbbue2cQ/9bfdessylAChzygEP7o7u3hOubC+oV+D2q3ETllTIihbF/wdvGtJk/21
 entgOPhY820LPhWkMD/4Jme5U33tuCIMo9w4xv5KngXws94s++vfKojaZgcnJdoiCYLe
 tsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SuCvcfeQ9OZsudnyJmzZpphQ6g8eEGgjPIsQH1HjJMU=;
 b=L3o/7KBl5+m7fBI40+rn4uXam5wYY7AYx7svptbWQrXjSAu3ciNKXQSDJLpk91tdhp
 vsB40yIoy0/hILd6hkBjp1lF5fNPCKUxciZPqgvrq+HNGK2/8Bcz5woAr0jQD+SKZHyk
 9Xgjo8TIcDstVt4S/9IQYDLDXILOEVgM57fwayleXcNDWdVTfXaMpdQdoBROxKfyK0I0
 nLwLubr6ISkg1MzsrT7jb2YBXeo9RYWBke2uTBQFKaW9Sc1PAidGToyGtAn0J6yWiwFO
 DMwyiVRnoFns2Hi17Rs6V+P9GDOObDMU9r/atn+ECiR3AYAXZxZlQ8b26ktt4AKzKRgG
 P/Eg==
X-Gm-Message-State: AOAM533asJ8B81wxKS33srvSTmAYCunQuTyDKvQvXD/fsy8Sj/GkQtxj
 QKoKbgo2IPFV89OPzWVs6rFMFw==
X-Google-Smtp-Source: ABdhPJz9+13rhPDFO4I1ZfvGScIu+pZSDc2MLpxUyYYYlqvYjy3rBTQqDRhdsgr1aIj/W/y508Xzdw==
X-Received: by 2002:a1c:730f:: with SMTP id d15mr4459541wmb.135.1610136917730; 
 Fri, 08 Jan 2021 12:15:17 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/40] drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix formatting
 and spelling issues
Date: Fri,  8 Jan 2021 20:14:27 +0000
Message-Id: <20210108201457.3078600-11-lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYzoy
NDI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2h3bWdyJyBub3QgZGVz
Y3JpYmVkIGluICdzbXU3X2VuYWJsZV9zbWNfdm9sdGFnZV9jb250cm9sbGVyJwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYzo0NTA4
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd1c19tYXhfZmFuX3JwbScg
bm90IGRlc2NyaWJlZCBpbiAnc211N19zZXRfbWF4X2Zhbl9ycG1fb3V0cHV0JwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYzo0NTA4
OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICd1c01heEZhblJwbScgZGVzY3Jp
cHRpb24gaW4gJ3NtdTdfc2V0X21heF9mYW5fcnBtX291dHB1dCcKCkNjOiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3
bWdyL3NtdTdfaHdtZ3IuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci9zbXU3X2h3bWdyLmMKaW5kZXggODI2NzZjMDg2Y2U0Ni4uYzU3ZGM5YWU4MWYy
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
N19od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Nt
dTdfaHdtZ3IuYwpAQCAtMjM1LDcgKzIzNSw3IEBAIHN0YXRpYyBpbnQgc211N19nZXRfY3VycmVu
dF9wY2llX2xhbmVfbnVtYmVyKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAvKioKICAqIHNtdTdf
ZW5hYmxlX3NtY192b2x0YWdlX2NvbnRyb2xsZXIgLSBFbmFibGUgdm9sdGFnZSBjb250cm9sCiAg
KgotICogQGh3bWdyICB0aGUgYWRkcmVzcyBvZiB0aGUgcG93ZXJwbGF5IGhhcmR3YXJlIG1hbmFn
ZXIuCisgKiBAaHdtZ3I6ICB0aGUgYWRkcmVzcyBvZiB0aGUgcG93ZXJwbGF5IGhhcmR3YXJlIG1h
bmFnZXIuCiAgKiBSZXR1cm46ICAgYWx3YXlzIFBQX1Jlc3VsdF9PSwogICovCiBzdGF0aWMgaW50
IHNtdTdfZW5hYmxlX3NtY192b2x0YWdlX2NvbnRyb2xsZXIoc3RydWN0IHBwX2h3bWdyICpod21n
cikKQEAgLTQ1MDEsNyArNDUwMSw3IEBAIHN0YXRpYyBpbnQgc211N19kaXNwbGF5X2NvbmZpZ3Vy
YXRpb25fY2hhbmdlZF90YXNrKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAgKiBzbXU3X3NldF9t
YXhfZmFuX3JwbV9vdXRwdXQgLSBTZXQgbWF4aW11bSB0YXJnZXQgb3BlcmF0aW5nIGZhbiBvdXRw
dXQgUlBNCiAgKgogICogQGh3bWdyOiAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJk
d2FyZSBtYW5hZ2VyLgotICogQHVzTWF4RmFuUnBtOiAgbWF4IG9wZXJhdGluZyBmYW4gUlBNIHZh
bHVlLgorICogQHVzX21heF9mYW5fcnBtOiAgbWF4IG9wZXJhdGluZyBmYW4gUlBNIHZhbHVlLgog
ICogUmV0dXJuOiAgIFRoZSByZXNwb25zZSB0aGF0IGNhbWUgZnJvbSB0aGUgU01DLgogICovCiBz
dGF0aWMgaW50IHNtdTdfc2V0X21heF9mYW5fcnBtX291dHB1dChzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyLCB1aW50MTZfdCB1c19tYXhfZmFuX3JwbSkKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
