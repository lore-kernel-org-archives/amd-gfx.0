Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EC4C369B1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A59610EC4B;
	Fri, 11 Apr 2025 17:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0qNdCbw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E625910EC47
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0cVY8JmpBUJ39Om2NB4pDnmyYRJQX22bPpY1zCvJoZq3iYFLXYBWLVj0b4InLxllRWqRYy7MFGAL9bSjBMW9JLyAP9pSoeYhWFTH1HSnfSkPt7ctBLGr/RVZC5uk7W9AZfnDdPp+m3wAWW6qT49ANyyrZyqy8I/9bIivyvJrqhFUmnIlj6vuG2IsNdCfB8Y0OCo7Iv+vuyaaMz0RhecGncvoGdBvo7JxIQ7UxLBP1yxN1AH5/gQoRkpTOpW45f9zX5UFBz0O5XbY+ohlSVnLBSE/mX15WnRVDhpsjWGuHAkXSbKyZ2e4JpB2W5QLPnOr2oGi23vWceSiXTeUD1xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxpwLSQbEs4F5MKK8bw7j/e22GoP7i/0VnUxZIqNjaI=;
 b=WOIwLChH9EQytFMVEQiYbfDXetBVLcLWPv0ag9MpUtrDab72o6cB2MqMjIsy91b0HBuo9ib538V1S5xNv3l5uRGFiaeCvzOpM+m6W0f2PrB8u+ZLHKX+k7FcXz+nQ1f/QRLBjR2NzpIiIRAVCQIN9yfHJiTksxgzjqaLTP79y8hAFBf1ffAVINf5GKKeom2VC3Oq1UsEyLadGicsUzdLBW3WICyv1eOcZgMBQ2PbVqj9U037RCoT34mBng+hnqKrUiUHS+aQHDj41NYr/4DNHlTZVvO1xaV6vhwjX8hq71JUiAryrZJBr0K+KeGgaNoMQNjhkKGlyUcaB6cXQ8a7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxpwLSQbEs4F5MKK8bw7j/e22GoP7i/0VnUxZIqNjaI=;
 b=u0qNdCbwyhGdUuHI5MiVulyKKB2VeyFVHYFb204qTT77b2b6CYDTZhVY1hJdJD/j+5Bm6Gf0rSsXzcEJpf9nEbh9rzDyooHW8RVuJjJ8dFESJXKGJzryiF90MQjpx5lee9WdFCTT0eOdEqrSfCTch7KA+nA0uceQF/Ag+g9Foow=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 17:40:08 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::7e) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 17:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 17:40:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 12:40:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER_9_0 for
 Cleaner Shader execution
Date: Fri, 11 Apr 2025 23:09:41 +0530
Message-ID: <20250411173942.3324241-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
References: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf57f78-5443-4bdc-c074-08dd791fe733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkJmT1dwMnRaSUZlYmNvaW8yUE5Oa1JPTmROYWtDcktPNUFCUTBHVGRpU0Nz?=
 =?utf-8?B?UlBkblNvK3UwMW96NXFCYWJsd25YaWp3VkVmZWtGdi9vWnJqRjFmUnJCMHlZ?=
 =?utf-8?B?ek1yZDdTeXpXYkN5RU1NczdoeHd2VkNmdVR2akl0VTdvQnRVSFZoL2lXdS9O?=
 =?utf-8?B?MVlpN3pzVzVPYm1HNmVnR1d0UEpmei9HR0RSSDF6ZHIwQUhhTnhNblpKU0lu?=
 =?utf-8?B?UHFUR0lVaVgvOUZZeHNYTGpWVGxPNXRXbUdHcGVBOVdYUHpqLzl6c21oS0lJ?=
 =?utf-8?B?VWJJUUNpOWZjanJNeGIweFNKa2orVmY5T0lEUWxteHVzdDJ2QkhORFBzV2VB?=
 =?utf-8?B?TzBFd1BHVGdpd09BeHg2emluUUJNbmVXZnNURnFlMWNQNFRRSmUyeU9HNTFp?=
 =?utf-8?B?Y0kyUDZ0QjlxMjQ0MUFoK3NRcThRKzhGS2lZanh1cEhMcnVXMDlYa2Y5eUI3?=
 =?utf-8?B?eEZGSnZST3NtL2ZiQVozMzgvNmVNLy9JL093V1A5dU82OGJPNHpLRWVuRnVM?=
 =?utf-8?B?b3dFR2NQajE1bHNEWWJPeldMQjhsZW1va0NXR1RkS2VsNDg5NHdZMkp1TjR4?=
 =?utf-8?B?dDNTRjd2MzcrMlNwWFdsdXZFc2ZFZXNmeUxDc2VBYW5CWmZDWTUrdVlTQ2FM?=
 =?utf-8?B?T3p3dUJOMTlOb1V4TXZvR0tONVJpQk1Cb2Nqck5QUVNBc2h6NklvUmxpQ2xt?=
 =?utf-8?B?VTlHdCtKa01TQkhFWUFPaVlYZXArWU14MkVJWEwzeWI5MFRtZ0V3L0dvZ2xB?=
 =?utf-8?B?bUlwK0RTMHdzQUdRS3hWb3NsL1k4Mk9IS3Q1eVdHMXdKS0xOY2ZwMHNPYXA2?=
 =?utf-8?B?MEN2eUJwTVpqWFBKUE5QVFZLbmx1UWRRbkNMd2dOY05aVG1QNlUvRXp6TEJW?=
 =?utf-8?B?YTNPTWg2cWFibmF5RTZYblBJYVpzM1g4M3RxeldxSmNVeVdlaTBvR25SalEr?=
 =?utf-8?B?ZnBiQzNWK011aE10SHNuMDZUTWZ6aW5kS0s2empIdW04T0ZEd1Z1R0ZtZm52?=
 =?utf-8?B?UGF2eVB0QjJtNjRyeGh0RE5XNUtJYnQyWU5RWVR0WG9VdGQ2bHkyWi9icEEr?=
 =?utf-8?B?cmoyS29qa3NIUWp5dXFkT1FwQW1McXZIcVByYTlJTjcvNEZmZmM0a2Y1Qkhu?=
 =?utf-8?B?bjFvUExhUjUwR0J5b1VNb256eHlZb2VkemlmQlVQSThuWFBtWWkzc0RzY2gz?=
 =?utf-8?B?TnQwMzFCa2ZJcVdJY3RPRkJxcWhiVGVRMjYrWHZyS3NGWnM4L28wRW9COHpq?=
 =?utf-8?B?cEJhNTdxaGpnaHM2c0M0dXZRMmczaE5EUkVtazBrbVQ1Z0R6VURZZ2hlZDdK?=
 =?utf-8?B?R2xBTU40ZFZ0cmE1TFBuSE94MEFqeDRHVi9ScUVrY1lOM0VJQlhsdmJrd05B?=
 =?utf-8?B?RCtKYU94a0xVRWxmTWlpUktuMVc2b3BydUROYUVhb3F3Q3kvVnZvNnE1WDlo?=
 =?utf-8?B?Uy9QUzJrVUhpeEJGRUhhT1pVbElVZmtheFRQSXg0ME9mMjRrRGZ1ejBBL2Mw?=
 =?utf-8?B?K28wb0J1alNrSy9qbGtHSE5JUUNvZFVhVGJ6MEtTNG9BbVZleEVjSERiZDQy?=
 =?utf-8?B?Y0YrVmhJRmFLUitCTUxxM3lIS2lHVmtUdHNkQlYxZy9udFZmbjV5c3ZWZ2ZK?=
 =?utf-8?B?bkwvUXJDV1AzYUlEREFMNDhBbXVIRHBaRjRJRnRrbFUwT3hsL3hZVy96elJr?=
 =?utf-8?B?QW9lZWw2YlVONGFBcEhmbWo3OG9sRnhEbWhacURmazc1cmhBdXFDblVvRE1i?=
 =?utf-8?B?OXk5VFYwb08wUDN1Y24vMWtUc3N3YStGdGo0Nk8vTlFUbFVKV2pDWndpT1cy?=
 =?utf-8?B?VDg1aTdvK3VlWGxVcW5Dc0ZPSUdSek1ZbW85M2FEOC8vVlBXc3Ixa0d3dUl6?=
 =?utf-8?B?Q2VrUzM4WlZkcUFVUUF3ZGlYZm5MTldZcXBuWndUYWxYLzZZdk1Kc25yQkJ5?=
 =?utf-8?B?anVuK09hY3p1eW83VE5YMEIrY1FuS29ZU3d5c3l1VjEvVXNmWU9HRWtRcUJF?=
 =?utf-8?B?MW1sWnl0UW1OZXM1OHlpeXNzVVZVL1drcEtlelN2aXh5TGtYbE1lclZ5R1RB?=
 =?utf-8?Q?Vn6Tat?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:40:08.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf57f78-5443-4bdc-c074-08dd791fe733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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

This commit introduces the PACKET3_RUN_CLEANER_SHADER_9_0 definition,
which is a command packet utilized to instruct the GPU to execute the
cleaner shader for the GFX9.0 graphics architecture.

The cleaner shader is a piece of GPU code that is responsible for
clearing or initializing essential GPU resources, such as Local Data
Share (LDS), Vector General Purpose Registers (VGPRs), and Scalar
General Purpose Registers (SGPRs). Properly clearing these resources  is
vital for ensuring data isolation and security between different
workloads executed on the GPU.

When the GPU receives this packet, it fetches and runs the cleaner
shader instructions from the specified location in the packet.  Thus by
preventing data leaks and ensuring that previous job states do not
interfere with subsequent workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index a5000c171c02..cf93fa477674 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -552,6 +552,11 @@
 #              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 
+#define PACKET3_RUN_CLEANER_SHADER_9_0                      0xD7
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
+
 #define PACKET3_RUN_CLEANER_SHADER                      0xD2
 /* 1. header
  * 2. RESERVED [31:0]
-- 
2.34.1

