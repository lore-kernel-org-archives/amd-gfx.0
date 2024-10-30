Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8084BD6B6D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 21:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CF610E0D7;
	Wed, 30 Oct 2024 21:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mypytuV4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EC510E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 21:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI6TLyp/cUaVoSec5mwBNWBekyAqiInvS8MLFZA4zUMe+SG2U2i9D953QRriDVGTAF3Lf41d6RJyuf3X7OBNclDEjCGIky9LnlyxtuJiM9wk1p4AGwajDaFOVBOoaMrYIkpusBGNkidq1yTeO6TsQMtAlKjx4NOqE21TwHi0gKZyoh0zhYFGBpHc9Kyehn2Hf1C/jIK14SHJu7cEKdydEVLXwA6VtBxqKdtzOP1sidf/in18Aiop8uk5/QgSlyvlvxMlTpKYXPzWf0BHZEtQZy2eiU+04GzLK5XlakaNkQP3aqUJRX6r+Ksbyc4BpjALU1ZxXaS4ipsovYM8ZfAJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GcCkV2SUAVb8xJufgccPZMKH0wtIgkGj6J2HRlRvOw=;
 b=t4qGsSHHzcu3vAqx++/ykmJv9D0tsVHnofFRuRWdnHDpblmrDwz1CXZbhImvCJJX3UOyicXa6q9baSZDam2GHs72k2h4bd+VfWjQdNcLoWCjj7h5Ql9E1TgjyeCNXEMOAs0QgLYPDqRWIPKSwVCNIgeYvGBkPNBpNswrQSS67C/6xnP8V0GlWEk9t2hhr43UlNiImKclHVH9nyHoL/sSnXuy8lqd8gaJOsE0s09T4LOvso88+ssOx4tpZhKy7oBrnrQejTrKDlyOW/dhATWm/IMUwhUoEs1EDlPC6rDUem79/wxLqcmAa45TwEO5qpEsEGZOzLOmeN8mGWdKOOWHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GcCkV2SUAVb8xJufgccPZMKH0wtIgkGj6J2HRlRvOw=;
 b=mypytuV4z3x21JkAcJ2bDvrQR0zOnqGp+W4xl++OBqQEOsTxr2qcHjsJqtAiZtvEWyMSBySBymwNqehn1A7N5eqAotN+rWRqEUbzcNzaVF13/jJGJQYZi3DuPuoEs20NgqPjs5DtphFvoPasqkpAJyOGK1M2/yImzShYUMRorqI=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31; Wed, 30 Oct
 2024 21:02:06 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::c) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Wed, 30 Oct 2024 21:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:02:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 16:02:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: don't free conflicting apertures for accelerators
Date: Wed, 30 Oct 2024 17:01:51 -0400
Message-ID: <20241030210151.3303328-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: dd000330-6c4c-47bf-bf88-08dcf9261bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cP8sJphReF1KJCeq0PmMcuXzH3rgAgsOhoHcvIHGK9lVLidpN8az7QZ2LD56?=
 =?us-ascii?Q?ca56LveUoozM+UHVWYteabhHdb7qO9Qmh59eTwuDcaX+xv308QBt36GWaKiu?=
 =?us-ascii?Q?F5of8ewVEFF2J1mpbx2Vrm1lUStLVEYZxvkziQ639boUxNa9wSEBVkaB5kGP?=
 =?us-ascii?Q?QkEOm7+jDpdaZpsXS8CiFQl7qCz1GUV40wtvkZkxebAca6ohrgT9vLMGwNqW?=
 =?us-ascii?Q?sHhqPn5vqHaNIB3NorWmOYngjelxY2DKlHea4/Wk+0IOvfdRYSAMy69qOg3C?=
 =?us-ascii?Q?nOYXhLzzf54ObxzYAHPKV3mBN/VaHlJgslwDYMRNaL/ooM/K1XJFwNNJWg9C?=
 =?us-ascii?Q?jX5HZZlT8lHenbY+L+6v6DRE9+c3zmEjHkIrfbLsudI5klsJZn/+J09LZnAG?=
 =?us-ascii?Q?qcF4pF9EeWLXlCw11aegTZ0B9yG/8D20xyGiZqTXiIZWsSfpcaYn3aQho3qy?=
 =?us-ascii?Q?BvkXhaJKWdnVdE6hah627l3g/7UyS5yoRBKpZC8m6gMnHcvx8eVZeybjas8+?=
 =?us-ascii?Q?EgUOOyWYKC9o6Gl453Vu9N4RJ1uAabew9ISIZRGkaN0KOFXvg0uw5LY4mcm2?=
 =?us-ascii?Q?RfXG73cnUrY6Iv+lxM54FyGyeTXW9/x6vnjnVm5IRO6Yy/+w+9KT+mJwhfZp?=
 =?us-ascii?Q?qXUoNnXxnYcPvbX4fjYzNAm7rxkb6d1zT5wbTnlVuP+eqcX5MArUEJhluUv8?=
 =?us-ascii?Q?o3IaUiTRGAU5F6c+RFj1RYE/Q8Z6zvqQREY68qAD6BfVIZqsFHzI9ox8osg+?=
 =?us-ascii?Q?GyDiTfczD5BUNow7lGLhJKyZ9lkvVLkOYiPOM9wRehSsGBcvmsYmCe2Zpw6z?=
 =?us-ascii?Q?CNZJ47lfTm+iHhw0lHjAvLJTXssJmunGr1A50o1lyrb6yMPc5P8mxVc0XmLT?=
 =?us-ascii?Q?2t05YQN1NNqDYyuxj4P+DpVYrN/E/hxnk/CHUaUOd8mNrlX2uBaUxyCuA29n?=
 =?us-ascii?Q?qAv/PnoV13w8Z5qDzOG3QjO2dV8nvyCULPpVptKqObh1YJUhVm6hySJnnOi5?=
 =?us-ascii?Q?3ZqVal5wQST3UA8uJTvm49w9gT27zaOB2RMVWvJqYPWXcKg9tzC9JrfI1KDB?=
 =?us-ascii?Q?dJ6E5ySkukrp4ZghlGseUvNae23uiYXrYXEbEnnySJUx2MkIFpZW9s72r7PE?=
 =?us-ascii?Q?yIQahS5huWeTxqutMEHcYtchPPHA9OQuGnVoDVulUE2KZ3uVQaZLCiBzr2Hq?=
 =?us-ascii?Q?f9aEs73Xa7NdRuiSEEJth5ISPck8wX9AUJ2HUJJ/egVN5+9As04KzwFHs7O8?=
 =?us-ascii?Q?brmtJdEA+HLt/aQyOCR7kg3TLEg57+QX9q6XyeLrHhB5q+5EMh+SyCNhzart?=
 =?us-ascii?Q?6i/ABUwe+6BF3UwWMlykmLxPjN5JMEaoP2Tym0RB3GtnwplBeFDA+QMFnTsa?=
 =?us-ascii?Q?2AncgTpObP/Mk6I6/WJaqpIpfJHPEm622IB3CwynhUcivauOPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:02:04.9927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd000330-6c4c-47bf-bf88-08dcf9261bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

PCI_CLASS_ACCELERATOR_PROCESSING devices won't ever be
the sysfb, so there is no need to free conflicting
apertures.  This could lead to the sysfb aperture being freed
while we still need it for the platform fb.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 383bbee87df5..e74395bdebe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4290,10 +4290,16 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	/* Get rid of things like offb */
-	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
-	if (r)
-		return r;
+	/*
+	 * No need to remove conflicting FBs for accelerator class devices.
+	 * This prevents the sysfb from being freed accidently.
+	 */
+	if ((adev->pdev->class >> 8) != PCI_CLASS_ACCELERATOR_PROCESSING) {
+		/* Get rid of things like offb */
+		r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
+		if (r)
+			return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
-- 
2.47.0

