Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499AFC63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19EC20729
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzyDbEtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19EC20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8027B89FEC;
	Mon, 23 Nov 2020 13:58:16 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A690F8945B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:30 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p22so17510973wmg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZPHwGts/M0okAx5StN5/QDa0j6ml5tJRffeJmqdhnEY=;
 b=UzyDbEtjw9EFf5YHCxgs8oF8pOLnid+3lYCSPIblTdPw6D0UjMFPSambM0pxcvoVId
 yBF6s4V7I0DZ24qAxuE+t1eTl10NX3a00BZ7ZvLaM0BYPP7yQMpXrO+z3KGbK0IyiCCQ
 zgTobsZex+ZN7sIQkC1EZVY9SOkieJDIwWXZ3h06Y6yBmTNLpqi0xGTdYF7VqGcK/Uco
 TUh+AG1KY7n3afiVLwCUjUfdO3GYkgo4iM0HXLDBmC3TmMOTjRRLFl1mgUg5F9lrpeC6
 XZVWX7JAG4VgebsWCOafOCt2rtluZltcp+0plTVJCkksuN1mscYZvfbh1aauUdFBo0x1
 pNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZPHwGts/M0okAx5StN5/QDa0j6ml5tJRffeJmqdhnEY=;
 b=EakEDAN+Kn1kWmuuLVaubgk3vT0XiqMbuWiAwSbJJ/ThSIR1Y03QdREWyFQAqXsUth
 9V5/2wytJKEgl2rAu0HkuTB3GemWis+WtuO14+XYMICByqURtoFyU+Fa8cU64+AZeBQL
 Ui5eW8NSmnD6u1nWnlyxDepA1hzzIZN3J/80TrY/AKhaKetahRsRkmdctOtAamDWpuBv
 fZTnWP3xskOfo/1tF+D5zfgi3/pw2pTScIqo4PoaHeuRew29eBbuwehbOQGERZoKWFEH
 zdJQfmm/6mEPt5SDbwdumOBU7v8fkNhxm7l/HwDU5CYu6xWPBMZwJH90FRJ7gb6bWlYP
 0AAQ==
X-Gm-Message-State: AOAM530zmwvs7YeC1J8iAD6vshNObLkml9eeKW/WHcvxqV5xkCIq4gzF
 a/Id5sUHaVhXK0poxUAuKnsaXg==
X-Google-Smtp-Source: ABdhPJxCCdUhjs0qi9cXiC6juGV3V7fNxFDwFrM5pEq9qjmcHBO/Y0Ddy+z2cLdiLHj8tZ/biImuuA==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr17634480wma.48.1606130369392; 
 Mon, 23 Nov 2020 03:19:29 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:28 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/40] drm/amd/amdgpu/cik_ih: Supply description for 'ih' in
 'cik_ih_{get, set}_wptr()'
Date: Mon, 23 Nov 2020 11:18:44 +0000
Message-Id: <20201123111919.233376-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX2loLmM6MTg5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnY2lrX2loX2dldF93cHRyJwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX2loLmM6Mjc0OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnY2lrX2loX3NldF9y
cHRyJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogUWluZ2xhbmcgTWlhbyA8bWlhb3FpbmdsYW5nQGh1YXdlaS5jb20+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19paC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2Npa19paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX2loLmMKaW5kZXggZGI5
NTNlOTVmM2QyNy4uZDM3NDU3MTFkNTVmOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvY2lrX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX2lo
LmMKQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdGF0aWMgdm9pZCBjaWtfaWhfaXJxX2Rpc2FibGUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiBjaWtfaWhfZ2V0X3dwdHIgLSBnZXQgdGhlIElI
IHJpbmcgYnVmZmVyIHdwdHIKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisg
KiBAaWg6IElIIHJpbmcgYnVmZmVyIHRvIGZldGNoIHdwdHIKICAqCiAgKiBHZXQgdGhlIElIIHJp
bmcgYnVmZmVyIHdwdHIgZnJvbSBlaXRoZXIgdGhlIHJlZ2lzdGVyCiAgKiBvciB0aGUgd3JpdGVi
YWNrIG1lbW9yeSBidWZmZXIgKENJSykuICBBbHNvIGNoZWNrIGZvcgpAQCAtMjY2LDYgKzI2Nyw3
IEBAIHN0YXRpYyB2b2lkIGNpa19paF9kZWNvZGVfaXYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAgKiBjaWtfaWhfc2V0X3JwdHIgLSBzZXQgdGhlIElIIHJpbmcgYnVmZmVyIHJwdHIKICAq
CiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaWg6IElIIHJpbmcgYnVmZmVy
IHRvIHNldCB3cHRyCiAgKgogICogU2V0IHRoZSBJSCByaW5nIGJ1ZmZlciBycHRyLgogICovCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
