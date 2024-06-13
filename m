Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83701C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 11:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C8510E036;
	Thu, 13 Jun 2024 11:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgweDBKV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7538610E036
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 11:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr7iOM15ErtqkLhQJNnVWQdNl8Bq6Udmia64WHJgFcof4F7D2MWHKq4seQamd+RBaXLzm/cLck+YrLhaVORVOLEsgm2FtcaDUjahAt8bXGqiaewYbt8zPl6Olzj+of7CxhMQFvQdHtokxjX+ndbzWdISMcQCeWm9lrJusti419Qykm53q9Y9fJZ9bAVuKWmzl6ZC2auLSTaK3m2YLE1mB/+/X6ACWdIs4tYmiU3Nv1hRp8g5o06TLGypDYp2HfkxSx7s3olLUVA7LzMrYxgCN1TPzwJbPlxYxd0cxTjRQkErr5Clsodza2uhpRyesbqbHy7H9pJOKFYKMcphN57sGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWiNlExjzzPHmhtE9sj/2ILFtbU1TKCLT+3LEbjFbcM=;
 b=CayO2tmmpzekxquShDaWJjgosY9k3UsAFJ6qttXfUVoYz6R3xLqw6OEpI2m2Au9Y2KyGZlql1ie8S6X4rRPMEsdU3wuZaBDXaZJris9jb1tcfxOdtUYi3OG1T1hw4lr/eZi/iv5sjgSlPXeBCiZFTAn0v3qDV7kjZuMj5BYUpgiMBq0VEP171TvbpnIjjwIoKhUmgAPKn4PHZDosBrMJ2oacIwOG7Uo/86jtloMXWWPbqqYX5jdz2X+sqAeKm5LZR3Cxaj0rW/skXbV8ehJHiZovQcpWEIMUDA1M4xjqeM9FGPNeYOejJR1b5Od2YszHT7+90BDfWyP2Az2x5H55RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWiNlExjzzPHmhtE9sj/2ILFtbU1TKCLT+3LEbjFbcM=;
 b=FgweDBKVafOwZYvV36DMQ46wvN/vd+gBSrkiWWaMgJP+qiJmtzkpYR1z0GnSGhlbRgMOkYTdCtHHYCXW1zDvbe0O4nLSppwAaGDc211NkF26Uy69zRdtgSob0DniS6d+kq4fy1zRobb7UuTSO5Eyr29VwU6sRBJ3lcZ4IJh9blo=
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 11:14:09 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::fe) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 11:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 11:14:08 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 06:14:06 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: add ASIC version check for the reset selection of
 RAS poison
Date: Thu, 13 Jun 2024 19:13:58 +0800
Message-ID: <20240613111358.31261-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: b899bde5-6854-4474-aff2-08dc8b99f245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|36860700007|376008|1800799018|82310400020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uShVLfADbg0a8Bz4oJRAzkdXOgjhWQ3zA833AQrIUyl9hvr+9vMA4ff9WkYe?=
 =?us-ascii?Q?W1uSw0WUCtdlSz2IwP7VLCb12K8FPPWCRqrvVEeKjonIo9fIksBAXW0L6lDO?=
 =?us-ascii?Q?P+RDHWcZw0At+zcXZUxEQARfz6vewYdWLlSQjDsp75tMiiuFVzw8w3u5h2za?=
 =?us-ascii?Q?sgJSYN+TchluLE+95mVK6Y7D+8P9c2+OtwGXB9Ls/c+yZG5Gzt1qE7xCmwQW?=
 =?us-ascii?Q?ybbZ0sT3nfFjwhczq7xOkAzPN8ZQm0beYcVBxh+HBllyHWKrnQSs1H9T+AyO?=
 =?us-ascii?Q?4BWe8B1LwZQDLnpmghZ5IJk9fSXlO0oPANf+WMXogF3mpWplxmYtIpJ+8/iK?=
 =?us-ascii?Q?IaDmH8zmRYNO1LgKAPEWDMzUT9zNheyc8eeZ5yGVI4oSdhBgJR+TBJ48zxu7?=
 =?us-ascii?Q?gJzBZi0NA9KPpaje99ClNgqBLzFbXSqldZcudLlQHU8j2SdAacGtOY+h0FbH?=
 =?us-ascii?Q?RjurelfxJes6yHw9PoQ7/F7U+/uceYVux5LstzKLEwD9tWhj4qMdVYEMqkFb?=
 =?us-ascii?Q?Cf3GHCvUeazdGpgShEG9O9nMbCgngnFwp1Appz7pyYnJaKCwLy9EKBSJn8zd?=
 =?us-ascii?Q?E4nQsJShC0Zth3odcGpLbnGfmZgEe0TW8UNpHU6U9+6ORlBonXqIo/ina2Kj?=
 =?us-ascii?Q?RMfa9SjhQWLKzr8l/wANm3YMKXsj42x2BDpz+MxlgyBgac5NQvs/VVJDPytw?=
 =?us-ascii?Q?kdrSlnsFrGTNjjxPZ02Gd0B43u+9f7P4USjgpc7Y5+5wgO6AE7EXmEtKFWX2?=
 =?us-ascii?Q?06kRSHBg1q87S7BCn1b/DCxsUHYwx76F0ffyA7iOjG+eEPhwQadjkFhzO1q4?=
 =?us-ascii?Q?y9KMA6tceT2KABrjIU8x/F1Vs1rtm/wALmLFDfZ2/Zl0tyH0WdxVdZWzYLyV?=
 =?us-ascii?Q?3ZVKL9FuFVMuesEUafS/3gFQRjiGIbx4dPLUer/bIad8Xf74soW3jcNtTxMV?=
 =?us-ascii?Q?gz5wiM6C6imvrTk6UV/UFCJw6L7X2LhHCOlyTq/5/Z25EnskIlS8YlL/E4qu?=
 =?us-ascii?Q?Kqq52trjF81ebtS2p3dLpl16MhbirOah8atoSOQ7d8ydxrjzwdXuhfpTOND0?=
 =?us-ascii?Q?AZ2y/yJp1+dlWvD5xGBV+UycCKDeMJj+uY5DIIc/g3AtvTbXvYgzwH2avltG?=
 =?us-ascii?Q?xf72mUS6PeoekCy/N67fJbGv3bo6ueMc9LRxDWlvuurBUntwXR7c+YCqZ+/Y?=
 =?us-ascii?Q?Fzqqkr7j/6DpO+qEePYCoHzvFN688gzPhKn5DL7FX8T5g0J48gTG0krOOfmS?=
 =?us-ascii?Q?g2frzYkmremt1GxsLJoYP4BIxsRRebwSsdx3Dn9Q9Qb1X9n9Ufm0gjk9iDCb?=
 =?us-ascii?Q?goRpYkx8RgRzSGC7akr5aIm/BTYWy80FTFTQ86+R/lhWy4pL/ruCDy/ZZ14I?=
 =?us-ascii?Q?WM0uPbikRR5Zz5AqXV6qynEQewwjqwBvVkwUc6P1/5pE/6Nvaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:14:08.6928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b899bde5-6854-4474-aff2-08dc8b99f245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
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

GFX v9.4.3 uses mode1 reset, other ASICs choose mode2.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 78dde62fb04a..816800555f7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,7 +164,10 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		block = AMDGPU_RAS_BLOCK__GFX;
-		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		else
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
@@ -177,7 +180,10 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
-		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		else
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
 		dev_warn(dev->adev->dev,
-- 
2.34.1

