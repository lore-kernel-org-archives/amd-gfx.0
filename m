Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2907D5B862
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0BE10E4BF;
	Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kTIqOd6p";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741AF10E4D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV2/TE2uEP91LNGmvBbgpok57hMlnbyfOBGf7lN5A7Q5V5A7qw/w0a6H4IxGeNKA5GMFf8LTYxI1vLsY7x23qIp9L8oRxyfLaYOPwRG1WDaafxU4RJb5WnFGkbp0mqvLPsnO4hVlMOfB/otKncKRF8w3xGRtswNhSwvuuJLUgwtEwxbKkl4UF8CqZpBrm/RHC+lqA6i7yRWE25OKaOPprG6IGBMdLsJH9hSWrx6jL+EkoqtpfBqcpaWfD16ny9TL1GoU/gKZbtNGkXaHzXc+dJZfTYamp17bR6jVBs6BvtOPwoKNsfhm1JGvxLfdzi0lorthbR5zxRvuOQWYyOfHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYrAI4wB+NeG2AAaQ5lwm1m62HfRiaAsQaNl9Tk1VIE=;
 b=ZRNajuTDnGquMssDeWzhyhVRfWfPWKDbeTUtYgKLqCCrajmI6eiJ0fDC7lF2Mh2+SlA9VN5j7BqXeujWVEMgLL+u1K52ODj3cHxSBNUqXGgfk6SQrVE8/oCeEV80pSbkPKZJdM/0N808MVm1DlweUbmhyG2iZcD/c8IUfC2LAOW792Hh7GqpNw/yC2sxacoxugL4bkEiHcF3aLJfjkVbi++cKwmEe7BSiCd7r2/rVaVSxD0z6l4Pde5G5ySL8h+0LT1aWHSPRkWCwFfog3TbkSofrW5nKxX5QJ1EiKHIJ9eJxWbaeRBBxTNGYLIjTFHLfLVwxFVcWhu7ZYPClzIYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYrAI4wB+NeG2AAaQ5lwm1m62HfRiaAsQaNl9Tk1VIE=;
 b=kTIqOd6p2ej6uEtvhdrHodqwhQtSHDG2F1WRWSLwp6nNoX6C3Vb0upYzvbExhVRRTR5SheFJgfCG+BzVIoFcGSdHOQ/4zPjFDxGk06Q5NIQm/PuU8Gv4wrpFXLWG1bZItjXXwwSEvUopWUvDkKI2bKaT928i4XKYODIOTp9QYSc=
Received: from BL1PR13CA0227.namprd13.prod.outlook.com (2603:10b6:208:2bf::22)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:31 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::55) by BL1PR13CA0227.outlook.office365.com
 (2603:10b6:208:2bf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Report correct compute partition mode on GFX 12.1
Date: Mon, 15 Dec 2025 13:16:02 -0500
Message-ID: <20251215181607.29132-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6237dc-44a7-4780-fd18-08de3c06126c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wSF6Ie7zRiCtKth/ES8us3tmnoi4bxdW1sF3xngHrwCDO2Kw25alxjz7XN06?=
 =?us-ascii?Q?5lquYHBfOB36aMJPMJWbasHE+dCZcJsTq7J6yiPrf6qxtg+oGaVsQRtu+2MQ?=
 =?us-ascii?Q?RAr38XvUvupGeUnEKDvLPBAX2iXSY3XObwUgqYWzHrbLXayknSjXaeEe/MdB?=
 =?us-ascii?Q?o7t/8/QgL8+2jzarvIxNGVqB2oNNd17bz3YxhJ6bjVTroHtz2LqD2fgj3gVR?=
 =?us-ascii?Q?E22rjdgcY+iObNPukIhMBQr5r6YG92uTt/3pgE/AADlp0WljPrBy1R7VmK6W?=
 =?us-ascii?Q?EPuaGJDTh9UHSR37Duz8sT7a4tWv+dd5ig4aBpFFqNayE7SAInxiX6ugZ6aY?=
 =?us-ascii?Q?aoK/al4Vw36Ah7BYTjl3XynivQFkuhHtMPKff6cQYP4gXpKVCp/CN421z6X7?=
 =?us-ascii?Q?66SiANzPi5ZEWdvB4SvdcwyKACHZaGSsuc3UMOjcSNCZPIUrx74bOldCqpG7?=
 =?us-ascii?Q?FVrAVOGZqGX9ekZSZImrcKzgylWIYkspdqHIz73I/NFpI1CVzuG1QWfCKVI2?=
 =?us-ascii?Q?GyUjOUmWDFzXUGjdHKbN1ZHUxCaPa3Ca9a9YmQhm/GzUAPh6yTViXmRYxCyo?=
 =?us-ascii?Q?zKySNHa7b+cy//kzDcWvCqjlw2iokOQ6wir3jdzmsOsvNqeONjib35BvzhPM?=
 =?us-ascii?Q?ixuOyECpfmArjyEqjRfGoyS3VUwadmAc8BQ/eF50J9NxINHqSJa7/yS3kw/5?=
 =?us-ascii?Q?fknPvYx+4I4YI9yL2zRBgg4iiC+e77OBJbFIEWVQgZM/Q9f1O2W35ucyp94X?=
 =?us-ascii?Q?XAM7DZ1Zoap9/vy25Kk2nDs2O/O9SYIpJL5d6TK8VIQknRXU2wnbf3bPmBKq?=
 =?us-ascii?Q?blyfVQpWKmNwemhwXF+dLcp6qHgC79W2Z+vPIb7Oed9c/4FAIvDi1vhEjtgd?=
 =?us-ascii?Q?HU0uerWqK5G7JQhK9hAVrqKrG3vrXGlhCxOxFFjrg6c3rIA/6WPvOtPb1MHp?=
 =?us-ascii?Q?HsualoBXkWe3oD50Xg8eBZwj37dQJe/KICHBZPyMOmg/bBqIVMD/wyY05+25?=
 =?us-ascii?Q?zVyJCJiBA8KRVu3UMFLOfjb0Zgs/vYfCLnK98P2jbGgT/npxEynf/T5iPeAY?=
 =?us-ascii?Q?M9vHUC3c9LvXdbIhAltRr3YRt6S4eaEB2/kFcvBIS8TQjZt+7apvP+E0TY57?=
 =?us-ascii?Q?92LprwNqvTW6Wco/666UkwooRDTtO9W4FZCKIF62n/kGOw7ea00A6U5/lWpi?=
 =?us-ascii?Q?28VAl41T5GZnRn4HDYo/bXESx4suSvRk8VkH73hGVeU1nru55BavuzLQTOKc?=
 =?us-ascii?Q?eTeCbPiap578EIgpso/nVSdrO70bavrAdnzC33D81+Uk8vmRXZ8+P65uAjJN?=
 =?us-ascii?Q?y0C6hFUCEf5m/ad8zdeLMz3XBwbf5Dka/3Y1GaofAFBnnA1RxBN/HsMB+WER?=
 =?us-ascii?Q?TmEm+hVpWk4KQtyzop+GDkydIeHIrDf+cRR7rib0u0//ZYfveRrwFH+79imf?=
 =?us-ascii?Q?Qd9TVwh+vkLCAK64Ksy5Ie3gwE7aUYSRPL8/xeCUcW3DscMkZDKq1fBjOu4u?=
 =?us-ascii?Q?XdjM0+GPH4+q2pvT/mJQhxI8on+Ku/ti3DLu/+t9S+FLaXt/6s3LYZ5v68Za?=
 =?us-ascii?Q?yYnvq22xv/C+0eTkWQ8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:30.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6237dc-44a7-4780-fd18-08de3c06126c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

From: Mukul Joshi <mukul.joshi@amd.com>

PSP programs the NBIO partition status register. In the absence of PSP,
read the current compute partition from the GFX IMU register instead of
NBIO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index ec9754f687d00..23544cef4101c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -379,7 +379,7 @@ static int soc_v1_0_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 	mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
 	derv_mode = __soc_v1_0_calc_xcp_mode(xcp_mgr);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || !adev->psp.funcs)
 		return derv_mode;
 
 	if (adev->nbio.funcs &&
-- 
2.52.0

