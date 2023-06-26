Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4B1C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 18:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA1610E243;
	Mon, 26 Jun 2023 18:34:01 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B664710E23A;
 Mon, 26 Jun 2023 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hcEG/EDV/jBYrfWeHJXPYu8t7rz0vK43YGRhzJYLXqU=; b=JXWyM354SH54g4cNBKh2UBKOJL
 bxkzvOkbwxGcd0uxU71v0BFjl9fBLwS+jyrqDHOLbviRZFMTBl88Wga5ePaIPASYTYbePo/lc/yMJ
 Iw/68HE/Es4xIKDnGnz9lR+/Hnb2w+0axYfIT34YV5hksAt51LJBowkabzPfolQBctp2tiaXYL99t
 eDQGD5Yx+OWEestabkwv4WCLvRn8m7kPsW3or9OFVgAP6xXqCqFJCsCm/PDWjqdOC2LFgfMoT3YX9
 UMtXwnoHQZ4V0ehzM+Mt5ss1vPc114IFnG7jl6mVBKSbctSaJsAK3IHMt0TLPH40prc7UlL2guiUZ
 OuYLA78w==;
Received: from [179.113.218.86] (helo=steammachine.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qDr2A-0047zl-6M; Mon, 26 Jun 2023 20:33:54 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] drm/doc: Document DRM device reset expectations
Date: Mon, 26 Jun 2023 15:33:46 -0300
Message-ID: <20230626183347.55118-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Daniel Stone <daniel@fooishbar.org>,
 Rob Clark <robdclark@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexander.deucher@amd.com, Dave Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This v4 removes the common DRM ioctl, and adds just the documentation for now,
giving the lack of a common "DRM context" infrascture make it hard to implement.

v3: https://lore.kernel.org/lkml/20230621005719.836857-1-andrealmeid@igalia.com/

Changes: 
 - Drop the ioctl
 - Addresed comments com Pekka, as making the documentation more clear and
 consistent.

André Almeida (1):
  drm/doc: Document DRM device reset expectations

 Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.41.0

