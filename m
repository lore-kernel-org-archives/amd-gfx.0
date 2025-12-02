Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB41ED116FE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B4610E5EC;
	Tue,  2 Dec 2025 10:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2eUdDsDX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C86D10E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZZ9nwNMEnB9yVlTAMFSburs07U5jqSPTbN1S+pSH5BnLPRywzgFl5P9m8A+KvwjdLt2sezAYLOuYzvbynMHYKAlRrCrSrrOMRevsZRiFT+jBxo7SU7/y4ZHZ4CY85krtSvofVL5bYledABzW2z2nhbll79ps1PnQo7cHz7JrCTqTTeoCoiv2bHJxIChye9B501j25/T3g5dqG3UdrdLYNLa/qWkHcgeAsSKf2n5rnysLAcGa2Rs9FPrMwfe7j3PWiBoWOW50fdr24Sty+4coz3i2u49yVB/2AF/v1zABgpd4XKAvqGqQjIvRJLAPbajtzwZtgAYYN7z6mt4byi8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuHXwkT2B4QMtDdl4fuyKFUyzcIoYffHI1x28EyfD+4=;
 b=l7NCw1HMAoTsoyOT2Q7+8INX+7TvO+k7kQ31aJTb9AJKSfhPnbItNsLRVmdMqfVLxEiM3ZXkxWr/PTAXRT00NzxxCgnzFwnUk09oTKkk36u6kM9ajPgIhnQdZ4QJ7unrevDKA4+QHL8HXbjAg8juUi45FS3Q4KbNr0BfEgYPLt9EHs3PDiETggzB/J7M5eQ9E+0NOLDLY1FZCSE+kWR9qCMFEuy3ZV579cGr3DfFKaa7CWWB1O2eHkOxe3/KtgV+NvKMvE2ldP8lNdfCtshMsvjpejIjI4kAL12SBQi4Pl5gbea9cFA8/7gsbq62xWkBPsnjeiXaXjisNogyLlLMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuHXwkT2B4QMtDdl4fuyKFUyzcIoYffHI1x28EyfD+4=;
 b=2eUdDsDXXuaSV7xFRocLlT4F9Cj0ZNw20ll5t5R0O63N3m9XniUHlfcYwj3lBURlC3aIHKiCw+V+oyTyvYaFdVVWJcTWlFs6eyRrxHAuwsdGs/pIaH6JdxQb57z2i+zDTW4dslW2eMYzO18BevgGYDlHyZmRkD2vfC7SK77c3Lg=
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:03:22 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::8f) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 10:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:03:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Dec 2025 04:03:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu/sdma_v7_1: Add missing inst_mask entry in
 sdma_v7_1_inst_gfx_resume()
Date: Tue, 2 Dec 2025 15:32:59 +0530
Message-ID: <20251202100259.310182-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d919ea-1faa-4c88-09a3-08de318a06ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEJUajZxOTN6RW13dnpWL3pEN3p5aDdJTElTR09ralBRbzhvS05oQSt6WDRO?=
 =?utf-8?B?YUxUQlZPZ1RuekhEMlR6NnJkcHFkOWxmYXB6T1Q0MW1xQU9qOU4zV2k0TUZH?=
 =?utf-8?B?VmJibWEyMGY2UHdSV1VMUVdrL0JJNFk2RzhVUVNxNGtkTERjZ0Z0dklKYmVn?=
 =?utf-8?B?RUhUSWRPYmlUOGwxUVBKOXVRWDZPNmFVL2VDZ3NkU1ZmK2RrRmVVc2diaHVU?=
 =?utf-8?B?aS9JVzk0RDh2eDJyTk1aZ1BUbTFyaU5TbUR4ZjhUanBrdmYzdGQ3M2ZrT0xw?=
 =?utf-8?B?cGdPWXlKK3kwcEpaMzZhbFJLTE9xR0tTZVVXL1FHakRnUktxNzBXck9vMWgx?=
 =?utf-8?B?cWN2bm9pQzVWdXVMMVdONW8rTXM2NGQzZDZ2d3RCRGExUEJscmFrWFMvZmdj?=
 =?utf-8?B?OEdVTCtxUXM4ZU9BUzhvQnZGVWlJSWMyQkNMRVhadWVXNFJXNnpnR2dML3ZS?=
 =?utf-8?B?NSt3TXh6N1hBcDRobVVZVEtIclBRRTl1cTBST3FQU0FpMzBKUXRHQjBkQU1U?=
 =?utf-8?B?aXgwWUNJV0pETGQvMkd3Sm16N3JBV0g0N21IQUw4N0ZpR3kvb2N5Y0Uvdi9i?=
 =?utf-8?B?NGRCMi9mTU5Xc3NWK040dVlXbVBJTWQwUXR0TVV1Z0g3RUJydE12cUhVN1dY?=
 =?utf-8?B?c054M2JCSGxUVldxOW16VzhXZ3JqNmZCSDRoM3A2VVFmQUJhVmxuRG1BVnVr?=
 =?utf-8?B?YUxBQUM0ei9FcnBvdjZ1VFRNWWZXUC9Rbi9yK2VvT1JCZDhUeEJTU252VGhk?=
 =?utf-8?B?QkZ6KzlyMmUzUFRKbFpUcHE0Mi9ieXR4Q0tST01Tb3kwUXE0NkZBRlBuTEtu?=
 =?utf-8?B?aDBwcXoyMXZaMzc2ditqOFNMQS85aFB3Yml1azVobk9mdTVFVFQ0QXZQRi9E?=
 =?utf-8?B?aFJMMC9raVVyQ2tLZi9wT2N5R2w0Tms0SGJLejZHK28wZEw4aHBkWGdab0Va?=
 =?utf-8?B?WXlHSEVMNGYyNjFWUGVOelRHYllaMXMyZWdDUWdQeFZ4bkVDM2pJUVZLdmNS?=
 =?utf-8?B?bDV6eDJsc3NadFlhODdrSGdCUUdMcHl4b0FYRTdyQ3packZmRGE4R0QzU2ZE?=
 =?utf-8?B?a3czaDM4dTVPTTBETUl6SGwzM3hUNktWV3EzbDl4YzZQM0NsdzZsL0F5aUNn?=
 =?utf-8?B?c1pabkVSNC9WdEs0M20xK0dabVhzQllXMG9iREkxbk00bE5KbVRxWDdIcjJy?=
 =?utf-8?B?TWhjVlVUM29EcE93MjFxWVhXYytIbXZOaVFpcjV4Q0M1cGR1QjVvZEg0UkVx?=
 =?utf-8?B?QzBUcHZUZkl0amV0ZHNMRXQ2bnBqQW9iYlFrUk81Ujd4SUJqUEdtajN1UjEz?=
 =?utf-8?B?UWQrUGlWN3I2MFR6anNzcVBvNTNhUmdQcHJDc1FxaThTTDI4TDVDak14eGJX?=
 =?utf-8?B?Mm1vWmRLWXljakRWNTRxNWEwUFJUT3NoTC9kcUFkdUxvWWhrZ3JYWnV2c29j?=
 =?utf-8?B?bElrdWxiSTQrQVVWTXNHMVhWZFRyNlF6YnBMVUJmeVFIK0pCcDJVRDBCc1JQ?=
 =?utf-8?B?THJvd0IwV0c5MTZBZEQva0FjbEFXbUZ0ZkphbTVsc0FOSTZOOVVSblZvNlNF?=
 =?utf-8?B?UDdzVEVzTnFVZTJMWGpBZURFVnNCOG9wMTEzR2NNdUowM3BUeE9xbmJCSkFh?=
 =?utf-8?B?a1NSYThoSEhvVWRJZEl5VkMwVENObCtXOXNuUUNRc2w5Z0xPYjhyZ2d5d2FX?=
 =?utf-8?B?R1ZTWHlYanJQaHIvTndlclZOd2s2T3NBTkFtMTZ0eFJGWGU5OWxZZkJYcjN5?=
 =?utf-8?B?Kzk2TFFJL1VydlViRWQ2KzdsWlZXKzhYTDh5bCtqSWJscGpveVcwY2VFQTZK?=
 =?utf-8?B?Z1RUNk1idVpKZ2h0Ty9kcVN0ckxkZnBvdStFNElNcVZ3MkRYTmZwb0VsNzVP?=
 =?utf-8?B?cHYyRElPa3RCYU0vek5QanM2MlRVc094ZFZNRzlHNlliWXpORE0wL1VHZ3ZJ?=
 =?utf-8?B?UURrVDJjdDgrU29ZNnB6bFd5dHBKUHIzdWNXK1poMUhZaFBtZ2ovdXd6OXRu?=
 =?utf-8?B?cGVGUk43S0EwY05acFhkZXJGZGw4ZW0rd2prRUthS0lOYnd3UVlOWHNOd1hJ?=
 =?utf-8?B?Q2FzRWczUkxOL3pubjRRb09jNVN1RGhGeDdvZnp2SWNHOGVMcjUvQ2JSS3lz?=
 =?utf-8?Q?2TRs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:03:22.1904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d919ea-1faa-4c88-09a3-08de318a06ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

The comment for sdma_v7_1_inst_gfx_resume() did not include the
inst_mask parameter, even though the function takes it as an argument.

Update the comment to document inst_mask as the mask of SDMA engine
instances to be enabled.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c:644 function parameter 'inst_mask' not described in 'sdma_v7_1_inst_gfx_resume'

Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Le Ma <le.ma@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 89ce07ae18b4..f998edf52c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -635,7 +635,7 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
  * sdma_v7_1_inst_gfx_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
- * inst_mask: mask of dma engine instances to be enabled
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
-- 
2.34.1

