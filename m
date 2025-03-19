Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DCCC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF33C10E54B;
	Wed, 19 Mar 2025 16:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiI7VAbV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723FC10E54B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWjcVH4q6PJH+jWkqXVAuuDxxrdL37hldD4RE8MwHf8/LI9SgY5QF4zVBjVlELVyjRRGQFv528JdVWa0QS00GgSSqVVQdnG7elAMl4RbqZQbZHXJ5/iVIx9TqXmQH0vUda9JG5CKMXKZAmMEjoPfiGLp42q0m4ILLHcMUPV6LrAPZ9vfvWpft+QnkGOkly0kBOvCUige3+p9Y10WrQ2GvtcB++Z/rtau5RKBm90MXCWkCcyPq4c/3UrSYQoj2sRR7RvzqjlfSUeEhQRxwlGfh7SN6Ez+SmdUo4Q4mDfE1ZfZxnvkYf3Pnne3na1tHGPo4XQW4mEGIrlz5HGNHChUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVcTOjlWzMtUB/YlkEem8AnGWddfv+eqBg7NwE92+Ow=;
 b=pflmlq+4nbyoosq8KWuPeOzrX1asDGT6OwVRkvqbljG7Kcn/PmpAcMXAOJbySWWydy+EL0OtZh+yoyCGl4/TrSleG57u1mcIqJLfAy1wgcs1m0RsXrHluvyQz0CZTVD1Mhm9+j/BB8X7aeKEa/xwMk8MxZzJMiSOpJKwFfbC2LkwxIu/29jzTK3I/H8Qiop5PoBN2EOcXPwFfpf+idDKJHh9YlRxdP0OuZyk1u2XbmIx9en9haNkonoF0inpQWJdixOR/c5tyuvddhZKU2ecLkIXOAkpIgKq6j/zPKnM98+LnK3Nvbz8qPjF1vnUT8hQjv0iYRioG71Xq9c/9XvheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVcTOjlWzMtUB/YlkEem8AnGWddfv+eqBg7NwE92+Ow=;
 b=jiI7VAbVUBZmDRtg5uje41QPSzsHQeoNbT+GMocDTex5QWQbFZYw9L+yJuMzMaCap8NNI+CEd9PfXVzTb8DqL3Vfi+h4KSF9fmX3+8NRUshtscvKxbJrp8AF3jjNwptm2Etpfygpd8aAbeqJQnsWk6ZmoQV3Zn42TLuORF0HZrI=
Received: from CH2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:610:54::32)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:22:42 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::ff) by CH2PR11CA0022.outlook.office365.com
 (2603:10b6:610:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 16:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx7: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:21 -0400
Message-ID: <20250319162225.3775315-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe65241-ca72-4b0a-da29-08dd67024598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJH9f55f01lxRpPMueI/j6UGfx7xdOwW4W9Kdhy+o9157ruGpCaQ3NJH45BE?=
 =?us-ascii?Q?vMeUKl/C0qDEA8DL3RXLlFhL77T092Abcf2Mw78ZLqzx2/qubnGUD2ehCNpy?=
 =?us-ascii?Q?VjhWWll2BmKsoyEmqni6gMaxIk9v5sGKr88mbVwAht2id62D134+2rK3uTED?=
 =?us-ascii?Q?YwCMJx2QHZ5PbmGaGnXaMshBYuZ65EwPWEmObuGIY8kzYjSdl4vXXf5anZSA?=
 =?us-ascii?Q?BlOyHKsqonouP9FfLoIHIoCL8JSiYgCNv/jhdj4syYU59HziZ2fbIGs7gdzo?=
 =?us-ascii?Q?R4tdMg/Gc75C7PRPWhPJvnHK4mhQzka4IjKuChIpBa/trZQID0fbRIahIzg+?=
 =?us-ascii?Q?e+iesf1dElPmgXFE6f4fva3t7D39u2hhkjE329OaiH9VXqCpSQ1OXPrIhL3q?=
 =?us-ascii?Q?hzqIBB+McEUMmVv7sIV5Wxwob2qLt8zVqXGaUpafIXDYjBe3b4Y/+IGZpqQY?=
 =?us-ascii?Q?/R9ykspWVz+Kkfbj6HHFY8Y72jVZC+xpR7S54t4QYlGge66pmpySY0IO9muq?=
 =?us-ascii?Q?qCY8yAIVqJW/+Je1zvyeXMnNZU2WEmnOV80SDFUI/N1PMIbsUBx/0l0TfE7X?=
 =?us-ascii?Q?fMttdIIkeHlMVU4PO3Vnh8S6/veaGYEf8dHg3yfp1FAumIwU9ZCgyHhjS4A8?=
 =?us-ascii?Q?NxPzmAY1nNeRciZLV+G1nV4iaxmCNNaPxWu7VMDusdXhQ+eGam65LnYV7lkg?=
 =?us-ascii?Q?PspPxhWQ/BjeKfaTIFBkkZQFWekKKPE1fLRJJC1E1zRbSxY7CBp/Ksr6BX7d?=
 =?us-ascii?Q?U8banXnwEFz9gqz1BBkfZQtvD9ByN+05+3gv4fYjOC8d48QiHlbcygRwsGRA?=
 =?us-ascii?Q?lhvYQGqStjvwenkA+8HZXbHtzsWJC8Zt3jUuHp4OMR4a2dw7Rxq7gPEVtwXX?=
 =?us-ascii?Q?DmcceWKkAMFz+jjvzro0R8RmFsOaXUWqScJRIptSfFPlQUydXZb1Cj0Q3dhR?=
 =?us-ascii?Q?HOZosAW49YXvMAjFD7TqkoXTwKCKPR7Uwa0i34iouq2E3OPCz9jwVekZDkOW?=
 =?us-ascii?Q?8N3FTyietpjI8sPX0TBkj86wCjVNT4OZxTZ52AsvN30mcXJm2mHna46uDz8c?=
 =?us-ascii?Q?TM5T3jf+Sbt0Wjkp86mzLKv6zj40vYoY6FHDPgCxr/iAhqDK0vY4tVYLc9N4?=
 =?us-ascii?Q?EQNvkfvwRJ99NXhISdGvH+npizpPqL+XTlxi0A+0qEM2b2+oX5P2/SAkEM+u?=
 =?us-ascii?Q?b0h8OYgfohqMSq0/Rm1tbQ12CUCynB1vjtJx6MRGdzO7vdf0jXqMw+O9UkTh?=
 =?us-ascii?Q?qpXTLLLQro5v5wxWR2KUeIK0aKE6Gj8sVyLi8rKWAN952Ee/VGe7tuD9LBKk?=
 =?us-ascii?Q?DN5g8HHbsO7+XmDwAsxLdt7cc9pBpMifbQqzwgGDLQkEW/BBvD83lfXFoAZp?=
 =?us-ascii?Q?ZjSM/jMLe/8W9boefwnQDfPTCMyvvzfL8c3yLfM/qvgi+34fyS6pHrx36ogj?=
 =?us-ascii?Q?Kt1/DJhVcHSnDpYGC03rcQR23aYfMuaGRqbY0xMie1YrrHomzBfT5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:41.1094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe65241-ca72-4b0a-da29-08dd67024598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8181bd0e4f189..0deeee542623a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3906,8 +3906,6 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
 				buffer[count++] = cpu_to_le32(ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

