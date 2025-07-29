Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDCFC87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 03:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A1410E5B5;
	Tue, 29 Jul 2025 03:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAXVrh8l";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091C10E5B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 03:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4CCgdoeDaZhlbGgcXiIYbwUMvkQWKBj/UiXL+vl/+C0nQ8Yx8hC39md+TevuXIvjsNH6it8RfdjUboYuCDzDp4orhyryYzOJPPjK+io/hCpwZDa55dQK99QMHfsMC81lcDJ4HMJ+W22/Cd5qA10OeAPvU0iypWnEsBDia9ItU6WhiM8RfIno+yKT+O/r1CQX7wxI2c66qm6epEGHgMbqsIhT0MRdynAAAOn4KdzJPafQOFfNQWykDpq4vY6ictQT2X5YIPuQ3noAjbVGVXTMdhLGivncKFH8tDZObrJBTSq6y+v7x1hWapypqoBQboiKKIcG7UKpeYvuSI5PSU3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIOgIBJF/c5po3YnlUVz3FXMrj8UvsHkXM/uVXySdaY=;
 b=TEYdbDhOcCzy4njDsOAwAD3F52T2Yu13yvBnK/yf9i9V1OhfH7MIE7wYo6IzbmKsTwv+vS6vmTbNpjy0uvSlflEQaKZ0I375zXse1GmEZKm5rc69cJDeMk2cLvWWbFwgny7YVTMUyq9mYCrs9OijROoxZfHQ8wyz/53bRmKUYJZ9s6T9Mab7LbYmyyM1lTa3NDu7KljgkPEU6mg0zcempX/UYShCHfXRKkEBMJ1rgBYi0vu7X/EjOj/h47mvlRN9UY8UYhobiZw0AoZ5hFRDOsZbh3D6kKVeLTlRRpSSN0MdnVLjAdrQK37TM5tNt8mL2NBYVyFQ+W/QS+U6dACjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIOgIBJF/c5po3YnlUVz3FXMrj8UvsHkXM/uVXySdaY=;
 b=jAXVrh8l/Cn3yZx61TjatKMAGD1kfbIW07d6lrpzSgIZEV/yuxvqwspLDjAaaYQ57MySn64YSToiWb4afXLHhvQM1LfK6m+6SCPfKzLYej8Nzjl7Jo6EClfbGsGnV+ZeCMfG4qoTQHc8q3oDJ8m7izRo+UnmIFR+q+t3dSG1dVw=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 03:32:35 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b4) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 03:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 03:32:34 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 22:32:32 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu: Fix vcn v5.0.1 poison irq call trace
Date: Tue, 29 Jul 2025 11:32:04 +0800
Message-ID: <20250729033205.826312-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d76c42-23fe-420b-4651-08ddce508ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NsAKn86f49VE08Gz9hr9LVB6QrKy26KW3oq8LXmFoGEyZtgVPVCuSqG+Qb0O?=
 =?us-ascii?Q?wEyNuTYKCASsn8vheslzb8E87Ca96WRKubemjunDr7Yi/TsI7P+fdeqtmqN9?=
 =?us-ascii?Q?DPUtbRgsUq7j1BWf7s3oMTgaPwpk18bIYWjWCs0/nwfrUf4YthRdA5o4Dj29?=
 =?us-ascii?Q?/0sBe6yL0k+l4b9kMb0+G9fuT/yGux7BEv5wYFePCbN3Sc/Fm1aVKYE5yhlg?=
 =?us-ascii?Q?3pVf4A4yczy7VbRn3zwYTUOph583EbfFq/TSJQE1SgRYoe+G+O/s2Q0TBy82?=
 =?us-ascii?Q?d+ZpWWWBNY3AIAO3dynowHztrs9jJKawX9AIugvMnbe3T4V6945Cu8SR6HHz?=
 =?us-ascii?Q?NW94JRIuemMiXPT7GAgnmwdZ/s9QC2CRsQtDZRCOgpiD7+u6oY2cyYA/cpzI?=
 =?us-ascii?Q?VhVicOH7RIgw575tB+DDvedcX5udGD3cPlzhItMaK9f7tsoDmGtyHAn4Bj+5?=
 =?us-ascii?Q?nUhzVQdVUSOV5UYxEQQNgGHd7EBHeJwAm+cAO4bszE3hfFEks6H03VkxBCmM?=
 =?us-ascii?Q?t3f9N2ETFsPZIjO30jfGLe/HPK1reD7/6/Gg/ZLolK9qDv8q8pDz+olpn2Nv?=
 =?us-ascii?Q?lnZeExLKVBweloS6STQC5BjXtJCDroayNw9Q6ge9mt3nCtflPoKZ7TMYi+Yn?=
 =?us-ascii?Q?aDWbw97UKdDuL6du8gktRYgC3oZ0v4ieddipH+s12TO13NRhnGz/nvukCjlK?=
 =?us-ascii?Q?ocfn2AjPpXmTwamZYOBu0er3IuhGueNWVevlzXaFuH3bTuIJEJiATO4gWzFi?=
 =?us-ascii?Q?2nx0muDLHodlwB6rQDHhnwmCMKSwDJWQVv8jt/mauIhkHedSu8qq8JxBeWsZ?=
 =?us-ascii?Q?m38cVoMYTCz1PkiBcqH832NEYscPqsmQMF/ZonCKXOzT2fcfP2pWsTgPzZMU?=
 =?us-ascii?Q?SolOvIxWDVxNgq9Mvi6xqzT18wgDH1H7EV2/qzSVkWnjgmaikdsamYQ2hX7s?=
 =?us-ascii?Q?7OLd2peMKlYT5FVLxQ7Cx85n9JrqwzufHu8J4cRWvXgpHT1Y+hf02PrGEfBY?=
 =?us-ascii?Q?uAP4hpE9kLZuAYUqPmf0VJG3ybu0+7wX/jOWa/7l2GLomE/k7SZupGckjGIK?=
 =?us-ascii?Q?9YL6joJLQrSBcUsQlOMh22+QxN4MuDj1cbJKO1ZGCHKzwkwHoZRktCv0rRyo?=
 =?us-ascii?Q?d4FJawCRO5hJ5DhNM+N7Ri+Ac2OByKiPDRBENoEWO5MCCD8UspC8XuokjXwI?=
 =?us-ascii?Q?F1DFJnoJAezpCy1Or5Izm0xCnlz/Vm0z+FN4AOut+jP7liEamj35DzazIGLT?=
 =?us-ascii?Q?I6oey3udS1Reou6reQ1K0XCmbBymoZTBwkuM2Q5iWANpofl9jcgyR8hdGcjG?=
 =?us-ascii?Q?x2ykBKkCwI16J4aXD5WSAGHiUNGRo26JH2z1fhdjlnFJRRcMCkoDZt3iBiU4?=
 =?us-ascii?Q?iGlou5mM6PyypHLmJTp6muWpgBf8VxSUKvdAf8hoCnfoDTjvlf2ITgBWrNDR?=
 =?us-ascii?Q?3vvLUZ8vm+2+kf+z7CZEG0HuWK6ztJ+bWD7cT1uYs1Pxfc0u62pyFAgodZWL?=
 =?us-ascii?Q?fcZvrlMx85wIB8Lu89d5Nk092Q0gbzDrBhXP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 03:32:34.1606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d76c42-23fe-420b-4651-08ddce508ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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

Why:
    [13014.890792] Call Trace:
    [13014.890793]  <TASK>
    [13014.890795]  ? show_trace_log_lvl+0x1d6/0x2ea
    [13014.890799]  ? show_trace_log_lvl+0x1d6/0x2ea
    [13014.890800]  ? vcn_v5_0_1_hw_fini+0xe9/0x110 [amdgpu]
    [13014.890872]  ? show_regs.part.0+0x23/0x29
    [13014.890873]  ? show_regs.cold+0x8/0xd
    [13014.890874]  ? amdgpu_irq_put+0xc6/0xe0 [amdgpu]
    [13014.890934]  ? __warn+0x8c/0x100
    [13014.890936]  ? amdgpu_irq_put+0xc6/0xe0 [amdgpu]
    [13014.890995]  ? report_bug+0xa4/0xd0
    [13014.890999]  ? handle_bug+0x39/0x90
    [13014.891001]  ? exc_invalid_op+0x19/0x70
    [13014.891003]  ? asm_exc_invalid_op+0x1b/0x20
    [13014.891005]  ? amdgpu_irq_put+0xc6/0xe0 [amdgpu]
    [13014.891065]  ? amdgpu_irq_put+0x63/0xe0 [amdgpu]
    [13014.891124]  vcn_v5_0_1_hw_fini+0xe9/0x110 [amdgpu]
    [13014.891189]  amdgpu_ip_block_hw_fini+0x3b/0x78 [amdgpu]
    [13014.891309]  amdgpu_device_fini_hw+0x3c1/0x479 [amdgpu]
How:
    Add omitted vcn poison irq get call.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index af4f562db32b..51b9148626fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1069,6 +1069,11 @@ static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	if (r)
 		return r;
 
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
+				&jpeg_v5_0_1_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
 	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
 		adev->jpeg.inst->ras_poison_irq.funcs) {
 		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
@@ -1076,11 +1081,6 @@ static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 			goto late_fini;
 	}
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
 	return 0;
 
 late_fini:
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index d788898808db..0333a2833b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1611,6 +1611,13 @@ static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	if (r)
 		goto late_fini;
 
+	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
+		adev->vcn.inst->ras_poison_irq.funcs) {
+		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
+		if (r)
+			goto late_fini;
+	}
+
 	return 0;
 
 late_fini:
-- 
2.25.1

