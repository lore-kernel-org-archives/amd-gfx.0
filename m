Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD8C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E08661184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E08661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EC56F468;
	Thu, 20 May 2021 12:49:17 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D106F414
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:06 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id r12so17402882wrp.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p87lVshS5WtAkP+vwHETLCg2+KWBSmqiA1YnmqxNMnI=;
 b=a0NIQqA5rLn8/zDIH1ZHgTKtjrdQNFOqYKVUhlTWUmu+HMX/QdYMhzdfw1vnVRI6h9
 5ftpgP6sU1hD4Yn0LY+AZQcGCSfvqqS1Z0rNcyjthxY2amFnTWc+tBhkI+IXvW6ISVPy
 Znuiyk6IycvT5V+n60HIOQd+Agl7RJ2VvoUzoTkPlhNskqEB+uSoeWDAft89rOUwhqOn
 GJskOcGB3CvTGt/Qy4NqIM/pw4JTKpD6N1mdJVmotEQdhStQMDA1j/V3xJBruo5ull0c
 96oVQpgw0QpTNeNkj73P8Zfrg3kq8efATw2NO6gQqRt5Uxk5RXecfUzUiHsY24AKuzno
 pMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p87lVshS5WtAkP+vwHETLCg2+KWBSmqiA1YnmqxNMnI=;
 b=YIwDK3r0pjeNo2Xs6XJbdpXpCdubpo4uLP50UjnLf7N3uIDSiGMnTvZHoEHnkoR0JE
 iBczbJ2vtnFQ/iaILceIhq96GGIN2NdkLazpNjJmAxYINoupC9GeG6dFc7fx+Ww2/ulr
 lZsphNamaT5BSKzMYUxv2act8ynrN8veTqvZXEihWtuZtzkt8a5kPkKvN+fzRpKUWWRc
 YNazyVAjZrpcs5aUQYIhokAC6B0N4J1zJJaYux1xew2zFBFudX8Qhzy7TkN8QhWeFBkE
 4Yh9+oyI1ZGJoc8VFWhd+m5z+hoTpJkAsAD+zprQYI5FpcSsGduk8MHJ+QWVB6nw3ics
 139g==
X-Gm-Message-State: AOAM533UOXgwfLIc9hIFxNZdQP+7fom0/sBGimwptXYCWLlMNKT+rDmU
 5Vc+OUFvgqcldKXH75F3W/BzqQ==
X-Google-Smtp-Source: ABdhPJztEhcLl1ZB7W0IJsYbUWN1YgmHDJ7/kY6TYSk37pdkh/b5zgKfJXBzKdNZaNHzScPv6WULWQ==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr3888694wrp.341.1621512185252; 
 Thu, 20 May 2021 05:03:05 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:04 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/38] drm/amd/amdgpu/cik_sdma: Fix a few incorrectly named
 functions
Date: Thu, 20 May 2021 13:02:23 +0100
Message-Id: <20210520120248.3464013-14-lee.jones@linaro.org>
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
 Evan Quan <evan.quan@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYzo3MzU6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIGNpa19zZG1hX3ZtX2NvcHlfcGFnZXMoKS4gUHJvdG90eXBlIHdhcyBmb3Ig
Y2lrX3NkbWFfdm1fY29weV9wdGUoKSBpbnN0ZWFkCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9jaWtfc2RtYS5jOjc2Mjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgY2lrX3Nk
bWFfdm1fd3JpdGVfcGFnZXMoKS4gUHJvdG90eXBlIHdhcyBmb3IgY2lrX3NkbWFfdm1fd3JpdGVf
cHRlKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYzo3OTI6
IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGNpa19zZG1hX3ZtX3NldF9wYWdlcygp
LiBQcm90b3R5cGUgd2FzIGZvciBjaWtfc2RtYV92bV9zZXRfcHRlX3BkZSgpIGluc3RlYWQKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmM6ODE0OiB3YXJuaW5nOiBleHBlY3Rp
bmcgcHJvdG90eXBlIGZvciBjaWtfc2RtYV92bV9wYWRfaWIoKS4gUHJvdG90eXBlIHdhcyBmb3Ig
Y2lrX3NkbWFfcmluZ19wYWRfaWIoKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdh
bEBsaW5hcm8ub3JnPgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlz
dHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMgfCA4ICsrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtfc2RtYS5jCmluZGV4IGM0YmI4ZWVkMjQ2ZDYuLmM4ZWJk
MTA4NTQ4ZDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1h
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYwpAQCAtNzIwLDcg
KzcyMCw3IEBAIHN0YXRpYyBpbnQgY2lrX3NkbWFfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZywgbG9uZyB0aW1lb3V0KQogfQogCiAvKioKLSAqIGNpa19zZG1hX3ZtX2NvcHlf
cGFnZXMgLSB1cGRhdGUgUFRFcyBieSBjb3B5aW5nIHRoZW0gZnJvbSB0aGUgR0FSVAorICogY2lr
X3NkbWFfdm1fY29weV9wdGUgLSB1cGRhdGUgUFRFcyBieSBjb3B5aW5nIHRoZW0gZnJvbSB0aGUg
R0FSVAogICoKICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGZpbGwgd2l0aCBjb21tYW5kcwog
ICogQHBlOiBhZGRyIG9mIHRoZSBwYWdlIGVudHJ5CkBAIC03NDYsNyArNzQ2LDcgQEAgc3RhdGlj
IHZvaWQgY2lrX3NkbWFfdm1fY29weV9wdGUoc3RydWN0IGFtZGdwdV9pYiAqaWIsCiB9CiAKIC8q
KgotICogY2lrX3NkbWFfdm1fd3JpdGVfcGFnZXMgLSB1cGRhdGUgUFRFcyBieSB3cml0aW5nIHRo
ZW0gbWFudWFsbHkKKyAqIGNpa19zZG1hX3ZtX3dyaXRlX3B0ZSAtIHVwZGF0ZSBQVEVzIGJ5IHdy
aXRpbmcgdGhlbSBtYW51YWxseQogICoKICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGZpbGwg
d2l0aCBjb21tYW5kcwogICogQHBlOiBhZGRyIG9mIHRoZSBwYWdlIGVudHJ5CkBAIC03NzUsNyAr
Nzc1LDcgQEAgc3RhdGljIHZvaWQgY2lrX3NkbWFfdm1fd3JpdGVfcHRlKHN0cnVjdCBhbWRncHVf
aWIgKmliLCB1aW50NjRfdCBwZSwKIH0KIAogLyoqCi0gKiBjaWtfc2RtYV92bV9zZXRfcGFnZXMg
LSB1cGRhdGUgdGhlIHBhZ2UgdGFibGVzIHVzaW5nIHNETUEKKyAqIGNpa19zZG1hX3ZtX3NldF9w
dGVfcGRlIC0gdXBkYXRlIHRoZSBwYWdlIHRhYmxlcyB1c2luZyBzRE1BCiAgKgogICogQGliOiBp
bmRpcmVjdCBidWZmZXIgdG8gZmlsbCB3aXRoIGNvbW1hbmRzCiAgKiBAcGU6IGFkZHIgb2YgdGhl
IHBhZ2UgZW50cnkKQEAgLTgwNCw3ICs4MDQsNyBAQCBzdGF0aWMgdm9pZCBjaWtfc2RtYV92bV9z
ZXRfcHRlX3BkZShzdHJ1Y3QgYW1kZ3B1X2liICppYiwgdWludDY0X3QgcGUsCiB9CiAKIC8qKgot
ICogY2lrX3NkbWFfdm1fcGFkX2liIC0gcGFkIHRoZSBJQiB0byB0aGUgcmVxdWlyZWQgbnVtYmVy
IG9mIGR3CisgKiBjaWtfc2RtYV9yaW5nX3BhZF9pYiAtIHBhZCB0aGUgSUIgdG8gdGhlIHJlcXVp
cmVkIG51bWJlciBvZiBkdwogICoKICAqIEByaW5nOiBhbWRncHVfcmluZyBzdHJ1Y3R1cmUgaG9s
ZGluZyByaW5nIGluZm9ybWF0aW9uCiAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0byBmaWxsIHdp
dGggcGFkZGluZwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
