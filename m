Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665CC54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B3F10E984;
	Thu, 22 May 2025 04:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="juBUJ41k";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BDC937B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIzlPn6QHKC95ZuRA/0hxkKliB1sNHVDHbaLK1wKGChng8VKi7t5y7FxAJF70QVDVAX4DkmXMJYKP173pf8EzCRfs2qQ3m8OoEvmC2Yk9AQlDcbFO1FFLQroTg1dSMZ92hhtmnJTmd2lmwWWlUtaKc1/H/gib6GSE+h5HDOsuHy30TwcESMbAcs9jUVQmyQCjSmKflCpsI15CQ646QAeHVOQVdoO3WheTahyKRYlnG8vzuzB6rJa+xSDJXyUBaOyQnhFZ956A8eAqekRbWJHw1klZP7sjYk+nyOvYMP2im3/PdSt2OVOrq/zSjvs7Feh8hovQBFUgkywTs2ci1Tndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ouwy+fMIq1su6+9zD5YHHT72e/hfs4K/NrcY91Q2ZC4=;
 b=BIKffxqVnsrLsIpc878N/fhFHcwzzBZzLwN7cVStBNOT+sSfRlStYk86xfVzYFgsACCiNwhc/NfCl9saKlRpdmOzojRRJKFvUG3ruIpKZOFUsodl/apQ3w4jgL1gyb2ROSVHh47uVLXRv5qX18xDKFdjWXfvMtW2kbKEgE9B2PjO71h9buZB2MIbj6fS2mFINOXiOoeONdBuCYLp0bK1aTiDhbwhfcjTeTgsFrPQQEpewGqaXM7YDLAsxRLTedKGs76+4f0yHZPgL2Nd5i97Uwojc1o4t+GAhYcQP/w8O0tB5XRH90mQ/XcZmGZKny05b1rkEIX68q7IlBCtg9peQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ouwy+fMIq1su6+9zD5YHHT72e/hfs4K/NrcY91Q2ZC4=;
 b=juBUJ41kxmmPrlaNwbZPC+iEZkMUBlAI+uFcv9cTdX9fbWjPXrQ5/p+axQHOUMIYoLU4ZpT1pZleNHiqhFqjBpIgA7K119RF+shDySLuqtLbNFBiIAr7Z9jH7T15p6kHVCUzk4giUXcPzKqfvNa38zQ+tFMVqGlKhDWlbypuX7E=
Received: from CH0PR13CA0050.namprd13.prod.outlook.com (2603:10b6:610:b2::25)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Thu, 22 May
 2025 03:44:49 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::88) by CH0PR13CA0050.outlook.office365.com
 (2603:10b6:610:b2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 22 May 2025 03:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 03:44:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:44:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:44:47 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 22:44:45 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v7 0/4] enable xgmi node migration support for hibernate on
 SRIOV.
Date: Thu, 22 May 2025 11:43:46 +0800
Message-ID: <20250522034350.433219-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3730084a-f5b1-4f94-652a-08dd98e30069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHY5NUNvTEl6dHNzT1lPY3p0cFNZRVpKbzNReEUwK20wMGVwalNnZVlSSUk4?=
 =?utf-8?B?RXdkMERPdVUwRVo2aTJNQWJHbGI5cnJONFN3ZFBVa1Q4WTBiT2dGNzdXK3NQ?=
 =?utf-8?B?ejE5VTlHalpWQ016ZUl3K0dzb0JpUVFNam9HRGVrQ1lTcWE3ZHBTclY0RHND?=
 =?utf-8?B?ckpjV1JQRnFWRHJ2RmdMREZVdXdzZy9tblVtMHN3VVdqS3A0bDdsMDBrcjBO?=
 =?utf-8?B?V3lUOGtDTVdRbWxoYnFhK3N5MjBiMi9rSXQ5SGtIZnN5eVZJOVU2ck1PUTRw?=
 =?utf-8?B?MjF0MEoxeEpXamZoQkp4OE1za1dubnhlcFBwaE1UTExUWUVuQWZ6RmJ0RlpP?=
 =?utf-8?B?c0cwNFA1aklxY05rYWZYMlFxeFpxN1RWeGlURDlhZ2NobFZxZ0YxbHgzU1di?=
 =?utf-8?B?cll3OXg0M3phaytBelVOcXJrRjk5N0I4Vk82VUdzcjRSUGFTSFNjMmNUQVV1?=
 =?utf-8?B?NmZKTmc1dHc5VXJsa0JCS1hSNitGZlJXcUlCdkIzdGJ2MWZkL1V0Y1dJbzRr?=
 =?utf-8?B?bFRrTUFZTWorbmRkemI1d1c1Wm1aTi9BaWludS9QL2wrZ1NVaW1ITnByaDVU?=
 =?utf-8?B?eVBqS2d1bUtTMk9yK09Fc2E4b1VlZTF6ZFQ3cFdIaFFlRFdLTVNKdjVmall4?=
 =?utf-8?B?b1FGTWRoM2xTN3VoQWZFaDRiSEdwT3orYmNmcTFCWTJOTmZpdGRuZk5UMnhO?=
 =?utf-8?B?RlRmTWVqUTZHOE9mdjVRWHRCWHJTSTBZL1AxN05DdmwyWjBxVHFrR2NoanJE?=
 =?utf-8?B?OEU3WWk0RGhTcVhpUFhpWm1RODhwbVdwR2wvNHVLNE9aUzVBTWJIVTVRcm5x?=
 =?utf-8?B?dGJTM0Z4ZkRwUURoVnovR3VScWNra2lRNWVnUlgveUFXMGtlaEdYZ1hlQUdj?=
 =?utf-8?B?UlljbllXemxWZTF1dngrTXBMRjZ6VUw1bUJ2VEZJdlBhb0xVV1Q2aE43Ulpt?=
 =?utf-8?B?NTNBek1kWXBJZldPQzRaZG5sWnNFTnNORWg5dzVXUGYrSFdDMjMxTGNXbUl3?=
 =?utf-8?B?ck5ZdWh0SkZtR0twbytRNjA1enZsR0owM1h5WURxTVVDOHYrVGl4QjdaUzhS?=
 =?utf-8?B?ajdtZjFIZzZHQ2pJVmRkam5HS3FzclQ0Z0d2RHl2MUdCd0doQ0d5MVBaMW5T?=
 =?utf-8?B?aTlWT2lxMENSVmpOYTJWWVNqTlRCRnFOM1lNM0M4NWF4RGNtdDJuLzZmY2tG?=
 =?utf-8?B?UnlPT01OcVp0WkNiSjNCVVNkaERjMmRKZ0d3QVhWdmJkZGtIMUpUbWhGekhU?=
 =?utf-8?B?bkxVL0NQNE1OWWVZUW5jMFNXaURaV0MwY29xQWFzZnFka25rYmpZMGdEaEhw?=
 =?utf-8?B?bThhRExWcS93WGwxeXErTERuWjEyM3Rtck1NSEU5MEQ5NkkwUkwzb3J5Nm1D?=
 =?utf-8?B?cFJJZU5OOEdmN0lOZ2htaDc1bC92dW0yVGExUzczelpPQU1va0wrajJ0YkFK?=
 =?utf-8?B?YVo4REFxajNMWTV2YmkwYitocEZpSU14QUlpd2t3NHV6Ri9tUVJFS3BNUHhn?=
 =?utf-8?B?MWwvUWwxUnRkSEViLzgrWThNVEFFcFNqUzRuS0VsVjRVNjc3QzNZM2F1WElT?=
 =?utf-8?B?eHRpTUxyWVVYeVBIVE9UcHhGOFdhTmFZemlDVUZjbWtTdEtPK2FTVTgzT2pq?=
 =?utf-8?B?RjhmbnBpaFhXcEhIYmdSNVFJRzIvSmpBQjFZTkF0UU5VNHJvQUVzOVZwUEpj?=
 =?utf-8?B?UlhXUE9JZmJzQ0xONUx4Z0lJdHM0TTIxVnYzOXRkbWNvRERld1JFZ2hudFl2?=
 =?utf-8?B?T295amRHT3I0SzZjY0t5Wnl1bTNhcC9Na2JFRm5LRzV1eTh6NGQzU2lyN0or?=
 =?utf-8?B?VnhWbTlsYlBIU2IvTUpLei94MlJkSndYenJHaE54Y2xyYUhaQ1RGRkUzNWVs?=
 =?utf-8?B?WFFxWGFwV0JST0tIRWJIVWRnc0lKYkptZEhIZlJ6cE9tZ0kyVVFzYUkyU1Nw?=
 =?utf-8?B?ci92NEY4Q0l6ZGJ2VGtjclpTNlh5dWtMWkFWZTNJZWpodjZ0SFR2bTRBeDdk?=
 =?utf-8?B?V1NsV2duTlFpeWNVSG9zMDdJTGtNZGJONGk2cm9CcDl1ZENzZzl0NDBvZGhD?=
 =?utf-8?Q?/Nc43c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 03:44:48.7818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3730084a-f5b1-4f94-652a-08dd98e30069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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

Samuel Zhang (4):
  drm/amdgpu: update xgmi info and vram_base_offset on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 23 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 13 +++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++
 12 files changed, 143 insertions(+), 8 deletions(-)

-- 
2.43.5

