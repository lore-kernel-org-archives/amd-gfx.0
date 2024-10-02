Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC01CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE0210E680;
	Wed,  2 Oct 2024 04:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g966bApQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFC310E680
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU/+Hd0hfuR/Zx5xehtLl3RmVBTK07m8Cq1aaU9EIriQbvWktAa3t/vUFLzOkyvAyOxvAX3FeNwvq6hm6cZx0tN6X/BGu1E+BAB9/F1D/cFxDxJTKPfhGMlZSDsMtJ2RXRtqlrzlDclG00fwKsua0QCJMA3taovUSA9zapqVi8QwpP4X5IayWmVk/UDQOsNzfiLc4crRq8EAQxvaxYy1OUeJrhB0p+YaKronrNo10TL4z5591esqxc78I1vXZnQgX39AqU8MKyOl9EW5fifdmtETvDljJ1WVsNPKYmoZ9rvLLlgOc1HznS3I+a1OolDzIfq2lH0lNKUITGxG793NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLlfGkuoSBu6QVhmxPnRazOmSpMcLbwhMIfGK7AUYOU=;
 b=ebBLTidgcQb9pVLFlRaq6SFtm29t+Pd/flm79d3+gp/dOOVA7xqZprzlPnKhDYx0/8S4TTIPTn0S1vTrt6ggTLkSXmqXAd4QxuFwFsFJW3oW8Ua3ROAqmQrQnUfFUMdYF4peR5UVoNLUhtrlPtVfy0ZXbhYC2iDVJ9DaQmFOVr1ilP+/ylL2cxOLolZ/Yr8vvOXjRngdBv3D29fBRZJHAM5I1N1LUpA9xs7p4x8o6i5OBQXtsdiQMGclZtoLOBDJVvKlIbNyyqWBhHPOPJWpgXC/TwIcuv0CmMHZdDG8zv5gI7vL+iPbFY/VBX1wkyCkXduKly7zv1IPGbes3834+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlfGkuoSBu6QVhmxPnRazOmSpMcLbwhMIfGK7AUYOU=;
 b=g966bApQaOFKqscthlhbmU9oR5Nf8o40sKchHmkO1monBJlhyAAmdGHreTercNjVBt3kYmllv+UqUCkCM6YLSFJwQS0dUxud4PG+6ZXUvAaod2yAffj8Oj2P/XCbETLA0CPkhtimEPxE38m2GOROZzU4rQh180oNumB9BpKVsKU=
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 04:38:29 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c6) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:36:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/18] Separating vcn power management by instance
Date: Wed, 2 Oct 2024 00:36:09 -0400
Message-ID: <20241002043627.102414-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 81402b84-5a11-49b0-fbcc-08dce29c0fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0lsbWV2bmo5Y1QvdG5zS3lKZ3R6S3QwdVNxVjJFZkpiNEsrbktCeXVlSFVl?=
 =?utf-8?B?elY1Ym8zVjdkM2dkM0hSb3JIalgwTi9Wdm14cW8vU3YyZGM0V25qbFAyaGhU?=
 =?utf-8?B?N2E2TDM1c2JtVktvM0xnVEpvbnVuQkFST2ZEZzBDcVk5anhwbllueW5hdlZi?=
 =?utf-8?B?SVBGendDby8vaGZpM21iU2IwZWd1c2p3a0FKZzVsWUNmWkVqeks3aDg3YTYy?=
 =?utf-8?B?QzlGWnlZcVFqaG9sb2xTMUpqTUtoNzVBN0JlOFI3eUYvVTZCUlRwbUZ3aVpH?=
 =?utf-8?B?M3BVS2VSOC8wWDFpNnM2MHd3aFBEMkp1U3RlQVQ4ck5WUnduV1N2UkRjQmFF?=
 =?utf-8?B?dnBPM1NpTWxtZFJGNWhEL3JvSTlRTmhqWnFZWjFuUks5TExOSUJFTWZCMklB?=
 =?utf-8?B?N25Galc2cG5VUTVld3M1eFJYUzAzamd1ekZGK0J4elFjZjA1bVpncUQybkNm?=
 =?utf-8?B?R2phbVN3c0x0MVE0NUhTUHMzaTQ0UjVQaS9NTExVMklaMmExV2VPQ2tPcjl4?=
 =?utf-8?B?dXpXZWozMUUyK2I1azU4UG5BMkdLZkQ5M3k2Ukh1SWx5VGdIeml6aXhLTjZ4?=
 =?utf-8?B?aXl6dWM5Y1RQUndtUUMvdFVMa2xhdkkwY2N4eDhmdjVYTmZYemgySll3QXVq?=
 =?utf-8?B?UUN4MnBQUTA1RVQ1N2xLTmxZNjVWVWw4cG13VDZnbEh3Q1R3ZU9PQ1gxYUtW?=
 =?utf-8?B?TWNQWVFQbEFrdENlRUNSSHlsV1lMMThkVmJvdHJTY0J5UWpLWTZoSnN1NFQ4?=
 =?utf-8?B?WXpEeXhVa1pYMXAxeUpNNUN2M2FFejgvOGJUcFNzUndMWC9CMituQnJuSEdw?=
 =?utf-8?B?U0NVVXFCWGtyZXV0NG5RWGFlSGNONUlKRUZoYmdVNHQ3eFhnQUhHbDZjeDUy?=
 =?utf-8?B?K1FCKy9KTVFsVk1keDdXVTVXT1F6VFFsanZwdkRSMFJaMzJ5SnBvYWgxQ0ZY?=
 =?utf-8?B?OHh3dTlob3BldW9ZaWdab2IvMzRUdGppY2RrbDdidVd6NmVZcUhLeWJ3NUtv?=
 =?utf-8?B?V0dLU0xVT25HQnpmNG9GbW9OVGlUb01oMVJ5aHgyUXJ1YVM3TVRCbURiaUgr?=
 =?utf-8?B?WWx4Y1IrWVdLMGU4T1FweEZWZFlZeUF1RzBRWmRmQmZWUmNGeTJJUU1uekdC?=
 =?utf-8?B?Sng0MVU3NHBjMHh2cVBncmM2SmNYZFR4MzRZOXBCNGNUaHBMcmc5SFVhMmZ4?=
 =?utf-8?B?ODNuTlkyc1QzcWhmeGJJVGIyVndVUTVQNE9reWM1aVFaU21uWDFsTzZqOTh4?=
 =?utf-8?B?RDd3eDdCTGpwZ1VzalkzOUlTeEd6MlZxd3JhTVR6RDJ6QVdUNThKVjZJdlBL?=
 =?utf-8?B?dDFxb0RVT3hsSDZVdXFrRnJMOUlNY1dmYnExNER5ZlB5QUtHZ1JNaUxJS3Bs?=
 =?utf-8?B?c0tEbndkS0VUVnR2ZHd0eTlON0g4anF2U2hkSDZGWUNxekw3UUU0R2kxMjJh?=
 =?utf-8?B?aGZ4QWFZbnRkU2NnenNnSWdVUTBmMGNRRFppY3FSTjZYMUxLSHFKK2FJbjRh?=
 =?utf-8?B?M3FheVBuTGNXWmNROVJFSThhTVM4OWtQNGRDVzZyd0NxZUN5QUh1ejN3ais5?=
 =?utf-8?B?RWV3NFdoSGprZlhiV2lJRUVXMXNqMzVCTnMyWXNkK0E0RDRPMHl6amtZTXZL?=
 =?utf-8?B?SklxdFJSM3JuakFDcThLS0w3blJmdVBYSVh1bXVnaDUwUHJvVFJCMTdUNUVK?=
 =?utf-8?B?cFBjd0RRMmlESWFlK3lJQ3h6T3oxRUpjMEVoUkpYTlBPSDB0TW9oRzhMZURi?=
 =?utf-8?B?YWt6YUNvb2ZMcjRsUmlpK0RzdGJEZUF2MzhueHp2WS9wenNHRTJsakhZc0Mv?=
 =?utf-8?Q?gVgXKfL+kZFI5OO9G93ubW+4uGtbQeR0xfL8Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:28.5246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81402b84-5a11-49b0-fbcc-08dce29c0fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Previously, all vcn instance will be powered on/off at the same time
even only one of the instance requests power status change. This patch set
enables vcn to ONLY power on/off the instance that requires power status
change. Other vcn instances will remain the original power status.

Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.

Patch 7 is VCN change to separate gating status for each VCN instance.

Patch 8 is VCN change to handle idle work separately for each VCN instance.

Patch 9 is to pass ip_block in set_powergating_state() callback function.
Suggested-by Christian König.

Patch 10 is to track VCN instance in VCN ip_block.
Suggested-by Christian König and Alex Deucher.

Patch 11 is to set_powergating_state by instance in amdgpu_device.

Patch 12-17 are to handle ip callback functions separately for each
VCN instance, so that only the given instance will be powered on/off.

Patch 18 is to set powergating state by VCN instance in amdgpu_vcn.

Boyuan Zhang (18):
  drm/amd/pm: add new vcn enable function pointer
  drm/amd/pm: enable vcn by instance for smu v13
  drm/amd/pm: enable vcn by instance for smu v14
  drm/amd/pm: enable vcn by instance for smu 11
  drm/amd/pm: set vcn enable by instance
  drm/amd/pm: set powergating by smu by instance
  drm/amdgpu/vcn: separate gating state by instance
  drm/amdgpu/vcn: separate idle work by instance
  drm/amdgpu: pass ip_block in set_powergating_state
  drm/amdgpu: add ip block with instance
  drm/amdgpu: add set_powergating_state_instance
  drm/amdgpu: power vcn 2_5 by instance
  drm/amdgpu: power vcn 3_0 by instance
  drm/amdgpu: power vcn 4_0 by instance
  drm/amdgpu: power vcn 4_0_3 by instance
  drm/amdgpu: power vcn 4_0_5 by instance
  drm/amdgpu: power vcn 5_0_0 by instance
  drm/amdgpu: set powergating state by vcn instance

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  80 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  82 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  29 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  18 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 580 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 605 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 531 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 486 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 538 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 448 +++++++------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  67 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 138 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  10 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  24 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  21 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  40 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |   2 +-
 101 files changed, 2132 insertions(+), 1871 deletions(-)

-- 
2.34.1

