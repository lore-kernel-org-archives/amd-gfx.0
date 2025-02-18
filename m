Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E88C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2D810E397;
	Tue, 18 Feb 2025 04:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXx09dj/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6C110E397
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFRXWfgaFhkpyUV0Niw01OI0sAmMYKjiVgPeKLFDdrHDHyyH6v8Qjogte+f74nnmKjSs/5vkjObRBxCqe6/2A5nbSSePUBe1fnJoyzgnwZKO8akrtPHTW9+38idK9X01IFw9uZm6Xm8CXG55tgi9cCZB6UJF5dtK1SVOdvDKHgnMdVT9sW7QFHHowcCYpUrVRKOtEiDuMhvyeUwGIx7bJaWC9hnkoBLg5iAKO/lwwIllv3iVthJnmCAXR0bISUJrYPjV5vT3dayaQmCButZEJVMBgteskyA3pMO0ZFfMl3CS7xeRiO2S/8mXcP799abSpPnijloYOgLAZdM0qyGEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grTNZaxnH1Vp+OnKSWi1RxMc0vbLOVCSpjuO5fQMCsE=;
 b=XMdf7Ad59Aj5LuL/d4WGWZY3QuDFp7BCZtzhHR2R9fKS5PDyUUcT3J18LPtEL3PBa5B6iz7fUK8L43h6Q8+1uB74OZJH3/5e+NwiYUtPlF/mtMgKb1P5M5GGWt+/3asAAVBznbneuGhKHxIdMjvrNvymAvH47vlKd+ZpKr8Xlav0oxCLnn7YqHuciRF3cKVOCIcAEdgb85yV2juZ0g/+gApgHhbAsSjUBphV/FJU62i1KDt3G3i3LHRuIms6KbPfZDeeXAs2pTv5AHGDi9cwEkSMB/yIZtAdWKXrWgnb9RrsKT7RdlSYoPQB7MRLYuSek3fEUTApVnVYG6pm+YtP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grTNZaxnH1Vp+OnKSWi1RxMc0vbLOVCSpjuO5fQMCsE=;
 b=NXx09dj/Z+pmQbxpdfx7FiuYWRNdng18hiblzba40ebwAo8Jef1qPLbItSfYHwBxDFNe96dPZDtgvn38K1QTVJDCOLxdvLdv+U9rdEiJT/Wa/+ZFSa7GTcJUUkFw7y7VeF0flGl4S2hBc/PIzkF/SkuuODFPJSsxubnSz0R5Myc=
Received: from BN9PR03CA0443.namprd03.prod.outlook.com (2603:10b6:408:113::28)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 04:52:47 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::a7) by BN9PR03CA0443.outlook.office365.com
 (2603:10b6:408:113::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 04:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 04:52:46 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 22:51:37 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: Add JPEG4_0_3 core reset control reg
Date: Tue, 18 Feb 2025 10:20:57 +0530
Message-ID: <20250218045058.2478917-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d63ce4-eb65-4b7c-c106-08dd4fd8168d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2tLQkpneUNBdnVBK0xWMkJENnZCdVNZQTN0Uk0yd0F2OGYxZDRMMmUwNURF?=
 =?utf-8?B?cWVXSFFRNzhQSHpjT0VrQVo2cW14a3RWZHdwTkdRbjFVY0pEaWR1YXFxWjVk?=
 =?utf-8?B?dEdnNjZvNmxjSGRZTUpWaWJ2VzFDVy9VeEtVeUVEZ2c2bnNKZmtpZXJYMjdr?=
 =?utf-8?B?MWV2cStSNGxsMmFYM1JsSGFmSlhieE5VSzkvSEN0WHNnVDBTOFduK3NvMEhl?=
 =?utf-8?B?THJ4ekZKRzM1M1VnMnk4WEJEMEZBS2MydWdCYm1SQlYvcE1ORVB6VmVDTnAy?=
 =?utf-8?B?SFpIWTRNbVh5VjBvV0Z0Y09BaTdFNHNXNDNDV2JJUGtSLzVqUXZ0NXlmM1JR?=
 =?utf-8?B?Vyt3d2ZObmU4Q3dJNWtuN1c4NHZXeWI5VzNnUjdqekpNU3FlWDVwUUI5aHdR?=
 =?utf-8?B?WHJIWCtSMTVHVDJlb2RNd1hudmxqWG42aGZ5VGtObnI4MEJOTFdNOStYTHk4?=
 =?utf-8?B?NjUvdVM1QktGZHpJVmZUVFhOYjlRbVVQZzlBTjNMN2FHL1UySElvY25TVThy?=
 =?utf-8?B?SmNlWWtTcVBxYmVpdkZVZ1dFa29WdGNMNFJ3WnBjNTM3RGtXSEtJQVprS0ph?=
 =?utf-8?B?dU1SV0UyQi80MEZUTjJxc3lZWmplalR4ZjYxKzM5N0IxNHBsVkQrN2pCbGl3?=
 =?utf-8?B?Qk1hVkZSQUYvNkpOcllTU0tFVXprYTFBYVRzbDlNZ2tDZnhVZnVBZ01PSElm?=
 =?utf-8?B?aUFacHI5elBETlBVU3gvM0FYc3V4YTNHRnFjSEVMb2dFYTluWEZSNkprMmEz?=
 =?utf-8?B?dXNaVnhiWlN1Sk8wRjJyeUNsK2VOLzZqbHc4dEovMmh0V3NPYktjaHhoRFpm?=
 =?utf-8?B?RDZDUHhIazgyN2h3NEx5Wkd3NTF5eDE4ZWkrTE5sZ3ZPaEZOZCtyOGRvMzcv?=
 =?utf-8?B?MUt3VkRaeVk4MVZHRVZGSXpPVGhrdUtHdlNKTEFlc0NMOU9DMUxPb20zSFJK?=
 =?utf-8?B?WURTelc4SWZ2cHZ4Sm5Zejk3bUtLbVM4Ritkb3NmUS9PK1pWblNXTjNCeUI2?=
 =?utf-8?B?Q3Q5YWs0eWsyVkNVK0x5N2tnODd6U25GZlB4cHNQS2t0NkxtNUNpU1lHUVl2?=
 =?utf-8?B?SHJCTUp1NDNIM0ZTdDkxVEppamQzY2Y0RDFieUprUUpaYjZNM1NMblVIcVEw?=
 =?utf-8?B?aVRidGNpV3V3K1dFaytRNWZvZ3lvYWczSVRFYlVxT2JBbUVsbVZWYzhMZ0ZR?=
 =?utf-8?B?NGZla3pZUDA3TXVzeFBMbkdSTjJaRFR5eDRDaDlnRUpnbEN0ekt2Y2w0U1Va?=
 =?utf-8?B?TGc4RWg5bVpKcDV2b1YxUWo3RWpaU0xEbkJ0SkM3bjcwY2NtMU9ZR2pXb0xR?=
 =?utf-8?B?WFozY0NBSlBMaGRvVUIrSXZTNEhkSjN4eUwvcjlsRGdXYkFmdkswaEpTN1Zt?=
 =?utf-8?B?TDZzNmJBL01MWHpJc1RDcHRvZFNic0RKSGo4Rmt1MzYzR0ZreU5DMUNoM2U3?=
 =?utf-8?B?S1VIdlFjRWVTU0I4VmJtZG4xa3lyS1pFNWN0c0p3N2Q5RU1pSlVqSnpKOE9o?=
 =?utf-8?B?VDJKeHlXbTgwek03MVFBQ0t2aXVWYnNYR0JuaWUrZUt1SVg1bk8zaHlLQlhE?=
 =?utf-8?B?alZEc3FzOTZNYitVT3cybFZuWCszOUY0YkZzY0h6ZGFCVkRYcmw5OVorYU9u?=
 =?utf-8?B?TmhWdlJ1Nk9PVjZMVzFpTE1iNTdKRjhRVHNiYWVHaGtLMm5rL3pPTG1FbUFF?=
 =?utf-8?B?OVN1U2tMTWlzT0FaUUhUTExUR01ucTZFU2dTYnVQZTVlc1NpT0ZWT1BYWDg1?=
 =?utf-8?B?KytoNTQ5VnpZZUdnM0JrbERzRkR5djlOYU90N0xONG5zdVJGQXJkZVBOYndh?=
 =?utf-8?B?eTdxTXlkaHREOXpnL0NnaXJvcHM4RVM0RW5qM1c5blRlSkk1Q2VldjUvRys4?=
 =?utf-8?B?cm1SMmxkZkgxV3NoSnE2bzR6bkwxTXYvYktkdWg2V2VRSVRtTllHQnd0MEJU?=
 =?utf-8?B?aDNQY291ZEprUXd2ayszdU5xQ1k1UVRqRDV6QkUxU3RDY2o4azdadXdYQW81?=
 =?utf-8?Q?RP6c9gceJkRdpeBJHeesI1Vk1kFBK8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 04:52:46.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d63ce4-eb65-4b7c-c106-08dd4fd8168d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

