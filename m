Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B250DC25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1778810EAA3;
	Thu, 30 May 2024 03:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDL/z3p9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BE210EAA3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi9yCVbuVQLK/E/XaUuZnvjOauEBw6YXk2qpimzxz7jnudDNTYLVQbo012sKFeeeZlEC+grFVQAEWbfd08G/Sd1k346Ni5EqP8NtOuKt2InQC17BHzMc0Y1tLAB6dJsLWqYXLg7CKQ7XNrSTynvzCa93UrNbKQQ2SWwGskZAdniUin+U9j0Vym8hLab4cUfmFMuu4Iskxlf6WmqW3TFXK7vjdsCxYOkD7aGKu0I4doBWJYEMtpvtmj9M0qs0FquRtWPuQQ7VTkncSe8TLY0vNlRGhJA/5sXcaTuYlLQtSRuLdfxfaWS04iE30IU2LbUPIg1KAKBes/IRiZ3r7PdrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J5zmZWVW9sG9GBkwSXkAYPlNBcMbF9o/F6gEpqaKLU=;
 b=jxHp5HoaAmh9oJfgoI3b9zHv/WHT/VodSZh7MAX5kDsvoavTBYJxHYe88bZjvrcTlOuqKM0RuOCD4ddRGaiEfrZD9jcB1Ki44tvTkYS0tTFSh+J1pn2Nd9ADfftsPH8j+eNtg4l0qogHEINzueWrQsOPrgdndGhMB4N9vi3q4W3cFZLvKF9Hyoivo3+Yk5tW4fDFkuq3BCc7wpzVOd4uM+sDqEOxgz3r8WCMhzOEa/VPRV5MwKmSMRQsEmuE7EX9NcvoiuAMLvLiYHLgeGgmCAXwPyf/rPbI0x39cwXAPs2DlRTe2wtIvXiNa4z2Ucdvs8UduFJQxDaGwKMEREwDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J5zmZWVW9sG9GBkwSXkAYPlNBcMbF9o/F6gEpqaKLU=;
 b=UDL/z3p9v7sSYdoGErHv2fPnPXcUNlzfdksXgsTia9RWsbRZ//5nAvPWy+HvtRHic5acS/3TenPAEatnq5/Imy8Zvga7Ai+696LnX94NQb5nTEEnpl4R2QW7ljMyDA4Fgzibdmv7amwnu8mVcYk3BycDRYXPmBSdGXJVtxSkt+4=
Received: from SN6PR04CA0080.namprd04.prod.outlook.com (2603:10b6:805:f2::21)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 03:49:18 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::ab) by SN6PR04CA0080.outlook.office365.com
 (2603:10b6:805:f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 03:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:49:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:49:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:49:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:49:09 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 6/8] drm/amdkfd: remove dead code in the function
 svm_range_get_pte_flags
Date: Thu, 30 May 2024 11:49:09 +0800
Message-ID: <20240530034909.2341467-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e59424-015f-43cf-00bd-08dc805b7b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPPjzhQlfBEREuSRyl8UBV2Wmh3mz024eLXfmuDVRYX2GsiHnZTMTQN1zEzW?=
 =?us-ascii?Q?frgZvdfIpU3q04GFM1Y7ijHsjBT7F7P2duzmjX6qazEmrGZtTOmeuQ6X175/?=
 =?us-ascii?Q?PAa7G09WstGTMLalRFnYaqXKrlpgt4LeYHiReAdcMLgEG9G67M/UaZpZLizJ?=
 =?us-ascii?Q?axmEFleHsBs7oXpJcchTY8CKeiYHJQ1IOVs9/G5v8WUJcpCkAZoiRnHaR6cw?=
 =?us-ascii?Q?RGpk7siDsUKLoU4PRx5w/inT+s6xVlGyi04x0s84wMJtdymT+QcRf0OShKUv?=
 =?us-ascii?Q?Nim3gzFZnla6TznOY/eas2PKdMf3RWf3ZV5qs4vEgovdWiQlzDrSjibskZjW?=
 =?us-ascii?Q?9t4Tv79pbWeSYGOBRMebkhZQGR22M0eqiN4MVowfMxhwmTaNfb8DW1pNepEf?=
 =?us-ascii?Q?He6yDXePMfS44Uo4vWPTBACXI7uOIWxUBOfeQKXKrsMP1gHGt9s52LeQp1Jj?=
 =?us-ascii?Q?OhMUFzDkAt1t84tL3PdE4xeRa36294dswZPZtUS/FYCG79BSgMBnFg1h8tXt?=
 =?us-ascii?Q?Ny+zIj/UZDkdr1J8oy0m+QD7Y+bjn5Ht7+L+3bXwNwzcV8gYaHRX1OhvxhLZ?=
 =?us-ascii?Q?eeQ2LBmeq526I9O9rgcGKgwK+jKiAeYt9x8YTUzd74pu4+u7Q2kl8sfAbYb0?=
 =?us-ascii?Q?R2Ztethx1oWW96JwzkyzPCAvtbjfBj0plS7WjMJDys9SwC2JT8Lc/Lds15Hi?=
 =?us-ascii?Q?OdLpuklbINL7B1doZ4jjWdZJKIZpw+64AkLFbVzqFU+i3xs0uqHxQ2/2kpQP?=
 =?us-ascii?Q?GsJwBS9t2LCGKliO6Smf017/uP3KFGc3YCBwLv53a0XK2mzKhvgEKDrw2gbS?=
 =?us-ascii?Q?WQkT0Pr+rh/HU/TjEAE0c/ZBSP/jqiSDr+M61UL+o0y3Bu2Dm3JAMmSZuCew?=
 =?us-ascii?Q?D0j3K6MkhMHruDOOKGU50zI9VtYna/ghGBsuhVbx6AmgtYtKwGqLVyiBtKWF?=
 =?us-ascii?Q?mcr0oNFThegaCZehnHF1NLtK/CJSp2G9V5gY6CXGSvOoFXGuUmwfJffocucP?=
 =?us-ascii?Q?vhDKdSiL3mfdwO9c4RbVecUBFlX+Z4J0Qwpk4LHSA5oYdYdpIAEHsT9oZHuw?=
 =?us-ascii?Q?h5LiFPWIiDuL1mWz3IFiLVwW7STUan5l6XvDpMUOEkzLLaHpmxkDTPe3hZge?=
 =?us-ascii?Q?CRXzfV8Wj1z0/HehrbYLvIUBltsLwPfIG3VnxWOwG94lJDjWc9dHRC+R7dub?=
 =?us-ascii?Q?GO4fwQOv/O1M9Ql/dy2PPQsob/aDDNrOWekKxgZKPh7PcOS1EKbC1SaoUcm3?=
 =?us-ascii?Q?GVp5CijlVQbcYdUoKZ06dzquiHIC7BQB+TckEhHUmW+c7YpS/QbCG+WMJmXy?=
 =?us-ascii?Q?+nrJRriLCYr3o/TA+dw1EaoPzM/o272I6U/dBt5XmeCLQFHaqLdxSCC8LTP4?=
 =?us-ascii?Q?j2xxRdQa40DCtllSbsYpo0b90GxY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:49:17.8493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e59424-015f-43cf-00bd-08dc805b7b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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

The varible uncached  set false, the condition uncached cannot be true.
So remove the dead code, mapping flags will set the flag AMDGPU_VM_MTYPE_UC in else.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..bd9c2921e0dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1171,7 +1171,6 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
-	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
@@ -1220,9 +1219,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 		snoop = true;
-		if (uncached) {
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			/* local HBM region close to partition */
 			if (bo_node->adev == node->adev &&
 			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
-- 
2.25.1

