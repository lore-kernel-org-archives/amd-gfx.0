Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F99E784A5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 07:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B399410E219;
	Mon,  2 Oct 2023 07:39:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC2610E096
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=nngXHStwMm/8b0PbSb+Shl8IOlqNc+wbIGR/pgQDPss=; b=jUpy1oUFYb3ixmnJNKrsMC2mF5
 7JStuKpGRv8QxLzzJacggxsNEa6nAPE7waV7RfwPHmjLD3BaUzdM0HKuf3xuhPF5ATReaxgIjvsD1
 m0oulql6TxwYvkuMtveo99BCx9XLRFDWAziYHtM0XGe7y6672I8CN1r21RqcuCbxEIbt7VxTWy8cs
 CNRvhJ0wIJDmmKRsaXgnAOTIikZX8kuo+tknjoeRDO0mWwg9yo+nWdjoPMNVUD1YfmrSUKrR13z9k
 S6YhU7xsok4JW+VZe1nePdONZHhP7isykb9GNKBVEo7PArTn3QgAjDoOM7RCEqt8mPO2s+668jmQF
 RA8Rcyew==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qn7QJ-00Bmzj-34; Mon, 02 Oct 2023 01:08:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
Date: Sun,  1 Oct 2023 18:08:33 -0700
Message-ID: <20231002010835.14798-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Oct 2023 07:39:51 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct typos of "occurred".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 include/uapi/drm/amdgpu_drm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
 /* unknown cause */
 #define AMDGPU_CTX_UNKNOWN_RESET	3
 
-/* indicate gpu reset occured after ctx created */
+/* indicate gpu reset occurred after ctx created */
 #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
-/* indicate vram lost occured after ctx created */
+/* indicate vram lost occurred after ctx created */
 #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
 /* indicate some job from this context once cause gpu hang */
 #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)
