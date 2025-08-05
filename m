Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BC2C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812C410E276;
	Tue,  5 Aug 2025 14:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tT8Qq6xX";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8680D10E277
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW4DQyj3aYrJjuqmYywVFqMCo9I+DBfzt7pJfwvzWR5bDvw7Jj1Am8jBRgpU8nKzZeHaUn9ZDjd9APOof8+LYmq0OAUmnu0LRaVS4PqQyp4Qx0qRkrgX8Oa+m5Utrc+E9d+GSb79yIt+fKqkDs8AsCbSPQcBGugfcYc0mWBMyLsD2EU3SaJj/Da1x9EB3untnq17xS0SM/KucjrNubjmYwWv/txLhDkn1RmchxP4RneSVLjCKghxQFDY82StNbo7voOyFyYX5v2u9JWlkea8jEu4ejEY3KVQHFNzoOMbcCHzwSSe7kqr54PpVKu9o51ory+i9DqIRtxIXP8ehCQphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToybFUR/ZNW4e3WZijS6pV5s/12XF71W7MAyFaJb/KU=;
 b=xrw9evav9d7NiumoREQFNSurUeMnl+60yetU7UCn9MSyEPIxUBE1vqG5HM9oNr+1RBbScDC/NtqhZT0Jzrf23Dksg9weujJVbTfCSZgPrWKAsVc3nhTh6M15x2Lwbh/1f2dCpHWbFRBKR9+bv0OzZTj4wmHFeCIJAM8PKo+fK5KSs2GRsOC56mHNhlwCSApzXmtMtV4k9h+9hHrBfGE5GmjAzzc87r0Ao5Svsc9fRpWJZUaO3dPcCeW758Ff6iIDwuDPalpn9IEuZgul8BNLZh2EhnYrr9Er4MtYvhdARBPkRyrTzVGc/mVWI575UGEkUYm4wYVDRcXNnZ+DGO2diA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToybFUR/ZNW4e3WZijS6pV5s/12XF71W7MAyFaJb/KU=;
 b=tT8Qq6xXlIF60SYIxpzBz35dOghJrswgXmtx5BEhzmn5WfoYrqQAji7h5NosU+/gG3D9RhQafg+2qW6H5iyClbQvjkm+jSM6mGMlrlFhnjP6J8WTDXR7GRbrWYNKVXT3qQHXv+snzjeUESJW8aEQzveyPccZMnC/2mzVCUtRQIw=
Received: from BN0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:141::25)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 14:09:54 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::e2) by BN0PR07CA0018.outlook.office365.com
 (2603:10b6:408:141::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 14:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 14:09:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 09:09:53 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 09:09:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <harry.wentland@amd.com>, <alexhung@amd.com>,
 <aurabindo.pillai@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/amd/display: Fix vupdate_offload_work doc
Date: Tue, 5 Aug 2025 10:09:47 -0400
Message-ID: <20250805140947.4159216-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc03e3f-4db6-4dee-3e4b-08ddd429c01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BDvyE2ju7GMm7cySAQe9Qj428UdAyLT3/dFEW6Tp1qAmDiUOc75r4UrS8E1j?=
 =?us-ascii?Q?AGeqrkFV0nCGJAaJsfgq2a76VTP/3zxlPh4KMqtG77M3Kc08iolG9/bHBKLR?=
 =?us-ascii?Q?Q33jS/VL+SHSOOHOpQ/l1l/NfbGeJ80ohnfVFuOXMmXMVhwExOhtnps6oU0G?=
 =?us-ascii?Q?E5+C80uP719TYOZuNKguJAMrCqE/3KoziNBMkyNP89m2FGzmqi2SbeG/w9iw?=
 =?us-ascii?Q?jEu0qO6FgDnlwzH6A5qjSkptrTNytk7GiIDlfdo/zeyGDbsQSrnJBQVwey/d?=
 =?us-ascii?Q?6UmqkJa6hi8dD1HjTyOGXgQTZxuZfRC4ueBDfmU8A+Ph+j/W+iyVEaBNp1G/?=
 =?us-ascii?Q?AA9P2wZU8h/zbGQO+5Eln9BM+pQjAosdZlEi5APrYz9JILdAofN7N44EFSqv?=
 =?us-ascii?Q?pBrTrYs8RvS0MwMAs4JVtDc2aJ+MioAjYGvClau+MJ1Pl/anJNcYDmZ9w887?=
 =?us-ascii?Q?mTocRi0jXp2DkXqMdgVBWTbBO8Vw8SedeBUQL36LeMVzfvTtFbNH5krPdATh?=
 =?us-ascii?Q?Wf8PIe5IRRUohUbdSZo2xavKPIDQob0NYF/nJGeTOn071GaWLTqFxLr/8pwT?=
 =?us-ascii?Q?3eLPNL5n9PuxbRu1x15A64jBSBVBORkEnMMxRMdAPX9HnUtw3n1GyK1iqxay?=
 =?us-ascii?Q?KqKOx5c1tFEPJ+qlAitpT59cM2q3v0wtTKBcu1XXVUoDgsN7hjlDwtmZBKeK?=
 =?us-ascii?Q?LBpMizBzA0feDyjRXcf5WDTsZjz82KumL0/KWAKS5XBd3q5sb0y4M+NW472R?=
 =?us-ascii?Q?IncNYz995nwn3QoKy68cCAvtFclsm8JHb2lGVQnAZk5A0ZvMzXuB/RzD60aT?=
 =?us-ascii?Q?1x5g4FpawAclIhGnfOhEL6HsPGDNszZla+iiOAmMxNaHpR+0VZP4z9/TrH/O?=
 =?us-ascii?Q?Ljjp2BmppcOwa+voBW/Pw66DZ3GbcuKY4adC0p1h//yYi7Wcf7j8GivnGF9f?=
 =?us-ascii?Q?DPB96l0QR3uJMWi0mMlQxb1Tm95FohljnYoJOV95NtGsqRr+Qxgq2HkfGRQn?=
 =?us-ascii?Q?NGI1g1ppdt8A1AXrHjf9kpk3mVfRLK29xLTXCa01I3AbyC4rBF70lDkqaI92?=
 =?us-ascii?Q?/y/Vs6Rsnjb8Gsv/H46qTzUJ1suQYErm5IV961wAJfd0phduS9YHFnD8X4N+?=
 =?us-ascii?Q?12HsB98D/huA0/4C+KANHAYCXXplhgUBsZWvnEK1ZB4/fLNr7sHFEjouI5rq?=
 =?us-ascii?Q?7Bfg2+Y6gf9mYzuQfss4NXQpRxpnj4umOjWiMpUSrg8pKymWZ7k3WMl895jg?=
 =?us-ascii?Q?R2wlNAqHcO11e8qR/zCSTQkOjtTAV1hVZO+Tzyq4+sc08DZIu89tRXHt1Kyq?=
 =?us-ascii?Q?vOaeEuZSXVGq/NaIKIL+5UHpOxEmk5xHxiSkQgBMkoKTz9SMASYxOkLLWv3q?=
 =?us-ascii?Q?XZGEZiQJwiGT5+MbP8c2sBpOtykD4oTv/i4rROczxX4xQ52hcLYozFatokqA?=
 =?us-ascii?Q?t/dg3YVy3Ehmep/KfGBnlYsGQnQG8lwv1GqYxC1WJQA+GbHXNaER7u72XT1v?=
 =?us-ascii?Q?RhxHs/PQ6W7HD4NW9uApVRBvh/3srrXTwuSK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:09:53.7723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc03e3f-4db6-4dee-3e4b-08ddd429c01a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

Fix the following warning in struct documentation:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:168: warning: expecting prototype for struct dm_vupdate_work. Prototype was for struct vupdate_offload_work instead

Fixes: c210b757b400 ("drm/amd/display: fix dmub access race condition")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 94f312bae9ac..cbd107493f8a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -154,7 +154,7 @@ struct idle_workqueue {
 };
 
 /**
- * struct dm_vupdate_work - Work data for periodic action in idle
+ * struct vupdate_offload_work - Work data for offloading task from vupdate handler
  * @work: Kernel work data for the work event
  * @adev: amdgpu_device back pointer
  * @stream: DC stream associated with the crtc
-- 
2.50.1

