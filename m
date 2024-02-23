Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D97C54E49
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F9610E13D;
	Fri, 23 Feb 2024 08:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ef7PVkdl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52E810E13D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTk4wgCnhE4PBcxvc/oYDjZ3aTZ0KlyIkWO4kmEf4tqxStRwO7/KzyIDCxfsH1H9CxGs9v4LzXwUwnLfTDVCo3b+zNJzNDPOyZsfnVRcuH26BY5pSjt/o4tq3T0aLpylCL6QjdGhfOPAF8sJFIgcfa0vZOJuJ2UMdgtacd1XEsP18rpVD+Fnb0CbI85Hx4B9jRqphCrOyo6DpJccEHq4eprpyFLYFpOSFXFWgK0aGDTnRrd/nptSaA+mUtZdAVNBIdrikS1hwY6cVdQLbpXrrD2fVZXm2UqrbDKPKWRrf8u2/FbCY1Eh91jg59UyfJWVMV2r52ttKFRk+1kRHP27rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G0jWfFjuUECH1uQwHPa4TM/GYSNrOg/T9r5NIkG8wM=;
 b=dyOehccR99O3ROql8Xv/AWISLnPfqYa1oYQlaYE950gR1UevCXJKF6meaAApjNGHnU09qbhysONwEKZT6RDWvsB3e/AIcE2Rz+qQyli+Fl5GDEwGI2J6KOY6qLRT+QnDvlrS3p2Kf6EIbUkcHONN3Fud7qOFg3Xfmao0yzAGGcS9X/qrtg7X4z86XfLmxeUFDBGlggz4dURncFW8Ukhraooamfgl8WAN7e+8ozA692nWUV8odN2PQ5UPeQ+cwx6LFMVL/owgs9i63fK+JxVkH088hVWMbGBSAB6FtT/ne+tDj/1fxXsjPSjIE/Nyv6J4kWbll249OmNBUAGBJ7fkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G0jWfFjuUECH1uQwHPa4TM/GYSNrOg/T9r5NIkG8wM=;
 b=Ef7PVkdl5CX4ZR+vt6ex8zbEcseHl26JC2N/J5U6wmeh+70DwG5U+R8a1S2MVbWlLQUSTGqEw1ch6TknuGphkP6AeB+cvBoHC7fjJZZBNp/406KMxWIO3ZPu6WFigVsjEQZzfHPXo8gmSw/PBmA+dN82nKUN5QkBFG94KBfZ0UM=
Received: from SA9PR13CA0176.namprd13.prod.outlook.com (2603:10b6:806:28::31)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 08:24:03 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::f4) by SA9PR13CA0176.outlook.office365.com
 (2603:10b6:806:28::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11 via Frontend
 Transport; Fri, 23 Feb 2024 08:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:24:02 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 02:24:00 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Date: Fri, 23 Feb 2024 16:23:48 +0800
Message-ID: <20240223082352.323583-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a2a1f2-6afb-4991-96ed-08dc3448cade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cn/mcQxmfA+2h1nin0BhWvwrYHoIP2SL3bSYOU6VwXKt4w9O0WedkFnd4Ow7vp4QKJK/gN9DuMeMQ4hSGjtWBPOVNNODrFJP3BAH5KuqK4jAGEYi4Y7SlKXfwrHkjWeM3e7w/piGAYvLj+KZtqXXEnjYxq/hZSkSBvqxHJadcmqxnjYOfniM9q7QElgVRs8FJJysNuw232tCLZx0ySQc1m2sItoJjDFp/WciTB/1uniaAYh3XqxQGSxI8lnhNhMT0ozFY0RS41Hl3WieOnEiVK5B4HkH8r8m+MbIb8T2sveiIKGxxSI9Idhnpo9yfnop3BJ5wF1RGMrLx9j2mvWmK6kX2/2G0n51B3dLr3yioLwFhh2m9UDfXQARmZ9Q2eDoWIG3tROu2hpx2Yn+YEk5ExjRZRoPxn3IAq6GwrF1wcgoYSUOmIn0EW42rxRvNc2PVE39SjHL7WxP0oHUaKzBXX6PXBADqO9InqXU1fGaFE0VlrimMOQ8e3qL2GQ53pzUOM4rn517DfoFG+kVHmIX/bfBRoO2z2OrDrA5n0aI4Yikq3JJQ5f7zTDHVQ06mYWvv0Y6K7OnNcu/lj/CCf/vAorjEMOd+nvyxL9Ri7FW9AVqR9WH5Tb61IMDPb3ZVPGlZYC1OSXEEqBaeSD0p5fHwQgQB+i4Heu6nkvVFoEarZs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:24:02.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a2a1f2-6afb-4991-96ed-08dc3448cade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

Add UCE and FED bit definitions.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index efc16ddf274a..2dfa0e5b1aa3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -6822,6 +6822,8 @@
 #define VM_L2_PROTECTION_FAULT_STATUS__VMID__SHIFT                                                            0x14
 #define VM_L2_PROTECTION_FAULT_STATUS__VF__SHIFT                                                              0x18
 #define VM_L2_PROTECTION_FAULT_STATUS__VFID__SHIFT                                                            0x19
+#define VM_L2_PROTECTION_FAULT_STATUS__UCE__SHIFT                                                             0x1d
+#define VM_L2_PROTECTION_FAULT_STATUS__FED__SHIFT                                                             0x1e
 #define VM_L2_PROTECTION_FAULT_STATUS__MORE_FAULTS_MASK                                                       0x00000001L
 #define VM_L2_PROTECTION_FAULT_STATUS__WALKER_ERROR_MASK                                                      0x0000000EL
 #define VM_L2_PROTECTION_FAULT_STATUS__PERMISSION_FAULTS_MASK                                                 0x000000F0L
@@ -6832,6 +6834,8 @@
 #define VM_L2_PROTECTION_FAULT_STATUS__VMID_MASK                                                              0x00F00000L
 #define VM_L2_PROTECTION_FAULT_STATUS__VF_MASK                                                                0x01000000L
 #define VM_L2_PROTECTION_FAULT_STATUS__VFID_MASK                                                              0x1E000000L
+#define VM_L2_PROTECTION_FAULT_STATUS__UCE_MASK                                                               0x20000000L
+#define VM_L2_PROTECTION_FAULT_STATUS__FED_MASK                                                               0x40000000L
 //VM_L2_PROTECTION_FAULT_ADDR_LO32
 #define VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32__SHIFT                                       0x0
 #define VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32_MASK                                         0xFFFFFFFFL
-- 
2.34.1

