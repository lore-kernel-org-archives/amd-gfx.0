Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1537E77190
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA02B10E9FD;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ojHJgVHK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD4C10E9F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAfM5gMGHDPLoF1URO7atnMboVUp+vjpVqa04+MNtsZ4sg/ZPElNP2tnEdzwMf9cPVpGT8xqqJrm6ENspa/v8XBLNi3JrDM24XuUYwkUDRakRnZ/tbuIZ698EOAJbmG3AMcawmRP8ZA9/e1cbqiMwcPMo+Q9qk/YPypMIiMjprQN1DhpP6SgCVank1ZlDAPgsLXLU7lnhR+zaWEp2r4rpJP6m/CRpNhBb2r335U30vjzmBVQmFn+yCofxYKxvE/X9sfW+5ToF6PHiTlhePGrghkCBImVu9xW5we8oBvSicef41gIQ/wx9+5AaQZoofx/mL2hZgh4nRaH32c6PuS0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoYFjSmBjYe1zFUTAjJoddvend0NwWcl4xW/6JttAIE=;
 b=FxVlRdR4On2LgjGslDiShH5/kF1TuWorkCYFj9pw+MscYiGlKKZW4RQvrN6PMF9DAwIc1TwpHpEBpHxR3TccvJmBXXA9JZj8O3y149CE4G/U9UBKLb2eVMA4lo2h8E4c/owzwsAmHxS1xB9MGBvoMRfjeH5CqcSazCkjl+9IdOUaVxJxQ1cEu9vbrgY1X48Ibj/Upx5ZQa5riTbs4ymfmp7TUQfB4D5nbh41l7XzL4UOK7ZorkhtCzmZfYRjySrbxUY24gSYKfU60dPBR+9hua8tdfK4XjQ3tDC4es2E6rBTOH/4sMvWoTorYAovB7he1FiasUyNEX3afVX8MqrhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoYFjSmBjYe1zFUTAjJoddvend0NwWcl4xW/6JttAIE=;
 b=ojHJgVHK+2pUDRoUN1W5DkyIbOdph9idLlng8ZCJ0kXMS7UTh195orK7Lr6Y/wBaFddCEumL1wwOtbWf/473O8NF3OB9+xR0TzlEFxWmy6/QEFe5jBPARbHEtci0eWBeTuYRFbD5h5oPkA9L+gIH5W198+M04RJFSh2AalUjsJ8=
Received: from MN2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:c0::40)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:19 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::c6) by MN2PR05CA0027.outlook.office365.com
 (2603:10b6:208:c0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue,
 10 Dec 2024 22:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 45/48] drm/amdgpu/ras: use the number of JPEG instances
Date: Tue, 10 Dec 2024 17:53:34 -0500
Message-ID: <20241210225337.75394-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bbb4a9-a98e-4dfa-345d-08dd196d948f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nzWhSaVWjpKdYRhLQ2tOtnXzIaSstTKtz73Tuh+k6NSP04YY21ZXnwe+ccBf?=
 =?us-ascii?Q?7jww26+BcCWKBkFHxMw3ihNGzgcN+bxt+1y/NaN08eMUjC0aEm18DJf8plJs?=
 =?us-ascii?Q?t2piWj4AIDWu9BBAlZ0KefKCdlaqgw26N6pBxBURp6l3iQigyyERy9gZtYVr?=
 =?us-ascii?Q?th5ghigm5X44EwvQNYPHUFdkS+AtEB9d4gwcalNKmcjs73Esk3CWeK1Wwoe+?=
 =?us-ascii?Q?tYxoVK/K19RCdFBcKQN9faReKgSlXQbbXX+ic6E1WLB/eZC/ih6qoH08TUfa?=
 =?us-ascii?Q?BFKC3db375PvPCWeBfU0c29RsQc1CXSFFBC4nGIWyKndJXCdfs42+xsS0uw9?=
 =?us-ascii?Q?Rz0zFJjby8+OQmZA5wGocf9JzHGRut/hAW96ml9+hGFxN+2sDbiPPhvPpsap?=
 =?us-ascii?Q?a4YvQgqxo8qnV3BlHvzawWEwO8fwGIBZjonDcrsZh1r2tHsbbG05czjvIswt?=
 =?us-ascii?Q?bntUKFHDlq4wRwcKBymmUcVRd6SrMExNKMfjeGhHxY2SiSkA3ISSHuPLWJMO?=
 =?us-ascii?Q?E1AUuOsFHKKCOV6ljvWHKprEjMM9yRxwwWqX7ZEGNxBZ6qTwWlPxmpgtRUsz?=
 =?us-ascii?Q?EZC9yUbQYd3nw7uEpFjkR6sB1yJy2mNMRpuWcZJgZIdEbHp3SjBYzSVHbC14?=
 =?us-ascii?Q?CJyCOSRBcNGZhVRLErrFe7eggmqFuY1njn3IQyz++jHg8EAD4lrjdDKvfuQA?=
 =?us-ascii?Q?HeRKZ/mDx7FxP6Qo0d9Wqsa06/0Umwl4LeSLraBzW7+aZKk3M+cwWzVnF9z0?=
 =?us-ascii?Q?Ke0xKCMEc8Of8XST9RZe/oL2xkkRmka6DQKS1gbHvGZSiKVjzKPGpfcFoapM?=
 =?us-ascii?Q?TxSCDzkKUzTkTkoJfbslVJUboH9TTcCJlKcstSfG1Yksp0AdxFodK07KYDFs?=
 =?us-ascii?Q?7lAQgHYmLLuNyb/m6kHtP7qaXzjuorOY32hy/PdOu40u0qXN4pWcfvDnmfWZ?=
 =?us-ascii?Q?X41UsOkAXu9elL9PUBrJjfAzqHFNx2UD1web0hm0IoVsFTtvxwDbdvEjGeQy?=
 =?us-ascii?Q?Rqg7NfCDfnkNncDdKvnhNVFYOyJ9Xs/xmhpPuQuBqUyYEsoUfQ/f0ZCd5ocY?=
 =?us-ascii?Q?cFl4ErhyrNRVpIKY38+PhEXiPhjk6FTEQmvcI/Rg/rvLd2SLcNPpORrM7MzJ?=
 =?us-ascii?Q?BcqNIW9tXqbxLlaTHYaXQ5ZzA/pfD++gu8HadGH4xR9dZGOmBMpMlIH99y2J?=
 =?us-ascii?Q?C/a+kGz2qI78TOiANejt7LkPCivE3l/d4ZFdzNM+noObc+llUuWQXbZDS0ET?=
 =?us-ascii?Q?EooOSYIgJ2mstG37pwhm95t5AquTB+Hlaljf+CIK7cly3AbqyG8K+hsFZZjQ?=
 =?us-ascii?Q?OVZ5ojX+HnMymOfQ4FWMW+CV6LxrFnmbaeN1567TClqdrwWa6MXVrUlW4Dko?=
 =?us-ascii?Q?gMU2wrfJLjfnSz+Ci/Q7eToeanZj9xJfvDrmuEKfOnI0+DJYUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:19.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bbb4a9-a98e-4dfa-345d-08dd196d948f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Rather than the number of VCN instances.  This should
be the same, but call it out explicitly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 66ec1a4da7343..571f1c783bc66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -378,10 +378,13 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 		mask = GENMASK(adev->sdma.num_instances - 1, 0);
 		break;
 	case AMDGPU_RAS_BLOCK__VCN:
-	case AMDGPU_RAS_BLOCK__JPEG:
 		inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 		mask = GENMASK(inst - 1, 0);
 		break;
+	case AMDGPU_RAS_BLOCK__JPEG:
+		inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_JPEG);
+		mask = GENMASK(inst - 1, 0);
+		break;
 	default:
 		mask = inst_mask;
 		break;
-- 
2.47.1

