Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E7C64E69
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4422225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFBPvHxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4422225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C416EA34;
	Mon, 16 Nov 2020 19:18:19 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8CE6E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:48 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id 23so19608033wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a/Zj5V7ntHFWoK7hDL0KY4UUjT17GXd4P0At2oNvDPk=;
 b=TFBPvHxiNg0J66sXloeHlwrOB5eWbndg3GWxnxNUY/l85QSylm74QsaOu6c9V0sLmG
 gsrnImQVGr/vzI1O7BgbeoRNaysARDN0yLvRIL+qaCWtSVIL3Dki7e9FEDW8asTZVwZ6
 +KbfAcOKEr1hxQUuXN22cD2h5KNqAixBIbRYq2Qf8CZUofHYwO2YGcYYuXget9TsJXwS
 sSWUlQBWfMX4tksJumaQpklKT/jTnTL3slInD2HfyyF2gVExiphw0nn20uXiUWBwEc4T
 9naALP835/24p4ry/5XCk+jssfHvQcCihUPctJQpGv51yNSp70AKMXPK/mHf3HRNuU1n
 5s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/Zj5V7ntHFWoK7hDL0KY4UUjT17GXd4P0At2oNvDPk=;
 b=DJDZtGfZZ41TijZCpzfegDZN3SPh69yDBcXmyFBRmSlqhIL3E7vtktA7elU6l0lFeS
 pXbrAT0l2ag6BzDPLPsMLROOlqQeXOAd73BPhpjjm48EZsphT9j4PUhJOz1NuHwsx40V
 tgmHlEtfeu86qh7OLuYq/4Ol0wLbhLbTkkp2aBGuEG36CIcwkmtTTQ4h7UUaWP4Wtwt0
 ZkP7qMfcgUf9bAulf20iHxWQuJNNgUPgD+dtKsjTwqiV608xshm5pv8QGl+uU1PAodeH
 Lcij95ZWPs0p2LZ9pDaJvJ+DpR/ceVFS26PjVRox9i/XDO/5L39mw7aN/jx7AHAj3Eaz
 QG5Q==
X-Gm-Message-State: AOAM533hsKtkgSmkqhveDyS6szptp6Og2SIedBiRwqOfmAawyQZhOBbc
 ob8XUIqSaEdJWnVj/G5uZGDzZw==
X-Google-Smtp-Source: ABdhPJyMK0Ji9phYwLd+YAD9fkz+za+2JWzXtRjSfGXUX56GVCuCSEw3Ah5D19tYN5hkRyKDaHQNxA==
X-Received: by 2002:adf:e512:: with SMTP id j18mr21789945wrm.390.1605548266827; 
 Mon, 16 Nov 2020 09:37:46 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/43] drm/radeon/cik: Move 'si_*()'s prototypes to shared
 header
Date: Mon, 16 Nov 2020 17:36:48 +0000
Message-Id: <20201116173700.1830487-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9zaS5jOjQxODY6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhzaV92cmFtX2d0dF9sb2NhdGlvbuKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNd
CiA0MTg2IHwgdm9pZCBzaV92cmFtX2d0dF9sb2NhdGlvbihzdHJ1Y3QgcmFkZW9uX2RldmljZSAq
cmRldiwKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2ku
Yzo1MTg2OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYc2lfaW5pdF91
dmRfaW50ZXJuYWxfY2figJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogNTE4NiB8IHZvaWQgc2lf
aW5pdF91dmRfaW50ZXJuYWxfY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmM6NTgwMTo2OiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHNpX3JsY19yZXNldOKAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCiA1ODAxIHwgdm9pZCBzaV9ybGNfcmVzZXQoc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+fgoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13
YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
Y2lrLmMgfCA0ICstLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuaCAgfCA0ICsrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5jCmluZGV4IGFlMDIwYWQ3YjMxODUuLmNlZjBmMzExMWNkM2EgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9j
aWsuYwpAQCAtNDAsNiArNDAsNyBAQAogI2luY2x1ZGUgInJhZGVvbl9hc2ljLmgiCiAjaW5jbHVk
ZSAicmFkZW9uX2F1ZGlvLmgiCiAjaW5jbHVkZSAicmFkZW9uX3Vjb2RlLmgiCisjaW5jbHVkZSAi
c2kuaCIKIAogI2RlZmluZSBTSF9NRU1fQ09ORklHX0dGWF9ERUZBVUxUIFwKIAlBTElHTk1FTlRf
TU9ERShTSF9NRU1fQUxJR05NRU5UX01PREVfVU5BTElHTkVEKQpAQCAtMTI3LDkgKzEyOCw2IEBA
IE1PRFVMRV9GSVJNV0FSRSgicmFkZW9uL211bGxpbnNfbWVjLmJpbiIpOwogTU9EVUxFX0ZJUk1X
QVJFKCJyYWRlb24vbXVsbGluc19ybGMuYmluIik7CiBNT0RVTEVfRklSTVdBUkUoInJhZGVvbi9t
dWxsaW5zX3NkbWEuYmluIik7CiAKLWV4dGVybiB2b2lkIHNpX3ZyYW1fZ3R0X2xvY2F0aW9uKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1Y3QgcmFkZW9uX21jICptYyk7Ci1leHRlcm4g
dm9pZCBzaV9ybGNfcmVzZXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotZXh0ZXJuIHZv
aWQgc2lfaW5pdF91dmRfaW50ZXJuYWxfY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwog
c3RhdGljIHUzMiBjaWtfZ2V0X2N1X2FjdGl2ZV9iaXRtYXAoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYsIHUzMiBzZSwgdTMyIHNoKTsKIGV4dGVybiBpbnQgY2lrX3NkbWFfcmVzdW1lKHN0cnVj
dCByYWRlb25fZGV2aWNlICpyZGV2KTsKIGV4dGVybiB2b2lkIGNpa19zZG1hX2VuYWJsZShzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgYm9vbCBlbmFibGUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9zaS5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oCmluZGV4
IGExNzUxYWU1NjBmMDIuLmY0ODNhNjRkMTcwNTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vc2kuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmgKQEAgLTI1LDgg
KzI1LDEyIEBACiAjZGVmaW5lIF9fU0lfSF9fCiAKIHN0cnVjdCByYWRlb25fZGV2aWNlOworc3Ry
dWN0IHJhZGVvbl9tYzsKIAogaW50IHNpX21jX2xvYWRfbWljcm9jb2RlKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2KTsKIHUzMiBzaV9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldik7Cit2b2lkIHNpX3ZyYW1fZ3R0X2xvY2F0aW9uKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2LCBzdHJ1Y3QgcmFkZW9uX21jICptYyk7Cit2b2lkIHNpX3JsY19yZXNldChz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cit2b2lkIHNpX2luaXRfdXZkX2ludGVybmFsX2Nn
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIAogI2VuZGlmICAgICAgICAgICAgICAgICAg
ICAgICAgIC8qIF9fU0lfSF9fICovCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
