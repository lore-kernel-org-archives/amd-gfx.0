Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E9C11F79
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D244361D80
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D244361D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F536E328;
	Tue,  6 Jul 2021 11:20:16 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E8D6E328;
 Tue,  6 Jul 2021 11:20:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8410261D6A;
 Tue,  6 Jul 2021 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570414;
 bh=dQZVRB0s0ZaI5JuJSNJrI0CmVThru6IXPILSsXFNzc4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jDXx/lmD6ldq0uDfrxY7ObOem9cVH5NnQ9ia81j6PWW4KPl3uEPyO7gDyPhHehuRI
 IiUIrGEs6x7Qcl2an3ZAVdrV5igTllhVdXLrandmiqtTHEZx092nYKViX2+0a6A2rz
 KhnDdtvH1e1PQKK2mmros92zzmpJPAmpV7QFls9BoXkS0nzt7XuNd5nH5r/fqG2t2J
 f8PgOQbWY694smVrcUy0Uo+JxJpbbcLktoC4BMajl2CT9JX6RiTSLdBB5lswDJVP3h
 SvQgtX3lWZ7v+P15ViQBf3/j0UayqSIAjPf81ljTGBiwTsBOxRPMMGCEw7f/uaVHu2
 klhB6b8VgVoFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 080/160] drm/amd/display: Fix crash during MPO +
 ODM combine mode recalculation
Date: Tue,  6 Jul 2021 07:17:06 -0400
Message-Id: <20210706111827.2060499-80-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111827.2060499-1-sashal@kernel.org>
References: <20210706111827.2060499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 Aric Cyr <aric.cyr@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 665f28507a2a3d8d72ed9afa9a2b9b17fd43add1 ]

[Why]
When calculating recout width for an MPO plane on a mode that's using
ODM combine, driver can calculate a negative value, resulting in a
crash.

[How]
For negative widths, use zero such that validation will prune the
configuration correctly and disallow MPO.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 325e0d656d6a..749189eb20ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -733,6 +733,11 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 			if (split_idx == split_count) {
 				/* rightmost pipe is the remainder recout */
 				data->recout.width -= data->h_active * split_count - data->recout.x;
+
+				/* ODM combine cases with MPO we can get negative widths */
+				if (data->recout.width < 0)
+					data->recout.width = 0;
+
 				data->recout.x = 0;
 			} else
 				data->recout.width = data->h_active - data->recout.x;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
