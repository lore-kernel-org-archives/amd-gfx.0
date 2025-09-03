Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94993CA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 20:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E22D10E935;
	Wed,  3 Sep 2025 20:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzXYxn06";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B23610E935
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 20:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEa20iRdqv7DrEG8w6bWnCyBZLY6kPN3wZ4ilGdT8uttFgVHX9JT04h5KWT9OAsBKm7+ujq0+oo7jvX9tiHvOuNK7YPqIxLRSZtE82jlr9lOl3cF7mG5N80xViGRydYuR2xh9ytwz3f8/Y5nJ+8kq3f71vbf+75sK2e/fZ8OE3RGIVB1QkRYbms5whrcw0Of48SEZCZ4tgHDDlume3Qa0/X5UI3Tc9aTVSJNBPzx5Y9kARpt2GYU7vnfB4KVPl1fC+OoaBpu7FF9HmzMgQSd0Mkop9SqQyoLrIIU5EjP2O5tAmc8yan3PL1A36y0psT+RlG+4BxnSKHxBVB+0jo2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2WUfTNnKTTbHaa7HsCVACuFINcBPqFOmnhQj6tPKBQ=;
 b=ARuK00YWqru96iy5nGVOwnbRroMWE7QJoSkpOzRX5wZKLCGbXowoZesk2Wr8Z+K8LWGKvpd1YXF2DRk/JZkYpovkj/kSW+3lWNrrC8Xa3AXAbbFsHYcIwIT5rDunNdgve2zZvWdCZOeWNaPL14PeqeRDf07jIsUubq7fpujJpZO0A9j+PTpZFzFXZyR/BEzX1x/Whe2g+VQixasGGevyTT/rxMyArmhOs/Z53Ho9BnRMhkkV1SOk09boJDYbpeMYHrRbwylOM9Ff712okfdyEh/FE1Lp0SEAJNf0D0R3E/wg90nobSzEK6lCIhqpIC6tmgmCmS4VKGE+mATaVUKTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2WUfTNnKTTbHaa7HsCVACuFINcBPqFOmnhQj6tPKBQ=;
 b=jzXYxn06Sa7VfnZdho3o56PZ9v1SUVF1+DKH3lgUSomT8E5AIh7lxmxEEIkoMrJ8nx3rjHvkgrv3HPwM2it9AhVHciX00TXOGh1Lst8tf0Oq/6Qvm2Up9/1T+B7fKnEoeY1cx+cn51EC3BdC22NuPHj/6dTgp4UrvoKhhpUsVuc=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:36:40 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::39) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 20:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 20:36:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 15:36:38 -0500
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 3 Sep 2025 13:36:37 -0700
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 <xglooom@gmail.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v2 2/2] drm/amd/amdgpu: Declare isp firmware binary file
Date: Wed, 3 Sep 2025 16:35:44 -0400
Message-ID: <20250903203601.839525-3-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903203601.839525-1-pratap.nirujogi@amd.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e75cead-1561-408e-b5ae-08ddeb29955c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbQ8LNCKCnYmGA41dM4lh1EWJGEKFfHYLYHJuhY7oSVf1TKD+a4EoYvzoo02?=
 =?us-ascii?Q?urbWLlID6EDANpaDADjwkh49szoFy0LNI+rsfLdDwURQLpDPkKLwajSAJxJK?=
 =?us-ascii?Q?EWn3bMG856xS1XnHcfCgi8DgdFgy/HI2Pi3niykOFym6NcioL9AVG9rISGSA?=
 =?us-ascii?Q?Sg3uqMAGNFHQTsHRrDFUoNbO/1gg1gwCED32RhaW6HMSMhpUMzLq7W+r8XwD?=
 =?us-ascii?Q?Gpw3hQ6wKbZ4RA3ciIzdq3k4nO70SqW8XBbQRtI4uKqZCi9X03rTj/Ifjzdp?=
 =?us-ascii?Q?2NtsLx2a6S1vco2ku10TezFJIgcPQ1VdeZuKzYvOC5XWGPVMiMx3Imtin6VR?=
 =?us-ascii?Q?dPK3+8dO7FQFJQTlYT47AUldiDTO+BJQUsh6+PDz8j2W0Lluv3WAHhIkFEWE?=
 =?us-ascii?Q?j9ICrbpIuj++a4N1vnxW0SNa8Okhyydukb8IKv0gps8dPTlLiNf04vfvetq7?=
 =?us-ascii?Q?DFOCQwAlDTrs/AyrQbC/LJsiqfuuX+A+qvlG9JG5ZVEnhJ+30g0adLLjrCc1?=
 =?us-ascii?Q?tNBvjS4SEUCZac8IURFK9SLeOMN23v5Bj6U+KNJViAyfYkZ8yrcBFtIb0g8U?=
 =?us-ascii?Q?McHrursLab/sumZApalUarVabnh8Yx24spNbpKx3qcX9C/Z1usj8A7k/jIrY?=
 =?us-ascii?Q?s1FGwnPCRPa9D0773iFJviw6122b8/3TJKDO2+gI5U7+oDZ67Ev5Toilqq7w?=
 =?us-ascii?Q?+uQNW7RyuzF/54yUR3bfOWeHWOepKsVZ7nElmogVdmk+zmu1Eaxi6ziUQj2i?=
 =?us-ascii?Q?VnYKO+J3rdCcgTUxxlue8oAERhkRlveIQn3YfCIG6VVzKXxaZ93+gt1Ol+7n?=
 =?us-ascii?Q?WI0BfsXHMRx1XjB1STEpu/KFqLAJp+B2YKX+gOpHN1CwL6cqcdFt31MarkcZ?=
 =?us-ascii?Q?suuaj8C3QsyqybGzSPJDgrnxtFpURjQQhazswdCkp+xRjN7c6WiwehtLT+4O?=
 =?us-ascii?Q?wM6So4pilV+DkqDcBu54xy8amq8oaoS7G0cC5q4w3NK3dblZVjIOqbVPsgqG?=
 =?us-ascii?Q?KfDs0XeA3POqaHo2e3fBl/cgUPnN9iByCMezIvNpfMsDYUR+FKhZjzh9uNdx?=
 =?us-ascii?Q?cEAgaQJgf0mRoInt6SQEWSQNLBR8slvp+UCZ6kyYpUYfrZshO7gMANJJZflr?=
 =?us-ascii?Q?lWe5fIrsDs22/iQRByWYG9LnQ7A5uFWf7BkrIH79PzP+8zSb/iP+yhVn6doh?=
 =?us-ascii?Q?Xucy1AsYezmlaWCeL7TehN32m1vXU777GAJlVM4nniuG0m4Pd2SgJuojqkAi?=
 =?us-ascii?Q?1dxwfE6z6BwzfRC/YASpp0E4Anm4dbmkwBUV3LTdWAeUWCuCcOTZjn9GHJhy?=
 =?us-ascii?Q?0q0MYToB1vEF4GMt/nYtr2lauQrFIpYZuqwGWV5qA2QokIb1auY9aJMkiRNp?=
 =?us-ascii?Q?EpE161mWFsIUwK3fYfKckEv1ca3uRYDN/8yKk5GmTeUpU3DYbiEHu0c7Me/m?=
 =?us-ascii?Q?YYWiWk2mfXCJGuIORkEdR0I6BBmnFCiqKZs93xw/vz6IafN2MNwrRAZgkklQ?=
 =?us-ascii?Q?6u3qPESwsYpz+tUu8QnkRc74Q1Fxt/9QIPZY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:36:38.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e75cead-1561-408e-b5ae-08ddeb29955c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

Declare isp firmware file isp_4_1_1.bin required by isp4.1.1 device.

Suggested-by: Alexey Zagorodnikov <xglooom@gmail.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 9766c6056dc4..1e48d94e8706 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -29,6 +29,8 @@
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
+MODULE_FIRMWARE("amdgpu/isp_4_1_1.bin");
+
 #define ISP_PERFORMANCE_STATE_LOW 0
 #define ISP_PERFORMANCE_STATE_HIGH 1
 
-- 
2.43.0

