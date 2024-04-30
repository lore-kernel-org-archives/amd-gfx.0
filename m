Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBE6C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C94112F1F;
	Tue, 30 Apr 2024 20:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykDtne9Z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12707112F1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyqQPXN/j4HhHlFsy7zkHudujrZhQi80OR2s1BoVdksWfGImitB3ZmbuxaQnaZOjRFsjA1oys9W9CH4/VJIM2xfR44FqzeslYKw+tP99LewNGKxHatOuAlI9c24OHk/E1IJfGisRi/LQrS/UsS6kqgbWCB89hnGrA3al54lSt/AgwksDNebHH/4FhAoSCRC12V+Py88CiNWijJI8GwRWq4oz2J6sPKte1Ue0CpcMCSiR2+xEJ+BJGpkX/fbogFry7sKv1ULZA6nDOd7I0RpeT/DhbiBcHdjs5RluZS9mOGhT2xYU0H0/G0VAUP4OvejG9iVjA0ZQhY9mmQM7kHnw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr4gZ8N2A9Hda177CDZtuY+JxJnZVKF37BWfLyGd/Go=;
 b=b3T5RtTxYRbdkbRV9SzwUOBX1sEX9wR5OX74ZpURvQvXLnDwIxOc9PpNJQ02jjKl0UUJu6Uav4HFjhYYWw9yikGy4qgn6tGDba0tFTihpJmRf19eWRIuCTroRFH3IfV8YUfMqU8BFjtu2GuRVHC+/hexiO76YHGLRD98BRT1GxOl701WHo4YcYUw8mX0xhr/TvkuGym3f5qIe8l4qRt83cyyDec43zQx11Ov2X2KipkXpBwQOllh+Cwpkp+4v5a2e8q0IuYrj5bkaZVlW2h2Nwg5tXYI1S0gtXwVJCF0YxOfe7tGdVsrFV7ujFiDoMlH0j+Culbnsk+a4xHum6rCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr4gZ8N2A9Hda177CDZtuY+JxJnZVKF37BWfLyGd/Go=;
 b=ykDtne9ZvOPT8nNKu9e8Qf7E4I803I14Iinjz6FVo1t5Jzk/H3aC4X6viUg7SMXbdG0fOVtusvbFiIkSrdGbAxB0OVuBSbwPfoL/G1pHkymBggU1bzXsiB6t5cDjPjHqO0EpVOpiJdsv/ggFpsUf5jdq0kh5xyTBT0JiWdvIp9E=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:34:21 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::f9) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amd/amdgpu: enable cgcg and cgls
Date: Tue, 30 Apr 2024 16:33:59 -0400
Message-ID: <20240430203405.798798-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdb392b-fdbb-40ee-0c86-08dc6954eacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1N3J8H0NkzQeasITJUm/uznara4u0n6DUPVoO/fFjDJ1wmfEBng3S6onmes6?=
 =?us-ascii?Q?3ItTqC1eZMxI52U/Zz8TuB5ue8vVjFF9b5cqQ8gxtYSCTh0s/UprGvpg0hp8?=
 =?us-ascii?Q?PE6CV/XRSaPMxaoSNObIogUXoghb0ZBT7Iw5x03kXbYPxzETlop/gRxNno/g?=
 =?us-ascii?Q?Auh61sIa0BX3nRropB7zYqyUL83jro6V/K9OOkqC0pyOESrpPDA8k6sN2aFO?=
 =?us-ascii?Q?gNbzm8KLkAByjMXRl2yZnfytTUddganCnXyO62RaqBS9iNLXXsjsC53bshI0?=
 =?us-ascii?Q?2XL5UKlx3NVxwIzV8WTyx2kqn9KVCCFI3hZZ3X3cbCETseawAeHKH+0/gZCv?=
 =?us-ascii?Q?6HPWkv0gZjcVEBTf9aEDWCVhfE0l+nO17UJkimU/djFX3+ptj6E51lEkTfrQ?=
 =?us-ascii?Q?SE6yUUJHmm3tKOrpyCnjQYJ7MqYdXy3F3h5L0zuCm850W7PmZISgm5dKm9Xa?=
 =?us-ascii?Q?rTwIPlhuiEqOS2cCKsk2LOFLSCYWqKFBDcnVAYDgUDMckrYD1qWHBSWUIHmh?=
 =?us-ascii?Q?Co1am5PbZJInKixtKchPi2qmZYZszf5t4G1zD/h82OCNlwiPn1ZxaJR2Hb9z?=
 =?us-ascii?Q?YdXDwR33/tayNmUG5hG7lA/twySX19H4LUw10vuqJ3CV5P4R/t4l+rpTc+gu?=
 =?us-ascii?Q?t/6iMh2/bnsQJqGo/W1XyGwr5fiVx+g7ri7i9uiAhW+7Gc0NqtctGwcX03J/?=
 =?us-ascii?Q?lKlhO9t0ffK1YHC+QzvMdkrgUQ2GuX89XW7tSI9+rYdC/NDGkZPvPGUcAvc3?=
 =?us-ascii?Q?OlTGIWdj5I+5wF41WXAsUVHm03WqsH5sGz6OfJt+Rs7PfgZ0Ix6VJ+/S49iv?=
 =?us-ascii?Q?Oigpo5UqPTj7rPrXGIxijf/N8Y0JpwmmcOdpRRgsvbyObmI8BC9FpGuGeJ6C?=
 =?us-ascii?Q?zyWpmHU+7vHlcY+3WyP4j7BvDVbppQxsQZIdUGj8yvT8HGeKVtvmjWobH1pR?=
 =?us-ascii?Q?arD+3VjWW0oaB1ZrpTrYtt0yV8O75wuWUNStc6tR+p2UDt441bNdK+1qaapw?=
 =?us-ascii?Q?5B8XHji2gAYiEsE+Vg4nWVebQ02wFNJ8cPOuUyo6f6lNMMhO3l+MOP6fNQza?=
 =?us-ascii?Q?ImI75hQFtl5YNzry1vJW/4DrAwnyikFpFORQr8aTOlUIZOC+aA0w11Cp1sNm?=
 =?us-ascii?Q?qJJasEQd1t7MtFsHIMUaxOsqwqVpTv/dvxjGElokN4sJhoKlWeSKku5nHXTv?=
 =?us-ascii?Q?aOoTDJKf5a77rAFq6tkHR0ISG0ZMmeSMRuzrT65dCT/0+bJpEkqhEeIV+7Rz?=
 =?us-ascii?Q?jaLhn35ziuaZvJ8ouY8elBM5Hq2/e10qycxzFcTx4/G3fuifSjJ8jyKVlfCb?=
 =?us-ascii?Q?qYV/BKQCYm3WsXxtTEe3XePaiNob/1JnYWidj7nGAGL0co1ob/ZajG22+1VR?=
 =?us-ascii?Q?C7VXNR8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:21.6906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdb392b-fdbb-40ee-0c86-08dc6954eacf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

enable cgcg and cgls on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 0979dffe37424..143329ed2c9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -401,7 +401,8 @@ static int soc24_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x40;
 		break;
 	case IP_VERSION(12, 0, 1):
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_VCN_DPG;
-- 
2.44.0

