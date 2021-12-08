Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C83C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D12F6E101;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE1F6E1BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zz96pFczF4nZ;
 Tue,  7 Dec 2021 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926806; bh=9DMQth5rkhjw/Ohqp0O6siIow4TICmrslB5XGGNg3Jg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P8oDLJGXiu+Gwy68RS7NMs876owX/F17ySP461P0JcMFXjL0Vo1tiN1NR91fXkIvk
 uPYJPQ+NpwVJnqlWRdnX2RDiZQ5aRxq+3bS5vi/1eH2oXZTRDFKWyjZU2WmPjkO+pj
 khbOAuPZfzSqDpgfwbd26EOjHRk3mp/4crZyHxM0=
X-Riseup-User-ID: 9E3F160572BFE210EDA75A13E8A9A8600ABA75CB7E4845A7708283A88FE6E54D
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zz74jT6z5vkY;
 Tue,  7 Dec 2021 17:26:43 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 10/10] drm/amdgpu: re-format file header comments
Date: Tue,  7 Dec 2021 22:25:29 -0300
Message-Id: <20211208012529.372478-11-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning below by switching header comments to be more aligned
with AMD's docstrings:

 warning: Cannot understand  * \file amdgpu_ioc32.c
 on line 2 - I thought it was a doc line

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
index 5cf142e849bb..cde5294056cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
@@ -1,10 +1,4 @@
-/**
- * \file amdgpu_ioc32.c
- *
- * 32-bit ioctl compatibility routines for the AMDGPU DRM.
- *
- * \author Paul Mackerras <paulus@samba.org>
- *
+/*
  * Copyright (C) Paul Mackerras 2005
  * All Rights Reserved.
  *
@@ -26,6 +20,14 @@
  * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  * IN THE SOFTWARE.
+ *
+ * Author: Paul Mackerras <paulus@samba.org>
+ */
+
+/**
+ * DOC: amdgpu_ioc32
+ *
+ * 32-bit ioctl compatibility routines for the AMDGPU DRM.
  */
 #include <linux/compat.h>
 
-- 
2.34.1

