Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C066DCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592E810E697;
	Tue, 14 Oct 2025 19:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRog4Miu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD4D10E694
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSPuYxZIXpTF4dVRC9RkFEX/eraUCLB5K7LwkrFZ0SzoBEw9AGnCo0IKd7y8shPuts68BXcTHwCdZgbbAABBWHl4PFvgyrHYQJhaBgtTUtSMSx7dLfEU5P4hE1obfJ9VY2+FNo2Y41k5GvjZb71+AMrzKSPjjsn52jcUn1vLOwDIyOguOz1hLYduJrfe5ZdN7sPDU8uNrkJMnnKcfZv3we9Pcjp2aVLgBDzBOxckPA4t4OuTrw47x/cS6BSbe36Gm+c6cAH4z2bx8H0n6ZWHpCUNKzxe/f1kICsNkQ4Lya99d3AafOnOP6lJ1RbwVp++Q6XKhgO7yNFASnAIffxDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itFwrNJRXANfyUr3S+koCVRGZxwFgp1gQcV0BwckBJQ=;
 b=mJKeMEWQe64hm98wzl4jblyIjaQaQQeNyvK7tRq1nNZkthOefbwKra5v94ZS9+WKMQQnpSbdTHT7tuDB0sqHTXRBViKhH9wzAFZhs5/NeX+PrEASqFRTSeOApHaZzOVPQ07dz3K6eRq3GYnL/aNLgmQd+m0dAunJ4oGcs6Bt5TdQ47dABae7GJgkjYHYXDkOapKgbLCERYVZZbcNfyXwuUA57Dwue14Gb+xLQW+8wV/gnx8pdZK8c4p1G+CiAKceZ1IRjdtCNjwh7KwYQNEQBL1yOpDiI4jt8E415CWSyXrj8dpwLL90QSGcOrnw4QXaN5qUZpVvQXWg5kSvHYyLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itFwrNJRXANfyUr3S+koCVRGZxwFgp1gQcV0BwckBJQ=;
 b=NRog4MiuD/q5DFVXoBtr7GUFiha+a5OPvqYLX7jXCxuKXXb60z28axI/Nf4nCfJbP8+kor9g/XfbUMP3gDV9zGOCh7KwXfI8k1IDCXf50wmZ6pemeSl1fMoAdjl2Sl5gUuAqQTJY0RVUGbz6XkAS8n7ykRWLG44AMvA121JnyZw=
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 19:30:54 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::d0) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Tue,
 14 Oct 2025 19:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 19:30:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 12:30:51 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
Date: Tue, 14 Oct 2025 14:30:36 -0500
Message-ID: <20251014193036.595453-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014193036.595453-1-mario.limonciello@amd.com>
References: <20251014193036.595453-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d5438b-2798-4213-3a43-08de0b58314e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QeNhpDTWTQWzpNSmCO1OOR49c1UDNiTslg9AerVGyfuT6u6ic9ZM8SSrtEpM?=
 =?us-ascii?Q?zPkvt7ejiCTQ7vTZW+FCKssz5dKQTVBsq0b3PgoVaf7iWzE2eLMJs1UeTtZA?=
 =?us-ascii?Q?Odc1nIJJcy+lPiYnjwl/Tk+IkwZZQIwPS705K8fSzvscgoLXTVZGWuZNKYUk?=
 =?us-ascii?Q?FhhREmkks6Q9T62SOF9pxoJ1wp37di6cIhQpV3CeLH1190UfCw0paj8aaa0/?=
 =?us-ascii?Q?1/MvSLxDv1Mb7AxiTmm7bMFMA857W/WdiHMtK1ezemS9K2w5FNiKep+nRPdj?=
 =?us-ascii?Q?J7rkQcrUbhYEDWJrQg8DroZI8Uz6O2gd7wTlBm3WiepBywtxtGSlOWOm9T2O?=
 =?us-ascii?Q?6QuYbwC9HsbqTt+NBd15R7WH48bpiTYTAc8S9fSNVkF9yuFG6eg0WP4pBG/o?=
 =?us-ascii?Q?4xeaQkVCofTXo+pL9swS8IyHblJlQSKEjJw8kIqR+h/hlaCJarU8xD0SfZ81?=
 =?us-ascii?Q?0rTj8vhb9km7myOTD6sy9XGGmStThsEirCACGWSHmLvmGWNuNZchhIX5d/3Q?=
 =?us-ascii?Q?Y+gcrmoGXUO41XEgxIDzRsJpKMof3P+tF0hnJ36KrNgxJr1mlr4g4V8dOGUi?=
 =?us-ascii?Q?L7tysZG0OBF1HVhliN6wnGYJGAivPHLUqrRJbZKntp7y4/XGFVeQI/hF/4KQ?=
 =?us-ascii?Q?iQ2Qa2y9/dCSStB5kovseMfmOf32NM+iQUOjg0ZokoQr54M03jeoJx5tagyW?=
 =?us-ascii?Q?LIkvjr9+1UaNtVn94LWmrSGv//uOJbdmrcOdurlg6vxyGEDdiPPaqbBs/DgL?=
 =?us-ascii?Q?iGszS3nYCQpaZNj6aMvE8c6hfogbPiTd4gmPGnNpl/TNGT9CLsHPsjHYNF2t?=
 =?us-ascii?Q?Fq/It8jQvufkA4YEkDxkr9HejPjO2CDUXRrzskJvvBmbP6mzciUi4jlbC9g9?=
 =?us-ascii?Q?4xJjimyAa0yvVSuyX4OL6Flxbcga3s1OAvBnm12qkWZSQVIZT7t88w5Ngt+c?=
 =?us-ascii?Q?kXxB3mbYCiXD8GOKjp98EWI1GcIPdUAJMN9P/FGQCQZrp/3+jTV/CM8gOC5n?=
 =?us-ascii?Q?3BC0ggGotFEu2vX4zjwewrMYJKPtVTozsM7piIEKiVgNperogG85vmPHemII?=
 =?us-ascii?Q?Z+GsQA2CgrdXEKiaUqvlTNc+BuB20TIAaYMXBY12Gxei/Q2lYCulysWNJAL+?=
 =?us-ascii?Q?ih38SWWezW2cYyctKdQYKT9Shd/6PjWRFZ90wKgL1uR7H0ogrEy8NB3REx/9?=
 =?us-ascii?Q?RBjeuamA4YZ+3ysmqtZQeQG80DtKiZ5oTE31imD/UcGslfMoFKd4aNdnXMsq?=
 =?us-ascii?Q?IIB8sCbh15b7TVZRn6U4EaLQrlKLbOR+HfOvA4nKoqVPTmRDVloDGGsDpRAF?=
 =?us-ascii?Q?1hu/IXVv+eIO41tKLRkhFUxH/fKnbOjDaW/Klxjoltbs44U8CRv+B5w2iPq5?=
 =?us-ascii?Q?yAcUC4JckiWOSoPabQA3Nqr7poWPu5PShTjxp6rET7O8Ajdl7G/JiQ+dGAzt?=
 =?us-ascii?Q?VlQ6DKV83MK4kGLriJH7ZRC3h8I0TgHyOVtEygmxOTRftWibzGB50a/Llt90?=
 =?us-ascii?Q?b6Nhqz9iXLFea8I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:30:54.5002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d5438b-2798-4213-3a43-08de0b58314e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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

[Why]
If userspace hasn't frozen user processes (like systemd does with
user.slice) then an aborted hibernate could give control back to
userspace before display hardware is resumed.  IoW an atomic commit could
be done while the hardware is in D3, which could hang a system.

[How]
Add a check whether the IP block hardware is ready to the atomic check
handler and return a failure. Userspace shouldn't do an atomic commit if
the atomic check fails.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Harry Wentland <harry.wentland@amd.com>
v2:
 * Return -EBUSY instead (Harry)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6446ec6c21d4..f5cd9982af99 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
+	if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret) {
 		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
-- 
2.49.0

