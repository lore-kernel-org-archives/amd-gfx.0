Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C29BC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EDD10E346;
	Mon, 23 Jun 2025 09:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwWSMqaC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AEE10E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1WhygwOlavlLww1YyUNFy+b1t+f47s84kGBS+GwLtcVCvA192bRVILrdLvK5fW2O4xTLMssW8BnMVrJyvDdwymXpIhUtfltl1WBWjUf8p/Ec4wQ+txoyTlH3UwVMVtXJynUkbBd6V3iU8NiDaUQMVxy1wHQQ+pLD9u7+BgcRc2kImd9ei1EQYmqPJAxrmztZo0331XvPCPPd7MrYNzrySzgDJM2GJbmf7SZ6PUVv3wOf5ebTGDU6MwLtZ9mV4rQoFR1Qa8N1z9HL7YEeyBB1NeyBlfxcvQ9BSrl4sixdwgE3uDIFHS9td7kgy0VVnSkYb3UGciwChpNEuU/NTHZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkBwX4bfsHL66lU9elGmfpHnQ0AtrF0i9BVBshlA6lo=;
 b=n5VAPPrlaYoG51q6Cbji2kHTVkKZG7V1leMTY9gJPq5FebUeCIvvizjzb8nmXx7x28sSs4eYS6HYh7lSyQsFgLdwFQRmscyhoiF7xHzgAtQjZDeP3YGuC+jvumJPibhMx5/p0GYLoI8GIprb96RVhg2kjcvkworwBpiGeg/KJ4fs0NwBQkJ+Bwe/OgtAE78kIzrWhBOYIjIcMrWTASeK9KNC8cbtSxL8nwKReIXfNCC5gmQWJb4BA5lawo2te6PnAN3vnF5LT2O5U6ZrYsKT6dewAfIbE08XSoy+TacZ1N5FF6E2Kc9ibVfj2cHxLIY8VOHA02SiMRqg3FiGloQVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkBwX4bfsHL66lU9elGmfpHnQ0AtrF0i9BVBshlA6lo=;
 b=ZwWSMqaC6W5oAgh/PtGCVYZdeC0RZaAQ4VBu52fCOFUOGit1AUlaXP7OKF+p87xVpGaUq08fjA0LgwOAcDsg1cKMpCNRunPx1vBmr/nTojk6L38KGHZQ1fo0K20P9RUKVvYB84H/2QMwlSAyj+FWjZDdq3crGjGlB6IIa0G9ZUI=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:52:09 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::c3) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 09:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:07 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 03/11] drm/amdgpu: unify the userq doorbell object destroy
Date: Mon, 23 Jun 2025 17:51:46 +0800
Message-ID: <20250623095154.1150830-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: b57eaf7e-2088-4d81-d2e3-08ddb23b9ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hamlen2xmwmLBrd2vdm4882Ovrbs9r98cANThSKQwPa+CJn/Mktso8Gz4IPR?=
 =?us-ascii?Q?//OUzxmkgXEhXmiQm8hgAbhY20SKlYKm7/jQHi9mugMVVYbeLZsJBF9OUz/0?=
 =?us-ascii?Q?Wx9a63H5HWjFLSFEKty+L+xnOgbt4CehUXmQUeBOkyE1bkZGYQZiO2Db344c?=
 =?us-ascii?Q?+w6IFP2GE3OwJ+bEUi+nC4mnVb7sYRrQEAzFDCi8Xjp70V3ePUkuQvDJI7+6?=
 =?us-ascii?Q?4Vc6AngSdwLAtjFXW3fo0EM19jEPu49TTMJe7wLk5KEbjAYQ5atjRGOATqF6?=
 =?us-ascii?Q?9+pkB/HuLfzDZgSg0cF66tP2ktHZ2IVw8KD0jqGhpi/FRFI3Xg6WVsgg/F3i?=
 =?us-ascii?Q?91RBz1g0j5fX+dfx5UpSucShiozNVeC1n63Djpx1FpzacHHzr6q1WiBWjy1+?=
 =?us-ascii?Q?hZGggCY9YT8JCz46dnLL23GSadX0PtZOemDMzYdEtvOaTCz01t/naJV33B7U?=
 =?us-ascii?Q?jR4gud8T0acrJSx5/0Mof0RS2r6Z/fmj0oxXbMoj5zZFTFU9xsu8QdifOvk5?=
 =?us-ascii?Q?HgMAxEhNfknzg21ktj6Wd9ZAOB2W292p6QwMWMg585xscmOWft+ASn3wHYta?=
 =?us-ascii?Q?sHK6Z8CjXkGdMAgfhV+PuuRDmf437AAh5mSgf5f20+eD7+7ULE/btfABFysu?=
 =?us-ascii?Q?kOzESebemqfUE72pmR/lPn2Xifh0pSY/hk4LwZOE3chb7G/QOYqqYsU8/FKz?=
 =?us-ascii?Q?UnLlYSSh8aOfzBPagz93+890xQnd68ldTz7lOcdDZzgbBo3aHA/KF36nH3UD?=
 =?us-ascii?Q?TQkokeDeP7elCczTWuD9XA08tlXF9q2MyS/1kXJTGXcMPFv7cTKOvKcE6agF?=
 =?us-ascii?Q?VBLfz2PBqzzMyHo0Os42PEFOYWI1LEIuhHlnsGMv4X1oRo4dpybu9vavxKua?=
 =?us-ascii?Q?kDwlWN2lQTSAHvRc12GVMZ2YrLZSdqoORJN56dnJLldkAqurILbeMVVK1v/+?=
 =?us-ascii?Q?spYY2zD027F7hFYKXvbLqLZ1OUjqUMmv3RIUVKlJ10hGrptm2GwesW1J9A/V?=
 =?us-ascii?Q?3Qjg/B9LKJ8jkn/+pLgJutJge6OhpwaLR5ovcyMyYKFAyrXu9Xw8ffkiN2ux?=
 =?us-ascii?Q?Fdjvv4viGkR0leFMySeyz6UHf7BivIYEQio+ZsX3m4Ed6f2gRLb+uhD7X6Hj?=
 =?us-ascii?Q?VIgXagUkCf0RfDrredhVPJIJ41vvY/7ZIPaMXR/j4rHrxCC4qUpHFERIfm6H?=
 =?us-ascii?Q?DdkSdqBpAfQO1gFg81OBd0aaaFGduLcp8KOTmWvl6jbp8noo+7EWeC3w1Wh3?=
 =?us-ascii?Q?Yo+IQn4jOrUhKQ14GvHEeYQ4tRwOkNuhs25lIPGHtt5YdEK8WSFn580AsmKY?=
 =?us-ascii?Q?Hci16A+hicSAP4vYk7CwJRU6SAom0OaCES9R+o/JMpyf2tGCAAbkfBsxtYQ3?=
 =?us-ascii?Q?K8gqsQ+KiYBdl8hofrqeyPrc6ZDc3BSGSEEF+OsOdNe/qjZwrM1ThzBBd/H1?=
 =?us-ascii?Q?wRiV7RZ6bPA1eStTCa1m68Ux4b9s55J/jRivCeJGiEpMGW2Eqi24xUW1sZFu?=
 =?us-ascii?Q?w3mgMEOIdkQxSUjZ4qu1+BiEgf2XMc7Nh3Ja?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:09.2509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57eaf7e-2088-4d81-d2e3-08ddb23b9ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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

Unify and refine the userq doorbell object destroy.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c7c9f9e597f1..acaea4416ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for unmap error*/
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..dbacdfcb6f7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	/*Validate the doorbell obj whether has unpinned by amdgpu_userq_destroy()*/
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

