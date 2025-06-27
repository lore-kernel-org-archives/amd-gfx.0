Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFF5C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45AB10E960;
	Fri, 27 Jun 2025 03:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwqLx3sF";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2428A10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH+zz3ICxQvLDgteFxAUAIPPBTpU+FuL8sackJVCQ2vQftkBhwOUqO+JTXEWLjjcRspYx/1x4J6rfzVzXTea9d2Db69d19Rp5DgYqtyp4ca0ErUJZ3Ub3Lvd5Yucd0Hsi3n6hB/IFC8gpVZrS8XCz7SdHLJ+GuHR5fvVGXA4Z91latnEUcfCc1lPJ3rp2XwZZU6LRkMyzaklgMgXfhn+xWiuLAfbRViofOr9eZAOcpt93Ln3/DxuWujq64iedOM4RPT6Me/sUhnfF8yuty+yAhwGp6WvukmI9mCNk6Wy7BwofO8hOExr/+N2IwP2WlhslnkKmPJFkJJKcB4gYqj+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=p+vciW2Go0UVDBRYO7DyT1XGEv1OxP9UCnMaKPga7SVEbYXFFO5HKsmuVa2c88fl/Hcw0ES4dXepamhyyzjcAjSFf/HfyXBPYOFXNe75ltXmak4JApQ56cnd+vK9HFToWkDK9mseKyJuiQ1IAOrRDC7cp1/GCRt4YzGh3kAP3mScZabEFDjuLsPFj+wUpjOwp/umrxO7zxW823Lgd+nWIJvXQbGZSg/7KZrcBs0XFrNkPtV9FX8vd23ZDa5uc7mef1EEu+M8QyaeWHNRj5jKQCJqs92c3tK3V2k6gv0Gg6psdA7x7uv+OE0wKhxAKXVK/eRHz9J9/Rp/9QLhPXTzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=bwqLx3sFtjTK0lOS7Nqvdbgxa+MokHHfir6qmudUTUor5wTXCpOKK7Oh7Lbhmj5cMJH0PfVwcG9CsV2LrUQ7bSdLaFT+FrjY+Tpp6cS4OH7Z3QIv3rZ0T7LfHgJQzJw/SNCE0PSVwoBBuAraqU1z45DP6vvk54bT8eMQZpvS5/8=
Received: from BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 03:40:40 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::fa) by BL1PR13CA0198.outlook.office365.com
 (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Fri,
 27 Jun 2025 03:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/33] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:57 -0400
Message-ID: <20250627034002.5590-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b83e49-40f8-4b4b-ab97-08ddb52c6344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tPkOXDsoNtVy8eB6SkQrJCB/fBXjgK6dFb38+FiIAU3jiE4Qdw3WF+i1jaLo?=
 =?us-ascii?Q?O8T/sUZwoHgwW5I5cNMszR4lrlM8JfpeVr+iRJq/wXIeLlQL9E4o259IeL0x?=
 =?us-ascii?Q?yrNVMziuzql2JlPSjT6l5H02PbdbO4mNm9CKkqKo1fP5K58ITVXXUWHK/mJM?=
 =?us-ascii?Q?CQHkfk22/f+U8HoDgfrq4MLZewCs9d9wAF2raASWSA73AK47XRQLvxVpOWhe?=
 =?us-ascii?Q?mqzcTEPnXkYEW3GBJW8RYkOsF242haCjhXEnP4f/+OovZ5xXov0BxDIdzFKz?=
 =?us-ascii?Q?cHBDGeysrzjhEQkWUiRqgSfPqUITwEW+W6FXerZfprI1jKOXLZ5RuLuCbZrI?=
 =?us-ascii?Q?AxogVVYDwJvM/Oh5E9iNBDUzK6SupMUmBQm5yQz9J0shnliIpWgz+ZF4Pf2w?=
 =?us-ascii?Q?CG07KLSG2fqUPRrtot1dVwu/VWTaqM1tiqU3SmHO5ZsYZCiRwoCKMvuIKFNX?=
 =?us-ascii?Q?EL9MqA3JBw7SgicS1OpNw/CJI3Eg2zJoAV1hODyWnq++WSziNMl9XmTXKTsj?=
 =?us-ascii?Q?WKOwtG2bLC0qpU+k45w5U/VQRxQhqzBgQURyr1yd/xgjLVjHdtriZzQQ/RJf?=
 =?us-ascii?Q?yWZnoI9W8nkW8ab/Zq5qal08ZvwF4xSznjCIhrB5uPtlElK/10EwMIffWqvU?=
 =?us-ascii?Q?qqRwlfqQ+ORqfJ34P7skEazF8gSSDp0mxaNK8BEdzQDXg8oV7gE50nVxSQK+?=
 =?us-ascii?Q?xkTQibXRt4bq9Cz1JLbId6FH4UUutjwPYM3j8KgrOfsA3YPcJAe5RDmSlm4e?=
 =?us-ascii?Q?5RCsJtUKGCKaKm8wKCcUn+GafZKyM/WMlMffqOBM2SzEStzaRCJH2RMB8jwU?=
 =?us-ascii?Q?DdexJ8fImuspHLt7x1X+Itzzw0MQYSzolQVQzhcmqsXFN9bf7ppnLjCubwbT?=
 =?us-ascii?Q?eSlj/dyii1lbSZp2Bvq0I4FORmOdBpZpqtN9DmXJMHX4v3M8EVrJt33DAiMg?=
 =?us-ascii?Q?FRRS82dXOGEipL3r4AQJh7Ye6TfKaeMNNz97kJisgykZA8gmNTBOGwQ6Z2a2?=
 =?us-ascii?Q?SAHHU9T+Dqw5cK5I6EMA0Ou+QjYZ3UM9vfk/V2SkqORtBdnSG3cD2LkOmL4g?=
 =?us-ascii?Q?BW2CNfnydGyqfvZ8z4lvoy7XDpWWi2/iTGHuBou7YICZJ3jDl5tfCl7Zl/QC?=
 =?us-ascii?Q?UDms+Kt+yU8dWduld4eOvGiWRxs8+lUau2sSSiBZN16V5ix9/ihvHjdbIKOB?=
 =?us-ascii?Q?wWpdcnJ5sUNLFvh4jVAoklImrPG4Mqdj27aGNbHGjG1NlVRaOWapfAV1ksjs?=
 =?us-ascii?Q?BySYlj5jgMXJLAwylKruYIiUv3lEjuPfM1LbGQ7+OdNDiBu8RQXqhVfyTOoZ?=
 =?us-ascii?Q?AF257Ihd8UB3gxfcJ1+Xq3jOcrWUqcYB6nDpRH/jJH1INeOE3imt11MyQyxl?=
 =?us-ascii?Q?C4U8csnkn+7aEhIyLih5vmzMHvtgoNj9QkHPIoqNS1JwZywUm8FZ5GJAryNG?=
 =?us-ascii?Q?lWRWc7FHlDReTl2utmFKCFRcFqFEzjolxUv1SF7foZMN8Hp+umK68jt19StP?=
 =?us-ascii?Q?N1tg1W8Ma+ry8HWT1hxY9SMkkG3U8DbmJb4a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:40.4682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b83e49-40f8-4b4b-ab97-08ddb52c6344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea63550..faf2df7ed3fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,21 +1471,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.50.0

