Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90630CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 22:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B4F1120C0;
	Tue,  2 Apr 2024 22:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2YP8DI6";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFF41120C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 22:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbz6BLrsx8bPJ6F1MajIwrD+Ykwm19ZHRIKHsb1wGTIkivpT/qJRewfCMF6ulfYVIjNNfl8HPX0THPSxMOSMyuOkrKd8N+0UI9PwIhXIQuDooEbxuWOqI12Q5ekrHCGy+4ExRhjz7zJUwIKqR1Z+apMhSiAAtfgLuEVULi1IUQzMzUKgeTsFMBuuhnxL90xaPIhyGK7HDTCUFUdTrZ/c1ZpHlFoqtUD7LMj3j6ingU2o2oHomzS4KsaJ2LD+++j15SbZV34KdmEmLBbF9AUxaevxX7ED5UxejLu0UUHHOY6EACAXguETivXwV9Av/DDjB7M7mzArqK/bK41sFg/TMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFdjdgeQhd3h59v4b+DLtVwIDTUHxViQCSfzE56sgkY=;
 b=FJtytKaLZG+Czrl3jomeNgxmo8kuNS5JJd4NZw4lE3CXvJFPcc8Zrg89WLVYRihPFKZilsk5qykJiE3YoeAcRNFH+M1xcN/xXHNHVB1+NlyK5bb0ukn4jVKe91WXo2K4qbkd2SX49Okx5xeP12tKemAVJQCSDNU43o61TOy9bI0rWk4d7yOLKVUR985Ybs2CpwxmvYPiZ+qVp5ztmMoi2Do4TwlsCPPPy/e7vFIO5iX2S1B1MOgc/0j227kR5jEtrJT/mnDsq2lNAN1WRmmwGRvaqzyI9LFDlwPUTv2MI6RI9syNNnmNooe+F5JleHz+JDngs9ItJhQUYxkrKj+5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFdjdgeQhd3h59v4b+DLtVwIDTUHxViQCSfzE56sgkY=;
 b=D2YP8DI6b/urMic5qH1vLN4tgSzI0yZ0BJhbXeH25UTlqRZ7rUSoA7ovBxE1wDgPa0bJpOmp5Fw9ffv+Q969d3UBxXSWQSBr6G7dCMg1DBUD2bRtGKQBqfMTYJa6P1gPeoiWfkFFCmHsjFJp65wX2zRHnclPxy4iZxiIA825qsI=
Received: from BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) by
 MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 2 Apr
 2024 22:01:59 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ba) by BL0PR0102CA0007.outlook.office365.com
 (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 22:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 22:01:58 +0000
Received: from yunxiali-hp.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 17:01:58 -0500
From: Luqmaan Irshad <Luqmaan.Irshad@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luqmaan Irshad <Luqmaan.Irshad@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Update PF2VF Header
Date: Tue, 2 Apr 2024 18:01:36 -0400
Message-ID: <20240402220137.184869-1-Luqmaan.Irshad@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2200b1fb-0e59-4f2a-6a9c-08dc536084bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vxd6hEHP8+ggQZgTAuMOWVnyJeUIT2G8j47slPDQY0qVF9DwyKgM1PDbtNyov0zBeAtEuhARRj2XsXRf4wh05GCxpu7omg8hwP0NoMRbIpDvtnyYFChTM6t19Og3IX3kfbHi6W/q0ZdKkBGB9IEMy40PsoL/fm2zgUlcNL5KiPGoCPBpsG92tJwMny1zRZF0a8iRMltejIAGFferKpgGq533kDXwxke1lpQlFNlj9CITNvTuIcr7LmuRFQHVWEZiwlV6rbQKsSlgawt5T6SNZo4TuJfKEnHyKt5okOoZOcwiLhVW+J/h7rCamzLnOzgkna94naYWbmyQo9LhPzWS+ZvBrt6BN9IdLn3LDNf56de69Ytc3kKwOaxeZ0Msk0tYayO42wgdjNPSWx+EaIVp/WE+vGJG9Aymr/2bQ8oEj16dSZqtZuZCpkoQqrRU47Qy5lKCVS2O36rHjqy3IupRbQOXORhglJpu5255ADoc2pI/oQBMZH9eDL2MUI4LO64lMb1SmWbISBEJlYScO4rPSOnTGdrCA38Wudb8swoMu56XKwhoOrjFi7wAfc979wg0+rhn08BlZPzio2foi2kKhl61t421upoCIuR2OzjfgeBqvee7rppxjbEggnzUlF8UTfFWdMnns4Lshk7bAfcQJ14mZ17qtK8+Wec7tm8aVOjOW7XSSrRISsuTiDFtIT91nZjQH3ZxJMXinjgJevRNtvynsNFt92RL/SfY3jdUh3L0mJ7C4lEpHhpPHnhp6kfe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:01:58.7983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2200b1fb-0e59-4f2a-6a9c-08dc536084bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

Adding a new field for GPU Capacity to align the header with the host.

Signed-off-by: Luqmaan Irshad <Luqmaan.Irshad@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 0de78d6a83fe..fb2b394bb9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -158,7 +158,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (49)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -209,6 +209,8 @@ struct amd_sriov_msg_pf2vf_info {
 	struct amd_sriov_msg_uuid_info uuid_info;
 	/* PCIE atomic ops support flag */
 	uint32_t pcie_atomic_ops_support_flags;
+	/* Portion of GPU memory occupied by VF.  MAX value is 65535, but set to uint32_t to maintain alignment with reserved size */
+	uint32_t gpu_capacity;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 };
-- 
2.44.0

