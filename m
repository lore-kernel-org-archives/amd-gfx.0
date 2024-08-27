Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AC8C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 07:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7619710E2AB;
	Tue, 27 Aug 2024 07:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kub2mr1H";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48E310E2AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhPSKlLOcfY+vuFHRDxAcTM3VxmsoqpcP0K3sUqmgYXDVk63CswtWakrRRxrWd/a/hgkk7fIT9aJtoMqwUt+z4Z65KB3jER6J2t1FEYjg8VpBWzvJbATsbhOsMsLpoDGTdBiGuv9DNWAi7p0w585g37/WpOBq+qoTiFluAtI4HTAcTQHkr2Yy/8A+KW/rAsodoOspky4ojohbtTaIUeu9eCW0CRdFNtUI9VkruNXlLq+ofQ59W+xtlaNKZdazF9VYGfYJEUAsLWRw/Z0k3de1RduXcQKI6Ob6Dx+GpzaB+cCYuaL/pyKOxxOk/pMncbsgqITPdHZxUtDL5+1OGR28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F8yrBuDwkt+YgjcRbXhSyJp8ohHHcX3etxsQG0nU+o=;
 b=XSwyNwAthsxFkif3jbo2Wx8r3o9njqzFaf3654VZli4gb4AiRXsKo8cUgfaSC9w7RvhYARea1D1lVlrZ5tnFAy7aHALStMxV64eGFuRHRjHy4e3wvp/IZLeHXOCHo9ucYgdIk9SeBryuDtjr2JpyXgxoDCqrNh7wcAMYoUENGQu9yFrbT2imKM1Z3yaIaKjzlqqOh3S+zTDZrhEHLO1WTSoKVhdN4KDftc8aYtcSUbaMfQVjogllTqTKFkR32Wbj0fySROo5BAMrYdG1wCW7BhB8YrJL6FQnrJNm17t8x7aZdtlqbaU2q1KvTHwPCRycparjUFWyWCxl08NRWeQ6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F8yrBuDwkt+YgjcRbXhSyJp8ohHHcX3etxsQG0nU+o=;
 b=kub2mr1HcEgL9gwa/Fkmi364K9Nk6sMiHIo91i3Rw+Ii4SiPyrkKn2MUFJCRFZItbrVLNnY/ydghkymLFfIMY6cDQ6RSYOPmPnVfEpkFeS87g6MjQdVcagfc6HKJ9Unp3vrJ8f5enhhpBGHE7cDHl2QiY8qXhEL8vC3eUODcspw=
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 27 Aug
 2024 07:26:34 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::dd) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 07:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 07:26:34 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 02:26:31 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>, <xiaogang.chen@amd.com>, 
 Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Don't drain ih1 for APU
Date: Tue, 27 Aug 2024 15:26:00 +0800
Message-ID: <20240827072600.60239-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1efad-ef52-4883-7e51-08dcc669945a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZmQmaj41qqy3l8JId8h840htjo+fVXktGHcIVAryEFPYa36H2aFzSKU0JZWz?=
 =?us-ascii?Q?b1zSzM1RCLKbzTuQXq73eT68Taw5p2/ZgNSrQUWez/pXL1VvzlBrraCgoDvd?=
 =?us-ascii?Q?QQTEv+AeJSJ9aqAAO/P5suc8II3JeTselDNnyW8m12S7Ljz6lM5C0/oqRyxg?=
 =?us-ascii?Q?ZXz1nNVdFzWQG54YqTHAx9PLK5EidGiUviB0U9evXFZ0tLVYkPiJw16XVLFq?=
 =?us-ascii?Q?SotF/7IpNjEVy8smfo4EJTKM6B4wSFvZAFyfRFigzVJmr11G4dplbx/zY4vK?=
 =?us-ascii?Q?dU7bLZWs1dM/+Y/H2izEuCHYuh1+/2GTHbcL49elSv11Qf01FGtiOemWqhfA?=
 =?us-ascii?Q?0R+CDGAMR+kF6rJ6UOXCqs+XNoFk+MP5K8mP+CsU/fWLBNHbjthPFW6hGB3x?=
 =?us-ascii?Q?tXYO89ewlHvd7T44MeVaNEpRz60D77VwUbXZ/ZMI5F466/oc0dvayt/z0hIW?=
 =?us-ascii?Q?6GmnDfawnA7NZdXh4t+SLP1dqqX8M/85vnkU4MpUjRGabNksyhs5pfGVsoa4?=
 =?us-ascii?Q?5KMBscI2qt1vbJFm34xhYiRqGpN1EaCOg7eus7g6xbLPlO3jOXDnWNxmSabz?=
 =?us-ascii?Q?21AV3vPWASnbiA9Vuy8jAQPec/u1ZQmZ1pkNnQv/Uyq9Xl1frlC1FC7CV1Dp?=
 =?us-ascii?Q?5Mr5XZlyrxhZ4TazY07Ufv4i1I1w+FLiJ+iV0PbB8HqANjJsx6Px1RTc1sMk?=
 =?us-ascii?Q?6UtCIU1pJ3LsnAkq9anzyEcmYepVeCjtKPuqjAR4SraVoUOyvKF1hFjJ01Vz?=
 =?us-ascii?Q?Z9v1E3YzLSv9epAERJScn6jim4A2levPQO3zU17QqoHrFfUL+ripdU043L/L?=
 =?us-ascii?Q?ZlKrg7iv1hzEBOp2BBLktxaSIGarohlxzlvFDOC0r+/WACB7zHuZXgF0h/vt?=
 =?us-ascii?Q?J+h2WZNEFlV8D6nRBAgpgIqR6kh/yJaxPH/6RsTuoE8yyO+0TQW3g4cO0rv7?=
 =?us-ascii?Q?O83PUfoPVEUdHzYuGTEX3IzaytFNDJlHSA1G4rCjN8f6rDXhY8VVxoUbntwB?=
 =?us-ascii?Q?00btFX84Mtt4CicE0dtIu3JNc40ED6ib1XVJVdROsDjeGv0GNl6JTteh8P3d?=
 =?us-ascii?Q?mNorvI/A6g2iurshXSgsYNvoxFyKRAHVBFpt4TvxE9FJIAstUp7UvmEn6lMh?=
 =?us-ascii?Q?jJbvdnPDgjbuhIFKJAtow/uDQ8evH56r2CkKpYhRYBVatdvSkSsFECMzt6gV?=
 =?us-ascii?Q?uD2XlUx1vJAheW6YGMjeKx7I0voVCCThvBSpZTZVDakK76503Qd05d1C0wQu?=
 =?us-ascii?Q?N+WYdaBbdY2LrKS1kW+UU2KLP8Si5h3p2Ru9BUzwtsh0oBpndfEg7tiKlaAJ?=
 =?us-ascii?Q?g12t5DhQ5nvbCegVAm6L+B6QhDThEZKtqUMVNQqeuHnoDFkyQ71hwu0p9jDn?=
 =?us-ascii?Q?U3GKoeQ5/oiBmtDHRVx/wdKI8wzd7Ah/UmekyZB7HJqWtDlzxn0vDhHDAv5t?=
 =?us-ascii?Q?yqHa31+lhYpseszqS9Xh7L+/WNX4w6YO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:26:34.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1efad-ef52-4883-7e51-08dcc669945a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

ih1 is not initialized for APUs. Don't drain it or NULL pointer
error will be triggered.

Fixes: 490fc21fe97c (drm/amdkfd: Change kfd/svm page fault drain handling)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..1d08978955c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2458,11 +2458,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		adev = pdd->dev->adev;
 
 		/* Check and drain ih1 ring if cam not available */
-		ih = &adev->irq.ih1;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr) {
-			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-			continue;
+		if (!(adev->flags & AMD_IS_APU)) {
+			ih = &adev->irq.ih1;
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			if (ih->rptr != checkpoint_wptr) {
+				svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+				continue;
+			}
 		}
 
 		/* check if dev->irq.ih_soft is not empty */
-- 
2.37.3

