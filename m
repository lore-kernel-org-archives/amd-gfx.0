Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5855ECCD19A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F126510E456;
	Tue, 18 Nov 2025 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ktYWwRkR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298AA10E456
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu5219TOHwb8Tjq9th8xMdcpf0NQg38sHJUeUuDtPGhQ40FJcuknEOKzx197ESM1jVVW6WEPCb2z+wLyo1LO34zdEGhJ3F6NCFMPclYO3Ph416EJ6YiThV5/vDeoqKD3hNKgmrAbmT6/xfznfaK0AOf5DV0VGx4UaOXpeIMVVcuzWqcqZf35jikg76Muqq7RWV3ZMCVjiMg0TIy6+ZlagWNo+QQRJ72dMhyuO6SXz0lFX/PlxADfsHsri6uhQzkFx6JL1BGFyLN6Zv12dRlfBeXxrCJP9faZfsCJNFqBQZ+0taBK+VknN5QeArXIpMvSg394DEbezP+qG28MMT5lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0N/kg1/CeB6SEhMm+BzFeeYPntG8keVlHmHG3DxVMg=;
 b=Bs6NM/2d2PKtjSW4U+5orFRfatIZ5nKOJP2tiX8v1uS7S5i3rVIHOfT3V5IeXi2DSDp+rOr9RFhe+PJueFtONTJHSJ0GqvHBffCQl3oR1VvsSav5L8hgTBjmaec+KtFc7ymDBOY0I3z1UELBRnyQyUa+jKHTLPHEbGr0EdhdKkXxorN9AB8YqFxdogicHADEQKVRkZRz6qsfy+hspVu4Czi9szSkXJut6G617G8ZqkRB73HGv95joPa3rmws8QoAxFFu2PV/tF4xNoZSk5d2ydFg6gQAEPogCy7ZjBNFBCJDzigtrz0QtDyJSsBcoO6oRsX0qBgy9IaEu8DPJlU+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0N/kg1/CeB6SEhMm+BzFeeYPntG8keVlHmHG3DxVMg=;
 b=ktYWwRkR/aRJTUPDIVcdtGKWB/Bt3Xgp184mFH1Sncu93o2Xx7+xAN3rhnGF1P3gi4PnOqY2SI+HKgdxRciryDYGjEu0gXxYtkN7RWGtrNRsRRDh7jjSFNKYl9mbsVHM/kR7f9ZiovmBg6noaXb7FLo8Ulq2MKuIXH/Zt72wTb4=
Received: from MW4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:303:b7::22)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:03:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::88) by MW4PR03CA0107.outlook.office365.com
 (2603:10b6:303:b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:03:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 18 Nov 2025 01:03:46 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in PDE
 flags
Date: Tue, 18 Nov 2025 14:33:33 +0530
Message-ID: <20251118090333.109361-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
References: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c4792d-a4a6-4462-b320-08de26816308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RExMWFcyTm5ZV0N4aksvNmpVQ3h6dWs3UkJoNkhxVEpaL2w1dllYVTFtTDF0?=
 =?utf-8?B?M0Y3K2NiQWoxcUtKbm4wcWVSbXFQV1ZqT0FrT2dhRG9yK2VHbnRJT1N0a0E0?=
 =?utf-8?B?anozNFlSR0Zjb0pvUVZqWUtBUDJwNy9hZmFDTE9pSDk1VHFhamwvNWxrcDhr?=
 =?utf-8?B?U3Zzc2FsT0MwMnJOM2tPY0xDWnVvbTdEcmd4czQ3MlYxSFJPL0Z1eWtTUWpr?=
 =?utf-8?B?ZjIwZGQ4U1k4UmlQc2pLemN3K3BpTmFFdzdGeVhPeDkzKzlEY3JWY1UvZSt3?=
 =?utf-8?B?OFBoL1NhSEtUUG1xU25lTVZodUlyc2JIaU9nLzRZMGJHb01oR1MyOEhQd1Jr?=
 =?utf-8?B?WkpoSFR4YlRBcnFGTVJQRkF1U2M1NE5sVWNjQzhpOUYzcU5Mb1pVSm1wRENu?=
 =?utf-8?B?WEN0OERVdTBEc0Ntd1lxcEZRcUtZTGNxQ2E3UHI1R3lxM0JmVzNheEZ6aEkr?=
 =?utf-8?B?d0NpOFVQQ3ZKb1lGbE16MVR6Z2xPaEZjTE5MWmNrSk45cEJaeVNleEdmbzZD?=
 =?utf-8?B?bm1DRllwUE1maTd2TktGZnAwT3l3emNOcjBOZ2M2WDJpT2ZHOUFra2xBMEtE?=
 =?utf-8?B?U1dVWlJvTnpHTnBxWEJTL042VG1JT09WZjFpWXE1d3krTHlJSS9zUFdiNng0?=
 =?utf-8?B?M1o2STNjclFqbDZmNUdVMXVMSmY5UE15T3UzZk1ucTlKaDJqSyswRllrZ3Iz?=
 =?utf-8?B?amdNMlpXd0EwaHRRTUJla0lKS1kxRkZkL01jSlE0UGVzVGYvQWVVUmxxbFdo?=
 =?utf-8?B?NGM0cXhuSlhzTjd4WmJ0VDdUZzBoMFRORXQ5QXBQWjRsMTN4V2lnTEYrMHc2?=
 =?utf-8?B?NDRhNk16bytCRU1oQjlJM1Bzd2I4YUtTeWxvSEtkQnU2VEMyVEQrN3FUT0pr?=
 =?utf-8?B?WHBocHZCck5uY3VIT3YrVVF2SnUrWWpRaU1XRGJsdlh1K2wyZDBWbGZjOC9h?=
 =?utf-8?B?NHVlMlV1cDVycVpZTHowS3lBMDlXV1E5T29Wem1oS2RCaTRjR1JiNkFnalpj?=
 =?utf-8?B?eUxTSjJ5WEVobWo3UndsZ3JYUnB0RGEyMWhnSzFOY01LeGYwd1NvbkFiRWVz?=
 =?utf-8?B?cEROZXd2NXQ1aDJzeGVEOW4rK3k2T1BReTVSTzY5SEt2ZzE5ZTNwMWl0Nm9q?=
 =?utf-8?B?dC9IZ2NrZkFIZjNHcXl3ZW4zcVBpV1lvaThHY2xaSmlsOUtWdW5rWmZIbnBV?=
 =?utf-8?B?ZTQ4Q0lyakJjNUVyUm1VL0ErS2hIY0lhWGxLcUQ1MHRZeHl4NmxJeWNPOVRH?=
 =?utf-8?B?K29ZT1NkWHIycC9iZkdQRXBzdzdVVXRHMlRieTMzcHJlVEZML0hkZzIxSHhL?=
 =?utf-8?B?TW10ejk5cHYyemJRek5NOW9haWp3K3Fabms3Zmc2aDR0b2d2eHlsWi9NaEpt?=
 =?utf-8?B?L2Z0eVc5THVkazJxcmFoOFp1bnE5Z1JPS0ROa1M2WkNDdHVHQkhRSG9rc2x2?=
 =?utf-8?B?R3Z1aVR5alQ1emhvR1JYMDNHTEtPNk8vM2lDbVd3cnlJSndUK09MR2tNeXNG?=
 =?utf-8?B?aDhlQURNbjl5QmdtYW1NUUpJWUVBV0x6amd4SGpmSEh5ZWsxNjB1VFo4bjJQ?=
 =?utf-8?B?Q09hdXA1WXpQdmorL0liRWZMaDgzZU1lR3ArSHBMK1BkT2pYNndzTVBrM1N2?=
 =?utf-8?B?RUlxSXpyQ0RJNTdTLzhEQ3NTMVBDaDJmdnN2MzBVREhEZjZlMndrSGQzL2wz?=
 =?utf-8?B?b1NOVnNjQk9CaG9ZVCs0U2tScCtuRStUTkYvUUhMQXV1MFhPd1RXU3h4bjA5?=
 =?utf-8?B?dmo5a1NvMWVYTmNUQjFTY0pDTHMxQ0JvdlAvUURLeGM4cUpCdkQ3QXEwSVJS?=
 =?utf-8?B?R1oyN3ZBMUY3MHViU0hJMGdhTkN3Y1d5RUFIYVFZUGZCYlVMb3JDenlybkZa?=
 =?utf-8?B?NXpuRmNVYjl1eVBjZDYreHZVSUtUejRCQUFGNEo3L0svWUtDME9jWHNYTXlX?=
 =?utf-8?B?QmlHVzVHM2pkSThPTFNScXhCYW5wdlg2WHpkS0VTTTJ5d0M1M1ZaMHNXK3cy?=
 =?utf-8?B?RG1oVWFvUE9RN2FNM0FwRUI5dmVhemR6WDR3RGMzQVBZM25yOGJBQlJlS25r?=
 =?utf-8?B?emVzTWg5aTBLZFd3WVBXTXlDcTA5MjVqMVNWU3FDV1hRNUlIZFJUTGFnMzlZ?=
 =?utf-8?Q?d660=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:03:48.6003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c4792d-a4a6-4462-b320-08de26816308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

The MMIO_REMAP BO is a special 4K IO page that does not have a ttm_tt
behind it. However, amdgpu_ttm_tt_pde_flags() was treating it like
normal TT/doorbell/preempt memory and unconditionally accessed
ttm->caching. For the MMIO_REMAP BO, ttm is NULL, so this leads to a
NULL pointer dereference when computing PDE flags.

Fix this by checking that ttm is non-NULL before reading ttm->caching.
This prevents the crash for MMIO_REMAP and also makes the code more
defensive if other BOs ever come through without a ttm_tt.

Fixes: d716b3a2df1b ("drm/amdgpu: Implement TTM handling for MMIO_REMAP placement")
Suggested-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 84f9d5a57d03..04a79ef05f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1328,7 +1328,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 		    mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
-		if (ttm->caching == ttm_cached)
+		if (ttm && ttm->caching == ttm_cached)
 			flags |= AMDGPU_PTE_SNOOPED;
 	}
 
-- 
2.34.1

