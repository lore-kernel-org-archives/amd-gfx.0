Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1337AC5474A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 03:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE8810E47E;
	Wed, 28 Aug 2024 03:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEHdH4po";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F0A10E47E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 03:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhdqDu/7PRYCwoOC4HoO5vjESjo0dqHpsX7e5RS2RUs3UoWEr5g/afvNXq7WXLF5eywD685LlVUCfV3bmVDDnRI4sNksErCZD+2IF5FvtMmj4bBKTxQ2oHJmdBQnITbJ9hHAPM2Va4v6CsEaZXgzx9jzLgQ+D1TQP2pzTeQ0Zfz2nCxjUwtCXlvZ/G4Wx6KlUiUdhW1nAtb7k8c46oHixQA+mAl3k5o5huBXucz0gI1VrBMXGTq9Xi1AujVKnBVJdgfgsrgWekaxyX+Olkc3pk0nS7bYeNs8/gAzShVZttLWTNvzySSQsdlkvHhjhASJvXLrkr9ezwo9VxwnDMoSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5VlaLzgTVjKgwMn2XTih6HhK4WRl1kabthPLeu7+iw=;
 b=eeaobmKZbsptDYDK/wM1dbMHX7FF3LkVOIvZrewUCuTPZmKrWl8NWcpIwBYYOwUf+3/C7kemG2gTxeUt/tLQ7nNRceJGNgQD+vjZ/Lh/v6Nr8M1qI3SmBLk/BYQNfcmLBnxP/OUEWry/i1bhUwhynUjs1zMLmHBMWBrd9F/Gi8d5z8UP2m5cMMa38Lgs+TV07bbkUr1UdHbCpHHzxEysCfFIOFDddVp3ptbrwtl4YSi067oD/mHoNkLQCyVipMJoPR7XKPwfpU2xgZzyURTmKNMSsAaTkxnkhYaFV6FjV9WjX0C5dY0Rz11INjtNDceQFb7gUmPgh26y5wBKuhcyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5VlaLzgTVjKgwMn2XTih6HhK4WRl1kabthPLeu7+iw=;
 b=LEHdH4poSBibA/yhONwrS+CSxpl48gcvcjSd2zr6mS27HPpJi7GzzmMoFdAUo82+jm2XwaXmqb5pWqnKlQcU5+sZYj4HbYoQGlCuGFuhXkl7pYsKD9HFF4OAnLxsqYDkJJx26cVNSj8LI/JKcF3Z3KMO4/GpI2FX97aF1Ajaklg=
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:11:05 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::e7) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Wed, 28 Aug 2024 03:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 03:11:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 22:09:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/amdgpu/: Add missing kdoc entry in
 amdgpu_vm_handle_fault function
Date: Wed, 28 Aug 2024 08:39:26 +0530
Message-ID: <20240828030926.4065919-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 792f1e41-f409-4b72-c36b-08dcc70f0e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QktXeUpIaVhEQzBoejBtc1FPYzNlY3JBeVY3Q3lZTVAxZHQ4ZlZPa3RhMkp5?=
 =?utf-8?B?UjY4UVl3N3p1UmYrN1VwcU16T2hYbDFvTXpHbld5QVNVQzQ2WDd1UU5jZVFy?=
 =?utf-8?B?ZC9PRkRFc3lTWDBta29EbTRlQzZOQXZIR2VBMzFjQ2pWY3VuaVNXRUVjd3NX?=
 =?utf-8?B?WE1HcWY3TFR0dnE4SmVkT3FHWGxPVzIwdnFBYWdXcWp1UnJiWllScDhMMTdO?=
 =?utf-8?B?STZTb0l0ZWU4UnIwN0gyQnV6UG1DWkF3aGVaWS84T2twcHVRVUtRNXdpK28v?=
 =?utf-8?B?bS94R3hmZWVJM0k3VDRYazY5NitRN1dtYlVNSTZWeCtrMlhXZ3NvbXJ0MWlF?=
 =?utf-8?B?SjI1NWNGczRrZzk3TTJOWjg1RE1CUUFOM0pKWFJZODVvenpaR1llcVZLRHUz?=
 =?utf-8?B?K2t6Q0paSHBVL1d4MHVqZGh0YWhuVkxSR250Vkd3R29wcEtKdHlSUXJ1cW85?=
 =?utf-8?B?ZjZ3ZHp4T0s2S0MrME9Ra3ZLOE16ZFRua2o0TE5pdmJVanNrcyt4ck1VTWZi?=
 =?utf-8?B?bnI2Q0VBbzFPSG9YY2g4SlJkdkdURW91cVpwZnM5dzVsVW5xc2swdVp4SVJI?=
 =?utf-8?B?K3VweWc4WGlWZVhySTBDL040N1RmSmljT2VNdkp3VDZNd2xaZkZTOU92UFVy?=
 =?utf-8?B?Mys1RkMyT3lFTVAyV3V5cUp2bTVxNkZsZzA5UkdmQjFYbCtaZ01PQXdpQzMw?=
 =?utf-8?B?Q1NJK1A3VXFibkJRa3MvN2JIcVhoTm5VNm1KUE9pSCtpRkVQSUpxQjRKUUgr?=
 =?utf-8?B?SzlSZzlvbVdWWFQ3S3BnVnVPZW5iOUlrN3RKSDQ3UGh5MXBmUkVrWEdmcWJH?=
 =?utf-8?B?aGtuMnM4NE1FeE15czE0a2FWb1FXUEdkblpvdWxCTkN1Y1I5UTBYY1dVL3FH?=
 =?utf-8?B?aTdPeVU5ZzV5Q3lUSjlIOVU2NWphUVZUQTJlTEs3Z2lpeDNHUDhWVk1KR3FH?=
 =?utf-8?B?K1Vod2NWSS93cHdGemNnbDRXWUs1VmV0TzZXS1pGTmtkbllJU052YVR2cmpk?=
 =?utf-8?B?WWtXZW9RbFBZTmNFaW5jdnI0WGJQS2pUNHozV0djQlpTTTFrTEMyNGxUWEN3?=
 =?utf-8?B?OGJLdC9USTJUS291ZExlbmFjWXhEWUladTJYdWxuN1R3cGVQZDA2RmpvREdj?=
 =?utf-8?B?SVFYckZTbHN0czEvMHhha1J5dWJCNGFCTXVUTDU0b1V6MXgvZTNDaE9UQXN1?=
 =?utf-8?B?QUVmZGVFY25PWXVlNTZxbjdhZ1FBM0RVMW9ZTi93YU9RYkd6OGxkTStnc1F1?=
 =?utf-8?B?RkxNdDRwa0RHMTVGS0FTYUV1a2xiN2ZMVVJWd2lNY25mb003cEtpdDQ5U3Ns?=
 =?utf-8?B?NXhrSC8zbUFKRUs5bXgydTVMc2MyTFhUdE1wN2JuUGhIOEFDVzdpdE5QRGVG?=
 =?utf-8?B?UTNaM0YvQXpieVljK2I5NUdzL3JOZ2Q4ZVRyaFZSSEFrb0Q2QU56M3NCeVBu?=
 =?utf-8?B?OWJQSEV2Wmdua0NZem83V3Q0cnM4amVFMVlkMVFsWGVHckdWVDRCNHBVNE90?=
 =?utf-8?B?Y0FiV3VIcDdBeDFzZGxMUFM3aUg5K3BWdUt3ZlBqeWJZdm5ydGk4cW94MUNw?=
 =?utf-8?B?WFFVbW1KQ3M2MVdDWmRkNDYzOE1LRDZ3dDY1MmVqWGlHMTNRbk1HamJsVFNN?=
 =?utf-8?B?aENpc2tXbnBLL0o2aHFHcmRBN2syeEM0NE1yemJ3bnlNVWQ0ZGJ6ei9XbjFQ?=
 =?utf-8?B?Um05QU9SK0NyRWtWd0M4SDQrY2lEWGtDOERabUI1SGFLcDZ2Y2FvZHNoczRp?=
 =?utf-8?B?NGwwZ1dlWXhJSndoREVYNDRjVkdKTzdqaFZWQm1ZWHliOXl5R1pGYS8zWkRY?=
 =?utf-8?B?K2h4L21zUnFmcjZGNW5JSFBJRGxjdjZJaTd5dmM0QWk5ZCsxMU9kUmVVYkJC?=
 =?utf-8?B?dU1xZm1EMm5sUHBJK2VBcXo0OTNuR0I4ejNCU09tZ293YVl2bnVHMHY5OHpZ?=
 =?utf-8?Q?rIYVc7ebD8Qady7BdksykHNtGQ3ShENp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:11:05.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f1e41-f409-4b72-c36b-08dcc70f0e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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

This commit adds a description for the 'ts' parameter in the
amdgpu_vm_handle_fault function's comment block.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2781: warning: Function parameter or struct member 'ts' not described in 'amdgpu_vm_handle_fault'

Cc: Xiaogang.Chen <Xiaogang.Chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408251419.vgZHg3GV-lkp@intel.com/
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: Added Reported-by (Xiaogang)

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ad2e469548c9..0fa165e8fb40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2766,6 +2766,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
+ * @ts: Timestamp of the fault
  * @vmid: VMID, only used for GFX 9.4.3.
  * @node_id: Node_id received in IH cookie. Only applicable for
  *           GFX 9.4.3.
-- 
2.34.1

