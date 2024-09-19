Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0464ACE8D78
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 10:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252410E171;
	Thu, 19 Sep 2024 10:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKSL6CnE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E9610E171
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 10:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2VRyWDgkA2LylTjwD4ZIB9xhILE/DvqEsYjnKAe39LUfPRlrjyft6KNW8wDFpSTlimGDTXEORJdJRLpEMEpvhTydQW2T8I9qN0hol5PFSfIc7qO6I8+TWk4PUEXUHZf6oookz8RufJT6mQzRtFiNIy/46Ibhf/5TdN55OZr2jFgkq/q+mXRdJJjzw943kxCW9hxv/K/5FZmckh49Z+fRx+cY2XBsL74ah8ooHFpY9rd7DGZppA5O86u/BmZVepKFS803t/5jNB50maOTAxAa/b64+xhsZWuEudtveib4jVc9xtlXv4cjNICxbfMfQ1EbwrHLW2/pPla6v3METa+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co5dA3iQvA1c5kMz6idyAuVg171annq5d/FSWUHnZqA=;
 b=NpnoADq0wMhF0bZD7remzeTNT7YIyYqqJ8OVp9+2BWAU/6tlkmwuMmx6wtPTBU3f441y6C5oGGy3FWpo3w+KyGRVXd2783+Nx3JAnP5MyxRLjj+HdyhDmIVKjv1bQ2HBZd0dpY26/Y+epfmyZqxLinyOe9v34A4gHFtWUIhFmq9LEYC4h6LBe390kLn5IiZQ12JyZxD8TXOp73+r9l2LdVjBbGp+wnJWJzT1jZNObRZ0TYl14cbJ/WxlcF6y9DT68XffNuRb7Nz0Z7+BYj8Kr0+n2Bxx10h5DCg36ZfKSC0vV/bVnPeBH2kdGmrA+S12afFhKkaS5NQUlQlnOiOg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co5dA3iQvA1c5kMz6idyAuVg171annq5d/FSWUHnZqA=;
 b=XKSL6CnEu4nH3IQefCINgXikLZd54Fw7IbmVJFKlDP2nOeS4HRhn9xOKjiR/bexXAanR+nqNK3hrrkc0uHTe6Ku0XPmgVdi432blljXLYgWb8ZSrcBRMkkK1o5kBkCvZqAWsEvFLeeBX1BY0IqNcRFC01OWwhD9u08d01aDXy8I=
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 10:44:07 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a3) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 10:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 10:44:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 05:44:03 -0500
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 05:44:02 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <horace.chen@amd.com>, <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: disable force reprogram HW state in SR-IOV
 environment
Date: Thu, 19 Sep 2024 18:44:00 +0800
Message-ID: <20240919104400.155699-1-lincao12@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f881480-0a20-48ff-5e9b-08dcd897fc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L/sM+hULaPPJ6Wdzc+eY2/5CdJI6pmfTY/L4Gffe5OOVBvKHjWiY4y4+IZtl?=
 =?us-ascii?Q?dY8MM1DNKbEqzb/tU24dr86aCjfuCwCAC9uSbzUE5/8t9VlUQ/Vp/mpG5oZr?=
 =?us-ascii?Q?2Uwprm4XhwcCqNI6XR4NAXAIKgQcO7+xZyN/bh+9XFtMOO6tV2iX2Co4NJEX?=
 =?us-ascii?Q?Oc7uS4QZgXlAtpv1Esb7wWm3zWjRbTFtWNQ4UvkTMD+KVxu6wbDlqChh0Qyb?=
 =?us-ascii?Q?kR5Eva7hUAi91EhZ2r4fey+PWosgq7RuON5iIxHlPjoaY25qbGEKtLa5XzQp?=
 =?us-ascii?Q?CBoVu9x8BeemIlztwoUU6g+a1WsAHxlgCpD9+gjnuvCSJoqpkQOKnTsHoVkF?=
 =?us-ascii?Q?hfMDm8CtsV19gol6V8mvLlaXVp6J/VOQg6tHpLU1INRK+GG+gYF4kVqFzKM9?=
 =?us-ascii?Q?qTYLYyQJV9mfsh6rJO9x/XPIR7G2C43RRNhVe7/99wmzKo/HonHSzWLXEgeZ?=
 =?us-ascii?Q?Vz4fVcnM3d31JtfKrT+NWlzhk7kw6fc6IEz2LlDRFIumnwBBu1YZStUhbS5j?=
 =?us-ascii?Q?98ybJRjukRN5t/wAJ/SioH6tAOe+lUub4cG7bO+niTuF0XoggCpmj+Sf4Yie?=
 =?us-ascii?Q?GgEKqt60+DdEkcrZlcJQgUTEA0TIA1E/67Qeq5aDxtXsr9BrM2WTVNN7gtYK?=
 =?us-ascii?Q?q3uthoOIyDxg4F2nfwsg0qomkymO339TQgm333I7+StClNLqgZz3C7hTsszd?=
 =?us-ascii?Q?tVk2U7q6cQHP6caslOLeX4DBOd1lsAod778F6ZF+qb4hGkMSAsez92XJSNCs?=
 =?us-ascii?Q?I3c8LWL3y2ZnCRV6fRvu0RwDSobMbuFExf4fFjOJ5N7zd+JjYZAAGMH6sQbO?=
 =?us-ascii?Q?CeRkfmHpHXR3rlp5ibW5uJOyfwgX78OIqjBRNkBDEUBtyr43lxsDYoVZlGKY?=
 =?us-ascii?Q?Xc81CzjToxFVK2nXnL7x9zeX/In9eG/dqfVb4t75VV0X2dVivXM9rSESzyiL?=
 =?us-ascii?Q?qEMsaro+Djm/sD2s4NqlQNzCwaDH7SkIE1CrnJ1ZKCVV0QRIYojrX+/Frt4s?=
 =?us-ascii?Q?UOv+pAhZRXQMUA+nVNMxdKzNMxTNZOmE8TJwYrPs4dpNDxboyETBv0+fRChn?=
 =?us-ascii?Q?vkOt33GKvc5FLEd+OIW2OGf6GE6pvBWA7S0HuHFClDHm12EosG+BPSBpMqx8?=
 =?us-ascii?Q?d20QaCHoQy7BpO8zJQyVfHYURJRxbGMWMBch3KFQ/ZeHzh0OT44FF2KiouSp?=
 =?us-ascii?Q?3kVFX7+p8DnclwEFIIWw4pGqNietqyXZ+ts8fW0QzP/XUar6Z6iO2G1kP0NR?=
 =?us-ascii?Q?5c6M+VQi3diUHfWADuzIXcibichlAB3Ades43CZt33PEY33rTemViK10+gpL?=
 =?us-ascii?Q?REwdxLsMzu9dnYZP7DO51Uhl5Y9nfulsCZrgo4EPwI+bh0rr7Phiv1Y3wN69?=
 =?us-ascii?Q?jrDK+dHklerV9MpGLLZY/7Zm2WRBU4izfsntOVCICd9Li4/s+KuIhx80i7Ux?=
 =?us-ascii?Q?dpZuYYGQtzmJFhPT+gyP2dzp2vB23psr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 10:44:06.8260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f881480-0a20-48ff-5e9b-08dcd897fc9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

SRIOV do not need to forece reprogram HW state on init which should be
set from host side.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4a6b4ad97f06..a67678ee2d3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2234,6 +2234,9 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
+	if (amdgpu_sriov_vf(adev))
+		force_update = false;
+
 	if (!skip_display_settings) {
 		ret = smu_display_config_changed(smu);
 		if (ret) {
-- 
2.45.2

