Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66CDCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 13:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBD710EBE0;
	Fri, 17 Oct 2025 13:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8EIshS1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C90E10EBE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 13:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgUuCfcITWBNOBii03SbYVehOKDWIsHYDmB2mRrpBffY8KTGxU9g6ACLVg8HbMxYv1U6efkk2bwzxZ+jN9YHzxcroJxlXnRKtB+tuxqlqyDaEvaZZS4LcrPTwnvBqCA563T4K0xo1msWfdgDJVwTjrb02vublD6VhqJ9+TnVDpECMqh8+S/ZYCGN3Xc3ibS5i7XMvJnfFnOXZ6CNtzUkr+2T7ArRT2HloOeVvIg6a+0s51X9DW+YTWigyseZw/loGNlt04KDcxIMO6heogkcIiiVY+N2uIh4O+Qr+aPh+GziLSYvWSg5InFBTZZ2nbuesYUzz0Z7v82UQqAXlr2i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9p+GPpAcXKP4A1eXMmSnquzPwJwET1HLXG8UflJxZs=;
 b=o/3xC5GXJieReiR+4mjJS0xUZoNnyx0j2MKRkQottJMmbDdF/jDmwnAbWZGyKI0Fx/2gockXZlTyp0mmHXmurO7imyqbLy76TQ/PQcU/qL0JeIiUizfaI7YigQF0jrdvU6S24ShNPFfIAgORcNgh5s1CKpCiYUhlrq03qQ6hA9oUVh+HpuCQ5L7Ii0dvlyOHwi6I1e+CrfjDkm8zCFEb2zuRtboPUOwIkQMbWhpsTDpXtNnYkogWYzHaLtR0ry80z9rSoCB6W1QG91jNpUy4OP92GuPzKA1PGdz1W7/S6JZYP018cwJ34GM+fW7nnjgVK16AJy0IdtkPQLBWoGImUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9p+GPpAcXKP4A1eXMmSnquzPwJwET1HLXG8UflJxZs=;
 b=o8EIshS1J4WFGaaE1sIxOfP19HXfkCk5dJJVfFLN7Xe2As14Sl/1IRCzsUVJp61IiqWkznHOeaFXbyuaXXcq+Ba8bf4Y7uRko0/T9KAPYxOEjSkbc7d9A4g8hnrKxZxGQsQu6EyPBQ8y7KBl8ZfoHsVfSG3QOjfRa6m27O2I1oA=
Received: from CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::8)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:04:16 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3b) by CH5P222CA0004.outlook.office365.com
 (2603:10b6:610:1ee::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 13:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 13:04:16 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 06:04:11 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: pause the workload setting in dm
Date: Fri, 17 Oct 2025 21:04:01 +0800
Message-ID: <20251017130401.3196276-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d85b56-906b-4f9d-c991-08de0d7dad5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aQ6/YiMgjK9hTburM5ayC2GBZxoplVVvL2IKCPe9+fFMox231ApPX1r/v4Ow?=
 =?us-ascii?Q?W5oVhWYUWYTkBXEQIUm7tsAZkj/ok9pUyAjSLx9TvZqu9CAZSXkyWW5nXNYt?=
 =?us-ascii?Q?0hirZhFVC1+4NXlYrCsyGQJybibrUb4jDSKlkgSqkL9biWz4M2pJZarGHXVX?=
 =?us-ascii?Q?ZTay8bh78njkn7ForK0QC48I4T05F8m7/UzTjE5RK2+jeikVfedngFkJIni/?=
 =?us-ascii?Q?Xs5pdF6qMhuhdMzGTbotmR9AF6wUtgTVb6AZE0gwSXfNpz9coUzZ/M5yes0t?=
 =?us-ascii?Q?niemnV3p+CmLJbEheepFPjEOF4fuxTwPJS3RX/JvNG7/zggxGJyZ4moCjhsU?=
 =?us-ascii?Q?GAEjFK7NQgDmGFgubeCMOBV+VjQoyUyEABnDAiTn4Ni/nDvdhu4ngTqPtqvu?=
 =?us-ascii?Q?t2xdKxBViDlSiY+sfswxn/2POwSRIzevRraf/LLqEoGQtY2DD4Rw85BSHz5u?=
 =?us-ascii?Q?OpMCY22dLryDh4+BbjzJfe6gApWS/2fZX/rqGkFa8049W4WGGub/G5QohIa/?=
 =?us-ascii?Q?7nsQz57uX0Kcukg/wcxESPrX0eOgx+XM4JQAd6Lu3YFu/vyGSiiPGxDjJ9u4?=
 =?us-ascii?Q?keZj8bNL1h8fEyKfl0Cgs3xJqFqtKXRm40il1mfw52DpY4sW4IMFJ3PIhUk/?=
 =?us-ascii?Q?5nqe1QRql8iSm+z2ITkNDhyYbO9qTGMtdk5Eegn+Aj7YQIrEvpuJEycXnMuM?=
 =?us-ascii?Q?edivHPdHEHI3u+auqZJCNIcO8NtaCQ0PBGWS9ml3k/vT3rdMMeYGIef+QGoj?=
 =?us-ascii?Q?qNhbg6rGbvDh2UbZ5nWfzGEfcgAb7wbRvYGU+B5/3+esGMV3v1eAjJq3qBOS?=
 =?us-ascii?Q?B+G0Pc1xfVNlaa8VpLKLC6NoDSONkbcJhv1SsM6ngs4rvaEgXGHy9sqend7c?=
 =?us-ascii?Q?V9H+sMsYBh8CpqIufhV7xAxL4l6/nE2phgX4mZoRk4p//LbafBy1fJO56v4M?=
 =?us-ascii?Q?0C72tZ/FeqCU15JZFEBpYG9AM2hlYdDM6YW79nhnjtwvt+8jsMw6PeB3zGHF?=
 =?us-ascii?Q?k8tT1Qfe9f4dteT4pgTBiPDnw0Zb+fa7IrOnhTpzGO38jUQBpHSJ+HlS+aMG?=
 =?us-ascii?Q?ZzYMq309cs8jxAGYMm/s2XUMffamoDTAb+9MwS15FYD9qLBlVhXnoAbdF59U?=
 =?us-ascii?Q?OM+nQ6LWnPHAkSOhYSxRW/jyKXIZo8bgU+VWfrARoDd8ghvF/GxayFGISwDe?=
 =?us-ascii?Q?Zi2YliWEi0F30ZYULi5VcfX0uxSy8OZPJKG75E8N3snjIEN+YUYTfDyTAwIv?=
 =?us-ascii?Q?B+z9KFW5KjtveGGC8wEhdiSdntFK8FKfbETvA5DdXRnoMiKrhno0/OtRM9nv?=
 =?us-ascii?Q?TAanwLclgorxe1qraZzfHPEFAoroSxhYXq7sLya9Hlpgag/5BXnP+iDdL9r/?=
 =?us-ascii?Q?gRyWA4RfxqSCQozWBizl0yqh3EaQff1NYo06k363gcpxFZEzMhKxuB919lnj?=
 =?us-ascii?Q?q+3ibYaWkilDF0ZbweFVOKWubGZT580X4784kgq/RUOvcSrHPpSephSVOz4F?=
 =?us-ascii?Q?pEosHEPTz3FN1LasZreKv+5zFXby1RA8NhHoB0tPuQxX1cot5/r9KOkHD9f6?=
 =?us-ascii?Q?Lriyyn3rgb4NYJOUQCM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:04:16.3388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d85b56-906b-4f9d-c991-08de0d7dad5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

From: Kenneth Feng <kenneth.feng@amd.com>

v1:
Pause the workload setting in dm when doinn idle optimization

v2:
Rebase patch to latest kernel code base (kernel 6.16)

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 1ec9d03ad747..f08121a2b838 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -248,6 +248,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
+	int r;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -277,7 +279,16 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	if (dm->active_vblank_irq_count == 0) {
 		dc_post_update_surfaces_to_stream(dm->dc);
+
+		r = amdgpu_dpm_pause_power_profile(adev, true);
+		if (r)
+			dev_warn(adev->dev, "failed to set default power profile mode\n");
+
 		dc_allow_idle_optimizations(dm->dc, true);
+
+		r = amdgpu_dpm_pause_power_profile(adev, false);
+		if (r)
+			dev_warn(adev->dev, "failed to restore the power profile mode\n");
 	}
 
 	mutex_unlock(&dm->dc_lock);
-- 
2.34.1

