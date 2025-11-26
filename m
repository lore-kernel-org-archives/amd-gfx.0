Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA01D11186
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 16:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3A710E694;
	Wed, 26 Nov 2025 16:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLKbKTYP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8FD10E696
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 16:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDneb7AaI8f5QQFAh3yOcsPIrRC4q5RRp+XAspjuvZvzdAjtghWp74p7IXQUPZXRW4i5fWeoXlDNK2a9BFFPAThZODZYVd4msyt1+2vrYsG8gFeook6GPG40dttPY8TV1ZU/ml5Mu/uS0M+OMlHxG5T0EO4YQMCA4euHQyY92Sno1ViEmHh2DSBRAQHg5BcuTH40LUNh0EST/iGYH9tD/qP0KDzioEUkcNnJEVgfa76tyh1f1TDYvKh6WAkpQVB2uK5R3zxJNlaDwx1qsR2IKr6ykE6AavzOXpuMsrpZFCM9cRfbjo/Wl4P8DXC+B7pzdFE7MSLh5KybrSh5coFEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IGApmeE3rpOw7Dx04c5OgtaUOokH6F4AOd2m+NQanU=;
 b=kWv0e0h+7j0d9K6d5uDHn1T2Zd9G8PKxRU0WfFFOlNIlrtnxYguJ2nx8IRljfdYwDbkybQwCeAgLLmQxJmW9M/zQErqLwOfbkW7tTRiiUnilIR36O9R1sHiQzfSj4bsH+zpaVEHlp2X/z7CX1tD10H+rRRTDPZW+qOWonILPkvwixG2QuENhDlMGfDhtQNJC5NRFlwGC6UbNHgVpLTd9soYvZ1aSBFuLd4kCv9HAElvRPjX9cVJ8smgyGGq0H42UFLrjrnWUiLr79qpkw5ImXfgkdMvIxpHPfpoe4LaAlXBjagodkbmpL9W/JrEoVd4LZHA51Glv0WqqGZhXm/MIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IGApmeE3rpOw7Dx04c5OgtaUOokH6F4AOd2m+NQanU=;
 b=RLKbKTYPKeFy7cjqDg9kuelBb09fNV8pjmNUUIXi/vBzlHFciC+8SAx79jvqkca7/+BSFfGjaFmYorvw5FjwD299BF/hICZtSDCTZ3PSOu+Qd9PeAgi31Lwa/nXCtNG15An6nr/AO7Az+EWgBKObWakRnfrEG5VHshRSYTsUqD4=
Received: from SA0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:130::32)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 16:47:34 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::ca) by SA0PR13CA0027.outlook.office365.com
 (2603:10b6:806:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Wed,
 26 Nov 2025 16:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 16:47:34 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 10:47:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix cyan_skillfish2 gpu info fw handling
Date: Wed, 26 Nov 2025 11:47:21 -0500
Message-ID: <20251126164721.2520330-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 39049800-9925-42cb-c964-08de2d0b7fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4D1mJG8o5GQPybKxFKm1EAUZKoEs1Tg9FVYqeS7upgupwIpGFK4+YGSpqTeZ?=
 =?us-ascii?Q?YO/Nzsk09UWtrEIp9PrxAsOb1XjGeieHPLvCJyaYclk8d4g1kUycnbadB1d5?=
 =?us-ascii?Q?MAlc3/CVso9OibR8/SjLrto1uhi/diEtRa0LGB8cvmKn/OHYyxVu8OOOlnms?=
 =?us-ascii?Q?9U4QP1f/y5LU+wVoouNqYtEVLSLjIm1v4BG2UFXMBJTE7XjnFThrPb+6cDLe?=
 =?us-ascii?Q?GMdbQh7A9lD6Xi010xhOWAHBl+QJN3kz7Ej9QmcrExDZtK2pqWUhEeql6/Ns?=
 =?us-ascii?Q?iKuqGpT/HEeDMCiZPuXNFACeX45td4DoyRsvlqZxZAtR9Yx/r9gDQW+J8wNR?=
 =?us-ascii?Q?fx9Lyev4xzISladLMbyHqWtnA+BjQK6FdqNSoDbuRNJ3xRngj50kjjrlblLB?=
 =?us-ascii?Q?eT5F6sCa6BgrmKijouGvfa+u3C8XrvOTo1P2TpL5j+FSiHWHYjdEE3VxXkOQ?=
 =?us-ascii?Q?MJlx+41WdwmBrC76ULZHyWg6CS/IDwVERgKwW4Ptz5vRcPpxwT9j8rhRoQZR?=
 =?us-ascii?Q?kNS+aND0sdz1rgx6BXd9/ZmMRdmJgWRS5w3WgLnhMG1xNvxRfwaHuz+Q2oDn?=
 =?us-ascii?Q?BjcowvLCI8XCXw4ZXlrtvvo+m5r+EfBb8mwGZf9XbmfHav/MhDGqTwYhgVVq?=
 =?us-ascii?Q?yEFahMmZ9O1ndSNGXU7e35NuO+X2dD3bRH5SdK15rskDhazqSKLB9u1tbWm4?=
 =?us-ascii?Q?lvAEAF8N/SZAe1uzWZvR3vChAJE7ZXB8wwMno0Yu31Rrk3vxpF9xA0Cjdom/?=
 =?us-ascii?Q?PTYS0+uEe0cXlUkZ7HPmKHqkyxAiBbMrazHyq9QgSkHPCJu+zRcIOjJsfcWT?=
 =?us-ascii?Q?aoM0DtqwjMoSWaq4zvUnwQaGlrXm+9aFEcwyvBaQ28kLKAy+kNtKEMiZpcjV?=
 =?us-ascii?Q?YpWkHQk/3+O96wwqKDnjh9v9RlmpSYh2fO7SlREyxHCGCpJoXXIv6IF01H3A?=
 =?us-ascii?Q?bF9PC1yEp8PbRw9n/EENpuALMPgwrY2UGXhiI0Qe36tbwD1YixbFDh1d6gBE?=
 =?us-ascii?Q?1XKTjzTK/0QMbG72iVpTgFRAiKjcZvw2+IsCkmutq4Z55I6J0mhzXRI7G1Ce?=
 =?us-ascii?Q?6AFc0pB3dgK27bIY8cXvLqo84x+N2GkRQjknKDfsUyo8WG2sEV1XGWLjXCdc?=
 =?us-ascii?Q?baxEm0I9AC3+qPKWAKV9hF6Jk1N/GseW/tLRbCs5e6hPwcjLZDbbBLnkeIyF?=
 =?us-ascii?Q?K+v485psjyBBYG/23p4yhRkqGkIVngvxF2E7OzSEhGouvzTB+FFMrBgJmA6W?=
 =?us-ascii?Q?foPi0mzU7gN0WLGb+AhhqS+v0jDNbuLsR1ShFuCT18vZgqa//rHTnYKTZh5r?=
 =?us-ascii?Q?c06zG+2x+bHDZGsw+r0H9oM9IbrzB3Xyth4VmgS9xA0LOFFEUbi3EsPU1TKc?=
 =?us-ascii?Q?N9jt9+YejUxD4tgkl/baxnTsBYux7xuJuHf2TDnb2q1gxQNQxKy7RunO02wY?=
 =?us-ascii?Q?clHywjvj4/TPFTMc+rpR/1/fLvMMJ2dsRL4ao6SxRqZ6PbdSd8nQSeJ49uJN?=
 =?us-ascii?Q?ly6QwNVAxi7y8fKwQnV424sW4lj13LcI3Njo/+IesldaULYPnnJodXTARSb2?=
 =?us-ascii?Q?AMLp3XvUrkDUop/fIzg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:47:34.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39049800-9925-42cb-c964-08de2d0b7fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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

If the board supports IP discovery, we don't need to
parse the gpu info firmware.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4721
Fixes: fa819e3a7c1e ("drm/amdgpu: add support for cyan skillfish gpu_info")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a99a2b911529f..0d729284c117c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2675,6 +2675,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "navi12";
 		break;
 	case CHIP_CYAN_SKILLFISH:
+		if (adev->discovery.bin)
+			return 0;
 		chip_name = "cyan_skillfish";
 		break;
 	}
-- 
2.51.1

