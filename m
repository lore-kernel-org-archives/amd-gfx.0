Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE755C9EC97
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 15:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827E610E237;
	Mon, 12 Jan 2026 15:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2U5P3Rs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277F210E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 15:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY1GkEsbT+yOjHOywik7gaSzuudP6Lgv+2XpSF4b/IteL3ASAx93+fg1ZvNjfv8Z+/aOn4hp2ZfBK5myJ77GOg/4S/2b1T/EN7eXVsduDxHAbBzV9OMYSM9phFpJMSykjN8XwqOa4MDS61H/NdWKvn920GJp0VGppHRUIVIQIKqOkVUqytY64E07Z3wGdf4RRJCBBbKCItm1E2uoWPEOebXnO2M1SxK3Fnkm1iHkukF3fVwkBmQ9zoPNLetp2ehoSv5u271fiDFb96l3o+EeXPiZUqWPgZdXzKa9cElZPj/IvXbYmmlkOKtVD6sUwWrz/BwavDsLDMbC97o01RfAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4GnlXM9fJVMRdMV/cWOSUbeuH24zyb3meUVL4Gn3uY=;
 b=AAuK2gaPcs0HIuohRsFIreOyIoh0S+28xXhgOM8Ko1xZoogi+4AhmbMPxOwC+rUK+P/9RLnzsCAEdENVyxCx+DKNGc2//kqOViSB6QgW1ZcGIscDf81iVAWTFTw97BUQF1PdTw21dOGDV3cMBZcMwcoWWEA6vdZSGRFzXFyrFwHneRcxisVQD4aRE5dKBsE4Q5kJNU8JMJYRZzgLiF2kNAFnsjQ71TwgLKPMZyfZ0950uevTd05IzkCT72mo368H6mIP7abD0SExyTZRPpmtLCWaNHPfrwNDQ5MgIVUvXyXSS+GLgSclIbNi5xkTVFNmCnQc27qRwB+1p4ATxl1DoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4GnlXM9fJVMRdMV/cWOSUbeuH24zyb3meUVL4Gn3uY=;
 b=a2U5P3RsJCdUXD0axne8zPzimy2bEV6b2kZ1yctZMliPelgsNCuT+N3SD0BjaS5WxyBQk+01hIfkzKAGCBpBHSl+GW2MWxETeNmCLDKRmHzYDA2iYgqtEiwdjt8ERci0fnfd1gI1Uasr0oG0yQDAUALCdPhP2mfC9c2g5PVoSI4=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:21:33 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::44) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 15:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 15:21:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 09:21:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 09:21:32 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 09:21:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: program some additional registers for
 resets
Date: Mon, 12 Jan 2026 10:20:41 -0500
Message-ID: <20260112152041.441734-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112152041.441734-1-alexander.deucher@amd.com>
References: <20260112152041.441734-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0ce6e1-164d-4f59-b02d-08de51ee447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOohvhVJa4YYXN10cmLdczV3X8BMOzfF3yUrEvjVPZ6QJlolUKo6ywKQZyjO?=
 =?us-ascii?Q?YZ+Gm5EAfmjG+S4+u5/xS99u6dlfevnKgF/EUkX7iXSQSLXynV2fghk9gn5m?=
 =?us-ascii?Q?iaGC0vw2+CXvNLbtsDxGKNog8Y2CdJI+ffmd5l6t4Ih75iLUKd4pHy/sMMbU?=
 =?us-ascii?Q?X/dgLQY31T384+HH8RdfdjvRRsGN7E03X2NTvIPUZzDaC7q8aiytjdT1CaX8?=
 =?us-ascii?Q?IQwxFXHGCIUVKlaVYLgyfLB8fP+VJXEoJjGR7EPiIUawcb56Kunx4gEkqI+U?=
 =?us-ascii?Q?axIb0DYYiaoDvDzIQxumjQzOxq4LEtDL1Mb+iYALFVEwHvn0KzJXHjatZssW?=
 =?us-ascii?Q?qLjVG7VM7CG+c6I7PNjz1jQHADMb1JB81ybspbECwWqbyR3jf+ysLSFUADom?=
 =?us-ascii?Q?MFuPl9U3DeVwY3qeveljc02CiqgQWJPcDNI+z6VFi3mAr/xgBGcMlTmaxP4E?=
 =?us-ascii?Q?wfflezzIzZ1AOp/smLkJ7FQO5K/CRI72XM+uYWVQP+2dSBR46wSRhiS7ez6k?=
 =?us-ascii?Q?nZ9XfE635jYHqdnoXade5mjycNHIRE7/xEY9R2CJArhjJ2Eop4t9QhZvndxx?=
 =?us-ascii?Q?rz13ffocOmW+e+KfuwfA+Qd8Y/+pudTx++iJ7GLAwfXhLanX2tIh1Hl8kJbB?=
 =?us-ascii?Q?J9tFA4jYKIQVEQeIv6u6YaI3Vkr/wjIdZh2jWtwVcnf98j0o1FUuQF7ov7Mr?=
 =?us-ascii?Q?2g2142u73JX7wL0GzToCfmnNzpfYpQawWQlExlHbf26rQVX/G2CRRlp51Epp?=
 =?us-ascii?Q?9GTJCKh8tuvCInV+m3rwKv0qNY/Yy9ZhyKnbIIpYMlJgQXP9HkrFU/PCgb71?=
 =?us-ascii?Q?wZR/W0Pr7InlZnO4h/YdxObbaW2i/NS1GYqAunIz4MGeePAg78kcLqqTEByG?=
 =?us-ascii?Q?jkVKoI72xlDR1ZCUAZQ++FPmll/aQdtaS9FZ0joc986+lBo3uyiD0T8x+yxl?=
 =?us-ascii?Q?kbtoEx2wASrZZZe49NX6IuuQ7arNw0Io18BfBf/9mt3vC15HTdHdsq3akfTj?=
 =?us-ascii?Q?hzRApu7/BLdnrpaIMO2CBMFlHxM9DNWOSW8zNcWfc1iTCDTrPgnK5FANBaLA?=
 =?us-ascii?Q?MefRWHg6uBjdgVO8f6BTpsHEN2OZ/OxzwI+rwG1vPgP3yh4gvz7dB2X4GU+V?=
 =?us-ascii?Q?ITquGvMZYBaKFPSJUvcBHNoV2qRQ7Q8SgXgCeGNFvGEhBVisMbxyxOY20bmA?=
 =?us-ascii?Q?/LxnvEhxgmki5EoUEyQ5xurc7ONAbnWnoc8cUg+7PFTOCSrPyo7jZw5LLw6h?=
 =?us-ascii?Q?4zcMulnbpYxnYbEzGKeOg9v/NBVA/M7NuNQ0iPVnUxN3gZry61Ql9oRjr+x/?=
 =?us-ascii?Q?bbp9ROtB3GCJUS9ZLrhcy08bJIWaD00lwFqtUILC/EF+ytJpqSA+Au6HJxVK?=
 =?us-ascii?Q?AtJCMd1+7okWF0DF7xELmWBjaJ40CRsW8UuAOKDqm8PN84o2+PBb8EAsWNHI?=
 =?us-ascii?Q?N8H7/SlFqi4SBKq+c67IVjlZ5o+t2VKvG4slw8EvCmCe22qVW1pT1Nws1VPz?=
 =?us-ascii?Q?7qUlDW7CyilAx1Px2I66/lMEG47HQ4JYO948eS4FZq3u2ay0ZM9z6UFZBXqQ?=
 =?us-ascii?Q?UgGR7U48D6u2OqGp8mw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:21:32.5773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0ce6e1-164d-4f59-b02d-08de51ee447b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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

The first change prevents the hw from overwriting the ring with
NOOPs after a reset.  This is helpful for debugging user queues
since the contents will be retained.  The second change disables
conversion of XNACK to XACK during a queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c68f297ce7995..a30af12752e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2666,11 +2666,22 @@ static int gfx_v12_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 
 static int gfx_v12_0_cp_gfx_start(struct amdgpu_device *adev)
 {
+	u32 val;
+
 	/* init the CP */
 	WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
 		     adev->gfx.config.max_hw_contexts - 1);
 	WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
 
+	if (!amdgpu_sriov_vf(adev)) {
+		val = RREG32_SOC15(GC, 0, regCP_DEBUG_2);
+		val = REG_SET_FIELD(val, CP_DEBUG_2, RB_PACKET_INJECTOR_DISABLE, 1);
+		WREG32_SOC15(GC, 0, regCP_DEBUG_2, val);
+		val = RREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL);
+		val = REG_SET_FIELD(val, CPF_UTCL1_CNTL, VMID_RESET_MODE, 1);
+		WREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL, val);
+	}
+
 	if (!amdgpu_async_gfx_ring)
 		gfx_v12_0_cp_gfx_enable(adev, true);
 
-- 
2.52.0

