Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89CC64E7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518F420674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npJUR/Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518F420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940E06EB88;
	Fri, 27 Nov 2020 10:14:33 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914296E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:55 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k14so2213737wrn.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JRGzsr7E+IJLlqxa5D+IrFAdZhiFdGYpEedhVyk6GiY=;
 b=npJUR/DbxvX22PhhvsddHD3XwoyyDVf+g0XRN8KgbhT11qHmB4zphgQBWSBHNqNjr/
 8Vo0vv65NfZ9JCW8L/2SMi1OI6FMPbNOzBTW/o/VfmojKflzjEGWCqSYTC7rPf98wwMv
 mSK7VJ0LcB9+AQPMEzZtIq1VLY8QK6X9GkV8LJGK+XMVPn3+lE2rsA/0S10wsQww0dax
 gOzL2JHYgBqZPD72m+1EvomBH7ybMYA10Bci7AkXEShO9cuvmxBL+VMQn7rB6Nholahm
 0H7D+pNpH/VIKwt5Lzsklllify4PiA1rjNC+VV0Q6JzUxkKrm3UyRNkoGvpwqigXwObt
 QsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JRGzsr7E+IJLlqxa5D+IrFAdZhiFdGYpEedhVyk6GiY=;
 b=AfGKoshSgl+qg0mHbezHt8uEWfcY0DSpFxOVBeXbgYE73DSvzJG5gAAOQ3FZPqtwfb
 vLTzHO0aHDf9LkKFYRpds9TdY02xmQOCRBAFLjTmad1xtxtAmCzg+s/QIcsRhR6hk0nf
 rwlZGIJmXGbWFb9m++eSnOz3W0rrD3B4zBy7jYmxNKOnwJsPt62KCdmiPWKnO1e16dI5
 U5UW7eNYwzjD4XmuzVnDmrkarOoeTKxt8Cr8NUGf1SN/IuB32nHZDgvUScl7tGT5hPHr
 PimQeH9+i/aDE+okqjSxKpQiMstTlasR3AL9s42Rum4Q9H7G3+1cFXYLt+AfU5LNczi5
 K3yg==
X-Gm-Message-State: AOAM530BDaNpSzh7oUS9ve0O9gS3Lyk7rWghytrz/i6bq1hXgeK5IzIM
 ybBPcm+ilC3XXMqC7alzPWRCwA==
X-Google-Smtp-Source: ABdhPJwo3+FQc6tpgfzfYae15R5ZY9ynnRvbHNRXmcN7/sg1nZfCyc5IUVsESXdGkNqsUW9sg2Vo8g==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4111560wrq.204.1606398174228; 
 Thu, 26 Nov 2020 05:42:54 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:53 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/40] drm/amd/pm/powerplay/smumgr/smu9_smumgr: Include our
 own header containing our prototypes
Date: Thu, 26 Nov 2020 13:42:06 +0000
Message-Id: <20201126134240.3214176-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9zbXU5X3NtdW1nci5j
OjM4OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYc211OV9pc19zbWNf
cmFtX3J1bm5pbmfigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9zbXU5X3NtdW1nci5jOjExMjo1OiB3YXJu
aW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHNtdTlfc2VuZF9tc2dfdG9fc21j4oCZ
IFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bt
L3Bvd2VycGxheS9zbXVtZ3Ivc211OV9zbXVtZ3IuYzoxNDA6NTogd2FybmluZzogbm8gcHJldmlv
dXMgcHJvdG90eXBlIGZvciDigJhzbXU5X3NlbmRfbXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcuKA
mSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9w
bS9wb3dlcnBsYXkvc211bWdyL3NtdTlfc211bWdyLmM6MTY1OjEwOiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmHNtdTlfZ2V0X2FyZ3VtZW504oCZIFstV21pc3NpbmctcHJv
dG90eXBlc10KCkNjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9zbXU5X3NtdW1nci5jIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3Bvd2VycGxheS9zbXVtZ3Ivc211OV9zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vcG93ZXJwbGF5L3NtdW1nci9zbXU5X3NtdW1nci5jCmluZGV4IDhhOWFlZTg1MDQzZWMu
LjIzZTVkZTNjNGVjMTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJw
bGF5L3NtdW1nci9zbXU5X3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L3NtdW1nci9zbXU5X3NtdW1nci5jCkBAIC0yMiw2ICsyMiw3IEBACiAgKi8KIAogI2lu
Y2x1ZGUgInNtdW1nci5oIgorI2luY2x1ZGUgInNtdTlfc211bWdyLmgiCiAjaW5jbHVkZSAidmVn
YTEwX2luYy5oIgogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5oIgogI2luY2x1ZGUgInBwX2RlYnVn
LmgiCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
