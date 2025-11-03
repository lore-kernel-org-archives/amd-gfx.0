Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CEACCFA04
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 10:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2AE10E1A8;
	Mon,  3 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkEnwLp5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089A610E1A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev8zgcXqgtfXo9JYjQmqtefpfGvBvpVtSlOtPW1Ih3H9JATpKVyhoBTfeKX7qrn5kQJbbxR39cq+dXc3HPXWNoDYpQZi/lGXzHHt0Nu7KX1V+wnIzWPHKkyAmBbA/Jn+YIcLWSXmnjbKKQtAHZtboxHDx8Ve6YHp1rDndL+OeJecsnaOEC0hLBsmz6U7YxBqNLX7hh7MSTVewqCG6h7Vkk7YVyu0ye+/F5chYx48qyDyINYcg+KgDL4acgjRrx/ytoDhapwZ22o4ATYFOzSehU/OIBnc41/4fWfDQ8o2ckEyLLO9a3bsXyaPDAv3VSocg0+1tntlqjK1VAej9URd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJGRnWpS1U6je3HDKCbL0AS+zWIfFESo09qMTPFVRDQ=;
 b=Rfx+EZHu2DSBdIWSzn+rwM+vjFcxOkMBPenE4pfHGnGAB3OimcgrThmwb8mqfHHsXkZmlan2i4jhiBT0JCMay05+VA8TKjPxqdU9d0u5uPpApQYOSHNXXJSNwMfQUfzmhDRcB8qcjH8gJW+H2yWQz1SZggJlSPLydmUOx8MAHpL6tYq4PBMRJWOTZgJLPS+DXv1M37Gnj3W1Jvni4KSECKVbQtWEDyzxKb7kQkd+Brait+f52j89vJPCHDMpI7B7SKOaJCLxVQZzIItUz6hfwWLdNbtE3zK+VU+mQJHzxNBvukCKDmwqz2yDJNHshNasBib66yhS0+iolI2H3Ltw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJGRnWpS1U6je3HDKCbL0AS+zWIfFESo09qMTPFVRDQ=;
 b=kkEnwLp5gEMQfqKijQ3lGWsXafnUj0RLS18sVPKXh3MGTNQHOrf55ZZjMmR/S3jGDMhfxoB2SdiEYfrw6kkXrz7nkmMQK9jocf+xtJ/7TBLzQZe1P6oOFtGNw+fKk2AcrzHFyhGDMt6mqYAC0K1Eqtig/AyLKnPZZz5FF7E2DV4=
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:06:53 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::13) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 10:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:06:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 02:06:51 -0800
Received: from banff-cyxtera-s81-2.ctr.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 3 Nov 2025 02:06:51 -0800
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <lijo.lazar@amd.com>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <Qing.Ma@amd.com>,
 <Owen.Zhang2@amd.com>, <amd-gfx@lists.freedesktop.org>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix gpu page fault after hibernation on PF
 passthrough
Date: Mon, 3 Nov 2025 10:06:13 +0000
Message-ID: <20251103100613.19798-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc73531-b043-4ced-cf64-08de1ac0b5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hUxxpzm91tVZIHVTk3qs402pf7/BD/PUCqhpUC2ChGuuim5y4X5lcF3iFj6a?=
 =?us-ascii?Q?0VBFbmw1ufaHy5jjvpNyMZ0nzj5+6cR3q3k9loKtXNvB5vJu11Rc/H3PgR5H?=
 =?us-ascii?Q?uqIFuIJxUTRcsTXg5Br8VHjMnsspHJCQBEf7kUB9r5JrtI69hIbytaIz5mmx?=
 =?us-ascii?Q?bRKKK1FCF3CnN/VFJB0x6N06daYbuUq1TluEdAvmhoan3/5xM70m9XY1hJ9f?=
 =?us-ascii?Q?3hyj5iHhcr7TTsvnoQY/CXHIbzk09q3kPXXP4UH4m17cvWNN2hh0JrRppR1j?=
 =?us-ascii?Q?6fZDsBVuSmFwPIafNupgIckyB5Ld27OL6ACBo3J/2ejckHP0kdumyk0dIW92?=
 =?us-ascii?Q?bqLVQBcoSkdGfick2cCEX50HopQjk7t381igUbQukvYs3fFrfMftsXqj3Cy8?=
 =?us-ascii?Q?IydNjr6tcYVc0wkQx37e2QoBomJ/DvzaDF5l9M7JJLHjosR7FGEZHzbMeuxO?=
 =?us-ascii?Q?XKwHQ4fiSauh/aT1Gpgx6TzozA/MnpG2LthXHLOqvPmFeqKCzrMmhMnBo+g5?=
 =?us-ascii?Q?cH4gKHnNZs5PaR4sX/lDeNGJbTqtvpY04Rwj+JUJ4Qob5FN9YkS3jvqVh1lK?=
 =?us-ascii?Q?qkEqOV4Gi6eGn/r7Xa+RVsampDA+/NF07NueVuntk+BsXhPqdTUtIx4V+NCl?=
 =?us-ascii?Q?PmP4aS6jJPtdJpfbiIu9zClJFZWNziGhhdUdV0/2gu9Z4aTRoVFud2WRkJ6D?=
 =?us-ascii?Q?xLcNttz1SQ1ipRuC4zTd6NZpdD/sct/qt+wswEscEL/d7n1QUkTZUs4oMIwG?=
 =?us-ascii?Q?a/9vt6Euz3gvh0XipJNHDLBkvDwM9Ma6Jct3yzTVsz9iAGdJPY+5dXoN6oW0?=
 =?us-ascii?Q?BMQBclQFyvvPXgOBx1Bw1UgeLPVA1OUOVyF6OPYXinMJuwSJtlBCOBTPb1CX?=
 =?us-ascii?Q?DnjnUjIGjb7rb7y9ELrdMRr9LQRQASi+HLFky7LexiZGysdaa/TK99uXEnUD?=
 =?us-ascii?Q?vG2h/abY5IvX9l6Z/b6IL94HCPIUxxMkMZr02p8Sjs2ocqjhLC+6VV3pHHki?=
 =?us-ascii?Q?m1gev+E6k6Hw5rmUmYfKtH+GVftPCrusHquMy6aQrQwq4/PE0a9Rl7YWpvYh?=
 =?us-ascii?Q?vyUEsv282MN+Qed1isINU3FcPx7TA7XRBcH4XbsG5fOw8JmmXXtlohTEDrk+?=
 =?us-ascii?Q?0qHjVOyJGwJTPSsPrLpjSt7bEbitNTvyVmzypnwInCZ0cwgkivMeIPtk/LCq?=
 =?us-ascii?Q?asKyqvRiZaMY2pujkRdRA2tlheoJp1UAQ7l8urvbgbAXigcEIUaLmII/SBlZ?=
 =?us-ascii?Q?Mxg+Vrh1kU+UAGhDF/ckPMuIPl0PIuWUiiDkpVkVf4R97MtvHNtCq+XAS0Gn?=
 =?us-ascii?Q?I3VJqm+7QKI6V/2Lb3ZnQSvHzjT1sXtvPERGj12vJoSDOcj5w6eiS1Jeu6H+?=
 =?us-ascii?Q?TCsBfIDN0cWaMo5yW81EIaKPVvO93IHJXP6ssGVE3JsC0eQOSrb+/qHSuftR?=
 =?us-ascii?Q?BXHuVttjkLGDgrddweW6hg5ZxDgHEz5RrV+MJOYAWLqc+/x7q8lGy75MYOaZ?=
 =?us-ascii?Q?zd21q+0Oz1xbCplmN6ZloOiwwnzvrR1SyIzWPFc+YeRLZHd3wypWFVBchZ9d?=
 =?us-ascii?Q?1GqIjcCYlxDjouXe1XQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:06:51.9906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc73531-b043-4ced-cf64-08de1ac0b5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

On PF passthrough environment, after hibernate and then resume, coralgemm
will cause gpu page fault.

Mode1 reset happens during hibernate, but partition mode is not restored
on resume, register mmCP_HYP_XCP_CTL and mmCP_PSP_XCP_CTL is not right
after resume. When CP access the MQD BO, wrong stride size is used,
this will cause out of bound access on the MQD BO, resulting page fault.

The fix is to ensure gfx_v9_4_3_switch_compute_partition() is called
when resume from a hibernation.

v2: switch to use amdgpu_xcp_restore_partition_mode().
v3: use in_suspend to replace in_s4.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 811124ff88a8..f9e2edf5260b 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -407,7 +407,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		return -EINVAL;
 	}
 
-	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
+	if (adev->kfd.init_complete && !amdgpu_in_reset(adev) &&
+		!adev->in_suspend)
 		flags |= AMDGPU_XCP_OPS_KFD;
 
 	if (flags & AMDGPU_XCP_OPS_KFD) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c4c551ef6b87..a5748088d9a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2291,7 +2291,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
 
 	} else {
-		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+		if (adev->in_suspend) /* Restore if resuming from suspend */
+			amdgpu_xcp_restore_partition_mode(adev->xcp_mgr);
+		else if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 						    AMDGPU_XCP_FL_NONE) ==
 		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
 			r = amdgpu_xcp_switch_partition_mode(
-- 
2.27.0

