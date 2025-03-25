Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9749BC3600E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 17:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C2610E5C7;
	Tue, 25 Mar 2025 17:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="foIHLSEu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E05D10E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mRl0fbogTvwqyhCmueBznHZDun/OZP2EgMyvwFH6CfA=; b=foIHLSEu78ECiR50TnPishOzm7
 RKWYFxR3R8/IU2zDfA93+Ds1TuyQ3nAW4JbYMeYzBC9jYxfDQO6Ji1KYWjX3UUO03kzlke9aCPkxC
 l9ukZhzUsi7HT94HGGqkEctHz8p+j6/UlTRncc8y+uN9Gz+xBjVDLXE1qum5GuQQij218PDRhl5Ab
 /PaNnWuxWjicj59IvaGIsnaOGzqafMKYj+RUVqZI+Do1F8IZhyJP3QG+a+/6uSjaMCLckYoISuMz9
 05/7m8xEL3WMYGs8NYO2ZIAAWfE+lwgAKj1vvQIHXaXVR6OgtSkUEv3lC9TulUFRWGPNbZKipnaSN
 ye76E+yQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tx82x-006FdA-9s; Tue, 25 Mar 2025 18:26:39 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?=27Andr=C3=A9=20Almeida=27?= <andrealmeid@igalia.com>,
 =?UTF-8?q?=27Timur=20Krist=C3=B3f=27?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/6] Documentation/gpu/amdgpu: Add documentation about Pipes,
 Queues, MES, and others
Date: Tue, 25 Mar 2025 11:18:41 -0600
Message-ID: <20250325172623.225901-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
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

Hi,

This patchset came from my endeavor to understand better how some of the
amdgpu components operate; in particular, I was focused on the ideas
behind Pipes, Hardware Queues, MES, and Ring Buffers. In some way, this
series is an attempt to put multiple pieces of information spread around
many different places in an organized way in the amdgpu kernel-doc. In
particular, the following links were crucial to create this series:

* https://lore.kernel.org/amd-gfx/CADnq5_Pcz2x4aJzKbVrN3jsZhD6sTydtDw=6PaN4O3m4t+Grtg@mail.gmail.com/T/#m9a670b55ab20e0f7c46c80f802a0a4be255a719d
* https://gitlab.freedesktop.org/mesa/mesa/-/issues/11759
* https://www.x.org/docs/AMD/old/R5xx_Acceleration_v1.5.pdf
* https://gpuopen.com/videos/graphics-pipeline/

The first part of this series just updates the amdgpu-glossary with some
new acronyms (some of them useful for other patches). The next two
patches are just some basic organization to improve the documentation
flow. The last part describes pipes, hardware queues, ring buffers, and
MES.

Thanks
Siqueira

Rodrigo Siqueira (6):
  Documentation/gpu: Add new acronyms
  Documentation/gpu: Change index order to show driver core first
  Documentation/gpu: Create a documentation entry just for hardware info
  Documentation/gpu: Add explanation about AMD Pipes and Queues
  Documentation/gpu: Create a GC entry in the amdgpu documentation
  Documentation/gpu: Add an intro about MES

 .../gpu/amdgpu/amd-hardware-list-info.rst     |   23 +
 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   36 +
 Documentation/gpu/amdgpu/driver-core.rst      |   77 +-
 Documentation/gpu/amdgpu/driver-misc.rst      |   17 -
 Documentation/gpu/amdgpu/gc/index.rst         |   53 +
 Documentation/gpu/amdgpu/gc/mes.rst           |   38 +
 Documentation/gpu/amdgpu/index.rst            |    4 +-
 .../gpu/amdgpu/pipe_and_queue_abstraction.svg | 1279 +++++++++++++++++
 8 files changed, 1485 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/amd-hardware-list-info.rst
 create mode 100644 Documentation/gpu/amdgpu/gc/index.rst
 create mode 100644 Documentation/gpu/amdgpu/gc/mes.rst
 create mode 100644 Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg

-- 
2.49.0

