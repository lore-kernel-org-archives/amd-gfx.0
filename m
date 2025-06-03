Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A9C5B549
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 02:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7816C10E0C4;
	Tue,  3 Jun 2025 02:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2qELO4Ll";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4485110E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 02:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5ZR/4MVgSXrOUTus3ii/d2QRropdE7cKP4FWJb+klmMJSxSuFq684kR97ad6v0e3Via+A6B3D7Q3HvO90z7+KRXKIAj/6ez5V5cELI29gcWncUXf9Ho2bRA5xV1PBY2IpBnP5vpZANtVNNzpRjfLBev91ercQRRDOsg0+zr/knDVyIzqg5X88nG+j6NcOdpA101kJdyyY4+EPxJURKcG69RnBTkyKVNP49LcRGF9HgMz57XQRrDFgJKJoOI5DJQoCxS8mzF1GEDsHcurLYTrjB+cCgbWRthjVil71qObFtk4Pl3a2b1h9EsV1y9NlreRVBmIlxM7kH3zFpieylbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt2UqxX9L5J8e6xJ1GBQ2Uf+D/AH0o2Bx/dgsTxr1UQ=;
 b=v0bUMynW7vxWiGU+64BIlwyObOe50d8Z0X+5l1quXf/GwYHq6FIoIbw6b+r8z2QMXLy0NmGhRT5xrYy6kxrC0lnQO4W/Z84+LHPNvlmkK6rnQFN4H6H5pQKYboyDciHWVrg6W0lUf1R4r9MqUlYmYa+tI4tBDfbupwtq8354/2dqs1vUm8V/Wh5AYZo24NeKkiFYz+JAbwDX82OUGW/VntxJXjXQ/Sy8wA+PCggPCXXW3TQYogu3ooIqdmZImbTa8AKLOvQPV3NyX4O/hzP9NnX4auv6mXVPAtFgpoRkDzuuZRdaIeDfT8yh1vo6ur2OicOWX75HHOt2Ki+3XprlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt2UqxX9L5J8e6xJ1GBQ2Uf+D/AH0o2Bx/dgsTxr1UQ=;
 b=2qELO4LllsfyBhuPwGxCL53LM65PUtHFp3bGRup/NuVGwBLoTUwKlbjujVlhWv8II0HeiWgN7C9F+5lNyvAxtTYZ/ssWJcCrYdkFWM2/ak9LO8SsHAnkJtyHbjCXSAcP4PJkO7vjA+rL53e1sTjvubvNZk6iWtJ3hOiTEoIGJ3U=
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 02:19:16 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::d0) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 3 Jun 2025 02:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 02:19:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:13 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 21:19:11 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v10 0/4] enable xgmi node migration support for hibernate on
 SRIOV
Date: Tue, 3 Jun 2025 10:19:05 +0800
Message-ID: <20250603021909.841690-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbaab89-e709-4c59-1c24-08dda2450995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2hjNnlYcnkyKzdYWUFEWnFMMHRNOHdKWWNPSVZsTC9vODloelAremJDOG5L?=
 =?utf-8?B?aXU3ckRIdWJvUjlPVmZRY1B2cGwrMXVQYTlHRm1xMlZxRmNmSUhlb2xqVlBZ?=
 =?utf-8?B?RTNTOGt4NDJaVUdFU3pJQVdRVHJ0OTVYZ0pCRGlpNFo0TWdwQVJ4V3BxM0Z1?=
 =?utf-8?B?MWZTWWdwS0tLOXR6UUJqK05iV085dHF5UUx3TVgwdTVrUExlbmplUWJqYUxU?=
 =?utf-8?B?bkJ3bW9ZZkVuTmFCWDlOZ0hNL21XMWUwalVkN0VodHROSHlwd1VIb0EzNHVu?=
 =?utf-8?B?OHV4UmdUZWZ4QU81TXpTeDA1TTVnS0VlbXpSMXM3MkYzRWUxa0h5d012QURJ?=
 =?utf-8?B?OUR3d01rOFIxak5wNE9jRi92dEZRYTA1bTZCL2NQOTFVZjZsVEZTOWprVzlh?=
 =?utf-8?B?cWZGbVlOZEtla3grb0dUNm1zRzJsSnFKdWtXWHRTWXkyWEFwR1krV0h3SVlI?=
 =?utf-8?B?VmxxTVUwL0pDZFpkYnNxbGwyb0VlK1duaWZDRWFrTms2eU9NditKdWdTM05M?=
 =?utf-8?B?MHBNaHZXNlpNRDNnUk5BeUFQb3R6VmI4TmV2OExxcEoxbzlVQVBldHpIaGxE?=
 =?utf-8?B?Mm5ITU5mZVZiWDFKYWpNZjRnbTczN3NXdFF1alJEci9WbjdwQStoM0ZiUTFy?=
 =?utf-8?B?bUszVzFINUJsMnBjeXF1NnNRVGdtSzNiS29vV05Udk9uR2V1d0U5OVFaMWo3?=
 =?utf-8?B?Z0FWL1pwTm12Q0dTWG9LK3lITWd6LzNaVUxwQ2Z0Z2t5NXZQclR6d0pHb0l1?=
 =?utf-8?B?dXN1WGQrZUJrZlhBVGFXQ1VpMjh2SHRHK1hzVVpodVN1a3ZUMXpQaHluc0RP?=
 =?utf-8?B?RG0vY3NQUzNYMklwMzhwbURleGdFMWVmSjc1Y21BL2l2WE9GVzZEUlVBeTJI?=
 =?utf-8?B?TjZMUzNDQjhpR2toQ3NQelJUNjBxS1NBeUJUTjF2RWtYb0E0V3RvY2ErMG5n?=
 =?utf-8?B?Zno2clY5N1l3ZzRUMVp5ems3SHVyQU9lUjBlbU91MnU2Mzd5T0hqejRPV0RO?=
 =?utf-8?B?NjVraDdaOGxwWE8wUWxUWFZzSzNOMzJYaGFObGk1TEMxQS9aR3hPbnFDVTJC?=
 =?utf-8?B?MFc5dXlqSmNSREdKc2lHdXdLVzNyRmxjYUc5QXdRWnpmNndkUU51QVdGL2VV?=
 =?utf-8?B?c0VBRXhMeERzT2ZJdXduZVVNL2FJMGg1SmRMSkxxU2VTZ25TalZqQk5HUkZP?=
 =?utf-8?B?SEJLWlFzd3RwR2VTUFdMWnFZTU9udHpzOWJEQUpSQzBTaTFRWXhUSzRqVFZM?=
 =?utf-8?B?NXNlek9Ybk4ydTdvR0VCQUZyWERhR2R3R28xNm4yTWRESjdXOVlieG9WVjl6?=
 =?utf-8?B?RzB6MVVUdlMyMm1EMFgrazVZaG1YR0EvYWlhWWFBdkp4ZkorbnhJTERBTjhQ?=
 =?utf-8?B?SzFody9vMFhIaEk4N0loNlRTZ0hXbEtwQ0ZMdGJycnAxR29XSmRnMUlsM2w4?=
 =?utf-8?B?ZloreG1IRWUzWUNPUElxTmRsSDFscUY4ZDZ0N1NiTUZwd2lmbll2ci9Sa2py?=
 =?utf-8?B?L3F3ZFF0MVExK2xadGlWUEcyekpLWitwVGNmc1NiLzBHZ2dGVUx1blVoVWRJ?=
 =?utf-8?B?WFJKbWt6UVRybWE5NlMwaVZGYUxYQ2NYeHVXWlJQNWZWZDNCaWV2Z2FDMFpx?=
 =?utf-8?B?MDdRbk1ybHpRQzd1QVlFSUkzVUJvc21XMFh6TUpwVVVDdFhHWXRQSkU1T2to?=
 =?utf-8?B?NFJGSFNMWTBPMlBtZThIeEVUS2RpSHlmSytHTzRBNngxR2JZZm5VOUpSSlJs?=
 =?utf-8?B?VkQ4R2pId3pwNW45R0dtZXgwQi9ScDBxMGJNcG1GQnZ1aUxJanRuMzlsM1FD?=
 =?utf-8?B?aFVndDZxUlVHNlZDdExoWFhrR1dFdjhaV1p2OXNPUjg2eCtwNDV5YkUzcm9O?=
 =?utf-8?B?blhlU0xoalhxR0czb09aM2VFVm1hRURHNmVVTkNYL1h2bUdLck0zQXZHWkMy?=
 =?utf-8?B?NU1sdHNmcktMdk00YThZZ0lOUU5oNFcvUmpQdGNOekE0TmNsL0RwR3hZaHFC?=
 =?utf-8?B?Qmc1WXhoL1pGbmhhbnJmY0xYN3dlZ0VHN0JtOXZFNEZNWkxyVTNQd0wzd0Z3?=
 =?utf-8?Q?Ahhgod?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 02:19:15.2423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbaab89-e709-4c59-1c24-08dda2450995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

On SRIOV and VM environment, customer may need to switch to new vGPU indexes after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` will change in this case, the FB aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all over the KMD codebase, updating each of them is error-prone and not acceptable.

The solution is to use pdb0 page table to cover both vram and gart memory and use pdb0 virtual gpu address instead. When gpu indexes change, the virtual gpu address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB aperture gpu address is used instead. They need to be updated when resume with changed vGPUs.
v2:
- remove physical_node_id_changed
- set vram_start to 0 to switch cached gpu addr to gart aperture
- cleanup pdb0 patch
v3:
- remove gmc_v9_0_init_sw_mem_ranges() call
- remove vram_offset memeber
- add 4 refactoring patch to remove cached gpu addr
- cleanup pdb0 patch
v4:
- remove gmc_v9_0_mc_init() call and `refresh` update.
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.
v5:
- add amdgpu_virt_xgmi_migrate_enabled() check
- move vram_base_offset update to pdb0 patch
- remove 4 refactoring patches to remove cached gpu addr
- add patch to fix IH not working issue when resume with new VF
v6: per Lijo feedback
- rename amdgpu_device_update_xgmi_info() to amdgpu_virt_resume()
- merge xgmi node and vram_base_offset update, IH fix into amdgpu_virt_resume()
- remove 2 unnecessary gpu addr update changes
v7: per Christian feedback
- remove pdb0_enabled and add gmc_v9_0_is_pdb0_enabled()
- remove amdgpu_gmc_vram_location() call in amdgpu_gmc_sysvm_location()
- remove check in mmhub_v1_8_get_fb_location() and update fb_start/fb_end on resume
v8:
- use cached fb_start in amdgpu_bo_fb_aper_addr()
- remove fb_start/fb_end update in amdgpu_virt_resume() and amdgpu_gmc_sysvm_location()
- use vram_start to set regVM_CONTEXT0_PAGE_TABLE_START_ADDR_*
- move check to the callsite of amdgpu_virt_resume()
- add gmc.xgmi.node_segment_size check in amdgpu_virt_xgmi_migrate_enabled()
- rename gmc_v9_0_is_pdb0_enabled() to amdgpu_gmc_is_pdb0_enabled()
v9:
- refine comment
- move amdgpu_gmc_is_pdb0_enabled to amdgpu_gmc.c
- refine coding style
v10:
- refine coding style

Samuel Zhang (4):
  drm/amdgpu: update xgmi info and vram_base_offset on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 33 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  8 ++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++
 14 files changed, 152 insertions(+), 17 deletions(-)

-- 
2.43.5

