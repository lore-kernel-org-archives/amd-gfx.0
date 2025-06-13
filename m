Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417FAC71150
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D373D10EA5B;
	Fri, 13 Jun 2025 21:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uV/yb7yC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD10910EA58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaT0VpUOUMDyIEYh20qWvOEfJ1s60jjApeIAVvF+hlgLddfysjlYyRMQdvYpWDsTd0ZI03H4K0WYwltLNcIj6+UZzS8rzAQwH5MtOOZaeq6YbMba/QXMZuPAPhaKOYvaz+Tey7iQxh+ryCmJryhM6GEmBt6CCpxYnwC+yzAgo9Fm85HyAFx2bUzods62tm4by9ejFPUY4f9MF1EkvACmNDiz4upy/5RIxuI5Broht9THPZES+4750r6V1pEKNXBUij0GrPYdtwgEMM/Han/ZR2z8b+h9Otz2tBraEhC8GKzAaeZm4yYDr2wYPe1YcWpYkALInLr12cgv712Zgox/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SODA6bJUutOTHm1nGWjGMmpFG0+OlHLqU+BWvjG9ATs=;
 b=FjefcfBCygG8THSAx0EZC6t6vGzoPHIVjx4ZxatxOw8kMpsWPwRLHmmcHvH80/XCdriQ06mg6eXjvM7iRWg4crL/YcOx+sPxV562s4kNnP5R1J8Ve9W2wZpN7H2HIeaY+nbB0u2r5FC/zpVF6y9jorq/v8qzCCxMgOVeIERQsvAjVkXDT82H6yzhjWkVTfkzTSEki/58WFXa6T8v2QOCP4UW4fCQpb6o9syOkG/X91Fc3QMkWccZBczlwKSDyb1tgd0pnWa/oBro2enGUAggKXRu2NP78GKQ0GOulksrmwt/6XoGqt64Mrvi6+fu2/8VBvPaJFpIojAGI8/Cx83bzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SODA6bJUutOTHm1nGWjGMmpFG0+OlHLqU+BWvjG9ATs=;
 b=uV/yb7yC3smyi7JkW1qIsaM91AXxexJcdNn2WX93/D6N/pojqBUNC358jrN4VGjGgnwfno42Yw5wcfvCXpuV7eAhZ0eWo0XcwrsurTMFhDajTtn6n7zmAulrh4NgRHkNLHaZIrQbVxlIyPRP2WMlhFXeCu6iYXSvdZBSdpgOT6M=
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 13 Jun
 2025 21:48:07 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::65) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/27] drm/amdgpu: enable legacy enforce isolation by default
Date: Fri, 13 Jun 2025 17:47:24 -0400
Message-ID: <20250613214748.5889-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: d977ed90-3a00-475d-81e7-08ddaac3fbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmlVTnVLTmovUHh6ZGxvNXMxWmVMRWVjbktyN3RyaEQzZjFUWHo3WlplR29O?=
 =?utf-8?B?ZEZBN0FOUysza3dsc0sxTS90bEdycFdmUXBrK2NsbndCdWFZczhjRXpnWE9Z?=
 =?utf-8?B?VGV5WW1UNnpKdFRmbTAycFZ1UHpub1k5Mk9kQzUrcWEwRHlHU0NZOTFoUTJD?=
 =?utf-8?B?bEtKZ2hsZkd3aDZTZENjdDQ4TTNLdDZiWWlxY1p6b1M1N3MrQUxhY2dXMFRt?=
 =?utf-8?B?TGpCNkx6WnI0SHBab1FGSEJISG00bHRLZXlNRmxaYTJwNGpwWCsvOTNuQWQ5?=
 =?utf-8?B?VGh6TDlxekNUc0QzL1BHell6QkRwYkZOaVRtdlhaczl3azMwTjhiZ25NYi9Z?=
 =?utf-8?B?aXBLdHZLVWk1S3NMSVc3SjloeXFTM0JhWXg2bzVkLytocGJmaGVZdDJGZVoy?=
 =?utf-8?B?OWtBTm11Zi9uT0NVNS9zY3V4YTBvNjVyR1MrTHNsc3BOdExVS2o4VTF2T1Vt?=
 =?utf-8?B?d2EvMm1PdkR0aHVaNkc1MWRJdnRNeW1yL3VHSEVLcE5JSXRYMkR2Vm9mR3Vn?=
 =?utf-8?B?SWpvSGFQMDN3dS9yQ284d1hmZVVQMHprVExlVUg0M0g3TjZOZGdqOEl6TXE3?=
 =?utf-8?B?QUNFOHJaUlQ2dENoQzdRQ2QxcnRPNHhNYzdWQ2RVQmIycFJic0JRdUwvNmRL?=
 =?utf-8?B?Z1BTbHRpaU5UZHkyVHFyY2tNMmovTjdRQTZsRGVKTk5YSzZFY1NTaGxiVEhX?=
 =?utf-8?B?Y0E4Wm1PL2dNS0Y0NHExZGF4VFMrdlV1S0RDUWp1M3hFL1gyMTJobUM3OGRw?=
 =?utf-8?B?c1FBdFlFcWpmb1ltQnBOMUE1Mm5iYmhPUlNoTTRoaTdDNWY1MG5IQ1VwdFYw?=
 =?utf-8?B?REN1ZEtmUmhFTzZjOEJvS1l6dHd1aHJkdXFzUnR6M2IyRWl3UnlSdFJnbkJV?=
 =?utf-8?B?VnhQM09FSW1GNEtOVVFuWURoQXZmZ0UwN0Y4TnZwRnBhS28rMW9tUTA2eWJj?=
 =?utf-8?B?ZHBXQVkxZ2JmenQ5NlNkV3RObEJvcllaVGgrZTBrU1lOanpSd3J6ZS9COWFM?=
 =?utf-8?B?TVNKcE1BNmM3MFRJTWZKSnhDbXNOM21DemNzOFJqMzZLbkZ6ME9yZFBOM3BJ?=
 =?utf-8?B?WHQwaDhmbUNRTFpiN05tdHRHdkJyQm5XYUwveWh2YndyWHhlSWNhbVg0c21K?=
 =?utf-8?B?UlphSlN2WnBBRFFKazUzWXd5UzFHYlA2bTZMLzJrMXY0NC9FTUdUaGZQMy9E?=
 =?utf-8?B?YXhNUzdjais0V2ZIcnl0V2JOaXRzSENhNHhGU0laTlJkbGlNaUNuYUg5Qmh4?=
 =?utf-8?B?eWZ3Nk5IaXc2bEQ1YUdma1VWZHlnVGt1NnZPMVJwN05KRk5NWUYwS1RGaDd5?=
 =?utf-8?B?TW5IcFArb043Y2oxRldZZVhkck9iQ1lQamRnVFNPdGlSRUhJaWxmTUNkS1la?=
 =?utf-8?B?bTM2eGcyVkNKczhNdVY4d2NPRTFyT3YySVRLU1kreEQwY1NjaUtPMmtIN2Q1?=
 =?utf-8?B?R2hBZWM5dFhzMXF6T21sVmtldVdna0lXU0lsc1V6akRUelI0ZzJrRFNwMThI?=
 =?utf-8?B?aWxPQjh5MzQ4OFZzcVVkaXVYa1UyWEpobUt1NThsUUJVZzAwZTVqcGVVblRL?=
 =?utf-8?B?WEdiQ0lnMDM2YUlYUWZXWnZzRUdzZU1nd3dWZUhZM3MvcmN0N2tXVVV3aUZC?=
 =?utf-8?B?RUgyWDEvSFA0bGlCc3VtR3MwSmJna3hsVE9PRG0zVDlpdWtCa1hxVjh0c0Jh?=
 =?utf-8?B?QTE0VlYzc3N0ZVRXaFZmRWRSNnRZMXlZRlBLODQ3SnNEcCsvWjN5bVRKZWM3?=
 =?utf-8?B?ZDh2UHluUWU4SGI5U1FSL2JZSkRBSkhBeWcyV0duajlrSWZ4dVhJNlMzcGE4?=
 =?utf-8?B?aTVraFNWZ0Nhc01ROHFJZmhnSWIzNlBrWWxBQUx0RGZCelVkeW9JdWdGTmZC?=
 =?utf-8?B?ZGdSZnlzTVBaRXpNR3F2SkRxYVJHcCtqZ3djKzVSZ3d2UmRFT01YbjlhVUc1?=
 =?utf-8?B?cDNBYzZ1NXVyU09EUGIvbmk4OTVwQ2UycTRRTmpkZjkzTmhlcnV3U211QjV4?=
 =?utf-8?B?ZnRFZVdGbVdmMERSYk5PNmVaS3dnZFNweVlWTy9QYzV0QkMwaFpYRlY5T2oy?=
 =?utf-8?Q?D/7V4i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:07.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d977ed90-3a00-475d-81e7-08ddaac3fbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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
index 4893f834f4fd4..88d4da1df6af9 100644
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

