Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E7FF433C7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 04:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937CC10E71A;
	Thu, 16 Apr 2026 04:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxqGmS8G";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7CF10E71A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 04:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ8SDEwh3xwHnEopt46jIZM+DlPn0eKc8yMZMqrAW7346yBUOlaUCiUnh5dRQKzzcTudRm/kLuuNUv8Jjz6EEYxpM4vjKqSFh06bAdxmQbbKMu3QO8ib3tlVg4aJKkrNiNhRx8ycFfmfquHa5RnWG/3+ISbmF/5VydcdyOF5pawaxK66UrtXYK7C1Ix1jG4FYbsjIeMZ4NXsFsc3ZSF9FcceVXBADJGC2ZuAS4H9WgkPu0C0odca+5pW7p4P/zo09MBsO4UfMS2k6SPisQFX0gIyg5ncA7EOeSpAuEukhQTikmshVqw5E1DVXdVSJBXbtI0CsB23CJ9u1rrrbwJMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eAaS7cXGYhPIPtq4KHOJGH3QGt7vIGRUSIcfDV6ByA=;
 b=c6kUC8pss7ZNgTNFtuWwn4rgZXp+v2airGvDqOBGva2Nd4vbZQWEF0bbKh/fOqXGSNKZjykvkzixy2TgnJGg4jjYtPAPnnVp61gMbb2R9MrrMnh55vuiee9r/NvOEFzzL917VaE83v3cuCxi6OVy+fIhhPDQY5KVa8L3RBIRZno7VUR2c9d/mw1rKHoMhmezLtNR0MQcZq239ul+tw6iN55eKqczlgdHfltjQxhel+suCujAjAoiFkIK1UCyDgS4i5dbCqBTuDB6zpdCjguD2f7F5ltP+XpEwTyGJCTRQmeGcigWEzJPVwU5rW8QlgmBFNFS2JbezET9PI7s09iqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eAaS7cXGYhPIPtq4KHOJGH3QGt7vIGRUSIcfDV6ByA=;
 b=NxqGmS8GpVBYNDiCB+fIAIj+tCuv9AE8YTMcwExC9UdUVDyFx6tCsBXaHc2OiLn0iGIwREAd512iOk0GmXDZ2/hTILF7RYWiy0wZM2i8QHNzU8T7Gg5NC0ZHjJCN+RfxoCqd9zrfrOg00QGNtDo8XAxTCheaWXmyWvYP6UIOUfM=
Received: from MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 04:50:46 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::95) by MN2PR18CA0020.outlook.office365.com
 (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 04:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 04:50:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 23:50:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: bump KFD ioctl minor version to 1.23
Date: Thu, 16 Apr 2026 12:50:25 +0800
Message-ID: <20260416045025.1825888-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416045025.1825888-1-perry.yuan@amd.com>
References: <20260416045025.1825888-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1e5839-91f4-4e43-1aa6-08de9b73b5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cJyoL0dogajmhMiOX6S3BfEjhZOVtiyLEIvbRyAFlx9A7ogS1181hUVqsV5Nl/lzToTDtkJyESjhobZDXS2FHt3JgznRbiJ8MtunWUQaOs/DZozHS/0hsRoZzohe5yrx6KDxyYbxliO8EXZpJWeK5hHhVv/SPHtLo3MK0u2nuaZYIvwAkCCZjXMtze1VuGqGAkh5wIDYxktm6M/wHVQnhNQmaHLkL+5s2oMDmpnAtAZ5Ho1bTX7P49VRPCE68NlixVvCpH+wsvyO5pyK79oUyYTeDLCmbyDEXnM8DBpPkKqQ8ScYZiMargd0ERBMBoaQhS82nlF+kFvxy+Ild/2St3eECAEwXU1Fqn9XfrElB+XVZGMc7Vkfpy6EMqqsYHPuCLTfu/oUtipz5QGh77eZYX3r3RJR0pZJOf+Sbvuqd/MmtLS8ekKhkI+48FOMHHyw73XwJ2F+DM11PXOTOg52dYFr4NIC1Nbc/CxcAYzMLv7ncWZZempDMI/S/Bp9EQS/BVlD3RKnbx/qCrvvozy+vzj+DWKhizilXERDV6i/e2+r29f56F/YTcocMpwWjLdsZ3bxEnN0nh1QsriOFTHk1gUNWXjN6DxAyGapeA7yYxUGMaMj426rEwhl7WItdKRxsLxMG1oYffq1S6fHFnE95c6K2lShs+4nIXytYgyHzdEWrDWZtSc0Srjtn4XJbN3OYPLaKtyrGtmo09b0PZkbHnhaB6K0DpHN9DYAzDmIP3J//r/PN7WKyXrhElFgMpuP5Xewp8eeFY8Rwr4YW99WOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xztoaYmMkEg/mAtKrt6t+RgAw4yjL5JbR7mHTpw0Z8OFfj38eLyaC4gYC2A/5z51z+DGRGkCTne/8/KBQs5lzpJ/C1brFYIVfUenxwh+pr0MKI/iiNblnG21obHfdrXkPlTLufz0iYDHodUBRRUU5U8AGmUQZ8CbnSn4T2G2aHBrR384JsFXb2GotgZSR3LYp1Z7GgbchWBrDik3iB2Fw4u1V1uuJM9leVPo8M99AvV3uNHXS/qdfpZw+daYPgDEGd4xa5FSQoeMqAk3qr/UMxO3BQ19FnKK8Loy/jUS6kz+Murvq5tFmWB17zj6ktGRxusD6Lm2dAbxfF65HiqTtrXfIqmjJiDARiNbuBOdsd+WQaET+hRw9OgepTWbtKhXkbxzD1TUG6+4OuFRdpqkDcBYPF0VrmCsXxOMx7+bWtB/ktXti5Zj4UBq4ehG+PvC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:50:40.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1e5839-91f4-4e43-1aa6-08de9b73b5e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

Bump `KFD_IOCTL_MINOR_VERSION` from 22 to 23 and document version 1.23
in `kfd_ioctl.h` so userspace can detect profiler ioctl support.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1a94d512df35..9584b5aab727 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -48,9 +48,10 @@
  * - 1.20 - Trap handler support for expert scheduling mode available
  * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
  * - 1.22 - Add queue creation with metadata ring base address
+ * - 1.23 - Add profiler control ioctl to enable/disable profiler on a process
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 22
+#define KFD_IOCTL_MINOR_VERSION 23
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

