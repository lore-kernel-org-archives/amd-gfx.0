Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081F4C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 18:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BAE10E0C1;
	Thu, 13 Feb 2025 18:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3z2fQJhx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9D210E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 18:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whQtrgOK2d0Yu2Yh3JDhohJ2a8oysKvwEKM7EbUPq3Uq1WQlgTJ7qYP7uukIZqTwWTiIl3Cdii4ESKsILrl/GBzUyxZDcmm0RkxbIC9G7f6Be9E+JCMJT6Y5kHC4Rf8kWRfyF9+Q29p6VYqxDFh1g0RPVX2vFJ5TcqyWtek+e+Lc9KPU+EB23EiYDxgD1PRIkacms5J8gDpS0Y9VMC306ABFypr5+w9p05OhwVSD7xqSZIR8HyJUTQIVwIRm6+xXtM5tcVX1a+I/tvHPfwX3zS+pgxWw6EsXnvxGY7rB0ro2OF+XtjQxtY8WCr8KlQ647v6Jxsti0GmVP3LxMeTtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXdFARYkjMSOcuiBVxJ7U/ddjDYY7S1XuxyjrUEbeUo=;
 b=E9H+W9kE6jAAxOi0dxr8+lqTsclcjdexKLHP+X3JHeXldfj5L2Nt6J5jzk1xmnpkiFc6XlrVhhgOcCJXoCY2oPTKOZKQRYhkXTxlaGWww8T6tbPa4uDq+AA/w8Fw04glxej72RZPE+/6IgwwRflsoVSczZU6aylDwtlNAf7so1m+JWPAISs+S1p5runtIKO2JhyYS84kzinNFoyRvdvFjx/UoQcNElC+bTh9EOuMSRa0qkWRKo2YaFH5q9Pb7tS1qgbsiX6le8LZ/KhVHCvn4zd4O6bCMOHG6F1w5+VXF+lBxuWtFLG9OBn/vHo+p1unXrMK66jOwed9euPXisZ5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXdFARYkjMSOcuiBVxJ7U/ddjDYY7S1XuxyjrUEbeUo=;
 b=3z2fQJhxDL0lm4Yx+0yXLTbUFUfg18im5Gn09fU+O9csHEs0XsO2ScG/8eNYayxKc6XKP8kygnBBFhOgc8xqEJ46QlXiQQr09qInJz7974PiyH7uErgvL7PU7LLWTeE0od1/ttgZSC/lTnaY4C8EQmu9xKv4bR5j/KzXZpnQyZg=
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 18:15:27 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::8f) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 18:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:15:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 12:15:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Rename VCN clock gating function for consistency
Date: Thu, 13 Feb 2025 23:45:09 +0530
Message-ID: <20250213181509.619164-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f49c321-a454-4ec0-be6c-08dd4c5a6409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0JPV0hQN2tYN0hPeW93Vk16Tkh1Z1VyVlVlY2VTRzFYRzEva3h1eGhXajBl?=
 =?utf-8?B?NUFoZG1zQnJMWnRzdGdzQkppNm5OTzBrVFJEcEFEbHYyYk9zb3lkN2hHcmp5?=
 =?utf-8?B?RHB6aGVLemt6UURSNjVOZm54NjVzL3EyUEJFQ3pJZ0liSThvVDNFb21qNHJS?=
 =?utf-8?B?YW01eW02dE5BakhoY2ZqOTdRQ08xWnV3OFRiSGs4aDlwcG9oYXZEMDZLcjUz?=
 =?utf-8?B?NFNKSXBNZHBDWUVzZFdTSm1TNUE3SjRWM1NrY2VQczRzSlZ1MEMxWTJZQjlM?=
 =?utf-8?B?a05TZkhDM2dmSVdORDFWVVdRQjhYV1VqQTY5bkI4Q3VJQmV3MHlVOU5rUm9P?=
 =?utf-8?B?M0grellNVlBPK2FLQkdLNHRxdXlYaUszdWtnZVl0OWtOV05rUkNxSFBuZEJu?=
 =?utf-8?B?K0FjbS9SQ3k4MXgwaUtmYXpmdnhOcGJUUC9KZjBZRU9PNlQ0WUR3N3dOeGJU?=
 =?utf-8?B?VGpmTk1EY09aR00wS0s2b1JpcTRjRWJWRC92R3hrTkUzeldFTmRUdm83ckVB?=
 =?utf-8?B?SFRPL3d5VWxXdlluM3NNdlkwck1zNFRsdnAxQ0JYVDdNMElqc2E0Sm9EamlZ?=
 =?utf-8?B?MFY1Q2FOaGpIZU8xdUkzeDNqRVhCaVFqM3ltMmhnNnpZdmN6RFNiR1VHd2tv?=
 =?utf-8?B?ejcxVWFyK2YyY0dWb1kzT3pCZ1NSNHM0UTM5S0ZSQ0M0SWJPVTFuRERuZlhD?=
 =?utf-8?B?Q1hUdTlTbWxUTjVjU21FeXROYnNraDdPNTAzb01JR1l0dXdWYTFLaVRnT04z?=
 =?utf-8?B?N2FMaEk3UkhZWW9kVDJWZ0F2cldoUy82bjBzS2pEdjF2Z1h6cHdmUWMyUEcx?=
 =?utf-8?B?WEpobmd1dGFXZzNzdEZ3QllOKzlFR2RFSWVrWEtVRk9KRmErd3FmMEU1V2xO?=
 =?utf-8?B?dmdqSElkRmtMQXFOdXg0QmxIcHpyK3lBTFdsbkZSREZ1VzJqek85ZjU4OHB0?=
 =?utf-8?B?OE1kaUtXbXJ0UjNRMmsxSlF1UnY1bmp6dStDRFdEL0FFcVJ0eUxOOUhEMUtJ?=
 =?utf-8?B?akkwTkxncWI5UlJvdGJPbGpQZ01wZDBISHpsRGh5UU1RWG5EY1l1N0dobWFk?=
 =?utf-8?B?NHJVQ2xkdzN0bHBISnVzSEV4Q1BQR1ZzK1ltajJpRWMwVlFBOGZvOFcvUS9u?=
 =?utf-8?B?citCMFFPSlBhREV1NE1EL2VLanJ4RzVWelRTL25PWDBaWHg5alU5TEVPRGNY?=
 =?utf-8?B?QXZpRW4zM1A5WS9PN1hEc1NmUjh1ZVFHWVNmdWxJZXR3U2c3K2pNVTZTUFFD?=
 =?utf-8?B?ODk4YWpsUUs5bmpmTTRLYkJ6d2pIR0VuaUFXV05wckVCYTRJSmEzRUVwMnpF?=
 =?utf-8?B?d3l5S3FDYzJOVVdiUmVHdytlcW5TeDlUSS8yRlhZTjBnRTdlMGt0OXBMSGZB?=
 =?utf-8?B?MytncVIwRENKbHl2NUdSb0FIWm5HbndrSTJHWkhVbkRyVC94ajU0cS9VaUI5?=
 =?utf-8?B?MmZheVQ4bFdxcHFuS3lnaVZKUW42emY5dFRUVU1LTEMzUlFHS1hZQlBCUjI2?=
 =?utf-8?B?SEs1OVRkcUIyR2o2ZjNnS2FaOGxRSkFsVGNHdUJJM0dYMUY1Y3AxSlVXVWVm?=
 =?utf-8?B?TGxIS1BhQTlVbk90eVZmdzJ3WG1YektycU9YelQwd3BiZXRidGhlTUxzNlVC?=
 =?utf-8?B?OHk1cGxualZNRzREZXVMUFhoQ25lVXRDMjBENUl1K3d2L0E3bG55eUdGL2ZF?=
 =?utf-8?B?aUFxTi9yWHNqMmxGcXJPOUtGVE9SNzNNR0MrNnBIVWxrQUhxSGJncklYS2JL?=
 =?utf-8?B?b2ZvZWVJQyt0eTBoQnMwSDR5dlAzMDkrNWJSMzd0QzVuYTVvOXdTQjBnWUFJ?=
 =?utf-8?B?b1VTT1Nnd1BFcWVhL1NMaVZoMnlyL3lMUlVScjUwQXYzZmZMV1Nydjhha0xC?=
 =?utf-8?B?dlo5aEtZMUhCLzNjMjlHNXNTZHNyZmRBbHh0aWExSlA2THN1eVliK1E2UmNT?=
 =?utf-8?B?TkE5b2xxMmlLcmZxY0VzK3lHZW0wRFBxSWF2ekFJSG51ZmZQNXZmbkRZQTB0?=
 =?utf-8?Q?bNR0Vft0Vq0a3OVnF6JIlSMkIuydXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:15:26.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f49c321-a454-4ec0-be6c-08dd4c5a6409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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

Change the function name from vcn_v2_5_enable_clock_gating_inst
to vcn_v2_5_enable_clock_gating to ensure consistency in naming.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:781: warning: expecting prototype for vcn_v2_5_enable_clock_gating_inst(). Prototype was for vcn_v2_5_enable_clock_gating() instead

Cc: Leo Liu <leo.liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b9be304aa294..105e59f6132b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -770,7 +770,7 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
+ * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
  * @i: instance to enable clockgating on
-- 
2.34.1

