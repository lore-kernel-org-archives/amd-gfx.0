Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBD9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 14:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B21110E671;
	Mon, 28 Mar 2022 14:35:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBCE10E671
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBjRlpmgHHPF0TztM4NZMmXmQLB2bnhbOzsZqnT4rrI7kvrGwneG+5s7/X2Q5IyfEY4T5zSIUpRAb3BbsxbomvI2VwnCh352tHfD7hlPASLsqG7BfAdzGPFtYGPG38Aps1vl5A/Si7qxs8ewQ/BQMEsPcsElc+0jEk95luRwHAEOpJjYqQZ2ZkOvUg9rSJz62MuUPbv4U+McKh3a7h1eziO99w4luLMwZs5sKvANRm1M13TvULknwWj8gS8OwqPcz2DXyqyPWxcLJr0klIYB9V+BffDDa7xShXS4U6HdJBZVbimUJjqrTy+GKEV2TiO9tYIClxHxgu0xBJdJIOdGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbewE8KgZRyVGRtsXWIjAe0Hj4O3GbR/R5Plp7y/EhA=;
 b=SI6bcIjZ/fqV7FBhONc3s7SCcEl9PEyZUcBP45x80rSyzWtF1x+FsO2ec5iU6/kWg1WZcRvCSei8LCR4wqCoZ+HzezhYY9GxKHUotm7ym6JboXa4b627esLiBsUgNMrvQK+S3tFzu5Qfaea574KK7BjZvVkhoOTSgoGKv4f+hcl5xtonnHnnoAXs34ObFo/gMbATI43NSjqhypHA2BeONJup/wDpYUur2T6iW1RQMZbz0gAgl2sRbCrpRdj5IO3EJTD9jCuNi+EiV6obojMgHhhusCXGOnyWuFQ99O0zUxfx6t1v5J+IVbFLcMi5JrS5tBl+9AjUyg2MTU4I4iJjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbewE8KgZRyVGRtsXWIjAe0Hj4O3GbR/R5Plp7y/EhA=;
 b=hMv/4d7lE4OHgY/APxSapM36VWKRTCrQhXRDTPKKrlD7qmtwaO/6Fs3SmnNbyj4mVfBaEcrl90M7Bml1DChPZk1ASf2/BiLZ+lzgo2/OnmMUs74zra1PVPfMpZQeUCO96oBFnXpFpSSPJ15RW0WsIfZAiSRLwPFuJU8K0cXB/kI=
Received: from DM5PR19CA0023.namprd19.prod.outlook.com (2603:10b6:3:151::33)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 14:35:29 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::86) by DM5PR19CA0023.outlook.office365.com
 (2603:10b6:3:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 14:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 14:35:28 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 09:35:27 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use switch case for unique_id
Date: Mon, 28 Mar 2022 10:35:17 -0400
Message-ID: <20220328143518.1253762-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed233562-e0c1-4a39-9908-08da10c83451
X-MS-TrafficTypeDiagnostic: MN2PR12MB3053:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB305361C4FF96F52842AA5E79851D9@MN2PR12MB3053.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K141w0qYF/vK6sx9bzBgdZzvmROiNbLFaGX8Tr+VrpF0Dc732IhH5WlGimDLnP4fAlWLwb7p8TK0/McAoDWKlxihLqcgV9jGX5Sfi3YiOd8iHkXO8tlSzIswIZPp0ocbdBG+kSDNn9Mcqi7XzO/HDaBsIvNmvy+uXCdgC4RB250kHBVS5ttm3ChDn2X8L46UzfPDuXkmjkiJh46qsh+f8sjA6RVaUKbFBK5yZsFlarOiUrJicO/g77za6A2pKLjXBO9NY/FUZ39nMcJ02vQFO85Paig/y8h1d6VxaQhP4x2o0zaPU0HKpnD0H3lzWE2y9DWN/tLgzAAONb1j4z0Q02Z6+jNJonULuoykUimK4JTnwEovsZY4DRE+wuwlOc2stzP2l2liQF3YTh/w3s1fBUIRtnrebHklRYMueCUQkBzdh/hHVvcXHXi7n0Er6nTa0Km5LtksFRiYLj1hNRO/+402AaFOXnFn7J1Z/eEJNu8/Vwf/LzG2BT37ZYSV1yNtdn9o9eSxJhWE2n8McLmzo/X2HCG6bao4i1Uhvt+ylHu4Z2pAM+V2RSwuhrXS8Sd8+wIgBbF3dhSL6wNMnrxDmNJ+7llu90MmW+07QTb8qKZb2Ne5D/jdyUMj3KpeDpBRhM/GRVUkcTntqYgQwFx3z5+QfQLomyMJahSiBXfBZCzPSqSBdpP4livykHkFGpuDo5dtDOHtsmvZG6xvAKU8bDl+5i8ik82BuI6BI7bLUEuJ2N/bOoDzMerx6rv0GYXUesMo98+kV7LEsYrrPdr4Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(316002)(336012)(82310400004)(186003)(26005)(6916009)(6666004)(4326008)(356005)(508600001)(54906003)(16526019)(1076003)(2616005)(47076005)(426003)(86362001)(83380400001)(36860700001)(36756003)(40460700003)(44832011)(2906002)(5660300002)(8936002)(81166007)(70586007)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:35:28.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed233562-e0c1-4a39-9908-08da10c83451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To ease readability, use switch to set unique_id as supported for the
supported IP_VERSIONs, and set it to unsupported by default for all
other ASICs.
This makes it easier to add IP_VERSIONs later on, and makes it obvious
that it is not supported by default, instead of the current logic that
assumes that it is supported unless it is not one of the specified
IP_VERSIONs.

v2: Rebase onto previous IP_VERSION change

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31d..4151db2678fb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1988,11 +1988,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (gc_ver != IP_VERSION(9, 0, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 0) &&
-		    gc_ver != IP_VERSION(9, 4, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 2))
+		switch (gc_ver) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*states = ATTR_STATE_SUPPORTED;
+			break;
+		default:
 			*states = ATTR_STATE_UNSUPPORTED;
+		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.1

