Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A64C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC0720723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC0720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B9E6E957;
	Fri, 15 Nov 2019 16:50:56 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413CD6E77F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:55 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id y39so11525009qty.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5GDdrlMnmxrNIgQKGRo4dG3+0quYy3Sx5zwE/LC5HRo=;
 b=mMYYIAHrglhS+3822J+F+XKL8BgA4Ia07lFIbWjTRP0JGwZok4AVslE/6/H4VEwE2s
 zRWlZ46uJ02RqI+cx31vQ7CNV51CAq/q8H+zDWKxMh/DMAIkL6/+LtPVni+FXervWhSa
 HQqHN3DJH/vP8YJ8g2CcbG2snFs9MEWks5jibuiOtNlVLpMOKTLw+NnaU/LwVgig4742
 +JvTFAF7aVlxrmfJzJA2QIhhjxd0GVajTSYgzbrjOXMNBRdvOG5q6ZAwSPwR+QS9kBjU
 6Sm9UdoGdg3fyWSPqh9C/cQMDfm3/Hzyg3M8N9LreL8T3Wf2+kWf6meIjf2mNd6XMrMc
 LqaA==
X-Gm-Message-State: APjAAAVxzpuLKQv0Ys2kyLguuHkipe9oenHnFbP8hyAKYHtm70JryzIb
 Mkj9e2J2xBsq/yiiBNN/B9gYuNls
X-Google-Smtp-Source: APXvYqwJvVpkUdtzPqhxIDkA7Ck3K7idIqSlwZ+EpI4czsgrEr9ZCFt4OnnGDUPaXOpTBMVSVCpnnA==
X-Received: by 2002:ac8:3597:: with SMTP id k23mr14757208qtb.195.1573836654139; 
 Fri, 15 Nov 2019 08:50:54 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 07/20] drm/amdgpu: add a amdgpu_device_supports_baco helper
Date: Fri, 15 Nov 2019 11:50:25 -0500
Message-Id: <20191115165038.56646-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5GDdrlMnmxrNIgQKGRo4dG3+0quYy3Sx5zwE/LC5HRo=;
 b=R55PFBxt0+70cTo2vVEQTNYlUs/t5UiY9yRKqaOpvjP/A6F7uWAPB7xxqiSmAyaTt2
 IbqAF/v8/jMYoHYAJjXQHX2xiPwB54nkIJ7IpFn33cT5UYmonUs/fV9lfbDQem+sSxNU
 NQ2AG4gYdAYiYxWyU7WbTmJalKAdplf78jId8bF5g1fXZzf+pnXc203ojiFhQ1HvPRmh
 S9GaZR7yDFCEubK8mdvhLzM1SNobH8bgPAblWP+nx/0lW8Vm4yvZEqH5sVva0jpDL0sD
 wJl9tI4w+rfSHOgv18uKfsZD18lFdZnkarsA78rxdXP7/qxBhWGUPvzVrT6HC1h6rb0Z
 2NMA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165025.i7o8LFFCxwfcMHULFSBrVw2YHWujj2w257X9zJ9HC5s@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpUbyBjaGVjayBpZiBhIGRldmljZSBzdXBwb3J0
cyBCQUNPIG9yIG5vdC4gIFRoaXMgd2lsbCBiZQp1c2VkIGluIGRldGVybWluaW5nIHdoZW4gdG8g
ZW5hYmxlIHJ1bnRpbWUgcG0uCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICAx
ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE1ICsrKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCBkOTUxOTA3OTgwYjEuLjZiYzczZmJkNDlmYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTExNDIsNiArMTE0Miw3IEBAIHZvaWQg
YW1kZ3B1X2RldmljZV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQkJCQkgICAgIGNvbnN0IHUzMiBhcnJheV9zaXplKTsKIAogYm9vbCBhbWRn
cHVfZGV2aWNlX2lzX3B4KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOworYm9vbCBhbWRncHVfZGV2
aWNlX3N1cHBvcnRzX2JhY28oc3RydWN0IGRybV9kZXZpY2UgKmRldik7CiBib29sIGFtZGdwdV9k
ZXZpY2VfaXNfcGVlcl9hY2Nlc3NpYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJ
CSAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICpwZWVyX2FkZXYpOwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggODVjMDI0Yjc0ZDZkLi5lNmRmYzI0
NmU2MjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAg
LTE1NCw2ICsxNTQsMjEgQEAgYm9vbCBhbWRncHVfZGV2aWNlX2lzX3B4KHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYpCiAJcmV0dXJuIGZhbHNlOwogfQogCisvKioKKyAqIGFtZGdwdV9kZXZpY2Vfc3Vw
cG9ydHNfYmFjbyAtIERvZXMgdGhlIGRldmljZSBzdXBwb3J0IEJBQ08KKyAqCisgKiBAZGV2OiBk
cm1fZGV2aWNlIHBvaW50ZXIKKyAqCisgKiBSZXR1cm5zIHRydWUgaWYgdGhlIGRldmljZSBzdXBw
b3J0ZSBCQUNPLAorICogb3RoZXJ3aXNlIHJldHVybiBmYWxzZS4KKyAqLworYm9vbCBhbWRncHVf
ZGV2aWNlX3N1cHBvcnRzX2JhY28oc3RydWN0IGRybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CisKKwlyZXR1cm4gYW1kZ3B1
X2FzaWNfc3VwcG9ydHNfYmFjbyhhZGV2KTsKK30KKwogLyoqCiAgKiBWUkFNIGFjY2VzcyBoZWxw
ZXIgZnVuY3Rpb25zLgogICoKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
