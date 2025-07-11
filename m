Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B2C83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0872710EAE3;
	Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDhOE+tj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0DD10EAE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7OCbNW/YMRIzYOeNC5lOZfTV3jWBLLfozHjumfIxPWxxXU98mmGnF3PUz+8bkuDaMTW2NQ6RDqzLtbmzczqrXXjmpM8vMs3Z3CzA/l5ntALc96Nlgjw+qkWL3f3oGoIq0000GUWD4wl9/L0iTNf0ELc6S0s/L7j2R7H/fGtJUee9g3aLUy0TdtHPpvb/lZVxvpmCHcFH8GqOTkWUcpx4y5fkfeRcSIn7ajxnR7EvfblDsZ+QzBc49hk+BahBsP6CwElkvb1rwrXyjir3lkGvr7ieQyWC2uJLqqAr2DRdLjApq0sdxhDq06c73SoeCY6ownpGCWLiRcI79u4vC6zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C/5dH0KLsJA2ADZE7l282PHm45C9dQVkFM8WRfTdGE=;
 b=PqtfIBf1RoX69m0U9DOp/0FoExkh9euXUaaFjuMXjnjed/MFQiPyqFrDhfAEXRFJsi8Vqa5jrCCBQPIdxfS3WpIv2XxZ0lr2H48OZxhTust9OwoqJ7nttk3kgbN3Oxh8SPnii0EZqxNx/u9bqvdPsFxO+9htvU9EJrUz2VSEBPwd+P1Z070kCPXvDBqlh2JrxVduq0Al3kUFVzsOpgWskFmAR6sr3UK27y2Dbs/ppjGrrYujqJtmNFzs2JtDbeceE7zr1Ca4uSmFIYOHK3WZbrUD/4UA4jPU3DUKX63lpzema7IqRWCh3kJv/Z8FyHeerDJNu0RNzZVewfM4jU1FLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C/5dH0KLsJA2ADZE7l282PHm45C9dQVkFM8WRfTdGE=;
 b=PDhOE+tj2rOR1lniVxLp7AXc/O0h5roG3TqlmeLqahdMLr15UPEFc/cXb7HIqreQFh92jTsbi5RVUpRSRQM9ENQMNIjGiuf9b6GAccnctL74DWpCM8ejYmPTcQTeX8jCxqDeeGgkq4PZO0AOdmuwzSR9fcir89xZDAfBvfaR3JI=
Received: from BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) by
 SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 22:40:47 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::f) by BYAPR01CA0037.outlook.office365.com
 (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 14/33] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:05 -0400
Message-ID: <20250711224024.410506-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2998cfcb-d3c9-44c3-86cf-08ddc0cbfad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FhWzfFQ224kS4hdJ28raDdU77iMejtuQeioeX8sPffvl29VJZMcgtjkWV5Th?=
 =?us-ascii?Q?g9HiAHFsvjLkrg9GgbPHyog4qQyXGAI8Nxw1PnwQASYvHWqSxDuBRAZVQi3r?=
 =?us-ascii?Q?SVpGxgoqO4Gh3rIOk4Nkuh/ODRTYY6Fyqr6ygImP24hwV+tYodZb61alywGV?=
 =?us-ascii?Q?e2KEfdMQQUqwgQbruTJ4TVgueanfAnRzUH+JR+emWn/LryTDBTdtPV9SjtNo?=
 =?us-ascii?Q?nl/x6SmYixNMXTtHxiqe2rWOHR2ROm1q3eS5hj+iTIzIzPiPOx5TpkWQAaKj?=
 =?us-ascii?Q?sX39lWR6loOjpUgWztlOiNdfQpDOQI8UDdDJNVM4pbGwA3qDKyws/6r2Wu2W?=
 =?us-ascii?Q?uhYBNpjBwGdYajEPHgU3UTSdFPS3+gxw8xFqOI6w+FbDdx/7YFl/IE/yFaLj?=
 =?us-ascii?Q?NxXtl13UsdOAsOxyu6HCrJAE85GgHHRu1TUyw1lD1QrlCiCdMPBiEAmYCy0x?=
 =?us-ascii?Q?IlEcBeR0lGZXX/jISbkv3d7wrxNj/dS3Pqyk6qDfAVfLCuxUbyX/irIlPzTl?=
 =?us-ascii?Q?jdnSEo0oawJpfhY46IOXicg9hLzL4nzC5eEV833Tmne2f33uisojMiRwGKqE?=
 =?us-ascii?Q?vhP4ioQAl6TyFV2ec+u56fCWnlWGZgfpZkiTDQZnrs8bpyIvcLwTxV49zlo1?=
 =?us-ascii?Q?L1xMx2x96v9XC+ij/oOpRiz8TI0I5e8gpZmuoDoSiSjXuF+Q2AkHK7mc/kvj?=
 =?us-ascii?Q?KFUiR1KNR/qCe1TDGBWGrnEiRHsOuGCAOGj27EskiPbtWhpBOzTEdkh5dKe0?=
 =?us-ascii?Q?lQ+bbBxmF4RHgrtuFTdIV5+anGgav09uM88A9r/yyt6RS0VCcyWUVWnHVJNf?=
 =?us-ascii?Q?YgmPd5LrUN+c8QitsQHum8v4KeH8yYsYeZaA50bidEJ74JZ05rp0wPz9RR55?=
 =?us-ascii?Q?WY8vlLnZ1YmsBqrBOOK0t6fbcL9lPTNew5Zd1wSgv0pC0ckySsxcu7DXojVH?=
 =?us-ascii?Q?6zFjlv1KAYqAyZlSIfIlPw+Y9G08NGZ8NRnvobJ0ZVRRxcJJuDSukHjpEa9h?=
 =?us-ascii?Q?zt3AhEHetOkInIBIiRNDqvBuIxezdOgvdklB75PeEcjAvlDj58X0AoSDgNBt?=
 =?us-ascii?Q?A2bd2Bp/DavKputS35/N3mt+lFFfbGTbaaSSpyEuvN+vARxWeLDXXa1WBUSr?=
 =?us-ascii?Q?aB2kEMYrnPTwIUVZCHD97Io8Mzle5i87Q1GS70Q7yj8MIpQwSpY2nR3pBnNZ?=
 =?us-ascii?Q?/1zwdVDQehUwM8tovwWmVGIUWqIUNc664kQXBh4SPBZHEzZRujQlmjnpr5X7?=
 =?us-ascii?Q?Q0ocrzJp3LcXwQ0daDX7pAEAkOJqcsh3VuQC8KuJ2Jx8wQhAqGSmlEGziJzt?=
 =?us-ascii?Q?2iaFQdsHvCbS2LjyE5kNrcR2P+wYGnS+D7V7JndHbcGuthUXDgy9jq5VXysP?=
 =?us-ascii?Q?VPfkh6Zcghs4ptSoNghvX2y9HyT43+QguBXNHcHEedBkwcEFEZ3f3dUT5GfU?=
 =?us-ascii?Q?4FU5BWB4pkFdBUvadeXgQM17ixdLsnFajv/zNnMu6wFzZfn35G7oUuShOYnd?=
 =?us-ascii?Q?sasKo4BqSce/s0Yz3IoejA92wIvL5YfaaGxx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:47.4524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2998cfcb-d3c9-44c3-86cf-08ddc0cbfad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 999705e7b2641..d8c19601dd2e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1555,11 +1555,15 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

