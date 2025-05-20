Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2AC5479B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C599710E093;
	Tue, 20 May 2025 04:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIhFVdMK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC51810E093
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVo/QvTZyuWIWDCY3lSlG0UFI1NuieIYHS0tkHdwPbZnhE3gI4lSdzkJ1IffB0MWkQzgNHIFSgFAat04F1va3czdN21ywD47ESiRBr9i7expE+mWLHTKeBMfDE5TOZTRz+ZaIvd5DpLADpOkftEout5/Y3puNtDv2pnt1x82jMSnZTxVHPs1NfyQ2lnvshmu4ex3yyOdd9FSQNuHkqxrXc/1VlljepcxNDCZcoEcaLNSB2g9R5U2DlFd4TXaI7LiuJV/MwS4ETVFTGGaDQPLlkHW9244zxon0gJBMQuRb5hLajmXYlcYf/BdRXO2WQ/EBD1D5tF4KSKOmgLnX5uxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIXO1WKbETpVLHDPkWRD6B8U8QEZ2haLKby72VPpYTg=;
 b=T6+emi7D01/buzf7B/KGdb+Rjls/Vzg0gLwI5/PLuxXDfcrk3uDlSy7Rt59I/PwvygTyIYGcvNAIOct+9IaHUES2b/iCKL/AMFoNY0sKQ3pbyZ44b4yhMLr6jwFRIYGo7nqL9jMsG04qw0183F0nHuvf32qIbE4NlC+gU7362dmm7ad6Y0/J5Asnp0IdbhO1D+OVDn0/LD0t7YMV2QKbpHIPZJatNtqvWn7i+BEtYRTF/QQVuD9NA37Efubgl80C5l5K0FWH7o2yqZtWDj8HVPfD8N97A9vVG+F/m7ObhLdJnYZsr65JhndIAMP/pELGe7BIdqSo2LisrL6tjkuVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIXO1WKbETpVLHDPkWRD6B8U8QEZ2haLKby72VPpYTg=;
 b=xIhFVdMKcSN84l/0M2xRDnM7etrLAt7lg3Q/qE23uLbFdFO43TxqgxMdxmJyUgTVjaEqXjnYIT2gaFs72Nc7Hs41Bo9G99v8gUhxVO0/a02/w0NXOg30fQGmCeuU3n2ZRx3V/tq5yY+DtQnTvLnaSB5Xedlhs4awy3aoco6LSag=
Received: from SJ0PR05CA0189.namprd05.prod.outlook.com (2603:10b6:a03:330::14)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 20 May
 2025 04:23:40 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::47) by SJ0PR05CA0189.outlook.office365.com
 (2603:10b6:a03:330::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.14 via Frontend Transport; Tue,
 20 May 2025 04:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 04:23:39 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 23:23:37 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Stanley.Yang@amd.com>, <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: Add vcn poison status reg
Date: Tue, 20 May 2025 12:23:12 +0800
Message-ID: <20250520042312.1606650-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb14659-d077-4f65-73be-08dd975618f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NZIuXgpl9by5JLmOcRsWi3+Yh6SM0cJOpi62zTDC1rHUJOTDXt7X+0Sw8iHc?=
 =?us-ascii?Q?8h1uPInBvn0qst9Pr3UCtYPbNJBdRHZbrnpv4xUE1Ro8Nx4wdDcrJVaOl2Ek?=
 =?us-ascii?Q?gD9kJ5rt0gseQa+cGVZwyE/rVNu6hVEtMiYUw+SVVBa+LA6G9tmF1afN+d+U?=
 =?us-ascii?Q?2XNk+hhHikACU2nTPfTMByEKHvKamzES0pD3w8zcFDQN4IRq37sj5+pKdtVg?=
 =?us-ascii?Q?I4PaRwgbXCbFlBoxhD+/Pogz2vwFJ6nugFhcFtQ32ERtRCLKiZg0kQ4O8zYV?=
 =?us-ascii?Q?piQSr1hWCRelHBIuO5xQKmfiDz4HfEqFp/VGSQEiDGsvo8iX+WKwqVNkf6jH?=
 =?us-ascii?Q?wY6J1Vj31h/pIfE26BzkPlE1z4U3Xvbo1ZhIwZTpXtq/N5VoKx6HRv4pSo9v?=
 =?us-ascii?Q?blhlvklE9QO5cssEXywQHDQ6koR9rj89b9itISW0ab6tcctqH9ntmoYw72AO?=
 =?us-ascii?Q?LWGXg18GCRTsuodyvcQ/Ter0PmVyE4KiVVsDvB0x1meavhCjxvVEz84FjeHz?=
 =?us-ascii?Q?o0EBvqJdHo/lt6zAZfo9uOnQQ8RtJ5v0FNMJschJ9qL7Clt5uDELHQSl/11U?=
 =?us-ascii?Q?9w2it9vBeeos0w79vtU5MPce1tVqZU3pCvaxEAqvSmczBNdLwTxrGXgfMS8W?=
 =?us-ascii?Q?0ExP3L3rGpY7umdpZuPUQ9M8DrDXtZBreyj/ir3qmaLdpSLk29JzbLG1oaEU?=
 =?us-ascii?Q?dcGcLrfSvG+7D5YpCN/NdTo/pn5woYKqcPG1Cg1jxLqLFssQZoXXZs6shBQU?=
 =?us-ascii?Q?oqpleVvZLb+i8DAq4O1xSl1aWhq35FsmwXo0uHMGnnRouiMhQhZEU+OjiuCQ?=
 =?us-ascii?Q?RoVPQOyvmnL8Ywyd7aTP2aTJGPchdX2U6WDPiy4mI8eOYt2U6t9ZrC/1/uKG?=
 =?us-ascii?Q?Aq1n0ZHi1dYp3Iibb2QWMbuZYj4O7Nv7O/fKWkexdAcLiBCrs6wLToVbLA2y?=
 =?us-ascii?Q?nCqVkZNJbO89PVKlXRM0UtJWY00hwN5qyUbQD0g7nZzWpOoWRotL5vb6ca6j?=
 =?us-ascii?Q?t/gY6shwIAkzxgb3QLoFDIIooSXo4JPj1qtIfbp14BrJ92p8J3psknhU7MnY?=
 =?us-ascii?Q?Jq+uV4zJllz6WPzvHIvzNkvbBgG8WMxEFd0/yz6C0B1dS0tEXUX0n4Fy2XpX?=
 =?us-ascii?Q?jQN0v3fLo9ZaYqefPZgCV0IYLQrsiLa/zPRZEZaeRp+q0mKmbQnFoj78EA4o?=
 =?us-ascii?Q?FMuJeegma6Ho+SRzREfgGR9gSJe1bhWzztWzcsaB1jV+yyLOxrAxgh1uBwUc?=
 =?us-ascii?Q?JCqVZfIfA86fYj8uodMsjkGDwvC+gogbDC2zn1mguGxMmRwDKZos9C8FGtTf?=
 =?us-ascii?Q?BZd3xolm3NhjodgQHIAAV/0fhyOY9LWbw2BvybKBzKiNptTWw7OdTNXEF/ih?=
 =?us-ascii?Q?JOTbRRWcL62PbNGD4gJ+SSUmGCNg4w85E6VWvPf2KsQVZ2UITnAV6bPydOpp?=
 =?us-ascii?Q?hrsRwpkuBqjv5LJRt+rYQf8Olg9gy9NhvsSqNozhcgsWceOFOecYheTjmc4V?=
 =?us-ascii?Q?BznIFQUY3/T6vz7II1+LeW2JsavRr4FsVYLC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:23:39.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb14659-d077-4f65-73be-08dd975618f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

added register to enable vcn ras

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h | 2 ++
 .../gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
index c4aaa86a95e2..f45155280ff5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
@@ -1067,6 +1067,8 @@
 #define regVCN_FEATURES_BASE_IDX                                                                        1
 #define regUVD_GPUIOV_STATUS                                                                            0x0055
 #define regUVD_GPUIOV_STATUS_BASE_IDX                                                                   1
+#define regUVD_RAS_VCPU_VCODEC_STATUS                                                                   0x0057
+#define regUVD_RAS_VCPU_VCODEC_STATUS_BASE_IDX                                                          1
 #define regUVD_SCRATCH15                                                                                0x005c
 #define regUVD_SCRATCH15_BASE_IDX                                                                       1
 #define regUVD_VERSION                                                                                  0x005d
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
index bd7242e4e9c6..eb8ff9de5826 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
@@ -5714,6 +5714,12 @@
 //UVD_GPUIOV_STATUS
 #define UVD_GPUIOV_STATUS__UVD_GPUIOV_STATUS_VF_ENABLE__SHIFT                                                 0x0
 #define UVD_GPUIOV_STATUS__UVD_GPUIOV_STATUS_VF_ENABLE_MASK                                                   0x00000001L
+//UVD_RAS_VCPU_VCODEC_STATUS
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_VF__SHIFT                                                        0x0
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_PF__SHIFT                                                        0x1f
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_VF_MASK                                                          0x7FFFFFFFL
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_PF_MASK                                                          0x80000000L
+
 //UVD_SCRATCH15
 #define UVD_SCRATCH15__SCRATCH15_DATA__SHIFT                                                                  0x0
 #define UVD_SCRATCH15__SCRATCH15_DATA_MASK                                                                    0xFFFFFFFFL
-- 
2.34.1

