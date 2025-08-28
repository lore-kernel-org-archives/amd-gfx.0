Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBE2C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F54310E959;
	Thu, 28 Aug 2025 09:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZXP+jj5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E7C10E953
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaJqXTYTGoHl//Sow8W9MNscfDFfumi6C0YThXuk/NuQseBtOUVFy6697CYmz9C/8cLm5fCbA+OINhJKl3INuTQaayOUJ57PjZocslKWivatoTzDpj7zbD/JXhw3/sKhFp9KaxIyDVkd/Lw6t4suhU8mXlwpuq8H1kDXHPjuVMqKA9htgzWMkNCsuKLRs95zTqznfiMDX0ys91hWSLlfQkrYr1k17iKEo72w6g4CWdLMp+qTo25Fqop+3dPXfUXPUzZ1lbSBLUrc6BQWHVoG4ne2ruisSu0GMxzf37goNXBLJESbkA5XeRBdQ07j1L5ZBR56vuM+Ykf3q7ngmC4ULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=AKVUvdcbXjzJwWi0NIaPPeTiBhgomNSlIsbm9652N9ziV6wRJPx6mRBKkvYBiYVYzadmeLvtHp0C1GCecMRivZTWbsV2J6kLNnU0hKXaSYDugQpVvJzC+wfkHOuUsCj9qz/AkZUGGF1MGgBgA72dKrZe1OjyTn96Pc8xzhCl4kCGOAgxpYDNSjDKrBNVPxeSCEEIJOacXROPoIfx8qveyyphVfj49IH/iLWfzwEjcoEZQoZoy08K0hTbRhOm+oamtLQUmY3WWQXVsgdzwup9pJA87/LaD4JWoGxZIkZN4ZNTFhUDhhnrGwhEcKbp2OGAyp97tnN0exK53RDJkcQvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=QZXP+jj5O5ru9p1RW0MS35NahUyjjckEbU9A91D3AgMpI514UaATyRyvNp8zgaDhvGFw5wCb1xHcquha/cf7CpbK7auxvducPhmiQFknqFtBXZ43SxOxPcN47zMEtObu9KWBQ5BAxQyp028VGvfnjJOV1jr3+qJ5GNjWMfqhCLc=
Received: from BL0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:207:3c::43)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 28 Aug 2025 09:21:22 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::23) by BL0PR02CA0030.outlook.office365.com
 (2603:10b6:207:3c::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.24 via Frontend Transport; Thu,
 28 Aug 2025 09:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:19:43 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:19:42 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 5/9] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
Date: Thu, 28 Aug 2025 12:43:31 +0530
Message-ID: <20250828071335.3948819-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bd4f1d-e2c8-4935-8983-08dde61440fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVVmTlc4a2EyUURyVlNJUW90WWQxVWhOQ2NGRzBMK2dsR3NxOUlsRGxIU0xa?=
 =?utf-8?B?bVVKcnRGZEhOaHVnVXY0ZnVzYzZQS1lIVVMzSkxybjFGM2d5WnQ1N01uUUU4?=
 =?utf-8?B?S2tMdHBGeHRMTDEva2E3WkhKZGFLZFpiTGFIM3oyUEtsV2xvQ0ZGWHZOdUdp?=
 =?utf-8?B?NE1wME1qSktUSkRxN2dXRUJ0KzZrbytLcVI3RUl6eGJadGFQeVZsZ3VMaHVy?=
 =?utf-8?B?Qm9SUmMzdGtnMENhUnUrSUxWN0pveGJYM1NMRklpcU54RUlET1ZhbG1LWUJJ?=
 =?utf-8?B?eFJVRlpReXJKRE5yWDRhY01OSkowdmJhbTE5UTlBMjV3TGx6K2ZyeDVsQ2Vj?=
 =?utf-8?B?aXc4RmZMTzFuUlN2WlpyY0VLd2M0dzF0Zm5Kb0dRYi9wR3h1RCtMTUZGMS9T?=
 =?utf-8?B?elR6TUs2VldwL01MVlhWbXpiUU52TzlsM21uT01mWERHdGJUZkdLNjJDb1lo?=
 =?utf-8?B?aDEvZzBqQ0pPb2FSdWcwVHJmU2JKZURFaVN3VElNYUZaaXZlTFAwWXcwNk5I?=
 =?utf-8?B?ajFEekwzNEhCSm9jRlpUWG0rWVRtbnhod0lNZFdSb3hiYjBLMHptSW5vSTJo?=
 =?utf-8?B?U2sreVVybmlJVEp4VFI2empDaTVZRVdQb2E1ZjBQLzNMTDdzZE9PZDh2TnJa?=
 =?utf-8?B?RERINlNVRDhLRitkNHRWQXBUZk91VUJtOHR3K1RqNGRaWml0dDRMd2ljQlhk?=
 =?utf-8?B?QlFtSFI1Y0tENzhyZ1IrVGYrRE1YdmlOUWh5dHcxTmtDb29jQzJkWVVDVkZp?=
 =?utf-8?B?Wmw5b1FPTnZ0dEtiVDl2eEhXYWdHVndFL3d5KzUvZ2FRL0RlM2xEcUV3aGRU?=
 =?utf-8?B?WUtMMHE0ZW1TazBXdlE0WHM5VnIvYml1MlVXd0d0NFIwTWVCeDNGdFdDdHBt?=
 =?utf-8?B?YVJKcEY5WHk3OVRKQkFzQ0ZoazArNEpNNHJOaXBjT2JPeVRJcW9EdWYvQTVH?=
 =?utf-8?B?amMzNEsydEkrbkNmbVV2dldTZElDM0ZkMGduZW1TN1ZodmxvMVdXdmlDdjhm?=
 =?utf-8?B?UEdjNVJ3aGFrRzBWYTJYS0JHb2w3eHV0Z1lsV1dvSGRlWVc2NnBDbk9TZmNI?=
 =?utf-8?B?T1luVGdPakRwb1AzV0VmOWVJazB5Z1JBLzdtc1B1TVFUWWltdEU5QnV2d2wx?=
 =?utf-8?B?WDlBSm5pN3l6NjltajdSYzdiVE13U1VUWEJiVFJmTzZKWGhQRGJIdytNbjNx?=
 =?utf-8?B?dEtiMFk0djhnY2lnRjV3Z3U2N1BBbHhQeHlPTm9nRGJ2eWJsNFhmV0VRRWVN?=
 =?utf-8?B?aWR1R0ZKTlJmQnQ0L2l4S2Z2eGpsY2J2K2lSQlpRaEdub3FGbnJUSEJIV0Y1?=
 =?utf-8?B?QTZHRWdsSStYQW90TGJnaURzQUUzZlZMSGdyNzJpRXVaVTRWWGUycExmV3FF?=
 =?utf-8?B?UmhxNlRzNUVLVkk2VEtBc3ZtS2V0YzRRYlVjRVllWGpMbFpYSTVCbm53ZXpp?=
 =?utf-8?B?d0VHVkt4UUU4Q2U3UElSNFVONDgyTFNLejdRVTlxdUxualU0TXNZN05UbjlT?=
 =?utf-8?B?VmF6MUp0RXpiUTI4OURXVW0vUmhYTnI3Z1phV3pyVmVTaTl4bmRQZUkyNkE1?=
 =?utf-8?B?bE5VdEw2dys0cUpnQW9naGVTeURYMlRrWklhMnNSLytsb25mN1ZVOE4wdG9l?=
 =?utf-8?B?VXZyTktvZkMxM0lhN053bVh6ak5SV0E5UTNPSGRvcm96KzIrRjZCRU1NK2or?=
 =?utf-8?B?aVJjOG5GTWlaUWg4QTdYYWZtMXNPNEFkYlZKNkRCVEM1VXhVODBPWG5wVDVR?=
 =?utf-8?B?SHhXNkNUU3UxcVFiV3lNN05xdzY2Y2pQTkFQS3pmWWR3Qlc5UzhWVFcvV2pG?=
 =?utf-8?B?OWxkZHNsQzY1ZHpYL1VqVTl0RHdUTzJpWnRDcGRHMmpDZGV5VjdqZWFsSUh5?=
 =?utf-8?B?S25ieWZzOUYvTk9WaWNDWTg3L090NENIYVFjaE54UWVqLzVxdlNmOGJ0Rmdj?=
 =?utf-8?B?bTRraWszcE15cWlLT2VjZy84dVQ2c3BXb1M1RUlydWxWV3FoN3FUU1VyMzhO?=
 =?utf-8?B?SzhxVTZ2S1VBNmMzZmRMR2ZRbGlEb1pVUmxHUnpOTGM2VS95dzRXWGNyUUN5?=
 =?utf-8?Q?cHmGMz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:22.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bd4f1d-e2c8-4935-8983-08dde61440fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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

Add bookkeeping for the remap page to struct amdgpu_device:

* bo:	kernel-owned singleton BO

v2:
- Use existing amdgpu_mmio_remap container; remove per-field members
  (Alex).
- Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24501d3fbefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
 };
 
 /* Define the HW IP blocks will be used in driver , add more if necessary */
-- 
2.34.1

