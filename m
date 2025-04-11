Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B41C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C5E10E049;
	Fri, 11 Apr 2025 08:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jCmcr8VK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BD810E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3Kixz4JvwjbfZxJ/uSeKCJZfsu6m65M4fjpjM5eaxknGEUj0otT9QZ9QSdirxcriRxo8crVDidmxSOm5E1u3Er/+0OugIS4BEH227a2Ef75VZI7awZrp5t6sqfLuLXLC0+eSxy+Wv/fS0mLJKFXRIXRCQSzU2mih23x/YhjsPoZc0TnQPpYtWPr5ZVO6zMCnGQl9tsX5w1wxUvimHLzXZ8Ib5qcxhTQsZdHcJ6U0vEd7J7pDwD9Tk0S60kuvkLRfiixqVRw0oJ3K3qF1gdB7UeEvhNvs28q+/UIZt/ium1sC4U1JVDjxBfMvWhCYhyen1571qlwxrL/YJ6W4r+jpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96igj+QSdwMgUvAyfvDl7qnzZgbAQn/aD2v7/DL0X6s=;
 b=dskzJbl9rYCmflb6ktxlaOrxBn0sSuzegyv/ZF3XSczzFdrFCNlrufmMgU6jIoqIkigsf45yBY60MY6IOFxuLwsBulwtRTPG7wo5RBDFO2Oms8mMGX+ciI8LqliyEa/nOGhFXQj9aRjnoB5E+LF/lu/OgEhBHYZXiy8BRXfPg/ceemAbT4MzB5pnTDSipI2iAQwtvdCyLbJx/AHEA85Es4Ih/yiJ7+HqSHyijcrVy76o3Ae9MfCU5k2cAB8Cb/quDqzQe7VzJA8TfhUtOfnaA/R2lU0pp5UwCwVp+iZw5qva26MbUHsk3JmkSfDiMTvwP53BBY5dQQFUocsv6xvx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96igj+QSdwMgUvAyfvDl7qnzZgbAQn/aD2v7/DL0X6s=;
 b=jCmcr8VKLiv7HRhH/WtbZFp/zkhzrfRVRRnqadwoCO+Ig8Hagxuwv2CDtzGnw/QWW3wrgqicaQ44lE8DH32EodpADagEL3Srpimtf+g6HlMBfF9FTtrfihAGSPUMhKT/lkAsXqFGNY7/Su58NxlIAfWRytZa/e2LpbLr7awIliA=
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 08:22:35 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f7) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 08:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 08:22:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:22:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:22:33 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:22:32 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix out of bounds warning in amdgpu_hw_ip_info
Date: Fri, 11 Apr 2025 16:22:27 +0800
Message-ID: <20250411082227.3228289-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a651fb8-404b-47e2-0b06-08dd78d2034a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v5wwFSUW3M7fFDmkmba3tTKACpUJNyIokivfcRFL2t9ALs4I6oicd69TeZTI?=
 =?us-ascii?Q?2Fd+As+xQtMK14Tqixy/rXoqUKEPp2UYq+dAKAYS6HFOH8P6Ui/V/PSO5CLe?=
 =?us-ascii?Q?3ou4Cp5H243LmbkwtRRiOZsqlhzL4Wcb6mV/Nk2gRHWnyiSJh+QJk1PYFsPn?=
 =?us-ascii?Q?wZRjX3NiD6vln6x45XiTfyzL9R6jXxUTsqyDAdBiK3npRymYbBVPDB7hZKvl?=
 =?us-ascii?Q?NFbyamviA8GvYvCSp/ga0TW5ZMpqnPhuwUOZPKOMLORw9jSB29TDcMEq9Nxb?=
 =?us-ascii?Q?bq46/VxT/DwRyf0Bb9ek9BTGsI7AMnYOYluz9meVs/gZO1wZSprZ9JV/jyNw?=
 =?us-ascii?Q?43rR4VARXugfui942IvJatFsTmnaL2Dzn+waYNu9Ba7PvtusZ1PdZQ/lkHlv?=
 =?us-ascii?Q?lPwcewRmOohXnyZ81wIn92+8O4jDu4iqdGExeyzlgysJolqJpeujf04pfTBP?=
 =?us-ascii?Q?79QcWVN4fK82LFcySqwrfzopCpEgqFPKHCTAeHNzdxHnvRIbbGVPR4oS+gDu?=
 =?us-ascii?Q?YiYvBY7eTdfa2+agHGorx4jPtRxL39E/JQL8MSqipTBrglnaaTfUCdG10NWA?=
 =?us-ascii?Q?ld02Yg8hGVTNpbNLoCjrlX5Op8+Yzq7OIImREupm9VokXKukRfeH2TIgZiEk?=
 =?us-ascii?Q?ougd17v2fiSmzsjAV1qGGeGP80dt3dDL5t6fuyUCjR8wb4Rgb/DKPJAlovzo?=
 =?us-ascii?Q?UECFETj7UhMJspvMQfHznfytsGGovSPcF6Gi6e3D7rcmUNug2iC1IcONPR95?=
 =?us-ascii?Q?uCdJDMn2+UfB0XRMVZmvaKNTpY2430XZw5c04FIioaAZelU4HFh8sVOIHGuU?=
 =?us-ascii?Q?gSrjwOumlxSYBpwiLrCCLropAHLrzIdwLakzTtB9j8gZAMkMZwLBxHNAaZeg?=
 =?us-ascii?Q?nWIOBl7iSWJ/72OJNopNysDoHR0HU/alefOlAf3JxCXP5GSxz3WnzCrPgPjE?=
 =?us-ascii?Q?3lT2bAkeMD52Tu2WVP/6MylHQ0ueipcXdZ+tU15k7PwqcUnqIll5KH0T/Dip?=
 =?us-ascii?Q?GBhfzn/rYse1pCjk1tFREsNYxtD24TUimaFnMfL1ShRiDnO4GGf3BeCJTakx?=
 =?us-ascii?Q?cVtoJ6hOBZ+oLPb+i1msAGbXLgaBtJvfMYit7wqZm8aUSw3L4XidLHDhOAj3?=
 =?us-ascii?Q?0FWVy8iHmDLKn1AbInMaUxO2SdJDtmDLZvzYBvVbiAycP989OCoPEkG6G9nK?=
 =?us-ascii?Q?krSNJea+Yi8QXe2JVAlWtaQtm8hJNvDwW9MRPk/7QOGZo6Ea+VmFjauBN8uD?=
 =?us-ascii?Q?L4FrC+f8RfBIx9+YrP1Fq1eK830ETA0TiMCidWvvHAJprdXTIkr6+pycWXiE?=
 =?us-ascii?Q?I3/ksidePL09+kL5RTqcB16V5KgqG7Wt3Jg/5A/9hVRuasHsr3A3YJWcgr+2?=
 =?us-ascii?Q?gPJDYcoNKBOMZzKxCkVQpEdA/EZx9rMBJ/A8FOEPWahcmF6zz1X7qiY/k7u8?=
 =?us-ascii?Q?aZCToeIGaIuK93jsDHYwPdp3YlFRsrahD3V44rbmYa7/JqWtUT8gKKFhweFK?=
 =?us-ascii?Q?0GmhQLuatERmSgzn/m1vJyWgl6wMQ6yYymkf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:22:34.8721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a651fb8-404b-47e2-0b06-08dd78d2034a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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

Fix an array index out of bounds warning in the DMA IP case of
amdgpu_hw_ip_info() where it was incorrectly checking
adev->gfx.gfx_ring[i].no_user_submission instead of
adev->sdma.instance[i].ring.no_user_submission.

The mismatch caused UBSAN to report an array bounds violation since
it was accessing the GFX ring array with SDMA instance indices.

Fix the commit: a245daf3d7a143fb2df(drm/amdgpu: cleanup HW_IP query).

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0ba3ef1e4a06..6a42dea775b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			if (adev->sdma.instance[i].ring.sched.ready &&
-			    !adev->gfx.gfx_ring[i].no_user_submission)
+			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
-- 
2.25.1

