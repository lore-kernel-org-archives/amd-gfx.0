Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC24C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 19:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBE3112D22;
	Mon, 22 Apr 2024 19:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4FNZyp3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBDE112D22
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 19:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2SYc3m/86yrgICjZDZdW8eCFiJqMcLH/UkLLaj95baA6zBB07x200LLZLt77TogFql0XdvOrbo/x/qEp3H5xldHjAsk2hOJM3g6iwSqnq0Q//Qr/z0/6YNHHKIanuGanEApkMpKHf/QgPRckiUBaxRlkhtapgXgIUteOwvZNxZAGJf79BtpFEl+fv4+w6SdxVzxHm9htyWp8IomBi/QaYmBaVFlhDTn2GTvb3H42NYMuW7yalwgP37btDMFQxqAkcGaZAdxFLRSk4RRhPVtOcnhjOCuMKvCv0KVpRk/djfLvEq8x4kYkNBX7EVNyeFunN39YzrQ8lKAYkBFFzQJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=labbFo1+XrgesoDAJ8pKmcyKAIPDdDhdMByUUIy5sRk=;
 b=Q7tS6UOBNczoG1DMYnQpmgfOf8YagYSeSfsVlG3RxQuIQCZGuvzCyS9a6UVRfeV7bFhvSWDTgqFiKy65iCL/aV01gFluVIw79DDw32BJ0zF8YQE83x2Yws7WfG/lmA0r6skR+5QKWBd2HWUqdaL3vNPEsQXxu18DrbjD2Q6uyo2pfNhU3yynKEFzYqY+u0h50JDr9DGmTN7sLrNU/+Hxbd9Bz6zGyOLZ+nJkkF0x2mqvPLLFFEH4lPdjjV+xSLQqGgAudiKA5mXY0bIjA7s7IKTtQbdwI4MgXSCvc/xK4qcYpGMoFYGuKMTzqcwncemoy/sgv3n40X1w29JNOQndYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=labbFo1+XrgesoDAJ8pKmcyKAIPDdDhdMByUUIy5sRk=;
 b=w4FNZyp3AL3CbU/obfSmgyerB+gg8323zuBEBvUHndwNuaoWpGbrEH+rsDkCY4nlH+z0wMB1pun6gqKiUdtj1dabgzB6/EdGu0q3N9mZj0qsAJgAsudLDCL2yJuOQzYW68SEfHnPEUV+XfJ8+totC9MnFQum14vdzERpZNWIswM=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:46:04 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::44) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 19:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 19:46:04 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 14:46:03 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Date: Mon, 22 Apr 2024 15:45:50 -0400
Message-ID: <20240422194550.26148-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b72e4f1-8dbe-4b4c-0e88-08dc6304d8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wL7zlFkOzQv5w5lcQ1FyijFo0J6i5jbTNgOFcsumvDLPOUGLiJjjrTgSJoNt?=
 =?us-ascii?Q?KEw3ENNRtn9NtZwDPLh3w5Qo0xp5h/Cxw1zzK3uZNXZm0xgWu3QnJTUUA/6O?=
 =?us-ascii?Q?VjTJ3ybWe1LVfl9gnX7G5SQTNFknD7C9aNxAcCwCZj69BUYSVCgOFKL3sfnG?=
 =?us-ascii?Q?VxMYNKVky15x0W27aKuxXV9a0niqBPki41NOiMmbxiGzutDx/KlL43Tkbdic?=
 =?us-ascii?Q?2RQ5x8Hd8QuYQxFArnWrQfWqaECSC4O91osx5CcARyehrV31qsiliV3GIUFk?=
 =?us-ascii?Q?sH8gCL6lvFD0GN7bUrFGa6/LeYTqseVjHI/ehE/n8/g9TYSbo1rQcMRDDMEK?=
 =?us-ascii?Q?Mkbq88UZkA/29dRP5yjOdzCnJ0e0eA0BstHxlGM54k8cj5pN54pGddPupe5T?=
 =?us-ascii?Q?r9fBCc7ktB6mmnAFRR4aZQFQRHMP9HWETNXakjXYh7Oex2yk/kWF6yF79pE0?=
 =?us-ascii?Q?c+zARi/pmyoE4GDumMj17+SuCY8QlsMpRq2YSxNlArGY4PePJ2Fe8pX2My31?=
 =?us-ascii?Q?Gxi/BgjMQJanubWNL1EKYt19pV4IqeNYHnOms+LSOijoifn7G+v6d8OBaHsr?=
 =?us-ascii?Q?55sHd8zY0smFhj3JOIJfMNE8q0bNq5aEncCucDY5QVhZopbNIaIxvGLF0MJS?=
 =?us-ascii?Q?peNTJ9csWEbDq8t6IYqi95IETKJLYm8zx4S2L0cCGWdtUn1y8EXZV4S3Ar/T?=
 =?us-ascii?Q?5g2CiovS97iQ5xd7wWg73M+1QKfVkuOekctkzh7u808EJgd5UjDyzZE5lIjl?=
 =?us-ascii?Q?mZ79wxnzHPrtQvyAxpSosxmEoxGBztlDV6+JowQUJvGhejhmH80YwwwrVARU?=
 =?us-ascii?Q?+tCcaqc4noloV/+lZCeEfSe8bI7AYoDVap0wZYaA5+pETLdYK5PMjTORKHLq?=
 =?us-ascii?Q?woWFye8+R/4Ec3nfMfkvZE+doFDSm6PAwtvlMaThfpoAp3BffD+CT2T7sSM9?=
 =?us-ascii?Q?sTskf2XcvFWB1k3XrEG1HirU0aEExMsrOycumluKtLBpOXW9ystCxpZSD5VV?=
 =?us-ascii?Q?qunWACUbkl6oLep8F3ews5a9txbxbi+E7dczMiFXxTFTtq4QFXResr6fxDoy?=
 =?us-ascii?Q?GHPGuWZxVyPzTBmbRIqalp9PEjp9EJIs62/++EnPUibe7mi5xnYoFcR0fctP?=
 =?us-ascii?Q?iDqphuc1SQoEWqX1qdd++ZpiakmERi0ZvhdU3Oegw+UwNgJ0LcX40nL5Wcib?=
 =?us-ascii?Q?tFEmkLTd3j8tN/OqP8niQUdAziwN6yVolqzOiDEPxW978z2+du/ludx3eGhZ?=
 =?us-ascii?Q?U44rE+n6jr2TPsIyt5Z1y2yZyPI5hu2VRMTaMAiRIPMt5gn377LZUL61rook?=
 =?us-ascii?Q?1f+3I9E4Bet0NNa5y7kkUddUbC2w/+JvV3aKb+hTO8ojStuucATJljeu4vLJ?=
 =?us-ascii?Q?n4a4dIbB5YldQWcEwbT6SJSxsbGO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:46:04.6012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b72e4f1-8dbe-4b4c-0e88-08dc6304d8b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

Reset request from KFD is missing a check for if a reset is already in
progress, this causes a second reset to be triggered right after the
previous one finishes. Add the check to align with the other reset sources.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3b4591f554f1..ce3dbb1cc2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
-	if (amdgpu_device_should_recover_gpu(adev))
+	if (amdgpu_device_should_recover_gpu(adev) && !amdgpu_in_reset(adev))
 		amdgpu_reset_domain_schedule(adev->reset_domain,
 					     &adev->kfd.reset_work);
 }
-- 
2.34.1

