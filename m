Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9196FC63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3A720674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCQv/x0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3A720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E436EBED;
	Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D256E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:49 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a186so2198455wme.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L9lgGUDlM7py1bAmh0K2ReeB9Skou96C92LhLu83qxQ=;
 b=DCQv/x0DIszjvscBb36cxqtG1a0DErbfJW+KXTrIqfTU1euX2kddV9clliTxjLQ4QX
 CD9TG8I+DosTGJG8D8N6ITX1PgUIu1NNdKrtsutaSvoyePqg8JbRQtVEY/dT/ovpu65t
 m6Wn/oUGmKqJn4umqIpSlSHZNCi07Aw+LXEtTQ0R/XvZGz+K80m0H6JehoZQ7H3Ucckl
 FT3aGJnooxLNS+dmiqnxCC9awsK0OogkN/9pXro1UI8E6Pn7I/o4YH9Iy3wDxEApnVcF
 5tCKExUMh1kXY3VsC5me7/hwHWsKOBNMPrbQVb25mW4mrCOcKmyvOHf9poBgNzBY0Orr
 HE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9lgGUDlM7py1bAmh0K2ReeB9Skou96C92LhLu83qxQ=;
 b=rSUXK5EDJs6SOSos7E8FWOaiw4mxfWyNZR21jD8c2uDkcgcoxnVqvXnEmjffpgcYa6
 5rEhljnng+VXW2be7HYxH6fbWjU24A1cRl93r4vaRKnI9+oJ40ROzuoa22X9dzJufF0S
 GpR6pbT7Vqpvh+7IBpGdClj+Yi+OqnhSBLtOlybvwtChCtuKcHvqsa1gR0VK5vjmSEGC
 t7PUs80uEeb1niAvp1M+w8df7lu0xkCCPb7uRje1S9reIgd6BQ6M7MPijQhbjBlFFsGU
 peL9v+LUWLHU1ZmLhByEj6hzU0V20VddRz8A4vzcjn4VqE1sx1ktxDfJpzquZYBk8ogq
 k0PQ==
X-Gm-Message-State: AOAM530dCd4uxzdsFW+2joaL/Eo/8AZ5EpZTSfqlSrgWYVyXorry9tfq
 NDEL+l+7Yqb+SzzLmu9yAJBLAw==
X-Google-Smtp-Source: ABdhPJzvwkDW0s2vxiNf5+aK/oS+gcALiJrv7eq8sae3U4oQh/q0CF/GyjEm5e+T0OwBp2um+s9Ugg==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr3526378wmj.69.1606398168126; 
 Thu, 26 Nov 2020 05:42:48 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:47 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/40] drm/amd/pm/powerplay/smumgr/ci_smumgr: Remove set but
 unused variable 'res'
Date: Thu, 26 Nov 2020 13:42:03 +0000
Message-Id: <20201126134240.3214176-4-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9jaV9zbXVtZ3IuYzog
SW4gZnVuY3Rpb24g4oCYY2lfdGhlcm1hbF9zZXR1cF9mYW5fdGFibGXigJk6CiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvc211bWdyL2NpX3NtdW1nci5jOjIxMzI6
Njogd2FybmluZzogdmFyaWFibGUg4oCYcmVz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvY2lfc211bWdyLmMgfCAz
ICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9jaV9zbXVt
Z3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9jaV9zbXVtZ3Iu
YwppbmRleCAzMjliZjRkNDRiYmNlLi5jMWQ4NjliNGM3YTQyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvY2lfc211bWdyLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL2NpX3NtdW1nci5jCkBAIC0yMTI5LDcg
KzIxMjksNiBAQCBzdGF0aWMgaW50IGNpX3RoZXJtYWxfc2V0dXBfZmFuX3RhYmxlKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IpCiAJdWludDMyX3QgdF9kaWZmMSwgdF9kaWZmMiwgcHdtX2RpZmYxLCBw
d21fZGlmZjI7CiAJdWludDE2X3QgZmRvX21pbiwgc2xvcGUxLCBzbG9wZTI7CiAJdWludDMyX3Qg
cmVmZXJlbmNlX2Nsb2NrOwotCWludCByZXM7CiAJdWludDY0X3QgdG1wNjQ7CiAKIAlpZiAoIXBo
bV9jYXBfZW5hYmxlZChod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5wbGF0Zm9ybUNhcHMsIFBI
TV9QbGF0Zm9ybUNhcHNfTWljcm9jb2RlRmFuQ29udHJvbCkpCkBAIC0yMTkxLDcgKzIxOTAsNyBA
QCBzdGF0aWMgaW50IGNpX3RoZXJtYWxfc2V0dXBfZmFuX3RhYmxlKHN0cnVjdCBwcF9od21nciAq
aHdtZ3IpCiAKIAlmYW5fdGFibGUuVGVtcFNyYyA9ICh1aW50OF90KVBITV9SRUFEX1ZGUEZfSU5E
SVJFQ1RfRklFTEQoaHdtZ3ItPmRldmljZSwgQ0dTX0lORF9SRUdfX1NNQywgQ0dfTVVMVF9USEVS
TUFMX0NUUkwsIFRFTVBfU0VMKTsKIAotCXJlcyA9IGNpX2NvcHlfYnl0ZXNfdG9fc21jKGh3bWdy
LCBjaV9kYXRhLT5mYW5fdGFibGVfc3RhcnQsICh1aW50OF90ICopJmZhbl90YWJsZSwgKHVpbnQz
Ml90KXNpemVvZihmYW5fdGFibGUpLCBTTUNfUkFNX0VORCk7CisJY2lfY29weV9ieXRlc190b19z
bWMoaHdtZ3IsIGNpX2RhdGEtPmZhbl90YWJsZV9zdGFydCwgKHVpbnQ4X3QgKikmZmFuX3RhYmxl
LCAodWludDMyX3Qpc2l6ZW9mKGZhbl90YWJsZSksIFNNQ19SQU1fRU5EKTsKIAogCXJldHVybiAw
OwogfQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
