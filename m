Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C602CF2560
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3C10E539;
	Tue, 18 Nov 2025 22:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imGtU8tw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09DB10E539
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPGevXKjlvuDUbI00+44bT3cdqIBDFYxtiQUC7Ftxdc5y2dNzPMID95xJRNxbVqzLm72Tk3qtrEleAP7dpijEmArMEOdLvGDf8SDVvFohSnO37uLJJkW+5mDBHdg6QXfk5xIaXCArADpWyytVd2/mTUwiOkakmO5b5Y4XA4aG3Gi1PjPrSLNj21QdYk6nUsaiSk4b80KmdnhVI3w+ZF+XTvE1XVX57STpaTWaasLJJOUWVTkLfJpBJ1f6me4WUXLzeTsepcT0yNHjS8diuvqBz57iUwYnv5A12aYG4XJLWAZubjXgEHjY/UMyA1Qu71PhPKC932gpazQmN/jxQ+jPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeGU8h+EBAzyJp1cJ5RKkWuz6F5nmdTOoGZKEQVgA6A=;
 b=JQHQfLsduw/nlvSvN1Vi8p/xXZIn2cbjZhZ59YSfyKIhp4dX7Nfs5LnJzIuT3FVkFmljdSNJOqCqY7WyhIU4kYZTAOAtqHeZyLX+HbvqvFLoR6PC9bDHXnHHnU258WFHGLqfFLdzXMVc4gqGmElKJQxdip7+BaOhuvRb1nctiY0khOe/3Vlzo1ngbAMdUx7cr9/ZaKVU1t8QFaXO/Xzptjw937PdDFiLyRZ2zUdMg0U+tQQNQvirdxFI5tvaemCH/mFtF4h1lawXlwpUCXcrCTzZTTmalvpCBTNP5bfj8k/hzuBFG2EgzYZFnzmobMyZXoE+83V8atXK3Awovye7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeGU8h+EBAzyJp1cJ5RKkWuz6F5nmdTOoGZKEQVgA6A=;
 b=imGtU8twBB8ehOVY5G3m012xu7V9n0yQvA8oUN4KvkOAiKN03BEeqJ3ipAytAFd8oRIWa9HJoU43A2e4sJ4RubvThBimmEyGEVXTuGE8ywyWBN8NCGIwCpDZ+Q/oqb2tt0PITkFG+eec4kYzUSfEBpb5xNzB9fFSXFhxaPUIR+0=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 22:58:03 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::a) by CH2PR17CA0024.outlook.office365.com
 (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:58:03 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:58:02 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/5] PSP 15.0.8 support
Date: Tue, 18 Nov 2025 17:57:46 -0500
Message-ID: <20251118225750.3613219-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: eb056f0e-cb58-4612-0112-08de26f5edce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nUubetke/JcruJGCFFRcgE/9GJpiJu0f6ykHIi0uO4/sceqmiSN5pCZQAPrk?=
 =?us-ascii?Q?wHGH7PZ5WkWzR2Lvow25zqkF5Z8+/rzSRLBeZuDxGEegwZmvDAksQfJupayO?=
 =?us-ascii?Q?6V6QRAL72uIVvyQet3klWi0PVg3/HcU+LDflgxgUWL/DkMiPAvhyqYF4CJfK?=
 =?us-ascii?Q?7PBIthaGR44Dy26zqIE6YhOpKhvObRQdFS9OpqLl9ofbHLWoQkFlEaInUA+Z?=
 =?us-ascii?Q?+oDOt9NVKIGi6UynF5U2d7I82McQRsISbRCZz6CHYvcqip5d+K2gYe6pn2xc?=
 =?us-ascii?Q?vFFTuQVZu4WA8SfKHkzk9HgyeVX5uHavrG2XffT/ns+9lk4zC4eIa/xVILku?=
 =?us-ascii?Q?xIfn1ujVFN7c+OkL0G6OroRcs0gnQ52R93t/nKJh6TwLtg+RecBrydbOM2mf?=
 =?us-ascii?Q?3ToIXK4V0N/4z097krd48qXCdJlpZedi5zugznrCKv2TM085dbOd47xQM6dd?=
 =?us-ascii?Q?KmLyAublwWCk1Q2pN2Ce4Njt0LD0gzPpWup5OISEE+4X9riO+RGT5ar6Ru7R?=
 =?us-ascii?Q?AhQz6QaPSp0cESAQGOf72cm+TRkYTJB52a3W2lu+RMRx1oUiWQY7I7K9uJJy?=
 =?us-ascii?Q?fX7+dZaFZKVawusHPXUm7LfAWkcjtmk0Ocy/Bm7z6sZ0MLEZiAO67jUQV8fO?=
 =?us-ascii?Q?eqNkWGrGF8aOXTlEwsq9/SWlOfoF/XX3ZTxi6dIkr1CWFplbFJ7mdx8wy1w9?=
 =?us-ascii?Q?5zAJ5ud3NrnjzRX6dhkqyEqfCx73tFAJRRmX3cgV+DGy5cSmcmf00EYD5PVT?=
 =?us-ascii?Q?pB1giC3TriejRtvnoB7RGIJmVy+ayqY0gnjEbPUi7wRlcIm90Ta/8yWigwU5?=
 =?us-ascii?Q?cuGyIcgAQlbUxJtUm5p1UagWmx7cIgD6ZlJbAGPCnf5dXp4sxS265lDIYKNR?=
 =?us-ascii?Q?/SJJpUcbTPMwLQhPQSpfZH8lfQBKdyK98JAVG0qbqVz9NK8M78iRk0kHIZkD?=
 =?us-ascii?Q?6Ku5UpUf4VkpJ81zDtz33MNyQWrIK0ECEBsT1BSb68MgOufBQJhTFD+Iu5n+?=
 =?us-ascii?Q?hwfGmKqHYIRI5frgPTJst5znIRvbDTvlZS2nRBcQdqaJEViUB6cKRxvxMyLt?=
 =?us-ascii?Q?annvjD7trQVi/ibinHGJIVcD8/u8Fa12xjXUo4vKYi7C3VFwD5GNoZ/+8MJC?=
 =?us-ascii?Q?v+bgBVGObcPBJo2zs93ZHQ4ies5AEX1L5jg+jUXrgJZgZiuuFz5frGUDqumO?=
 =?us-ascii?Q?qFjwyxmw/Xb1M66xB0PyGVizO8gmVRQbqBBaPzJy9KAAU1Lic2zq7meW/kXy?=
 =?us-ascii?Q?BhlsBTHV1kdMUmKsehOALwTbG53xYV6yb16P068pjd18ltyRiLGpM0JYJGZr?=
 =?us-ascii?Q?eFH1Fv6E0nWX4VPcHopMb9C6ALRsFOS9k8KT78y0vfr4a5lbSK7RDKzim2Jz?=
 =?us-ascii?Q?YJ/E+EyTY0avJ0GAwcZMhQc3EhdQ1soL/4dNk+vvtVzJUn3kKPD3+VDAl5Nh?=
 =?us-ascii?Q?ALTg6g26Sk/4VoLXTJjxE9wdyZFd9JrGxkSOUUD+AzHV9CbkKw5+FZiIwVYt?=
 =?us-ascii?Q?ghtTxRBskGw8QJsfhnqHphQ7WfAUb34WrY5+tRPU3me/PdpKbbjxE8KeCw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:58:03.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb056f0e-cb58-4612-0112-08de26f5edce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

Add PSP 15.0.8 support.  The first patch just adds
register headers and is large for the list.

Hawking Zhang (3):
  drm/amdgpu: Add mp v15_0_8 ip headers v4
  drm/amdgpu: Set skip_tmr to true for psp v15_0_8
  drm/amdgpu: Upload a single sdma fw copy when using psp v15.0.8

Le Ma (2):
  drm/amdgpu: Add psp v15.0.8 ip block v3
  drm/amdgpu: Set psp ip block and funcs for v15.0.8

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c      | 342 +++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h      |  30 +
 .../include/asic_reg/mp/mp_15_0_8_offset.h    | 868 ++++++++++++++++++
 .../include/asic_reg/mp/mp_15_0_8_sh_mask.h   | 616 +++++++++++++
 8 files changed, 1878 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_8_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_8_sh_mask.h

-- 
2.51.1

