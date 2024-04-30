Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB14C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66A3112E66;
	Tue, 30 Apr 2024 18:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m96fyT02";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 858E9112E66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npFNfTQpi1gn8muaeGnIeUKN6CHvuacGa26AMSAfsDuCo+tJqy9+1Nlgojeq7qJoEev81Qj4O2+B5kiI3sM6e8FVLffQtOpw1D8gzLT+BKP0v5COK5Urt+Y088c+WApnwmCBaOgwwG2vlM1u6J+pUFSBouOmBfni0NYuUNbWYTOyOWwgCsiTUmyktocXO4RiBWvNkcWmmPX8zoVIrbULh+CLCw95wB/DUmY+jJkE3b7N7j+5jgaj/awLTeNdaHNB7TphiWQAhNnq0R2JXTJctzI74SS6sRwt+7w6OMjwJuZLvZfwBOZAKQC3vSOSi8WujzTltaajw33JqDw0OcX4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBjLV2kSRV7nwLXlLGNmFJSmpqf/humbHq3+KDUer2g=;
 b=myZJ47d1PRIZVbxm02UHZ/fII3JWnqY3HXoQeFxbDlOEruMP4K2VXUKcmLgrZhAkDTkG0X6yYCDkjdPA0/0KhX1PCPI1lOG4KDjGAGpygyTapZcgcXEWWxXJi2t0otVDFTWrLqZPedquDlK3xGotWgMH10UABsaV0UiTx8dktpePUabLf/eqDbV3G/c3CaAPgj3N1ldQcd7CJMZVs5aKXZL+wk2x2h6nlhnjqp2hPXrq9okVM9CrYy+WBzDqytqJLqZFH/BXg5XfOr9VpzHxrJIgPGf35ir0YcjjClKt4cL4hQJSZEZZpgI5izdaDUObCCovcf3y+ynvh3UmgPhgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBjLV2kSRV7nwLXlLGNmFJSmpqf/humbHq3+KDUer2g=;
 b=m96fyT02VhjHwnhUaX31ze9IzWsIV8vz+leQ/cjoAj0neCBFKyk2wf4ha3IqLSBlqNn1WfITi5aMINJP18mKw9LMeeLb8Dzh49B8VNLdqRPPVigkx4JKgt/nyPfYJron/XfNPLZ0eK3SQEkmgigGroLcxx45r3iPTDW7Hdp8ldM=
Received: from PH8PR22CA0012.namprd22.prod.outlook.com (2603:10b6:510:2d1::8)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 18:58:32 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::96) by PH8PR22CA0012.outlook.office365.com
 (2603:10b6:510:2d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 18:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:58:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 13:58:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] amdgpu/vcn: enable AMD_PG_SUPPORT_VCN
Date: Tue, 30 Apr 2024 14:58:08 -0400
Message-ID: <20240430185810.750572-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 781035c5-f3b3-490f-e40b-08dc694787f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fFnRHwwHwMlEb2MuqChK9AgdwPLdnAK/QRB8cniFmmRaeACEv6tTKa1VGe1u?=
 =?us-ascii?Q?qUFtPV6p+3ibPf+5g6W4pz0cvqpccgfOlbkMXU5q6bEU4aHW2CXM0ZQxdehZ?=
 =?us-ascii?Q?gVK/jFyP2UuCAhyRK5TvF5zpCq1Dn0g6+vSNibMjA4KEKrRR0kqb2mtOf2b2?=
 =?us-ascii?Q?LMvzSPUMYyNr5GL1PZIMQffXRifQXEn4bUqvnuQNZCUNxYpqOCpTmoxmVz3q?=
 =?us-ascii?Q?++PkupyKQHtN+dEd4pIFPf05hYdXt2rFqmu4nZKewbdGU7f53Lnzo0tx44Rp?=
 =?us-ascii?Q?3lMnfZc2igqE6QrYBlONeTRvzwrbq5R1+GcJ2MPiwWX/0QxEE+g7z2rk2LGx?=
 =?us-ascii?Q?v5Jt3uGhG8wxBGSrWLYhbjO3meBRPqNYaBnwcFvIwXMTNmDa2bwIrji1GVyy?=
 =?us-ascii?Q?KSB3UOAFNKDRRZ3ysioHvgO/OJoUA8sn9OnOEGstALSVAi7Alcj8Agf8oZTi?=
 =?us-ascii?Q?NhZWcOur0sOnMxs7f4KnoPxvEokgiXE/xNWJNBq4kESJR8dnfk+aQZR12QY9?=
 =?us-ascii?Q?TjjBY0K3yDuJnVbxLGWNtmh6sDkVmnNOJE+XsmffcZ7wtM5FdXnhe6w5B+mq?=
 =?us-ascii?Q?Y1tceI6HkpERxeuY+ASwa6Fr6d9biDWe6e5Tmt2LT9dxjCEhZnC7Nx4Ntf4L?=
 =?us-ascii?Q?8OUGL3OXK8pfiHVmqrHGsPUNhJoceQACKCEH5R0Qnwp0sEzqFShpk5xanJgy?=
 =?us-ascii?Q?uyrJGclaHD2uNHPzlV/knXld1/aCTAElQ04O7+Vo0Bzd8BvVel1BtzQKDfVW?=
 =?us-ascii?Q?Qhf9iGOE73T9h9wfR6hfL8AsVlkwmWpjCkxl7WPN7WL/cyE14XO7hXf/pZ0q?=
 =?us-ascii?Q?BjpByvU1EZn4kq0ahizS727xIQHUafM97iHJpMygTpEoPzxKcFuf7EuF/MET?=
 =?us-ascii?Q?RA0j/+unCxNPBqafkNZGl/5ssEnGxTvhFrGOQPpfHY3t9w5T784TzEfxPodC?=
 =?us-ascii?Q?M3sBzzyN99Z0OxkrExZDY93CqUumVgpHPP2/lbBqp/Wdy5kbWL/aEyIvgq2O?=
 =?us-ascii?Q?iBJxL4J8rQKRirr/lvF4PpCZpNrYo+RRcMULBRgFLYhcOs8U9JOdJlWN05JE?=
 =?us-ascii?Q?dO7/VS6odcDPTJZVY1lOXW00JNdzWgkC7rSIBLnIbyUMZL935M3J0b+8vGhN?=
 =?us-ascii?Q?7EmLNrWbYeRX6JoToAEfGQMdH24mLc9wLB2FyFfG1qiMEGUgz3b6bQdDe9sr?=
 =?us-ascii?Q?JHzHcXtuGRJHRshb7dDnJm61Z3pQBPfzOSNesHCi+brzm5DJWKwJHAN3kdZg?=
 =?us-ascii?Q?tTey9oip4A6pe9zpx4fVMioecV8MZBvuSCNFqHla6a2ATvtRyO/45bZ7O9t3?=
 =?us-ascii?Q?F1xmgFlcn4hiwek3e8i2sm9CSO8294QuqC35WkCB0CMDD6wdbkBxso7WGRj5?=
 =?us-ascii?Q?9OhWeZKUHuKPnPMdlhDnT3Ddvj61?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:58:32.2929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781035c5-f3b3-490f-e40b-08dc694787f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

turn on AMD_PG_SUPPORT_VCN flag for power saving

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 6b438f0cc86e7..c8cb255b6cf68 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -359,7 +359,7 @@ static int soc24_common_early_init(void *handle)
 		break;
 	case IP_VERSION(12, 0, 1):
 		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 				AMD_CG_SUPPORT_GFX_CGLS;
-- 
2.44.0

