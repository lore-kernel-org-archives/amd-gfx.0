Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7FCF58E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 07:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E4410E023;
	Fri, 20 Sep 2024 07:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvdlCU+u";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E6310E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 07:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br9aWIM9JliO+3gbsySUrsgcEDdNphniI38q19knQadinP2LQMYTgvDqzaxjaibZDcS2NN6fW9ugITZ26ng6pKdMzaEPMQMY0/e+OErYoAPntbT8bn4fi7CdkhCfetaE58NVkZxWh0q0JS5ESC9wGvKU6BxEbt42lkHUuuWD0NZYEGIYrD0prISb4ni7TsHOoHFdnuUFv02IPFTMCzvZceN//PfkJ+A0sZydDoT7XjDZW2E4IDDur5WL4OMzP1O00oXVj7g//ltUaHqBFsiU+PL5eX98rf3mTskk1IBqqr8I5eGhT7Js8DqqauML3n60YjLBPVgvLJYnrztpBZ1Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxtJQx8eft7KSHnUyNrd1jr6ZD1rujbRWAIxAOJtb0A=;
 b=dF4/mqMItst4d48dM2Aj3588PQF5k+IUIXKnFGVCKLgKVOnNkmiMZHBTEYfyftYDe6/RTcBaIQOG5G8KFYLWwWrBmn2RfIfHJNLX8FjNH4ytNswsXOhj9uVAhbb23kdfe3lUB+MX6Nx0ka2/jVUepb/3W5eY/sFZJCbHFwR41ajoDPNeF75ed1O4IvKnBhX3862bQcyveXoPrcx4H2Dhqv4ijznBbiq4YEp32rSIubObthPkqBR3cnTXz355+edIiFw/mmTZCMyfQ3poSgllvG/P3qy2cIDNtZWVPDSL6xfQfmetJ+7sQ8XVACGlts0uqB5SAwIgnMqUnVHaqOTMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtJQx8eft7KSHnUyNrd1jr6ZD1rujbRWAIxAOJtb0A=;
 b=YvdlCU+uEB/bl7H5s7RJo/j5dt7tk2/OGSUG+j0riHRN7jF790MX2H7c9vAHZeZNynGCg0Tqb6RgxEtlnTb+op+/Hm7Ce0m7OZQ17SeE86SdxbwDMw8ET7PGqPXZOAR04u5qdBEgqpYHLNK3J72IH5BSkYRJED6/wwbJVYfNJr4=
Received: from BL6PEPF00013E11.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:17) by DS0PR12MB6632.namprd12.prod.outlook.com
 (2603:10b6:8:d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 07:36:36 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2a01:111:f403:c803::3) by BL6PEPF00013E11.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 20 Sep 2024 07:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 07:36:35 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 02:36:33 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] amd/amdgpu: Reduce unnecessary repetitive GPU resets
Date: Fri, 20 Sep 2024 15:36:07 +0800
Message-ID: <20240920073607.109275-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: b37c6032-584d-445e-3e4c-08dcd946f4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQsy4xRUYOeFPCl2/sKN0qwrRIpWMjHk5IRmXuDFQJIibvOrLqwDJvzmAkY+?=
 =?us-ascii?Q?C8Al+hR6evS2k5HNd686evAd7Uin2GuKc2PMHjt24Zag+xm1gzYWbez0fdBk?=
 =?us-ascii?Q?lRvxm1YKqsyxOdiEwBfWqVohUwWKr+OFGq79JLeKnhjF5PedfHjQV+MUPt0K?=
 =?us-ascii?Q?VmUr73Ti8OpfNWiVTkRlKeRzERFPIQQS35h2yjqMo8CaW40M7sB/5jr9fnP6?=
 =?us-ascii?Q?xfVHy8KLWxYF42GL+TESrJftLAtYKalXad1r3pgiKRdpmECv2mWONEHCO0Bj?=
 =?us-ascii?Q?MaZ32waRqhMy4gr2ArNxmUxAjiR0tTt8Ko2s46nZubUXdk2xOAdj1hZ8zkj5?=
 =?us-ascii?Q?e/gRwjhuLs1sEXt6mMyuNPKLZW8B+o0bPcyKcGW4S4QMcM8IWwVZAYdMuHLo?=
 =?us-ascii?Q?uKN7S517wE/DLpmn/2BdssZzHJmf2uZg5lm7qN2PsgX04GEyz4yGjXGQuF94?=
 =?us-ascii?Q?uiR2oyIzVy+vBrn9gOCkK88kL6O9jiS0rwWzJymtl39742dh4Cs4h0I4mbO8?=
 =?us-ascii?Q?c2WBeMApGhCPW9XbvOTOkwyWYjY0kJdF6kzcXdl46ZDNEpDtEXocJFgT+fTc?=
 =?us-ascii?Q?uI794Rp8Mgh7ApN2IWeEgvrHmHQ7N2oSosGeRqg3v2iWqAySEEZTUgb1uEb2?=
 =?us-ascii?Q?qLrD1uLU9fP059ZTXkx1xtvgFV2T1LngUd8oOxPdT/t4YaEyzEqBS0Na4kSj?=
 =?us-ascii?Q?A/1Vj3Vg8OBiWtRe+I9Vw4ColWYbDSkjaI6a2eX0cOEpC/FSBM694Y8woCar?=
 =?us-ascii?Q?t2hFGPC4fEqTPaFS2vN5NE27CIY0IrhgpvAoo/JDXj1U3oy2FWqoV/usXWHI?=
 =?us-ascii?Q?LmLaBHLlNBUrQFnq6XhKGflL5QTxHQu8iHVmrF33jLIzIBEAQC/Nkvmd5L10?=
 =?us-ascii?Q?SwJhk1rIzgQHbMPXFu4eiFjUxmag3+ZiWGmbQp98jysoq2LH25cGZp/pKV2E?=
 =?us-ascii?Q?EAOhnkvNh7DO1wBJFPgfXyTO7P6/6xf492RqKChrqNpWHUYLIm75Jh8jGjqS?=
 =?us-ascii?Q?Fi5Yz+ZPp6pcokuSPiORfGhrxmGlrkX560df1Ewcz0v3hk1BkGyUQi19LNyS?=
 =?us-ascii?Q?wWS4UopZrRbpWQmSK159M5PEJ39LRe10kNxJQxAlTuRHCQTUCLm/ra07uIef?=
 =?us-ascii?Q?iuvEv1dDt+1NrBc5Ww+dtlb4RXPxkaV/eJ9Lwk86AgM9xt27eEq+DNfP9BTA?=
 =?us-ascii?Q?MebyTOKAXCM/BfkTIPLy+Ajc7+Z7nPbLe0MvqXJxRqqMC75eg2kuC5kNEYL/?=
 =?us-ascii?Q?z7gm1KAF8izqXsxRKDeP5fDk0zLMNz4tmYhNUe5ZOU6/8kfYa3/d9ktswrU+?=
 =?us-ascii?Q?YS8D9UHWyCB5f7vZlwb05opFX+pBZ5ZD2nsMA/JbNmDBZu7IEhHQ8MV8x+Mi?=
 =?us-ascii?Q?2KfhjL1nOcMIpoo1DPKmbKS+ReR+QkW6RIVU0LmPEUxiTS0AQwNCfR7Tl6ET?=
 =?us-ascii?Q?WxBoKxTZRvT3nRFrCHVdWnRx/ybYz0wa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:36:35.4460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37c6032-584d-445e-3e4c-08dcd946f4a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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

In multiple GPUs case, after a GPU has started
resetting all GPUs on hive, other GPUs do not
need to trigger GPU reset again.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..7d48541b03d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4306,8 +4306,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 	}
 
-	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
+	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+		int hive_ras_recovery = 0;
+
+		if (hive) {
+			hive_ras_recovery = atomic_read(&hive->ras_recovery);
+			amdgpu_put_xgmi_hive(hive);
+		}
+		/* In the case of multiple GPUs, after a GPU has started
+		 * resetting all GPUs on hive, other GPUs do not need to
+		 * trigger GPU reset again.
+		 */
+		if (!hive_ras_recovery)
+			amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
+		else
+			atomic_set(&ras->in_recovery, 0);
+	} else {
+		flush_work(&ras->recovery_work);
 		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

