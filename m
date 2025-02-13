Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D2BC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 10:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF8010E3AB;
	Thu, 13 Feb 2025 10:34:10 +0000 (UTC)
X-Greylist: delayed 887 seconds by postgrey-1.36 at gabe;
 Thu, 13 Feb 2025 07:29:11 UTC
Received: from mail-vip.corpemail.net (mail-vip.corpemail.net
 [162.243.126.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D98410E3A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 07:29:11 +0000 (UTC)
Received: from ssh248.corpemail.net
 by ssh248.corpemail.net ((D)) with ASMTP (SSL) id KZV00139;
 Thu, 13 Feb 2025 15:08:39 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 15:08:40 +0800
Received: from locahost.localdomain (10.94.13.56) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 15:08:39 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.co>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <corbet@lwn.net>, <Rodrigo.Siqueira@amd.com>,
 <mario.limonciello@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
 <hanchunchao@inspur.com>
Subject: [PATCH] Documentation: Remove repeated word in docs
Date: Thu, 13 Feb 2025 15:08:37 +0800
Message-ID: <20250213070837.2976-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.94.13.56]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202521315083964d9b138c6aa985701335c0a1431e4b0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Mailman-Approved-At: Thu, 13 Feb 2025 10:34:09 +0000
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

Remove the repeated word "the" in docs.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 Documentation/gpu/amdgpu/display/dc-debug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/display/dc-debug.rst b/Documentation/gpu/amdgpu/display/dc-debug.rst
index 013f63b271f3..605dca21f4ae 100644
--- a/Documentation/gpu/amdgpu/display/dc-debug.rst
+++ b/Documentation/gpu/amdgpu/display/dc-debug.rst
@@ -154,7 +154,7 @@ of the display parameters, but the userspace might also cause this issue. One
 way to identify the source of the problem is to take a screenshot or make a
 desktop video capture when the problem happens; after checking the
 screenshot/video recording, if you don't see any of the artifacts, it means
-that the issue is likely on the the driver side. If you can still see the
+that the issue is likely on the driver side. If you can still see the
 problem in the data collected, it is an issue that probably happened during
 rendering, and the display code just got the framebuffer already corrupted.
 
-- 
2.43.0

