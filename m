Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98456C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F5E2071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdN72beQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F5E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1166B6E837;
	Tue, 31 Mar 2020 14:25:41 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D996E837
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 14:25:40 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id z7so37283wmk.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LvalxauGFqw0+chzHdRNDnk1JGFxwLN5y6GpDXo3wXM=;
 b=qdN72beQt2W47x5hdLa7hC7x64tM+NcxmEt5MXqew9BLSxckUuQBQ148ZhqOMJvoU9
 M2RlgHEQJZCIR1v5N7Sk7j1XGeXMAQIvS2IvIFl9L3QR//zUd3m8kt07NBgOR8Rfo96Y
 WFEj47DcTT6KPNZZAAZfTNg/+nj8h+BqCEhueaoc0bdhxUMlArCi3oJ8EomvCVubrJiB
 isnNpcZtjThgu2CntLBezm3FopJuNk/8bYbpDXOZNHc7R6Ruiq0O3DepQYztromSJLrm
 JAq7DD3RvwhxdqEszXU6C66X3Ay02dyj/6h8jIYEGIhFzMhfKTRB4ypbA8Zncoe/nE6i
 NCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LvalxauGFqw0+chzHdRNDnk1JGFxwLN5y6GpDXo3wXM=;
 b=ZyZuK3mYYMvkKOxkDJpF8gvSDC6rfsZg/Hi+L+u2jNFuCfApliYRv/scE2VcHjIKql
 TU8O8UgHSdtA2p5uccGKFjdaqBoFQIwMsREVCj7SATL6EKwSVvNjM4yxuppCO4xjavhG
 8tw6RLtVfKDTr4hQlKWuMGkeKMRcqUTQKatFmSTv8+xOYGBde2rZX9VNNVtIblHcYucq
 7NIRA5snYUk9s7F8pJp5Tf3EOUXd73B7xGpIuvkvdN6a2V0LU1zN1H762J4RBnvSUPAA
 BdhzeLGcTeIW5e0I4RWQd7UT3XWjK5+acgEtIlEg5Y08A8vVZGFnbpy95NsU5PsLB3b2
 Ut5w==
X-Gm-Message-State: ANhLgQ28w/06npW7aA94xpf0lnrWjDUfxb4KdiSRWJ3F/DduRveGNB2Q
 qzZ8XIoWvRt76pmAz+PQsces6rap
X-Google-Smtp-Source: ADFU+vu8jN40tHS3dKvIlyw9T0DVxZqxRT1gxLuFzUa2/x9Np6KPAcdEzwVmaVB7b7XUZjbN+JgXMQ==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr3970633wme.12.1585664738856; 
 Tue, 31 Mar 2020 07:25:38 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:1dbc:f0cc:f5b1:b489])
 by smtp.gmail.com with ESMTPSA id n186sm3911538wme.25.2020.03.31.07.25.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:25:38 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix fence handling in amdgpu_gem_object_close
Date: Tue, 31 Mar 2020 16:25:37 +0200
Message-Id: <20200331142537.2948-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

VGhlIGV4Y2x1c2l2ZSBmZW5jZSBpcyBvbmx5IG9wdGlvbmFsLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYwppbmRleCBhMGJlODA1MTNlOTYuLjc3ZDk4OGEwMDMzZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwpAQCAtMTkxLDggKzE5MSwxMCBAQCB2b2lk
IGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLAogCQln
b3RvIG91dF91bmxvY2s7CiAKIAlmZW5jZSA9IGRtYV9yZXN2X2dldF9leGNsKGJvLT50Ym8uYmFz
ZS5yZXN2KTsKLQlhbWRncHVfYm9fZmVuY2UoYm8sIGZlbmNlLCB0cnVlKTsKLQlmZW5jZSA9IE5V
TEw7CisJaWYgKGZlbmNlKSB7CisJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwor
CQlmZW5jZSA9IE5VTEw7CisJfQogCiAJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2
bSwgJmZlbmNlKTsKIAlpZiAociB8fCAhZmVuY2UpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
