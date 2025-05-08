Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DC5C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 12:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAAA10E8F9;
	Thu,  8 May 2025 12:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4znCHW7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A6010E8F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 12:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXsJ/dKjPIuS3njfbNDlX6aal1Sl/qmCdz7BzRzDTOLH77mw6/YbL4pYQEAeagXpp0lKhFlzhTIG8258vt3JCDMdIBKCaz1XxtvMmMmbg+Lg/W3ej/NNNuluMwTP0ZG22A23wLb2Ed4QR0v7wAyqkZ5ar1KuGdiijSAqa6WeYTuaOCLzmHPJkWYOGK2VM+eefrBdSyUeZ8KYD6gT8uL8j9SBS1C9lF+HSOv7qJCHk7Zx4rBOC71Wzf08a+9s345mR9494h7rgTr7JTq40nxxnv5HAZg6jN9ee2lkvoMzZ/TVUTJzniF6ttUcZypv+GV28TBXYTWrrzu4idFwOuC7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFEOzCZWc522r1aolaLLcKBJOqEkh0ebWBE5oozwBqk=;
 b=qbs8v0BbL1JHL0womOEjqv7RZ0yvDukuxR4NaXdw1CB0EaRhfPKhUCOvl2pvwg0sFR1PUrqYdDV7/g6I0woqrp3zP8/qQ+HUdHSnnNuuoFmwxxOytKbXCYtIXuub4PwWNcn1NG+u1m3yTnue+QhhP/xSGuhfIeQMyGeC6dN1o+RxKpDwG0ZWK61HBdNDkKZedGZgD/o4sm+Z6jI6t6F4BoGcYJV+u9jm8iopRr/ezRSyVRt7TudmpXblwLSvdiDfo57OfpyHPxbPRQpTGPgusjW21KXICDBzzJAMCOsDjji02ioSZrKmdBYOq+AjBPSnWTmWicC/vV9SYzke/fn2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFEOzCZWc522r1aolaLLcKBJOqEkh0ebWBE5oozwBqk=;
 b=N4znCHW7tvlH4WRCRaGaOfTsturCyqSUG/RfxURTTeLJR6gkDpfS140S3iDNYsjANSkjHrfeMkSR+SnQcOGHPqksy6apgzuBuUdoNSfD1hj6+CcFjiwdJLQ0NMepQpNzig6a+fb0YULpZ+YOFKzrb1Hku/Brj+rKBCVAKUNdwn0=
Received: from BLAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:335::8)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 12:42:11 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::2d) by BLAPR05CA0026.outlook.office365.com
 (2603:10b6:208:335::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 8 May 2025 12:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 12:42:10 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 07:42:07 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, <Guangwei.Ren@amd.com>, 
 <Yunxiang.Li@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: add vcn v5_0_0 ip headers
Date: Thu, 8 May 2025 20:41:49 +0800
Message-ID: <20250508124149.340361-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 7196da98-0a34-4238-49be-08dd8e2dbffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2uVxzhT3iOcsk7mzhi79aAW3hY1E/2iPZiCeLILzBtLyR27vRygqUTvXjTc1?=
 =?us-ascii?Q?YfoDgDuI71AHtUQsK3BiKs9NyuFyyG3+6Gb1A74/GRuec2iCWxixVclonAxs?=
 =?us-ascii?Q?c+2wZcunbzL2kRkqHwQUE0Z2Z1OlqBx5e+MJhmVOUL8uNJVJc32upaD43qpj?=
 =?us-ascii?Q?HyvfLR9uHam8g8iAxxotr8afky1nr8CncePuPfnRIR1VmoB2hR19TqolPldy?=
 =?us-ascii?Q?pHIV2efWzKrtGZv9zXJeCbJbByNrKH5Y5R+r86df9thEJrZb1QulQC196xov?=
 =?us-ascii?Q?xB4Y6ec/RD61Iv5qdmcX1n8tj3XDY39+TNnjffRzg0urHRLSy/05qzqBEwa8?=
 =?us-ascii?Q?Hm5zmChLCyM3yQ3OZizqEToK4h/OCflh2IDNP/ldrP8WcF7CQaXAf/EOZsLF?=
 =?us-ascii?Q?Y7Pve8si2qIEv4fLq2vcZ+XSzrxWymD0BB1PDLEKNLPVEuGuNTTHlwAbrT4t?=
 =?us-ascii?Q?ZcPsVq/SSeouzX7oK1LOMaagmgkYyeeqZI+xYkt/a9hs7sXFFpJ+NDl3XzoR?=
 =?us-ascii?Q?t9zII737vHDP5Wl52EjE4aU8vRqFb5efumg8AyH+OJpAn+h1NkB58514EnZ9?=
 =?us-ascii?Q?jQFYzMIPQ7BGNEIGDIZGdqaaVyMO1Ltq+Bj3nV+qkheu6w4JqqerHvQ09yGq?=
 =?us-ascii?Q?RbTO8hvr++cLUd6B6DNtecJ6K7KlgDHyP28tA6WyERskTj7EuU5zPlV6DAo2?=
 =?us-ascii?Q?9Dx8aDKuiV6s68L4dwrIEYBQdNQl2yHCGFDSPDXUvz+av9QGwTMBEPJ/Kyk1?=
 =?us-ascii?Q?PQuS/ywGuGsO0g9rT7VqTtM9RowY40v+oBlV3o9cotJyXkn47VeGln88kOOw?=
 =?us-ascii?Q?PisWXwT+sI9bgsNdagfM2EZmdivf2/hvddjTXYwyycuzZdDJpjZdzzgrkVEs?=
 =?us-ascii?Q?24+OAePdrVQw8t9YIMsx1l86hWkv1V9TUVsbvtOmUF2iD9dDdpesMrP0vwc6?=
 =?us-ascii?Q?CvP6bLqDsmw+ngx5KO5MYcKXtp/qHM9meM57KkLfs+QTA65WrRWDB63NGf0S?=
 =?us-ascii?Q?RgDq3uwFhngzDi6+9ep+eqOOJYh4Q1BY2P5CPpCK4E1sFXzbXu2FwOot6Vi5?=
 =?us-ascii?Q?PNtXn3CiV0jc+Me77eyC2N5tJJAS3wnxV6qIuE7PV32HJNTskoNuLKsc3lId?=
 =?us-ascii?Q?Klj8glEAeG03vbBUXgEzvbQ+2/0b8Q3KsoVIBByoju+xYZX11EGR4LJKYNps?=
 =?us-ascii?Q?6oLXCuO6NFgBQjMMZ1IkfiXVHu3QySTSyrWOs/6UwqKZT/4yBiNZwZNEHiUC?=
 =?us-ascii?Q?+zfHd/J8cxfzJXvkf8VY5DAoTChqkokIx6SulZlnK+n4QPX0PqJS9dJo2d2o?=
 =?us-ascii?Q?3uuJ5PCquWjwxw+sdjotaoaSV0Rr7Bz1lFNKdwD3pN0FtF7incH5eMAas3Rp?=
 =?us-ascii?Q?mDlLEMVgLC78I6Zim/oJVlXRd+aZqU2nN/3RjRFIq5/pou/n+7tk6aQ4CcdO?=
 =?us-ascii?Q?D5hAcJGeo2rAw59yOm2CQEYxOj27ok2dYGBdEtcFxAW7Uu+MF2KS6ZMzbJ18?=
 =?us-ascii?Q?hW9fshCK4BRbYtUUg30PoXyEakTnwWQ+hrY4f6rlSaIz8FH+bHhrvIgBaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:42:10.1762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7196da98-0a34-4238-49be-08dd8e2dbffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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

Add vcn v5_0_0 register offset and shift masks
header files
Only include the registers required for MMSCH
initialization

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 .../include/asic_reg/vcn/vcn_5_0_0_offset.h   | 16 +++++++++++++
 .../include/asic_reg/vcn/vcn_5_0_0_sh_mask.h  | 23 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
index 14574112c469..c4aaa86a95e2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
@@ -1147,6 +1147,22 @@
 #define regUVD_DPG_LMA_CTL2_BASE_IDX                                                                    1
 
 
+// addressBlock: uvd_mmsch_dec
+// base address: 0x20d2c
+#define regMMSCH_VF_VMID                                                                                0x054b
+#define regMMSCH_VF_VMID_BASE_IDX                                                                       1
+#define regMMSCH_VF_CTX_ADDR_LO                                                                         0x054c
+#define regMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                                                1
+#define regMMSCH_VF_CTX_ADDR_HI                                                                         0x054d
+#define regMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                                                1
+#define regMMSCH_VF_CTX_SIZE                                                                            0x054e
+#define regMMSCH_VF_CTX_SIZE_BASE_IDX                                                                   1
+#define regMMSCH_VF_MAILBOX_HOST                                                                        0x0552
+#define regMMSCH_VF_MAILBOX_HOST_BASE_IDX                                                               1
+#define regMMSCH_VF_MAILBOX_RESP                                                                        0x0553
+#define regMMSCH_VF_MAILBOX_RESP_BASE_IDX                                                               1
+
+
 // addressBlock: uvd_vcn_umsch_dec
 // base address: 0x21500
 #define regVCN_UMSCH_MES_CNTL                                                                           0x0740
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
index 5c119a6b87fb..bd7242e4e9c6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
@@ -5929,6 +5929,29 @@
 #define UVD_DPG_LMA_CTL2__JPEG_WRITE_PTR_MASK                                                                 0x0000FE00L
 
 
+// addressBlock: uvd_mmsch_dec
+//MMSCH_VF_VMID
+#define MMSCH_VF_VMID__VF_CTX_VMID__SHIFT                                                                     0x0
+#define MMSCH_VF_VMID__VF_GPCOM_VMID__SHIFT                                                                   0x5
+#define MMSCH_VF_VMID__VF_CTX_VMID_MASK                                                                       0x0000001FL
+#define MMSCH_VF_VMID__VF_GPCOM_VMID_MASK                                                                     0x000003E0L
+//MMSCH_VF_CTX_ADDR_LO
+#define MMSCH_VF_CTX_ADDR_LO__VF_CTX_ADDR_LO__SHIFT                                                           0x6
+#define MMSCH_VF_CTX_ADDR_LO__VF_CTX_ADDR_LO_MASK                                                             0xFFFFFFC0L
+//MMSCH_VF_CTX_ADDR_HI
+#define MMSCH_VF_CTX_ADDR_HI__VF_CTX_ADDR_HI__SHIFT                                                           0x0
+#define MMSCH_VF_CTX_ADDR_HI__VF_CTX_ADDR_HI_MASK                                                             0xFFFFFFFFL
+//MMSCH_VF_CTX_SIZE
+#define MMSCH_VF_CTX_SIZE__VF_CTX_SIZE__SHIFT                                                                 0x0
+#define MMSCH_VF_CTX_SIZE__VF_CTX_SIZE_MASK                                                                   0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_HOST
+#define MMSCH_VF_MAILBOX_HOST__DATA__SHIFT                                                                    0x0
+#define MMSCH_VF_MAILBOX_HOST__DATA_MASK                                                                      0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_RESP
+#define MMSCH_VF_MAILBOX_RESP__RESP__SHIFT                                                                    0x0
+#define MMSCH_VF_MAILBOX_RESP__RESP_MASK                                                                      0xFFFFFFFFL
+
+
 // addressBlock: uvd_vcn_umsch_dec
 //VCN_UMSCH_MES_CNTL
 #define VCN_UMSCH_MES_CNTL__PIPE_ID__SHIFT                                                                    0x0
-- 
2.34.1

