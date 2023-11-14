Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8F3C47072
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 09:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16E310E50F;
	Wed, 15 Nov 2023 09:15:57 +0000 (UTC)
Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net
 [188.165.48.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567CF10E21C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 15:28:06 +0000 (UTC)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.20.216])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 2E85225A1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 15:28:04 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kk79p (unknown [10.110.103.114])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0FB981FE70;
 Tue, 14 Nov 2023 15:28:00 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.102])
 by ghost-submission-6684bf9d7b-kk79p with ESMTPSA
 id QNnGNgCSU2UGzg4Aqzq3ag
 (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 14 Nov 2023 15:28:00 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00447b4aba0-d8b9-4512-b764-96c8bb41a9fd,
 39B655737E19CE8DAD14488E69459E8CEBC9C448)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 83.100.46.156
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 skhan@linuxfoundation.org
Subject: [PATCH v2] drm/amd/display: fix NULL dereference
Date: Tue, 14 Nov 2023 17:27:51 +0200
Message-Id: <20231114152751.30167-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10521253157812807361
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeftdelueetieetvdettdetueeivedujeefffdvteefkeelhefhleelfeetteejjeenucfkphepuddvjedrtddrtddruddpkeefrddutddtrdegiedrudehiedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Wed, 15 Nov 2023 09:15:52 +0000
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
Cc: dri-devel@lists.freedesktop.org, qingqing.zhuo@amd.com, wenjing.liu@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 hamza.mahfooz@amd.com, daniel@ffwll.ch, Wayne.Lin@amd.com,
 srinivasan.shanmugam@amd.com, mikita.lipski@amd.com, airlied@gmail.com,
 linux-kernel-mentees@lists.linux.dev, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following patch will fix a minor issue where a debug message is
referencing an struct that has just being checked whether is null or
not. This has been noticed by using coccinelle, in the following output:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:540:25-29: ERROR: aconnector is NULL but dereferenced.

Fixes: 5d72e247e58c9 ("drm/amd/display: switch DC over to the new DRM logging macros")
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
[v1 -> v2]: Remove the debugging message, requested by Hamza

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ed784cf27d39..c7a29bb737e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -536,11 +536,8 @@ bool dm_helpers_dp_read_dpcd(
 
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
-	if (!aconnector) {
-		drm_dbg_dp(aconnector->base.dev,
-			   "Failed to find connector for link!\n");
+	if (!aconnector)
 		return false;
-	}
 
 	return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address, data,
 				size) == size;
-- 
2.39.2

