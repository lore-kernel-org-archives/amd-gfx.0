Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F0FC3ABAA
	for <amd-gfx@archiver.kernel.org>; Sat,  3 May 2025 20:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678B110E13E;
	Sat,  3 May 2025 20:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i3tSgAmr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A3F10E03C
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HXcxqZahD0963e51rmYtgv58gIkSIEGJfCJCn2VAhjI=; b=i3tSgAmrKs8hc3vOCcIgMIhk/v
 u0Pj6zJWf1DyYnDyioHM6ek801r1gG/+3grIjOGUoF+MIKcot8dwFr/AHYQotfDjGu77iTBkrWUfw
 daBUMvKe8Emqb4Dy91hnF1myjUc/JRq8JBJv2KUSZguYkKyqMt7GvMPDb2b2NlexAkH+EIy8yYd0R
 EyXh/PX1QUpbqoburLK5oq9n/N87wFk0jB4nLz7b6o967mq+n3K5JZyyYQevsljoqXoFgs81y6RuI
 e5TwzhVkkdnFblk3brMwYiVNECaZGNP+Qv8Cl2UHJ4hXaqX3kZsALWi4S9uKdGx4qV6105md+EJep
 rN/UJP4A==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBJbQ-002dFw-0z; Sat, 03 May 2025 22:39:20 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 0/2] Add more kernel-doc and expand the glossary
Date: Sat,  3 May 2025 14:38:41 -0600
Message-ID: <20250503203905.346049-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This version is a follow-up from:

 https://lore.kernel.org/amd-gfx/CADnq5_ODXY_1MoPZuKXgCAAxmP2QNsc00+x=W6_aaO=5yShwsA@mail.gmail.com/T/#m9b8658ac7600bd5f99e46732dce5693bb81e2586

From Alex's feedback, this new version includes:
- More documentation about amdgpu writeback.
- More ring documentation.
- Expand glossary.

Thanks

Rodrigo Siqueira (2):
  drm/amdgpu: Add documentation to some parts of the AMDGPU ring and wb
  Documentation/gpu: Add new entries to amdgpu glossary

 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 33 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 52 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     | 74 ++++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)

-- 
2.47.2

