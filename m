Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3806C5DF9B
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7110B10F491;
	Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HGIcD3CT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAD810F47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r23ejstHVXqghHbP+BzZTN3hgQMbLeFtKkJgASCNWC9qZoT0lrHCfW6OxsyzlMp3eV4xO1ecrGKHXyyTmFP8ihJQWtcWQ3l3uvaE2V64txrLRv0b9JU39rdOp5H1B+Q4kak2PBrLOFhjXGC4uTdwYJbrWJGjQm5/+KJdAHHNTT25IRXhzjYQNQMs7TJFwd62+Ht/HMKMXGdKMJ9PzApiscmQAEm9HBQ0OPmHCYxXWL8mkuCw20JdVj8CRtJGHucD4z9AW+kVipsLyMbiuN8Eo8awShvU8ZW3Tur3ZPkqyDcs2rIujc4ukTfgh0IJcBZR2m2+1cJEdsJEy3Pz5A4TYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNevbVPbawKuOsEExJgWt0Z/EPOO+/4Jtn0SIBrshsw=;
 b=rCFgrCbJFt+aliKDZpslauT1ZmX88+viFJLX8jN73rbtxUYtWXQJD9+6/6syxizceFP5WnZnXa29cZsedXHd/Kxw7QaSgZAn6lViKOAfpp9wk0/QJt1sdzX9C4qrClmj8KcxA/m+zJih6mzU9M6vf3pcVNZZ9wF553N2rJp0+PZVmp2n1AZq3qxObgSt7/w1zvuYgtLsay0JGM081DMQMRDHwBcmKUgjnrHEemMSbG9kgboG+boD1vJ1VB7mTPbcdyNwnFR1ZizkgLuvT88ScePROurAYBtfUOkxhNm/xSytc4gEqWfPVzUjMYgVVNO9MTNnbYouWxEiAm0BGyIawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNevbVPbawKuOsEExJgWt0Z/EPOO+/4Jtn0SIBrshsw=;
 b=HGIcD3CTEXxf/2e8qeDRfFs2ECurE6Lf9YXLFCeNE2jKAivprOuoHXJa6Sz3+lXX8hNxSM8Xarp2zp4dbZCIGoLtnZRhnMTPWZc9NSPNFU9zI29z2fZ/iLSu8ro3DB7nD+Q3PaM/Tq9k7abR2lsIgfvo/YR/aN0FeshBkEutMRM=
Received: from DS1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::12) by
 SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:36:00 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::30) by DS1P222CA0007.outlook.office365.com
 (2603:10b6:8:454::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 73/95] drm/amdgpu: always use MTYPE_UC for remote memory on
 GFX 12.1
Date: Fri, 21 Aug 2026 15:34:36 -0400
Message-ID: <20260821193458.808626-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 457217dc-5a3d-4f1e-4d9e-08deffbb6dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: LuTZsWyjVBGkAW7NB/opoG/aFwj9sCpYCYVyLkHa/pyV/4H2ysZnvKor6cdAiSTzQpyqEsGdF5aLenzTAvkh86Fpek9qlo32av6tn3oBtj6Ogd33VTFLB8aaHI+weKGW/Y5u/0n+WtR7+KpETKA0ikuBwctJbblURgaMa188xnzk6Uqpzrt8yt6ep0bWrppeXr4Mi7cMUxnNCJb4wmImyU9H73JfJ8fR2Cc7EzhC7oQar6lOCWHv0nrE9phJJsJU9WsdDgM5Lu6AwDor9pB9nispLO+WS8u2DDMtcWjDkFsNOBbdbh6QI6jJZLTfTVsk5VKnWAdg8NZBUupWciYmRK6wJ7J+5xPAvpu/7f1qozAjAl9wNh1yuPMCFpa4/SbtG0RV9CNeUNtv37KvWuHWvmDdX7xpsGM2uxvEVCcwyUmMjnDi3bUCg4sDlSCrzAqprdKLmdl3l0ZPNRGT/HaoFsqoeJvrU5zu3P10lnXJ+ODta4uIAWL7MMduWZH66MOGSqUbfd+0GtZ9Ne29L9JPsVPPWInThFax1Ox//fgYpvnlo/WbGfolFnRrbsUKb6NqFuoyt+lgQ0vvdvtxd1kuVlL772RtpVOXaiuVSSRRn3OtjuDGIKXvB7ujYyaXzo43xVO895TSa/gNswMRIPs2GT/hrRRKNtHSMJFrtLKOIRGhiNUPD0ptznR0Eq/rEnVOwLd/F1nAnzTEmVlstlgYhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oh9whCZLkKVABBPV1nS4tnwqzGlr4lMG0xrp5fZOLL4eg87RtbLV4i+y5ysBaHxKykBN/cIVEAzJ+UIg1W6su37SGZnbJ5mdaR8b3kl93LgKGEYMmTg65hXxaDMKCHhZp2lcKvmeHfmZ/kgS0VMOvknQfoy88M6n9o+cazi9+Am+TPO89zwkjhNM0inSGJLAaNZMtAc7agZaLx/cXza9rF/odIkbH8YbqFDOm9cqPIJUvwIsz9vziCEvwFPvhof4HgNjlQcasJxoUWRrEq0TUs1JBf/c9SIQ4FOmwjaSWxPoDMBcOu4XleMqYT6DIxaCjHQ29Uy9dXfbIXirz+b4a2XJ4xn5XbDXNgL/VBMnexRH/wdX9pW11QnCs305ooX3L4SLtXXi1mR1z2C7YbN8IKBo6FM4qH+XvZBAc47FO0vNaOQRhJX1dfHL7Um3NhC8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:59.9145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457217dc-5a3d-4f1e-4d9e-08deffbb6dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1 remote (non-local / system) memory accesses should always
be mapped as MTYPE_UC.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 11 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 302ebf2f3ccd1..fd24d66290f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -638,20 +638,19 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		is_aid_a1 = (adev->rev_id & 0x10);
 
 		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
-		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
+		mtype_remote = MTYPE_UC;
 		if (amdgpu_mtype_local == 0) {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory and MTYPE_NC for remote memory\n");
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
 			mtype_local = MTYPE_RW;
-			mtype_remote = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 2) {
 			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		} else {
-			DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
-					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC",
-					is_aid_a1 ? "MTYPE_NC" : "MTYPE_UC");
+			DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
+					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		}
 
 		is_local = (is_vram && adev == bo_adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fb5eca38e6a93..64fb38400bd1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1348,8 +1348,8 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
-		mtype_remote = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_NC :
-				is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
+		mtype_remote = AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
 		if (is_local) /* local HBM  */ {
-- 
2.55.0

