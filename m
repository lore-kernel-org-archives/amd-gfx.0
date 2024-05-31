Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFFC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 12:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BBE10E383;
	Mon,  3 Jun 2024 12:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="ZykOTIcc";
	dkim-atps=neutral
Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F68610E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0BMueCwMy2jcCBzCTn8/bP0uOhO/66+zSY+qOJmnLBg=; b=ZykOTIcc+sWYJWmbjL8raJM9CR
 aWpcgaxdW0uOXYkvzokrUXQm+O7srhQ7OXX6mS5HoBI9yw/T5pS/mmjgIzmLY/v3/JI0izg78TLtJ
 MobOsUqUMYq3NdlfZq+XtJO4yGTonPm7/SeGrhUuvNeiQHgDba1uFdaIHGedJSr6LDT4=;
Received: from [2a02:587:6a04:fe00::298] (helo=localhost.localdomain)
 by devnull.tasossah.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <tasos@tasossah.com>)
 id 1sD59j-004HAo-Pu; Fri, 31 May 2024 19:31:03 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com,
	Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH v2] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
Date: Fri, 31 May 2024 19:23:30 +0300
Message-Id: <20240531162329.1343167-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Jun 2024 12:52:59 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Flexible arrays used [1] instead of []. Replace the former with the latter
to resolve multiple UBSAN warnings observed on boot with a BONAIRE card.

In addition, use the __counted_by attribute where possible to hint the
length of the arrays to the compiler and any sanitizers.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
V1 -> V2: Added the __counted_by attribute where possible and reworded
          the commit message.

 drivers/gpu/drm/amd/include/pptable.h | 91 ++++++++++++++-------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 2e8e6c9875f6..f83ace2d7ec3 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -477,31 +477,30 @@ typedef struct _ATOM_PPLIB_STATE_V2
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
-    //how many states we have 
-    UCHAR ucNumEntries;
-    
-    ATOM_PPLIB_STATE_V2 states[1];
+	//how many states we have
+	UCHAR ucNumEntries;
+
+	ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
 }StateArray;
 
 
 typedef struct _ClockInfoArray{
-    //how many clock levels we have
-    UCHAR ucNumEntries;
-    
-    //sizeof(ATOM_PPLIB_CLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    UCHAR clockInfo[];
+	//how many clock levels we have
+	UCHAR ucNumEntries;
+
+	//sizeof(ATOM_PPLIB_CLOCK_INFO)
+	UCHAR ucEntrySize;
+
+	UCHAR clockInfo[];
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
+	//how many non-clock levels we have. normally should be same as number of states
+	UCHAR ucNumEntries;
+	//sizeof(ATOM_PPLIB_NONCLOCK_INFO)
+	UCHAR ucEntrySize;
 
-    //how many non-clock levels we have. normally should be same as number of states
-    UCHAR ucNumEntries;
-    //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
-    UCHAR ucEntrySize;
-    
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
+	ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
@@ -513,8 +512,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
@@ -529,8 +530,10 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
 {
-    UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_Clock_Voltage_Limit_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_Clock_Voltage_Limit_Table;
 
 union _ATOM_PPLIB_CAC_Leakage_Record
@@ -553,8 +556,10 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPLIB_CAC_Leakage_Record;
 
 typedef struct _ATOM_PPLIB_CAC_Leakage_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_CAC_Leakage_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_CAC_Leakage_Table;
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
@@ -568,8 +573,10 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
 {
-    UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   // Dynamically allocate entries.
+	// Number of entries.
+	UCHAR ucNumEntries;
+	// Dynamically allocate entries.
+	ATOM_PPLIB_PhaseSheddingLimits_Record entries[] __counted_by(ucNumEntries);
 }ATOM_PPLIB_PhaseSheddingLimits_Table;
 
 typedef struct _VCEClockInfo{
@@ -580,8 +587,8 @@ typedef struct _VCEClockInfo{
 }VCEClockInfo;
 
 typedef struct _VCEClockInfoArray{
-    UCHAR ucNumEntries;
-    VCEClockInfo entries[1];
+	UCHAR ucNumEntries;
+	VCEClockInfo entries[] __counted_by(ucNumEntries);
 }VCEClockInfoArray;
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
@@ -592,8 +599,8 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_VCE_State_Record
@@ -604,8 +611,8 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
 
 typedef struct _ATOM_PPLIB_VCE_State_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_VCE_State_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_VCE_State_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_VCE_State_Table;
 
 
@@ -626,8 +633,8 @@ typedef struct _UVDClockInfo{
 }UVDClockInfo;
 
 typedef struct _UVDClockInfoArray{
-    UCHAR ucNumEntries;
-    UVDClockInfo entries[1];
+	UCHAR ucNumEntries;
+	UVDClockInfo entries[] __counted_by(ucNumEntries);
 }UVDClockInfoArray;
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
@@ -638,8 +645,8 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
 {
-    UCHAR numEntries;
-    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_UVD_Table
@@ -657,8 +664,8 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
+	UCHAR numEntries;
+	ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table
@@ -675,8 +682,8 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Record
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Record;
 
 typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
-    UCHAR numEntries;
-    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
+	UCHAR numEntries;
+	ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[] __counted_by(numEntries);
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_ACP_Table
@@ -743,9 +750,9 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
 } ATOM_PPLIB_VQ_Budgeting_Record;
 
 typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
-    UCHAR revid;
-    UCHAR numEntries;
-    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
+	UCHAR revid;
+	UCHAR numEntries;
+	ATOM_PPLIB_VQ_Budgeting_Record entries[] __counted_by(numEntries);
 } ATOM_PPLIB_VQ_Budgeting_Table;
 
 #pragma pack()
-- 
2.25.1

