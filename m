Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFAAC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEFC10E550;
	Wed, 19 Mar 2025 16:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c27V3sTP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DE310E54E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt8Tj20dzfqO4SuMirXlnPnwAWh8JW0dS+xWUINNF89FsTgQFAEY+7OYncFojpp93tQYk8wuFApSBz9oWtWJX2f1vAJvXmF9Ssg0wmz3qy0/IAS2+GPL800x3oNe8dgWbEmU9oRCa05RhVMFkgJfpg671wAQh4KOvpiUvOSMOqaJ1S9YJa8AARwAlh8Rt3upN/fId8hYxjoY6IRjIO5DtBfjtsn794p6OV/julmMf7yCM3MFsmCkD/tGR9XiPyzGDT8ID6AlmcvEsaeOxMtPcvc+dgKMOE12cGy5zZeFGlGQBMIrZ/BMaEz4Ce/PFfhFF20HB7nvH9krpvV9GhQQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WtwdNgAr1zC4rPaDvoyq3+KqxKdDHr+kNL2bpeVqpo=;
 b=Bq9vCEB2ksU1ZAKLLHnLJdKTvOtt5X5sOYUb8dTy8xlZulrhr9M74MY3dfmq0YJu8JVTgN9xaw9WUC3yYsAMGNWO5Hl9OoVDYLaEziqFiSaDN1pTWFwfGQo9ZDPDqx4Brz52fObxEuIC6BpZZJ/L4S4iusJdB8Q60ScQwm7ouO+/KubjX23xcGQrBg0wAHKgXrDiFCMMqbB8wTy4ohpGkwfxBiTnfPgcKGfPWdV7QaZxURwEqhe9ZQIvmoLEX55JbRjfZoKYwdOyn8fnalVThFsWs93h5Q/EHQmvCaLknTjTBl7+fSwwiFOOxG7rwLD3cAwJRSHvchzltVcdsxavPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WtwdNgAr1zC4rPaDvoyq3+KqxKdDHr+kNL2bpeVqpo=;
 b=c27V3sTPp55KTU+2AyXe7GrWDY6iTMjv0+3LAjlFMNCDb6pWr+L0h7r+FEyVYLtihouFWETqTmV4eCjEiytIcW+xk0+goCYQ/g5D4MTN9zgG3F8ACnmO4B2UnancheWybSJJD3FUS4X60PWuYyVuSsV9iKU+BW1MGSmQrcqyjrA=
Received: from SN7PR04CA0119.namprd04.prod.outlook.com (2603:10b6:806:122::34)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:24:29 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::3e) by SN7PR04CA0119.outlook.office365.com
 (2603:10b6:806:122::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:24:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:24:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes: optimize compute loop handling
Date: Wed, 19 Mar 2025 12:24:14 -0400
Message-ID: <20250319162415.3776175-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da06d0a-cfef-4083-50c1-08dd670285fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Op3cNmhh28kPWrUKRu/tCk0b7ytGiA9eNUhIJW/8lYc9lXRwlvHMJf2HdoJa?=
 =?us-ascii?Q?Ywf+TYvD/pog3WYDJgvZmHNdJHS0M4jQ9Z7k1gP+12DOTS9TJikzN3Qv87ww?=
 =?us-ascii?Q?su/+K4QeOBPWb2ofn8nTZz4YjmD5DChC4/Bg/BIL1e0UoQOJ2dwAnbYMcRUU?=
 =?us-ascii?Q?E1rHFuqR2ruwq7H3DONGUMoDYUNdVhLj1rDPL7ECrSOfF/tbkNar0NfwUn0S?=
 =?us-ascii?Q?DX1XhtzhEbQ6QtJprafuEoPDIAR2dctoYJjuOQmuyljuyFgC9WW5Osua/2Zt?=
 =?us-ascii?Q?/uPR08ezIYrf56n3a0r205sk+MpOKujqEp9UNMpHxXjJUsNYa4/ylbUAiSDt?=
 =?us-ascii?Q?bNdzIDoT37XU+LALvs1mFmOkX/jQc2sf3CwjVRojBK5BY1nqrJ45xxzEPIVb?=
 =?us-ascii?Q?hICu8yyNyocqZg6O3lS5f+jSHMV1xVGGsIIrRi+EB51sDWyakuQ7VItHs1Kl?=
 =?us-ascii?Q?WxIk6tJ/wHKZQ+Ck4s8+JYt6VvpJZFa8qVhDmqGbrJ7Eli7oRSm4BgjJ6HdX?=
 =?us-ascii?Q?8hvQJRF92LBNSwPaW7G9LLxdhb7pvZw/sCzLCSGlyMrFSpzOHv07B/IZmEYB?=
 =?us-ascii?Q?bKuDKAFuzPqstTd/sUegjSF+zz1jJagHM81rRbZ0R8RuzSonCXei7yMoERru?=
 =?us-ascii?Q?r9iAkIErYrp/oALQpCqMt5ZE+kuwJnY6vZ1RzK3rpwQGNmyjql07eFAXeNOs?=
 =?us-ascii?Q?J0PL2LTvS4y3KM0WffgFUntDHNO7sZ3SGdeUIOVFLE1WyriVhoZaJoTdRP73?=
 =?us-ascii?Q?q9gIyRduH7Fmkc9xspSg+j/Xb7UkJ60KUsuReWnpbajEa6H2QRyDyGUsDe6n?=
 =?us-ascii?Q?s5iizbeNAkjUB9DjTRkVLp7+JVlZgB/l52cfwAjLcDgOQ0N5hYnk7+TmNS+T?=
 =?us-ascii?Q?Cr2FptKXJskfqaoKCzQi/HsiBChzd5MCSsbyS8FCsimdG2/cszda6ib+FRhE?=
 =?us-ascii?Q?EHJVWae14Egy9dVSWeGuRmjpVwqEDbePNaQg36DOhsTIaW/M7JGXvGMWE9YB?=
 =?us-ascii?Q?+TuM8C58QiCT+NkaR3i5S24TPpTDieMPPuBe731toMZsgMqpx4nJpbglgdbu?=
 =?us-ascii?Q?py9eHwI4wxhCt+tJXoq4dui6+aH++//itrJLkF0/Tl0TSFWMkDU9rMU/Hzd5?=
 =?us-ascii?Q?QohKksAG2mY7PIFaTnAF02gUOl7dtsdJmLOKO7fWWmtTowSFBSoowqdkRSpa?=
 =?us-ascii?Q?VxLp33VfLRmk+48JkJbx1HbnbqVcDi7xUhDJiYoWMnhLBQ7+KDg/LxK31QWy?=
 =?us-ascii?Q?2Oa3YfBxI6ImWwHuzeY6y5qKI+pumEzaxkOsuMfcqyQ25fBbfus9PHRZylww?=
 =?us-ascii?Q?xgzfFZp5rqTR8nh37NFprf8qIWtY5f33r31MUFnMrDQ6+XZYVGRivHfQhOwF?=
 =?us-ascii?Q?Z5Azd694irF5p+pr/xsffIkPjo2u30LEfwLIXL3GhhEdDjKFEPqmfm8KGpII?=
 =?us-ascii?Q?kTIPuQx7cRJLYWVrgTExXWzB37G/QaCXsaDnmpWcET2rYap+SRWDCx1yEq0Q?=
 =?us-ascii?Q?xpjD5GfW9afYIeY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:24:29.1354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da06d0a-cfef-4083-50c1-08dd670285fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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

Break when we get to the end of the supported pipes
rather than continuing the loop.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6f5e272d7ded3..920cd1c1eacb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -111,7 +111,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
-			continue;
+			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-- 
2.48.1

