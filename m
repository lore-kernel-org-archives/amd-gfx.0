Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9DD3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B92310E6BF;
	Tue, 29 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNTMszoC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF83010E6BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTPLtosedE8Jdh8R12xejt2InQbdg4Wgff34FsPl+43vhbI0P2ivolqC2O7Uh/WW9aZrnhjFutBcsPI5NZg4lfhK56iZ8DWwIIXwOL7GNbVv/0d9bSQ5HABzkb2I43ZrHK8iKCXF/dNn1dI+0a2n2shk/EOmx4DG2Dh9zrda9GSW1EJlX1WlQn/lnyH8r4UtpXONqjwQ5tBTNa2PL8E8TShy6CsFqGIyHkRwkMENdb8BFID1B921oPA7+2LDP9BPlkMySonU+TtD+vR5jFkBmbZizVt9rnOlU+yD8d3VebL/mYDlo3Gyk2jJoDOdUDbGF00juaV1vo/Zz9OP1emVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wACe1PWmlEjCD2zBINwMF0TaEY3Sed1gL9ESoJmZrpk=;
 b=AYR3kXlQ9JQoC3peJeKprhUh26Dj1+qXEWSGx4ZPLjEuhbXoe7uVNc/Er7skazTTx5GDqi9HGKkX7aSypbGvpavVqMFm/zY/C10skkAmbezcKm1/CkjdR0ZzG0pwdmSwRvDp9tpWeAukfd+0M809GTeRKpoYquKljsDDWu3ykC8cs2ZH7pNAMqb9HsFsAgwJd9XyJPXldgDXh2KIgH4XzuDp5nD4HhUwELHQm/uOeFsZbikZ+WDSm1QNF+8c0KcBdojCixoq3vNeMz8bFzyouNCSlacuV3617JR+WZNDDo7l/MEkGIbT5cokyLT5e6dn8gar2BTwKKuyuec17RwcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wACe1PWmlEjCD2zBINwMF0TaEY3Sed1gL9ESoJmZrpk=;
 b=hNTMszoCPvOEeFib1F2NuBXQAi1q4vvVJZdiBxBroPuTcnlskd53ULnYzo/8FdNt7j6mEvL9oCmQoLbwgVR8UtNufXUJgkLg4R9hUtgUv+1sXjN1ql3YCAMR5QOdTc2oxRTw8H+6985RFuXwQRnYAp46UmDFOgY/KDkbAnPpD58=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 17:42:59 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::d4) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:57 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:55 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 08/29] drm/amdgpu: pass ip_block in set_clockgating_state
Date: Tue, 29 Oct 2024 13:42:19 -0400
Message-ID: <20241029174240.682928-9-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 555b68a2-94fa-4b14-348e-08dcf8412034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEdRM0ZuSkM0S3ZuUE9YSVJBZzRjN0p0U09tZGlGeWRjb3MvNzI2NWdOaFI0?=
 =?utf-8?B?MlgrcEVXUEdOOXh2Z3huNmREc21YSEU2dkdUai81eFZvTmZzWXpGYUVNQjFG?=
 =?utf-8?B?cVpVLzR3a1dCVExlNXlEdE5MZ1lVeXNXeFcwdCs0QTRVVGpOMXVDbmxiREZx?=
 =?utf-8?B?TU04RzRiZjZsMGM1RnhoNmpqaS9NaFoybXprRlI0dkdRcGVqMTNGWXc0SXUy?=
 =?utf-8?B?UWxKVmQ0RjJrTFpWdXhhQXd4UXhsb3RSbzRpT1BBZCtZSjVxK240aENvaThM?=
 =?utf-8?B?TVlXMWp5dzhHeDJsdkRWdHgxTFY5NkgxeURDNklvdE5PSWEvREFqNUlqMVA1?=
 =?utf-8?B?ZXV4WXFuaUpIbHhNZXQrQ1FSZDI2QnBrK1IrYmFsVVFZUDNpSm1ROVVXdnJC?=
 =?utf-8?B?UnJlZmE1Q3hxdW9RR1B1WlQrRjQzMllCaVZwRW5lN2hOV1U4U2xGQy9pZmRL?=
 =?utf-8?B?d2loZ3JpMGM1UXJzRmlwc1lqM2pPaGN2Z3YxSjNBbGJpYVVzcnNRR2tXVFI1?=
 =?utf-8?B?QUtxckc1VzhmbVVvQzNEM3hkS3Jib3FaZVNhNVhjRjBlV1d0V0RXV3pVZFdk?=
 =?utf-8?B?c1pRcDZFZFNkK3JhdjQ2UUN1bHFNV3lBTi9KQ0FzVUk3UXh5Y0ZnNEdmaVVG?=
 =?utf-8?B?US9sc3FkUThFTkNlSVZYRHUreHhEV3FycWlSUHArdUhNQWQ2c1RNbGlJUmNU?=
 =?utf-8?B?a01nVVFaL00xYzdlTFpCY09yTmhYM2xzUmZwZ2VsVk93RUh2NlF5VmZDOGhJ?=
 =?utf-8?B?UUdkaURuci9ucDltbkNkb3hYMFNMc0QwR0VqbHo4eUtiMmR2L2x3SWJVQzI4?=
 =?utf-8?B?STRpMkxDSjdxRnloYlZMS2x2OVFEaER0cHNZRzNQRkh3QTk2ZlRTM3BWTzRa?=
 =?utf-8?B?QkhpRjBIN1djdUFPMG1ocTNCaVU3bUk1V3BZRENMZGZQbkkxUXZQSHN3dlRW?=
 =?utf-8?B?SHVTbDhFMGRvNDEzN0JiM21iWGFtTXlTVHJPYmhCUmNRNnE2a2E1TGpOUEdo?=
 =?utf-8?B?NmlPaE43dUZ3SVNSTi9oNnBkZ0ZCVWNXSEpGYWxQbG85SmN4Q0tuTEh1V3Bz?=
 =?utf-8?B?cFZlMStQVVN4cTRBcmNCME9jNU83aVhoaHJsbnY2QlJMQnlBZmpyeFhCcmFh?=
 =?utf-8?B?QkpwREZaeTRrc1RtWFR5UEFudjl2cU1wL2o2bWtjZ3pya3NvR1VvcEZNRkUy?=
 =?utf-8?B?R0FwVG5wTDNVNDN3cjNXdytHcm1Qa05udzg0d2tVL2w5ZXRTbHNwN2E0dVZQ?=
 =?utf-8?B?b29KWUhFUFRZMWdVcmt2V1dIemhEZG51Mmh3ak5ZZkw3VmpEdWUvMUZROFFU?=
 =?utf-8?B?c0Vtamt2azhMMmRTRnBZb3ZrTkwxMDI3ZzhsUko2WFh4eG1PcWtuNlprd0sw?=
 =?utf-8?B?MmVwWXVsUWxpZSt0M0pSQWNRY0FJdXZBUExicUVlV2U3S1FSTTFQMXBCYUJp?=
 =?utf-8?B?RkZqdGpReVNjUHRPcDZ5MnF4Yy9iRHhvdnY3a0V3RnUwZmVJTVFNbk9kdUY4?=
 =?utf-8?B?TDJkbjd0akc5VjR3TXlMSGZpRXpiWmRYdFhTR2IxcG5YMFA0bTdtdWxCTklo?=
 =?utf-8?B?TjdxcTAxQ0RNVDdvVldyN0lPbkhVRS9WU2xKZk52b0x3RjNNSXE3ejZwRmxZ?=
 =?utf-8?B?NkJ2bE1iMVpQZWpuWU9LUERKOUpGb1VOQnJPSENJdzBhNEVidXJZNGp6UVZ5?=
 =?utf-8?B?VVVTd25DVXNhQ3gxWXZCd2h1dUF1VC9NMjZFRjJGenk0Rm9vaEp1dlVPZWkr?=
 =?utf-8?B?SGh1NDRzOTkwaVhjNEV2am0zdWpueGhuMjl3MWkvaE5NdlBHVHpEUkVnWVlj?=
 =?utf-8?B?dWwzUmJjR2lmNUphbjJCZFpmT0pGa3N5UUU2bWVWTUE1NzJsVVhXOTBGVVgv?=
 =?utf-8?B?dUl1Wm5KaHBRRjNFeGU5a21Tc3J5bk5LR3ljQXIvRE05L3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:57.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555b68a2-94fa-4b14-348e-08dcf8412034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

Pass ip_block instead of adev in set_clockgating_state() callback
functions. Modify set_clockgating_state()for all correspoding ip blocks.

v2: remove all changes for is_idle(), remove type casting

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nv.c                   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vi.c                   |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
 82 files changed, 158 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index cdea150c801e..deb0785350e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -584,7 +584,7 @@ static bool acp_is_idle(void *handle)
 	return true;
 }
 
-static int acp_set_clockgating_state(void *handle,
+static int acp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index be0245c9d792..74711e6ba88b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2156,7 +2156,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
-			(void *)adev, state);
+			&adev->ip_blocks[i], state);
 		if (r)
 			DRM_ERROR("set_clockgating_state of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
@@ -3128,7 +3128,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_clockgating_state) {
 			/* enable clockgating to save power */
-			r = adev->ip_blocks[i].version->funcs->set_clockgating_state((void *)adev,
+			r = adev->ip_blocks[i].version->funcs->set_clockgating_state(&adev->ip_blocks[i],
 										     state);
 			if (r) {
 				DRM_ERROR("set_clockgating_state(gate) of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index bc3b5bfc3423..d52f18393970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -128,7 +128,7 @@ static bool isp_is_idle(void *handle)
 	return true;
 }
 
-static int isp_set_clockgating_state(void *handle,
+static int isp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4843382390a8..25ca6fcd4788 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3846,7 +3846,7 @@ int psp_config_sq_perfmon(struct psp_context *psp,
 	return ret;
 }
 
-static int psp_set_clockgating_state(void *handle,
+static int psp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 1bd804a8fdb5..03308261f894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -632,7 +632,7 @@ static bool amdgpu_vkms_is_idle(void *handle)
 	return true;
 }
 
-static int amdgpu_vkms_set_clockgating_state(void *handle,
+static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 17cd1d66a056..0a884215f59b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -638,7 +638,7 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int vpe_set_clockgating_state(void *handle,
+static int vpe_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index b5055181b050..08d6787893b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2161,7 +2161,7 @@ static int cik_common_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_set_clockgating_state(void *handle,
+static int cik_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index c49482793c12..444563486769 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -402,7 +402,7 @@ static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_ih_set_clockgating_state(void *handle,
+static int cik_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 8da334c71419..1563e35da0fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1189,11 +1189,11 @@ static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int cik_sdma_set_clockgating_state(void *handle,
+static int cik_sdma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 67554e322386..82586b76aeda 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -398,7 +398,7 @@ static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cz_ih_set_clockgating_state(void *handle,
+static int cz_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	// TODO
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index cd874f9e9a70..8bc997b66424 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3302,7 +3302,7 @@ static int dce_v10_0_hpd_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v10_0_set_clockgating_state(void *handle,
+static int dce_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index ec908b524f61..504939e3c0c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3434,7 +3434,7 @@ static int dce_v11_0_hpd_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v11_0_set_clockgating_state(void *handle,
+static int dce_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index ee7b69a63f17..a33e33743a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -3124,7 +3124,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 
 }
 
-static int dce_v6_0_set_clockgating_state(void *handle,
+static int dce_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index cc4f986bd533..aff58d56864a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3212,7 +3212,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
 
 }
 
-static int dce_v8_0_set_clockgating_state(void *handle,
+static int dce_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2a7a77317d90..a2ae696e552f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8377,10 +8377,10 @@ static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v10_0_set_clockgating_state(void *handle,
+static int gfx_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3e9b6b88b6a7..875900f5a9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5466,10 +5466,10 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v11_0_set_clockgating_state(void *handle,
+static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 	        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 94459162803c..99bdc4ef51df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4109,10 +4109,10 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v12_0_set_clockgating_state(void *handle,
+static int gfx_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 2e1e8a49c66e..81c185a8b3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3373,11 +3373,11 @@ static int gfx_v6_0_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v6_0_set_clockgating_state(void *handle,
+static int gfx_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0124f86f8e63..60931396f76b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4846,11 +4846,11 @@ static int gfx_v7_0_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v7_0_set_clockgating_state(void *handle,
+static int gfx_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f85e545653c7..955359fffb64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5975,10 +5975,10 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v8_0_set_clockgating_state(void *handle,
+static int gfx_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bdf1f831c670..551cbf514470 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5271,10 +5271,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v9_0_set_clockgating_state(void *handle,
+static int gfx_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d61f53921723..4184521b2642 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2762,10 +2762,10 @@ static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v9_4_3_set_clockgating_state(void *handle,
+static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 738226310690..9bedca9a79c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1088,11 +1088,11 @@ static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v10_0_set_clockgating_state(void *handle,
+static int gmc_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * The issue mmhub can't disconnect from DF with MMHUB clock gating being disabled
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index b73cd4f9df48..72751ab4c766 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -996,11 +996,11 @@ static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v11_0_set_clockgating_state(void *handle,
+static int gmc_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = adev->mmhub.funcs->set_clockgating(adev, state);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0ed26d24fc9b..621769255ffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -980,11 +980,11 @@ static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v12_0_set_clockgating_state(void *handle,
+static int gmc_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = adev->mmhub.funcs->set_clockgating(adev, state);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8575b0219e8d..8e878ab44e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1094,7 +1094,7 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v6_0_set_clockgating_state(void *handle,
+static int gmc_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 3025ac476b52..8f6f2f067641 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1307,11 +1307,11 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v7_0_set_clockgating_state(void *handle,
+static int gmc_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 20a6d6e192eb..29ce36038b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1658,10 +1658,10 @@ static void fiji_update_mc_light_sleep(struct amdgpu_device *adev,
 	}
 }
 
-static int gmc_v8_0_set_clockgating_state(void *handle,
+static int gmc_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c4918154580a..31cdc624f096 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2541,10 +2541,10 @@ static int gmc_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v9_0_set_clockgating_state(void *handle,
+static int gmc_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->set_clockgating(adev, state);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index be3a578596ae..8ac3d3282268 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -392,7 +392,7 @@ static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int iceland_ih_set_clockgating_state(void *handle,
+static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b004dc88cbb0..f8a485164437 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -693,10 +693,10 @@ static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int ih_v6_0_set_clockgating_state(void *handle,
+static int ih_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	ih_v6_0_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 27d9d4965757..dd0042efceec 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -674,10 +674,10 @@ static void ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
 	return;
 }
 
-static int ih_v6_1_set_clockgating_state(void *handle,
+static int ih_v6_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	ih_v6_1_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index d37f5a813007..8f9b15c171f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -664,10 +664,10 @@ static void ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
 	return;
 }
 
-static int ih_v7_0_set_clockgating_state(void *handle,
+static int ih_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	ih_v7_0_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 38938a624658..1100d832abfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -675,14 +675,14 @@ static int jpeg_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int jpeg_v2_0_set_clockgating_state(void *handle,
+static int jpeg_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
-		if (!jpeg_v2_0_is_idle(handle))
+		if (!jpeg_v2_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v2_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a0c0e8bd5978..3d72e383b7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -518,10 +518,10 @@ static int jpeg_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int jpeg_v2_5_set_clockgating_state(void *handle,
+static int jpeg_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
@@ -530,7 +530,7 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 			continue;
 
 		if (enable) {
-			if (!jpeg_v2_5_is_idle(handle))
+			if (!jpeg_v2_5_is_idle(adev))
 				return -EBUSY;
 			jpeg_v2_5_enable_clock_gating(adev, i);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 057e0c043de5..200403a07d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -466,14 +466,14 @@ static int jpeg_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v3_0_set_clockgating_state(void *handle,
+static int jpeg_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 
 	if (enable) {
-		if (!jpeg_v3_0_is_idle(handle))
+		if (!jpeg_v3_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v3_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 7a79fac9962c..0a4939895b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -628,14 +628,14 @@ static int jpeg_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v4_0_set_clockgating_state(void *handle,
+static int jpeg_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 
 	if (enable) {
-		if (!jpeg_v4_0_is_idle(handle))
+		if (!jpeg_v4_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v4_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 30ab807be2bc..7dfbaaf260a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -941,16 +941,16 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int jpeg_v4_0_3_set_clockgating_state(void *handle,
+static int jpeg_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (enable) {
-			if (!jpeg_v4_0_3_is_idle(handle))
+			if (!jpeg_v4_0_3_is_idle(adev))
 				return -EBUSY;
 			jpeg_v4_0_3_enable_clock_gating(adev, i);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 2b25e8f71f4e..d89863213ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -652,10 +652,10 @@ static int jpeg_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int jpeg_v4_0_5_set_clockgating_state(void *handle,
+static int jpeg_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
@@ -664,7 +664,7 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
 			continue;
 
 		if (enable) {
-			if (!jpeg_v4_0_5_is_idle(handle))
+			if (!jpeg_v4_0_5_is_idle(adev))
 				return -EBUSY;
 
 			jpeg_v4_0_5_enable_clock_gating(adev, i);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index c870f1a361ef..09eaf7f07710 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -553,14 +553,14 @@ static int jpeg_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v5_0_0_set_clockgating_state(void *handle,
+static int jpeg_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 
 	if (enable) {
-		if (!jpeg_v5_0_0_is_idle(handle))
+		if (!jpeg_v5_0_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v5_0_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f51b5dae3701..ebc2ab9c3c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -667,10 +667,10 @@ static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int navi10_ih_set_clockgating_state(void *handle,
+static int navi10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	navi10_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5332e510bced..ffc5b55ec841 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1039,10 +1039,10 @@ static bool nv_common_is_idle(void *handle)
 	return true;
 }
 
-static int nv_common_set_clockgating_state(void *handle,
+static int nv_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0c32e614d8e0..c6af318908e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1080,7 +1080,7 @@ static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v2_4_set_clockgating_state(void *handle,
+static int sdma_v2_4_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* XXX handled via the smc on VI */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 18f29e2be828..d438f2f7a408 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1483,10 +1483,10 @@ static void sdma_v3_0_update_sdma_medium_grain_light_sleep(
 	}
 }
 
-static int sdma_v3_0_set_clockgating_state(void *handle,
+static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a2f5f2be699b..defabd163d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2297,10 +2297,10 @@ static void sdma_v4_0_update_medium_grain_light_sleep(
 	}
 }
 
-static int sdma_v4_0_set_clockgating_state(void *handle,
+static int sdma_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 95d5de2bd186..7e23caca8813 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1505,7 +1505,7 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v4_4_2_set_clockgating_state(void *handle,
+static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					     enum amd_clockgating_state state);
 
 static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
@@ -1513,7 +1513,7 @@ static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_in_reset(adev))
-		sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+		sdma_v4_4_2_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 
 	return sdma_v4_4_2_hw_fini(ip_block);
 }
@@ -1812,10 +1812,10 @@ static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
 	}
 }
 
-static int sdma_v4_4_2_set_clockgating_state(void *handle,
+static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9ee5318be89e..afff8a6e8eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1835,10 +1835,10 @@ static void sdma_v5_0_update_medium_grain_light_sleep(struct amdgpu_device *adev
 	}
 }
 
-static int sdma_v5_0_set_clockgating_state(void *handle,
+static int sdma_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bd883a35c7eb..e282fd8de9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1789,10 +1789,10 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 	}
 }
 
-static int sdma_v5_2_set_clockgating_state(void *handle,
+static int sdma_v5_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 34106702e0ca..8fc70b9d8f81 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1588,7 +1588,7 @@ static int sdma_v6_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v6_0_set_clockgating_state(void *handle,
+static int sdma_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1a5fc7bc7289..eb35ec9f3da2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1524,7 +1524,7 @@ static int sdma_v7_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v7_0_set_clockgating_state(void *handle,
+static int sdma_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e32615630cca..77ef7da2e4fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2649,7 +2649,7 @@ static bool si_common_is_idle(void *handle)
 	return true;
 }
 
-static int si_common_set_clockgating_state(void *handle,
+static int si_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 4b278904cfd9..9f62b2b7fe0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -629,13 +629,13 @@ static int si_dma_process_trap_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int si_dma_set_clockgating_state(void *handle,
+static int si_dma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	u32 orig, data, offset;
 	int i;
 	bool enable;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	enable = (state == AMD_CG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index ec756d24aaa7..a32b6243c1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -263,7 +263,7 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_ih_set_clockgating_state(void *handle,
+static int si_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4aaf0c4b83e7..2bc9820ec495 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1385,10 +1385,10 @@ static void soc15_update_drm_light_sleep(struct amdgpu_device *adev, bool enable
 		WREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL), data);
 }
 
-static int soc15_common_set_clockgating_state(void *handle,
+static int soc15_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ab184431e3bb..0592e090b630 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -928,10 +928,10 @@ static bool soc21_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc21_common_set_clockgating_state(void *handle,
+static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(4, 3, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 2a408bc65f73..59d5e2f31c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -522,10 +522,10 @@ static bool soc24_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc24_common_set_clockgating_state(void *handle,
+static int soc24_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(6, 3, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 7c02eb0e1540..0968e551f7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -448,7 +448,7 @@ static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int tonga_ih_set_clockgating_state(void *handle,
+static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index c66fe0c8d5e9..5830e799c0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -790,7 +790,7 @@ static int uvd_v3_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	return uvd_v3_1_start(adev);
 }
 
-static int uvd_v3_1_set_clockgating_state(void *handle,
+static int uvd_v3_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 1f3da607c0d6..f93079e09215 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -44,7 +44,7 @@ static void uvd_v4_2_set_ring_funcs(struct amdgpu_device *adev);
 static void uvd_v4_2_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v4_2_start(struct amdgpu_device *adev);
 static void uvd_v4_2_stop(struct amdgpu_device *adev);
-static int uvd_v4_2_set_clockgating_state(void *handle,
+static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_clockgating_state state);
 static void uvd_v4_2_set_dcm(struct amdgpu_device *adev,
 			     bool sw_mode);
@@ -708,7 +708,7 @@ static int uvd_v4_2_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int uvd_v4_2_set_clockgating_state(void *handle,
+static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 50577cc79dcb..050a0f309390 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -42,7 +42,7 @@ static void uvd_v5_0_set_ring_funcs(struct amdgpu_device *adev);
 static void uvd_v5_0_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v5_0_start(struct amdgpu_device *adev);
 static void uvd_v5_0_stop(struct amdgpu_device *adev);
-static int uvd_v5_0_set_clockgating_state(void *handle,
+static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
 				 bool enable);
@@ -155,7 +155,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
-	uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+	uvd_v5_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 	uvd_v5_0_enable_mgcg(adev, true);
 
 	r = amdgpu_ring_test_helper(ring);
@@ -790,16 +790,11 @@ static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
 	}
 }
 
-static int uvd_v5_0_set_clockgating_state(void *handle,
+static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
-	if (!ip_block)
-		return -EINVAL;
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4f5dc46802e2..d9d036ee51fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -48,7 +48,7 @@ static void uvd_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v6_0_start(struct amdgpu_device *adev);
 static void uvd_v6_0_stop(struct amdgpu_device *adev);
 static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev);
-static int uvd_v6_0_set_clockgating_state(void *handle,
+static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
 				 bool enable);
@@ -467,7 +467,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
-	uvd_v6_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+	uvd_v6_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 	uvd_v6_0_enable_mgcg(adev, true);
 
 	r = amdgpu_ring_test_helper(ring);
@@ -1450,17 +1450,12 @@ static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
 	}
 }
 
-static int uvd_v6_0_set_clockgating_state(void *handle,
+static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ip_block *ip_block;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
-	if (!ip_block)
-		return -EINVAL;
-
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (uvd_v6_0_wait_for_idle(ip_block))
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 079131aeb2f7..53249d4ff8ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1511,7 +1511,7 @@ static int uvd_v7_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int uvd_v7_0_set_clockgating_state(void *handle,
+static int uvd_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* needed for driver unload*/
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 552866990db2..c633b7ff2943 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -578,13 +578,13 @@ static int vce_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int vce_v2_0_set_clockgating_state(void *handle,
+static int vce_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
 	bool sw_cg = false;
 
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (state == AMD_CG_STATE_GATE) {
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6f4a2476b9fd..f8bddcd19b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -65,7 +65,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx);
 static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev);
 static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
-static int vce_v3_0_set_clockgating_state(void *handle,
+static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 /**
  * vce_v3_0_ring_get_rptr - get read pointer
@@ -497,7 +497,7 @@ static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	vce_v3_0_stop(adev);
-	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
+	return vce_v3_0_set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
 }
 
 static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
@@ -760,10 +760,10 @@ static int vce_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int vce_v3_0_set_clockgating_state(void *handle,
+static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 04bfa3b59f75..335bda64ff5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -684,7 +684,7 @@ static void vce_v4_0_mc_resume(struct amdgpu_device *adev)
 			~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
 }
 
-static int vce_v4_0_set_clockgating_state(void *handle,
+static int vce_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* needed for driver unload*/
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 32b0159953f3..00d9fdd2869e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1395,15 +1395,15 @@ static int vcn_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v1_0_set_clockgating_state(void *handle,
+static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (!vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(adev))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 798d06563c65..de4067713d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1335,10 +1335,10 @@ static int vcn_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v2_0_set_clockgating_state(void *handle,
+static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
@@ -1346,7 +1346,7 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (!vcn_v2_0_is_idle(handle))
+		if (!vcn_v2_0_is_idle(adev))
 			return -EBUSY;
 		vcn_v2_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d00406e057d7..08f43a281a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1782,6 +1782,7 @@ static bool vcn_v2_5_is_idle(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
 		ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
 	}
 
@@ -1805,17 +1806,17 @@ static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v2_5_set_clockgating_state(void *handle,
+static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	if (enable) {
-		if (!vcn_v2_5_is_idle(handle))
+		if (!vcn_v2_5_is_idle(adev))
 			return -EBUSY;
 		vcn_v2_5_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d761bc7c31bc..6002990d917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2136,10 +2136,10 @@ static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v3_0_set_clockgating_state(void *handle,
+static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8c1d9afa81ff..2c36f748176f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2007,9 +2007,10 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 4ac6ee75b27d..eda67585768f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1560,7 +1560,7 @@ static bool vcn_v4_0_3_is_idle(void *handle)
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
-			UVD_STATUS__IDLE);
+                       UVD_STATUS__IDLE);
 	}
 
 	return ret;
@@ -1595,10 +1595,10 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_3_set_clockgating_state(void *handle,
+static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 13c0fc9f9894..f24e1eef6606 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1501,9 +1501,10 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9d16747484c8..8ccd054975a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1228,9 +1228,10 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 039f1ae2df02..378da889e075 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -605,10 +605,10 @@ static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int vega10_ih_set_clockgating_state(void *handle,
+static int vega10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	vega10_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index a8e88c9f6ae5..87a530bbc092 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -697,10 +697,10 @@ static void vega20_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int vega20_ih_set_clockgating_state(void *handle,
+static int vega20_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	vega20_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 471a66dad9b9..4180e5e671cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1945,10 +1945,10 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 	return 0;
 }
 
-static int vi_common_set_clockgating_state(void *handle,
+static int vi_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbdfe37cb93e..7790d2cdd71c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -955,7 +955,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	}
 }
 
-static int dm_set_clockgating_state(void *handle,
+static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 0f20abbfd381..98d9e840b0e2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -401,7 +401,7 @@ struct amd_ip_funcs {
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*set_clockgating_state)(void *handle,
+	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index bb8b0799ab7c..67a8e22b1126 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3177,7 +3177,7 @@ static int kv_dpm_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int kv_dpm_set_clockgating_state(void *handle,
+static int kv_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ed8f755e9ff6..2bed85ba835e 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7849,7 +7849,7 @@ static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_dpm_set_clockgating_state(void *handle,
+static int si_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a3d1c5aa3b3e..686345f75f26 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -267,7 +267,7 @@ static int pp_resume(struct amdgpu_ip_block *ip_block)
 	return hwmgr_resume(hwmgr);
 }
 
-static int pp_set_clockgating_state(void *handle,
+static int pp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1f3033e931b0..0805936bdcaf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2192,7 +2192,7 @@ static int smu_display_configuration_change(void *handle,
 	return 0;
 }
 
-static int smu_set_clockgating_state(void *handle,
+static int smu_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
-- 
2.34.1

