Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCB7C54E90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB3810EC26;
	Thu, 22 May 2025 10:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SHcGDTKQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F5F10EC26
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZBHvvKp2s2XOp2z3MSK06qHgPjE1Yjh7rwJ4njKX5nzNSGx5pO6dgI2KNmKoV3qNOaeoejk+Dnqgc62eJ6L6dXb6Hl2B9ZHfZVZuL7GCuTF5GC+9RgM3O6kDSTr1o38u0As0TL3e6SjxycUmR6danwP4OI7eyKo6coni6NmHB9OKlGcDy1FOW/Evatgpznnll54gH23mlAgE8q6aVW5GlsD1g141narGhETT5+2r77FQLwp+R4GF9Rx+oa5Bk+zxvy+NVvCXIcCgIEXigfCYxD7sAmavkxIeu9ECvU7xXwBcbLXbj+KZkpVp0SoTWN+mAbffJAsCeUW7cKwERFVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYJrwA/SpUbdtP/s1PgAPMPHkfYe1XIF8m+raYNy5mg=;
 b=cmCP3JNKIADANTipwrGWntxiSPe82W4kqYciiz48oxEj7SNtIrgViCY2Fpp8A2cZ6iEJQBUb1p+60Bmd8VS/RwqInrg0t+ox7kdkilcXjUzxIn3ezIHDuxj0ECZQD5xuxyvIC3h38wk6xn0/wQgfGeBR+dQx8JeqFbAZBPdA41O6JcUh7lmQ0n25o6AThNRoQGt5xML9Ik3xmHAKpKeyTijyJ9aMZL0WybsHONx3jsHfJuaqR/jSIQYEbZFTmtjJ7NNP5ohJ6WK+1IZ5F9FRJ8V1VRv7bxyTWNa9qitj14qwmk6Z+qQxN/ns2xTEqkqr9S6I4HrHM6sQz9UdrqeQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYJrwA/SpUbdtP/s1PgAPMPHkfYe1XIF8m+raYNy5mg=;
 b=SHcGDTKQ8rzMlZ1hb0/6J0NBi5ds+zBSf5Oq80eUeAoJdv5yMJyBGxWVVYUmxtBffX5d5aC2mjcqYrjcXfT2cnvEaW7CG1AAe2WNOKlvVed56vw1HNwz9N79pIJ/1AbkFDYlkalCat9I0Jm2BmkQ1d35dccItYop+TtUYhtwV20=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 10:41:01 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::22) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 22 May 2025 10:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:41:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:40:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:40:59 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:40:56 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v8 0/4] enable xgmi node migration support for hibernate on
 SRIOV
Date: Thu, 22 May 2025 18:40:44 +0800
Message-ID: <20250522104048.569456-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce5cedd-ff0d-4386-90af-08dd991d24a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXRLSWhkTUNBeTJQUUM1eVZIam1wM0NmRHRKS3ZmVGp0eVNvQ1grSEdCS3J3?=
 =?utf-8?B?ZEl2YnQxR24xNjNqNUUxRHlScWRucE85d0o0cFY3RWtPYlNkaXpESzU2a1ht?=
 =?utf-8?B?SVJPc1pJZXo5a1dWdnV0YXBzUlAxTTFrVllDUTZBcmh6dkphZll3VDAyYUZJ?=
 =?utf-8?B?S0hpcEV2ZWMxbURsZmhXMGlseWVjaTQ5ckJxaUxMempYWU9zNEp6K0oxU3Bq?=
 =?utf-8?B?ZUdQUTc0NHE5VlJvL1dXSDJIM3dKTWZyMWZLSG1tVUVsK29QZzJXd0NVYXMr?=
 =?utf-8?B?M1hnWGtrOU0yNUZmT0E2NXhsTHlnRWYvUjByRFRYTllTUlZPM0hyaWpUWk5a?=
 =?utf-8?B?eUNxRFZPUzV6dTQ3V3YxQ0ZhUXZNNXdVbGc2U0ZTRDFyY1NEbmF2YUlPUllq?=
 =?utf-8?B?QjdTci9UVnluY3EzOHBNVEhkTkdjNnEvbnRUaDBEdGw0Z0Jta1VuYWdqVG50?=
 =?utf-8?B?Wk1kaGtDa3hnczFhNUNtc1REcnhjdUhyUVB3UENpdFc4S25ZVnhIUXZnWUJU?=
 =?utf-8?B?Tm1ibURBcHRXUlhNTkgrUzVnSDg1NlZXbEZOTEE3OGFIWXhjeVljbWNkVnFi?=
 =?utf-8?B?L0gybmhwcy9JaU1BN0VTZVNGYlNaWERkVDl3eXAycmxqd3NRblM2UUN5Wit2?=
 =?utf-8?B?MVpVSG9mVXJIUTBac1BjckI1b3BjS24vL1I0M0JlbEtoSGhIMmZEc0Zla0oz?=
 =?utf-8?B?SUVDVFpPK1lJMnk0cDg1YWZsSDdmdFVnZ0RJc1pwZGVyRW42ZVc1cnI0dEZu?=
 =?utf-8?B?bWw0dXhCUHNrMTIwT0lsNWF0dnQ0ZFJxbHBOemFuZ0x6OHFyQkFibUpHSnF5?=
 =?utf-8?B?NEpSWVhtTmVIOG9vRmRkbEF4SWxxOWM0V2xVZmJCV1diait3VVgrZitDdGlH?=
 =?utf-8?B?aER4VUFqNnVmSisrWUNjZFpzbzc1STlLZFB2UEJTM2dxZkF4Z0U1NGJUVXZO?=
 =?utf-8?B?cTBmMXR4K25kWlQ3OHhsaU51TVZRU05KNWg2VFV5di94dUg3U2VnYXg1N3Z2?=
 =?utf-8?B?UEw3bVZ2WFRndFh2eUN3dVNad0NVN2JGNk5XVCtCTlg2Lyt4M3huYW1wazFn?=
 =?utf-8?B?MUhYMFJWWEl2TWFvZ2JFbXhaMFI3dWdRb2YvRmgyMldQY3pNL0hYbE5uNklB?=
 =?utf-8?B?cWhTNmlNbWNIVXVqSVFheWtqQ3AvN000ZGxKaHNHaDQ2YjJ5c3YxREYzNEdI?=
 =?utf-8?B?VE0vZ0QvYUFkV0FuTmgzVzVad2pYVWNWeEMybzNJMlFib0FQTGZWQ1R5ZmlW?=
 =?utf-8?B?aVRNdjFFU0tESDI4aWpXZm5rMXhKZFZaalZOZktLczZicWVTRFIrKzE2WkFr?=
 =?utf-8?B?cVIrV0hGMGRsNzBkYUN3TEZ2V0U4a0N4RW5rSlJEVDdPblpGRnlheGJPSmg2?=
 =?utf-8?B?aFN5ZFZJQTN3Skh5U2xyTE1wVTF3R1R6b3Y0Q3dhMXo4b1dBNytIbVkzTFZI?=
 =?utf-8?B?UE9ZRlk2b3NWUENLUkl3MmJkZlFWS3UwYlNybjJNNDM5djZMeFYxc2hGODhG?=
 =?utf-8?B?UlZWaTQyRHBydElmOGlPNHFKOG5qMEtKSUZIeDZkRWdoeURRS2Z3clFxbXNR?=
 =?utf-8?B?b1dGaG83bDRadEg0dlJmVjFLcHN6NjlWT1dDMFRQcWdhQmE0ejdYaEVyVS9T?=
 =?utf-8?B?eURpNzJSaDRPc0NqN2xReWtPZlhVa1pIVDBnTnhwdXFjVS8wZnJLL3VNT1l0?=
 =?utf-8?B?VHJtMEFucER4Q2FTY25qZlZ4enlyY3BQb1JoandFdU5tRGlKZmdvdlI4bUJX?=
 =?utf-8?B?VTdKWWVTTlcvOVVWdEQyY2l1Sy9WdnY1Ui81bFNQZVFsK2hmRjd5NStleHlk?=
 =?utf-8?B?a3E0T2hVN2hhTy8wSTFXM3Z5K2FObHNObEE0anhtY3hXVVAxeC9DWkV5YzJv?=
 =?utf-8?B?Z2FOazNhT0w2WkcwZjdCekgyWENReUNmRWJScVZmOTJyYmJodVl1OWFnd3Iy?=
 =?utf-8?B?aTFURThzazJvL2FFT1FPbGlqTnd5SE50dHFLTHFLYnE5U0JydlducUs0cm4y?=
 =?utf-8?B?WXRvbmx4N0ZGT0N4TG9UUFo4a0E0VE1ZVHR2S0RFSC9ka1QzMTh1c1c0M055?=
 =?utf-8?Q?Q7b7FC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:41:00.3150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce5cedd-ff0d-4386-90af-08dd991d24a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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

Samuel Zhang (4):
  drm/amdgpu: update xgmi info and vram_base_offset on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 28 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 13 +++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++
 13 files changed, 151 insertions(+), 17 deletions(-)

-- 
2.43.5

