Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C77EA3F05
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 05:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C51E10E4B4;
	Tue, 10 Feb 2026 05:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iVcO1QfA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF23910E4B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 05:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Feb0SpS6PuRrgQKbI1XaomRjtk57IE6yjUQVh56u8sjs1gtLdUv4oViRPtlhNCX9ml7HAvnauQRPyU0kmnHWidmzvLalmFmstRjR3QMbbPjHO/RpAYeQL0EQHz1ClOZjG8lLuZV3EIRCLlodUtWIV5KeeXbHiV3JSxA8yxctPcttVX/4YtmEGCrI3kuuQo2zZeLDUW+XgkUYzGs3LprOfaCZVIzHwbZWgVRIAJ+TQ7rjM0hZVIHH5UhHvXQKTx3A6LHyjlFvkFavE7lSOm/uOZcSsjjfZRzzF0SLjipjfnEJuULW56FdrcNW7ZVTLoIbY29Jmc2f2NwK4uqwNTGp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEAZPMf3x4NSJUDSDd5ayMG145///aZ4FfBluTRLETo=;
 b=V4PDNR9J6pK2dzTNBfo6q4ENKAPcTJI/9WkKRevSRxdOmIEFqsyP0nDhTWQS0lzwl+smtlbH9It897iY+wsuXlgouo72gq9ksmcC9OLqdbar7QW9g/4ESp9mHx+i9hKskwjg9BzCe/uMhg8CDDZhUbMUpr2g9bDgYvv56Of7gNP97v3s0lGht/QmWB5NNmRsEz1Ru2a7sd24nXPQVIW7UTW6Z/xAeE2To/mEiaezU8AIJXWx8hoNv1W2GZ8s+CIVsR5dcBdu5iv5ni6yCeXZE/3OItwW1hIHSr0v/k0WrOUDmiG60+6B5V/Z9U2rJ1PrP4cFJRrwaVD7cADBKUmMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEAZPMf3x4NSJUDSDd5ayMG145///aZ4FfBluTRLETo=;
 b=iVcO1QfA6MD48UQReXirRwLD2GLMnazy8fNtaatC67mQhHXgLG6P13dkaCq2AiGRXbgClOVid6wePTYdKj5Z5dFHq8J2AsWUg2qUwM9LiR29NxNtCG18rjvgBIpdQyiE37UJm2ihFFql9XW6Z0mYM+uevuRifs4L5YgfcK9bfEw=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 05:11:26 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::90) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 05:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 05:11:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Feb 2026 23:11:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Drop dead error handling after
 dma_fence_wait(old, false)
Date: Tue, 10 Feb 2026 10:41:07 +0530
Message-ID: <20260210051108.1514514-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
References: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f7eddb-9a7e-4007-ced7-08de6862d727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW1OY2dLV0xxb3NSbVlSZFQwYk1FNVhtYms4cEVnRW5LUG9ScTB6V0MrNG54?=
 =?utf-8?B?bVZKYjRzMXdUMitqbHR3czdSeDVTZHorMW9GcEN1MGUwZ0V1enM0YU1EVGZ6?=
 =?utf-8?B?L2crOXZNV3FITTExTkRnTjZBOEhyK1JjQzlsUGVEbk56YXNKczNBT1NCbDha?=
 =?utf-8?B?M3VraWNYRHNEekxTS1plUlBlOFNvTUM2Y1lHSTRTNzd4RHJ1bFllVng3U3N1?=
 =?utf-8?B?L3g4eFVkWjVmRFlGMkZ4TU42d1pUdExpSEhGaGEzWkJYYktnelpLMjU2U2tM?=
 =?utf-8?B?dXJORzZaT0tkdkxHSmVYY0dxSEJ1STZwbm11UVBWUVAxM1cyRmpqbktHd2k3?=
 =?utf-8?B?cHFCVStPV0tnYXFqVlhYMStRVVVIaUlpdTU0ODFER0RLZGRIUWJ5OUsxQW1H?=
 =?utf-8?B?VlYyK0hpTkhIMStrVTFLSEFES1ZzM3YxMk9JKzgzNG5JK3Z5dWJWUk1uYmZZ?=
 =?utf-8?B?Vk1JM1dpUU9FSllMdzE5NndnV1pqbHp4SkVFMXFRdGxxUGtIYkpKZXJkWTN2?=
 =?utf-8?B?RHZtNVYycGxGdTBrUlR4Tk85NVhWR0t5dnQxU3h4UHVnTHZ0cHVmMWFMalVM?=
 =?utf-8?B?OTYvZHp3dlFTbXhwQlgyNTNFQ2tId3R3dllhbEF4U2V4TTdVMU1XN1JwMkNF?=
 =?utf-8?B?SUNyTWNaN0xMdjBSeDhCcVBCV2MwZEI0b2ZDRXFxZVV3OGdUU1hkQU1QUjFy?=
 =?utf-8?B?SlQrKzN6dnN5WStnc0dmVis2elpWVnlaUnJIY0E1MU00K2hLR3l3S1paQVcv?=
 =?utf-8?B?ejFpekFwaDQrRCtiYm9UYTdmV2wzTmdMK0tLelBiZ2RocEp4Vk9PWlJFa2tk?=
 =?utf-8?B?NWd3bitZV3BjR3V5cjViZ3d4b0lUVUJyRzF4VVpKNHRkRlI2SUM3YkFXMkhU?=
 =?utf-8?B?NXBQQkRScDA5cWZ2cHBmU1RCRVgrTkNsZGlkaDBxQVozdkpGVG1JMjhRYlJS?=
 =?utf-8?B?YXB5YTFQYm54N0hoQjd3T3VvOU5wZnZ2Rm1Sd09QQkF0bVhqemhOOWsyWTMy?=
 =?utf-8?B?UGU5cEprN2h1OXRwb2NSY1Zpa0lBZHlndlBraTFnNkxtaWFtZkF5MjhTYkFh?=
 =?utf-8?B?WnMwSDZlQ1g1cXFmRTduUndHQ2hqVU9MMnQ4TWxnVFFWblU3T0M5UUZIUzds?=
 =?utf-8?B?Y2YxVW1wUVY1eXF0MjhJKzB2dGxDOFhvTHlobm5hTGJqUGpxOWJRdkViVDEy?=
 =?utf-8?B?cEo1R3BpR1JpVk5LMmVCNWxDUnRVanRXUzFFUDlDWERJMmRudWl3VHFRZGQy?=
 =?utf-8?B?Uy9mUmRHYy92QU9RUWE3Z2VTdmNLY0t4dUNmUXRWMktwN0x0bFlBdmNNMzZB?=
 =?utf-8?B?VkhJa0tNSXlHTS9SZE1OS096VlhMYVJsRmlKRGdhaS94alJXVzhsdHBNVVRq?=
 =?utf-8?B?KzlVVys5cEdwMzZzQk1QUExzVm96SmFpNEtTS3RObE9wODNNR2JSamE1bG5Q?=
 =?utf-8?B?SWI0UndmSDN4Q1h0R1hSYlJLNVBiOGRwdWUrK2lzZlpOUWM3elczRUh3T2RL?=
 =?utf-8?B?b3NpRmZiRnFOUVJSSnEzdmIwb3daZHZqUTVkSkJBbmF4bzVJZmtRZXUxWDJy?=
 =?utf-8?B?SGx0VzRxdGpSTmxXdHJXQlVTL1Y2aStSMXY4SWdJN1NOTjhVVVA4K2d6UVZj?=
 =?utf-8?B?aU1RejUwNHdaQnFTc0M3cEMyTUl4Qkszak1yZkNUSzFVR1hLN2hpbU4vYWNO?=
 =?utf-8?B?R1cvSlMvZWVLVHlKWEY3VXVSbDNWWkNZNXIwVCtwc2JOVXQrcW4yWGJBV2lQ?=
 =?utf-8?B?MStrVU8vZTNQcmFWSGNxSEhtREVqVUlwSE9TaDZ2Rk9oamlyekM4RkhBSnkv?=
 =?utf-8?B?dFQrSnFNUmpuN2E5dTgxQWN2VVFQTnd2RzV0bU5FS2lQcFdXemhQdnM5aUVq?=
 =?utf-8?B?VzdHWjdVSzZUWkR4MCtVN2lJVHUydzRtNHNHY2RGQ3dGMEdidGIzZ3lHeHkx?=
 =?utf-8?B?eURiL3g3anlzNU5DVUlNL0lyZWd3OG05OEM2SGQvVGtzRi9QQnVMTnlCc1ho?=
 =?utf-8?B?OVdJeHJ5SVZURnArN2FUU2RBTDZPMXhQR0pFVFJTT0xqVUJ2VzdoTnFHbUo2?=
 =?utf-8?B?MlhPY0NRVERTcFg0MGdHRVNDT0FBVmI2VzZ4Q2lrTldPQ3NlY3YxbWRrd2N0?=
 =?utf-8?B?MVlucEJ5TE1IdC9GZ01NTW9oL3UzWWxVNC91TXJZSVo1dUthejdHU01rQ3pQ?=
 =?utf-8?B?WkdTRU1uQTVYeGVRMmNxVFlWbzk0bGR1UWh6UjlCYVpZSzkwRjRIUis1L3gw?=
 =?utf-8?B?M2oveHd3NXNUVFROR2dLQ0JEdWZRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jWlVBOYxgmq0zMM6W8O2TRO4BrPqc8KZyQkQxBb+boBLN5hGx30ikDLeQxGCAfasMSgBJUGUAGIn1kQNomrSvn49Qk5TPUFIh1EmPtR6gAJ4HO3h3NKsf61mbH5/xTlsZweWwEhJ2ZvGinPECckJYBgh8uHDHFVE9nToV+oshev1UUN8MRfVEIhAxJ2jcpwfYhDlp0pgsu5Mq+Va6fZ/prUmDYM8kWewhvw0zzovwORPV4PHcliIUYlChuvr7qr6v4cslG0dsLPU7CMB5z1Vq+Sw0A1PtFSG8lRwawFqk8ReaqCLItdPD9R6NIQnjri7ZTVBv7T71jofIXqV2cX4x8AMqnEBfBM/hbS3p/wbd//FZuV80u6nt4wJY9ueqtL+DSe+MR5H/iSYf/Y4YRPV0zrSJyhYtx1E6sVTnY9Qp7MDLCkSAqKnLA4cEaSfqBJh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 05:11:25.8264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7eddb-9a7e-4007-ced7-08de6862d727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

dma_fence_wait(old, false) cannot return an error because it is not
interruptible. Drop the unreachable error handling in amdgpu_fence_emit().

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1054d66c54fa..01f347f59405 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -141,10 +141,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		rcu_read_unlock();
 
 		if (old) {
-			r = dma_fence_wait(old, false);
+			dma_fence_wait(old, false);
 			dma_fence_put(old);
-			if (r)
-				return r;
 		}
 	}
 
-- 
2.34.1

