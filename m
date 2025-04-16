Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA52CC369C7
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7B610E9CE;
	Wed, 16 Apr 2025 22:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3YZWBnw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DCF10E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np4F3v4pwKzB0EMBsm2Ogn7Qxp5wEqUmdYPMm5hLupBgwMdjB4FsnZ4rgcrkE7ncOfjpggQx4pBgwm8nPhTFneJR2HWmG75OCNU6h681Vq5l2W+2HSyz3aD9BkKiaxiCirz6f00slvTRcdOIde+DxjcKpUY2wecYlfOyyk9/zbx3KHSylyM6ky2aJfh/WrpWsQvjRnONZhd34zXu5j+Q/tDW1aUZh1RPiksAKFP5ewAh4Tfv0udgoB1YEaHk0mKYZFon85P7uEOoohuDintf+VD9UuFOwqiM1xvAs/BBO2YGpeMhuL2wZNfam1uK2lS9jUbLvi9uOuIbOrDInO1AIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm10Yxqyxrh4BNCkgcs54iy5+KfVVHIJPiLvz5fS1Bw=;
 b=MlwavIXtIcfpARwQIUxwqpq+7mPw446mhSPyB2Wz19PPYXqIAB1VaMK5RtPov2o4PGFP0tAfGqJG6UP7YXVHk2zSsXorM0NLZh1KhkpUknQl9cywmxispFaDX19VQBZCyj9CTVI2nC1e3slVtFuuQqTohP70UgXGgTlqBV5IEpBAmgX1yhKYhhK+Hjbj/LyocGLg8MqS6OZX1hY6RoGlRSVKqZOXWvcNPDcHI6Aa8cleRt7YN1rkDNwvFS9cChUJbJcNihuC5j+/gyo16cazm3P21h6DvauyGjG0xFpbhzZAoPEEaNG98fqTF0Y8BDLADrAY19TaMmcRCbJ9ENcooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm10Yxqyxrh4BNCkgcs54iy5+KfVVHIJPiLvz5fS1Bw=;
 b=H3YZWBnwru/6OAcc/5ia+hFcvvlisOBBp+p3g4TIa2dbts5lTzz4stTgrXfPHvUhERPhVFUtPqciUE5EUKNX3kjhtNkFxjxVlQGchIHqXpJHmExAqqdoMEDFwRfy4oIwUyZF4GPJWEAphXgQ9i+KYDPMpBMiisChxmROSziTDRI=
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 22:21:03 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::b5) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 22:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/userq: unmap queues amdgpu_userq_mgr_fini()
Date: Wed, 16 Apr 2025 18:20:43 -0400
Message-ID: <20250416222046.1142257-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: cef919ee-5aaf-4ca8-3047-08dd7d34f93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LoeQ0oiASlkVThU2xcitYqeIHVc2vPBtG8vENYWJdl5x+a8fYORKoiPOiP7Y?=
 =?us-ascii?Q?5TlcOl8VII5arXjzp+C3ymbvv2uCbaX1j0Qli6H3Slv6hKDfFgb099OSzDBL?=
 =?us-ascii?Q?CCtzS7UElEjOs6R1mqZt3KiSQRwuSnRHN+sUngCdkWZ+BTqwMEtHBHhVQsNs?=
 =?us-ascii?Q?7fBj5H2x4/nZ6FaC0MTNIPBIWvE4yk4MDHbZcibFU8CALbFS6i/5yMFWWPOT?=
 =?us-ascii?Q?vjIdz3U4Swh3//8lhMwKAhtTULj6jk2f2QGYcLVzio1nUSXf74Z5BTj5z8Mg?=
 =?us-ascii?Q?W4xiIvcIoJvpsM3Xp43spjTdNnPIcRmEtCqIevrwNF2B3pEAhudse85SjyQA?=
 =?us-ascii?Q?ZqLHdXcLauKfhJGCiB3RZ3FHc7JzwWSfu0yBan7m7LzHne40HqGBNi782vVa?=
 =?us-ascii?Q?AS8Ik1fNM+5cbuUE7dLWexgMJyDW46q7+50KzQfSH4ypklZ0ugxl0+S7bPSV?=
 =?us-ascii?Q?w9ehtjt/NxM+Up0iYo9vA1oLudnpk/IdODL2Wdy9lNIdzfvKD9jdq/87khLU?=
 =?us-ascii?Q?MxnHakidGJQSM73KDujuRc55Xlw+6R4EvajwYLlo6DHUGMeCNWVKChGLX6aQ?=
 =?us-ascii?Q?k9gY2i9RUg7BNtpevaf0uLL93YYImapYWR05CRySMj3y/+ma7e8KKaFUKuXf?=
 =?us-ascii?Q?A+LxKhMChNiT41qsrBqXs3zW9UNvcVt2efR8sxwPofXStDPHAzup+A09Aut0?=
 =?us-ascii?Q?CZbAUBvtouEcFN9SRsHLiDq+si8MASbbpATvI8EwX2kX0bPKW0Fn2jgHBGCi?=
 =?us-ascii?Q?oCPV/6QJty+wdXuh0CjUDkw3Y9KPfmTNUFoJ7ER4s8zh43Ve3/w1hGcfl06g?=
 =?us-ascii?Q?gWs57pRylISr10B/0UqpSM9c6wTvGGHOnzVwdm/cr47qA6ro9D2nFNrbF5/1?=
 =?us-ascii?Q?3+wO+N4d6/dDmyfUh33u5C+W7accJzYuPLSg3rCprVvzI7lBjzSEyOGmXbCs?=
 =?us-ascii?Q?4YoOBWtuCX+kf5SZakda32pdeFOJtJvqJpzEbCQIPxrdRRFHN/mgplCJP7QB?=
 =?us-ascii?Q?XlQY26iAj9pApXuC6UxUoW5K9v465VC5croC256HbUNaORtp58L/nhqAlNjV?=
 =?us-ascii?Q?efx8tDXwfp2jcxEv2pYKiucP40C9H3bLNwY1guaLhcuNWjWDgMwlaDDZzYGv?=
 =?us-ascii?Q?7N/IFSkeDTvoL+uTnhTN/YEOp8M5ZuSrpyMiFC9Q/TLv5G2Bv1rc+jZawNbJ?=
 =?us-ascii?Q?dWLBEOSd7vtsgIjIEde1iYFXgnWiTznqs99b3ui+OvaEQl2Ku6e2bDy7ZDQ2?=
 =?us-ascii?Q?AWo5OPJkcA11OFaFwrGOvp3vMlkgni5QYGE+W9iMLTaK1pJGa4zjYjc6fakE?=
 =?us-ascii?Q?QDvG1BeCh28mGujmBOBuhimmT50OUAAmMii7XhuSZWZY4jNA/RW9G1KOBt2j?=
 =?us-ascii?Q?jnEj6UJzsfxYutPcynVWz7TRjy+unFA0gmi6pjK+Oc/fpP2f6qLbfFRvUhwP?=
 =?us-ascii?Q?C7DAtNTMOMBAJysHjS7YupG0L1S5bcbdkZfU7LYgnvXkZ4H2k6rLdd5AbcVU?=
 =?us-ascii?Q?JSm6+5r0rpanQzO8Rhi6yW6SO3QPwOJWSUwa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:02.9277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef919ee-5aaf-4ca8-3047-08dd7d34f93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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

This was missed when the map and unmap were split out
of the mqd create and destroy functions.

Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 8e703dc9dfbbc..763532de5588d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -778,8 +778,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	cancel_delayed_work(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
-	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+		amdgpu_userqueue_unmap_helper(userq_mgr, queue);
 		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+	}
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		if (uqm == userq_mgr) {
-- 
2.49.0

