Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21CC0018C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5900310E77C;
	Wed,  8 Nov 2023 14:11:56 +0000 (UTC)
X-Greylist: delayed 605 seconds by postgrey-1.36 at gabe;
 Wed, 08 Nov 2023 07:12:50 UTC
Received: from 17.mo582.mail-out.ovh.net (17.mo582.mail-out.ovh.net
 [46.105.36.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1D610E0B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:12:50 +0000 (UTC)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.113])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 3DE3928801
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 06:55:49 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-v2f9h (unknown [10.110.208.162])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0DFBC1FD69;
 Wed,  8 Nov 2023 06:55:45 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.96])
 by ghost-submission-6684bf9d7b-v2f9h with ESMTPSA
 id V/SvOPEwS2WlSQsAsZoO1Q
 (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 06:55:45 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001fd1c432e-144d-4186-b8a9-dc0114c8abac,
 CA30051851D9204B2894E18F048F6C805596AA31)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.109.40
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array
 members
Date: Wed,  8 Nov 2023 08:55:39 +0200
Message-Id: <20231108065539.14223-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3527725884123096769
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnheptddutefhgefhgeffhfdtueehudekudduueeiieetgeektddugedvkeetffetvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeejrdelgedruddtledrgedtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Wed, 08 Nov 2023 14:11:48 +0000
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
Cc: daniel@ffwll.ch, lijo.lazar@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 dri-devel@lists.freedesktop.org, sunran001@208suo.com, airlied@gmail.com,
 colin.i.king@gmail.com, linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While the structures affected seems to be unused along the driver the
following patch will care of replacing their members to flexible array,
removing the following warnings:

drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:169:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:174:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:179:48-55: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:184:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:518:32-39: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 81650727a5de..082d0bb79277 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -166,22 +166,22 @@ struct phm_phase_shedding_limits_table {
 
 struct phm_vceclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_vceclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_vceclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_uvdclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_uvdclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_uvdclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_samuclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_samuclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_samuclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_acpclock_voltage_dependency_table {
 	uint32_t count;                                    /* Number of entries. */
-	struct phm_acpclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_acpclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_vce_clock_voltage_dependency_table {
-- 
2.39.2

