Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08856606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=PsOiwObN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEFA10E279;
	Wed,  4 Nov 2026 12:03:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BCC10E10A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=d4PS6n98x+TvkBYC986vyjDvxspUkjkzyZhMtUNi6jE=; t=1793793816; x=2109153816; 
 b=PsOiwObNV1cmPmYmHKX7ZhGFMQ4fvuOE7n7x8clCfvD+b6AqxlMhinqD+kA0o8iKv6trw7fqVWF
 6CvcmWD4+KvSI8JnP84XqIJCU8LKiDBscH1OnPZI4129hdwU2DIY8S2cWYOVllMfJDT7NSwmO78If
 nD5/U3L9vhQgdlTWu0oskrJsXn4Jiw7eweGmP2JFFzRL0MAX4Y27jzLiQpk1ppZNOpcCujUw7KewI
 T1ydiuWdz8fSoiIcPif15riKrOo4q5II+yA45422sIF5p5WyHnVr7r7YaqhYtCJyaFSJz0HoujMCd
 YkRJLM3Exr4IDBGPzne3/bOXbYXTQYO86bew==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOZiH-002EGs-Se; Wed, 04 Nov 2026 13:03:33 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>
Subject: [PATCH v5 0/2] amdgpu display debugfs handling fix and refactor
Date: Wed,  4 Nov 2026 12:03:30 +0000
Message-ID: <20261104120332.34405-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I had some patches in this area ages ago so I re-visited them, tweaked and
decided to re-post.

First is a clear fix while second is a serious refactor which needs a lot of
scrutiny. Mostly closing in on the desired semantics and thinking whether
changing any of the existing (incosistent) semantics is likely to break any
(hypothetical) scripts used for debugfs configuration. In it probably desirable
in principle since it removes a lot of redundant and somewhat questionable code.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>

Tvrtko Ursulin (2):
  drm/amd/display: Use memdup_user_nul in debugfs code
  drm/amd/display: Simplify debugfs token parsing

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 564 ++++--------------
 1 file changed, 121 insertions(+), 443 deletions(-)

-- 
2.56.0

