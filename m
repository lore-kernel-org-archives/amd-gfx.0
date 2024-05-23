Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A205CC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 13:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9316510E65A;
	Thu, 23 May 2024 13:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="DI4NMuWu";
	dkim-atps=neutral
X-Greylist: delayed 948 seconds by postgrey-1.36 at gabe;
 Thu, 23 May 2024 07:32:37 UTC
Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A598B891AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=devnull.tasossah.com; s=vps; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XoRV45eTb6FtMOVbjrbEY9D0nnIfjS+sNa+jJ4ZT7Sc=; b=DI4NMuWumvwMqEbxZTvwsfleTE
 xFJrjwIwaHtRrLmgtm6+LpDVYROqM97kaxPdGZ7i8qR8/TmNHfMuEzhl3qIG1cfFZcMoGAyTxRIxV
 MTLgIUZgnbf3MEJVW/PRriivOdqdYh3N+VGCCKUqzl1bimdJ3JJFQTgGpfMu4Z3KjTqY=;
Received: from [2a02:587:6a04:fe00::298] (helo=localhost.localdomain)
 by devnull.tasossah.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <tasos@tasossah.com>)
 id 1sA2gw-002S82-6X; Thu, 23 May 2024 10:16:46 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
Date: Thu, 23 May 2024 10:16:37 +0300
Message-Id: <20240523071637.1114898-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 May 2024 13:04:44 +0000
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

Dyanmically sized arrays used [1] instead of []. Replacing the former
with the latter resolves multiple warnings observed on boot with a
BONAIRE card.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 2e8e6c9875f6..d1dec880d2d6 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -480,7 +480,7 @@ typedef struct _StateArray{
     //how many states we have 
     UCHAR ucNumEntries;
     
-    ATOM_PPLIB_STATE_V2 states[1];
+    ATOM_PPLIB_STATE_V2 states[];
 }StateArray;
 
 
@@ -514,7 +514,7 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Table
 {
     UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[1];             // Dynamically allocate entries.
+    ATOM_PPLIB_Clock_Voltage_Dependency_Record entries[];              // Dynamically allocate entries.
 }ATOM_PPLIB_Clock_Voltage_Dependency_Table;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
@@ -530,7 +530,7 @@ typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_Clock_Voltage_Limit_Table
 {
     UCHAR ucNumEntries;                                                // Number of entries.
-    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[1];                  // Dynamically allocate entries.
+    ATOM_PPLIB_Clock_Voltage_Limit_Record entries[];                   // Dynamically allocate entries.
 }ATOM_PPLIB_Clock_Voltage_Limit_Table;
 
 union _ATOM_PPLIB_CAC_Leakage_Record
@@ -554,7 +554,7 @@ typedef union _ATOM_PPLIB_CAC_Leakage_Record ATOM_PPLIB_CAC_Leakage_Record;
 typedef struct _ATOM_PPLIB_CAC_Leakage_Table
 {
     UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_CAC_Leakage_Record entries[1];                           // Dynamically allocate entries.
+    ATOM_PPLIB_CAC_Leakage_Record entries[];                            // Dynamically allocate entries.
 }ATOM_PPLIB_CAC_Leakage_Table;
 
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
@@ -569,7 +569,7 @@ typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Record
 typedef struct _ATOM_PPLIB_PhaseSheddingLimits_Table
 {
     UCHAR ucNumEntries;                                                 // Number of entries.
-    ATOM_PPLIB_PhaseSheddingLimits_Record entries[1];                   // Dynamically allocate entries.
+    ATOM_PPLIB_PhaseSheddingLimits_Record entries[];                    // Dynamically allocate entries.
 }ATOM_PPLIB_PhaseSheddingLimits_Table;
 
 typedef struct _VCEClockInfo{
@@ -581,7 +581,7 @@ typedef struct _VCEClockInfo{
 
 typedef struct _VCEClockInfoArray{
     UCHAR ucNumEntries;
-    VCEClockInfo entries[1];
+    VCEClockInfo entries[];
 }VCEClockInfoArray;
 
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
@@ -593,7 +593,7 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
+    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[];
 }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_VCE_State_Record
@@ -605,7 +605,7 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
 typedef struct _ATOM_PPLIB_VCE_State_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_VCE_State_Record entries[1];
+    ATOM_PPLIB_VCE_State_Record entries[];
 }ATOM_PPLIB_VCE_State_Table;
 
 
@@ -627,7 +627,7 @@ typedef struct _UVDClockInfo{
 
 typedef struct _UVDClockInfoArray{
     UCHAR ucNumEntries;
-    UVDClockInfo entries[1];
+    UVDClockInfo entries[];
 }UVDClockInfoArray;
 
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
@@ -639,7 +639,7 @@ typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record
 typedef struct _ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table
 {
     UCHAR numEntries;
-    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[1];
+    ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record entries[];
 }ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_UVD_Table
@@ -676,7 +676,7 @@ typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_ACPClk_Voltage_Limit_Table{
     UCHAR numEntries;
-    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[1];
+    ATOM_PPLIB_ACPClk_Voltage_Limit_Record entries[];
 }ATOM_PPLIB_ACPClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_ACP_Table
@@ -745,7 +745,7 @@ typedef struct ATOM_PPLIB_VQ_Budgeting_Record{
 typedef struct ATOM_PPLIB_VQ_Budgeting_Table {
     UCHAR revid;
     UCHAR numEntries;
-    ATOM_PPLIB_VQ_Budgeting_Record         entries[1];
+    ATOM_PPLIB_VQ_Budgeting_Record         entries[];
 } ATOM_PPLIB_VQ_Budgeting_Table;
 
 #pragma pack()
-- 
2.25.1

