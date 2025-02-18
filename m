Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4D4C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 03:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984D710E039;
	Tue, 18 Feb 2025 03:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkPfjrqU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6858A10E039
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 03:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwxsMZftsumIx+6T71iJS1C6zEHopMru0UCazuUGK0fpipVuSQWuttcrmg0k1lN7ElfgT2bhck5tJJ5lIAH6X9hfAcnTDDFosodZlRb8DfMZhbO+lBjH89eVg2+UfMu2i/wiS9GrV/0811XJ91Tx0Iw9144KNnQTcSiHWKCabY4qUSme31qUQRrU1rQsIY3rwvv4eiYMfWSLJE4MsazBBMLw4IdspKoeKCVnn/WPw4gb0BkxUqyeksxSTVMsTRymrNjM/Dq1kv/AzKep+1t3RQi8wugnQRmTBcWD5GH575TtYUnikxiAeMlSaDhTC0ozp/c5J/8xc4ysa4AwMFswOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grTNZaxnH1Vp+OnKSWi1RxMc0vbLOVCSpjuO5fQMCsE=;
 b=WeHOAvigJ+m1YWpYd99IUStr24qtombgz/HXQvDHXGl6EDXLfWZAwWl8nd4agcj3XVuMOr42djePNVUld/4t8T/FtFA5E/+D0orP1FzW7ix8kVHkbz3dA6ZQGvWSpFykccsVPma6yFy59Qs6oTN9WXq7OXiCx30UE4s+1ZVdWYlaZ3/F0Shpnh1TUh127CT/ToqrYru9bc4ajsB4mBZvmHlZRVlhnDX97apEBm0G+bhZ9cWHjFwbQzhokG4w/ShLpm4HIJqiBMwedLfrfNrRjxfnai/vHWRwFS+Imc/FVWBcdQX4uGyzdhFNe2JkwgB7gsRQmR+VCgU0ceQIG602Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grTNZaxnH1Vp+OnKSWi1RxMc0vbLOVCSpjuO5fQMCsE=;
 b=bkPfjrqUJLcobl+10wVF6xIbS0g5cFB3EJH5CZ09VpZhAR8k/1aRpZG11iKyzTCSlTQTD0+ca90ULciaanENzQh+fSa9rEbMHmpBanNBvDAX0QLA82sF4t8iA8pXC3nmJ1BrAku5tTahEZHW65tRjrTSJQFqPPViinv4FKd7AXI=
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 03:07:56 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::80) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 03:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 03:07:56 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 21:07:32 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add JPEG4_0_3 core reset control reg
Date: Tue, 18 Feb 2025 08:36:51 +0530
Message-ID: <20250218030652.2472681-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5577bd-7486-4837-717c-08dd4fc97119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0pwUEt3Rmt3cUJ0ZnVBV0hXeU9kOWhDT2hYaklBT1JFb1Awc3JLdE9HMGtM?=
 =?utf-8?B?SjVlaFljem9RQ3E5WjdNRTVPK1Q4b0gzbXo1YzdjOVhqQUFDNVBVd29MT1hY?=
 =?utf-8?B?dEh1UTJzdHZ0NzZrdStuRUk4dTFLT1JHbVFuNS9QQitLRmZmQVE4Z3ZZelpi?=
 =?utf-8?B?WDNHbVVvT1ZTakNiT3NOaTlsK0RQUGpKYUN6UEdDRmVOUXVGVE5RZWNVZWpq?=
 =?utf-8?B?SUhpQmQxbTEyY1FLL25tbjl3b2xMTkVQRWIrblA5YXRBb1NtOHVOVTJVT1l5?=
 =?utf-8?B?eFpjNEJoSDRNYVB1VnpsNEVLYVovcGVTR2g4TklnZ29pT1haYUdVS0NiQVp2?=
 =?utf-8?B?NzNmOWpqaFczVUFCOVN0UFZwS1FoV2dIcGdYSE83SGtXTE1JYjIxWFRlZXdJ?=
 =?utf-8?B?QTExUFMyVUdvbkFrSVMyeVg2N3pjSVE3R0VXU1IrTFp2NWFkaXhDSmlGYjU3?=
 =?utf-8?B?K2FlQ3lmTHg3NTcrU3lDRFdLZDJMREZFc2pyNnpDdlk0WDArSlY4VGNYbVdH?=
 =?utf-8?B?RjBrUTNzNmtQU0VCM1ppOXRsRjg1eHQ0cms1QlFhcHJpbEtBaHNXaE54b2o2?=
 =?utf-8?B?R0dUcjQ3Y094QU5HbXBnemtBUXpOd2xmcEk5aUNzSUtlWWt6c0VucGJJeU9Z?=
 =?utf-8?B?UGZqVDBOQ2V5Y0x3QjJEMGtNNXpOVEUySTBhemdWTHA4K1J0RnM5dlZPem10?=
 =?utf-8?B?YTcxd1JwZ2pwSHMvZ2Vya29sV2hHYkVtalNLL0RRN1lKVzlJZGw3cFlVZ1NB?=
 =?utf-8?B?YmVUbVZMSXRBR2tqK3lxMmxxMVFVTE9wUHk3WG5TbC9OVWdWMDlLWFoxSlh5?=
 =?utf-8?B?Q2o2UFJMMTNQRWNTeXdWNExjV0NXRTBhSHJwOGE5Rnc0cTk4b0g3Rkt5N0Va?=
 =?utf-8?B?S1EvTDdZTVNsMnh3d3pDVUgzRDNDaURYT0hTM3VUQVltVElXM2dGcDJ5QTJK?=
 =?utf-8?B?K29BZnQ2QTZQN1pLMWdRYjlGNHlSeHh4b1VybUZwOU01YXlwRHMzd2J2aWlO?=
 =?utf-8?B?UytYTjNxNndjdVhkRE5YV1Y0SGVNVW9CMkljdTBKMWRsY25kdmJTeHBqWHQy?=
 =?utf-8?B?ODFYdTR4bkF1cUJSOUpiUTFLQjMxNHY1elc2ekZXdDJFbW8vRTNtc3U3bFht?=
 =?utf-8?B?bWZ4aFM4bVFwbXJSZkdML3dWdXJhNmRBVkFwUlZqVzYxdVBOblpqazRzTFZD?=
 =?utf-8?B?VHFBUDUyWUhpWS91anRGajBCNzNyQ2NGUDFVSmM5S1BpdkdRZjBuckVLaHZ6?=
 =?utf-8?B?dVVoTTFZSllrQUNGNldkbklueVFDRER6YWVTYzVYOGFreWpxbVB0OTBNcFB0?=
 =?utf-8?B?Qm1qRzcwZVhiSTNRM2t6M2lhNnVWYll6UnlmVkR5WmRFWUdmcS9DYWVQNWVy?=
 =?utf-8?B?anQ4ZWMrQSs4NkR4NkNuajN3eWc4YXRMOVg4bWxOU29RNEoxMFU0VDZtTGlP?=
 =?utf-8?B?MjAzTWxHTmFHNjMzeFQzdWxkN2g0MjZDUFlXVVJxMm80b1NBYWJJdkpHUWVh?=
 =?utf-8?B?WHU2V3N1UmpPVjRxWm5DZDIwQ0pvczMvRVJSeVBjTWRZNHNtYkEzMUlBaDNG?=
 =?utf-8?B?OEV1Mk5RRkpYRmI2Wm9QZWNGOWFGT2FoUXI1RHEyaFJObFdqdjRzRG5tZDI1?=
 =?utf-8?B?eCtDdjlMQ1FjVDJDUklOODRSYW5FOFlRbHdQRmRpbnQrRTVuaVJvTTE2dEo3?=
 =?utf-8?B?MFhMNi8yWi9ROWNMdTV3cEwvZ29RdVFhK015MTU0eit2KzVuU0pHeGhjMFB4?=
 =?utf-8?B?THhqcVFIMU5YMjFURGg3bzZlRi9GRFExdEp0Kzd5eW1UZ3ErRGt5b2FCQ1dX?=
 =?utf-8?B?TDNPMjF2b0Rib0thWVFJUUhmRmRSYmRMYzV3MlZPbVZRSlFiWjdNelZlNWd6?=
 =?utf-8?B?UitEMXFlRExkeXl4VnNJNER3SU4yR29od2ZpYXA4aWhKRkZRMzRwVFVUZGNl?=
 =?utf-8?B?d2pkL0d3ajZIR3YvWnVMamtpVmp1bWpYQTAxODM2TkcycFprWlZiVGRXWjAv?=
 =?utf-8?Q?WqIe0eBenKQA1NsjnAMG29NaMG14lA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:07:56.0210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5577bd-7486-4837-717c-08dd4fc97119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

Add core reset control registers for JPEG4_0_3

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 .../include/asic_reg/vcn/vcn_4_0_3_offset.h   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
index a0e27aefb56d..3ed10e60afbf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
@@ -954,6 +954,10 @@
 #define regUVD_JMI0_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_LOW_BASE_IDX                                       1
 #define regUVD_JMI0_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH                                               0x0679
 #define regUVD_JMI0_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      1
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL                                                                0x067a
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       1
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x067b
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                1
 #define regUVD_JMI0_UVD_JMI_ATOMIC_CNTL2                                                                0x067d
 #define regUVD_JMI0_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       1
 
@@ -1056,6 +1060,8 @@
 #define regJPEG_PERF_BANK_COUNT2_BASE_IDX                                                               1
 #define regJPEG_PERF_BANK_COUNT3                                                                        0x072c
 #define regJPEG_PERF_BANK_COUNT3_BASE_IDX                                                               1
+#define regJPEG_CORE_RST_CTRL                                                                           0x072e
+#define regJPEG_CORE_RST_CTRL_BASE_IDX                                                                  1
 
 
 // addressBlock: aid_uvd0_uvd_pg_dec
@@ -1930,6 +1936,10 @@
 #define regUVD_JMI1_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI1_UVD_JMI_ATOMIC_CNTL2                                                                0x003d
 #define regUVD_JMI1_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI1_UVD_JMI_CLIENT_STALL                                                                0x003a
+#define regUVD_JMI1_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI1_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x003b
+#define regUVD_JMI1_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi2_uvd_jmi_dec
@@ -1988,6 +1998,10 @@
 #define regUVD_JMI2_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI2_UVD_JMI_ATOMIC_CNTL2                                                                0x007d
 #define regUVD_JMI2_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI2_UVD_JMI_CLIENT_STALL                                                                0x007a
+#define regUVD_JMI2_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI2_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x007b
+#define regUVD_JMI2_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi3_uvd_jmi_dec
@@ -2046,6 +2060,10 @@
 #define regUVD_JMI3_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI3_UVD_JMI_ATOMIC_CNTL2                                                                0x00bd
 #define regUVD_JMI3_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI3_UVD_JMI_CLIENT_STALL                                                                0x00ba
+#define regUVD_JMI3_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI3_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x00bb
+#define regUVD_JMI3_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi4_uvd_jmi_dec
@@ -2104,6 +2122,10 @@
 #define regUVD_JMI4_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI4_UVD_JMI_ATOMIC_CNTL2                                                                0x00fd
 #define regUVD_JMI4_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI4_UVD_JMI_CLIENT_STALL                                                                0x00fa
+#define regUVD_JMI4_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI4_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x00fb
+#define regUVD_JMI4_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi5_uvd_jmi_dec
@@ -2162,6 +2184,10 @@
 #define regUVD_JMI5_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI5_UVD_JMI_ATOMIC_CNTL2                                                                0x013d
 #define regUVD_JMI5_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI5_UVD_JMI_CLIENT_STALL                                                                0x013a
+#define regUVD_JMI5_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI5_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x013b
+#define regUVD_JMI5_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi6_uvd_jmi_dec
@@ -2220,6 +2246,10 @@
 #define regUVD_JMI6_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI6_UVD_JMI_ATOMIC_CNTL2                                                                0x017d
 #define regUVD_JMI6_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI6_UVD_JMI_CLIENT_STALL                                                                0x017a
+#define regUVD_JMI6_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI6_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x017b
+#define regUVD_JMI6_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: aid_uvd0_uvd_jmi7_uvd_jmi_dec
@@ -2278,6 +2308,10 @@
 #define regUVD_JMI7_UVD_LMI_JRBC_IB_MEM_WR_64BIT_BAR_HIGH_BASE_IDX                                      0
 #define regUVD_JMI7_UVD_JMI_ATOMIC_CNTL2                                                                0x01bd
 #define regUVD_JMI7_UVD_JMI_ATOMIC_CNTL2_BASE_IDX                                                       0
+#define regUVD_JMI7_UVD_JMI_CLIENT_STALL                                                                0x01ba
+#define regUVD_JMI7_UVD_JMI_CLIENT_STALL_BASE_IDX                                                       0
+#define regUVD_JMI7_UVD_JMI_CLIENT_CLEAN_STATUS                                                         0x01bb
+#define regUVD_JMI7_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                                0
 
 
 // addressBlock: uvdctxind
-- 
2.25.1

