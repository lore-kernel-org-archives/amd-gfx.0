Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24AC71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DBC10EA76;
	Fri, 13 Jun 2025 21:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDZlsh3Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1345910EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA5dDJc1bnwBprhsM1+kHfIb98s101fHIN4xVYWxEvrx/re/J31HWx9VbypnPkE+w+dudDfYE6nvc+w8PVY7oOAXPXpu01+iN/GP5hfcPt1oOqn40Pp6na9vvLPgwKtW6uQzmriYEpey8+6EioD2f7XlJAiRRVPUDILBN1him9Kbnm75S5wiHPQLHZpkiyiBO6691tKVG9nGDRTDSY2mpbbhFffP/vMnRPPgxm5ozGkJXALvAxOedBwek5xtMD2zqUrVmYR4JjM2skRbfAgNXupjr59u+4ZDqFy7oo5TLiqSDcmB1ChM4QNdwPxjzeCRdZZi4WRT0GUEz3iUqhQlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQurBkFLJ79dzj08lELMNIbnQcnesNDeM1ZYgw7aIh4=;
 b=gNroapaLXVEBLzZNWifU+qCKlQXDD1BmkCO+Vsn9M5VnmXLSAZvLEs0PFrIjgdqI6bd47ntm1z151ws3FPV3kR/B3AsRgfhT29NnvHaNIpxlaCQFa84U+Q3oHMk9PBuovqxpvSm881fLGYz5G+xV7XspzOZUDUPXnELOM0zHDGgsYrJpBRCQBax72ORBT8zsZjpSiXx3fxjg5A22OGZQFxAstwWeq+9gfHYZzVOs1YHzCMC3OC6yBrmJd3U74u+fuOw5cy22+Og0lghdpxgTxUQgMBBIKeHfCxWNmgLvGTIOkQxked5JrTKCZmZmc0C61OBoqJaa7bk5bH4O0MXA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQurBkFLJ79dzj08lELMNIbnQcnesNDeM1ZYgw7aIh4=;
 b=JDZlsh3Q3fpLteTJF+GFjwiiH4bioHhsaqDjZSq6i6KLx2y2zV475YZIW1JAdu+82GsWAmKuSyYp/eChECLFL0Zbo/OArFnLk9ZU6+Nejgy552AO34M+KzHEnUINFb652jixA8CEgRi6DEX4jAY1q2hFKevqs+imExurpea++g8=
Received: from CH3P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::26)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:48:17 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::f6) by CH3P221CA0012.outlook.office365.com
 (2603:10b6:610:1e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Fri,
 13 Jun 2025 21:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/27] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Fri, 13 Jun 2025 17:47:45 -0400
Message-ID: <20250613214748.5889-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: be5fe975-46af-4326-30ea-08ddaac40185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqjAYDdNHs+3eKl7kEc18helN+GA6nIzxfVgRmv06LVuc1Iv3g2YfL7SwxFi?=
 =?us-ascii?Q?PEfJWV3csO9XDydvS2qmJ9pbfhesaOnpCVaIMmtUclE4sloCkpMnDZv7f2Yz?=
 =?us-ascii?Q?HapQAxY4csUJh3L1MQVy2Ax1lzs7b2U8gRgUpymxYvU2Qw+P6qCWnNxpIzna?=
 =?us-ascii?Q?Tq8ta4fqNeb7toaHtnP7I7rwrDNiDlnJ+qHXRbT6EUe3gmE/WUli9tWGmNrY?=
 =?us-ascii?Q?VftzSdEwdyKcs8fhaDG620mT87Cn0v7cgnZtLHlQF9kDNclGBdn+ZYl3dpOd?=
 =?us-ascii?Q?xxz72uwXD3EpH3Ae/z1t0NDQIv2TPKqmmzuD1/6LZX6v3WA+aVyHfsQB8kj7?=
 =?us-ascii?Q?c5Jak6VApugnVJCgFkHKG0Ui7VvRKB+NieQAuOByMrHhH5TeEXT5ZnBknvud?=
 =?us-ascii?Q?Z5IjSsMW4s/ZJKmmaH3yBITOXn4jlmORAfXGGfz5PBaVjfYXE2ieML5ak5zt?=
 =?us-ascii?Q?A4x9OVBfEOfWDCgzpLsOip33NbWYbsKaxeOv3cunMmjG3Znhp94mBwYms4ni?=
 =?us-ascii?Q?UKde3HZDs49jz6Qit82ORk/P715McPwaBEZfZ9OX4a/EUON5U9Uf93MxfHzT?=
 =?us-ascii?Q?mzBRaFHtBYmAxDWmi7WD+RAgeolInXgqZv/MFLzeZMai/s3h3rzxLGzq8X70?=
 =?us-ascii?Q?gEUjjl2MRZ6wrQxeTYthulaDQM2aU3+WHu/VLLyre/3oJXD/c4xMgtmmZp59?=
 =?us-ascii?Q?tCMuIwirTyksgdzqTQMXQWJsIJ1e3uTz6iRQL33L/2RZZ0rk8dX9PmdN/I/B?=
 =?us-ascii?Q?ur5Uw81V46Qms1pxv+6MMNRxON1gQRGRbVtF1tllPTF67KF+5BCrDAtlEFZ/?=
 =?us-ascii?Q?pudstNNTCwFBeJxxbppNEQtDovJugHx+Jhy0We/xIEAg5OvjdviLfY9WrxkQ?=
 =?us-ascii?Q?bCLYxib+KqWh9nUQCKcVTdQBlLSr2FYnor0lqgkjDFkBRIl0BtbegY62+oUK?=
 =?us-ascii?Q?K9uI2nNd4Ej+/66hPWj3kxKJif434I2hbpVSBinc6z2BGOlRMX7C6m9Wn7Pc?=
 =?us-ascii?Q?M0mhCj/1yNveUHKt97+A3druXtTdep/Pr743HGCSN+FhyA7XBd/94U7oPvhh?=
 =?us-ascii?Q?pWeAb0WVZh9U4CjDNtFR3m8TXjl3azzExEMocBNqRP3AgZ6T1NV6dEGlbn0I?=
 =?us-ascii?Q?s6BKpkSqxnTQ21JPsyWlkKsiWLNeqn5cqL1zP1Bc4BzIicV3ewGJ6S6VgA4U?=
 =?us-ascii?Q?tbRzGGz8+Eydq4D2zQcqo+z0wHIj+ya4dkWf0dEUywiPTIfMKfhdddAATsTQ?=
 =?us-ascii?Q?9sqU/W44AFnz7JrY5Q9ggsrWLr6SY9pBbs36Q8U4jLxCRAhB2fM7ntb6GVtm?=
 =?us-ascii?Q?tcJJKna2lCOYIViexj9viWMw6v9WooSy+auhw69p5vl95Wv17PLRETPwIURS?=
 =?us-ascii?Q?cZLqlEJ9RHyAVJuJSAENIASmqupN/7DUb5gZWPVj2lTOGvVXZvu7ro0j8USa?=
 =?us-ascii?Q?j+gdq6vk4bQzahlOy77NoMQnBEbu2aae50ikmi/PGh/ldpf5hA+lMG6b/9Dt?=
 =?us-ascii?Q?xl7BAsoqxzQ2E6nZUdBIk3oQmB73cEcPHmrV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:17.1739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5fe975-46af-4326-30ea-08ddaac40185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d5be19361cc89..ddf7c2fd94952 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1978,14 +1978,21 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

