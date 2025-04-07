Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194D4C369A1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 17:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72F810E52E;
	Mon,  7 Apr 2025 17:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1YbpZ5cS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E17610E52E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 17:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqA5nHV4eaSnxHQuJySoN38xxtP1iph8vNMHUa1eUwZT/qhv8OdpoLUSZmtOu5fvyvnILAlMoIa9NWDYrmKeO1OeOzbNPg0fFmqrXVbm4Yqhz/UHAVOb1l2gDb9uUXfFqnJJB4ewEB9ZTndykQQabth9sd/fqRGJAg+H0KmIwcOZYddfgkB+8fG/PejYOzzi5UQ/ulO5eFCdVhUN7rRFbYXRPgSPH693sJkGVp5b4CzbUM2fTFQaxupolhWypXL1q7BqYe2Tput30NuTHmmp1HGASi7yZTQI35a/YljmOJvPMmFYjWqgG2ObmaQL0NuhQ8B5s6o7odstkbs4nqibLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w/PbEUSF7nWi2s+Axbs82pdnFkW2D5RZzTi2AUFsgU=;
 b=bnRdgnt9ktmMKiUyZ0FiDOBvxUi8rwcVoko+FuYQsnC/nORVxe09HFibFpLqn/f0qAlewgqRfaqCXt2RhYXmlkqp681P/Rba0f1RRpRdZ9Na82PrnCgWs5TM9lE8ld60IrSKJZUi7Nf95Ahvm7aGUnEQrHViujbrsiHKi9zTt4YNOX9P5E3Dwog4Dq++ntF5R6vVBZfc0o160S59rAANhQ6W8w1Z/y9Ps2KRB8US8yMjlfCMTebx1iijJGimW76TTInBPLdl686EICcY6m/hFBif3wgw6Jg523z6CGeOzdgJBS8XxPygGBFQeyDSVF0h3q8BvPEueXnXzZ3FD9q1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w/PbEUSF7nWi2s+Axbs82pdnFkW2D5RZzTi2AUFsgU=;
 b=1YbpZ5cS24fPT54ooYrmU1UHrFp6CCmho2EwAPaeF5c7NnZVGj4EaxKhegwVGMgky+PToAcXoBRQ7ZlCl77ufAuZS2oSHKsIfHfL90tZOTNIp8k5VXwOuGRxeBGHBNj/Ywpj0l7S2/iwnBz1FAcLrQy85oIgYOO6BuBDZ6LrpuM=
Received: from SA0PR11CA0103.namprd11.prod.outlook.com (2603:10b6:806:d1::18)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 17:15:26 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::6f) by SA0PR11CA0103.outlook.office365.com
 (2603:10b6:806:d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 17:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:15:25 +0000
Received: from dell-1e707-d05-15.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Apr 2025 12:15:24 -0500
From: Masha Grinman <masha.grinman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Masha Grinman <Masha.Grinman@amd.com>, Masha Grinman
 <masha.grinman@amd.com>
Subject: [PATCH] drm/amdgpu: Move read of snoop register from guest to host
Date: Mon, 7 Apr 2025 12:15:13 -0500
Message-ID: <20250407171513.235207-1-masha.grinman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 93557c7a-1312-496c-82f0-08dd75f7c983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eQ4ZkHbh2ZLaI2mmiVboD4gTzP4n4+8PdhW8DNoX7hbi5jJkh0PsI8A1Sjd7?=
 =?us-ascii?Q?9UMcVbYEB3Q2JEauabZX2OWIlNq5IJhDTy4wzOo+QKPYYRPe3ssGt2kjSFXo?=
 =?us-ascii?Q?7mM84VHN4cAo5s0bmw9EptMr8c0qaf4teaxBv3X0GTpeqa/P+wXp0zhztwWq?=
 =?us-ascii?Q?opyWU2yfL0LiWXFJBE0oP/c61QmafQ88/S69wuSzfGcw42uTM/IDbyGlKy9B?=
 =?us-ascii?Q?tOU8U8BbR6HSbLcvc2NuZfeiRkpy1Pud82d7fnWnycM0m4Zc0EBmiUxYDHW+?=
 =?us-ascii?Q?iZTGLqhUnC4vZMNjzC80YCzcbwn50zdUGgIaUhKCaJHKRd4yYwDne/DiwPx8?=
 =?us-ascii?Q?FpaEiSkbzThSQuDnUR4rD5zkktcvpaWtNLG3lvB0QzsoYdviADYhS02bqJzS?=
 =?us-ascii?Q?CY2XWMyOn5468D1XmH3Nfcwg74Ch0AdBjBoOaRiYeg1YcNDjpw+10mLU9kpr?=
 =?us-ascii?Q?aAiuph/uBJAFDjBGabRZmpBV/N2kA6dMy+PQLmf325Haol+OPzP8v4EJcMCu?=
 =?us-ascii?Q?Wo3DFlp333icKtyWfqtfBS7KRC55Pu0zQBvcgJWjFpMygZwrqViHFyweFt55?=
 =?us-ascii?Q?axyZFsj4pw+tef9hgrmGM8FzljcFTaK2CgMTkguqyjhHbDOJZ7J3LtrQ4HKK?=
 =?us-ascii?Q?4lZhqS5opLfO9p+pOHqfjTu6XrWMsbzYIeg/iCD6iEF7DFqKivU8BOHagmPr?=
 =?us-ascii?Q?nlYVtbBor3+pmvPUlucpx99Rj8qzqPEX8xqQUj3ckE7J57BEeCkazbNLU5yx?=
 =?us-ascii?Q?kl7/HCGP6eRzQB45Ej647CRlIs+jarUmbzc9xW9b5EH3bUU3rIoVbblTFTjf?=
 =?us-ascii?Q?kQ8ZSZFnvm4qMA2B9zzcZj8oSAysyijpJ9Es0MkDRwStYmacX5l2jbYu5n/E?=
 =?us-ascii?Q?7PaXXKWv//5cdm3FjWCv97MQxBV5aJt/DPpaiPDUCe6HtAf04B1fQkRtzbXZ?=
 =?us-ascii?Q?6SUVI3g0MHdHLKa9e42vaBqKuCzMRc17dCpcpst+1zjOJVM3wvE+DaJL0iNx?=
 =?us-ascii?Q?qY8eSu6m1cGQX+tqKGyqWby0apUPF7OHOdi3J2dh+0CMkqBVofIlZK8CE6OY?=
 =?us-ascii?Q?2LPLNXgH+BJze7VU7kfybsb4H1xTIhVysRll8aVPTdbbPoCcQuaMWksq1Cin?=
 =?us-ascii?Q?HJ/lVmbO0dPCKOUYr1D0MCNHQh3V1j7ArlgCsF8h8NgTVm+lx9eMmArrVlk8?=
 =?us-ascii?Q?BZSnzDN+kTNXg+1i9+5w5iYpKC8tdCIqppKD7KQDNkgM/RUEWRouQlWAAkaw?=
 =?us-ascii?Q?PpVp10dz1zMcIoMInncHSHyRk/jibVLaoQUA6ESmoCeAIqoRbIp/wImMCksP?=
 =?us-ascii?Q?jAkuYfgrgWIi8L1qOw7v2oGaj4H0b3E9sjF25Wcxuq2YNLib3I64B1H0Y5Tb?=
 =?us-ascii?Q?hwnM8VmA3ry3Y4aTKs9I3Qs9eSAcQqtpRdhIfqYqDcaXc0BqbpJRGoY1HD6R?=
 =?us-ascii?Q?t52MCxLXuwtH+WJEritP7l9iceVZm9U0p76Cd2LcPw78LqHGbY5OLQzLtTkc?=
 =?us-ascii?Q?8RqntOI4C67eLmE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:15:25.4064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93557c7a-1312-496c-82f0-08dd75f7c983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

From: Masha Grinman <Masha.Grinman@amd.com>

Guest is reading/writing to snoop register which is a security violation
We moved the code to the host driver
And also added a validation on the guest side to check if it's guest

Change-Id: I1d5773ffa6187a961994b3403d4cde5b1641369f
Signed-off-by: Masha Grinman <masha.grinman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a54e7b929295..6dc3896fd61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -221,6 +221,9 @@ static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
 	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
 			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
 
+	if (amdgpu_sriov_vf(adev))
+                return;
+
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
 		for (j = 0; j < 5; j++) { /* DAGB instances */
-- 
2.34.1

