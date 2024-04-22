Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC3EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD5910EE25;
	Mon, 22 Apr 2024 09:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kuuMToqX";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11BE10EA98
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0+EoLQ/GMQYKOtiIMyCPWc1OKV+2GDOHGOGmCUBgvMpCrJgqvP0reMZcunAKCRJyl+RPCgRwafmCNBHG6Vnsfv3kOaUi6lMrzAjik8FHOSoBlBV37H7Jhs74adSaBsMvxUNwemLi54aBLsnROt/ZFG2HyG/zBOGThBJDzdm1UqvIK7SR77LaOfFAauyXNq1BprlkTtL+jDC90ZoF53S+CEhfojZLYmF9Fe077sA+XM+sspqOOZ59Hh19PWTCwnK9XYANHifwrddP/07+ydQ22K422GoqntCriv/SptZiORVgtdZGSvw3/pT/IKKwEJBiyn2FVkOV9/QXmtThAH5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0HOPdNtHAA/L6AF82CmodyYhD/qmoHMnl20qzixWHI=;
 b=LS2v6LgA7BVzokSQPgpiPeb2RsafQmrw3rpo2Vc5Izx3KOH1IKqjLj1cuNBWLtIhfb3C4yf2BGCflJAYSfWKPGX7avhBXY1BUaf8kgQOaT1d84CGbxr2YPnc9pwfcIti4HRjlT4Y3jcUOteNyJpM4FIU6yKUwpHHGebUFrgrh2vE+ms7mh1GAIAje8JTcg6SQ/zOLk7+hOzq9/fA7tLMteXKdPXTjlyoiWNVjsHdJmbkN1vVFiAPhoUPXhuMq7jMNq5NLHYruTUOSOFM6IKHknOw5Xh3hBEezTEK3WEpxcThi0kZXArXvaaSCXvyU9q/EVQZwyJYcHiyM9yd2ZCbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0HOPdNtHAA/L6AF82CmodyYhD/qmoHMnl20qzixWHI=;
 b=kuuMToqXkxbKmHfqBMpzcjiP+yiHERSeHDdjWcnSdIHp+Ww4bnNLKR3GqIkVbK9stqOBzIlOmUJCfPEZUQ0X5Tua+3mrWQOONnHjOMO5kRhStuG19WahvNYeVaXblike0fVpemi3Nqj3QtO8nH/yYcweFBokdBV9mFA6qQBmdPU=
Received: from BN7PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:20::40)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:39:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::42) by BN7PR02CA0027.outlook.office365.com
 (2603:10b6:408:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 09:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:39:52 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:39:49 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: fix use-after-free issue
Date: Mon, 22 Apr 2024 17:39:31 +0800
Message-ID: <20240422093931.3823889-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: c423463b-fe65-4ec2-cc77-08dc62b0291f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T9iTY0UGhWQ8H2piVRVFS2kVNYUXVtpat3fxQPCI+8wERFT+q4pwPNqvcoBN?=
 =?us-ascii?Q?tYrcbqJo2ZbwAFv6TKhUwgiROmnDLlkxLbgzBXSMxFylH6Yl2NS+JreAImVv?=
 =?us-ascii?Q?UxyI59LuBIXi8xn4BIdA8WK50KHwhWjhIberUAuxDniUbnOcHb95z5DddC20?=
 =?us-ascii?Q?5T3PwCmYFszeFreiadslh0qY0wGbiLDDETy9FeZTtU+TrQKqWOqyX3K4e9aJ?=
 =?us-ascii?Q?5jP1x9N3XZaEDRu8KTpYu2LujmPq2Oh0nf9nd5fPK7YyRhX2drRhBcQ3PFdU?=
 =?us-ascii?Q?gfNjghR5H+7Z7QC0o2Ujn35Jp8kqhJLiNujxcAneesT5h2A7ZnRz9w4QObDN?=
 =?us-ascii?Q?tLGOJTYtP5/qrwcXC8xwRFkE4mLsrDQg6MeBklTaSGPUVdkG/HElScc/JaSe?=
 =?us-ascii?Q?tkf37cFSm306HzqRW48kgq9gsZ8t/bugP6ylRZZ4JpfAR7HTgHN45pcXahgt?=
 =?us-ascii?Q?oCBg9Ug4q0grM0hYV7z079Nlq/jU6RNkzEQ8Q28nWckzHgoE+g7o6040dYCL?=
 =?us-ascii?Q?pIvuPqpC6vTPP6udvnPAsE7usOHw7qpEMkvsX21QgfxOU0CYs7Bg3RBG7/9X?=
 =?us-ascii?Q?pBCQKqxqt+xcZPERmCcL4GyrRTSzjSboHp7IIHhSWeZ2HzfcaV/UQpMBosY5?=
 =?us-ascii?Q?sSXJe3e0LAHOnbCQUKQrRP5WOdeTpNkv6AMUCDv7PNqlRj/IPS+qjanxEkim?=
 =?us-ascii?Q?8DrWyXk09JLOV84U+rUx0ZMJeXygKyvB0uPahGMPuxjcsbZaV9BC3e3vUabI?=
 =?us-ascii?Q?bOjqX8l9SUeiu6GfCCxBC3RHHctd86G1/Bz/S29x9ZPRExXHGjS2V9xiL0ic?=
 =?us-ascii?Q?+EEr/oVBicawNenNs31whSs+eWO3sybDXYc1uB4yizStcjh/xQlpF/Evetm0?=
 =?us-ascii?Q?588SQKWn19vIjyJ3Azw2LBOjoj5WYxV2mKxpNUWDIIXG0PcvxLu5hKto9lQH?=
 =?us-ascii?Q?EYRh+ZOHkv3kODe9i0Ce2Ceh55D5mf17pD+FTgVwUVGbGSqIVSvHNlgk8SYX?=
 =?us-ascii?Q?CXzzsPA8+x68LSEvvoAUhKo1CHmtSC8vGBBTyN66aMHUfw9tfRd8ZDODLI0t?=
 =?us-ascii?Q?LjDdb1X0cOZLXcnTXgYQsKavkhaJsDeHIugoifvLrjoyhNAa6FcJLF8tPsXx?=
 =?us-ascii?Q?+WPoWkjcAfwQOA6XUqB6p9KK7wZZpdiExTw8zwDfqwEsZqBn3sota6NXr1Pd?=
 =?us-ascii?Q?wWErEIR1Z3fuCXmk5YTiNcaNgHyuKsP7zspsW9e1nuaZEkKsHKdRlZxYpKND?=
 =?us-ascii?Q?BJxc5eEecdMvX1LF34D4bxJIbRXFWt+yeSlhhm9q3FkwGCbYwdMuw2v+dJN6?=
 =?us-ascii?Q?9f1oUdvsA5P6QJXoEuxZamhzYAN8muNu1gwPkY0NHgGCyVuCT9rX1t4jHpej?=
 =?us-ascii?Q?L86Fasc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:39:52.3015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c423463b-fe65-4ec2-cc77-08dc62b0291f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

Delete fence fallback timer to fix the ramdom
use-after-free issue.

v2: move to amdgpu_mes.c

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 78e4f88f5134..226751ea084b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1128,6 +1128,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
-- 
2.41.0

