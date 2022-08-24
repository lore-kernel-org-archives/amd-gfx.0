Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C2C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79B410E21A;
	Thu, 25 Aug 2022 13:05:58 +0000 (UTC)
X-Greylist: delayed 9199 seconds by postgrey-1.36 at gabe;
 Thu, 25 Aug 2022 09:32:24 UTC
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DD410F00D;
 Thu, 25 Aug 2022 09:32:24 +0000 (UTC)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP
 (IdeaSmtpServer 5.0.0)
 id caaf97ed744133c6; Wed, 24 Aug 2022 19:32:23 +0200
Received: from kreacher.localnet (unknown [213.134.169.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v370.home.net.pl (Postfix) with ESMTPSA id 075BF66D192;
 Wed, 24 Aug 2022 19:32:21 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm: amd: amdgpu: ACPI: Add comment about
 ACPI_FADT_LOW_POWER_S0
Date: Wed, 24 Aug 2022 19:32:21 +0200
Message-ID: <1831630.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.54
X-CLIENT-HOSTNAME: 213.134.169.54
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevtdehuddvteduffejgeegueehheekfedtgeevkeeuffffudeffefgheevkeelgfenucffohhmrghinhepuhgvfhhirdhorhhgnecukfhppedvudefrddufeegrdduieelrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdehgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopegrlhgvgigrnhguvghrrdguvghutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtohhmpdhrtghpthhtohepighinhhhuhhirdfrrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhk
 thhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Mailman-Approved-At: Thu, 25 Aug 2022 13:05:48 +0000
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
Cc: Linux PM <linux-pm@vger.kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Linux ACPI <linux-acpi@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to the ACPI specification [1], the ACPI_FADT_LOW_POWER_S0
flag merely means that it is better to use low-power S0 idle on the
given platform than S3 (provided that the latter is supported) and it
doesn't preclude using either of them (which of them will be used
depends on the choices made by user space).

However, on some systems that flag is used to indicate whether or not
to enable special firmware mechanics allowing the system to save more
energy when suspended to idle.  If that flag is unset, doing so is
generally risky.

Accordingly, add a comment to explain the ACPI_FADT_LOW_POWER_S0 check
in amdgpu_acpi_is_s0ix_active(), the purpose of which is otherwise
somewhat unclear.

Link: https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1066,6 +1066,12 @@ bool amdgpu_acpi_is_s0ix_active(struct a
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
 		return false;
 
+	/*
+	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is generally
+	 * risky to do any special firmware-related preparations for entering
+	 * S0ix even though the system is suspending to idle, so return false
+	 * in that case.
+	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"



