Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9190FCEB2FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 07:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB4310E187;
	Tue,  1 Oct 2024 07:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAC35AH9";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B1710E187
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 07:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIQU9IBN2EaUdp3D8Q9iyQaFeAGuaI+GSbJnegGgNim8UL7N812wRyABMjDq+yiq3Tcykaev9EKN1N6TQQ9ekwHnXHwDPq9OL7pLvXB5CW36wvSrzPiWFuSIIgGW3xz6bds7RHLtCDrsoZ+VQPFnBJC3LKSKbrv5G3kKndUXCkG0+7dE8H9a+JORDGMoe7OrOe3c10F9wSq4A7q1moA92h2awy8REB522zbxXyTrj9p7SoIacvJ/uzaF3G9ZM4ifg5xtfN0jKQt5i6+gDJXM/jOuB8z7fzDj8i1q+any/dIuy1Se7d2p2Sx3vpZcKEOERwV2B0nWrxwF6KtVGxuTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BVgzs2dSPa9uXndqp2OJ4I77qFttGzHYcoiBr5bbWk=;
 b=veFqAqJCMob4EljxLxiPiqOvBFPKTbS4h5Tn4RPNOxq9e4mqvoi8f82cBnzyUKNJtv0/7dIdww4yZh/ksrZRY92UR86QhFdv7Hcne1LGjaL297DvmPUXZJSG+bOM48ite6PMXG8pY3Q67ZjIB22ToqxipSRPWP1OTj9PmBcpkenEwNwdxdqp/crJMiMYYlxjFsfHlNPXeZYRwDlcGbvIPkCxijmMibCvBXXp4YDiMnic3jH8m6mQB9/7L8ustUd7c1Y4ZQEFlZECkF5kiXVvLV+nFJFdkMbwvEB/7q7Qb4JVn79iZjm0iLojAkshrdzb/UAM/vqf8qN/Uuj8XJd8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BVgzs2dSPa9uXndqp2OJ4I77qFttGzHYcoiBr5bbWk=;
 b=xAC35AH970zreibSmcOFsJEM6tvocwwa00y/ilY14g2AbZ2tnTH0K5wWur3yzHOdLD2lrDddSntqz1HzrKO4nroGXJFns6xrwcMN1w9swtr85o7+RxjfD79WgXLpbZ9hEadksRkx+0sbr7XDKSE1hUSR1ODbVnuRbpXUFfKevBM=
Received: from SA0PR11CA0103.namprd11.prod.outlook.com (2603:10b6:806:d1::18)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 07:01:02 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::7e) by SA0PR11CA0103.outlook.office365.com
 (2603:10b6:806:d1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 07:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 07:01:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 02:01:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: Add Cleaner Shader Deinitialization in
 gfx_v9_0 Module
Date: Tue, 1 Oct 2024 12:30:47 +0530
Message-ID: <20241001070047.2578002-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 218982dc-ffbd-4fed-1822-08dce1e6cf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDdJMXJTZXp0dVpKenkyd1pzSktFRXFzT1l2UTBtUWJnUStjeWRSWGVoN1Qy?=
 =?utf-8?B?aUVrZGFRQndpMHRwME5xbHUwWmFubktWL0Y3bEszaE5tYjljTXJOdmhwTVNB?=
 =?utf-8?B?c3liQXNEeU05d3hqbHh3dFNXdVhPazZ5RWlDaXJmNjRwdkliOEpoa1pPOUMw?=
 =?utf-8?B?L2JPUk8rM0F1bERRU2pPYWlrakJ3Y2taM1BqVVNYZ3lselJWZXRta2lDWWk2?=
 =?utf-8?B?djlLdUxXenhqM1N3aC9hV0hZZGJmazdQa3dmV3o3QkJuUzdsUUNxZ05qbzdi?=
 =?utf-8?B?a29qRmF2VjJPUFJNMGs2WXhwSEpYY2R5WFNGaFFLQVkrWnJ3QUJ5MmxSZGZo?=
 =?utf-8?B?bU9zM0hoOXFoUG56eWZidFlZdktUK2VqUlVZZlVyWm0wOGNNdXd2bDRqZDhV?=
 =?utf-8?B?K0R6eHVpWElhYXIxaWE5bkhTSkxaUWRQc0Njc3pPdXJiTVNhZVM4SzZDZU1T?=
 =?utf-8?B?VUJoeUtMQ3l3OGt4bUJkaGg4NzNCQlpZdk9WYytUdnRCQlExRzRkbjY3TUF3?=
 =?utf-8?B?a2RhRGMxRjJsRjIyVEJjTFhvS05Kd2dyOXJ0THo4WnhqQ3lhM210Y01qOFo2?=
 =?utf-8?B?d0V2d2lCZzJHQm5JM0ZoMCtydXBJMjRraHVkb2VnLy91ZVRwTmxVMWNPcUo3?=
 =?utf-8?B?c1VncUhRWGZWay9Oam5hd3ZSWHRZbk1EaGhSQ25JaTRoSHlxL0NGQ2Yvb2Ft?=
 =?utf-8?B?SXNzWkVtb0JIU3VEeVFQU29pWk02cjlkUzdOY29JL0hsOFRZYkU2SVFiaW55?=
 =?utf-8?B?cnpYdlpwTzAxWUVzd1RrWDl6SVNjMjZCVVB2RWVPWkk5aklnVVV4Sm0rS00y?=
 =?utf-8?B?ajYyWkljaEdKTklHbGtUODZySVp6QmxNL1FaTU5UMytrMVMwcTcyL3czdWFv?=
 =?utf-8?B?WjJwS1IrSm9udFdldk9hSC9MQkFobXlUSlVBYVhOVDdyTWNEVDFHVENlOG9m?=
 =?utf-8?B?dlJ6Vit3cmtPeThNK2gvanNEajh1WTZobTJHNnJWZUdodmtNSmV2VHE2SGM5?=
 =?utf-8?B?NFZqemxLdi9KVWNoNlJXN0piTHhwUWtNcVlGUCtsdE1IT3RyVkY1dlp1azZO?=
 =?utf-8?B?d3diZzZIV0NubDlORWk3czYzL0RhK0VzVFY2K2dranJqcEVMMDk3OEJhOExn?=
 =?utf-8?B?R0s2NFdjaUYwUGJBalIzTkVOMkhzNXBmWS92eVRrV0N6QmlBT1d5d25xUWlI?=
 =?utf-8?B?SjcrZTl1T0hXbVl2eUo2Yk1UV1QvZXFGckFlVzdzcThzOWpKNk85YUV4LzFR?=
 =?utf-8?B?QlVXSFhRcEQ0bC82UnJvZkkwWGZJSzhrazB3eUFLY254dUJaQmZvNExEL0ha?=
 =?utf-8?B?QU9DR0dzNFpoSmY5akdKYUV5T2JkUSsxTTliWCtaZUxFZWdpdFk1Q2ZqWThp?=
 =?utf-8?B?TXhYMTVralQ0VjM4S2orY0hLRXJ3ZlU4NTQvYnlHVEI4NXFjcnBNb2VNbDJ6?=
 =?utf-8?B?VEI2UHJmTzRQWTVhcDVpT1B1ZHR6Ukh3ZjVxR25sTGx1ektkTW40dTFhNjB0?=
 =?utf-8?B?UzJ3NlYxbC8wRll5Mlo5R0VzeTF6djRDMmx6NUI0eEdnajVqR0ljSVd6ditq?=
 =?utf-8?B?QVZGNldyWUFlR0p3bXAvbkNiVXZuOGdzOUdPcWZpRmwyL3RtNjM0ay81WURu?=
 =?utf-8?B?TVZ0Y09SZ0VNZkhLdCsyZERWMEhvTHI5WnJlSXErMDdhSk5lYk9xNWJRV1dp?=
 =?utf-8?B?eUI3TUY3bXFnZi8xZjdiRHNhNVByQmNzenA5bVRqbXRud1J6QjNUYmtPUHdy?=
 =?utf-8?B?OG1OWUZhRGJib1VJbmFYaXFQZkt5SXh1c01Qem1HVGZXcUNaekhvWmF6UnJw?=
 =?utf-8?B?bFNXcHBmbitQSzY5R0Q3Q1IwZWdkVHpVZ2lVeXlFRWNGemhMeG92Z1dSclE0?=
 =?utf-8?B?eEdiRnhyckQxWWZSWjF2bXFsRGg1ZVAweGQwZ1pNMiswTUZVdlhBc1VxNkFw?=
 =?utf-8?Q?uNwShhEt4JQm+V5WVW9VIUiJOmMNfCQL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:01:01.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218982dc-ffbd-4fed-1822-08dce1e6cf77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
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

This commit addresses an omission in the previous patch related to the
cleaner shader support for GFX9 hardware. Specifically, it adds the
necessary deinitialization code for the cleaner shader in the
gfx_v9_0_sw_fini function.

The added line amdgpu_gfx_cleaner_shader_sw_fini(adev); ensures that any
allocated resources for the cleaner shader are freed correctly, avoiding
potential memory leaks and ensuring that the GPU state is clean for the
next initialization sequence.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d7ef05cdb72e..1deb5eee794f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2418,6 +2418,8 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 	amdgpu_gfx_kiq_fini(adev, 0);
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v9_0_mec_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
 				&adev->gfx.rlc.clear_state_gpu_addr,
-- 
2.34.1

