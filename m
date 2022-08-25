Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428FC04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 01:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9762AD0BDB;
	Thu, 25 Aug 2022 01:37:32 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB85412BA07;
 Thu, 25 Aug 2022 01:36:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2E38761AC0;
 Thu, 25 Aug 2022 01:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F46DC433D6;
 Thu, 25 Aug 2022 01:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661391395;
 bh=XLti2z83tYygHF8SczBuJpgN/M6l3Ns3xwx5EIoSAZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NxRkzXCaUaYrlJabi2T4Qc/0276kd4LX8pWOq04KBiYApK3SNq+6slrF4+M/0uSbT
 uZHely7AUQInA1O7Q3tI3mFvVkKyWKtoh4kcHdgiPUyhUxJ3NTeseEzNzd7rFN7eTd
 iK3rFS9JTUyuH41s/C6QylKFsBPbybGYK8rxIuAFluIc5ZJKEplq3684MGDGOSIvAN
 0yBZn21+BMQrSb2SquVaQ2uugm/Pind0JErP4YFtzfGQTE9QqY3rqeap7fwMQHS0zC
 KaLyhLTznQAEaLDBOOUDgMFP5w/0ARkSxnrXjyVuL/8UdEdh+m4gSid5VJfcRlkcq4
 dp/lGiqyemURQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 27/38] drm/amd/display: avoid doing vm_init
 multiple time
Date: Wed, 24 Aug 2022 21:33:50 -0400
Message-Id: <20220825013401.22096-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013401.22096-1-sashal@kernel.org>
References: <20220825013401.22096-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 Daniel Wheeler <daniel.wheeler@amd.com>, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Martin Leung <Martin.Leung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, isabbasso@riseup.net,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 5544a7b5a07480192eb5fd3536462faed2c21528 ]

[why]
this is to ensure that driver will not reprogram hvm_prefetch_req again if
it is done.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index c5e200d09038..5752271f22df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -67,9 +67,15 @@ static uint32_t convert_and_clamp(
 void dcn21_dchvm_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
-	uint32_t riommu_active;
+	uint32_t riommu_active, prefetch_done;
 	int i;
 
+	REG_GET(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, &prefetch_done);
+
+	if (prefetch_done) {
+		hubbub->riommu_active = true;
+		return;
+	}
 	//Init DCHVM block
 	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
 
-- 
2.35.1

