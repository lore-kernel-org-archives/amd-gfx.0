Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0FFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A961F6E529;
	Wed,  8 Dec 2021 03:16:44 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3936E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zyq0RYbzF44W;
 Tue,  7 Dec 2021 17:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926787; bh=HLohSGq0v7HVejxmbqZSMNPz6weNGsvAuAu3nsuZWhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YMGHobUvIDVIGL/pL6/1FBF7mK3vKN8B/5oDEq2JYei4v8R11Oq4YsOXLwCi5o/kB
 a1VE/coootPz6UnW6++7aApsSNb9FBALJVnRkqcZ4pJeF7JV2q1BciGTt/BDsJwsc/
 i9Wkcen2OyZTrPeEaQ3Egz5smbZBjYZjsx2C3c18=
X-Riseup-User-ID: 36112B99DA239BA6EB315BB74283DBD00DA4E9647D9AE79622222FA343AABC55
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zym5Fjwz5vkY;
 Tue,  7 Dec 2021 17:26:24 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 03/10] drm/amdgpu: add missing function prototype for
 amdgpu_ras_mca_query_error_status
Date: Tue,  7 Dec 2021 22:25:22 -0300
Message-Id: <20211208012529.372478-4-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This commit fixes the compile-time warning below:

 warning: no previous prototype for ‘amdgpu_ras_mca_query_error_status’
 [-Wmissing-prototypes]

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1c708122d492..34e651f39bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -620,6 +620,10 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 
+void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
+				       struct ras_common_if *ras_block,
+				       struct ras_err_data  *err_data);
+
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		struct ras_query_if *info);
 
-- 
2.34.1

