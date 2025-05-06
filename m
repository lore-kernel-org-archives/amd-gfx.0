Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C99C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 07:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBD610E071;
	Tue,  6 May 2025 07:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stOoVCu6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E517E10E071
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 07:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0fXiU0PIKpELbe3Jnx4ixfobswLmEssoZxFo4d58aROUmdgY7lp4U+jQOzluwV6Ncdkx1PEUcl/XdP6XJZfDz9Dzu9Di/3gK8R9f+SVLV4yJ4EFtojhYMW4Jd+iY8Tu+BTeeI5okwsX0ijKnKIb+GsCb4AC2JmrJwKTTTI8d/vqSuElV5Ud5yMScw1g0hm99jFgdrN6BxHZXtlvl9B5U1zMr+t17quz8EFsGpqFhc1nIMVP6QB8pDdFKU3jMqH3kkg0qiW4iSE5vpqQ0wv2aO6Ns9xxXibDFK8QoolCsLvzPTAbV7gMANmbLqfTU+w0leH8Chr0XJQXxRRDLTldvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GtHNOQZCavS08wni3Jg77AZX1TsCLNrxh6d6yxe20U=;
 b=FIXidu9ufrAQPE2AFSzisTSUpmhUnXPDhDTNSxojUfHgv8U5Nor9BFKdq49tvR/QAdvM0bJTdn3UpRQRuZK62/GS+KvbNbmfzz+5ZQNy59LY/PIofVB9yf5DK0YN8ZCU+6ESSP7O0DGSg1c4FKcVDJ373lZ0YfgI0abWdaHGMTYh+Uw9O4HRluBaB8pz6YFJxyu2DJQ7x+26LKHek7WdAFvy2hamkyPeJfrXKzP7iFq2DIIvYEHEXa6x5O0fPMdgatjnf3mVYn6rgZUmo/KwgTb1DAWNLWbINzoUQHLjNcra0LTYQdy+4S/Mm3AQCV8tOH5qs3C21HtHkN6J3p/L+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GtHNOQZCavS08wni3Jg77AZX1TsCLNrxh6d6yxe20U=;
 b=stOoVCu6WqaRoTzwfDI8cAqRqq1ifWA2625M6JcDOAlYqL8JdI8SduMv0FEvv+ByumKhF8nixnhX6D8i6gticVqbk+pXjYJ9nE/5iJfk4HmcJuEo+hzO+3GxbUW3mV8Xusl7ralVFcR+C+qGRYKLAmC6b7D4dTReA0oI6lBRj4A=
Received: from MW4PR03CA0148.namprd03.prod.outlook.com (2603:10b6:303:8c::33)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 6 May
 2025 07:43:13 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::6d) by MW4PR03CA0148.outlook.office365.com
 (2603:10b6:303:8c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 07:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 07:43:12 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 02:43:09 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, <Guangwei.Ren@amd.com>, 
 <Yunxiang.Li@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: add vcn v5_0_0 ip headers
Date: Tue, 6 May 2025 15:42:40 +0800
Message-ID: <20250506074240.95139-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ddb538-cb39-46f6-c166-08dd8c71a7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RfIgJnAWdAK0pFsssX5ulo0Bd9yLaG0LZimrYDoZznZAYg+0tuflWV8f74qB?=
 =?us-ascii?Q?Iwae3YnT5V57nXMw8Lp3W79SnUOmeS+urh5EdU4MzSHh/Uett/BkmgmghBxX?=
 =?us-ascii?Q?shc9JDtERcQtupSBG0d4ZjfZSn5i46Vlh+Au/HKh49IuEYwGTvHg1BZnpWQq?=
 =?us-ascii?Q?/iHIkWFB5vSbKD77d5WQrip+zKCpqSmK3vlQ42x4mJs0xl4I5K/Zv3LrEV7g?=
 =?us-ascii?Q?KbXiNATjKNVLfXuUa0TttWCkLqCNa3osXLVrcr7OS6hkDwV00/18XauNcbiM?=
 =?us-ascii?Q?TXP2pvu/Mmravb3axt6bsuNMvyMfJTOyGjD2Cms4rKhsXAi4V6xqwZ9BMSt7?=
 =?us-ascii?Q?JMznZfTZeRGTBRsSKl+M6pyimQzYdVxUV+r3AdzL3OA3JGwchs9CEqb38k2g?=
 =?us-ascii?Q?wj6Msk9eOogzAEQqiq5yIJpgwxWx+2EwyDg2kCLXlgjH4MUt0RSqltOhGBfj?=
 =?us-ascii?Q?J3ibphFjiSNc1rti4d2kplCR7ZJU35T5zp0M2TlGLWQqQ3HwdNTzVNRwqnDQ?=
 =?us-ascii?Q?mHRaUDSib9N6uLc9hCz3pr08w0KQWGALtuZgT6RRxwuV6JDv9EiWycJdT0Ho?=
 =?us-ascii?Q?UnTkJVk+pVICPbjHYaLBYH/xzAHts82EamDB/I0rE7Z5ODE68TgsltCRqm0K?=
 =?us-ascii?Q?dRml2wfofW34bjq4TC+b6kxjQWE10+LlKX7lvw4T1RpD7iiZ8/79KDt32Dz4?=
 =?us-ascii?Q?pmrA7htO2Kl8mWcCtDikkoCkjJv6/0GJySLguZeAZDrl8BUhc7w2zT/KLUkU?=
 =?us-ascii?Q?5PC9WiejHYroxvS0+uy4qsYzCjYRVXK/NM/Zwe/uw2UdZdEP7MeCxWrWhHrq?=
 =?us-ascii?Q?ub+0/URxt32qf48BuuV2RLbusqbnbmXqhsTMj6UQd07nLZH0ehq41YGD7Fq4?=
 =?us-ascii?Q?PDuai7OuplOdNN3LM07fQW+ypyMvBPEN4CR98mKVq2V8zqRm4OIJkQJ7e32q?=
 =?us-ascii?Q?HE6jnj+0+HojEmjXeUkVSEaihycpVfkKizjn+uZCDvzSpS3iptKb7bi12XQ5?=
 =?us-ascii?Q?9R3K8XDM7gfglQtISc9OwjlG/j2SKU1ch+iB+2lSzqZMXErSDm4mfW+YBZ8j?=
 =?us-ascii?Q?GmXbHzkaBDBGfdoboNKG1DsgCUOeFeDqRv/H6L1njtlLEiNxGAM/njxXYOfc?=
 =?us-ascii?Q?WsjFyWr2e6CRrfRHL+pMI8pidMtAt7r1w6ACany7AlZf7RQSyAsTrHLHMBjZ?=
 =?us-ascii?Q?Qkgyzb/HhjuUQJ4BcYoezWKOZO0WFMJt7Tl307KobEGAV2lB8+eDZDx64DJj?=
 =?us-ascii?Q?B79UHuF70s5DkR7xS5zHHjiluyPERo9EFPcjqVCAQYzImUTTOcuKDEL4qmpJ?=
 =?us-ascii?Q?MA+ZgXTHKIl9587ta4JA8z457jOecnUQmhBCRV9zxJdNDsUWz50PdRk4Cpf7?=
 =?us-ascii?Q?8dC1WEBfns84GXpAEdxmprNVksXOoCBsH7vi6TOPSd6c1I9Vs5haUx/PRJSd?=
 =?us-ascii?Q?3ANSnCaaj4DT0AxWlnNatGVez2uZ0yxA7Wf18xHnndQ08N2KOwrESk54c4K+?=
 =?us-ascii?Q?uKiCNH8aTrLXajgdYSCQXGIiwknhhTPpbWVswl7Ymg/e8rJetjcvOnYS2g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 07:43:12.8164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ddb538-cb39-46f6-c166-08dd8c71a7b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 .../include/asic_reg/vcn/vcn_5_0_0_offset.h   | 234 ++++++++
 .../include/asic_reg/vcn/vcn_5_0_0_sh_mask.h  | 530 ++++++++++++++++++
 2 files changed, 764 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
index 14574112c469..9fc46e484a21 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
@@ -1147,6 +1147,240 @@
 #define regUVD_DPG_LMA_CTL2_BASE_IDX                                                                    1
 
 
+// addressBlock: uvd_mmsch_dec
+// base address: 0x20d00
+#define regMMSCH_UCODE_ADDR                                                                             0x0540
+#define regMMSCH_UCODE_ADDR_BASE_IDX                                                                    1
+#define regMMSCH_UCODE_DATA                                                                             0x0541
+#define regMMSCH_UCODE_DATA_BASE_IDX                                                                    1
+#define regMMSCH_SRAM_ADDR                                                                              0x0542
+#define regMMSCH_SRAM_ADDR_BASE_IDX                                                                     1
+#define regMMSCH_SRAM_DATA                                                                              0x0543
+#define regMMSCH_SRAM_DATA_BASE_IDX                                                                     1
+#define regMMSCH_VF_SRAM_OFFSET                                                                         0x0544
+#define regMMSCH_VF_SRAM_OFFSET_BASE_IDX                                                                1
+#define regMMSCH_DB_SRAM_OFFSET                                                                         0x0545
+#define regMMSCH_DB_SRAM_OFFSET_BASE_IDX                                                                1
+#define regMMSCH_CTX_SRAM_OFFSET                                                                        0x0546
+#define regMMSCH_CTX_SRAM_OFFSET_BASE_IDX                                                               1
+#define regMMSCH_CTL                                                                                    0x0547
+#define regMMSCH_CTL_BASE_IDX                                                                           1
+#define regMMSCH_INTR                                                                                   0x0548
+#define regMMSCH_INTR_BASE_IDX                                                                          1
+#define regMMSCH_INTR_ACK                                                                               0x0549
+#define regMMSCH_INTR_ACK_BASE_IDX                                                                      1
+#define regMMSCH_INTR_STATUS                                                                            0x054a
+#define regMMSCH_INTR_STATUS_BASE_IDX                                                                   1
+#define regMMSCH_VF_VMID                                                                                0x054b
+#define regMMSCH_VF_VMID_BASE_IDX                                                                       1
+#define regMMSCH_VF_CTX_ADDR_LO                                                                         0x054c
+#define regMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                                                1
+#define regMMSCH_VF_CTX_ADDR_HI                                                                         0x054d
+#define regMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                                                1
+#define regMMSCH_VF_CTX_SIZE                                                                            0x054e
+#define regMMSCH_VF_CTX_SIZE_BASE_IDX                                                                   1
+#define regMMSCH_VF_GPCOM_ADDR_LO                                                                       0x054f
+#define regMMSCH_VF_GPCOM_ADDR_LO_BASE_IDX                                                              1
+#define regMMSCH_VF_GPCOM_ADDR_HI                                                                       0x0550
+#define regMMSCH_VF_GPCOM_ADDR_HI_BASE_IDX                                                              1
+#define regMMSCH_VF_GPCOM_SIZE                                                                          0x0551
+#define regMMSCH_VF_GPCOM_SIZE_BASE_IDX                                                                 1
+#define regMMSCH_VF_MAILBOX_HOST                                                                        0x0552
+#define regMMSCH_VF_MAILBOX_HOST_BASE_IDX                                                               1
+#define regMMSCH_VF_MAILBOX_RESP                                                                        0x0553
+#define regMMSCH_VF_MAILBOX_RESP_BASE_IDX                                                               1
+#define regMMSCH_CNTL                                                                                   0x055c
+#define regMMSCH_CNTL_BASE_IDX                                                                          1
+#define regMMSCH_NONCACHE_OFFSET0                                                                       0x055d
+#define regMMSCH_NONCACHE_OFFSET0_BASE_IDX                                                              1
+#define regMMSCH_NONCACHE_SIZE0                                                                         0x055e
+#define regMMSCH_NONCACHE_SIZE0_BASE_IDX                                                                1
+#define regMMSCH_NONCACHE_OFFSET1                                                                       0x055f
+#define regMMSCH_NONCACHE_OFFSET1_BASE_IDX                                                              1
+#define regMMSCH_NONCACHE_SIZE1                                                                         0x0560
+#define regMMSCH_NONCACHE_SIZE1_BASE_IDX                                                                1
+#define regMMSCH_PDEBUG_STATUS                                                                          0x0561
+#define regMMSCH_PDEBUG_STATUS_BASE_IDX                                                                 1
+#define regMMSCH_PDEBUG_DATA_32UPPERBITS                                                                0x0562
+#define regMMSCH_PDEBUG_DATA_32UPPERBITS_BASE_IDX                                                       1
+#define regMMSCH_PDEBUG_DATA_32LOWERBITS                                                                0x0563
+#define regMMSCH_PDEBUG_DATA_32LOWERBITS_BASE_IDX                                                       1
+#define regMMSCH_PDEBUG_EPC                                                                             0x0564
+#define regMMSCH_PDEBUG_EPC_BASE_IDX                                                                    1
+#define regMMSCH_PDEBUG_EXCCAUSE                                                                        0x0565
+#define regMMSCH_PDEBUG_EXCCAUSE_BASE_IDX                                                               1
+#define regMMSCH_PROC_STATE1                                                                            0x0566
+#define regMMSCH_PROC_STATE1_BASE_IDX                                                                   1
+#define regMMSCH_LAST_MC_ADDR                                                                           0x0567
+#define regMMSCH_LAST_MC_ADDR_BASE_IDX                                                                  1
+#define regMMSCH_LAST_MEM_ACCESS_HI                                                                     0x0568
+#define regMMSCH_LAST_MEM_ACCESS_HI_BASE_IDX                                                            1
+#define regMMSCH_LAST_MEM_ACCESS_LO                                                                     0x0569
+#define regMMSCH_LAST_MEM_ACCESS_LO_BASE_IDX                                                            1
+#define regMMSCH_IOV_ACTIVE_FCN_ID                                                                      0x056a
+#define regMMSCH_IOV_ACTIVE_FCN_ID_BASE_IDX                                                             1
+#define regMMSCH_VF_MAILBOX_0                                                                           0x056b
+#define regMMSCH_VF_MAILBOX_0_BASE_IDX                                                                  1
+#define regMMSCH_VF_MAILBOX_0_RESP                                                                      0x056c
+#define regMMSCH_VF_MAILBOX_0_RESP_BASE_IDX                                                             1
+#define regMMSCH_VF_MAILBOX0_DATA                                                                       0x056d
+#define regMMSCH_VF_MAILBOX0_DATA_BASE_IDX                                                              1
+#define regMMSCH_VF_MAILBOX_1                                                                           0x056e
+#define regMMSCH_VF_MAILBOX_1_BASE_IDX                                                                  1
+#define regMMSCH_VF_MAILBOX_1_RESP                                                                      0x056f
+#define regMMSCH_VF_MAILBOX_1_RESP_BASE_IDX                                                             1
+#define regMMSCH_VF_MAILBOX1_DATA                                                                       0x0570
+#define regMMSCH_VF_MAILBOX1_DATA_BASE_IDX                                                              1
+#define regMMSCH_GPUIOV_SCH_BLOCK_0                                                                     0x0571
+#define regMMSCH_GPUIOV_SCH_BLOCK_0_BASE_IDX                                                            1
+#define regMMSCH_GPUIOV_CMD_CONTROL_0                                                                   0x0572
+#define regMMSCH_GPUIOV_CMD_CONTROL_0_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_CMD_STATUS_0                                                                    0x0573
+#define regMMSCH_GPUIOV_CMD_STATUS_0_BASE_IDX                                                           1
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_0                                                                0x0574
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_0_BASE_IDX                                                       1
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_0                                                                   0x0575
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_0_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_0                                                                 0x0576
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_0_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_DW6_0                                                                           0x0577
+#define regMMSCH_GPUIOV_DW6_0_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW7_0                                                                           0x0578
+#define regMMSCH_GPUIOV_DW7_0_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW8_0                                                                           0x0579
+#define regMMSCH_GPUIOV_DW8_0_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_SCH_BLOCK_1                                                                     0x057a
+#define regMMSCH_GPUIOV_SCH_BLOCK_1_BASE_IDX                                                            1
+#define regMMSCH_GPUIOV_CMD_CONTROL_1                                                                   0x057b
+#define regMMSCH_GPUIOV_CMD_CONTROL_1_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_CMD_STATUS_1                                                                    0x057c
+#define regMMSCH_GPUIOV_CMD_STATUS_1_BASE_IDX                                                           1
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_1                                                                0x057d
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_1_BASE_IDX                                                       1
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_1                                                                   0x057e
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_1_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_1                                                                 0x057f
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_1_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_DW6_1                                                                           0x0580
+#define regMMSCH_GPUIOV_DW6_1_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW7_1                                                                           0x0581
+#define regMMSCH_GPUIOV_DW7_1_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW8_1                                                                           0x0582
+#define regMMSCH_GPUIOV_DW8_1_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_SCH_BLOCK_2                                                                     0x0583
+#define regMMSCH_GPUIOV_SCH_BLOCK_2_BASE_IDX                                                            1
+#define regMMSCH_GPUIOV_CMD_CONTROL_2                                                                   0x0584
+#define regMMSCH_GPUIOV_CMD_CONTROL_2_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_CMD_STATUS_2                                                                    0x0585
+#define regMMSCH_GPUIOV_CMD_STATUS_2_BASE_IDX                                                           1
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_2                                                                0x0586
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_2_BASE_IDX                                                       1
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_2                                                                   0x0587
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_2_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_2                                                                 0x0588
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_2_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_DW6_2                                                                           0x0589
+#define regMMSCH_GPUIOV_DW6_2_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW7_2                                                                           0x058a
+#define regMMSCH_GPUIOV_DW7_2_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW8_2                                                                           0x058b
+#define regMMSCH_GPUIOV_DW8_2_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_SCH_BLOCK_3                                                                     0x058c
+#define regMMSCH_GPUIOV_SCH_BLOCK_3_BASE_IDX                                                            1
+#define regMMSCH_GPUIOV_CMD_CONTROL_3                                                                   0x058d
+#define regMMSCH_GPUIOV_CMD_CONTROL_3_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_CMD_STATUS_3                                                                    0x058e
+#define regMMSCH_GPUIOV_CMD_STATUS_3_BASE_IDX                                                           1
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_3                                                                0x058f
+#define regMMSCH_GPUIOV_VM_BUSY_STATUS_3_BASE_IDX                                                       1
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_3                                                                   0x0590
+#define regMMSCH_GPUIOV_ACTIVE_FCNS_3_BASE_IDX                                                          1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_3                                                                 0x0591
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_3_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_DW6_3                                                                           0x0592
+#define regMMSCH_GPUIOV_DW6_3_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW7_3                                                                           0x0593
+#define regMMSCH_GPUIOV_DW7_3_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_DW8_3                                                                           0x0594
+#define regMMSCH_GPUIOV_DW8_3_BASE_IDX                                                                  1
+#define regMMSCH_GPUIOV_CNTXT                                                                           0x0595
+#define regMMSCH_GPUIOV_CNTXT_BASE_IDX                                                                  1
+#define regMMSCH_SCRATCH_0                                                                              0x0596
+#define regMMSCH_SCRATCH_0_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_1                                                                              0x0597
+#define regMMSCH_SCRATCH_1_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_2                                                                              0x0598
+#define regMMSCH_SCRATCH_2_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_3                                                                              0x0599
+#define regMMSCH_SCRATCH_3_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_4                                                                              0x059a
+#define regMMSCH_SCRATCH_4_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_5                                                                              0x059b
+#define regMMSCH_SCRATCH_5_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_6                                                                              0x059c
+#define regMMSCH_SCRATCH_6_BASE_IDX                                                                     1
+#define regMMSCH_SCRATCH_7                                                                              0x059d
+#define regMMSCH_SCRATCH_7_BASE_IDX                                                                     1
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_0                                                                  0x059e
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_0_BASE_IDX                                                         1
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_0                                                                 0x059f
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_0_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0                                                              0x05a0
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0_BASE_IDX                                                     1
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_1                                                                  0x05a1
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_1_BASE_IDX                                                         1
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_1                                                                 0x05a2
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_1_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1                                                              0x05a3
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1_BASE_IDX                                                     1
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_2                                                                  0x05a4
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_2_BASE_IDX                                                         1
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_2                                                                 0x05a5
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_2_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2                                                              0x05a6
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2_BASE_IDX                                                     1
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_3                                                                  0x05a7
+#define regMMSCH_GPUIOV_SCH_BLOCK_IP_3_BASE_IDX                                                         1
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_3                                                                 0x05a8
+#define regMMSCH_GPUIOV_CMD_STATUS_IP_3_BASE_IDX                                                        1
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3                                                              0x05a9
+#define regMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3_BASE_IDX                                                     1
+#define regMMSCH_GPUIOV_CNTXT_IP                                                                        0x05aa
+#define regMMSCH_GPUIOV_CNTXT_IP_BASE_IDX                                                               1
+#define regMMSCH_VFID_FIFO_HEAD_0                                                                       0x05ab
+#define regMMSCH_VFID_FIFO_HEAD_0_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_TAIL_0                                                                       0x05ac
+#define regMMSCH_VFID_FIFO_TAIL_0_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_HEAD_1                                                                       0x05ad
+#define regMMSCH_VFID_FIFO_HEAD_1_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_TAIL_1                                                                       0x05ae
+#define regMMSCH_VFID_FIFO_TAIL_1_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_HEAD_2                                                                       0x05af
+#define regMMSCH_VFID_FIFO_HEAD_2_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_TAIL_2                                                                       0x05b0
+#define regMMSCH_VFID_FIFO_TAIL_2_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_HEAD_3                                                                       0x05b1
+#define regMMSCH_VFID_FIFO_HEAD_3_BASE_IDX                                                              1
+#define regMMSCH_VFID_FIFO_TAIL_3                                                                       0x05b2
+#define regMMSCH_VFID_FIFO_TAIL_3_BASE_IDX                                                              1
+#define regMMSCH_NACK_STATUS                                                                            0x05b3
+#define regMMSCH_NACK_STATUS_BASE_IDX                                                                   1
+#define regMMSCH_VM_BUSY_STATUS_0                                                                       0x05b4
+#define regMMSCH_VM_BUSY_STATUS_0_BASE_IDX                                                              1
+#define regMMSCH_VM_BUSY_STATUS_1                                                                       0x05b5
+#define regMMSCH_VM_BUSY_STATUS_1_BASE_IDX                                                              1
+#define regMMSCH_VM_BUSY_STATUS_2                                                                       0x05b6
+#define regMMSCH_VM_BUSY_STATUS_2_BASE_IDX                                                              1
+#define regMMSCH_VM_BUSY_STATUS_3                                                                       0x05b7
+#define regMMSCH_VM_BUSY_STATUS_3_BASE_IDX                                                              1
+#define regUVD_INTERNAL_REG_VIOLATION_5                                                                 0x05b8
+#define regUVD_INTERNAL_REG_VIOLATION_5_BASE_IDX                                                        1
+#define regMMSCH_CGC_CTRL                                                                               0x05b9
+#define regMMSCH_CGC_CTRL_BASE_IDX                                                                      1
+#define regMMSCH_DB_ADDR_BASE                                                                           0x05ba
+#define regMMSCH_DB_ADDR_BASE_BASE_IDX                                                                  1
+
+
 // addressBlock: uvd_vcn_umsch_dec
 // base address: 0x21500
 #define regVCN_UMSCH_MES_CNTL                                                                           0x0740
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
index 5c119a6b87fb..d713fcfbb170 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
@@ -5929,6 +5929,536 @@
 #define UVD_DPG_LMA_CTL2__JPEG_WRITE_PTR_MASK                                                                 0x0000FE00L
 
 
+// addressBlock: uvd_mmsch_dec
+//MMSCH_UCODE_ADDR
+#define MMSCH_UCODE_ADDR__UCODE_ADDR__SHIFT                                                                   0x2
+#define MMSCH_UCODE_ADDR__UCODE_LOCK__SHIFT                                                                   0x1f
+#define MMSCH_UCODE_ADDR__UCODE_ADDR_MASK                                                                     0x00003FFCL
+#define MMSCH_UCODE_ADDR__UCODE_LOCK_MASK                                                                     0x80000000L
+//MMSCH_UCODE_DATA
+#define MMSCH_UCODE_DATA__UCODE_DATA__SHIFT                                                                   0x0
+#define MMSCH_UCODE_DATA__UCODE_DATA_MASK                                                                     0xFFFFFFFFL
+//MMSCH_SRAM_ADDR
+#define MMSCH_SRAM_ADDR__SRAM_ADDR__SHIFT                                                                     0x2
+#define MMSCH_SRAM_ADDR__SRAM_LOCK__SHIFT                                                                     0x1f
+#define MMSCH_SRAM_ADDR__SRAM_ADDR_MASK                                                                       0x00001FFCL
+#define MMSCH_SRAM_ADDR__SRAM_LOCK_MASK                                                                       0x80000000L
+//MMSCH_SRAM_DATA
+#define MMSCH_SRAM_DATA__SRAM_DATA__SHIFT                                                                     0x0
+#define MMSCH_SRAM_DATA__SRAM_DATA_MASK                                                                       0xFFFFFFFFL
+//MMSCH_VF_SRAM_OFFSET
+#define MMSCH_VF_SRAM_OFFSET__VF_SRAM_OFFSET__SHIFT                                                           0x2
+#define MMSCH_VF_SRAM_OFFSET__VF_SRAM_NUM_DW_PER_VF__SHIFT                                                    0x10
+#define MMSCH_VF_SRAM_OFFSET__VF_SRAM_OFFSET_MASK                                                             0x00001FFCL
+#define MMSCH_VF_SRAM_OFFSET__VF_SRAM_NUM_DW_PER_VF_MASK                                                      0x00FF0000L
+//MMSCH_DB_SRAM_OFFSET
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_OFFSET__SHIFT                                                           0x2
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_NUM_ENG__SHIFT                                                          0x10
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_NUM_RING_PER_ENG__SHIFT                                                 0x18
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_OFFSET_MASK                                                             0x00001FFCL
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_NUM_ENG_MASK                                                            0x00FF0000L
+#define MMSCH_DB_SRAM_OFFSET__DB_SRAM_NUM_RING_PER_ENG_MASK                                                   0xFF000000L
+//MMSCH_CTX_SRAM_OFFSET
+#define MMSCH_CTX_SRAM_OFFSET__CTX_SRAM_OFFSET__SHIFT                                                         0x2
+#define MMSCH_CTX_SRAM_OFFSET__CTX_SRAM_SIZE__SHIFT                                                           0x10
+#define MMSCH_CTX_SRAM_OFFSET__CTX_SRAM_OFFSET_MASK                                                           0x00001FFCL
+#define MMSCH_CTX_SRAM_OFFSET__CTX_SRAM_SIZE_MASK                                                             0xFFFF0000L
+//MMSCH_CTL
+#define MMSCH_CTL__P_RUNSTALL__SHIFT                                                                          0x0
+#define MMSCH_CTL__P_RESET__SHIFT                                                                             0x1
+#define MMSCH_CTL__VFID_FIFO_EN__SHIFT                                                                        0x4
+#define MMSCH_CTL__P_LOCK__SHIFT                                                                              0x1f
+#define MMSCH_CTL__P_RUNSTALL_MASK                                                                            0x00000001L
+#define MMSCH_CTL__P_RESET_MASK                                                                               0x00000002L
+#define MMSCH_CTL__VFID_FIFO_EN_MASK                                                                          0x00000010L
+#define MMSCH_CTL__P_LOCK_MASK                                                                                0x80000000L
+//MMSCH_INTR
+#define MMSCH_INTR__INTR__SHIFT                                                                               0x0
+#define MMSCH_INTR__INTR_MASK                                                                                 0x00001FFFL
+//MMSCH_INTR_ACK
+#define MMSCH_INTR_ACK__INTR__SHIFT                                                                           0x0
+#define MMSCH_INTR_ACK__INTR_MASK                                                                             0x00001FFFL
+//MMSCH_INTR_STATUS
+#define MMSCH_INTR_STATUS__INTR__SHIFT                                                                        0x0
+#define MMSCH_INTR_STATUS__INTR_MASK                                                                          0x00001FFFL
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
+//MMSCH_VF_GPCOM_ADDR_LO
+#define MMSCH_VF_GPCOM_ADDR_LO__VF_GPCOM_ADDR_LO__SHIFT                                                       0x6
+#define MMSCH_VF_GPCOM_ADDR_LO__VF_GPCOM_ADDR_LO_MASK                                                         0xFFFFFFC0L
+//MMSCH_VF_GPCOM_ADDR_HI
+#define MMSCH_VF_GPCOM_ADDR_HI__VF_GPCOM_ADDR_HI__SHIFT                                                       0x0
+#define MMSCH_VF_GPCOM_ADDR_HI__VF_GPCOM_ADDR_HI_MASK                                                         0xFFFFFFFFL
+//MMSCH_VF_GPCOM_SIZE
+#define MMSCH_VF_GPCOM_SIZE__VF_GPCOM_SIZE__SHIFT                                                             0x0
+#define MMSCH_VF_GPCOM_SIZE__VF_GPCOM_SIZE_MASK                                                               0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_HOST
+#define MMSCH_VF_MAILBOX_HOST__DATA__SHIFT                                                                    0x0
+#define MMSCH_VF_MAILBOX_HOST__DATA_MASK                                                                      0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_RESP
+#define MMSCH_VF_MAILBOX_RESP__RESP__SHIFT                                                                    0x0
+#define MMSCH_VF_MAILBOX_RESP__RESP_MASK                                                                      0xFFFFFFFFL
+//MMSCH_CNTL
+#define MMSCH_CNTL__CLK_EN__SHIFT                                                                             0x0
+#define MMSCH_CNTL__ED_ENABLE__SHIFT                                                                          0x1
+#define MMSCH_CNTL__AXI_MAX_BRST_SIZE_IS_4__SHIFT                                                             0x2
+#define MMSCH_CNTL__AXI_40BIT_PIF_ADDR_FIX_EN__SHIFT                                                          0x3
+#define MMSCH_CNTL__PDEBUG_ENABLE__SHIFT                                                                      0x4
+#define MMSCH_CNTL__MMSCH_IRQ_ERR__SHIFT                                                                      0x5
+#define MMSCH_CNTL__MMSCH_NACK_INTR_EN__SHIFT                                                                 0x9
+#define MMSCH_CNTL__MMSCH_DB_BUSY_INTR_EN__SHIFT                                                              0xa
+#define MMSCH_CNTL__PRB_TIMEOUT_VAL__SHIFT                                                                    0x14
+#define MMSCH_CNTL__TIMEOUT_DIS__SHIFT                                                                        0x1c
+#define MMSCH_CNTL__MMSCH_IDLE__SHIFT                                                                         0x1d
+#define MMSCH_CNTL__CLK_EN_MASK                                                                               0x00000001L
+#define MMSCH_CNTL__ED_ENABLE_MASK                                                                            0x00000002L
+#define MMSCH_CNTL__AXI_MAX_BRST_SIZE_IS_4_MASK                                                               0x00000004L
+#define MMSCH_CNTL__AXI_40BIT_PIF_ADDR_FIX_EN_MASK                                                            0x00000008L
+#define MMSCH_CNTL__PDEBUG_ENABLE_MASK                                                                        0x00000010L
+#define MMSCH_CNTL__MMSCH_IRQ_ERR_MASK                                                                        0x000001E0L
+#define MMSCH_CNTL__MMSCH_NACK_INTR_EN_MASK                                                                   0x00000200L
+#define MMSCH_CNTL__MMSCH_DB_BUSY_INTR_EN_MASK                                                                0x00000400L
+#define MMSCH_CNTL__PRB_TIMEOUT_VAL_MASK                                                                      0x0FF00000L
+#define MMSCH_CNTL__TIMEOUT_DIS_MASK                                                                          0x10000000L
+#define MMSCH_CNTL__MMSCH_IDLE_MASK                                                                           0x20000000L
+//MMSCH_NONCACHE_OFFSET0
+#define MMSCH_NONCACHE_OFFSET0__OFFSET__SHIFT                                                                 0x0
+#define MMSCH_NONCACHE_OFFSET0__OFFSET_MASK                                                                   0x0FFFFFFFL
+//MMSCH_NONCACHE_SIZE0
+#define MMSCH_NONCACHE_SIZE0__SIZE__SHIFT                                                                     0x0
+#define MMSCH_NONCACHE_SIZE0__SIZE_MASK                                                                       0x00FFFFFFL
+//MMSCH_NONCACHE_OFFSET1
+#define MMSCH_NONCACHE_OFFSET1__OFFSET__SHIFT                                                                 0x0
+#define MMSCH_NONCACHE_OFFSET1__OFFSET_MASK                                                                   0x0FFFFFFFL
+//MMSCH_NONCACHE_SIZE1
+#define MMSCH_NONCACHE_SIZE1__SIZE__SHIFT                                                                     0x0
+#define MMSCH_NONCACHE_SIZE1__SIZE_MASK                                                                       0x00FFFFFFL
+//MMSCH_PDEBUG_STATUS
+#define MMSCH_PDEBUG_STATUS__PSTATUS__SHIFT                                                                   0x0
+#define MMSCH_PDEBUG_STATUS__PWAITMODE__SHIFT                                                                 0x10
+#define MMSCH_PDEBUG_STATUS__DATA_STALL__SHIFT                                                                0x1d
+#define MMSCH_PDEBUG_STATUS__INST_STALL__SHIFT                                                                0x1e
+#define MMSCH_PDEBUG_STATUS__REG_DEPD_CONFL__SHIFT                                                            0x1f
+#define MMSCH_PDEBUG_STATUS__PSTATUS_MASK                                                                     0x0000FFFFL
+#define MMSCH_PDEBUG_STATUS__PWAITMODE_MASK                                                                   0x00010000L
+#define MMSCH_PDEBUG_STATUS__DATA_STALL_MASK                                                                  0x20000000L
+#define MMSCH_PDEBUG_STATUS__INST_STALL_MASK                                                                  0x40000000L
+#define MMSCH_PDEBUG_STATUS__REG_DEPD_CONFL_MASK                                                              0x80000000L
+//MMSCH_PDEBUG_DATA_32UPPERBITS
+#define MMSCH_PDEBUG_DATA_32UPPERBITS__PDEBUG_DATA_HI__SHIFT                                                  0x0
+#define MMSCH_PDEBUG_DATA_32UPPERBITS__PDEBUG_DATA_HI_MASK                                                    0xFFFFFFFFL
+//MMSCH_PDEBUG_DATA_32LOWERBITS
+#define MMSCH_PDEBUG_DATA_32LOWERBITS__PDEBUG_DATA_LO__SHIFT                                                  0x0
+#define MMSCH_PDEBUG_DATA_32LOWERBITS__PDEBUG_DATA_LO_MASK                                                    0xFFFFFFFFL
+//MMSCH_PDEBUG_EPC
+#define MMSCH_PDEBUG_EPC__PDEBUG_EPC__SHIFT                                                                   0x0
+#define MMSCH_PDEBUG_EPC__PDEBUG_EPC_MASK                                                                     0xFFFFFFFFL
+//MMSCH_PDEBUG_EXCCAUSE
+#define MMSCH_PDEBUG_EXCCAUSE__PDEBUG_EXCCAUSE__SHIFT                                                         0x0
+#define MMSCH_PDEBUG_EXCCAUSE__PDEBUG_EXCCAUSE_MASK                                                           0xFFFFFFFFL
+//MMSCH_PROC_STATE1
+#define MMSCH_PROC_STATE1__PC__SHIFT                                                                          0x0
+#define MMSCH_PROC_STATE1__PC_MASK                                                                            0xFFFFFFFFL
+//MMSCH_LAST_MC_ADDR
+#define MMSCH_LAST_MC_ADDR__MC_ADDR__SHIFT                                                                    0x0
+#define MMSCH_LAST_MC_ADDR__RW__SHIFT                                                                         0x1f
+#define MMSCH_LAST_MC_ADDR__MC_ADDR_MASK                                                                      0x0FFFFFFFL
+#define MMSCH_LAST_MC_ADDR__RW_MASK                                                                           0x80000000L
+//MMSCH_LAST_MEM_ACCESS_HI
+#define MMSCH_LAST_MEM_ACCESS_HI__PROC_CMD__SHIFT                                                             0x0
+#define MMSCH_LAST_MEM_ACCESS_HI__FIFO_RPTR__SHIFT                                                            0x8
+#define MMSCH_LAST_MEM_ACCESS_HI__FIFO_WPTR__SHIFT                                                            0xc
+#define MMSCH_LAST_MEM_ACCESS_HI__PROC_CMD_MASK                                                               0x00000007L
+#define MMSCH_LAST_MEM_ACCESS_HI__FIFO_RPTR_MASK                                                              0x00000700L
+#define MMSCH_LAST_MEM_ACCESS_HI__FIFO_WPTR_MASK                                                              0x00007000L
+//MMSCH_LAST_MEM_ACCESS_LO
+#define MMSCH_LAST_MEM_ACCESS_LO__PROC_ADDR__SHIFT                                                            0x0
+#define MMSCH_LAST_MEM_ACCESS_LO__PROC_ADDR_MASK                                                              0xFFFFFFFFL
+//MMSCH_IOV_ACTIVE_FCN_ID
+#define MMSCH_IOV_ACTIVE_FCN_ID__ACTIVE_VF_ID__SHIFT                                                          0x0
+#define MMSCH_IOV_ACTIVE_FCN_ID__ACTIVE_PF_VF__SHIFT                                                          0x1f
+#define MMSCH_IOV_ACTIVE_FCN_ID__ACTIVE_VF_ID_MASK                                                            0x0000001FL
+#define MMSCH_IOV_ACTIVE_FCN_ID__ACTIVE_PF_VF_MASK                                                            0x80000000L
+//MMSCH_VF_MAILBOX_0
+#define MMSCH_VF_MAILBOX_0__DATA__SHIFT                                                                       0x0
+#define MMSCH_VF_MAILBOX_0__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_0_RESP
+#define MMSCH_VF_MAILBOX_0_RESP__RESP__SHIFT                                                                  0x0
+#define MMSCH_VF_MAILBOX_0_RESP__RESP_MASK                                                                    0xFFFFFFFFL
+//MMSCH_VF_MAILBOX0_DATA
+#define MMSCH_VF_MAILBOX0_DATA__DATA__SHIFT                                                                   0x0
+#define MMSCH_VF_MAILBOX0_DATA__DATA_MASK                                                                     0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_1
+#define MMSCH_VF_MAILBOX_1__DATA__SHIFT                                                                       0x0
+#define MMSCH_VF_MAILBOX_1__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_VF_MAILBOX_1_RESP
+#define MMSCH_VF_MAILBOX_1_RESP__RESP__SHIFT                                                                  0x0
+#define MMSCH_VF_MAILBOX_1_RESP__RESP_MASK                                                                    0xFFFFFFFFL
+//MMSCH_VF_MAILBOX1_DATA
+#define MMSCH_VF_MAILBOX1_DATA__DATA__SHIFT                                                                   0x0
+#define MMSCH_VF_MAILBOX1_DATA__DATA_MASK                                                                     0xFFFFFFFFL
+//MMSCH_GPUIOV_SCH_BLOCK_0
+#define MMSCH_GPUIOV_SCH_BLOCK_0__ID__SHIFT                                                                   0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_0__VERSION__SHIFT                                                              0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_0__SIZE__SHIFT                                                                 0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_0__ID_MASK                                                                     0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_0__VERSION_MASK                                                                0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_0__SIZE_MASK                                                                   0x0000FF00L
+//MMSCH_GPUIOV_CMD_CONTROL_0
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_TYPE__SHIFT                                                           0x0
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_EXECUTE__SHIFT                                                        0x4
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_EXECUTE_INTR_EN__SHIFT                                                0x5
+#define MMSCH_GPUIOV_CMD_CONTROL_0__VM_BUSY_INTR_EN__SHIFT                                                    0x6
+#define MMSCH_GPUIOV_CMD_CONTROL_0__FUNCTINO_ID__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_CONTROL_0__NEXT_FUNCTINO_ID__SHIFT                                                   0x10
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_TYPE_MASK                                                             0x0000000FL
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_EXECUTE_MASK                                                          0x00000010L
+#define MMSCH_GPUIOV_CMD_CONTROL_0__CMD_EXECUTE_INTR_EN_MASK                                                  0x00000020L
+#define MMSCH_GPUIOV_CMD_CONTROL_0__VM_BUSY_INTR_EN_MASK                                                      0x00000040L
+#define MMSCH_GPUIOV_CMD_CONTROL_0__FUNCTINO_ID_MASK                                                          0x0000FF00L
+#define MMSCH_GPUIOV_CMD_CONTROL_0__NEXT_FUNCTINO_ID_MASK                                                     0x00FF0000L
+//MMSCH_GPUIOV_CMD_STATUS_0
+#define MMSCH_GPUIOV_CMD_STATUS_0__CMD_STATUS__SHIFT                                                          0x0
+#define MMSCH_GPUIOV_CMD_STATUS_0__DEBUG_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_STATUS_0__CMD_STATUS_MASK                                                            0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_0__DEBUG_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_VM_BUSY_STATUS_0
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_0__BUSY__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_0__BUSY_MASK                                                              0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCNS_0
+#define MMSCH_GPUIOV_ACTIVE_FCNS_0__ACTIVE_FCNS__SHIFT                                                        0x0
+#define MMSCH_GPUIOV_ACTIVE_FCNS_0__ACTIVE_FCNS_MASK                                                          0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_0__ID__SHIFT                                                               0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_0__ID_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_0__ID_MASK                                                                 0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_0__ID_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_DW6_0
+#define MMSCH_GPUIOV_DW6_0__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW6_0__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW7_0
+#define MMSCH_GPUIOV_DW7_0__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW7_0__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW8_0
+#define MMSCH_GPUIOV_DW8_0__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW8_0__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_SCH_BLOCK_1
+#define MMSCH_GPUIOV_SCH_BLOCK_1__ID__SHIFT                                                                   0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_1__VERSION__SHIFT                                                              0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_1__SIZE__SHIFT                                                                 0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_1__ID_MASK                                                                     0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_1__VERSION_MASK                                                                0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_1__SIZE_MASK                                                                   0x0000FF00L
+//MMSCH_GPUIOV_CMD_CONTROL_1
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_TYPE__SHIFT                                                           0x0
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_EXECUTE__SHIFT                                                        0x4
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_EXECUTE_INTR_EN__SHIFT                                                0x5
+#define MMSCH_GPUIOV_CMD_CONTROL_1__VM_BUSY_INTR_EN__SHIFT                                                    0x6
+#define MMSCH_GPUIOV_CMD_CONTROL_1__FUNCTINO_ID__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_CONTROL_1__NEXT_FUNCTINO_ID__SHIFT                                                   0x10
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_TYPE_MASK                                                             0x0000000FL
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_EXECUTE_MASK                                                          0x00000010L
+#define MMSCH_GPUIOV_CMD_CONTROL_1__CMD_EXECUTE_INTR_EN_MASK                                                  0x00000020L
+#define MMSCH_GPUIOV_CMD_CONTROL_1__VM_BUSY_INTR_EN_MASK                                                      0x00000040L
+#define MMSCH_GPUIOV_CMD_CONTROL_1__FUNCTINO_ID_MASK                                                          0x0000FF00L
+#define MMSCH_GPUIOV_CMD_CONTROL_1__NEXT_FUNCTINO_ID_MASK                                                     0x00FF0000L
+//MMSCH_GPUIOV_CMD_STATUS_1
+#define MMSCH_GPUIOV_CMD_STATUS_1__CMD_STATUS__SHIFT                                                          0x0
+#define MMSCH_GPUIOV_CMD_STATUS_1__DEBUG_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_STATUS_1__CMD_STATUS_MASK                                                            0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_1__DEBUG_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_VM_BUSY_STATUS_1
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_1__BUSY__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_1__BUSY_MASK                                                              0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCNS_1
+#define MMSCH_GPUIOV_ACTIVE_FCNS_1__ACTIVE_FCNS__SHIFT                                                        0x0
+#define MMSCH_GPUIOV_ACTIVE_FCNS_1__ACTIVE_FCNS_MASK                                                          0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_1
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_1__ID__SHIFT                                                               0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_1__ID_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_1__ID_MASK                                                                 0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_1__ID_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_DW6_1
+#define MMSCH_GPUIOV_DW6_1__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW6_1__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW7_1
+#define MMSCH_GPUIOV_DW7_1__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW7_1__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW8_1
+#define MMSCH_GPUIOV_DW8_1__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW8_1__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_SCH_BLOCK_2
+#define MMSCH_GPUIOV_SCH_BLOCK_2__ID__SHIFT                                                                   0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_2__VERSION__SHIFT                                                              0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_2__SIZE__SHIFT                                                                 0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_2__ID_MASK                                                                     0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_2__VERSION_MASK                                                                0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_2__SIZE_MASK                                                                   0x0000FF00L
+//MMSCH_GPUIOV_CMD_CONTROL_2
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_TYPE__SHIFT                                                           0x0
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_EXECUTE__SHIFT                                                        0x4
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_EXECUTE_INTR_EN__SHIFT                                                0x5
+#define MMSCH_GPUIOV_CMD_CONTROL_2__VM_BUSY_INTR_EN__SHIFT                                                    0x6
+#define MMSCH_GPUIOV_CMD_CONTROL_2__FUNCTINO_ID__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_CONTROL_2__NEXT_FUNCTINO_ID__SHIFT                                                   0x10
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_TYPE_MASK                                                             0x0000000FL
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_EXECUTE_MASK                                                          0x00000010L
+#define MMSCH_GPUIOV_CMD_CONTROL_2__CMD_EXECUTE_INTR_EN_MASK                                                  0x00000020L
+#define MMSCH_GPUIOV_CMD_CONTROL_2__VM_BUSY_INTR_EN_MASK                                                      0x00000040L
+#define MMSCH_GPUIOV_CMD_CONTROL_2__FUNCTINO_ID_MASK                                                          0x0000FF00L
+#define MMSCH_GPUIOV_CMD_CONTROL_2__NEXT_FUNCTINO_ID_MASK                                                     0x00FF0000L
+//MMSCH_GPUIOV_CMD_STATUS_2
+#define MMSCH_GPUIOV_CMD_STATUS_2__CMD_STATUS__SHIFT                                                          0x0
+#define MMSCH_GPUIOV_CMD_STATUS_2__DEBUG_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_STATUS_2__CMD_STATUS_MASK                                                            0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_2__DEBUG_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_VM_BUSY_STATUS_2
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_2__BUSY__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_2__BUSY_MASK                                                              0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCNS_2
+#define MMSCH_GPUIOV_ACTIVE_FCNS_2__ACTIVE_FCNS__SHIFT                                                        0x0
+#define MMSCH_GPUIOV_ACTIVE_FCNS_2__ACTIVE_FCNS_MASK                                                          0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_2
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_2__ID__SHIFT                                                               0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_2__ID_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_2__ID_MASK                                                                 0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_2__ID_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_DW6_2
+#define MMSCH_GPUIOV_DW6_2__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW6_2__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW7_2
+#define MMSCH_GPUIOV_DW7_2__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW7_2__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW8_2
+#define MMSCH_GPUIOV_DW8_2__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW8_2__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_SCH_BLOCK_3
+#define MMSCH_GPUIOV_SCH_BLOCK_3__ID__SHIFT                                                                   0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_3__VERSION__SHIFT                                                              0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_3__SIZE__SHIFT                                                                 0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_3__ID_MASK                                                                     0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_3__VERSION_MASK                                                                0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_3__SIZE_MASK                                                                   0x0000FF00L
+//MMSCH_GPUIOV_CMD_CONTROL_3
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_TYPE__SHIFT                                                           0x0
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_EXECUTE__SHIFT                                                        0x4
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_EXECUTE_INTR_EN__SHIFT                                                0x5
+#define MMSCH_GPUIOV_CMD_CONTROL_3__VM_BUSY_INTR_EN__SHIFT                                                    0x6
+#define MMSCH_GPUIOV_CMD_CONTROL_3__FUNCTINO_ID__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_CONTROL_3__NEXT_FUNCTINO_ID__SHIFT                                                   0x10
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_TYPE_MASK                                                             0x0000000FL
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_EXECUTE_MASK                                                          0x00000010L
+#define MMSCH_GPUIOV_CMD_CONTROL_3__CMD_EXECUTE_INTR_EN_MASK                                                  0x00000020L
+#define MMSCH_GPUIOV_CMD_CONTROL_3__VM_BUSY_INTR_EN_MASK                                                      0x00000040L
+#define MMSCH_GPUIOV_CMD_CONTROL_3__FUNCTINO_ID_MASK                                                          0x0000FF00L
+#define MMSCH_GPUIOV_CMD_CONTROL_3__NEXT_FUNCTINO_ID_MASK                                                     0x00FF0000L
+//MMSCH_GPUIOV_CMD_STATUS_3
+#define MMSCH_GPUIOV_CMD_STATUS_3__CMD_STATUS__SHIFT                                                          0x0
+#define MMSCH_GPUIOV_CMD_STATUS_3__DEBUG_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_CMD_STATUS_3__CMD_STATUS_MASK                                                            0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_3__DEBUG_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_VM_BUSY_STATUS_3
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_3__BUSY__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_VM_BUSY_STATUS_3__BUSY_MASK                                                              0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCNS_3
+#define MMSCH_GPUIOV_ACTIVE_FCNS_3__ACTIVE_FCNS__SHIFT                                                        0x0
+#define MMSCH_GPUIOV_ACTIVE_FCNS_3__ACTIVE_FCNS_MASK                                                          0xFFFFFFFFL
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_3
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_3__ID__SHIFT                                                               0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_3__ID_STATUS__SHIFT                                                        0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_3__ID_MASK                                                                 0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_3__ID_STATUS_MASK                                                          0x0000FF00L
+//MMSCH_GPUIOV_DW6_3
+#define MMSCH_GPUIOV_DW6_3__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW6_3__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW7_3
+#define MMSCH_GPUIOV_DW7_3__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW7_3__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_DW8_3
+#define MMSCH_GPUIOV_DW8_3__DATA__SHIFT                                                                       0x0
+#define MMSCH_GPUIOV_DW8_3__DATA_MASK                                                                         0xFFFFFFFFL
+//MMSCH_GPUIOV_CNTXT
+#define MMSCH_GPUIOV_CNTXT__CNTXT_SIZE__SHIFT                                                                 0x0
+#define MMSCH_GPUIOV_CNTXT__CNTXT_LOCATION__SHIFT                                                             0x7
+#define MMSCH_GPUIOV_CNTXT__CNTXT_OFFSET__SHIFT                                                               0xa
+#define MMSCH_GPUIOV_CNTXT__CNTXT_SIZE_MASK                                                                   0x0000007FL
+#define MMSCH_GPUIOV_CNTXT__CNTXT_LOCATION_MASK                                                               0x00000080L
+#define MMSCH_GPUIOV_CNTXT__CNTXT_OFFSET_MASK                                                                 0xFFFFFC00L
+//MMSCH_SCRATCH_0
+#define MMSCH_SCRATCH_0__SCRATCH_0__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_0__SCRATCH_0_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_1
+#define MMSCH_SCRATCH_1__SCRATCH_1__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_1__SCRATCH_1_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_2
+#define MMSCH_SCRATCH_2__SCRATCH_2__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_2__SCRATCH_2_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_3
+#define MMSCH_SCRATCH_3__SCRATCH_3__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_3__SCRATCH_3_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_4
+#define MMSCH_SCRATCH_4__SCRATCH_4__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_4__SCRATCH_4_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_5
+#define MMSCH_SCRATCH_5__SCRATCH_5__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_5__SCRATCH_5_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_6
+#define MMSCH_SCRATCH_6__SCRATCH_6__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_6__SCRATCH_6_MASK                                                                       0xFFFFFFFFL
+//MMSCH_SCRATCH_7
+#define MMSCH_SCRATCH_7__SCRATCH_7__SHIFT                                                                     0x0
+#define MMSCH_SCRATCH_7__SCRATCH_7_MASK                                                                       0xFFFFFFFFL
+//MMSCH_GPUIOV_SCH_BLOCK_IP_0
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__ID__SHIFT                                                                0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__VERSION__SHIFT                                                           0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__SIZE__SHIFT                                                              0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__ID_MASK                                                                  0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__VERSION_MASK                                                             0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_0__SIZE_MASK                                                                0x0000FF00L
+//MMSCH_GPUIOV_CMD_STATUS_IP_0
+#define MMSCH_GPUIOV_CMD_STATUS_IP_0__CMD_STATUS__SHIFT                                                       0x0
+#define MMSCH_GPUIOV_CMD_STATUS_IP_0__DEBUG_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_CMD_STATUS_IP_0__CMD_STATUS_MASK                                                         0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_IP_0__DEBUG_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0__ID__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0__ID_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0__ID_MASK                                                              0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0__ID_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_SCH_BLOCK_IP_1
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__ID__SHIFT                                                                0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__VERSION__SHIFT                                                           0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__SIZE__SHIFT                                                              0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__ID_MASK                                                                  0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__VERSION_MASK                                                             0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_1__SIZE_MASK                                                                0x0000FF00L
+//MMSCH_GPUIOV_CMD_STATUS_IP_1
+#define MMSCH_GPUIOV_CMD_STATUS_IP_1__CMD_STATUS__SHIFT                                                       0x0
+#define MMSCH_GPUIOV_CMD_STATUS_IP_1__DEBUG_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_CMD_STATUS_IP_1__CMD_STATUS_MASK                                                         0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_IP_1__DEBUG_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1__ID__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1__ID_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1__ID_MASK                                                              0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1__ID_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_SCH_BLOCK_IP_2
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__ID__SHIFT                                                                0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__VERSION__SHIFT                                                           0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__SIZE__SHIFT                                                              0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__ID_MASK                                                                  0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__VERSION_MASK                                                             0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_2__SIZE_MASK                                                                0x0000FF00L
+//MMSCH_GPUIOV_CMD_STATUS_IP_2
+#define MMSCH_GPUIOV_CMD_STATUS_IP_2__CMD_STATUS__SHIFT                                                       0x0
+#define MMSCH_GPUIOV_CMD_STATUS_IP_2__DEBUG_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_CMD_STATUS_IP_2__CMD_STATUS_MASK                                                         0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_IP_2__DEBUG_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2__ID__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2__ID_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2__ID_MASK                                                              0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2__ID_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_SCH_BLOCK_IP_3
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__ID__SHIFT                                                                0x0
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__VERSION__SHIFT                                                           0x4
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__SIZE__SHIFT                                                              0x8
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__ID_MASK                                                                  0x0000000FL
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__VERSION_MASK                                                             0x000000F0L
+#define MMSCH_GPUIOV_SCH_BLOCK_IP_3__SIZE_MASK                                                                0x0000FF00L
+//MMSCH_GPUIOV_CMD_STATUS_IP_3
+#define MMSCH_GPUIOV_CMD_STATUS_IP_3__CMD_STATUS__SHIFT                                                       0x0
+#define MMSCH_GPUIOV_CMD_STATUS_IP_3__DEBUG_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_CMD_STATUS_IP_3__CMD_STATUS_MASK                                                         0x000000FFL
+#define MMSCH_GPUIOV_CMD_STATUS_IP_3__DEBUG_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3__ID__SHIFT                                                            0x0
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3__ID_STATUS__SHIFT                                                     0x8
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3__ID_MASK                                                              0x000000FFL
+#define MMSCH_GPUIOV_ACTIVE_FCN_ID_IP_3__ID_STATUS_MASK                                                       0x0000FF00L
+//MMSCH_GPUIOV_CNTXT_IP
+#define MMSCH_GPUIOV_CNTXT_IP__CNTXT_SIZE__SHIFT                                                              0x0
+#define MMSCH_GPUIOV_CNTXT_IP__CNTXT_LOCATION__SHIFT                                                          0x7
+#define MMSCH_GPUIOV_CNTXT_IP__CNTXT_SIZE_MASK                                                                0x0000007FL
+#define MMSCH_GPUIOV_CNTXT_IP__CNTXT_LOCATION_MASK                                                            0x00000080L
+//MMSCH_VFID_FIFO_HEAD_0
+#define MMSCH_VFID_FIFO_HEAD_0__HEAD__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_HEAD_0__HEAD_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_TAIL_0
+#define MMSCH_VFID_FIFO_TAIL_0__TAIL__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_TAIL_0__TAIL_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_HEAD_1
+#define MMSCH_VFID_FIFO_HEAD_1__HEAD__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_HEAD_1__HEAD_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_TAIL_1
+#define MMSCH_VFID_FIFO_TAIL_1__TAIL__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_TAIL_1__TAIL_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_HEAD_2
+#define MMSCH_VFID_FIFO_HEAD_2__HEAD__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_HEAD_2__HEAD_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_TAIL_2
+#define MMSCH_VFID_FIFO_TAIL_2__TAIL__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_TAIL_2__TAIL_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_HEAD_3
+#define MMSCH_VFID_FIFO_HEAD_3__HEAD__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_HEAD_3__HEAD_MASK                                                                     0x0000003FL
+//MMSCH_VFID_FIFO_TAIL_3
+#define MMSCH_VFID_FIFO_TAIL_3__TAIL__SHIFT                                                                   0x0
+#define MMSCH_VFID_FIFO_TAIL_3__TAIL_MASK                                                                     0x0000003FL
+//MMSCH_NACK_STATUS
+#define MMSCH_NACK_STATUS__WR_NACK_STATUS__SHIFT                                                              0x0
+#define MMSCH_NACK_STATUS__RD_NACK_STATUS__SHIFT                                                              0x2
+#define MMSCH_NACK_STATUS__WR_NACK_STATUS_MASK                                                                0x00000003L
+#define MMSCH_NACK_STATUS__RD_NACK_STATUS_MASK                                                                0x0000000CL
+//MMSCH_VM_BUSY_STATUS_0
+#define MMSCH_VM_BUSY_STATUS_0__BUSY__SHIFT                                                                   0x0
+#define MMSCH_VM_BUSY_STATUS_0__BUSY_MASK                                                                     0xFFFFFFFFL
+//MMSCH_VM_BUSY_STATUS_1
+#define MMSCH_VM_BUSY_STATUS_1__BUSY__SHIFT                                                                   0x0
+#define MMSCH_VM_BUSY_STATUS_1__BUSY_MASK                                                                     0xFFFFFFFFL
+//MMSCH_VM_BUSY_STATUS_2
+#define MMSCH_VM_BUSY_STATUS_2__BUSY__SHIFT                                                                   0x0
+#define MMSCH_VM_BUSY_STATUS_2__BUSY_MASK                                                                     0xFFFFFFFFL
+//MMSCH_VM_BUSY_STATUS_3
+#define MMSCH_VM_BUSY_STATUS_3__BUSY__SHIFT                                                                   0x0
+#define MMSCH_VM_BUSY_STATUS_3__BUSY_MASK                                                                     0xFFFFFFFFL
+//UVD_INTERNAL_REG_VIOLATION_5
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_ADDR__SHIFT                                0x2
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_MASTER_ID__SHIFT                           0x14
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_OP__SHIFT                                  0x18
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_ADDR_MASK                                  0x000FFFFCL
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_MASTER_ID_MASK                             0x00F00000L
+#define UVD_INTERNAL_REG_VIOLATION_5__UVD_INTERNAL_REG_VIOLATION_5_OP_MASK                                    0x01000000L
+//MMSCH_CGC_CTRL
+#define MMSCH_CGC_CTRL__MMSCH_MODE__SHIFT                                                                     0x0
+#define MMSCH_CGC_CTRL__MMSCH__SHIFT                                                                          0x1
+#define MMSCH_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT                                                             0x2
+#define MMSCH_CGC_CTRL__CLK_OFF_DELAY__SHIFT                                                                  0x6
+#define MMSCH_CGC_CTRL__MMSCH_LS_EN_HW_ON__SHIFT                                                              0xb
+#define MMSCH_CGC_CTRL__MMSCH_LS_EN_SW_ON__SHIFT                                                              0xc
+#define MMSCH_CGC_CTRL__MMSCH_MODE_MASK                                                                       0x00000001L
+#define MMSCH_CGC_CTRL__MMSCH_MASK                                                                            0x00000002L
+#define MMSCH_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK                                                               0x0000003CL
+#define MMSCH_CGC_CTRL__CLK_OFF_DELAY_MASK                                                                    0x000007C0L
+#define MMSCH_CGC_CTRL__MMSCH_LS_EN_HW_ON_MASK                                                                0x00000800L
+#define MMSCH_CGC_CTRL__MMSCH_LS_EN_SW_ON_MASK                                                                0x00001000L
+//MMSCH_DB_ADDR_BASE
+#define MMSCH_DB_ADDR_BASE__MMSCH_DB_ADDR_BASE__SHIFT                                                         0x2
+#define MMSCH_DB_ADDR_BASE__MMSCH_DB_ADDR_BASE_MASK                                                           0x00000FFCL
+
+
 // addressBlock: uvd_vcn_umsch_dec
 //VCN_UMSCH_MES_CNTL
 #define VCN_UMSCH_MES_CNTL__PIPE_ID__SHIFT                                                                    0x0
-- 
2.34.1

