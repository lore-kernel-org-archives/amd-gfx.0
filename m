Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A7AC71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D9E10E493;
	Tue, 17 Jun 2025 03:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yf1wDEng";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AD610E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+JF3jaPmLNBAVa2/WP8iUROLigEGZ/E2Emq5fjDuHseeer7lw1c7oXA81CAZDOP/358hdTCvEFdvxX1tmAStmchRxp95D4kfIap7Fm78w0zWxg1w2yyqlI7DXEqfOlFr2A54962ggtXQJJVAWhJ5ShJwsW/ACCTapc1dfsyadIrD2FE6JTVUYH1EatUihOZQ+GAKj2J8h+VKKU0nW+zmSRGRATkVq7UGxv4ISxxAW7AyF85LbE0EHGHfMXk8PnYUniadmcATPf2aIPxGD30nyY72N7wr1eEpNaT3gmZ5Xah5Wpcso0Ph1mo+VEPNRkvqx9hShuWsFYjWoENiwtA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65RUW3nbg99eLmhfHVsFT7JBRQsxn4NNFo1R1+XhwkE=;
 b=hU2MXWgw2Hh9h+4LV5z5ERKEMNyGR+XXQ3m0nz9JFkzGdk2VoZtbG7yyBW3ALYWv4G7Z7tWLg/9idslroJ1sQN+a/X6ZB1GTCiBoGeJSmlzxKXOhi6ZJxBwqSd/X77eLZNo+DayWlvsA5NmfhJUpv8163QfJjxsfv0yfktLUhfjyNoRBGz/xl014w0K44f3o+caUnrH8ukERDsQyMcRqctOPUGwHrZG2ovDNv1EC1gpgp5+5WHXBZBnIbLqhWF2ONFbK66g0xinI82GRiWh9vtzsU0A4XCOcl1ePshr1guqEAaN0S60RawPiI5bVVJXLxX0zcc0wDXofyLE7Ziz3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65RUW3nbg99eLmhfHVsFT7JBRQsxn4NNFo1R1+XhwkE=;
 b=yf1wDEngI4WeQtmMNjECJUgL7jrGrOZ3k+EP3mINCZUHzyRflREPAeg9cLcDd2JGkPow8fhcc64fDakUSzMsfPNJsv8mE8QqJKlMuRLceWYKkptyPiDnislzl20W6VJb3ZeHmQGo8xxOyGepcr6qjt8dwPzaE4PJLAQNSD4WQyU=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:49 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::3) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/36] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:04 -0400
Message-ID: <20250617030815.5785-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0382eb99-e76d-4c5a-0c9e-08ddad4c47a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Or3rz50hNNGeBnqT9vYE9Vwy1YGYUL0J9eLG9tUa6plFFgsgW0vGAfWVfxxJ?=
 =?us-ascii?Q?dYMj666rbACx876ix0kV0UYJR23byMNLfJ/X4Kfs96NRVdB5qhhLZBNTcJX7?=
 =?us-ascii?Q?TntsPDUShwtI/Rm+AXEYvqPAvcZ51IuANiWRooUwJiRiPgor6vdOb0c2f0aM?=
 =?us-ascii?Q?wT0t/cDS9D4BF9OTn4gNwpTNkx5+mRBls8A7IaAcQu7tmkRPX5kF3Ke0zDa4?=
 =?us-ascii?Q?qVf0wBPnoMXq+eXw1LXFjKuyDeepnknOhhaz2Mr3mLKP38QDP2IUxnnIe2Tc?=
 =?us-ascii?Q?neXzrE1EWi5OHvjCkrNmeOI1k2FJ6CXVnxKu9NGsGZ45oGm6RtHM7xPSMq+W?=
 =?us-ascii?Q?vLVKDgCWY+y1TbDoZkMIIYwTqcvwI5tQ0j43/AhBliXrisVh43A9vbduW7ov?=
 =?us-ascii?Q?C+89cFVX4VF7L0zvYfAB2rYRpNHzRO0KUAy7cQWzWtcF51Da6I9BBwbyA/47?=
 =?us-ascii?Q?mqZinNJaqA2utVq+Gm9zb/7COdbSz+/gCSxsrAeCngHJt38rJ5dW7U1Xwqoq?=
 =?us-ascii?Q?e+jkffRYSWKEA0f2r8gE46ukDJCqOiClO8ocv3GCoWrZmd3YpzbTl8vqRm6B?=
 =?us-ascii?Q?qLnW5qIhUuaoMlYBWh/NLDTLt/otRjNs13DTo52Lb8Wws4ekYBGTovUETgxm?=
 =?us-ascii?Q?x8B8+4kTypewpd6odplDf27MKneittqzpz/O+57b69RPyt7h4nRXt/pYwEs3?=
 =?us-ascii?Q?F+k31IsS/FssurGzeddHjc2nk8t5m8X3dbvEEIdxhOAHJDi9LgGBOAzvl6Wb?=
 =?us-ascii?Q?Z7p1cnzZCH8MXlsF6ievs3bjNSvJADnDBF/RkuKd/S96yJDktLzW9QRmmpt0?=
 =?us-ascii?Q?AOknYTW6QBFjPhuN6QL2oCr5lU2kOzWtmpQDFtKlqgWkAhrL4ZdGn7DzPwQv?=
 =?us-ascii?Q?F+KCEDgzk4fjCJIGL3r6l1noeBpuUIOnoIs5Q/ZYdAmi1OjbClNb1gjLbBw0?=
 =?us-ascii?Q?st50qzcGgVeLNLUluZ3qcPSHCzNTyx91XKvgx+Owypg5bHAjK7xQOZG4UAhg?=
 =?us-ascii?Q?OsV+YoQTTVfQF38lTEJ+muQApWNxpF512AxRiDeoz8PMPRAZh6pvjGw8eGYm?=
 =?us-ascii?Q?yiVkQticKzxUH8IA0HqylDzksw4S0bygFVHlz5bJ2mdoMT0p8UhgTXgUkjS9?=
 =?us-ascii?Q?qUUI4CHOKx7LNvQAIV9qTTrCQq+dF0IHuMh9cPGClGjizVT2w492k4uQATvI?=
 =?us-ascii?Q?+E+Ejx2vT3LqcGETFZuZbc6ia2zgA5ikVg8NKBDCjgop+VQ0mQY1Dn2tKArM?=
 =?us-ascii?Q?8p9ar8boVr9AdUHcSxtT2AunJRbmtr8tmO8f8fDghUH6jTQ6RMRcxwkm/129?=
 =?us-ascii?Q?+zxS4d9zWXOZDVlIe/Ld6DhKNxPCVP9DhTISmb+2KIAlt7eU/M8qAS6ZRJdb?=
 =?us-ascii?Q?33Ow/aJGDo60YR4HXRobvH0/tOE920DniHFMfOl+7XEuKkWKVA0cBLd80FBW?=
 =?us-ascii?Q?ot0w5ebLPFZv+pT1wyhtfEFZVhDYUa0AnEcntJ6qNeYsNWtVQ1+oMdin+6cV?=
 =?us-ascii?Q?1Ee4nGKSZHUGe5C9vxNayX+BgzQZ5XsUw3Q4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:48.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0382eb99-e76d-4c5a-0c9e-08ddad4c47a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 82ccab9cf0895..3e92b099e91a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.49.0

