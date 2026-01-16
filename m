Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DDFC982D4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0A710E8D7;
	Fri, 16 Jan 2026 16:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLX7R6s2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6E610E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNRH/AAR0/Qwj30JuNGavKiK5figRYFyWIUtr0irpe08Xt1QQ1eyzXKHLZhR+0/yTBH/hbz+Cu7CJXH2JdUUGKjTu8rDjORqE8oEAWSpRTAESFCYdat8pc0B+K2Knx7+tifa+YMJAgRgjvPOSL6eCdz/HwgM4hLVHkdt+XLx2VmA33EqOZo90Cg87u6fL/UVSPOK9Pp4PXvytdJozdQotp8QV2vl7ggZVWGRyUDi3771sZDka0ggW6+9vhsjKATWKi50NipaAbaAlZie4BM+ar1wNJLd5CU+m2MN/1PPFfY71C3SqXXnPC7oTlh3fEw1+04OkqXocU41q+PggrOl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTt5aHsZOn3tTXw/6VYVWn28CSC2lxjg0qDYArCQCHo=;
 b=ov9Tm7Xn8zsma7Tx9FNWZA2EdtzCY9e+yacJ7nKXUxK5hljNFru9uMNWOFfRsHehZLSrTv9+H2KZBZdFpRppF6tJxyfewjEYn982iKjQS2/IBtgdZuWZKXP6zHkyuifvk0P+kquowp391wvb4eqI3FknU5IItI38CQlA15lMt4JM7bes5gNPV8bCjA44kIZQ8JrPWM2Tg9exakzjPRRshtDoBRT596qgi5iZOmi/dkRU09lMk26E2CIW4qlaaWze4RMdxRETmF5o5Sj9/X5YPj6kUv5iP/RAWQSennemApLUZ1h3ahfLb5r8YqOw0Rj53WIMfHv/kIVkAdj5qjq6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTt5aHsZOn3tTXw/6VYVWn28CSC2lxjg0qDYArCQCHo=;
 b=mLX7R6s2zMN63SRTFJ5AfFyHriMrGcvS4taBXPfQ3fX5g9X9RePcEpvkCKVFnL1f+3V5IRKYDdOh2cX9ouAVsa4RlurntBDWXMYQeX4Kg/6tI8KBETNf9EC7/TxxqA8Q8veB0Vuerahe0N0QNlYOyU/WFqTaMIgzHeRphM9xqcI=
Received: from BL1PR13CA0360.namprd13.prod.outlook.com (2603:10b6:208:2c6::35)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Fri, 16 Jan
 2026 16:20:41 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::c6) by BL1PR13CA0360.outlook.office365.com
 (2603:10b6:208:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Fri,
 16 Jan 2026 16:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:40 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: fix type for wptr in ring backup
Date: Fri, 16 Jan 2026 11:20:18 -0500
Message-ID: <20260116162027.21550-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c35dc8-dff3-4ed1-0809-08de551b3147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8eoHfx+/HtWBBg8E+NC3EZNtHoyjfqY4JiXygRNO8JKsvs1Jo4TiL1wu39Qw?=
 =?us-ascii?Q?Ers3sFFAijUYfNY+/u1SUMxMSjvcEQgDRrgZPaKuK53RJm/lon5/Iir30QDv?=
 =?us-ascii?Q?GjQ0dO2ZzSzBDIE1L0FYr4qNRvJvEa8aMlrH1kCCN21xtAFvHS4zSzTzkpry?=
 =?us-ascii?Q?zffB/Pj4zmzG9uH5ZFlYwafYmntQlOBLuTznXxakU0fHZLbVbDJsFEkOhNYe?=
 =?us-ascii?Q?3jCQrSCiaPaXwbNCg+z/ldD0VBHQKWl7waU8Me687XNG6WFxO55rWvBYceUt?=
 =?us-ascii?Q?qFm9sMt3CHS85M30mGWK/c3QD7tomq++IeANRmcAD3yvdHINxXMf/6/5FXeT?=
 =?us-ascii?Q?ysd4MZDLEjTQW8A0QYooxM1pLetDZSgy/xyG3XRnuggIaMEP5rVXxdRhR8/a?=
 =?us-ascii?Q?QGm/F1nGENdE1bhcL0kkmguk87Y/2iqprDNG+RNHGxUjM6fbwbs8P4HfNNNx?=
 =?us-ascii?Q?RddGI44JAsbMeMaaYZ4Q3wmdW1MATJmEqYVV3Ndjuk0Yn1aX60SBdv+5CLoU?=
 =?us-ascii?Q?lft+10V0UdsXyZhQ2WM6l6km+ia5kAT1j0ebwlRuuMkwz0WeSBo3GXJg3Ou8?=
 =?us-ascii?Q?koJMupvneV7WkTzfF3wIXwWzvmE+AEOdzUJ40G13zh+PK3M4qAMb3TBivnwN?=
 =?us-ascii?Q?dft05zfCHD0qA96DIuqJFXUtHg4NArsXOCg3dNds4ERFGLpoWSjdCSP3lDR5?=
 =?us-ascii?Q?0dQViEMGvcuYXKehKdGFZGQ2jovQCxP7glBcheKBXqT4nGcPaaKLyaLK0eZU?=
 =?us-ascii?Q?2/KJoa7z/BAtO1ZHGrQoXHCDHOhc7RnlVxalfKaM/Fq1XDuj8ctGB0MjuxZG?=
 =?us-ascii?Q?QBBBd80eVGgT1Vqf0BuHMO67wqU1WxEDrh/gig6zskkH3Ezx4LcT9ewpbu6D?=
 =?us-ascii?Q?F0zpFlZMv2CDuxZpQD5aCns9Mr3BPPd48aqlwFqHxCOWyxADaYXwhV4+G7YP?=
 =?us-ascii?Q?E8pQVxsYi8vsBPIh5kvnL02NWQ+SvSjkiVuNfaXQksqPB0KLDAb5vfGz53X7?=
 =?us-ascii?Q?BRK8laEJeB5WxkCZ8gD1QeB39OxjyXYa7guwAQ5pnV9QvUdtm3x37sng/gAi?=
 =?us-ascii?Q?UQvQvPwqMn0zX8h1KY6CTbA14nZ2LNLr+ivwjw1EPEp4fWOf9bDl1TCagXeG?=
 =?us-ascii?Q?BLMJtLrKi7M1efvZ2i2xE+93fndfQigh+GDL79LKfSCtImn16nlgoEc5S032?=
 =?us-ascii?Q?OuBBIBu9i/3j/n3D/Mld/8ZArdcVzI1vpnddIStU8ewhYPG3HpA/4NDzPlwy?=
 =?us-ascii?Q?9IwUgj/Z66PMgZ256C/2ZWW/atLgtYAZHSUOs/ofRE8otQyelNd1YbyFayV2?=
 =?us-ascii?Q?mZtWkBEaoa7IhuWwMahcikKL5EgDirugtomDZCT++C9HV0YzfGmBFP0KUOge?=
 =?us-ascii?Q?Wuyw/LdiZCRWvJjEfryp2NMUO5qMZCaN5vN1HCDHz1TBeDBKfKTyhfdxovVd?=
 =?us-ascii?Q?fQUP0IQsA3F1DrFXJkPo3BD+O83tQklyJLCFR55JzxPNAce4AQA9tGvGYUsq?=
 =?us-ascii?Q?DiiMkr+EolXWAzwOyWfc48pbUiojtMApX9lZqY2yWzuqGy6VzIKSJBcGj7V7?=
 =?us-ascii?Q?sxViIHO7IgalGFLZqvTklvim4uZTFF74RnBZvkWFpoBi9Cmr/Y48GLQfhOkk?=
 =?us-ascii?Q?ltPPrebkkj6+/M4ZFcgqLR3hLYCAWDIHnUZx12yITwb1lvLnJcpqLPwEDNb4?=
 =?us-ascii?Q?qIxAXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:41.2039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c35dc8-dff3-4ed1-0809-08de551b3147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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

Needs to be a u64.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3a23cce5f769a..f2f0288b7dce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -764,7 +764,7 @@ void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u32 end_wptr)
+						   u64 start_wptr, u64 end_wptr)
 {
 	unsigned int first_idx = start_wptr & ring->buf_mask;
 	unsigned int last_idx = end_wptr & ring->buf_mask;
-- 
2.52.0

