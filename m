Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A8C67861
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Apr 2024 15:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE3710F218;
	Sat,  6 Apr 2024 15:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ONOYr+zK";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0479110E9C3
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Apr 2024 15:43:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 29907CE19FD;
 Sat,  6 Apr 2024 15:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD9BC433C7;
 Sat,  6 Apr 2024 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712418189;
 bh=KlnonV88efemHIAcJauLyXmI35h5Ofb30ye+h1O5iv8=;
 h=From:Date:Subject:To:Cc:From;
 b=ONOYr+zKX7FB4VAtyh2UVVDuuwqYFLnMyYfj9VKM/+6G9A7gFE8mjLRPg3eNaBgKA
 qVRge+5eW0R4BKKivukxrgMifZ5+zZQohVSAqsRSe2+NJqreQsctTWTHQTBSEFsqVt
 Ahl345RG4CKnYGMjjFbTqGrhltdGDBh/wckSOFdCLRrm/VDM150fLT73hxC0kqbfRt
 A3uJ4BZhYiNBiIghQuRLj782yXY5j0uUrvVe0wuZwR4qhEuj4Ph6eXPyohLnKF/qnW
 cdj5jIEWvs6+fmtperyHZIm7x6wCY3qZvPw/NNDfljU24laEEImUVpBmOiNH/k6S7i
 1LX7y84zE6Z6A==
From: Simon Horman <horms@kernel.org>
Date: Sat, 06 Apr 2024 16:43:02 +0100
Subject: [PATCH] Documentation/gpu: correct path of reference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-doc-gpu-v1-1-fe0ad057ac7e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIVtEWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwMz3ZT8ZN30glJdYyPLNMPkFANTo2RDJaDqgqLUtMwKsEnRsbW1AKQ
 g3oVZAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Maxime Ripard <mripard@kernel.org>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
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

The path to GPU documentation is Documentation/gpu
rather than Documentation/GPU

This appears to have been introduced by commit ba162ae749a5
("Documentation/gpu: Introduce a simple contribution list for display code")

Flagged by make htmldocs.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 Documentation/gpu/amdgpu/display/display-contributing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/display/display-contributing.rst b/Documentation/gpu/amdgpu/display/display-contributing.rst
index fdb2bea01d53..36f3077eee00 100644
--- a/Documentation/gpu/amdgpu/display/display-contributing.rst
+++ b/Documentation/gpu/amdgpu/display/display-contributing.rst
@@ -135,7 +135,7 @@ Enable underlay
 ---------------
 
 AMD display has this feature called underlay (which you can read more about at
-'Documentation/GPU/amdgpu/display/mpo-overview.rst') which is intended to
+'Documentation/gpu/amdgpu/display/mpo-overview.rst') which is intended to
 save power when playing a video. The basic idea is to put a video in the
 underlay plane at the bottom and the desktop in the plane above it with a hole
 in the video area. This feature is enabled in ChromeOS, and from our data

