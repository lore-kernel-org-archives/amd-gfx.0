Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F044FC5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8843210E81D;
	Fri, 30 May 2025 09:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JkLJw9dB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92DA10E81F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH6bkSqUaVidwXICvM12gW/pXKtqJr/QKC/9fE//esj5CEVBylS4tOYMPWEvjqUtp74ShwcAjKYah1zjsl3NcbMyleY4DNRiM8XBpMw76oeJ28xkESr+cHig5fOWafm6sEcmJk5zfMY8fG9iYnb4Y/i2rd/cG/EM5u6oMgmvxK1bJghNWDwNiOpahKXuEr1C0FG7KEPHxMx/HHPQ4d4JyVaJdkUvIsQzRWVva3gHGDM//HGh9g3N/8ZBrh5zDmI+xqw/FFgOPuMQVyij1TEdyUosfRv+UWutTRCeDqshtjDymI4sFPXJDRXnjre8Ep252DGJ5c8hB4UcgzEZlCfx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8vbdydDng6wcudodUlJK7jXcqK3Y/soVhGZAYr7xws=;
 b=x6I3P5srKXff457wC0ttZQK/xdOpsg+UhTZGk2nuAjd+anbjxA0lItIYJgav/tqjmmSITidt3y5NPAmDMjofwuplY6bsaVsNJutbFdiidhaRCBQAtiTR/fl76hlUGrkIkGl/BXfo6RUEZsvJE1S+6huE8GLcClOIXMGS2BBHIc9HctJ/kceNgFUnmN4a4cj2SKr4ZhhiDMkatO9NTjRc+m05tytarTyCQ1+K8c3aW1FHR9s6KJMZ2/rMnr28+M+3Zp/yrx0YZwM9sbg/AKIcC261opT3vhUCdoxxlKf730S5tpECoq4nbG/+wQlScZBYfIgKn9H0IBkyrPgR6zfmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8vbdydDng6wcudodUlJK7jXcqK3Y/soVhGZAYr7xws=;
 b=JkLJw9dB2Q9XB4ZEQy6PRhwj+u17pMvg5mcMHetNtGTooelR7Yvy+6PlhdwSe6ExdOfn7oxZ8+ELNq9vgCcOAnOrLEbEMbvHyzJzqxd3pzm2jP1o3GKos03DJ3QIJNiueFlzsH/wRKpK0ZlQSKfxmxQycqSESybFnDDt5yvdxVU=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 09:03:37 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::e7) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Fri,
 30 May 2025 09:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:03:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:36 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:30 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 02/14] drm/amdgpu/userq: add callback for reset
Date: Fri, 30 May 2025 17:00:03 +0800
Message-ID: <20250530090322.3589364-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 69989175-d1bb-4bb8-e404-08dd9f58dd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3MvcmxhNUJ0MWMxNkNDam5rS0E4SnFyNVE2VGlSVmhXcHNWSTNDVjZJdlpN?=
 =?utf-8?B?U2MxM2FYSVJ3bTYzb1Z3a1BKcm1hZ3N1dkhwdjMvQzZzRE1LZVNOQUlpUDVy?=
 =?utf-8?B?cU9KSlpGQ1hDeURZaGRzTWY3ak1uZWJabTIzUWJsMFZhSDNUSW9XMGtuU3dm?=
 =?utf-8?B?cmcvVk1yMDVSUkdxTk1rbVNuQzRLYTJpemVUZnBIbHphTnhRQmJ1Um9rZ3Ro?=
 =?utf-8?B?NDUrbytaYU9UeUdaMkRCZTVzbVhlclNya0JvQ2h4WEFSdGVDa3ZSeXZwelZu?=
 =?utf-8?B?VUp2T3FvaHREdmx3UjJ6S2lsQmJMKzNncVNJMVBJbG5leUpVbThaVHBsb1du?=
 =?utf-8?B?dHltVDRHdzZhZ3JDL095dGVYQncrVHZnNzRXOCtpdjVUeGFCNzFDTVB2TlNI?=
 =?utf-8?B?cmc3Yk9vczZpZlVHQVAyLzg5cGtObnNIbHRFSlNIR1d5NEFQZW9wZFZ3Q2th?=
 =?utf-8?B?NFJHV0wxeklveUl0aDZiT1ZzRHQ4enZ4Zkd1cWFRelQrd0tPeHBJUENmdGhZ?=
 =?utf-8?B?RHJXQmJPZWp4bVhHa04xV3RNdjRrczVMcSsxQldmbHQrdjlLNDVSd2lrNGRt?=
 =?utf-8?B?VzVZZmdHaE4vNGlmclplbjJKM0pEaDhMNXdxTmVMaVRNYmZVUnAzUFNPZUxr?=
 =?utf-8?B?TkxmdEl5TDMzM1Z0WUYvZ1pNTCtxOHRJMzRxS3Rvd3BmYW96QUVvaTRSYzVi?=
 =?utf-8?B?K1NkMWdtVWI4Y0duSmlQeFY4WFlyRUMwcUxvVVkzS1RWUkpQRmdSd1daaVAx?=
 =?utf-8?B?eEtpMm85MXAwNkRMS0pMZXJuTHluVmtFY3BERzd4ZWFPNXRqU0Z0RFpaOE93?=
 =?utf-8?B?TW9WT0xXVlU1NWtlS0JsQ1NZT3dnWTk3R0tLSUN6Y1FvVTBZa2lHN2htcVJl?=
 =?utf-8?B?S0VLLzlvSjg5L1pTTW9zKzBlR2dPWVVET283UTNpY3JCSGNDbysyeW8vYzdL?=
 =?utf-8?B?UXRPNnJwS29ydEVSVitBU0ducWVmWE13VHp5ZVIrSjRESUNsdVFKKy91SkZ1?=
 =?utf-8?B?YjZWVkFGVTZJcnZEWmNQUm5RL2JNNEIvQ3RvdzVnOTBtaWVpdGpXdGtnd1ho?=
 =?utf-8?B?OVlxUjRlSEdxNi9zdUtXd3lpWWE5R0RPSE1MTXhNc2g2em9VQWFYWFFkSmV5?=
 =?utf-8?B?aWhUUnBOMEUrOGhLMTkyczFUVDNqYm83NURBTzhJVXdTM1k2UXlmTEtsUnhx?=
 =?utf-8?B?aVVnVnJyaEc3R2xOS2RXaWprbitNSkI4SjVFS1VyYzZoajczaHJXd3lhZ1N0?=
 =?utf-8?B?QkRDSkZvVTUvaFdvVW55TUJ0N1U2WnJlakpvN1NXdzZENjJOVWc0Yml5bFVV?=
 =?utf-8?B?QmxBcHNGK2RGRVI4TWUzaDJ5SjRoSEdmSFNrYTBMMURjT3ArYnhTN2MrQzEx?=
 =?utf-8?B?bSttQjJXZVlscjVtVGwxUjNQM0lJMWs1enNCeG15SndvV29QQ1FmclpOVzdh?=
 =?utf-8?B?S3NxaWV3VE5aa3J6QnZqcktoK1lxbENRTVpCc3VTQy9zUTZvRFlQTjlPWmVC?=
 =?utf-8?B?cVVwM1FFeEl1THN3VDJlTWtYKzBKTVZHYVp2ZkJNViswMi9HcGNFdlBZaWgz?=
 =?utf-8?B?S0hCQkc3MGY3QVY1bGs0cnJxd1NXbE5Dd2FYRWZwSXJpQUQ4OWgzdUNVSUJs?=
 =?utf-8?B?TnhFYnVvNUFFNTlQUTliNU41Z1dnRTFpQkN6L0V6cjN0YWE3SEZWdVhOWWZs?=
 =?utf-8?B?amlKVisyM29vWHZTVjNoblljS3BhMUMrQWcxTXAwUm5qNjRoZTVzRXZFaDkw?=
 =?utf-8?B?SGt2RDlHd2JYMHFWT1d4bEF4L3NTWHErRnRsc2xxdUJPbWM0dmNhb0lVMXMw?=
 =?utf-8?B?NFYwZ3lVeXE3YWE4d0hna2JHelhGY3hHdWtRMVptbkpuNmZ6L2wzMUpLY2Jz?=
 =?utf-8?B?UXBXKzVDVE9uSFV4K3hvd2p2NmtxbE5aL3JRMFl1bkVkbThWZGdHTjkyR1N0?=
 =?utf-8?B?SmxrajdFNzM5amI4VlpWL3RpSWd4Y2x0SEp1SGR6NkZYdE9jbXFpbStpNzY3?=
 =?utf-8?B?VHJSdEZIaEEvYm5UMnNROC9ZSm0rb3owVjhMOTZIYjNiaDE1cjNXM2duQ21h?=
 =?utf-8?Q?JjqPBS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:37.4126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69989175-d1bb-4bb8-e404-08dd9f58dd42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

From: Alex Deucher <alexander.deucher@amd.com>

This is used to reset a queue.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..3cc0ad8919f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,8 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

