Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635A2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 12:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83CB10E536;
	Tue,  7 Nov 2023 12:20:33 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D9610E533;
 Tue,  7 Nov 2023 12:20:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2266FCE0EE5;
 Tue,  7 Nov 2023 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE01C433AD;
 Tue,  7 Nov 2023 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699359629;
 bh=g43CxB34j+ROzmZD33fx6tXttSNCE40vHw8L68jLBfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ye845BqlWzpy6TFud7wDXldVUPCsjFgKQoSai7RNwHNHyy3D4uH9XHDQLFzILlyS/
 8vxX2DpchHFgbArQtdNJgOvTfqqHSOvJsD5QG3jcCzhm6rGM7nK4L9U0GowcdtmzlT
 N3fa85bOhd4pG/+5/Qk7XwGZ+UFo02NP0m5qhSYHVMcDekAuQ7540fRB67nH4qsSG0
 ITLz2byN9RczJeTwNLiJGsLAXvl/rL38e74y0P+BxOJoO3UW+t+22T3xC7trtXkbl7
 Ssoau+uzxCpPP2xHsa2jVxNqM8L5XHFJnPQ/8KnUnu3QbwWUrMJr8B6/1diVP+VKOs
 24iBP7sn4Zdng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/40] drm/amd: Fix UBSAN
 array-index-out-of-bounds for Polaris and Tonga
Date: Tue,  7 Nov 2023 07:16:24 -0500
Message-ID: <20231107121837.3759358-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
Cc: Sasha Levin <sashal@kernel.org>, sunran001@208suo.com,
 dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, evan.quan@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 0f0e59075b5c22f1e871fbd508d6e4f495048356 ]

For pptable structs that use flexible array sizes, use flexible arrays.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 57bca1e81d3a7..9fcad69a9f344 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -164,7 +164,7 @@ typedef struct _ATOM_Tonga_State {
 typedef struct _ATOM_Tonga_State_Array {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;		/* Number of entries. */
-	ATOM_Tonga_State entries[1];	/* Dynamically allocate entries. */
+	ATOM_Tonga_State entries[];	/* Dynamically allocate entries. */
 } ATOM_Tonga_State_Array;
 
 typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
@@ -210,7 +210,7 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
 typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;							/* Number of entries. */
-	ATOM_Polaris_SCLK_Dependency_Record entries[1];				 /* Dynamically allocate entries. */
+	ATOM_Polaris_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
 } ATOM_Polaris_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_PCIE_Record {
@@ -222,7 +222,7 @@ typedef struct _ATOM_Tonga_PCIE_Record {
 typedef struct _ATOM_Tonga_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_PCIE_Record entries[1];							/* Dynamically allocate entries. */
+	ATOM_Tonga_PCIE_Record entries[];							/* Dynamically allocate entries. */
 } ATOM_Tonga_PCIE_Table;
 
 typedef struct _ATOM_Polaris10_PCIE_Record {
@@ -235,7 +235,7 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
 typedef struct _ATOM_Polaris10_PCIE_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Polaris10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
+	ATOM_Polaris10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
 } ATOM_Polaris10_PCIE_Table;
 
 
@@ -252,7 +252,7 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
 typedef struct _ATOM_Tonga_MM_Dependency_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MM_Dependency_Record entries[1]; 			   /* Dynamically allocate entries. */
+	ATOM_Tonga_MM_Dependency_Record entries[]; 			   /* Dynamically allocate entries. */
 } ATOM_Tonga_MM_Dependency_Table;
 
 typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
@@ -265,7 +265,7 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
 typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_Voltage_Lookup_Record entries[1];				/* Dynamically allocate entries. */
+	ATOM_Tonga_Voltage_Lookup_Record entries[];				/* Dynamically allocate entries. */
 } ATOM_Tonga_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Tonga_Fan_Table {
-- 
2.42.0

