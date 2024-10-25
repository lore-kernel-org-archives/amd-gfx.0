Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D743AD1039E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3335F10E9D6;
	Fri, 25 Oct 2024 02:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbGJUtEL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE9E10E9D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLJX7VLm55Mxrrxk7ekUkRbDge9yuqIGF4+L/56U+XPIDqsaEZp8EcYF3J+3t43NkrSMOaFSzgZd+5KJkOZiA2KD1KcwjwPJEp/S6b6VAZvNoW/TihxH0K43SPqMsBn2A9qrEv7zPxLeVFtNy5Js59EAVsdBmsBA1GTjj+ldITt9tKCikTlMrxo4hi6pcq0sQ5q9A9+2TA2M8K1xYJAg7g0VIuikzl4OJ8stxPA+8RHFTEYAjKSWr1lUvALYE57k1wr8aVPjipQyv0RUj1mVTHNju61Im1PxipuHXVgoz19Hb7VZdTef7JAqp2fgBLTGVPS6ZUu03Pl1MEksOSaWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdShwrGdC2uKPu3xoFpEJKkVsYrUCiJRZ7O0uTasb44=;
 b=UqjcOMf2bh5RrmJfFReYHlVVfNxJiB0b4gk0S8xHdIFhp652L1KgjZuEb4t6Um/v/7a13y/VwmXQCKBJwT6ZLrqqdEfKtZkhP2GbnPT1NZgxfBAiynWdHjMY3Tbur6HRNtEAp+68bupmi3EJggWm1SQNlRj/3KWdTjROysoQp5+wwouIEJIxq6+gskqDVxJKpylmH8wNPwb9l4tSF86hvPy2/LhTVTcW1B1EWf6PzvXtjMAmgsXDMe1knV2kKc/ROupsY0cSqm4u2IMG2oMaLxEd/xDb6WkoK798Bat/yfM7daOUn+z+Y+k0bXuzkQosmbbqgBXuEv3F4FV20lpKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdShwrGdC2uKPu3xoFpEJKkVsYrUCiJRZ7O0uTasb44=;
 b=WbGJUtELFw5uyHC7oXnJQ10GJ3Ap6ML/YMAx+uE67L1+64NFrbAOZXv56GTqi503VhlucjXNEDlj0Uia2KDGcxdWN6HQ+gjkjgvnMJARqqSu7LSSy59e9jW6XJ0lNWd5s4uB3Cq3ZpgZqT1a3ianaO3ge+ZM6bsJwa3LlBpHJ1k=
Received: from CY5PR15CA0170.namprd15.prod.outlook.com (2603:10b6:930:81::9)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 25 Oct
 2024 02:36:11 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::e4) by CY5PR15CA0170.outlook.office365.com
 (2603:10b6:930:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:06 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 07/29] drm/amdgpu: pass ip_block in set_powergating_state
Date: Thu, 24 Oct 2024 22:35:23 -0400
Message-ID: <20241025023545.465886-8-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b93d81e-4d3f-4a0e-a18f-08dcf49dc9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlRNNXYwaEpWVmtxU3lBRU9TYzg4OFRKWENMM1NqaW9MOUtZeXNPNXlnN045?=
 =?utf-8?B?M2IycHpaMWRlNUtuV1B5TUVyc3RoOXV2MVl5bDhnbEVqOU9FNXptd3FGUFoy?=
 =?utf-8?B?V0l5ZzBTdENPTnFmNVdQdDF1Q1RwS2NmNm9lelQrUFRNRDdnT2ZpMUVGVWhy?=
 =?utf-8?B?cHZKSzlZUXpadnlHeTcvZW9mYkh3c3NrL1Z3R1FoYlZ3SGcvUGFkNFVLaTJh?=
 =?utf-8?B?MnBYektNL3RVTzFCRThnSWpzQlE5SDdmK1NhRDVtZDdiMVFINkR4NEtCQ3Nu?=
 =?utf-8?B?eE9wOGVaTEt4ZkYxSDJDaElnT1FIUTVhUEJNMWMyak9PQTNnV3NVYXhjdFhN?=
 =?utf-8?B?akhUVkN6MzN2WVEvN3JucDJZQmlFK3JJRjd1bG03WlkyOVFPNzRRQjB5clNQ?=
 =?utf-8?B?NTRqUkpmeUFRbndPUmMwM2t2YXVYcTRkSjhKVi8xditoVWVrU3lzL0hGaVcv?=
 =?utf-8?B?ZVdwOSsrbnpTUFdlZlB6ak5JWjZnNVd5VHRmVkNZYlJwM3BBcDNsTHh4VzB6?=
 =?utf-8?B?NnhJTFFkb3JTVjRFNEE4Zk5jMVMzOWsybDZnU2ZBRHFYYmhSODdOSHhIK01O?=
 =?utf-8?B?WkQ5NmgyNUl6b0lsWStsYkRWTDFhVWdIS0ZhSml5TVJXTWN2S3pGdUlwLzh0?=
 =?utf-8?B?SklTN2xZWVk4eS8yUWtQNjdKWitrWDlQaW1xYWd4c09JUVpOeTdxNVlFSlJD?=
 =?utf-8?B?UFIxUm0zbUhFemQ3TVhzdHNUQmtzZEQ2d2tiTW1zOURYSnVLY2hQamxUNUkr?=
 =?utf-8?B?NFZ2ZDR2WmNtcEFWMWlsdmxoUElUK0JJa2tLUTlHV0JKN3dpL3JJeE5ydVlk?=
 =?utf-8?B?Y2h1YWQ2dk1MY1BzUWVVUEh5UExRQUIycVBGaGN1ZjlJWTNsTVRkQ3cvZGFH?=
 =?utf-8?B?a0JQWHZkZy9mWmlvLzhjbG42YkYxblFJMDd6eVMzSUJMZlhLa1ZqVjloNXFu?=
 =?utf-8?B?WVBJNjZwYkZTekgvMUJ2akxZdU4rM1B3TGFPNHp4RmZzcTZ6aXVPRXlTTlE2?=
 =?utf-8?B?NFZzckpCTmZjajJQcFdoUnZDeUh5ckVtbTRlVWJjMkdvTVBQcWxZTmY0eGNR?=
 =?utf-8?B?N0pBZks5dkhweG5Kb1BCMmdPODRGRngrOVA4UzdIWGxlL2xCVEJwN2tqT241?=
 =?utf-8?B?Qm9qNi9Qb2hUbTYzSHN5RTlObUdwSDE3YTdyU0YzeExPMWJRZnVGamhqRTFN?=
 =?utf-8?B?eTNoMVhLSlVMc0ZRWGdLVEhiSDc0YkNnVmhzY3NFTjJvaVhZb1pZc29iVkVI?=
 =?utf-8?B?ZTBmTmwwUDV4VDUxSStYNWVBb1NPU25lSFRRS0E3ZzJnaEh1SnRQdGVremVM?=
 =?utf-8?B?ZUU0Y29SYndqaWE5Yy9zZ0dHK0VPYzU0RjRLRzJWMmQ3VXBQWk45SmdxUXFV?=
 =?utf-8?B?Y3AwZnE0QjJhTWYrU0tDTitkQW10dWU0bGpYWndJN2trVmY4QnNxWFpBSXBK?=
 =?utf-8?B?RGZTVDlmcmVKeXhDUUorSGtyMXpLZmVzdzBnbzVYOHFIdlo3NUk4QjN2ZHVL?=
 =?utf-8?B?Q1FpdmxNeTk2TmFJTGpkL1ZYcXdyL0V1b3N0elR5b2piMEgycUdaQ3RhVCsr?=
 =?utf-8?B?bWVQR2hiYmFJbyswSzNVdjA4ejNBTU5uQVNERDFjR1dwSjNEWjVqTm1sb1hH?=
 =?utf-8?B?SEZ4ek8wMkdmY3BSN3VLeXhLSTVneXpidnl1NEVtZk92c09ua3FKRWpnS0Nz?=
 =?utf-8?B?QWN0RXhEeGxMeWowcnZNZEU4WUVqWC9nZFc4Z1NIUzhDMzFpVzZXT3BOd1A0?=
 =?utf-8?B?aUt5dTN4MHFZcGlMbi9tSWt3UEcveGxUbmQyNEtJUFY5bGM0YjlTankxWUJq?=
 =?utf-8?B?d1JUYmdoTkoxZkhUSzVlS01Lc1pxT3dGYkJoT1N0VEJuRXVmWUVzbFpNWDFX?=
 =?utf-8?B?OUVZempGV0RySUxqWjBvL2x0bGUxeXRXTWVMSmROenIrRmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:10.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b93d81e-4d3f-4a0e-a18f-08dcf49dc9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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

Pass ip_block instead of adev in set_powergating_state callback function.
Modify set_powergating_state ip functions for all correspoding ip blocks.

v2: fix a ip block index error.

v3: remove type casting

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                   |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
 82 files changed, 162 insertions(+), 156 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 769200cda626..cdea150c801e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -590,10 +590,10 @@ static int acp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int acp_set_powergating_state(void *handle,
+static int acp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b545940e512b..b4d494e003b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -724,7 +724,9 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		/* Disable GFXOFF and PG. Temporary workaround
 		 * to fix some compute applications issue on GFX9.
 		 */
-		adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergating_state((void *)adev, state);
+		struct amdgpu_ip_block *gfx_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+		if (gfx_block != NULL)
+			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
 	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2924fa15b74b..2f31a6bf9ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2190,7 +2190,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
-			(void *)adev, state);
+			&adev->ip_blocks[i], state);
 		if (r)
 			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
@@ -3165,7 +3165,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
 			/* enable powergating to save power */
-			r = adev->ip_blocks[i].version->funcs->set_powergating_state((void *)adev,
+			r = adev->ip_blocks[i].version->funcs->set_powergating_state(&adev->ip_blocks[i],
 											state);
 			if (r) {
 				DRM_ERROR("set_powergating_state(gate) of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 263ce1811cc8..bc3b5bfc3423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -134,7 +134,7 @@ static int isp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int isp_set_powergating_state(void *handle,
+static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index abd5e980c9c7..14ff69ea2d88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3818,7 +3818,7 @@ static int psp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int psp_set_powergating_state(void *handle,
+static int psp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 8bf28d336807..1bd804a8fdb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -638,7 +638,7 @@ static int amdgpu_vkms_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int amdgpu_vkms_set_powergating_state(void *handle,
+static int amdgpu_vkms_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 46713a158d90..17cd1d66a056 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -644,10 +644,10 @@ static int vpe_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vpe_set_powergating_state(void *handle,
+static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 
 	if (!adev->pm.dpm_enabled)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index e2cb1f080e88..b5055181b050 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2167,7 +2167,7 @@ static int cik_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_common_set_powergating_state(void *handle,
+static int cik_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 1da17755ad53..c49482793c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -408,7 +408,7 @@ static int cik_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_ih_set_powergating_state(void *handle,
+static int cik_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ede1a028d48d..8da334c71419 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1204,7 +1204,7 @@ static int cik_sdma_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_sdma_set_powergating_state(void *handle,
+static int cik_sdma_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index d72973bd570d..67554e322386 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -405,7 +405,7 @@ static int cz_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cz_ih_set_powergating_state(void *handle,
+static int cz_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	// TODO
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..cd874f9e9a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3308,7 +3308,7 @@ static int dce_v10_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v10_0_set_powergating_state(void *handle,
+static int dce_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..ec908b524f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3440,7 +3440,7 @@ static int dce_v11_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v11_0_set_powergating_state(void *handle,
+static int dce_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..ee7b69a63f17 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -3130,7 +3130,7 @@ static int dce_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v6_0_set_powergating_state(void *handle,
+static int dce_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..cc4f986bd533 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3218,7 +3218,7 @@ static int dce_v8_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v8_0_set_powergating_state(void *handle,
+static int dce_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..2a7a77317d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3673,7 +3673,7 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid);
 
-static int gfx_v10_0_set_powergating_state(void *handle,
+static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -7451,7 +7451,7 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	 * otherwise the gfxoff disallowing will be failed to set.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
-		gfx_v10_0_set_powergating_state(ip_block->adev, AMD_PG_STATE_UNGATE);
+		gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -8339,10 +8339,10 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
-static int gfx_v10_0_set_powergating_state(void *handle,
+static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..3e9b6b88b6a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5430,10 +5430,10 @@ static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
-static int gfx_v11_0_set_powergating_state(void *handle,
+static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..94459162803c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3858,10 +3858,10 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *adev, bool enable)
 }
 #endif
 
-static int gfx_v12_0_set_powergating_state(void *handle,
+static int gfx_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 41f50bf380c4..2e1e8a49c66e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3395,11 +3395,11 @@ static int gfx_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gfx_v6_0_set_powergating_state(void *handle,
+static int gfx_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 824d5913103b..0124f86f8e63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4869,11 +4869,11 @@ static int gfx_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gfx_v7_0_set_powergating_state(void *handle,
+static int gfx_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9f5a5b2e6de6..f85e545653c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5360,10 +5360,10 @@ static void cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
 	}
 }
 
-static int gfx_v8_0_set_powergating_state(void *handle,
+static int gfx_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 66947850d7e4..c6f6907eb363 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5226,10 +5226,10 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
-static int gfx_v9_0_set_powergating_state(void *handle,
+static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..d61f53921723 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2756,7 +2756,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
 	.is_rlcg_access_range = gfx_v9_4_3_is_rlcg_access_range,
 };
 
-static int gfx_v9_4_3_set_powergating_state(void *handle,
+static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 697599c46240..738226310690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1131,7 +1131,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u64 *flags)
 		athub_v2_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v10_0_set_powergating_state(void *handle,
+static int gmc_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f893ab4c14df..b73cd4f9df48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -1018,7 +1018,7 @@ static void gmc_v11_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v3_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v11_0_set_powergating_state(void *handle,
+static int gmc_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index d22b027fd0bb..0ed26d24fc9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1002,7 +1002,7 @@ static void gmc_v12_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v4_1_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v12_0_set_powergating_state(void *handle,
+static int gmc_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca000b3d1afc..8575b0219e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1100,7 +1100,7 @@ static int gmc_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v6_0_set_powergating_state(void *handle,
+static int gmc_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 07f45f1a503a..3025ac476b52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1327,7 +1327,7 @@ static int gmc_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v7_0_set_powergating_state(void *handle,
+static int gmc_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 12d5967ecd45..20a6d6e192eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1679,7 +1679,7 @@ static int gmc_v8_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v8_0_set_powergating_state(void *handle,
+static int gmc_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f43ded8a0aab..c4918154580a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2562,7 +2562,7 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v1_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v9_0_set_powergating_state(void *handle,
+static int gmc_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 7f45e93c0397..be3a578596ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -398,7 +398,7 @@ static int iceland_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int iceland_ih_set_powergating_state(void *handle,
+static int iceland_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 38f953fd65d9..b004dc88cbb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -756,10 +756,10 @@ static void ih_v6_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v6_0_set_powergating_state(void *handle,
+static int ih_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 61381e0c3795..27d9d4965757 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -737,10 +737,10 @@ static void ih_v6_1_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v6_1_set_powergating_state(void *handle,
+static int ih_v6_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index d2428cf5d385..d37f5a813007 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -727,10 +727,10 @@ static void ih_v7_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v7_0_set_powergating_state(void *handle,
+static int ih_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index d6823fb45d32..38938a624658 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -35,7 +35,7 @@
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v2_0_set_powergating_state(void *handle,
+static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -154,7 +154,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
-		jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -692,10 +692,10 @@ static int jpeg_v2_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v2_0_set_powergating_state(void *handle,
+static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (state == adev->jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5063a38801d6..a0c0e8bd5978 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -38,7 +38,7 @@
 
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v2_5_set_powergating_state(void *handle,
+static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -219,7 +219,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
-			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			jpeg_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
 			amdgpu_irq_put(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
@@ -541,10 +541,10 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v2_5_set_powergating_state(void *handle,
+static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (state == adev->jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 10adbb7cbf53..057e0c043de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -36,7 +36,7 @@
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v3_0_set_powergating_state(void *handle,
+static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -168,7 +168,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
-		jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -483,10 +483,10 @@ static int jpeg_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v3_0_set_powergating_state(void *handle,
+static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if(state == adev->jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 89953c0f5f1f..7a79fac9962c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -39,7 +39,7 @@
 static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_set_powergating_state(void *handle,
+static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -199,7 +199,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-			jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			jpeg_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
 		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
@@ -645,10 +645,10 @@ static int jpeg_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_set_powergating_state(void *handle,
+static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 6917e4a8e96a..30ab807be2bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -43,7 +43,7 @@ enum jpeg_engin_status {
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_3_set_powergating_state(void *handle,
+static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
@@ -371,7 +371,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
-			ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			ret = jpeg_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
 	return ret;
@@ -960,10 +960,10 @@ static int jpeg_v4_0_3_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_3_set_powergating_state(void *handle,
+static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index f3cce523f3cb..2b25e8f71f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -48,7 +48,7 @@
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_5_set_powergating_state(void *handle,
+static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
@@ -228,7 +228,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			    RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS))
-				jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				jpeg_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 	return 0;
@@ -676,10 +676,10 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_5_set_powergating_state(void *handle,
+static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 06840d1dae79..c870f1a361ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -36,7 +36,7 @@
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v5_0_0_set_powergating_state(void *handle,
+static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -165,7 +165,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-		jpeg_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -570,10 +570,10 @@ static int jpeg_v5_0_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v5_0_0_set_powergating_state(void *handle,
+static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (state == adev->jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 0820ed62e2e8..f51b5dae3701 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -677,7 +677,7 @@ static int navi10_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int navi10_ih_set_powergating_state(void *handle,
+static int navi10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6b72169be8f8..5332e510bced 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1070,7 +1070,7 @@ static int nv_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int nv_common_set_powergating_state(void *handle,
+static int nv_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	/* TODO */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 7948d74f8722..0c32e614d8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1087,7 +1087,7 @@ static int sdma_v2_4_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v2_4_set_powergating_state(void *handle,
+static int sdma_v2_4_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 9a3d729545a7..18f29e2be828 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1506,7 +1506,7 @@ static int sdma_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v3_0_set_powergating_state(void *handle,
+static int sdma_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3f5959557727..a2f5f2be699b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2312,10 +2312,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v4_0_set_powergating_state(void *handle,
+static int sdma_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..95d5de2bd186 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1830,7 +1830,7 @@ static int sdma_v4_4_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v4_4_2_set_powergating_state(void *handle,
+static int sdma_v4_4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d31c4860933f..9ee5318be89e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1859,7 +1859,7 @@ static int sdma_v5_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v5_0_set_powergating_state(void *handle,
+static int sdma_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ffa8c62ac101..bd883a35c7eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1818,7 +1818,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v5_2_set_powergating_state(void *handle,
+static int sdma_v5_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 234483d346f8..34106702e0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1594,7 +1594,7 @@ static int sdma_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v6_0_set_powergating_state(void *handle,
+static int sdma_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d2ce6b6a7ff6..1a5fc7bc7289 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1530,7 +1530,7 @@ static int sdma_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v7_0_set_powergating_state(void *handle,
+static int sdma_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 00f63d3fbea7..e32615630cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2655,7 +2655,7 @@ static int si_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_common_set_powergating_state(void *handle,
+static int si_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 47647a6083e8..4b278904cfd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -672,12 +672,12 @@ static int si_dma_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_dma_set_powergating_state(void *handle,
+static int si_dma_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	u32 tmp;
 
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	WREG32(DMA_PGFSM_WRITE,  0x00002000);
 	WREG32(DMA_PGFSM_CONFIG, 0x100010ff);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 2ec1ebe4db11..ec756d24aaa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -269,7 +269,7 @@ static int si_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_ih_set_powergating_state(void *handle,
+static int si_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 93e44e7ee3fa..8c100db42d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1473,7 +1473,7 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 		adev->df.funcs->get_clockgating_state(adev, flags);
 }
 
-static int soc15_common_set_powergating_state(void *handle,
+static int soc15_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	/* todo */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1c07ebdc0d1f..7556055b8387 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -953,10 +953,10 @@ static int soc21_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int soc21_common_set_powergating_state(void *handle,
+static int soc21_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
 	case IP_VERSION(6, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 3af10ef4b793..2a408bc65f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -542,10 +542,10 @@ static int soc24_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int soc24_common_set_powergating_state(void *handle,
+static int soc24_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
 	case IP_VERSION(7, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 5a04a6770138..7c02eb0e1540 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -454,7 +454,7 @@ static int tonga_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int tonga_ih_set_powergating_state(void *handle,
+static int tonga_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index bdbca25d80c4..c66fe0c8d5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -796,7 +796,7 @@ static int uvd_v3_1_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v3_1_set_powergating_state(void *handle,
+static int uvd_v3_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index a836dc9cfcad..1f3da607c0d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -714,7 +714,7 @@ static int uvd_v4_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v4_2_set_powergating_state(void *handle,
+static int uvd_v4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -724,7 +724,7 @@ static int uvd_v4_2_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_PG_STATE_GATE) {
 		uvd_v4_2_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index ab55fae3569e..50577cc79dcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -817,7 +817,7 @@ static int uvd_v5_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v5_0_set_powergating_state(void *handle,
+static int uvd_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -827,7 +827,7 @@ static int uvd_v5_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
 	if (state == AMD_PG_STATE_GATE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 39f8c3d3a135..4f5dc46802e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1476,7 +1476,7 @@ static int uvd_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v6_0_set_powergating_state(void *handle,
+static int uvd_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -1486,7 +1486,7 @@ static int uvd_v6_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
 	WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c1ed91b39415..552866990db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -596,7 +596,7 @@ static int vce_v2_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v2_0_set_powergating_state(void *handle,
+static int vce_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -606,7 +606,7 @@ static int vce_v2_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		return vce_v2_0_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6bb318a06f19..6f4a2476b9fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -801,7 +801,7 @@ static int vce_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v3_0_set_powergating_state(void *handle,
+static int vce_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -811,7 +811,7 @@ static int vce_v3_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
 	if (state == AMD_PG_STATE_GATE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 79ee555768a5..04bfa3b59f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -691,7 +691,7 @@ static int vce_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v4_0_set_powergating_state(void *handle,
+static int vce_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -701,7 +701,7 @@ static int vce_v4_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		return vce_v4_0_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 7ad2ab3affe4..32b0159953f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -85,7 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 
@@ -281,7 +282,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
-		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1799,7 +1800,7 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
 	}
 }
 
-static int vcn_v1_0_set_powergating_state(void *handle,
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
@@ -1810,7 +1811,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == adev->vcn.cur_state)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f34cab96d0b4..798d06563c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -92,7 +92,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_0_set_powergating_state(void *handle,
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
@@ -318,7 +318,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
-		vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1796,7 +1796,7 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 
-static int vcn_v2_0_set_powergating_state(void *handle,
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
@@ -1807,7 +1807,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index beab2c24042d..d00406e057d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,7 +95,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_5_set_powergating_state(void *handle,
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
@@ -399,7 +399,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
@@ -1825,10 +1825,10 @@ static int vcn_v2_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(void *handle,
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6d047257490c..d761bc7c31bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,7 +105,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v3_0_set_powergating_state(void *handle,
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
@@ -430,9 +430,9 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -2159,10 +2159,10 @@ static int vcn_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(void *handle,
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b836b4935e2..8c1d9afa81ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,7 +96,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_set_powergating_state(void *handle,
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
@@ -357,9 +357,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 			continue;
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-                        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-                        vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2037,9 +2037,10 @@ static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_sta
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 868302d63a4b..4ac6ee75b27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,7 +87,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_3_set_powergating_state(void *handle,
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -319,7 +319,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1623,10 +1623,10 @@ static int vcn_v4_0_3_set_clockgating_state(void *handle,
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_3_set_powergating_state(void *handle,
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f0ec8bc031c6..13c0fc9f9894 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,7 +95,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_5_set_powergating_state(void *handle,
+static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -309,7 +309,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1531,9 +1531,10 @@ static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_s
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+		enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (state == adev->vcn.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9f89e152e875..9d16747484c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,7 +78,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_0_set_powergating_state(void *handle,
+static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -273,7 +273,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1258,9 +1258,10 @@ static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_s
  *
  * Set VCN block powergating state
  */
-static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+		enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	if (state == adev->vcn.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 0fedadd0a6a4..039f1ae2df02 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -616,7 +616,7 @@ static int vega10_ih_set_clockgating_state(void *handle,
 
 }
 
-static int vega10_ih_set_powergating_state(void *handle,
+static int vega10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 1c9aff742e43..a8e88c9f6ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -708,7 +708,7 @@ static int vega20_ih_set_clockgating_state(void *handle,
 
 }
 
-static int vega20_ih_set_powergating_state(void *handle,
+static int vega20_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b3fa54c0514e..471a66dad9b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1988,7 +1988,7 @@ static int vi_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vi_common_set_powergating_state(void *handle,
+static int vi_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bbfc47f6595f..fbdfe37cb93e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -961,7 +961,7 @@ static int dm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dm_set_powergating_state(void *handle,
+static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 7eefcb0f5070..0f20abbfd381 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -403,7 +403,7 @@ struct amd_ip_funcs {
 	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
-	int (*set_powergating_state)(void *handle,
+	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
 	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index f0f81ecd9ad6..bb8b0799ab7c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3183,7 +3183,7 @@ static int kv_dpm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int kv_dpm_set_powergating_state(void *handle,
+static int kv_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ee23a0f897c5..ed8f755e9ff6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7855,7 +7855,7 @@ static int si_dpm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_dpm_set_powergating_state(void *handle,
+static int si_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 90500b419d60..a3d1c5aa3b3e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -244,7 +244,7 @@ static bool pp_is_idle(void *handle)
 	return false;
 }
 
-static int pp_set_powergating_state(void *handle,
+static int pp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c5ef8806dbb3..8d07757adf04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2198,7 +2198,7 @@ static int smu_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int smu_set_powergating_state(void *handle,
+static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
-- 
2.34.1

