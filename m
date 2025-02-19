Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6C0C021B2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 08:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250D410E478;
	Wed, 19 Feb 2025 08:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vfb/u4tq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18A310E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 08:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmZz+l/J427RPtVUBOFeLUmJqQA4ETRqhavotux2icDZz5CZnbegc9vtUA1sRw2ZRU/EsLRg+XyQS2DUXsIyagDl8HK6+M2rq/s/pEsoNecFJECDpcTDzTTJOKOvDlz0QdqXqk3V/frFuejyUdRe0opHmpI0YSlWBNcMqd1AVRcrLw5xrTgk3w9gitTWfoUfY8y/WlzHCLpbUJnFOgaIMbkaKI+tx0VG1bzUdadIhFr3/jpZTsoutDG/2nc39zV0fbsT1jjxYd9S8ILb7MedutVTekxWfqJ0v399RYetB1leD1tA3EUrnrXjIZRmf2kQwR3T9WX1BQdy6sdCeLJwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=W7WexjYTlSALtLBJrD2fqWVBBmjs6ARtzFIGbdGW2pfs3hb5A4qQcYmR5ECVsY18pFCyXcDf5f0NCGU91xNGVGZKJV3WBgGk8Ikpb1YxOjsvY1oatmr2xcmSeKlfIZm3Pvr/r3xDEBSRvagd3qjlNsirRYenxyF2vo82eQ/ZVwf39OnvM3VvZdlWrZf4bUSno3lPsnb4Uh9VOVkum0ebFwwZtNE/nm+V8aMZ1rx3TMYDAq7VisyyomUSfkx6ibqq3xhVLbE8LuNpCuYDsXvDLXVM5olXbh0mEJW6VneLrmNSgv0w+TGUBg4Zo29XLs0u8lyEVQv3eif5Zve/Nc8Gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=Vfb/u4tqtBVbwNdnZGWjkhrYa4Cvs63rINFkVsZp6yWqJvni1H88rXNv4fRFmXLY/nOdI1Nnq8HBUBZGVNVKHwPym42VHgfLU2NzI3RPWaWkE8M9TjpZ4TDfrCEiZ51AL/cfDEjhCeekl3toVs+UV3EimWmrWaqvIEzXoSgiP/c=
Received: from SA0PR11CA0088.namprd11.prod.outlook.com (2603:10b6:806:d2::33)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:00:44 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::56) by SA0PR11CA0088.outlook.office365.com
 (2603:10b6:806:d2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 08:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 08:00:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 02:00:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 02:00:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 02:00:40 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH V2 1/2] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Wed, 19 Feb 2025 16:00:39 +0800
Message-ID: <20250219080040.3547468-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae5f940-fb50-460c-1cbf-08dd50bb826a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?13jUzN0BtH60TLGgFc/noz8J//fXITzqJJ/Mewi16uknO067qQ3SeL3saYMu?=
 =?us-ascii?Q?PU6izLfcece4XaxnSQMJQ7KFtSLqGwImqVqhaSA2+DpAQCIpuwQJVAN190oE?=
 =?us-ascii?Q?eEy6pYEPC91wjP2ieN/2snqoamIS77lMF+30u4IkHjfGOws7nrq2wFSozEhp?=
 =?us-ascii?Q?IG5ntVpIh5IaEyW5ZiG3A/Qq4OTViA8y7Vdx5BPZ5CcvmkBBNoJr8cH+A3Xu?=
 =?us-ascii?Q?sKU7thuAJgoV1rS/2S1ZDQMU4eg2yTzQtv9HVIepRLEismv6eEEcSzqOUjLz?=
 =?us-ascii?Q?XAACwSck6ttRiK5JUokffM4VjkMitr4nKnvXY7lwBNa0v9ydes+DCPind7sh?=
 =?us-ascii?Q?6x5xvl8zmJ/CLMvLCY3kgaWrT6IGrHe9M/c5NDSjjmtqtbAjvFZ4Cq9NxaKh?=
 =?us-ascii?Q?WO4kQZfPztcy+h2dY/Mkk0gLVRO83R42TXtm0jGaVczfIK8VoLlJ/DxTmisY?=
 =?us-ascii?Q?QzjBq4njP6it+NBBn8Hd0aIz1jFf2k0Jd4swHnwA4YodocyUfV6eEc86YNDl?=
 =?us-ascii?Q?cXPw3iQNaYlHK9VTm9uRUl5wdyeHalxkjMZypPJ73zhWdlysS98RT+af1yY8?=
 =?us-ascii?Q?p8uztuAvAKwERg/41CiuNirvIlqOROve7ecpVARnWnwo7++X/6F0TH2n8XG1?=
 =?us-ascii?Q?VNjsYJT/eBQa11IBBK1XcuUGwWa+KyAahGAauxWNAT+3nVLL0HKeLpYIfX2k?=
 =?us-ascii?Q?DG3RdiXj6c9FjINdpYC69Aie/a0maXAZfPR4lQpJWlFddfxMiVDaxpS/jeub?=
 =?us-ascii?Q?eBAQ6npOSPnAWk/KTkPP3h+UgJNaGYyxdLRPIlGLUXz6G1CE78fxlZd9RoIH?=
 =?us-ascii?Q?FjtqRMF+SBIyBu+o6iK6FR70U1J4DMMAMADUvbuajWM3YYwSlk+eME1NTc+J?=
 =?us-ascii?Q?E3wq45G6O0ZmlZyfvH/fkTiW9KBOPFVWYj7KF9C8FUcDZlyQp3yzwwVIL6ow?=
 =?us-ascii?Q?cqkJVBui3rJfk3jflfevc+oWVfNC3Hq32qhZfuP6QWyVs54Jgjzv4Y/PUnsD?=
 =?us-ascii?Q?ziHwJqKhnXSsGfOKZVKjzVH2rIVJ+2g49xsuMifP4scQffEk0s2EYHzd2BIR?=
 =?us-ascii?Q?UvSSdfAFkkLOCRyMRUNewoUcRzVP/bK1MUEyCCnygKqpLzPL6r3OHZ6p6uTn?=
 =?us-ascii?Q?gL//fSk0HcAjKVuZV5ot5a1T5A6F7xrTa8NJtD0Ng8joOXIhk5lXVEWJWLMw?=
 =?us-ascii?Q?zd3xFJqmBWP7tHyVFJMfIaxoYqiB0KXebMWq+MUjbvvQdmPVIGH1EMYU4JMv?=
 =?us-ascii?Q?p2lCY0I+6RVySOnzIs+zdeg4wyEIEw9MOysyuEBW/l3FABOKKp1LzOFAMTNI?=
 =?us-ascii?Q?kX/SJDmDMw3xTm5Wr0zL2LpiPdEKl/E9SftRo4ALQBBE0qJP+6FYgh9opBNy?=
 =?us-ascii?Q?HS1HQ+agcgLN8ODtyMAGKE64GZvdnZScLFisbj16vqH3GG6E4ABTMH0UMoZm?=
 =?us-ascii?Q?KVyFRaSKrzAgVWpSnX2MtuK5NID92jboRGJf3Fcy9ToRnAyeI1zV2rzw1fcE?=
 =?us-ascii?Q?VWEl1umHJFYs9Lc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:00:43.2795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae5f940-fb50-460c-1cbf-08dd50bb826a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 132 to 148.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 182aa535d395..ae1dd7d16048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		148
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

