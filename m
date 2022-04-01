Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D46C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 14:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FEC10F4D9;
	Fri,  1 Apr 2022 14:46:59 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C2310F4D9;
 Fri,  1 Apr 2022 14:46:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 048B860BC2;
 Fri,  1 Apr 2022 14:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39229C340EE;
 Fri,  1 Apr 2022 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648824417;
 bh=pU/H+u9rFtp4ENuB1Hm1S3gmfaCJ6UJyWiYaxiMbYOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mM01b3VenxyNrvwoTtMVfDtXS53HE/vZEGmLJmsh2KiHKk2ln136Q+dNbY8OrNYZc
 ILukTjIJsFYCS7CISEoCcqC9ayV41b0WLyeVNP652rgBlHaD+Ii6R7j6NQ/It82RWh
 Zw8w/AURoccR9UA1P7WQwBWRVHrfTPBId60eN+KDEF/IgKAfoaPDUXYGe7cLjSeShU
 dJD6drFL043+Ews8+bZeHvUVtEuioI1lA2lOh3tykey3hYL+1aLGobXjCF7fZNXXWK
 iZLgkAEO3w+15klE4VhbcIlzA8NhpqoDWz7Qzyc3wWdGIxDoM+xxFrMYdLVNvOIdmL
 w0poPKKZ5J8fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/29] drm/amdkfd: make CRAT table missing
 message informational only
Date: Fri,  1 Apr 2022 10:45:59 -0400
Message-Id: <20220401144612.1955177-16-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144612.1955177-1-sashal@kernel.org>
References: <20220401144612.1955177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
 Felix Kuehling <Felix.Kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 9dff13f9edf755a15f6507874185a3290c1ae8bb ]

The driver has a fallback so make the message informational
rather than a warning. The driver has a fallback if the
Component Resource Association Table (CRAT) is missing, so
make this informational now.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index ee4996029a86..e2780643f4c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -733,7 +733,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	/* Fetch the CRAT table from ACPI */
 	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("CRAT table not found\n");
+		pr_info("CRAT table not found\n");
 		return -ENODATA;
 	} else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-- 
2.34.1

