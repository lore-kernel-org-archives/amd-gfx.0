Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA45CAC5B8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401F310E824;
	Thu,  2 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWgsC+F0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC4210E824
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGtwUSpEfsH5r1t2BDYZGcPVmzzj/qqc+pKpk0au3oFySq+HDb0lcgNSkQrpFO0GqJ+7+XpEowFq4UWLVYM1zdrefb870ZC3bWuotYGtO2e4fmjntjXJbQfrES1rK9DxrM3p3af2hWwNpXdVvCxbBdB+/BDvov304YQS/x7omUyfZZA/XOepBGYrrQUirtfgBrg6l2bwo2fk/f9O2DFupcuxUcAHHKbgqyoQCd3PSSRs3YqapsRgAfidJ9i+h+XYznUX+IV6/wpw3noIiajcTZB+1o8ZJQFKOaXAI+t+WcmY5jRXI1JS6UifJKsLI0xFcg0+H9BYYiqxdGvb8Y9+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPlZFObSCzV25Z7H7oYIM8mWSHKWk2HfgFXSD6Q3ft0=;
 b=n0NUtKcKs9HhKgDLaRBIOJB7TCX1rZPmDLtzcDtkZRqzGpokJGg8D2f3u6tc+41ZcqcBoD2g0GoswwCzaxCinmXB3al6t21PtkyyrPssOUtbhIHbdByE7RmjVfJ4DvrSgQHhOWJnFxubEF5lj3N0SWtvUFdF3Pjpa1HgZlAS1oo+6iiVmStGwMnYH0f0ff4tWADZM7gFV+cHgBXV63MrzkcCQnJ+mBiTtOHdYtzL0RqlbUVHXBC2NqtXXiplsIOOMW5GUO5+mMqQRfzgl18PO5bOtTkVMfNKDRYHazpzQGeXH8iDxUV7I4WkvI99riqLFU8MaM7S9zXGDcl/EoJfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPlZFObSCzV25Z7H7oYIM8mWSHKWk2HfgFXSD6Q3ft0=;
 b=NWgsC+F0xVGm+SP9MRAR3HgWERJLxd2coeDS+1c7H3rvwpUXCoQGJHQH6BM3iV1kW/h7bH2zrm/eaV6LZFBiIiglEopwKarr8XdFddHY0TSbZvCbUoh6PvcUEUyU/NZcBD9sNTHT9buLXLAJZzpfz+wiaG7UID87vASLz00ibvg=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:43:51 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::7c) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:50 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:48 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd: Unify shutdown() callback behavior
Date: Thu, 2 Oct 2025 12:42:39 -0500
Message-ID: <20251002174245.1691343-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5c6771-ed00-48e4-b4a3-08de01db3f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4W1zVSRyNk8U/3TvZHQ5JqLuFwdlVBspf+gkk7pZoWm4KYWChX3fGisjBMyw?=
 =?us-ascii?Q?a5anwVFSvpYyUgE+IF4VnhtcexBtR+7rpXH+VORaIDcv5axq1wxaq3xoKoT9?=
 =?us-ascii?Q?dElyTUWMLxIfd2Fir7DY+VAmS3QKv3ZIaNVOCQbonf6w8In9w6fUDoI0kkYw?=
 =?us-ascii?Q?fbNHGBiHsZxspUhoRkUGZUsoTVN8IpybvNVpGq8FFKc6s1PJDtsrj+F65AW3?=
 =?us-ascii?Q?/TkIDdZi49CWsqE/0SfP6iiNm+sbZU0tN2UkXug6n9wLxcbGjjOJpwX7wXgk?=
 =?us-ascii?Q?6/YoV43rZNNVZ/5qInVs2rknULwy06H7c/QiVihuz1mkd9j/MIXrFBAEg1m1?=
 =?us-ascii?Q?XIbxAnDsigwF2LCDyu3/yGT7D+xoUP0GUvU+1FRaKGtS5jkzpaXDFG7eWKnb?=
 =?us-ascii?Q?MgGyLG404hbOD0CTQIOvJ49zyLT0H6KSFGTSk6Yywu/ly6L3N+KuNJjY8yhU?=
 =?us-ascii?Q?WrTvOIYSF7JEYZjAQM1Bj82OKma+TWIUGTBsuJrNYUrKbniTa4z+1WnaMXCf?=
 =?us-ascii?Q?PsJ+AnGt+/DKQ/8QXJneSQyOkPD561VceHe1MSSkTt8HCir2EmyFpRrPWVe2?=
 =?us-ascii?Q?3vFhUd6KQGyxuXD7kI0cbXro4fKrEqMj7BYV71kSWdoIYack1kKq+cWhppfN?=
 =?us-ascii?Q?NJBz356SN8yyzlH0f3qLpULCyUyZd7se+u3ClxOT8jjNeVPNWgCkc6c9QXdN?=
 =?us-ascii?Q?ZTYpo9iDW1qdSZA6ZznCT3WRjIBC7kGM/ICrGaAuWlJOdsoPoLX4DxFYdu8s?=
 =?us-ascii?Q?g3n7PDXHPu2uCS6SHM/s2mPbKSdsOUDC+3CrbbjNBYDH3h/2sCNZ7ii/9EK3?=
 =?us-ascii?Q?1iFhSMTvM4sYmuD8adrE2N1WWFv5KEE7uwmXpn53Z/DATmGGT8CL45UaN3cR?=
 =?us-ascii?Q?9U/URYDGcTUuXjMFnl0V517JkvIYP9PLWNSv2CXsOP5nOPTO6Wrt0lkzK+LU?=
 =?us-ascii?Q?GOHKh+st8d/rQDs2u4D12MPgA0ReBXdyQueXR8dOfnKS+ps/XU54MrOZJ8GB?=
 =?us-ascii?Q?pGLZLeMlS1Iy/++9LMvVtt0ujwERYBb2ZOfIdCI+fkL1TojLJrUhWfzjq4zW?=
 =?us-ascii?Q?3M1b6USkJq8j/X8NUfCK0cO6CO5klRsJxvbAJFtrBcuc6u68Q/E9lDKf4q8C?=
 =?us-ascii?Q?D/Gw0weOqEqd79a8CxQMVPrEuR42FGm3D0Gd+xd00BxAD/i0lQVY7Hy9dARW?=
 =?us-ascii?Q?mY/Fk0p6u9q6HwhDVQVtR1LBlAZjl1ETrcqVln6m+LveMzPogZ2xR4OkqP/H?=
 =?us-ascii?Q?PwwRAkPvRDOWszPNVjH14KSNukABv5WgVF5NxGUUpt8WjVbTn7NlGJNWIcpb?=
 =?us-ascii?Q?lcnnAK57qZvyKUtAtPDlcWdN2rNJLxn9X6ISJVEMBQQI0eVvRGabm3awVVEL?=
 =?us-ascii?Q?k8Xtwlxc8Qiy3Zfiab2+2MrCraqWa4ElkpdWV+HZCxzoKBiRrjLSJNCMX4oV?=
 =?us-ascii?Q?9kyCIajTYqy+xdSmhrLymalbqgjK5y/bkfIY/OaaOW2UaPLCXSpmUGtuGTFk?=
 =?us-ascii?Q?tvn5Yx8UCYkyNZbPsBvKJb4pCW9ShGXxYIrlKL4Ik1vIah6GXm0sUJ3QX2qA?=
 =?us-ascii?Q?ZrBKcjtNjhFgUMWiajo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:50.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c6771-ed00-48e4-b4a3-08de01db3f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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

[Why]
The shutdown() callback uses amdgpu_ip_suspend() which doesn't notify
drm clients during shutdown.  This could lead to hangs.

[How]
Change amdgpu_pci_shutdown() to call the same sequence as suspend/resume.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4905efa63ddc..e377fbb43e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2558,7 +2558,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (!amdgpu_passthrough(adev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
-	amdgpu_device_ip_suspend(adev);
+	amdgpu_device_prepare(dev);
+	amdgpu_device_suspend(dev, true);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
-- 
2.51.0

