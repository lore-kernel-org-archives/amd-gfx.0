Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51400D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E606110E4AD;
	Mon,  8 Dec 2025 17:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fjdgCgXo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51E610E48E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cte8wtkT/7h/zz6qTupjff7QKicNJWLrqzH8EfSqzSuT7E3ym1x8aYi49I9nioPFuz8KkpQNtDgoqalrSIz200Kb+IgBhHej0GoXCeFJYolloTdwT4hr7+dAt1VxundsSGDvjy9EY0J04gfgKUhc4ifFaYOfkatv1a0ptQKoKdSpVz4/jrBJeGK2QuQlS+Z49O5bJgcMoMnRSp8gGuMgLiCu45XTQTQclkywFYHa2JkmegBkFTEBh/CgDt4P9B5N9A2nbqUHWo+iCcJlH5fy/WC/62dH9GZDxt9eXoRM6z5uoP2sMk5vJgIPhcJfMRXHRIK9wJ2pmWpjNEs2jAdb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC+kUvlV53n/KaMmsTmOSyzdSvTb6MpurL0m//qqakk=;
 b=BMb7nUtz0wnA8cnQpv6/+dKrdRgVslTM7ygQAJ+SNdAiQG8GHL0eRpu7PK/TdGr64OKq7GIgsK2mlQOjtVLk9WJrCzmrh3dvTtPZb7K7dv6IGXLdqX+nAzsgnXAsEHxyyIk8oB/r2XbfoRAovhT8xoaaau/Od2ETjaA0ExlID8DIVMeMhbHcw/tPaOgxPT6TXK1/Oyed+Ud4MbGaVgjw9zgLwDPuCo1IgOdEgjwK2TUyK1h31TkcN31L/XYpKtQrlv6wXFDI6leVr6mQgLNrPx99oVpxQmUCv4ZuLxNqGgx8B6AY+5OcKGF9NT0RspxXcvqSkG1HK/VeXlnZT9rw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC+kUvlV53n/KaMmsTmOSyzdSvTb6MpurL0m//qqakk=;
 b=fjdgCgXoMrMbAG7baDAooUB8B5xqiwJF2DItwrXtQ4XBWidpBeKgHp7PIuDZ+NhusLIk83ATIsX3uwb8zw7QFxa73k/4oYZf49iVw+UiTSVmd2zhPEIwsdF18hik5mYDsKGdDB8p+ZRcS5Fch2YMt9hl9qqYN+D7xe90epMqpqc=
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:56 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2f) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: only copy ucode for enabled xcc
Date: Mon, 8 Dec 2025 12:17:15 -0500
Message-ID: <20251208171720.153355-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b35e551-ceea-44e1-c4a3-08de367dbacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R4DcH48W6bN7Bb/jAMV4Q0bYb/XLpt/7OzwKvaemffJOkn81FvTsmkbihMwr?=
 =?us-ascii?Q?gnbdCa1aTK5ltEBOPOi8YGjCLbH+olrpJMkezg1QGbbcrIUGK6uPRgT8w5XR?=
 =?us-ascii?Q?hVn9lGKKi6mEX2hwokzc/pnS/3p9f/FA0ZN2Pj9m5KeZlE5q+TRuANdhAHnf?=
 =?us-ascii?Q?JtdJCM9WyDkmF1Dw4ahBjJS2WwKKCIAlb6HnSvkJTRnrjC2zW8dOT4xTUdat?=
 =?us-ascii?Q?iR6g7svcnBTLP1xfMGYNrSRfJ8+KsttYwrd+mGNnSdSXkIYVUVcwJJO5QyQn?=
 =?us-ascii?Q?qgiW4KETCU/bsirns5UsZ0dqZk0iciJ5OJ6FTEPNlN1tXXW4WkTcTzunib5h?=
 =?us-ascii?Q?Xwo/gRGG7dE2xyOvvHE3yEd0mBqmibLrqUVvGjtz6/WBcnQNXM5l9tvR2Gn0?=
 =?us-ascii?Q?aXVfHOB+FQbK//cEnrQtN4gNLZgtp3EOIy8zMXYAPEJseUwzedaKqLoGFAXi?=
 =?us-ascii?Q?uhdTwcaciDEkyEyaki1ukzl1P9CiTS6N3PHebjWk8HnxXo4DYfAf2DkSnaQZ?=
 =?us-ascii?Q?xXaQ+A16eQcRz+iA+kYOsbWCrLz7OiQ4KXbyoxVcQPghlg1jzsVirmMt6mvN?=
 =?us-ascii?Q?eMLlp6H8Hwr6S2NPsOkTWQy5xl6bfF3VobVR5MOO+Xirv9jh9gNVBk9Q5hPd?=
 =?us-ascii?Q?SrB8uvPInID4tFoQ3RKlBs8SpRUHyAtlCYC0UdYBX293b1OpamNXKSKhkG++?=
 =?us-ascii?Q?7gfeYH8A0a7meGPlPpKIDnIoM+l0AJUETHUXu54uGDvmQmB8RHW6SDcZIwPe?=
 =?us-ascii?Q?RL8FUeHuo8osRkJFV+Oa6hbshZYMCLBrI4kBShu6oAC2sGucxfk303Q7Tex7?=
 =?us-ascii?Q?o6jsegxhNBx1huNvNOJ/umkTJzGMegIoTh68rl9RId20/vuC6XIFULuiryc+?=
 =?us-ascii?Q?SuMbAmDHUa/On6vaNjXDg+ExQP2bPcmutl9zZMpjpJ49N48xMhUbHyiPNve3?=
 =?us-ascii?Q?45xiJA2Ml62mzng0ZJsyJ3ZQZmPZNewDiQKWpUdAaFoPv2mT9DmNTQK2YNcS?=
 =?us-ascii?Q?Oub+r7jHiwOiasMoLWu3IBKZgZwx/95Ryvf+kOcU/Alw8KTMnIhG65MqL6o6?=
 =?us-ascii?Q?Y5bX/7eHH+QNyETB8iKyXIATkf3V03LYOtSiGCTcjhbnBM0iRCCSHmdjHEjF?=
 =?us-ascii?Q?llJSyY+e+AZkRBrdmHusX1tGZkMNVHt9vI1OIZcTE0dfepmQ4rcDkJNupZTo?=
 =?us-ascii?Q?XQhrDiQ3p9e0gfSSEJUwZPF2r7MKynU4FqdLAKpL2ZnGS+IZqbYosV6kXkg9?=
 =?us-ascii?Q?ea99pe7HWltv06BA4KXQHGseUd0hR8QAnePX5VrflIt0GKr+QcMkS2cNvMwA?=
 =?us-ascii?Q?XUyggb0wJVtwxIko32N/8ARsIl6GnrBPXKMq4SFDM9nZxrvGrIsnnrBVfV5j?=
 =?us-ascii?Q?+/CLY6qsk4crNAmr0Xy+f2rbvXrKcV86ZRpQLc6T8DOXorCCe+gShkJWm/s/?=
 =?us-ascii?Q?XK3at+jgMPlvT8MEy0gxyLyJkMCOQex7QRBF5ofjRek1lhJ8EJYWVWqaKeSZ?=
 =?us-ascii?Q?yKJU0OHX0al2g45XgTxAa9LWtNsm7HooHl58cGS+xk35ccFREk1H8o777r/1?=
 =?us-ascii?Q?nKj9Wb5H44SalFFXHhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:56.4834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b35e551-ceea-44e1-c4a3-08de367dbacf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455
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

From: Likun Gao <Likun.Gao@amd.com>

Only copy ucode for enabled xcc instead of copy for all 8 xcc
for rlc autoload on gfx v12_1 to save time.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 5e9ab3a5184e5..b93b2fbc4a12a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -898,11 +898,13 @@ static void gfx_v12_1_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
 		fw_size = toc_fw_inst_size;
 
 	for (i = 0; i < num_inst; i++) {
-		memcpy(ptr + toc_offset + i * toc_fw_inst_size, fw_data, fw_size);
+		if ((1 << (i / 2)) & adev->gfx.xcc_mask) {
+			memcpy(ptr + toc_offset + i * toc_fw_inst_size, fw_data, fw_size);
 
-		if (fw_size < toc_fw_inst_size)
-			memset(ptr + toc_offset + fw_size + i * toc_fw_inst_size,
-			       0, toc_fw_inst_size - fw_size);
+			if (fw_size < toc_fw_inst_size)
+				memset(ptr + toc_offset + fw_size + i * toc_fw_inst_size,
+				       0, toc_fw_inst_size - fw_size);
+		}
 	}
 }
 
-- 
2.51.1

