Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD84C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 16:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378BD10E8C7;
	Fri,  7 Jun 2024 16:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VoASCaIW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E7010EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 16:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4rqb9J/EWmvLZyGBac5vbTYbb20Fvy3TBSrzpkorPXOYOMLyA6dCTNHyI+5kGewudDXyviLmro8tIoEjcjrrSULYW9Rbpqjd4PejGpSbAzVo/ei9x7HcRNlBr8PQdgswCBzpFilVjBe2rMTu0Is/88WqkTX8vF5/30IYvLYBTOiJNMJStpa+64NxX6X/WY01Ymp8kpCQicXIZ2JJat9SoAs+2GF7KpzTsTg05gCzlZyk1xS1rcF1XGMBOlBgigP0dP6RPSpnOVJe2vyxMGIN8IXk+cjAm/F1qzPNuhTKJCGPG5YWDenQiZVfHDHod2avB68O2fGjyPJR31muXzMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2FFYfAenpwE0zQE1oidxG4f4GtlWUTj8aq9/BRIN2A=;
 b=PXbh4wwyi/gVlE/bBXKlCe+RUUcmbZHs+69gj7spYA/6uQWGN0dRXEkEDh+811bq5IqLO33ceG7WSs+MhSqkRoe4490Wu40/4qhkxdVMj4heA3vfz51sveteBmDRSlhGqPZ6ZfDTv1yaDs+EhHZlkTdTrIwKrNfGeAVlFVE1WbY4+eeJDFQMUQd77e7O0Fo/5NQDYdsvufX4SnO26vwn6sVf3CU4dpmRGFh+f5886hPtE/khHX4eiD4f58LcmbnwnrzA2DMaW28ZEajS4jJm+b25G2S258SckM4paELXucNU6VOef8aJY/O7BEgoIlk6PcS/CXRUOYHI5/0P/Zz0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2FFYfAenpwE0zQE1oidxG4f4GtlWUTj8aq9/BRIN2A=;
 b=VoASCaIWBiPf5ixoaX0+uS6AHwg0KapTG4gwCAmu9Fiet64KetQq1i41bCdRL6zur1kj79eT1qDp5I6jte85d/FfztTFEU7p+Qgbo+KmYsEj4WjuFkMg7HaQTOIEsR4q+q0jjFie9eNdy6NWfUurFdTFt7nBpFgt2EWngNY+WvI=
Received: from CH5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:1f1::21)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 16:34:12 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b) by CH5PR03CA0023.outlook.office365.com
 (2603:10b6:610:1f1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 16:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 16:34:12 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:34:10 -0500
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <srinivasan.shanmugam@amd.com>, <sunpeng.li@amd.com>,
 <harry.wentland@amd.com>, <rodrigo.siqueira@amd.com>,
 <nicholas.choi@amd.com>, <george.zhang@amd.com>, <alex.deucher@amd.com>,
 "Ivan Lipski" <ivlipski@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Date: Fri, 7 Jun 2024 12:33:58 -0400
Message-ID: <20240607163359.18299-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bb930d-bb91-474c-cb37-08dc870fa9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TO+KZx86S2sIh784Y1Gg2fMKorW64f9XNCsIvdpIzFNYgmpOGrmU7Wt5kKuT?=
 =?us-ascii?Q?VKsQKf0hxMYKCnHm77wLv5YVb/vkhvS21Avw4rHbKd9EkSE3euSh5rEnWQrJ?=
 =?us-ascii?Q?7jE01IhYazJIi1Z+5g3tlboG745XWiQ+v8D9Op5dfeJSKAdzgw8xWapS4lTw?=
 =?us-ascii?Q?Gzpa6/M5uxb+PQBpyfdjHH1uju6ipAqyqYDOTnMHnJocllGGsLFIeklnUVvi?=
 =?us-ascii?Q?j3RSa+I1KUoe3yE3FkjelbtJS3d1jSrcqvUns6feGohdr0AG+qt10cuhbnzi?=
 =?us-ascii?Q?6yvy3SDrBKeY4uHioz+ByCOamO6nfQ28athxJVIgD/2O2W5ObnoCLqchRAGf?=
 =?us-ascii?Q?uutNAGblfI7hJq/7i98sTN+ABR/t0rUkoPysQlgTzaVXG9UJNmQfA2pQ32VM?=
 =?us-ascii?Q?kxBCZ4iqbdOqIEiBAaZSLKuZVFIObcmaTDQV1ox93Zr2zWgmX2EjquwFzBfb?=
 =?us-ascii?Q?Fbnmd/6CvyVyxfaIRzIfmyI8YMzXQQtpBTmpE3uCnRvFD1SHUhO5pwGtGLFv?=
 =?us-ascii?Q?zgmDUgaYB9mPISpuFwp2av+DyHooOKn3XIdX0rBFSMB8b8Ae8m1zGBNF6vfe?=
 =?us-ascii?Q?qzkX0QiV/LjFj9lwfQveUVsJQ8uT7DqufMBWIREy3RUd3RxUqjXR/OqGZf18?=
 =?us-ascii?Q?iuAcN/I8dsNSwNx4/44fV0DTJCNTbpkFGQlcZIH3Z9gDmDALdQ4kdSL81Gu4?=
 =?us-ascii?Q?2bfyUesgy6+41deFq90jdTPkU2G7qluOgTUwGpTbUkClOsiLiZUMOD6u19ci?=
 =?us-ascii?Q?emA6c8cUYg5wNSvSGzSqeUXSeEgb/Ni87KRg+xSByqtJ1TxdtRmB7Zb4KeqY?=
 =?us-ascii?Q?9ZRXdkOHcQ7U7jqDfxD9ZyNRsF/Qc5VJQ69CKG7pgCLjN7FPkfjp3Up390JB?=
 =?us-ascii?Q?sPY7BLV0Ro8n3MnYr68TLvbUJgeha/VDZOUBoqPusCAKVkArd6Mp3e2UZTFQ?=
 =?us-ascii?Q?FT+4g1GOlGNeUwyu7p6CLAV925+Do5nb9oiIZGxbHqntjVV+nFR6aYnoZ81V?=
 =?us-ascii?Q?FjPBO5dBc+viB+jAIHIkLqfFi/6Gh1tzv+6sGH5+EUjM5RalL0W/bxwvKRvM?=
 =?us-ascii?Q?M8tRDlK4rRiNDkrvNw4DbmCi+QgrGZe0GwyuwLOVFuTq/a6rEOotNg2d2gAd?=
 =?us-ascii?Q?BJy4Jm9CImGzB7ur9Qb1zt4rGstiYZ2wGRpWnsonQ/HYMbf8VVrhJzwzqhWh?=
 =?us-ascii?Q?CslgkkN8cGqJd/wt1zHaMI7MHplPQ4cG0hDBu8OZkx5uEm8qErN9U0aZ3z1r?=
 =?us-ascii?Q?3NuIChV7/Mzrom68Zl0jji4MaaYZNeGNbzM6splK2PtOgxl3PxM8YjrDNLF+?=
 =?us-ascii?Q?O8inx8Y7cGaV/wNoeJceQhaVozcc4MM7bMl7b5M2KQBTkh7Nk9r1wc6PeLhQ?=
 =?us-ascii?Q?7w/wUnzAIR8bxHlVqzEAIOFdkqgKaPEUrWryaDDAuj2ZrMAuPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:34:12.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb930d-bb91-474c-cb37-08dc870fa9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This commit introduced a regression with kms_plane_cursor IGT
tests, causing AMD Asics to fail these tests.

This reverts commit 14bcf29b706f8ef423b86c9b783055b5b0c2cd35.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27acbe3ff57b..448932ac06fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8637,22 +8637,14 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
-	struct drm_crtc *crtc;
-	struct dm_crtc_state *crtc_state;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u64 address;
+	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
+	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	uint64_t address = afb ? afb->address : 0;
 	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
-	if (!afb)
-		return;
-
-	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
-	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
-	amdgpu_crtc = to_amdgpu_crtc(crtc);
-	address = afb->address;
-
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-- 
2.34.1

