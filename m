Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1287D0E6F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F77F10E40F;
	Tue, 25 Nov 2025 15:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xwnptxx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7185910E40F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcjN4i3Bq2T5npPMM7VgasnPA8PNLMmBWPBFygrkOci993OE0GBhRb8zSUPwMfL+FIu1Jg+ebiOJv6JORTZBLl4uKQHXCUiyE7QfvYdVyRu4M0JrFjrxFlBbBCkcDuZg2Xik0q4Q+X15vDB4n3Wl+qVcaJxbxUnlYHjEymQaB3VXpY53VlIaH+NjSTonaWrad6oLmortwEipBRAD5EfrO++v1dcCSFeYSSyvWIDVWln2B/XZzHY/elXor2b1dk8Y3qxJ3MVuqbKF77vXQPH+xgnF7UQAqw/r3u5XUkfSJhiy0FX9DIYz/CNKIoR4fjTSWGk7DX0uoW5L1sh7ir12CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5W8adVD+n+9YCsvXBKv5TJ6qQEU9lorIaKtqSS1+38=;
 b=FMBIj48qHyk9u5+w1iPzk7kSfSu1Rv0mfl4G1RT4E2v0W/yMbVry4eOPRYBDQ2Wsitd55nSnuReZ2RjuLbRR3bc+bX+9V05WY9s7HcM8HDoVz8jAvfoUiC4d8fk4bYAx0GlVgIRXrpd/CGIr9KJV0OIAq1IpLz3VPQvYH5WBI9QXLu16gvlETDHyEZRllpz2iu0MD4QTAbkeFd/z6TcZBYQGilQ1UHJ7rP+O2ZinULhysqlQ8Go2qSGcceHU6WaQkK4ZFxg51GmcysjF4O4zXi0uPwYMvcF/gXDviTxwC7A6Kpmc/agRtXoLeOoBYhLRg630OPtCF9tXv+D7fSaMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5W8adVD+n+9YCsvXBKv5TJ6qQEU9lorIaKtqSS1+38=;
 b=2xwnptxxYUCCmJ7oYtg6JnRGgNQCevpe43rVKqcKXVjOW1uE28CBrCIlwRddeR9eflEoMchEqTWswi8rJXk6L7E7NA53R6mbmqN2m9VyM60XXYes64bspBKbYXZIKjjYHDwTyAZqRWnxo8GUNh3EldsvamOIi6XpninLJmGFsko=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:56:59 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::e1) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 15:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 15:56:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 25 Nov 2025 09:56:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/sdma6: Update gfx11.0.3 SDMA FW version to
 include UMQ protected-fence fix
Date: Tue, 25 Nov 2025 21:26:48 +0530
Message-ID: <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
References: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ab4c1c-6fe2-4158-c59f-08de2c3b43de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnJBSGlWdTZ3akd3TmFqRjdiTVk5OUh4bzZNTk0zSWNEMWY4SlVrY0VTb21o?=
 =?utf-8?B?ZWpLMEVjWFFVZTdFMzdVbTdCcVMzVGRzWHFxL1drdjQzaHJjU01ZblVYTDJU?=
 =?utf-8?B?cDY3Sk1GaWlkZkMwM3QveVR2bThjOERBOVFTOExCKy9ENEVJZ1BzdGFYRkdI?=
 =?utf-8?B?M2JIbDFYQlVaWU1lYXFHYXNsN2k2Y0c2K1BOV3ZjdnQ5QVZldFdmSzZETktr?=
 =?utf-8?B?Q040T3Z5NHhab09LU3N5OVNEd081VTkwUnBqNEZ2M3FiRWsyTjRtdU1DOXU3?=
 =?utf-8?B?VmdtaWQwSmVDaFhLS1pNMWtBNVdQTjRWUS8rdDR6c09wd3JJSkJCdHNBQVZS?=
 =?utf-8?B?ak5abmI1emI5bTl0bWY3cU1Lc1pSWTZjWHl3dzZ4Sjg3bGlCaVdrdThVR1pP?=
 =?utf-8?B?VkU0OU5iVE94VHR5Qnp5WVFTUkFVeWZZRWdKMEVkQjJQdC9neGk2ZWd6bzNk?=
 =?utf-8?B?RmgzWXg0QVlxdDZOeEdNbUJ0cG1ycGlnRHhzMDFTeTIwSGljREk5VFhPQTBi?=
 =?utf-8?B?YkVwWnVDTTNlLzJTdEMySUpVek4rcTQwSSswcENhTjZmazk1cEJYdlpwY05s?=
 =?utf-8?B?eHRneHNYTy9rc2JnNlRrLzlTNUNrQ1VBK3hwSFlyRmUwdHUraGsxVW5Bem0v?=
 =?utf-8?B?ZW5zdU10TTYwVzZBc1NEazJheFFTWCtWM0ZGeWhTQjVnMHlqa1d4eWsvYVgw?=
 =?utf-8?B?WXN6bTZxYld4cnpuZ01jdEFiQ1duUG13K0JyL0tBdENSTUM4SS9jcXNJaWlL?=
 =?utf-8?B?OXF1WVZjUmNCL2hMMGVrYXRBdjl5VWZuTVVYZmNxcFgrRmc0ZW45MjljNWM2?=
 =?utf-8?B?V0VHWVNYeis3M0JHQjgwYktPMEtIUEU1STF6TXM4Z2lDVlhsV3dQaDVoQ0l1?=
 =?utf-8?B?NkFLVzA0RDBFNmo2SFZZdXYzR3ZTM1I2Z3BDUEROQjlMek1iajV1aUF4Yi9s?=
 =?utf-8?B?RUZRalVONm9rVTB4T3dRM0lVQXo4Zi9wcUlMdFQwTkRIZUZkT1lGT2p2eHMz?=
 =?utf-8?B?bGpIZ0VYZzRDbDExU29UUTJLd2FNbTZVQnVZNFZjNXVkOG05b1pDNVJlUDEw?=
 =?utf-8?B?ejJ1bTMxS3cyUU4xZm5oSmRvWWg2aWJWRFJVQS9WUVhvRW1TV3EwTFJQbldz?=
 =?utf-8?B?NEh4SExxenFLYVJjRUU2VGV5cXc0cm0zQUNCZHhOdGJZN0ZLZ0NUcGtYS3cv?=
 =?utf-8?B?bm9WU0IwNWhNSDQ3UjNXWEJrZDdlcDdrbVNDV1JBb2lReG42dzBaaDlRTVkw?=
 =?utf-8?B?cUhVeG9XeENER0NlVTJZZ1JJcHVBWEdGTGNTOXVWL1NvNFpRci9YSUJMSmNH?=
 =?utf-8?B?eDM3U1MxUisxckJIU3JpTXhzN1ptdkQxUWd0SEtzT0pvUkNYVUJYQlBQSkwx?=
 =?utf-8?B?N2dCc2txUkhzbGl5eUxNRzlwa3E3R2lnaVJKamtLTHRGcHU5TDhyeEh1ZkJK?=
 =?utf-8?B?eEVLL0VIdndwQ1BPcmZqYXE1ckNTOWpxRXdQcFFYbHgxR0syeFJDNmluYVlL?=
 =?utf-8?B?NndLcDBuQ1dtZlBlV0QyQTdhazh6eGM1Y2lUOGpwVTVxUU9lcm1tcEFUZEtN?=
 =?utf-8?B?VXZKazI4K0dmWXJVZHRhR1pZc2hOVUk3V3c2WjI2b0JJV29ueEY0VzhlYkVy?=
 =?utf-8?B?R1VycldpSTFFejBnb3JYVHZ1TGJzR1J1OHRwUUpEbFVlKzZWZ0NaSTJsVnA2?=
 =?utf-8?B?K0ZzQ2lKcUhjTDdzbFpJOFQrUWZONGJFSFFKTkVQQmRQQXdndGFEV1BqSGFt?=
 =?utf-8?B?WTNwTkxFUXBLR3BQK1hwL3kvNWFrc0tuN3BvWkVuNXVPMG9pN3FRL0dmNmlD?=
 =?utf-8?B?enhldFNLcy9tUWU2VEx0TnNDV0xnRTZ3UDFPSlNiYm8xYUZTZUhUcGRDdlFy?=
 =?utf-8?B?SFN0bzJzb0xYSTg3N3I4WXBnbk51MUZXSGRHNW5vaENCY3l0NExUTlJWUlpZ?=
 =?utf-8?B?YStOK3NWTHZSUXBJSEJEbW0rbnk3TFh0RTdqK0xRQjROT1dhWUVvZHg3emtM?=
 =?utf-8?B?Um9xTlRudTRmTEVPbjh4b0dJd1JTVEVOYW5WelBmaUhoR3BZaTRzUkUxamEy?=
 =?utf-8?B?MHJWWHN4cUdYL3ExSHBwV2NrM09wN2gxT215d3dMY1ArcVE5aS83blI1S2Vh?=
 =?utf-8?Q?a7b8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:56:58.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ab4c1c-6fe2-4158-c59f-08de2c3b43de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

On GFX11.0.3, earlier SDMA firmware versions issue the
PROTECTED_FENCE write from the user VMID (e.g. VMID 8) instead of
VMID 0. This causes a GPU VM protection fault when SDMA tries to
write the secure fence location, as seen in the UMQ SDMA test
(cs-sdma-with-IP-DMA-UMQ)

Fixes the below GPU page fault:
[  514.037189] amdgpu 0000:0b:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:8 pasid:32770)
[  514.037199] amdgpu 0000:0b:00.0: amdgpu:  Process  pid 0 thread  pid 0
[  514.037205] amdgpu 0000:0b:00.0: amdgpu:   in page starting at address 0x00007fff00409000 from client 10
[  514.037212] amdgpu 0000:0b:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00841A51
[  514.037217] amdgpu 0000:0b:00.0: amdgpu:      Faulty UTCL2 client ID: SDMA0 (0xd)
[  514.037223] amdgpu 0000:0b:00.0: amdgpu:      MORE_FAULTS: 0x1
[  514.037227] amdgpu 0000:0b:00.0: amdgpu:      WALKER_ERROR: 0x0
[  514.037232] amdgpu 0000:0b:00.0: amdgpu:      PERMISSION_FAULTS: 0x5
[  514.037236] amdgpu 0000:0b:00.0: amdgpu:      MAPPING_ERROR: 0x0
[  514.037241] amdgpu 0000:0b:00.0: amdgpu:      RW: 0x1

v2: Updated commit message

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index e3f725bc2f29..4996d60751ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1390,7 +1390,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
+		if (adev->sdma.instance[0].fw_version >= 29 && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 0):
-- 
2.34.1

