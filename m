Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6ACC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 07:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142B10E3B2;
	Wed,  6 Aug 2025 07:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gd1IJgay";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17CF10E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 07:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILzKdm9aPoSdvFZ+D6M6/+KL7Z7RSgOnHeBwHkyaxmkpqT3Lct/S56P6fqsCCRWvq1kBk+jYiWIjtrlO4Io2G7gNuVB9mwjOR2MXy+7+8flIZtdSGHVC0WD0WXvTZm+YoUA6zauEv98BND80AnFvoaPt/6gqneGqYo7Gk9ZQnOzvMuy9hAO0c9iMhC/YyRIrbtcnz1HhkQQzzYBzcFCkWzeBKKPxC+OM9EodN7YSbsdIfwlfcWBsVmjXvxnPuqxPk4jlp5qFOIlrLQQcs1LDEKz6P4RcqGCBuDQ3j+E8TgFVog1VE279p+gH/una1Iw2BZdQBPUkPQMfEUshH4f8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRyAxmQoxxa8g+JZqDuuVZ4QD//zu51y+o3iWXkjR1M=;
 b=vNDDl1v2JWRHbSRnUZQU3LYW67W5rOzuWU/obXE9hJFHuyqO79inftlDyCuGfC/3vU5PT2pzeqaPzoq6cgKGhuiz/uP9g+i1Ln6PkiUgWXCjlJLHbPMGrOtZbAjQkhluHdGhpIjrKOK2ACGNKDW++c80rjCaBvQl1M1cHM/bzd982jWnOeehUhPNlmAik1p3B/DFL2fz+LBj47cxuummfv4Oj2tmskom7qt1y9W4MZh5m6a7NaoRyyQUfPpTVS18yvBDoskptLtXtFAaisUBXVgs2GCTgjoEIXKM83hruTx/j5ZnClYwvwy2laDzC/qRvgB3QUHZa8uupyuV7fL1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRyAxmQoxxa8g+JZqDuuVZ4QD//zu51y+o3iWXkjR1M=;
 b=Gd1IJgay83lb4/pzYl0xZta6QkykGaB9q3khXrEtW6N9QUTL692ZsfRy9t1NT8h+1kMyi5i2bX4YyhTIhp0AYmEJhE4v22RHjzl62+j+e2AWsODsm/VcHJBteDP1AjTJ2I96m+pKw/jNQHHbM/jXv1BWMdEllRnSotlkrrQXHxQ=
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Wed, 6 Aug 2025 07:18:37 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::b5) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 07:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 07:18:36 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Aug 2025 02:18:34 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff
Date: Wed, 6 Aug 2025 12:46:54 +0530
Message-ID: <20250806071655.4160679-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fea8e7-92c4-4112-9967-08ddd4b975ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE03dXV5VjdBMm9RS2p2dEVZeStUS3d6cmc3T2FlYnN3eDE1dFFRTGNvNUdG?=
 =?utf-8?B?b1U5UTltL3hBL0tybzFNNkpQNHEwRmlQaStwWWlhaUsrM2RHdXlsWDkzbVlR?=
 =?utf-8?B?MnRhVE9ZY2lFTktuRlR2WnRRWTRjSVBRWTYyOXRybVlKTEVXMUJYbWY0Sk9X?=
 =?utf-8?B?ck5qdjJMU3Z0amVoc3B5UGxQRmxYRHFhWTRsY1czcVZWaHpmTUlOSDBhV01R?=
 =?utf-8?B?K3ZpZFNTOWI0QnNRQkNsdUU4d1VGWjNjdEIvQzRnQzlTOWpCdHN5S0s3Ky9G?=
 =?utf-8?B?OWtoUjZUUDIxVTYwSkd4T3Q3Y3ZYaHcxa0xPVnd1V2pNMm5LMzlmWFd5V0Jy?=
 =?utf-8?B?MFFIajc3ZzlPc0lycU4reFovVGFFMUFveEpBbEJiV09iMzYrcGxuZ2VBWDNi?=
 =?utf-8?B?RGN0ZGE0QnFTMEpWa2lsMitLY1ZrRlJqZEpVRTJPMVR2OXFqL0xwSjBHdCtN?=
 =?utf-8?B?QnQ2SzlLSTFwcXpsekpiMDQ1NHcxSldVZGUxanBGaW1QM21rWlArb2VkRjhu?=
 =?utf-8?B?VGNRQjVhQkkyNENHS2VpazdITmxlUjkzdVhGUi9jZWtJU0p3YmQ3Ri82UHJz?=
 =?utf-8?B?bHoyemxOdFdhdEZEYjdOM2tOQnpjektiay9vd0xSRUFpbmhwMG45YzhpalVr?=
 =?utf-8?B?V01hLzluVXRZZlRCa24vbHA4REREYU15S2ZYWkQ2dlIvYmpqNnkxVllhRC92?=
 =?utf-8?B?Y1VySjJjdDNTclFOdXdzYTRXRVlTNlJHSTNTbDhmSzE0ZGZJUU9MdFYySGVV?=
 =?utf-8?B?Y3hIMTE3d1VhNmkxVWdDeTNWRkt1bm1MUXkwSHlIWnN3ZG5yQ1NMUzh0QjhK?=
 =?utf-8?B?ZzRrSjdzZnRYaWJyaUxWeGFXTkZ6dWdDK29ab0dKM01hZlV5T1pvQWJPdEM5?=
 =?utf-8?B?bXlueFd1TjNaQUlKWWIwTkJtdWFkNkZJZ2hPMEIvcUxOaXp2enVmQVJZeE5J?=
 =?utf-8?B?TzZQQ1F5NXFIM1FLZ2tYcWR1YTdweGdjMjV5dWd0S0JoeENPUHgxU3RiMVhm?=
 =?utf-8?B?aWtWaDQrWFk4STBpZWJXMndDWVppUWtsRkRFYVBwM1JSSFBJdXkwcEtzOTVr?=
 =?utf-8?B?cXV1NjBLMDloeWliSHRDYjBJYjBjYStpYkxpS1BrbHhEd1R6bDBWYVBWSHhy?=
 =?utf-8?B?QnZuQ05PMkh3dDRNWldIMGdWT3lqbjdHeFdFd3g0WjduUmYyM09yUWh3bW84?=
 =?utf-8?B?U1g4aG1ZRDdrTkNKcCtqWjVCbFY5OThtZXVWcjdzY1h6a3dMV29vUjhxRkMw?=
 =?utf-8?B?ek1McjIxV21IR3diZFM0TXkvYU5xeVB1aWNhNXIyMHhkZmRlcC9aQmFNMWZE?=
 =?utf-8?B?R0lkdjNwZS9JeThud2xpMCtlaXk0aVhKMUdLRlA1SW1xeXpuSVZyTFNDNVZ2?=
 =?utf-8?B?TDAvUnFmTkZTSzF1eFFnY0lSUllJS05kWHVFbEJFZGtwOHJiNnpaVEtiOXNj?=
 =?utf-8?B?MXVSQlRQOU8zYk4rN2hpRmYvZmZLZWdWMWJvc1dzOVFoZlpHOFRxcTFkNS92?=
 =?utf-8?B?QlBzUVdwc1RlNzRDbUZqOHRxZkNsRktpc2NOUWtPNUFmeWxnRGlkZnYrUllB?=
 =?utf-8?B?ZGVJbVhpL2JOWnlZbll3WUtyNm1WelZyQ3Bvb2JZZjhENXZmN0FGYlRoc3dS?=
 =?utf-8?B?cmZyN2ZEMy9ObkhWNjZLV0p2U0h4VE1zQ0lkb2J5VVQ5WjN5UGNyS3crWGNh?=
 =?utf-8?B?WU8wa3djSXo5K0FRaXdjZlEvcW1ad0JEY1hOM1lYYkdBay85TjljTnpGNE9u?=
 =?utf-8?B?b2cyTEtEV3liZ1lnVzE2R3Jtb1ZhUENnSWxJNEVWWFhyRExnanZBUVVIdVZx?=
 =?utf-8?B?eUlaeFNaQStjYURETXo4Wis4Z2ZLVkVrVHo4QkhpYUxESzRQRlZzVk5GSDVB?=
 =?utf-8?B?Q01LdWx5ek5aUTAwOW8wYU5wWG15VmV3clpGUUtIczZ3dWpTdFBCZEszaWRz?=
 =?utf-8?B?eDdmMy84aWY5ejFFaFNmVUQxUzF0RklrVDBqR1hyY0lyQ1FPY0NEWG0xcUEr?=
 =?utf-8?B?V3NZS0psSGdxSVIxcWZOVmlLaUVSWkcwL2g2bGVSb0dXK2JOdXVQbTEzS3Va?=
 =?utf-8?Q?50lht0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:18:36.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fea8e7-92c4-4112-9967-08ddd4b975ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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

Acquire jpeg_pg_lock before changes to jpeg power state
and release it after power off from idle work handler.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 82d58ac7afb0..5d5e9ee83a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -121,10 +121,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
 	}
 
-	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
+	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
+		mutex_lock(&adev->jpeg.jpeg_pg_lock);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_GATE);
-	else
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
+	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
 
-- 
2.48.1

