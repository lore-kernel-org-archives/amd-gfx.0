Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B209D11700
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F8C10E4CE;
	Mon,  1 Dec 2025 23:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVIqsLE4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FC110E4CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/hvAgM8EDDWTTD+tF/BeUWLnYIqesuIunheOnyIp1EbB9ITknUZuuLmxWgqIzklTGrvN4hDTxy7mCb0c9bJDDBOsuU/b/mWmGvenKVUe2ejlc30XOTOE8WFmL7lIQGvIifj/Q4fjTMVdmJHCWI9oH4Wec6N0G72X2x/E/ru+sFlyOgWHoUkY4R+08InpLvGi7MDyFM4KZVlZI92KD5fDMROJBufeBc2iFC0rT1Dwyg408ugKB7NanofHDe0jj1n9XjuesIi+1Jj0YqnYpjFdpoir1jxp/Exgpk0OaVvDngxFOhTPLfUE/biidsNTfK0FZACmsQZ0hUVUurywoftsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pX2tUdLUx+oY5nRrP0J8KQncL3jH/ziyO3yqfpeTkjo=;
 b=Jf6E9xylNqLaLsX8KBB3xMgqv0meaFOKqQiLdEHhaRTkeI9aPSMv6CvBKhjjkRZYOiVG11Y8peJaxOjetnzQ8/iXhGZ5sRvXVDdXcApbA+cPkMEuNPbGroSKpO582UauHc4qUBsnVBDtErnI6TbuU4LGAl2/XfBQbJWr6h/m+tJ+hPJqEdNMpImVp8gcrg6MyHkrAl4mfJVzGnFWKmKQpgFaffvjaWm/LK+DxCBTqAXqSPfa9Em+CQbzYs+GEFqS27AjnKvVKSwT8k29pC7tGZlgmVOLAzfFJnPCQKlziVKaNG2fqgXsHfI7u0kDYUJpySYW3GPNbGtEpdJOh0myiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX2tUdLUx+oY5nRrP0J8KQncL3jH/ziyO3yqfpeTkjo=;
 b=oVIqsLE4+guMxgmyCUtzZ+0U2GY1NlpMuZa1lwWoHcrCw1hCU+XX/4jgOT7V7yIPD2TUu2zKNj0zzWh0XR+9w0cPWSWaRDsukbCM70FJ/+W2A26Fsr07V4Bj1rR2pOV6uTwWY/dtTI4A/GEZKZH+1WAaB7yE4o8RPLqyfB+bIik=
Received: from SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::9)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Mon, 1 Dec
 2025 23:15:32 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::13) by SA1P222CA0044.outlook.office365.com
 (2603:10b6:806:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix mes code error for muti-xcc
Date: Mon, 1 Dec 2025 18:15:08 -0500
Message-ID: <20251201231509.791954-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 1078c70b-4cb6-4cf3-9058-08de312f8646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2XvBB4LWMBKwtG8LIUBycldcNvOC/nET2OP4T/8UAhldF5DrA/ulRkhLyJD?=
 =?us-ascii?Q?QwuUF8wKh3RWpW1oUDs3iflA4k+Tc2NQfbsyR2topI4U677UWYe3iV3kkaqE?=
 =?us-ascii?Q?yKKqm1zvN2OuyuCp4QlkpeCg5uCKHAEDmoqHUXuusHQ8zTxFAd/TXTARn8X0?=
 =?us-ascii?Q?8Co4bzFwJKoD5dbSVphodkDJsMtK0yu6+yHwkH6e6rgOdULU0R/nAMvS2RgO?=
 =?us-ascii?Q?PtnbZ7W2wufJi2ky41g/MBGDMrNCSVg8EORcpZ/UGErXPmXc33LgqWhPZZYx?=
 =?us-ascii?Q?GWXy9tzVcmA9E4zdgeXBHZUhNWu3HtKO0GmOT9qNW3yYkpO1AjRp9rZ68GOn?=
 =?us-ascii?Q?tLzTtKJCsmCdYFvygQgWJb19v4nhZUoT/Lnw92v0od/WlYOCSzH10quhLB5y?=
 =?us-ascii?Q?60v4enX46c4XYXUYSp1o/VQn9//ppwFLxY0GIcc1h3Zvz1PLjU4ZFR8fwu0c?=
 =?us-ascii?Q?dis/NSlfvePWpsJ4iMq0232X6iPx5aSDvWR+jXm3fh4fCZC3Us0T/PLIDsqc?=
 =?us-ascii?Q?mZdjd1izy+q4pl4T+fSPTm93MmfjXrgQHS6jHR1Kt+S7TCkf5ZuLzIBEWfZM?=
 =?us-ascii?Q?K7iAd3n4v7DMjS5NYQJf5OulI5pSQuN+wuu/I06615UesbCxOmYYwysYkp+D?=
 =?us-ascii?Q?17d9/ORJ/6M32zxAi21IMBnUfHVkqhpOsX2ho+W8QMqhFjnOj10IT9wiP7sV?=
 =?us-ascii?Q?Wri4VqsJjQKZzkUD5kajRKr/bFYQZAqb28ztnVZSvg0i8hrBZtINgEXnV+/k?=
 =?us-ascii?Q?k9ihBiW35fP3kQIxaF0gIyc3GwhYblWJ20QM+FRbt+CoywHga4i+SLDfR4yP?=
 =?us-ascii?Q?PTgYlll7byTZbtBLb3guWpDbL5fwZkHhnGLZYR+IjNMAqPx1w6/Owb6M8t78?=
 =?us-ascii?Q?1rkQCZUShw1XrCcJl+sJfQ7K3ZDJZvBfIGZdnMllKQCHcgnkQIfzvh5rYbm+?=
 =?us-ascii?Q?hMH7wnTSxWIgoyHGphTiX4Bx+SIkftlI1ov2BJVmJ07NI2HupfG49uwVYKo6?=
 =?us-ascii?Q?zYmAX4FQ0KuFgw6fIgFIuPgVZSOCTlk3fdzetg9ZmwBWdL87vIz4sitXOCf3?=
 =?us-ascii?Q?Kat37pYd5ZdY3J7WNVtNvVNgrxXc9CCGkveWTlA3Fe6rohx+YaE81fwT/elq?=
 =?us-ascii?Q?0BiEtCj7/wHyiBdnl0W148nXxjfPgVf2aeAmA9myJH/HKKwsmaz6iIXjA8iN?=
 =?us-ascii?Q?ZWEKmqr9zvvIFjeslhXqt0j0SDhKEitQEUHya/DDRL75luMwQyFF0IS032wd?=
 =?us-ascii?Q?Qc1+pjAZllMg7PBB7kiYNgYtQu8MuSeQsHwoC9WRhcLjScap7ZrUPzHpN5B6?=
 =?us-ascii?Q?jj5Q9V3PysnHHJFuBlBbGLxwym6LzkBHM0WAzkwcxSGdHPby4XEyQsb9TW3Z?=
 =?us-ascii?Q?WaumqD/IZFDOPMnAs/TY9DL4uEIikrDQlfQE/wl2bQ0d2hn6tDS7/Pa/DVUC?=
 =?us-ascii?Q?wu2ZDMsE4crEho7db9iQNAjSf7346d22HpJYCyZQM7NExzifl+mDH/Et5MXp?=
 =?us-ascii?Q?2EvrgwLmiz+FHQUh1ZxdUhuePAm0rDgV3LhcpdWjRpb3nZtmHMfx4CqhQHDn?=
 =?us-ascii?Q?SAkwllZrydn9iyO5HzQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:31.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078c70b-4cb6-4cf3-9058-08de312f8646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

From: Likun Gao <Likun.Gao@amd.com>

Fix some code error for muti-xcc on mes v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index dcef628d604c5..128e29e6546bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -37,6 +37,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_uni_mes.bin");
 
 static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block);
+static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id);
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
@@ -684,7 +685,7 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 
 	for (i = 0; i < 5; i++) {
 		mes_set_hw_res_pkt.gc_base[i] =
-			adev->reg_offset[GC_HWIP][GET_INST(GC, xcc_id)][i];
+			adev->reg_offset[GC_HWIP][0][i];
 		mes_set_hw_res_pkt.mmhub_base[i] =
 				adev->reg_offset[MMHUB_HWIP][0][i];
 		mes_set_hw_res_pkt.osssys_base[i] =
@@ -1684,7 +1685,7 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 	}
 
 	if (adev->mes.enable_legacy_queue_map) {
-		r = mes_v12_1_hw_init(ip_block);
+		r = mes_v12_1_xcc_hw_init(ip_block, xcc_id);
 		if (r)
 			goto failure;
 	}
-- 
2.51.1

