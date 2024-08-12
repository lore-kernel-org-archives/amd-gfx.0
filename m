Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E5BC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 10:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06CF10E0CA;
	Mon, 12 Aug 2024 10:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qykHbC4F";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C284910E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 10:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D96eoD0jGtgLIqld0b8cpFpuyE2tOiYZ4ALpBLN73svKNqaVkwA1lt6PPEGv9ZjSvNnk1EHY9KvdY4MVITG/nJR2dnHSPSVXPeNRF2SCV9s/V92gxWwb/RTm7gwVnWXhqigzEVbHqOdYX3cL2p78QSQUfjEvFnDqn5VtJQeLIOwfb1rc1vYle/Uhs7ZbhJDWUpn6ARUYb3l1UcN0r3gm3G1LlPDgzKky+q6ogec4TogS5rnVdETAztFn5m3lNdThyp/jC/yWQO19zxQNL/rljqxrggFMiJavu7T6imst1dD5x1FPZLQuP/uW85IkAySfL/evBdb0IzQxnA3Xl2gE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ur87m9pV3/oO0Ylclo2lAytbYaWIl0yk6KHVEhuF6w=;
 b=MqceoX5lo8huelw+v+lBoBVNZh9DDUb+NQRcEXwo2E/QPVaiinyWXQoFD+RHZyxFoFgUEh32NEMULUvYC6Eq4X1pVKyheufLDVeS4ylcyt8/38H+iCRmsn4geMjN3VdyGHYglys+oVw44KNlEq8abYe8mKF56GX44sawPURKPDP7fNzZ9JRZ83RH5Di2bdoxeCY4515Y3f0hTg8DvlwsPoJ2mK2L33nqQN3UdAlk8GFV0rVvsVRmx+j8m51grN2+61lrL5L1YY8uF9GRcPLicg9UGihaPXlah/UCZnx/EqPJtxZtmRCoFpbw3tKV1Qbk7kdSATpnQ0HVLNxNyS4zaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ur87m9pV3/oO0Ylclo2lAytbYaWIl0yk6KHVEhuF6w=;
 b=qykHbC4FLFkHjYhV+s90frY34s3BBHzeZgLxieoybX7k0RGNuol7KuAwpoiOtqM53Yo8QnJfxcUwx13/MkODJpR6wW6w0gb/krfRu7Zcn0Q0DkohWc032rE/B2dIsMutsfW7/cBDx+AxgfqUQWDyYuiwNji+1QNtRO9rI0xPVEA=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:40:40 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::52) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 10:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 10:40:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:40:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Align hwss_wait_for_all_blank_complete
 descriptor with implementation
Date: Mon, 12 Aug 2024 16:10:23 +0530
Message-ID: <20240812104023.3744443-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ec7ff3-50f5-419e-2048-08dcbabb3572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LUHZanT4JeKqQ/Jd25Sz6sj9J62HnawX2wd1zkT+jCIY/HASXGEzrkWA+uud?=
 =?us-ascii?Q?RvSMZhgoDzDcKBwCKBi2qu8mVIfrWUSmYCg/WCDSw/nAWKHhr5OZH0fVIU1L?=
 =?us-ascii?Q?dK3+a5u/i6t9hKLn/VqPylFejKI5KZ/0s4KCS3RF8gr64q2H2KpfDyF8ercp?=
 =?us-ascii?Q?sLTLuBU70QVbnb22GoQqMg5/7sySjKj1128QYqqPW5PHgHh+AVoDecjuQn8m?=
 =?us-ascii?Q?USTxRyiK92xaiUNgE0vjX4hD7LRpWxwlV9zDrs/mh+ISDiYJ9aBjPDT3YdyG?=
 =?us-ascii?Q?7V2BGUgUD36XPKuvhnmBOTQz7yjt+pJb96+vlKiNN8loTEzogueKgspIXmBb?=
 =?us-ascii?Q?h4kxw2+/0wEabGOUkgtRkw2AGosyIob9/ciTIS6HOZKuReCn4u4kre1uTESA?=
 =?us-ascii?Q?UX5ztQX8VAnaZD7i8fhbr8jk+vrT53OTWLzVOzjdFOGZi5nO+kdg+GFrN5Wn?=
 =?us-ascii?Q?93+Zw2xx3ZcsP+wZwYUU6BmY91nWJrvdbLlfT88HcICcP9RI/QwI2AKWdy+j?=
 =?us-ascii?Q?mktp++bIHlse64Zmc4AF6U5vYVHWk114JhglakJGCzk9Js5xSIGdsN+ICvoN?=
 =?us-ascii?Q?TPZv9eLvAEMJNOY9tU2ecMGxmr02+hSnCghpH8ueQtyZGt6CWjukOkTg6WVH?=
 =?us-ascii?Q?I5DuxkFN+Zt1Cxb+B/S6gzWjcL4rpKdwJbUmzizFD+0mYg3Dqj4DV9yTEwhC?=
 =?us-ascii?Q?Jp24KQ56RJPpyLoi8QunEE+9vUjfno19MbwTEhCV60ditdfRvTdzQt27Komd?=
 =?us-ascii?Q?EZBI/Fj2bgcqr2zL1UGYU2O/FcLV7guiuE1YyHdIy52dm9j39OXMk2lMTSmz?=
 =?us-ascii?Q?D1KGs0cncIeqFc1UkElwS4HsC13yvd7Beuog1CGX5RiRwhIEuzjo1bDPT9a3?=
 =?us-ascii?Q?4X1M+WjMksb18NIYQ6tAKMpFol9ClsF5X4KEGUbLvx+/hSsqZeotkWut6Qki?=
 =?us-ascii?Q?qWK2FGHSZ4O/EVqrXVf7coM0wjuLGh2SpZcnfEl36uatQp8/ZvBAUEtSovfU?=
 =?us-ascii?Q?eEZaHoclkbcBE9v62lFS7SP0dBjmbsmFP0cgtnfZ4JlRVqVvurHOJaaViJbW?=
 =?us-ascii?Q?j53s+QanqmaniesB9WfUgyAdVbGQQVQtJ4cWl08Oa/G1ZJqwfrdjmyfGK1Dx?=
 =?us-ascii?Q?VZ1OCHVTZ9acPcfSnn8VRzUZvA8wk/nXBcpXdE0JDA1s7WgmG/eMKx24wB/F?=
 =?us-ascii?Q?TdzG10Y/NtMAgyL9BX5V+iqw/nPSdft/772+8cdY0VMUgmNIT4VOhJ0qSknN?=
 =?us-ascii?Q?O7t3J8u0sagOXHZA6T4yOqwlgCNNlqmtLXP3pazdk3ytyGDwhA7NSEqRMZNs?=
 =?us-ascii?Q?avYGWsWxpXMjujw6Ocd60SzIQCvW/Zxu4hqLud6A+0uRcsoZPZ/hfDSu5QpQ?=
 =?us-ascii?Q?mJNop2E+tLNL/eKM7Z7visC4RyWR+WXYaMCm+p/mtR74fRtkUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:40:39.7309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ec7ff3-50f5-419e-2048-08dcbabb3572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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

The descriptor for `hwss_wait_for_all_blank_complete` was previously
misaligned with the actual implementation. This commit refines the
descriptor to reflect the implementation of
`hwss_wait_for_all_blank_complete`

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_hw_sequencer.c:991: warning: expecting prototype for hwss_wait_for_blank_complete(). Prototype was for hwss_wait_for_all_blank_complete() instead

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 9a569aac3c00..7ee2be8f82c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -980,7 +980,7 @@ void get_surface_tile_visual_confirm_color(
 }
 
 /**
- * hwss_wait_for_blank_complete - wait for all active OPPs to finish pending blank
+ * hwss_wait_for_all_blank_complete - wait for all active OPPs to finish pending blank
  * pattern updates
  *
  * @dc: [in] dc reference
-- 
2.34.1

