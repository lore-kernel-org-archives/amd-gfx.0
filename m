Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45014C369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77EB10E6FB;
	Wed, 30 Apr 2025 08:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqhGzDPs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420BA10E701
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8DQCjM8bb0SN3iVr9bx2eYMmqWTsn9fkIy3gC5/HAEld++l2ZfTzLr1kldUjt6r8GHSnmJ8v9dUSOQ5Jn4dqe71UBWPlJ9Q2h7+3J/2VdibULK17RLJKjTVnXE2jEEyK/uin6RiRrUvN2oU3q4lMnE4uwvTmDq705IcuLzFz0XP0JbKAxA6Pn+keSrc9LsIH+L4GD1d6waic8zjBoITuzskUUwDxtFnNEvp7+rwFEr7MQXbOO354i9BMZPgf48t77wNJc/dFuU1/9ArXJ6uBbDJcDtIXYkonrms+jM9MxC8ORUppnEIpg2Cg55Ct6v5XxY+czZ6llCuxJ0P1cCAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=587jholJZP5pHg3Rc+TrTvZHaiUj/xxoqDBVX+L7GZs=;
 b=tHXGnhU+mOa1z4s808xW8wEIs1tyZWGckasuWdEhjEfL8SGfefhV7N0ESmePXuzYKDMHOO4345HSNTIVdvRoTueqQv2kdn5ORkAyJQDWtNZJH/QhM6Wd+h1btcPIHcN4I3z5qw1br3jliUGnhsVm89utWTymiHrrYW31oJ/L1hYyB67lfl9Iu7lMRo5+cHvAKkYiwgW9mxWRc+xqHS+TLdDPv4ICVBUO+SJ80vmqFuPtVjOLqEQ4nCUq+DA/tSKvqxkexmjr2XmzcgkDSW+Sj2KjscYWfrvfHTONUD4h/Qwt7hYsmSfG7/K8Rt2JQJ3aEC9arAzse9M9IWI79sB38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=587jholJZP5pHg3Rc+TrTvZHaiUj/xxoqDBVX+L7GZs=;
 b=BqhGzDPsO793Eokevabw4foJW9j91QK6r+w0lAVgrrjN2KLxu5+gqUtZ2VT8UNhmQEJXtNbluzSubfrH1i/poA8DWVqcqJydT+k3B1KZM8JQ1w1jgShIIVbdcpRRP1lQ99zCcsaobsczgH7tAXnTiBGBGRbVlsK0qV5J+d9b3R4=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 08:26:09 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::d3) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 08:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:09 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:06 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: set flip bits for RAS bad pages
Date: Wed, 30 Apr 2025 16:25:49 +0800
Message-ID: <20250430082550.60109-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: a148429d-7a03-4c77-169b-08dd87c0a8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dj62UH9xBbmkyofbluI1ozfLvhB8pIJe3Yf4EmE4tc304iMmu7To/dRrkJqI?=
 =?us-ascii?Q?y1lM7jTlIB8bMM4mll88Zr+SxIDxVuNBcA7YCIbS0GkxtK5tzh5dc854aWWP?=
 =?us-ascii?Q?Q9muvlavOKgDefyRyZzBQ2sIUyAphbVtDNJ1KZsfUpck/DoHMrB/qlGtQQgv?=
 =?us-ascii?Q?wZXizVyWvVg3KiBEGtaKAwrhj4I0e3z/sm14mLaVRHRhKUWprt4WMkAvOGw9?=
 =?us-ascii?Q?6fPfthVWnR4tKJ9aX9J1SA4UsstkaefzkiVa5jIKYFWjUdfGsGaojKMmaLWL?=
 =?us-ascii?Q?8QtRgyb1W4L6lTe7jbh++e4vbNa01aJ/JZbCs2+6+3owEjGbCCmGgjTm97qu?=
 =?us-ascii?Q?zLh5uH6IQvMxPZoTlQgwyb1jcuMsi6bupnt3gX74X+A2jpXs/zOLYI/1GgAV?=
 =?us-ascii?Q?Wd02ckUNPw527MA/ofKZeaX0m6fOw6eJE7MzpWM9c6VzlsmO/2VcNcmkHidA?=
 =?us-ascii?Q?9CadYR+YxpKj6kPBHr2bbDOEZtu7l9zrc0V6OrweH8TkogN4OOPwSVh9VeO8?=
 =?us-ascii?Q?9a36SLRyDbs8MRGFZv9P5cUzt4K6w6Ijst6RFufKlPR16N/9WwzOxImlrytB?=
 =?us-ascii?Q?jIuYXad9FXQAV0rmhZS9aeRIRrKHT1l8PcULYMNUkVTxULOyFxzzWo/3kIGa?=
 =?us-ascii?Q?BukmDc0+Vv7W3CVyBqnqk0/MAuDmdRz6+xLZ+++exxgMZUD5NVWYNzvLO7MV?=
 =?us-ascii?Q?sPqmKhGTbF0e2/HmaIuH3P1hfwbyMolntEaMNVB9R9beOUYWBmzlw+sv2vlu?=
 =?us-ascii?Q?iOXkCIik5u38rWFFiCH46qRDgoX433iWTIcCK7pxvRDvuDSlBvwwLUUUD4P/?=
 =?us-ascii?Q?DFcMAaOnnvyYQrYw6FOq/twY/d3yf2VsFyPqosyUJwjkultt3t1Uelo+hCYM?=
 =?us-ascii?Q?LGDBKLIsM0rgkOorLVYHHesXPPCRrBBGz+ksHEzPU5VoykfHkGQbMM331Yj6?=
 =?us-ascii?Q?GS4uaDWo5QOOqn7ZwM+lAfU4Y20hbz0KdOe1zzwfMPz4R7Mq6ZF+8n5in5nc?=
 =?us-ascii?Q?v3ZOcqW4SntPjLOLJ4y6wpTuz/mOO/pj7JlotDfajJRM29vN/uvNaHghKjUV?=
 =?us-ascii?Q?MSFlqJgOHlD8W9RrhnTvWJvLc0mDOc5hFsIvVYXSUCEqw9SPhPeEcwBMqCfA?=
 =?us-ascii?Q?A2VJ31FsOTIb9mB9j4TQdnpxumlWYQ/E1ZXrf0JWNt6Z1WbdpvfzWf+pODU9?=
 =?us-ascii?Q?eR2HgdOSRR0BZxfBz5uqQ8FSBr/0PTPKn6dj8xm3r/+ZpYwCjhTjZv4SaErW?=
 =?us-ascii?Q?AJo6Ugou98YKmESpLllRGLivs3bdW2fqhpVMn5MHXakYmWJzRALDPg+o55FK?=
 =?us-ascii?Q?DHanBiBkio8vkyWxmPv9W8lxTMNfhg713OT7DvXnR3dW0kQpKelFQJ7lopxF?=
 =?us-ascii?Q?L4bZXrAEeEa/l+XJ/cPUpEKdK3uuC+gFIhR7A7d53CXh+9Y7kgBb5OFAtkS1?=
 =?us-ascii?Q?24PDEUzFMekVvvmzZkJBtsI8Rc0p+q4A4Ne3IUb8OqZfdVgXeLLjWxofJ8pQ?=
 =?us-ascii?Q?fRKy42BWUHTqUb/zdsA6jhxlxKTZpY1Beaz1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:09.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a148429d-7a03-4c77-169b-08dd87c0a8dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

Make the code more general, user doesn't need to pay attention to the
detail of flip bits setting.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index f9076feb5a24..b04701d12e43 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -295,9 +295,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	col_lower = (err_addr >> 1) & 0x3ULL;
 	/* extra row bit will be handled later */
 	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
+	row_lower &= ~BIT_ULL(adev->umc.flip_bits.flip_row_bit);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 5, 0)) {
-		row_high = (soc_pa >> UMC_V12_0_PA_R13_BIT) & 0x3ULL;
+		row_high = (soc_pa >> adev->umc.flip_bits.r13_in_pa) & 0x3ULL;
 		/* it's 2.25GB in each channel, from MCA address to PA
 		 * [R14 R13] is converted if the two bits value are 0x3,
 		 * get them from PA instead of MCA address.
@@ -315,8 +316,11 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits[i]);
 
 		col = ((column & 0x7) << 2) | col_lower;
-		/* add row bit 13 */
-		row = ((column >> 3) << 13) | row_lower;
+		/* handle extra row bit */
+		if (bit_num == RETIRE_FLIP_BITS_NUM) {
+			row = ((column >> 3) << adev->umc.flip_bits.flip_row_bit) |
+					row_lower;
+		}
 
 		if (dump_addr)
 			dev_info(adev->dev,
@@ -536,7 +540,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	struct ras_ecc_err *ecc_err;
 	struct ta_ras_query_address_output addr_out;
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
-	uint32_t shift_bit = UMC_V12_0_PA_C4_BIT;
+	uint32_t shift_bit = adev->umc.flip_bits.flip_bits_in_pa[2];
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -584,11 +588,6 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
-	if (nps == AMDGPU_NPS2_PARTITION_MODE)
-		shift_bit = UMC_V12_0_PA_B1_BIT;
-	if (nps == AMDGPU_NPS4_PARTITION_MODE)
-		shift_bit = UMC_V12_0_PA_B0_BIT;
-
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
 		ecc_err->pa_pfn = BIT_ULL(shift_bit) >> AMDGPU_GPU_PAGE_SHIFT;
-- 
2.34.1

