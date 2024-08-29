Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97C9C87FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 17:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D2410E745;
	Thu, 29 Aug 2024 17:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ymmo5MUm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F8110E745
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 17:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjfq/hyQ2IuJI6QRJ7lQ/0GOsQ0c1O03d2jdDHh3wZzJcR/IczgJVj8p5ncj/TpllM58FkRsNTEkyzt40LZwYreldUR4bwIiTHOi+IfAMEpQTjcmi8klHMdzHlUty30pmucqRNk67iYluaRqVwHzcBWhrZQhNtpICt32zWxUu2WeqlY8Ecvhmjaoth4YrMCuW9wxzX4vkxFJQ3t2gHZ+h+AmBxBSjInUW94ijsopUrPwcR0MlhlFlFs1C9FzIzS7h/RXMjmBOohwjeR1z/Kvq1dn0EAiVZNiqZYRfVq1pENa6ja0EiV2MgD/zUy1PYJJA720U5X0z3Tg0w9F9DSh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46zipoH6ot0Cc6h+6C78A2BCrPE7ngDQ0Zcf2Tn9tTM=;
 b=RoHcTBkYkp5o5n6RCeP4Ui1mcAor/aalg8oZb9fMXia0gQf3rFzP+UXtMZWWanxVMJU185KwXvnDRcCEBxw9aIQEfRBAuZNjNvDvdc1BUoGTvgJ7Pw8LDI5YGbZCbc7isdLRrr8cBdv/+DHNOYFPqhv/f8MDbbGrj5EqkrLcWfRQOFfyT18P3EqJySCMLx9xiX6w4Rre4hyWPDZ0Ynuy2rjEY0XVh3zT3ApRJdeP6pe5kziUG551LHoCMMHZJxpTVSYmI/K+fxIUW2YHSTTyLqwvmmi9SyCeODE0d9Q7ScEuDncC4Xyf2r0lP896aCS7JxNFhXkUD0qwmBxJR/HKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46zipoH6ot0Cc6h+6C78A2BCrPE7ngDQ0Zcf2Tn9tTM=;
 b=Ymmo5MUmNx/4HBucLup6rnGAxnw4BGbKMGNK79DEL/rqZBk0K8+9MMzCLrA/eRgavBxQQoujWjsjmcB+CI9STCiLkXEhniseazw6CEIPnRRDE6oDP+7iNEsAGrHF1isP9GewksSNPKalI8PoahFmpBM16cQI/JQRue+K6e1CLOM=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 17:27:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::38) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 17:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 17:27:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 12:27:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Michel=20D=C3=A4nzer?=
 <mdaenzer@redhat.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM allocations
Date: Thu, 29 Aug 2024 13:26:45 -0400
Message-ID: <20240829172645.1678920-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: b2638221-b027-4b42-cac3-08dcc84fcce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snp5Uk9idmdWWUNiaDBPMk52RWdyYlBhaVozVU1BKzJKTVBULzFWSk9MUm8y?=
 =?utf-8?B?cXhsTHBDM2pHTDM5SXlwYTI1WWVKWCsyZ05RN0tabTBORC8zWjA0emNuMkFH?=
 =?utf-8?B?TlFYdlBxaWxFQUxYRjQyZGVXTnZQMzlJQW5acE42ZG9UL2I0Vm91dmN1UTFF?=
 =?utf-8?B?c3pYV1lnSW82Z2YyTEx3ZWtudENEdENRdFUxVXZPZndCRVdtY09BNVJIRm1h?=
 =?utf-8?B?aGdkaFRsVFFWaHp6c3ZCelNITEtEd1dnQ042WkdpQmZlY1NYSGY5aCtXN3F6?=
 =?utf-8?B?Z2s5ZEJWQ2MxTXFvM1lHWVZYRy9jVll2eEFUZnV1ajBRZUVTQTJINFJVc3Nv?=
 =?utf-8?B?UlUvVTQ0TkcxWnQ3ek0yZGI0Q1VyK2hWQTJlYkhFVDlpVnhSNEZWeUVQMy81?=
 =?utf-8?B?UmZOVUFBRjJMdnY3R2sxaDEyOFdCNmpKM2JKblU1TkY5U2hRb21jVVpjYWp0?=
 =?utf-8?B?TlNYcE9XY1ZTWnI4aktUbzlTanFLNmh0dkRyNmZUM0FUWldyK0RBT3M0RVcx?=
 =?utf-8?B?dUxuRHlhWlI4L1ZUSFdhTDVOMXlRamx5UERNaDZzdERUZUFCTjBpU3ZSSVZt?=
 =?utf-8?B?SlRsY0JLRlhwMTRudHFxLzE4WGZ6eXhPdGhESXJDS1cvQ0ZQUWkrWmJuNE5E?=
 =?utf-8?B?WnQ1L0Y1aW5ZNklwR2JhNjdLaU9SYmMvZEwzM2tRajdzdHpUUFh4bFRmRElj?=
 =?utf-8?B?MFJZSldKZG85aWc5dndRMjFucGVsVDlaK3hSVEtFL1ROWjFxczMxUnNJbmhI?=
 =?utf-8?B?V1pQbDJMak5nNWw3Z0UwNTRjaXhkYnVGeVFVZUpWY2pIcm1HOXNXSWR6OC9m?=
 =?utf-8?B?dlRieU5tWWVCeUxMUE1TbmVvYmtRYUdkend1SXVJenVxZ0dnc0VVcG5QZFFQ?=
 =?utf-8?B?MzEyNXJvSGRFSWZZMUpwcUJ4T2RjbjUxM3pnUDdKSlVacDNBbTloZVpobTZO?=
 =?utf-8?B?emhSanJBUndnU1FMWTVwQmp5QnFmR0hmTnR0OUFyZWJFeU5tYWdqNmR5alZS?=
 =?utf-8?B?RU9NWDd1c1cxN1NxUlRxTjVTdmVPVlRha25vUFlXVVNJY21vYzZMQUtoR3dF?=
 =?utf-8?B?a2xJKy9MMXJEeUxzanJINUs3LytVUjlLSWNqTmZwMSs0eXlwNEpRUzhoRTFP?=
 =?utf-8?B?YTd4N3V4eDByN1JXL05KV3FMa1VBaXltcytrK3p4ZjF0eXczR3pra2Q2N0F2?=
 =?utf-8?B?L3Z4a2ZqUjdldFFjZkNrM29vZTRzdjB1cEhXTWZwZGp2RXRtZk45aURvZXJH?=
 =?utf-8?B?ZzdpMjZLL1ZaVjJ5azJielBzalNPU1VRaUhEVlhPRGpFMG5QMTU5cmhkeHBa?=
 =?utf-8?B?MGRXOGt1YzExQXhXUk5rNWFiYmdEbjlMdW5vMXU0YVdUOXdjK0ZXejBLYVNM?=
 =?utf-8?B?UG1xa0ZBZnJQdUlRZ1lFMER5ZTcrRTFnVVd2OHYvZHNyMHBFRnJuNXZNZCsz?=
 =?utf-8?B?MEdEbXRJb3Z6b29xaWc0c0pQNWhxWkJ0a2FRcjgrS0V3WEJZcWQ0L3VDREww?=
 =?utf-8?B?T0pSTHltWStZdDE2RUJ5cEFqZ2pZaXphb0NKL2tXZGVURHdZbkxBY0NZdTBz?=
 =?utf-8?B?c3FOUDJmdHE1blZNcGozOWRjc05PZ2RDVDZNNXhrUm5teWtzUEdpNzNRMjc3?=
 =?utf-8?B?aFFaSlZsV2FOQnIvZlp3U0ZmN1JlTlFpUlRDMklQOHhrZG1oeHlKOFFsamVm?=
 =?utf-8?B?Z0ZBOFpnVjkyWFpIdmhwdnovOUE3NTJ6bk5RSmtKUGhJVlJUMkQwMTNicEJr?=
 =?utf-8?B?S0hlS01OSXVwRWdZZWRPeG0vdjMvTTJycWkxRml0QWo2cUtyQVFLQ2JMc3JK?=
 =?utf-8?B?VEhJWDBuZmRQOGxCR1IyeGx2QmZnanRnTnp1cUhQSmZFMW5vWE42SUYvT0p5?=
 =?utf-8?Q?GpySYEW4aM0e9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 17:27:04.3435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2638221-b027-4b42-cac3-08dcc84fcce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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

This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

In addition this fixes the high CPU spikes seen when doing
wipe on release.

v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Reviewed-by: Michel Dänzer <mdaenzer@redhat.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 1f149c9e2177..8794661b0bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* always clear VRAM */
+	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.46.0

