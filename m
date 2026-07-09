Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC08C44503
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA3510F435;
	Thu,  9 Jul 2026 07:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sN0ZmdrL";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2927610E698
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:23:03 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-847e6f03df8so1773346b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783578183; x=1784182983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ntJpwww9AG144NhiF2fIApoT06Qh+39umHvBh4GnFU=;
 b=sN0ZmdrLs3/C/uWYawWBCuN2EApBrVtqBQSI+oQiS3dVSQ8fg/gKIRljPtJ/8TH+RJ
 2A0DGMprtSpQLtLVPfCCUoi+OojhsUS0jdXuJOTn6DEcfW2J5jiTo+I1S/ADdje8r3QK
 ra6Nspkr3yygxaOwU0zaMg1ip6aBEF8iSyw0XoVw7o2IYk+7yGYeeNWRcGdbdDtaOL+u
 WXHua97QZsBaSxDEKHZVHhqrLY7cNElc5wFLNragC6gK17czYukyUZWRt1zG5AsJmar+
 QWd0qRWWEBr6eB65pBENqeAOAaJ+Ozt3PqlCnu2sP7dkgqPWTFYPLk2tDsSHOfufIL8B
 Ukxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783578183; x=1784182983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ntJpwww9AG144NhiF2fIApoT06Qh+39umHvBh4GnFU=;
 b=iZNNAUJBg4R6XItKvm+eq8cWVszmcko1Ft8diCJpyDM9On/dgY/sBTnqVRKmlEFcx+
 YEpHi8720IQi62fun7LFSFQzbFixhCJ7O/BFKOkpGIXDutaYRMfYEUXhQ8FZsLmo5ZZf
 PL6v/S6zRd9oJgG0ypzl4/FSxsLAEwdoaSDLJDjo0ADTYD/xheaZwPjOAASOdnqNsnnU
 cLxcCB/uzfrM715XaFWuMfdQ6nxXzp/KucyHdn/WIj5zpqr6PtVqLVxWTGn+BuuLYreR
 jv7UZri+iNIUAmNEQ1ihPb8Gg8b+gHLFe3Jq+NjoDDGonH33Lb8sdhik4NKUR4aElV9j
 uSxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrR5BvRs5rBnE+xrOyH10Lw2kbpYzIVdDS79/7k80JYaMrw3JpaEieNOm76FqUSEUhk+vMsFs6R@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw7Xm5EFqE8lrFLIbn44gznmxtSGBlacFHvMWCrrOk7/M7kZgo
 yQ4Yu4LsXTTqCnyON58sHMWr+ItfMBS6w2m/4p34B/Nx101c/DdizPkYiOA1QU2zOYk=
X-Gm-Gg: AfdE7clflEAVSnikAdE77lKSOIVVCRnvrDQxMFwuxJBqQmwNBJ1JNDApVmiNv9HngdE
 DXioIpusTwF+PXXo8HzORVZOBbkR4eC+zAeNMqvY3SzHiqeWhmGYNP8Vx1akej+FMkNZFHyh1G8
 IxAgRdn27l4KGGKqwuJuVBPwNGfkP8B1qjSTHkDH36OarEsBYorEYUTXrras+TcU3rQlv5GKhLo
 Qll/nboiHwkWYujoRFbWz8Y8V7KsFI9hZ1zqMOhjb615NuQL0XMVNSuePYMPtrSaDl/5J6HkOFq
 29EhOeF5M/KkokuaQKyRQMFV3qHZXxsOkgIZKfE/qoj+/6ZHgDYvMAViAXz4Rwb8f9Gr8Kza7Ny
 XylbrZFrcwn+Gj9XYzvEmO7lQcoBuYYii/ulx2l50tAqREGXiOtje47vFXNA2NqEVwsR96wQVsy
 33s0LVQS53TL9i6kNIkp/4zwE3o7dpJhh2rZr934jvb1U=
X-Received: by 2002:a05:6a21:4591:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c0bd1aba77mr6910775637.41.1783578182556; 
 Wed, 08 Jul 2026 23:23:02 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3a2e42bsm3298012a12.30.2026.07.08.23.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:23:02 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: ogabbay@kernel.org,
	quic_jhugo@quicinc.com,
	joro@8bytes.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] accel/amdxdna: Clear mailbox channel after create failure
Date: Thu,  9 Jul 2026 14:22:56 +0800
Message-ID: <20260709062256.4166833-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:26:29 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aie2_create_context() stores the allocated mailbox channel in
hwctx->priv->mbox_chann before starting the channel. If
xdna_mailbox_start_channel() fails, the error path frees the channel but
leaves the saved pointer intact.

A later context cleanup only checks whether hwctx->priv->mbox_chann is
NULL before stopping and freeing it. Leaving the freed channel pointer
there can therefore make cleanup operate on stale memory.

Clear hwctx->priv->mbox_chann after freeing the channel on the create
failure path so later cleanup sees that no mailbox channel is owned.

A static analysis checker reported the stale ownership state, and manual
source review confirmed the error path.

Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create function")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/accel/amdxdna/aie2_message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index c4b364801cc04..a22d025794598 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
 
 free_channel:
 	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
+	hwctx->priv->mbox_chann = NULL;
 del_ctx_req:
 	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
 	return ret;
-- 
2.51.0

