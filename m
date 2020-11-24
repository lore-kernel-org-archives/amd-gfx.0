Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DCC64E7A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D56208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6RizRk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D56208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A186E974;
	Wed, 25 Nov 2020 08:23:02 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BCD6E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:46 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id u12so23613524wrt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IuYUPAmdjNAB2iB0feai5NRQku3ocmldwDZ4+yeUjOQ=;
 b=G6RizRk86LJoiRxWoHggIJioWd/Caezt6X9dDirbeZl2WR1uV0CaD0Ho13XnPd5XtC
 T0S4wjyWXh9IbLoGuJJie52QMC1nQDAogfU2C50i9BdbT+sZO2vfn/sQ+8EpCwYGHFr/
 8cvlIibvBz9utcaqPcSen+zbb9g4q/fEaMXU1zyDfaG0UljGysQMCyu9yd74N5P6+FtZ
 huQU/Q3b68Q2mmTXVS/vH3yZ05TtTa0u96Hy1edtsgmC9aNg9CwFnfX+9vD28/L1Dsht
 59aRyImfMp+OTRPrcesVD0/YgR9S0iK5b336NZUfp7FPsz3cUuNzEphWmZGdJLJw/ELu
 +3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IuYUPAmdjNAB2iB0feai5NRQku3ocmldwDZ4+yeUjOQ=;
 b=otpzp0TtfUW1h4p82EB4FfO65r5aQ1/K7044qGIUlydHrEu6EhrN5hs46psuIbtyjz
 nfIRdNJZ6QdSkMHbaQ3wmUhmEzZEjDKFSeDcKb2g6WZExjcmLQvIFJY+7ryZtE56jlUi
 cRafb2mgK8PlHx0TyDcLrUFVRNF2jRvMwvBVcMNzz5Ffv3zpwTAuj22IXCHd/9H7G0zq
 lk4BHm2ZdYteynOJOB/blzQIe4b3t2pBfKjxYoZVzkPyR7yzgbRtYS7UfEV9pvE48HBl
 J5djx7nyUhHL8J4jqnDs0LlwKbWxI0hE8TMAUN7mwE5GXxpafGeaAQaLMYIvHbPy8wH+
 Ji7Q==
X-Gm-Message-State: AOAM532Y/S3AaZ6Z+wFAh8vYqkrJsLMF0ZlMWNagtD9rJ3i9SmGrsW/d
 u0ZXWoswnZ4VzfYdY/5ZjkySsw==
X-Google-Smtp-Source: ABdhPJz3fTSV3/+18bQ/0bhtmER6mtf+OjZ8lu5pN+mo0EYPCn9N9UjXgTCZ4wuw7uOtKLmiQljm5w==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr94838wrv.326.1606247085224;
 Tue, 24 Nov 2020 11:44:45 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:44 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/40] drm/amd/pm/swsmu/smu12/renoir_ppt: Demote kernel-doc
 formatting abuse
Date: Tue, 24 Nov 2020 19:38:21 +0000
Message-Id: <20201124193824.1118741-38-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTIvcmVub2lyX3BwdC5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTIvcmVub2lyX3BwdC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMKaW5kZXggNDZjNDRm
MGFiZGZiOC4uZDM2NDFhOGVkOTljMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMKQEAgLTE3MCw3ICsxNzAsNyBAQCBzdGF0aWMgaW50IHJl
bm9pcl9pbml0X3NtY190YWJsZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAJcmV0dXJuIC1F
Tk9NRU07CiB9CiAKLS8qKgorLyoKICAqIFRoaXMgaW50ZXJmYWNlIGp1c3QgZm9yIGdldHRpbmcg
dWNsayB1bHRpbWF0ZSBmcmVxIGFuZCBzaG91bGQndCBpbnRyb2R1Y2UKICAqIG90aGVyIGxpa2V3
aXNlIGZ1bmN0aW9uIHJlc3VsdCBpbiBvdmVybXVjaCBjYWxsYmFjay4KICAqLwpAQCAtNjU2LDcg
KzY1Niw3IEBAIHN0YXRpYyBpbnQgcmVub2lyX2dldF9wb3dlcihzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSwgdWludDMyX3QgKnZhbHVlKQogCXJldHVybiAwOwogfQogCi0vKioKKy8qCiAgKiBUaGlz
IGludGVyZmFjZSBnZXQgZHBtIGNsb2NrIHRhYmxlIGZvciBkYwogICovCiBzdGF0aWMgaW50IHJl
bm9pcl9nZXRfZHBtX2Nsb2NrX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBzdHJ1Y3Qg
ZHBtX2Nsb2NrcyAqY2xvY2tfdGFibGUpCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
