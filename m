Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03BDEB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4726389D7C;
	Tue, 10 Feb 2026 21:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lwehjb3o";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491C710E0E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRvRxqOXhWty9K7PsTfirqS4ZlylgjiH6buIlaMl/YXjGGJ5kXaKBY9SWUVVJZNar9Z6BAtyYKp/mmtbMhndY2CRXh2l+AY7q+j1hFEkO7WadyaaQkfdzkjiP7ehtNslpFMl1o8+A9V0TrVAhnrWZc580eJ63oCS7QJAMt10WlWRi35JnFA4waE0DSslmZC0fTqTUVOtKFjjNRzgnM8beTM2OIBWMqIhTUYhDF12rSEGFQ5ql8DYa5yrbeu5LdEnF0Aom3HFKx9engB6u0Aww6gqHRbeYf2VwB5ZtIhvBFfpb6VfkQaBgtxAdiYMejLW+enuQxr2auenAZM772jBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PGWoQL3H6yagEV+p6NqH4DxXsGKt4VSskElHkGE62w=;
 b=wEWsI1roePPnS1ABDDCDKoeMfM8toI1fABWmW3dQEbgvbqnHTssAnNpncALBb9ijq2PUUeehnp6sgaSoe8WX3KN/SidUS7IIQzuns8g1aju0YITYCqFqH+PQ/eXn/EA9r2t80jY5i5EzbBLvyH+o5lSx3AX+hJsGi4+MfNCAFkMrW6urCQU4/7x1++Z5OL+9I0d5EgC0PJ7lfO+t4f+q6VHYaU+0ZTUihoZsmMkG2peTw3SMS2NN/hKDFsOG0a+AG2Ho4lZgZC6v+ABDNfmKl/LRGgHCPRq6Aw8yJ2/4bnAOx4bmAszPfc/ijj3Khpq+GQcMFZaFdpOkpz5oyUFruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PGWoQL3H6yagEV+p6NqH4DxXsGKt4VSskElHkGE62w=;
 b=Lwehjb3ovsGz0u9gOGBeUhZ66w0CUMElGVDAwqMYgo/jeygyGcZ0ZyOug0VfBvn0GWRcPvtALEciOAa6AaCRS/VyPjjMOXXTEv7Hv8wHWe6YapM/hFWZeEbMcOmC6brmlFr2HfwSnBAWLN3sxJGt9Vv34JaGYnJTZhHCXJZonpA=
Received: from BYAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:c0::33)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 21:57:12 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::7d) by BYAPR05CA0020.outlook.office365.com
 (2603:10b6:a03:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 21:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:57:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 15:57:11 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 15:57:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH] drm/amdgpu: set family for GC 11.5.4
Date: Tue, 10 Feb 2026 16:56:34 -0500
Message-ID: <20260210215634.70349-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 092f4f41-42f3-4ad5-4073-08de68ef580c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XapfxhWBlxXRvsl6sC6G1jQI0oAFzl2tDr/mH0PWPE8KOdpbqHlX6PrqPu0U?=
 =?us-ascii?Q?0ZnCjxJYTILXsiD8ZlWn5FWKksCgcEQOfA7AHTU1ZRhASQH4nnUQjL9V4UY0?=
 =?us-ascii?Q?l8Cveab2qblxP66WwsbIhs3WdtptyEIGYyUE63Usl45wr17OyEhO6oN4QIIz?=
 =?us-ascii?Q?M8p1RISBcE5f9yayXDveSKlS7J0w0M+RVibPr7yXMvhcSZPM6s+UIkyo2rTs?=
 =?us-ascii?Q?p/P3rEwW1FRc791+5+sT62U3pyXN7CdwFkjTGgRk3KoghENBhcsoBJTRH5pR?=
 =?us-ascii?Q?izUNjXdXwdYbiyPbLi7bhhLdRqFz/atuXcGOHBpG7nnz8aZ1PQBSyeS4WqSg?=
 =?us-ascii?Q?8JdElP3FO1WLHEFIAXpsxZ5dgIZaglAoegZxvhJV0M+9SKApZuhy2XKRZiH3?=
 =?us-ascii?Q?eb3tBFMK6nqvHkKaboWh0BJCkcV3ti+RknTVyEGN+f11oeebINSlk6tIZnmZ?=
 =?us-ascii?Q?SAnAvWuugha7QAXnJLpcRqxL78IxkH7NYrpit5lxht/pgekCc/2+s/Y5AFNg?=
 =?us-ascii?Q?HdwWQpTEQWzREBwgrbzJNvQxZofBlYuF6l3FciBgFSzumVjB7wAuZBfr76Il?=
 =?us-ascii?Q?4+IcLlyXt07sPLu/vof6kiObjmHHl9hppkMYSXMIL3eIrxJBPbgh4XJaEPUS?=
 =?us-ascii?Q?Fbcco1WZBG0mBuIsM1t1mFfyGoxQotFErCSFyPUgMT/jsfSKVeH9tt7J+Bnv?=
 =?us-ascii?Q?QBK0ZMtbsjWR1SgreEMLdAjsqQlziIAxWcIzWRAuQAhANOv2lkFUea6X79TI?=
 =?us-ascii?Q?J4jneavSrTAI2HhD+sLZHMnSCAwPyMEh6ftsQeALarwLs5DoNqPeRNXkPi6T?=
 =?us-ascii?Q?Ucs3hJMmF8MFkdZYkxU/tzpsF0ySoOaE1PEm0scnINtjymUK4NlBL2S8VNwb?=
 =?us-ascii?Q?5ygg0x2LsiaNWvOr9HOcbSli6KCwKRi+UKerOB6DwkGLfNnNH81qxlyAbDPX?=
 =?us-ascii?Q?do+yM5vH+Cf9xDdWvo7kU9EGkgE6T6ZJFOnp0QgTHsKCaIw8GNtadIOkhSBx?=
 =?us-ascii?Q?3bruVvrfHn0RlnKd5CQmZwEJdvE/HtyIN/uTzDRJDJnlLC4OJ38Ozhgs+56q?=
 =?us-ascii?Q?nsK6+ygIFFmrBRpaS9e+IkA2eH7NFn7q/Uczc5xsOjenNdd4tIb1XUzVMcor?=
 =?us-ascii?Q?w387NiOSijgQHSDJNTsu8/0bxWEuHcZw4sAJq9z9WrYzgnKgFF+5GEcqBLfp?=
 =?us-ascii?Q?ypcWNKfyFY9HNpKpEppaPDyIlDtZqZn4RMW6T6mJqhR6xMqOGbcB3nx6IVBV?=
 =?us-ascii?Q?27wETlViq0T9JNiGCAxGHh/pmbeO96J35oCW90z8cfDBHZC7E95ilzDsUdes?=
 =?us-ascii?Q?GcFku/hA30YNcucJl8ei8VKfnRY7JSGH794sMC9oy9djX3GazBbQTlgJMMUp?=
 =?us-ascii?Q?SAZ15UicQfwn8kqyWi6V1gkSzT6zg4BGKmdUMVkvudEued2sjyu8Dhj1QBzF?=
 =?us-ascii?Q?atnjzwYxFxQaQh1Hn7zM+5l7ZFaizw3TkvbquFCJEroLbnoORThZxVrcb76i?=
 =?us-ascii?Q?zO2y8BcK+5rv7mkPf/wuZF+ucZ2R+RI91MPR1dvI2gZLqF8n1x//I7G6BhNE?=
 =?us-ascii?Q?eq2IoAzTz0p3V6XOX8GTvJWs8WSip5iianTYQauxY+woT4Im/x4Rzofhg7Z5?=
 =?us-ascii?Q?0ghH6lfjCEz/0cGs0sNto8kdyaf0cmtgcYuYNOvcbgzTeaYvhsVPZcS5toiG?=
 =?us-ascii?Q?H46K9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8iyJJqAV27tRIZYw5/Ie6oOKLcVOcUPnEizcexABO1mQMqub1rMpTh5s9/Kk5xePqjNubrTmkpuJXYtQJ8YHQnv6CgQKFuc4pit6+iRjRLGveWk6EPy6lVZgLEpro4E+0l0Og6hID/RPo/Bk3KeRTBu/CV62AG3eZD0XaVSW4WTSVkVc6TZ7wMfjrzOKrNNH6cQ0iZ6jSUONc9IgPeD/1/yfeyHEDGPglDiLAD74ygYo6OxP7F6IBp9gQ2tAGkSia5AgBn/csU/GnKvhYls94s+72QWO5R2CslfB7uc5cPUyGl2BQ1KOcUgPdsb31m7gFDIzDcXUiw0u+HUzgawdi9Z/FxbFa53TnTxxT2CmB6izpxqYHYOM7gELd9VYQSzDsJSI5x3EDHu0gnnvhQ6rs/bgPC5D+u3ipAESTOnKe0uDGJBjKfLS5WWu7Pz8Sgza
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:57:11.6101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092f4f41-42f3-4ad5-4073-08de68ef580c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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

Set the family for GC 11.5.4

Fixes: 47ae1f938d12 ("drm/amdgpu: add support for GC IP version 11.5.4")
Cc: Tim Huang <tim.huang@amd.com>
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 include/uapi/drm/amdgpu_drm.h                 | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 41e63c2869125..4143a25a498bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2988,9 +2988,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
-	case IP_VERSION(11, 5, 4):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
+	case IP_VERSION(11, 5, 4):
+		adev->family = AMDGPU_FAMILY_GC_11_5_4;
+		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 	case IP_VERSION(12, 1, 0):
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7a7a9f4787fe6..ddd4182540720 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1676,6 +1676,7 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_10_3_6			149 /* GC 10.3.6 */
 #define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
 #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
+#define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
 /* FIXME wrong namespace! */
-- 
2.53.0

