Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DABC71155
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0B0208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C31HmePJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0B0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853E6E930;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D336E54C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:25 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r17so23604268wrw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vgOzBuuv3Jikb13WPcU5VqKxn6O8S32Q4jFud76gOBY=;
 b=C31HmePJH9fwXRu4PMXkQBi28Jm+EKtUPkBVoGtuKmPZrUEHdvfFA0SNuyZoJEhWJf
 ukx/7EzIYQOSqR7rx2lI5u8Toe2HjUOEgdoBxZUyR9JFURHqPSnoZC/xx9Td0wALFPzL
 tmm9UDtZ4D05b09ML14NjkYX+RID1E5nYnkvDT0BUAsdgRc0pM0BtxQyC03dXygKVNuX
 5ZmC9uYoEgbvEZgsbKPDI5RaW4JPrK41NUULVKZkmP8/KHLZORfZMJABVk4AwN0Y6RJU
 vDUXFWM1NpwnXd9g4ObU5wJEEO5ZsOSF+GOSbSkCCuD3w7fjyPftIR7Sh7dDkvSsBrCA
 7DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vgOzBuuv3Jikb13WPcU5VqKxn6O8S32Q4jFud76gOBY=;
 b=YlM+TgqCJr40pJt1q6NFh2swyjXln0TxYwifwdsG5lV8ghTpjsn1zimvZeb8lRIyeI
 DadDS/O4yJA+ccYRLyIuYXiYrPS2dHEFbhbhEuOAvAW1KH7Hf2ubTfBE5h1NWciodb37
 XT7rE/4/vcz2z89xKtTQgXxJKO6T/mXDG1PQHmHZRx0j05Mhu1AgXQrrb68hcgXm4eSc
 TbOg/drSfL15lxpwIVWi5iaKLOAnRml4aZgXZ6oY7keVxFXyPRPmYBxYuGRbisGrA27f
 9z3Vif2vzxoxKdqXf5JHqHLkERaBdDpsEkHjrrIgslLnZFoxmq2RegtmovnWcjcSEQ0I
 CIRw==
X-Gm-Message-State: AOAM533qJ2JGDpzQqZ3c3ybmOm1dplyJj+u+Sd2RLx7ja/dupCG5TtUF
 5A1EhSqcXRwIr8Px/nm21TpBiw==
X-Google-Smtp-Source: ABdhPJxd3sekPz4U3A7PJpsQZ6XE0HNuR1u217eWTC8yIwc6lnsUUeCB6tS1yBief0VV60JVv8gEqQ==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr117320wru.36.1606247064149;
 Tue, 24 Nov 2020 11:44:24 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:23 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/40] drm/amd/amdgpu/uvd_v5_0: Fix a bunch of kernel-doc
 function documentation issues
Date: Tue, 24 Nov 2020 19:38:04 +0000
Message-Id: <20201124193824.1118741-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
 amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYzoxNTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2hhbmRsZScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y1XzBfaHdf
aW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmM6MTUzOiB3YXJuaW5n
OiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdhZGV2JyBkZXNjcmlwdGlvbiBpbiAndXZkX3Y1
XzBfaHdfaW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmM6MjEwOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdoYW5kbGUnIG5vdCBkZXNjcmli
ZWQgaW4gJ3V2ZF92NV8wX2h3X2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djVfMC5jOjIxMDogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnYWRldicgZGVz
Y3JpcHRpb24gaW4gJ3V2ZF92NV8wX2h3X2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS91dmRfdjVfMC5jOjQ2Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAn
YWRkcicgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y1XzBfcmluZ19lbWl0X2ZlbmNlJwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYzo0NjM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ3NlcScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y1XzBfcmluZ19l
bWl0X2ZlbmNlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYzo0NjM6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVk
IGluICd1dmRfdjVfMF9yaW5nX2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS91dmRfdjVfMC5jOjQ2Mzogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVu
Y2UnIGRlc2NyaXB0aW9uIGluICd1dmRfdjVfMF9yaW5nX2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jOjUyOTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAnam9iJyBub3QgZGVzY3JpYmVkIGluICd1dmRfdjVfMF9yaW5nX2VtaXRf
aWInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jOjUyOTogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZmxhZ3MnIG5vdCBkZXNjcmliZWQgaW4gJ3V2
ZF92NV8wX3JpbmdfZW1pdF9pYicKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYyB8IDEwICsrKysrKyst
LS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMKaW5kZXggNmU1NzAwMWY2ZDBhYy4uM2E3NDhl
YzU4YmVjNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jCkBAIC0xNDUsNyAr
MTQ1LDcgQEAgc3RhdGljIGludCB1dmRfdjVfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkKIC8qKgog
ICogdXZkX3Y1XzBfaHdfaW5pdCAtIHN0YXJ0IGFuZCB0ZXN0IFVWRCBibG9jawogICoKLSAqIEBh
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqIEBoYW5kbGU6IGhhbmRsZSB1c2VkIHRvIHBh
c3MgYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKgogICogSW5pdGlhbGl6ZSB0aGUgaGFyZHdhcmUs
IGJvb3QgdXAgdGhlIFZDUFUgYW5kIGRvIHNvbWUgdGVzdGluZwogICovCkBAIC0yMDIsNyArMjAy
LDcgQEAgc3RhdGljIGludCB1dmRfdjVfMF9od19pbml0KHZvaWQgKmhhbmRsZSkKIC8qKgogICog
dXZkX3Y1XzBfaHdfZmluaSAtIHN0b3AgdGhlIGhhcmR3YXJlIGJsb2NrCiAgKgotICogQGFkZXY6
IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgorICogQGhhbmRsZTogaGFuZGxlIHVzZWQgdG8gcGFzcyBh
bWRncHVfZGV2aWNlIHBvaW50ZXIKICAqCiAgKiBTdG9wIHRoZSBVVkQgYmxvY2ssIG1hcmsgcmlu
ZyBhcyBub3QgcmVhZHkgYW55IG1vcmUKICAqLwpAQCAtNDU0LDcgKzQ1NCw5IEBAIHN0YXRpYyB2
b2lkIHV2ZF92NV8wX3N0b3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiB1dmRfdjVf
MF9yaW5nX2VtaXRfZmVuY2UgLSBlbWl0IGFuIGZlbmNlICYgdHJhcCBjb21tYW5kCiAgKgogICog
QHJpbmc6IGFtZGdwdV9yaW5nIHBvaW50ZXIKLSAqIEBmZW5jZTogZmVuY2UgdG8gZW1pdAorICog
QGFkZHI6IGFkZHJlc3MKKyAqIEBzZXE6IHNlcXVlbmNlIG51bWJlcgorICogQGZsYWdzOiBmZW5j
ZSByZWxhdGVkIGZsYWdzCiAgKgogICogV3JpdGUgYSBmZW5jZSBhbmQgYSB0cmFwIGNvbW1hbmQg
dG8gdGhlIHJpbmcuCiAgKi8KQEAgLTUxOCw3ICs1MjAsOSBAQCBzdGF0aWMgaW50IHV2ZF92NV8w
X3JpbmdfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKICAqIHV2ZF92NV8wX3Jp
bmdfZW1pdF9pYiAtIGV4ZWN1dGUgaW5kaXJlY3QgYnVmZmVyCiAgKgogICogQHJpbmc6IGFtZGdw
dV9yaW5nIHBvaW50ZXIKKyAqIEBqb2I6IGpvYiB0byByZXRyaXZlIHZtaWQgZnJvbQogICogQGli
OiBpbmRpcmVjdCBidWZmZXIgdG8gZXhlY3V0ZQorICogQGZsYWdzOiB1bnVzZWQKICAqCiAgKiBX
cml0ZSByaW5nIGNvbW1hbmRzIHRvIGV4ZWN1dGUgdGhlIGluZGlyZWN0IGJ1ZmZlcgogICovCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
