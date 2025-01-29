Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46852C02192
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0B510E764;
	Wed, 29 Jan 2025 08:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y+B5aQ73";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1469610E764
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjXjHwZbQFOH+6R0Mg/vfP7994tXYBSvkKI1jaVTbiV2gRUgN1rkx6CL7ePP3asMPOwW5qJW5iCTLRU2W0MFRDToSbZDH1faey9mcJMVjaMWZiHaS8rBfOy5VQk+FXypZVQixR3cuuqMJaOEOn/dOwKLYYVqg+sQawwQK6s7Azhp0QkOoWS8b0RY/jUFDLiTTDhqjitxIVXZWveui8JX2nxv6wB5ysTpglNU39nTVTwRPsX+RtGaQoDdbekJrNGEcsGD/STiZaOP8eDkWpLx6tzyen3un+wliL9CVEM0eP93b27XgpdvaYatMu7L+faobTv2+9Uh59wWeC4ee5+cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/CwXEkCNd49MWM+N60LkZWQD/5PNsQeswOQDWnIHnQ=;
 b=oOHM+xmE35LyJzXKFDOf3tIS+fTkqgL6gMw8d9vg9tn0ZIz/shPDfZaXdSNHUAFVb8F7Uz5aBCL4Psp8VKuZ8d9Mg9txHdPVlhPoOGbxAe+txV2hlZDSi1EX5gd9CZ9w0M8DFE6Z017dEihGJlo++wtIuvzM0zcqkweni0iEhg7Nm4l/rX+yvoLXLeCqKFyGI0WeniUo4SggWGgkB2X+TpwfjMSVe0JQ5jojBLPt18kCLZ0FowNsPwzXE4zGgelF+/COBRcqnilGNdSc2Oou8i/23pEipNxoxljrAztYEpy2yg4dF5lCXUTMnUdG4Bnaiacxu6PGFzyDBoeDKiVGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/CwXEkCNd49MWM+N60LkZWQD/5PNsQeswOQDWnIHnQ=;
 b=Y+B5aQ73VnZZ5LVRvS9dX7+l3BFvZYtn7axe64AD1NhKJljaf8nd/m8QmwEq0936g12qh5qqKauoUaY9HMxc8mskpMMUeaK3SgkpExraC2dbFmdb1p6bejV41/9UPyrLVhy+wwlhn0zc6fWt8drPqvvARp7SOmbpn18qB8Yt/9E=
Received: from CH0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:b0::15)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Wed, 29 Jan
 2025 08:48:06 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::37) by CH0PR03CA0010.outlook.office365.com
 (2603:10b6:610:b0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 08:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:48:06 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:48:04 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 4/9] drm/amdgpu: Enable devcoredump for JPEG5_0_1
Date: Wed, 29 Jan 2025 14:16:38 +0530
Message-ID: <20250129084643.507727-5-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c52612d-b163-4340-edef-08dd4041a658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3pXcTZwS2dVOHBONDlLaW1PQ0p3SEtXUllqckUrQUR6V2h1aHRsdU9uWWlP?=
 =?utf-8?B?V2JwNnBNbzZ1WUtuSTQ3dm5GOFdmNzBNbEJ0cUJHa0V2MHQybWt0YllSM3p1?=
 =?utf-8?B?czVEMDFKbllnWFZSSGpyaUdRbmRNWXRvYjRRVGJDNXBhV1NPY3RaNWpiNk11?=
 =?utf-8?B?M0ZNczVJeUc4M0RTSktrZUo3elNhcDlaYlRmQ0hYT2xLZ2N4STZRcmhCbUsy?=
 =?utf-8?B?VEJ2QnR4NC9rZjdHVmQ1S24wSithT0phL1VKMWtGQ0xuR1BHcXBxc0o1Q255?=
 =?utf-8?B?SDRHcWVCTjAyZkw5MDhBRDNGY0xTSzVtMFZOVWFWaUdwTk9hVGZWWWltMGNE?=
 =?utf-8?B?VHdZNUxwcU1zdXR3UVRQNXRkOVFYTk80YWFTc1pnMmVJaGFxU0J1alF6b3JL?=
 =?utf-8?B?VjZ1WjhQZ2VpUGR0QXhvMWJ3dk4vOGtETVZnd210RnlkVUN3VG5wY1FVK0Nh?=
 =?utf-8?B?RzR0WnJZaFVYVjFkQkhoNmtDOUF0N2hEQ2VrWjJVSGQzdzVJUGVWeDVwVmpk?=
 =?utf-8?B?ODM5SlNrT09ydUVaTTUvbFMyV1p6VjgwK2dNSVYwVzNkYmk2SUx6eEc5NFRs?=
 =?utf-8?B?dk9XQ1hwcENhalU1SkppK0tsZ0FyWGpRc3ppbENRbXliM3BKT2o1NURhL0VZ?=
 =?utf-8?B?WHY4cnVOMi9CdU9SUThHSld4UUJUMVEvakY5N29iQ3dkZjBLbzhMVkFveUFR?=
 =?utf-8?B?VC9uYzVLaDJXYm5xcWRQSG1vT2RJV3AxR3pkUFVOUGRDWkNrMGd4VWJjYWZm?=
 =?utf-8?B?cjFhNU5GTmNYWU5EQXRRSW9JVnJiZ2cvYTlkVnh3QjRTbGVudXVWWUFCSC9Z?=
 =?utf-8?B?TVNrclFjRnJxRERIU29xWUdOT0RrZllldHluN3h3Vlh0emFUSEljdjRjb3Np?=
 =?utf-8?B?UWVSUnpmZWdGTTZiSi9BeVRydlgxek1DWlNMR0xLMTcvRWt5djdwd3FOU1FT?=
 =?utf-8?B?bjc1K3JXd2lGZkN4cWlGS1YvZXhpeEd4RVBvNlI0Vyt0RGxrM3NhODJXak5O?=
 =?utf-8?B?YnNpN3E0b240YmowdkpGRlZJTDE1RjFVTW9OKzRxeG51N1BHUy9ISDRvanFk?=
 =?utf-8?B?dmhJeHp3SW1RWXBEdnY0OXd2bitoRWlxUjZ2Z2ZuNFRyYndpOC9ZMlM2dDJL?=
 =?utf-8?B?OFlaczVaVFpsMlFiMXFUUHc4eDJIM2hXTjNxd2xrVGFSRGU0ZFlBRUV3SHA4?=
 =?utf-8?B?NmpEZGlwTCtTM3dTMm9FS04vbjVIMHh5bFFMZ3d3SnlieUNNcHFuNFBlVzR0?=
 =?utf-8?B?L2ZxL2xocmJzNkk1VU4yOWx0alRBelAwa3hnb0tEbXRycUE5NXZTenk4UWxL?=
 =?utf-8?B?Q0pDZ3E2ZllkdlhncmpLbHhLRFd3YjBBcVlTanlNcFpRMG9jSnYrSTl1elBC?=
 =?utf-8?B?aTlEUEFSOUJROElKRW9Rd25QRVFVUVVlS1E0cGNKVjNqeFprQ1BhbXNSU1U1?=
 =?utf-8?B?SnlSSnJaS3pEa1I4N0tLNWRmRi9TQ0l2M0JwOURJeWhieHRRTVIrZjYvRTZC?=
 =?utf-8?B?bFdHSnJpcXhSV2hiem96U0ZQTjY4ei9OcVlBd291Y0Q2aUxubEs5b25CVHVQ?=
 =?utf-8?B?YWZvRHdCb2dEa1JtVlhSVndIRFRSNXpLaE5ZYmJqUGFpRmJvcTV6aXN1SHI5?=
 =?utf-8?B?Y0RZemRtR1NveVdmYnYwYVBvTlBnZHdmeHBZajFObElwYXJxNFNPOWtydTFI?=
 =?utf-8?B?Z2Zxd1R4M2FRRGo0UHdoMEphNXhpT0plMUx1Y3pDMXdPVUtjcTFuOStCNm5U?=
 =?utf-8?B?MFljUGpLemRrMlBBeThCNUFpaGZQNi8rU3ViaFhFUTZxL09RY1VBTE9FaTQ0?=
 =?utf-8?B?Uk5jcjdMbHhvSlZ0UEJuT3F6cTNOSVNkQ2Yyc2ZnS21kTGRhbUZTZXJKUjBy?=
 =?utf-8?B?Qi8rWFlqSG1YdnRxNVZvek1ET3NXWUZWZ082Tjh1UFZwbjdTZS9pL3lsZ1lx?=
 =?utf-8?B?U1REZUpUQ1phVDdrSG5kVmNXcnFIRW1lOGdwV3Y3VEF3NFhwZkp5WUplTHJo?=
 =?utf-8?Q?c1JAkDgTdQAztI99Ty+PimLVpYh56k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:48:06.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c52612d-b163-4340-edef-08dd4041a658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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

Add register list and enable devcoredump for JPEG5_0_1

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 51 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 61 ++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 40d4c32a8c2a..210dd8bea1f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -52,6 +52,47 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_5_0__SRCID__JPEG9_DECODE,
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0_1[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_STATUS),
+};
+
 static int jpeg_v5_0_1_core_reg_offset(u32 pipe)
 {
 	if (pipe <= AMDGPU_MAX_JPEG_RINGS_4_0_3)
@@ -145,6 +186,10 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0_1, ARRAY_SIZE(jpeg_reg_list_5_0_1));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -166,6 +211,8 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -635,8 +682,8 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
-	.dump_ip_state = NULL,
-	.print_ip_state = NULL,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 8ce146c00bb6..9de3272ef47f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -26,4 +26,65 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR             0x0640
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC0_UVD_JRBC_STATUS              0x0649
+#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR             0x064a
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX    1
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR             0x0000
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC1_UVD_JRBC_STATUS              0x0009
+#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR             0x000a
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR             0x0040
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_STATUS              0x0049
+#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR             0x004a
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR             0x0080
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_STATUS              0x0089
+#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR             0x008a
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR             0x00c0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_STATUS              0x00c9
+#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR             0x00ca
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR             0x0100
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_STATUS              0x0109
+#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR             0x010a
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR             0x0140
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_STATUS              0x0149
+#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR             0x014a
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR             0x0180
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_STATUS              0x0189
+#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR             0x018a
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR             0x01c0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_STATUS              0x01c9
+#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR             0x01ca
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR             0x0440
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC9_UVD_JRBC_STATUS              0x0449
+#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
+
 #endif /* __JPEG_V5_0_0_H__ */
-- 
2.25.1

