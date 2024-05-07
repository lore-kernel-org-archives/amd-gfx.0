Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94678C25B10
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 02:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2900510E444;
	Tue,  7 May 2024 02:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDLMIVV5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D989410E444
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 02:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4TahOxYFFJQfVlu73OYRy1SPUVE04TYaOASAT2q18mFevyAtwc9qoWGUxo6EssJBlUvKNzWU+2orfhcfZIzgH9adEKAUjHQNcjRsjYxQ2csvLoFtOAv67ZDqIyh2adT7KknkqZ2EiakjAbbT5afmFHr6qrMHeE9ZQbploKveFRAJSgZwvI68QSLC/1LgYTi7FMrLH0h64z9buT5QqpVLhhpGenkRqq6ffdjmSTCLIuMqRVuA3QiWAxnc7ej2YZvv2J2PliUylUBHn8TRRfDRBlt5Wrx6rt0EXsBSprU+B5nuzCQM7aWIpkjvcthzIEbuR+aZYgw5ldrjECT3eFfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKSlyKLNm8jxTzJ5bSdYrhn/LnfdgIcvvZGt2Q1lYUI=;
 b=ePDGCd/xI6SA9/lUT7iiggq0vOS+PCMe+jZVWOL+w5IpqQHGEfSoJKPWW0+21Vk1y7E/bQGBe75sioUdKfzJijh7VHiSni0+5oPhVVp51J20lkuZmUWucj6D2QVIzZlF4VOlqf1Tk/LQZyEO0ZPQol2wh5+M1v8rWnSJjFXmEYQ8Id7YFYQKjehjvamAAfXBmRN2py0il4BM7R53FK/HXFwdVoHmcqU0ewIR2NlWvto4L7rSv36So17YFVm8lwENcYgU4Yo+PGs0ywHgR6oVApplOqGQHe+MHzBlOplfoGgfmowPYkSKjwSvpqZbnlX6kfXW81xYUjyhKDY89S874Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKSlyKLNm8jxTzJ5bSdYrhn/LnfdgIcvvZGt2Q1lYUI=;
 b=dDLMIVV5nBU9Bou9iLvjyzv2P1eJTzFaZBJa/BtmT0Xgf60alR0bV221Ju+rJUMAjexErXTLAPR+PMPDK+X5hS6vEpIlVs1G+iYTgY5psnpVUybkgdlQMnC4uGn4oQEOI49R1wTRmnygUB738djfsPhRpRZgfx9iXPaSvQ2shSI=
Received: from PH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::30)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 02:49:52 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::39) by PH0P220CA0030.outlook.office365.com
 (2603:10b6:510:d3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 02:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 02:49:52 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 21:49:50 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: fix RAS unload driver issue in SRIOV
Date: Tue, 7 May 2024 10:49:40 +0800
Message-ID: <20240507024940.2199229-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7c2c9d-6271-40f5-f30b-08dc6e405eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HXEdOCpzxAEgNVNRga3GjMM0P74rKkcWgkYYUsaf8xV5LMx4EGStHe+SVUEs?=
 =?us-ascii?Q?2QomY26twEaapOYzFIasC3hLNOUKE6ix6CBQ1QcSDr5YU9g1rn4deCBK+m3A?=
 =?us-ascii?Q?Jq+j7POwS3y2TdFXGSYKDN3U19GyDXTYOdTdXPRNeQvOQUBSo8dRblN4SmwV?=
 =?us-ascii?Q?lJivlvHYxUh1W7DBp2BNi3MN+7aKoHtW75pROHXOPjlmCtxLbdwRj14jsk78?=
 =?us-ascii?Q?hcaAVyIXrMMW40q0KpR6KSXgQNYlG3LTGFekbDfYfmLrTgYxBqypWOjNCfh0?=
 =?us-ascii?Q?30ly6DtlbHKcp8xe9q4Xxag5v7Akuepsqf1Ut+bhaj/oEumEbfrUtwB7zPiA?=
 =?us-ascii?Q?iRk/QaD3rGrva1bsQBczC+zrUYrY9MJkMykVE1EmnPOZjXzEOth+poEvzbS0?=
 =?us-ascii?Q?BKDv/mRHGvfjuydOi70Zo7k3pDd9A/6eVARCy9HGlNoHJsyFQjIGSqXGoGsh?=
 =?us-ascii?Q?yk+WqRBXiA3NytqfIwPcs9+H0RhtLFbuYj1+jHhxF9uLz/DjiuGvzNjxguoi?=
 =?us-ascii?Q?jQ6c9sqXDoK5DWrKsh9ehr4BDDcz6pVptmdnN/Gi9sQAFOHxDBWJi1KtyzRZ?=
 =?us-ascii?Q?poBd8EX2pPPLUqPDK2C4Mmkn73xbN1J++BRR2l/kkfusfk8WspX4scPA3aYc?=
 =?us-ascii?Q?/OUO2xrQrS7Hf8K1HvIv3usHD2YJUa3Wb7xb4DzaQfQ6ZDCunwArFldZQuJc?=
 =?us-ascii?Q?jzr7+96DQrzI4X5NQnPTvO0gsO1TCrfjZlQLpQyg2Jh8cUXLv1ap8lMYGcaO?=
 =?us-ascii?Q?QwU2tHkZYSwpZwqJH/OWzeqTlSX22pH7dv++TflIg+DfmdtznSA5zQqgF725?=
 =?us-ascii?Q?pwc+0Tk7NjaSoJ8+u51jy9YF5WbhSiy4qD1CEoXbuQ+q+LbOyUVhrmfPM2OX?=
 =?us-ascii?Q?Aq7tcgdjpoWNdDOXPcG/NLQXx7myT+IeO9Xiu4+vqH2zUjtnlCSh7VXvaCA8?=
 =?us-ascii?Q?F/etPGyKeniRXUVS4bBjlFYd7oT7JCBgXc3aBUFz/sJLwoV9ml0JfEuwVHgn?=
 =?us-ascii?Q?fD1t6GN2EYWl9NNsfq4MjCfijRPHK1l9FMbOctOuPqCbyhauPSz49DeMQ/CY?=
 =?us-ascii?Q?TDk/M58fHvY77ixWg/ZbMSxla66pX7Hmkv+n1rhEyHnWcOWQ61LtvildX72E?=
 =?us-ascii?Q?FkpEXRTNtN5+x3g6IZa2RUweuFL4lxBtm5KyYW+UHeMISilFJDIRSaRckxm2?=
 =?us-ascii?Q?L4bOtkZ0Ikp03YbTL3jkkx4sGLIhrV6zf/mBCcPUq5H2Cqu2K0sHVTVaour0?=
 =?us-ascii?Q?SF7f+00BM2VVwMm3447xVC5VY5HgG7hCotT01DQIOGlwGsJ2n36lA4cmeogn?=
 =?us-ascii?Q?Hcm/C47jpMybB1NqCjiZIlSvSq5wWYs7tAda2tI5UHptrTTj/5wHDRlQDaEh?=
 =?us-ascii?Q?zt4pmw7uutBfQJr27Cn/px5fC4D0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 02:49:52.4553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7c2c9d-6271-40f5-f30b-08dc6e405eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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

Fix null pointer issue when unload driver in SRIOV mode.

Adjust the function position to ensure that the amdgpu_mca/aca_xxx_init()
related functions can be initialized properly.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 36509fa9fecf..36deac3b1440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3611,10 +3611,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	struct amdgpu_ras_block_object *obj;
 	int r;
 
-	/* Guest side doesn't need init ras feature */
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	amdgpu_ras_event_mgr_init(adev);
 
 	if (amdgpu_aca_is_enabled(adev)) {
@@ -3625,7 +3621,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		amdgpu_ras_set_aca_debug_mode(adev, false);
+		if (!amdgpu_sriov_vf(adev))
+		    amdgpu_ras_set_aca_debug_mode(adev, false);
 	} else {
 		if (amdgpu_in_reset(adev))
 			r = amdgpu_mca_reset(adev);
@@ -3634,9 +3631,14 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		amdgpu_ras_set_mca_debug_mode(adev, false);
+		if (!amdgpu_sriov_vf(adev))
+		    amdgpu_ras_set_mca_debug_mode(adev, false);
 	}
 
+	/* Guest side doesn't need init ras feature */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
-- 
2.34.1

