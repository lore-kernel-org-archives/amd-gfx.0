Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D67C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7481C10E0C1;
	Thu,  5 Jun 2025 01:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7ml9ZEc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E9410E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq+Vw8HNiuDL3/n9xEsTpV0NYvOADiVxfq9naa4ffGQ4hyqyMU5qTjc73doK5B4E0FXL20V+HtB0BziBUUfvrTUV6GGo8PyObOHZUO2otzh93Y8I338Lho+zIP85TSj5xIK5eOqtgYYWFZu4aiwNo5B/I5Ae4ebM9oEKNiwmEKWiYBiAodRpSNckMF6yf/M0NNUqQTbC7Xh4OHG4/I7qMz2dD1DM+S4QbngNTSJuDsDzL96EVa7hnojfYKVRiS9WbjCntcJUmg4W9qlUSY1zwjzEAYeFgFuyAQ3z6ka5MpzLm7bOxMlKrmE4Jz56uipEXU38+4qj0t3Yyz3+/O+s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htBz1QBV+lqvyXGSOjsN8EnP1NxZURI3Luaut+ewuSc=;
 b=W/dqrYarxl6A4IVRVEzSpRufMmLHvXaFjRCRvvNhcm/c059CBPdP5fA+Cu7tUNl9BhxcPgYUs3vxjGI33GcpxdffsC0YUO9LWUvaX3Zxd/A3zSMZ9ik8QFhZyJcrRjS/GjaWR0DR/We9wnPSuj0tgKoX2/rxaBo6VVrbxwc0WT6zef7RDcPV1TKjriVrP+/dQwDMtJErGSUBh1YepIzdaNljtcw56QSx0d6Ekp7qOlsbwV8Beo+v+rtVNfqIFNhHsfX5m7o2l0uo6ipT2A3KhakVnFrQIdiS9vK73uktVQy7oWu2QbqV0bXhq5GyFwZHW8XEDFc/dkRyOreak6lSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htBz1QBV+lqvyXGSOjsN8EnP1NxZURI3Luaut+ewuSc=;
 b=z7ml9ZEcuGiI12IZCi617/0MCDkUxSfbc3jvef0qcRqFKMvhPhZkZbEy9AF4tAVuAdJOTgfqzf/BXFsTK+JMrG9adHAtcBHEZFqLgPxniE+rMGLsnwX527ieQbp24pE7odFnV5dm+xfcgUdYEQK7OhUbvl/tjoiD5bq10qgbg8M=
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:19 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::27) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/31] drm/amdgpu: enable legacy enforce isolation by default
Date: Wed, 4 Jun 2025 21:45:31 -0400
Message-ID: <20250605014602.5915-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 436d361b-049b-4a75-7b00-08dda3d2c46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmNwZ0xkL1A1VkFNZks3UW1lV2wwbjJOaG0zNUNxR1pBT1QyQTZXS0lTdm9E?=
 =?utf-8?B?NG82VitwNXNlMk1sS1lKQkdkb0J5N0RMTFlWc1FCZUhnNUQzdVpSTlhYRENz?=
 =?utf-8?B?TytCcFFLRXQ0YndMNjRaZXIzVnh3eGk2eDVLcnpZQ3NUMzBnUTQzRFVOT3h2?=
 =?utf-8?B?QS9Cc3pXN1B1d0o4b01tRUNPay9wZnVBc3I3R3E0aU02SXkwOXpUK2xMTUpo?=
 =?utf-8?B?b1hLUHFwVU5raHlHeVo1OXJlOXdtaXFobEtlbEZRdmFYYm1mbWs0TlY5Q2o1?=
 =?utf-8?B?ZFdBVXVpdEFPSEF4SmRTQ0I0Q3I0b0VINjJCN3djUm9TL2UxNEJ4M1RtODhL?=
 =?utf-8?B?eGwxRDYwdmZ3T1hpK2o1SVRBUW0vSktBWGt0N2d1YlpsZ3NCOEpvMFVuaFpO?=
 =?utf-8?B?cUpwdThhUkV6akpDdnRocUc1Tnh5TmlCTDlKa0xBNGZMb1pWQzg3cTE5V3l2?=
 =?utf-8?B?STdmT29MNVFFYXE3VEx0Rm8vNkptdmQyK3JNOTd6bDViMFRhVFcwU0JNZko2?=
 =?utf-8?B?a0VLNmlVZzE0WHFaVUZLdi9IMTVIazFCZS9DTTZ1LzRMK1FCVG5jVGI3S0dp?=
 =?utf-8?B?MXNNamNBMGNxMjUzTHBCSXhiMEhRdktlWktJRzFHd1RvRzJFS0NwOG9ZYWo5?=
 =?utf-8?B?U0h1OFRYQnR2aHp6M1NDN0tsYUJ1V2JndFNiaHo1TFk1NGUwdmh0a2lOb0NK?=
 =?utf-8?B?RThjLzR1cktUTUlWeTZMZXFQdlBOdlduSlFsaExmOC9YL1ZSNFBCL3lrQVhC?=
 =?utf-8?B?QlIxRFpGSHhZOWhEUXh3c1hnZWhoeTlpUG5KWGo1Y1N6Umk5UzFXUjA3amE2?=
 =?utf-8?B?UStmWkwwaklybCsxZ3JpdUY4UXgyRytIM3VYTUwvTFIxeVlkdDBqYUl3emo1?=
 =?utf-8?B?SElFL3YwTHlmTUNvWlZmb2t0WVVmcWcyMy9TNFI0ZEcwaVpOcGFycjNRVXlw?=
 =?utf-8?B?cXpmQmN4M0ovaE1JaG5DNU5WempOc28velN5QlRGMll0a3l3TENuL28rVFJj?=
 =?utf-8?B?cE5JYThHOXR5TlJFUGJJSUEvVlc3RXJ1WU9TNjRwZkJpd0xkbjlOeDBSTVdw?=
 =?utf-8?B?VEEybE9kTlh3NnFmbVVKNVJweFZSVGlJZ0JJdDg4UklWQ2FNYVFDcHdITE9l?=
 =?utf-8?B?SWVNRzJub3FyZkkrdnR3U3NPVzBEa2c5UlUvVjhlZy9KL3RDYVFGTDJIZGha?=
 =?utf-8?B?aXppd1BBTnMzek43YnJWc0lMTnFCUURXcFhiR3Z3SXRpZ3pLckRGeVBBd1Fm?=
 =?utf-8?B?VjVoN0dFU1RONkFqTE5UVUMwaGdQUjZhTnlEbUd5ZTdscFlNRmRhSzJOUStR?=
 =?utf-8?B?NjFLYzNuaWhaNnhqR1RXanpYM1NiWGhaNlF3emU5ZGRhVXowcVdjaXdCN243?=
 =?utf-8?B?WWFwUWhUaDRtQm1YdFFtbDVWR1hLZnhITU1DZlZrZmVNZGVPSzA0R0xLM1Vk?=
 =?utf-8?B?NjltSEVNaXRmcXFoK0QxaFVJdEFmNnRoZ2hFWEhqWHEvWXMzZkNIdWF3c0VM?=
 =?utf-8?B?cGJ5NFZjN3FKTUI3UGxwMk53VGpDd3hKUE0zOWJXU3l0WEg3M3hGU0ZyaUE3?=
 =?utf-8?B?Y2NQMm14ZzB2dzNVWUszaytRSFVhSEc1RVVaaC9FZG0vWG1qR1p2bTg5eHc4?=
 =?utf-8?B?cUhPUjgyNUYyelBibmJPK3EreFpSMVkwNXpsK2JoMHorb0I2amNMcmsyNnA5?=
 =?utf-8?B?c2FrNG85NUZvMUVZSGhaQm9uVHhYdTFTM3NFTDdnZzZLSjFDMXdPK3VzNzlU?=
 =?utf-8?B?aVZhTTB0UU5kY3hjNzhXL3FVelpza0dyeVNqYm53V2RBdTN6dE9GNXZrWkZV?=
 =?utf-8?B?SFlSbFFQSXM4TkhsN1hkUVVBQVlSVjZQaXROOHBPU09BS3JNWWZYSEI0bUFr?=
 =?utf-8?B?L1VES1Y4di9EK2ZIRldBcW9Kb05hRkprYXYvOHdlOGRzZ09sN0NxcExlYkVE?=
 =?utf-8?B?ODZCQzRHcHZtN2RSZ2lzVjBUQmNncXRkMzNFNWx6YVhydk1lQTduVVorRVMz?=
 =?utf-8?B?dkpkZXdVMitwTlJSOFMrTVFmWTJzMExjcEF2SU10cVNhR0R4STZYZEg0NVhK?=
 =?utf-8?Q?APVoOj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:18.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436d361b-049b-4a75-7b00-08dda3d2c46c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72e41781afb06..ca882e3d95bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2148,9 +2148,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	for (i = 0; i < MAX_XCP; i++) {
 		switch (amdgpu_enforce_isolation) {
-		case -1:
 		case 0:
-		default:
 			/* disable */
 			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
 			break;
@@ -2159,7 +2157,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE;
 			break;
+		case -1:
 		case 2:
+		default:
 			/* enable legacy mode */
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
-- 
2.49.0

