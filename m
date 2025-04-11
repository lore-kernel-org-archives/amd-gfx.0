Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC5AC369B2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FD410EC58;
	Fri, 11 Apr 2025 18:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2LQhCXJR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7CD10EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwey6e+BsmiU4Aks/rF0Q7vc0osMvEYkMhzYLUqBdjHKURriDM8eIQknSsOUFQZ+afT+x1IgLTuI75xDJc8Hy5CGKPvoU/1KVtb5pizoFvbZxv1On3ycBLTFREOVrTQn9Buk7jIXWMzezLwDSAwtB18AMUqr3Cca9GTP0/ni8FY1H4meZyRjjA2PesLuZjCUj79y9gXxQnJgnT32zqg9/5692IhdKoLOvNeuVsmUrwTAKOkeAI64kPZ2B3Fi/TZtjbWfKIaeBlXRtz2Sa/JoQkNQ0SDXbJ9EC8hXdoB48jkUm9e0xXqHFHFwCNRGX8PBP1ilEWjhZTOWecAaTQ2S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/1eBL/eJCCv2aCFs3KWbYxko8onVepDSSviku2Kzd0=;
 b=rO6PFDGBT5uFqQwnBkBeYbQGdWh2pWi8PAj8y6xE7vTWJIZzRU/MXk2I7DuymtiLy/FVCqa8xyVWtI7BU5vFInV/i6BzSlQrFyhWnNJTPU/5a5U+9i0EWsV5rl37wC/aXPV3aJw+H7r4lvOhCy7QKbsZN5zFMU9w+HcyJ7FvK7zHthkyoCS3A/J5ZUAZ5z4aZFUixB8mZ54UKwb6eIzwwf2viPM8HLdZIvj/E7QX7vRjGj4EKjhvLjzKfPz9R1Fq43jQBsIiv9bakSOkA5KRaN8JIplySAl2v3xo8ScyhkeSm8C4P9lfAubKY2bPk6c/DqKflWjEkBgPXTd0BLmuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/1eBL/eJCCv2aCFs3KWbYxko8onVepDSSviku2Kzd0=;
 b=2LQhCXJRe+9MlAt/brvLF5PWEqus+42zZVicLjqDbHOBa9CInkESTwzzEedNPOloVRoDxncL45pSBgjDwMTY6DSBv0lP2CynUUeFU2DxWVT2FhIOtQAsfLPTe0YfaQpFbK6+ZPHREtJ+EQZP5bGS1cT5Oax+ePa7gwczOrfibXg=
Received: from BL1PR13CA0272.namprd13.prod.outlook.com (2603:10b6:208:2bc::7)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:48:39 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::4c) by BL1PR13CA0272.outlook.office365.com
 (2603:10b6:208:2bc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 18:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 04/10] drm/amdgpu/userq: properly clean up userq fence driver
 on failure
Date: Fri, 11 Apr 2025 14:48:19 -0400
Message-ID: <20250411184825.2890189-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0832d4-b961-4108-7a6b-08dd792979b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vU+gfsjKK/Chmn2QGjru1sOFpxU7e0IdL+AgngI9kimJpOynuZrQVXQYDnsk?=
 =?us-ascii?Q?6N8KjRZQpgOmZfewrvu4R8bzUBJ6D3sH9phHknTG0FsaVKTGnrWS4ttEfcc9?=
 =?us-ascii?Q?mPS2wshpm2OqaP5VWd77CbqiMrev9YvDrA7kR84c6RmAuhj4VCsvPTf5OcKh?=
 =?us-ascii?Q?839bOUNOddvjC9lnQYBY4rA36yA9E9q0fdon/EP93yeJsjePBCBmQghfZENe?=
 =?us-ascii?Q?RP2SAAQ9nikJc7oMix97Vhgu8AHWuryAfSv+0Vm25oT9+rAHWuNLP5qYtVNw?=
 =?us-ascii?Q?pl8QCzII+MDQyTk3DG3gSzwgdl8THjgfLz6zztfVRl7nzlD6Pdn9vZcVntLR?=
 =?us-ascii?Q?qPXxnpQj9PNQZPc6lBXaagZzziWOGxgYIlYeZGhuZu/xVof4FPsZ3o26omm9?=
 =?us-ascii?Q?WpPTD+rr1TExPhB5+Uy5ktJ0iBto9Jcee2dfw1VUGDOuvhldYvSfCKIAwJte?=
 =?us-ascii?Q?/C6IpWtRGLAGDycxPiTQsSWni4/hdWrLB9SZFS4LFYtBlo10KEYfe9XV+nik?=
 =?us-ascii?Q?CqRq+6ljSysji3aJQpBLiQyoS0Lj3w+U7dSCG800jrbtTbCKtuVbke8Yr919?=
 =?us-ascii?Q?7m+i8L7RRT4B6ja+/DiRMBLVOadRIoktcACczQUmqMmxIZOlJPkdZ+q1Oo9y?=
 =?us-ascii?Q?yoWJqOOQqCHJZKTU5Dl7uS1yulV8XbBcrlhWcI0vZj2FXriWe5X5j3kfo39V?=
 =?us-ascii?Q?Z9nRXG8m6a+ao5Tm36i5nHeow8z9RWWyGQsdYXqKGVSH/qzqvNR0/MBq3CT+?=
 =?us-ascii?Q?JSJDnbowdPq1ZGpjT2U3mMRacv5iu3VeYTHfGT15jToMROucRzUb/01SOztk?=
 =?us-ascii?Q?hfSqJEqneCWw1FeKOatqFPq0iQOZgDkLdUz588cqj9fxXeS5gBiFHL3y3kNo?=
 =?us-ascii?Q?H8dMapqyIdjwNUm/k4pVWY4HLJxDurQvBlgJwfV7qTAg+Kb6bnQYrJ/eLFEO?=
 =?us-ascii?Q?anu7ARx1DqQu+FO2yN/U+5vUa+7NEcSIoeEdfwsQWxkGesvU91yKoZKscPBg?=
 =?us-ascii?Q?YF6i35HI1xG+IrAfJi2UfR1q9Hi+reNI88BPrR3dbY1wIew7y+NATAX6yaW8?=
 =?us-ascii?Q?XlgLmZ8OYpODFASBSnudz5+JzFcqzMDSK412KwY6GGu1hG5kM1FjlZ+9uSeK?=
 =?us-ascii?Q?3pOCnEYTYtl/m6FybxlfsiP3YGgwMY49ypsCW+NNUB8FSNtmnM92KGSx0768?=
 =?us-ascii?Q?J5lvarKPfnBoRXgVP3X7F0tkIfzRzKFupbJtfH1HXf+R1HBeMf0/bZjdlzLp?=
 =?us-ascii?Q?+8yjJ+kL0FxLOfSh3HUtTZVfRU0NguDGBwtNK7QYHixRPeBiU908jm5ELbdl?=
 =?us-ascii?Q?VtB70zvBt+1z+5UFcFOUUAD9q+5dsMR44wz+GEsrpP2RQh9+EdYXQtNpKXFh?=
 =?us-ascii?Q?cVqcc6RQiYGniYb9pJ0qszD5ZrkYKEOtbj0ZD8HvJLfsrPryYZ1xPTPOtKHb?=
 =?us-ascii?Q?x1rpwYuZdo+rOETIqEKkBIEoo8WBhXeZcRFiTYjjBOlreNfEcUs9zllnvLOp?=
 =?us-ascii?Q?ciBSxC2aCGx/iPjvV3xMeNxiaTxHkUjRpTX2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:39.8279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0832d4-b961-4108-7a6b-08dd792979b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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

If userq creation fails, we need to properly unwind and free the
user queue fence driver.

v2: free idr as well (Sunil)

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 79f4df4255c50..41a095c12f956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -330,6 +330,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
+		amdgpu_userq_fence_driver_free(queue);
 		kfree(queue);
 		goto unlock;
 	}
@@ -337,6 +338,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		r = -ENOMEM;
@@ -346,6 +348,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->map(uq_mgr, queue);
 	if (r) {
 		DRM_ERROR("Failed to map Queue\n");
+		idr_remove(&uq_mgr->userq_idr, qid);
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		goto unlock;
-- 
2.49.0

