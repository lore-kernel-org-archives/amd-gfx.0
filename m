Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81537C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D9722243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRzhklHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D9722243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBDF6ECA9;
	Tue,  3 Nov 2020 13:58:41 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F2E6ECA9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:58:40 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id o20so242948eds.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fjNzzC3mpmGy4yKQ0lg3VnGvxvsGe1XlO20MJDHGIwo=;
 b=mRzhklHk2JGWI4bTSdCJYOIUckSDHIYK9aYAqjEjATjFa0uE6zwyyAt0bajWIKCMQG
 f5tbcSQXS/6ofJ76sjevfUXi+nTTLKfWIGcfmPgLhV/vH5P8a3BLFUW64r++yJoN0GNP
 fw9T6FJTqKuHVwFWeWNNd+RGfxUMlEonqUaKCOD2SzmKQKCy1Q4DbXWNG0CQzRmCdKRK
 XLua7ST8AA/fXwTZmbKLfPpipL1jO89tAMM2D758/2zfk2CypYgL4YmhnXzxgB1hB8x3
 2cTfYo0YkL+FAZmOZcAboJYtgvkV3RigV94DXK8xM6mdseDnafX6434oXWS9c1qrVLYo
 CCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fjNzzC3mpmGy4yKQ0lg3VnGvxvsGe1XlO20MJDHGIwo=;
 b=GWHw85Ee7fsLJiJeJROAwBaTWJ4sENBXvTXcUXfRll4JndwoOYpH7dnveTU1UDhkrG
 XKw74CoqHdJPbgf7UmWAm6KLp/zHnt0oxDGL7XxU/D3EZiaWsp7SZD3he2LwXy8OOg4M
 GwiimDpSVdS33blsRm6OPDuQYBnzPQ5JUM6B7Rp0XT4sgO9DHwnIitff3QhFoypIDAWX
 l70DCkzZd4Gh6wabY1MA1ZrCdewyXA3IT456XfdkRo0f4fA37OwlWiOK7Rc3wjryZCI9
 au4DXMr/0RIMb+SE0Y3y2PalSB4WLo22ZLgRl9qEKi4yJ4tZhFFgq5HRg6f7Fz6FkhhS
 IZMw==
X-Gm-Message-State: AOAM532V8B5j3elsL5TqIq2XMiLC/ttDnzUh6QMcrLEs/R77L0JYw3wk
 NExZ2z5drhwWc/QdenppYPMcaV2g9OM=
X-Google-Smtp-Source: ABdhPJygc0X1TqW+p8TcYTHERs88+ag3sbpSKyj/3GJB0NjgfON+QtMcbxGWlV7uwQBy3KZf0A9XpQ==
X-Received: by 2002:a50:f61a:: with SMTP id c26mr22169875edn.324.1604411919018; 
 Tue, 03 Nov 2020 05:58:39 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f3a2:b920:33f3:da11])
 by smtp.gmail.com with ESMTPSA id j6sm7903263edy.87.2020.11.03.05.58.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:58:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
Date: Tue,  3 Nov 2020 14:58:30 +0100
Message-Id: <20201103135837.39693-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIHZhbHVlIGlzIGluY2x1c2l2ZSwgbm90IGV4Y2x1c2l2ZS4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZl
bGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpp
bmRleCBkYzBiYzU1MGU0MmIuLmZkYmU3ZDRlOGI4YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKQEAgLTMzNTEsNyArMzM1MSw3IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRs
ZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLAog
CX0KIAogCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoYWRldiwgYWRldiwgdm0sIHRy
dWUsIGZhbHNlLCBOVUxMLCBhZGRyLAotCQkJCQlhZGRyICsgMSwgZmxhZ3MsIHZhbHVlLCBOVUxM
LCBOVUxMLAorCQkJCQlhZGRyLCBmbGFncywgdmFsdWUsIE5VTEwsIE5VTEwsCiAJCQkJCU5VTEwp
OwogCWlmIChyKQogCQlnb3RvIGVycm9yX3VubG9jazsKLS0gCjIuMjUuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
