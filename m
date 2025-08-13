Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726CACA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFBD10E1D2;
	Wed, 13 Aug 2025 10:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/zi6T2s";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A64010E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 10:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej+mmlo5RQr0y4x31lurJx2MU8WqacRTryUYYZ4GrDv1J1D8cR6deDduEoHAh+Ef665YCp/Ag2ixIAN6tY1ngAdk5hdkJ0WSx6YE5oQYxmG3amsQ0tkR2nXUOH4DhT7W1UWc9jFaCjSMTPtmykK9emiyom3fOmL1CYtYbGw1BrF4qprhTpGugALoLf0q3BpmoYpGMpgxGdfcNTp5sswtE2FLz5tmWgbxFZTfil75tywNpx55HIciAAGDUhROXOzZA1nkFTgLHZ9zCUOuc0CNx81k8ifHee+KfRBQ3dO/2q8/OiJF73XmQh1J0Oyqn1O0UFIERx20gjiIEQ4nfMhTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB2OrUGagddj7XD0uVyaJCo4AiBSsZtTV+uH6YSIa4o=;
 b=oRrYWqoWlCsFdKBtYfhGKuFRVqHpQ4vVuVThKk5zSkh65CBK8G65pCs/lYDqfbfet0TXPQgCVTqlV9Ud3jG8KS6fcEr4HH1g3O4D+elxefQ546SLrRkx/vbNBhtfLnFhTbYiWQbFXtRvGe2k4TkVDb0xOO0whssDaYXEi3NsSKL58+fnUq/PHRdKZaDVJP9Gbg7lcavD8/iozqhrT096WulfnwX5F6/ry8/T2DoZOJfNRI39BtqkGA9/YbpwSHSQ09YKKEW/fNdbiqWr78namS0nWLr8QnidnKe0aJccWL276l1Q2p9BNWwQRLG7QzR80TR82vKgOzH87HGHKmvtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB2OrUGagddj7XD0uVyaJCo4AiBSsZtTV+uH6YSIa4o=;
 b=y/zi6T2s2h8/1JkxBx4nEIVAlYbiHPv2ypCOrjBnGqb7FrsW0Tc3Wb0d6xMM9dx45pmOSdTVVUkEDN6NdkgqdpbikLdRcaDlDGM3JImzTEppSQrosaQOhkul5EbuirxIyjmxTgFrVwHrL6Nzy89EwFey0a2mCeBP9H9xqPgznWA=
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 10:34:58 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::8b) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 10:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 10:34:57 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 05:34:54 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/3 v2] drm/amdgpu: Correct the counts of nr_banks and
 nr_errors
Date: Wed, 13 Aug 2025 18:34:45 +0800
Message-ID: <20250813103445.264476-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bc3175-1d18-4ea9-d99c-08ddda550c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PwDdf+avBqTdPT/TiF3sL8RCg+YC2Z8yR3u0pCZWIMoA3iSV7qLCuRygNFbT?=
 =?us-ascii?Q?EqGDFbJFEG1sk0SrlHwRzlCs46r9pOBFyigF/f0rScg0EKJ+dar1vJTdIoD/?=
 =?us-ascii?Q?z5kfV9pIvX3YzLXSDek7cquqTTn0D1HATyqpQtgXGCvp6e1ZfhqF6ehjie1j?=
 =?us-ascii?Q?eLmy57U1ZJCRnr5VPOWnKUCiouihojqcGwNUfrPJJoq2hJSSqlsCvKzMFulf?=
 =?us-ascii?Q?n1J9yo75PIiuU2yQSM5+4PviVLnmozTbNHbP/HcDzup78o+cnBWMBnQ3VEQ2?=
 =?us-ascii?Q?FCZ3dkbjf6S/+lMWGYnXEeS2LGCxCHA6RmhshnOzIYEo3WA7SEA+82bH57Jc?=
 =?us-ascii?Q?8B8VBD25/ApZhJ/6RzDo2hCA6j2R9TBPX9kTQDjfXoA0uI+6g7X0HVGYWnHh?=
 =?us-ascii?Q?XSy1eowOCyktie9t0xvGby46R0ahKJxl8hmtOhhMg6nmhS5GZMWks1aCQZ71?=
 =?us-ascii?Q?FakVBjwIWAoRXi+8k4cBM5vECF6XPkMsZuI5Lg1+54wDY9aRMfo2bbCPJhXK?=
 =?us-ascii?Q?oY2YkR6mdf2olGpo1EDbJTipRSqIQ4pBJ/RpT0Nu0Lt37lcuRWkYW+nAO7PB?=
 =?us-ascii?Q?GqYd/mHnr+mjC4rm/CktB59cdJX2yfbcDi1xPg7tpF5nraDBQPvsfqsJF1nn?=
 =?us-ascii?Q?3bBhZscBxYIXcAHC2BbobqUbRaSSIBv3SDRplPiHSdXInKyf6QC3U21fvXGK?=
 =?us-ascii?Q?wjuvw2woxJyqQfjMQUndNA6ANXolnXtzUM8/V25+moGdrvrg1mjPjQkm5Wxl?=
 =?us-ascii?Q?bxQuFRZyhjy3IB/iPqTP8Ocjb0dXp0cOA7ezdAlgG+aQ72bbxd0VHt5gS7ba?=
 =?us-ascii?Q?VINAzgIVR0ilFMIz8oBGZG2o1K/FYj1LrQRhryGutvnRoMdDUBoYezHgBQpU?=
 =?us-ascii?Q?7QSblxEpJnPuxrSzqnVD13VvZ3dw8mVkNrptMSC1DD5GnTB7P9xoS5wdWaov?=
 =?us-ascii?Q?pU1UddZaO1niFtQBL65CkkKDGuFEa1NWGdkXGcTgYzQ6G9ZeCcdgM5Bfj+RV?=
 =?us-ascii?Q?dUBhu4/D0UEylN8jtAhefhVJSpUFPLcr8xZ8xpcxEobbC1Ti2BV+BE5RqZFj?=
 =?us-ascii?Q?gFFZWvZT27iYQzvBpWWBlz4hv9/uBM1idHF9LBL4n9C7eTY+XPNOul46eZhr?=
 =?us-ascii?Q?J3w7hDIOLHzsPCedmE17mQES++QJCAetZFytez2jLTbiidiNSPsLvis4+u1y?=
 =?us-ascii?Q?13eTCEeVc/P5z1uFQ61KCdfeFKuxmfbHdihl9+DVQcL2ZxRVWJ3MW7H42G04?=
 =?us-ascii?Q?sF11l6QcwqP/zn/YMHf9Ha5S1AqG2E2OoMCEVo5ESIx5tvKCWi+jKyBtr2/i?=
 =?us-ascii?Q?WWaXzfcyYs5fCCKumIOvHzNSDO5xZrHSHixGnqYWksSo5/GDqDjDt6yGuydW?=
 =?us-ascii?Q?OdWXspAkHfdb7UJ+TH8/3NPUKzjn5S0M05ps6CEsbMAeYOfBCTfboWib6l65?=
 =?us-ascii?Q?XG3Hlyt+etrLg6onDD1PBACCcr1nyDbrfwx30Xj277rRWTONEf0jckBY4oQQ?=
 =?us-ascii?Q?Bj0LLKhWNAe5Drp15N9aaiCO75QWRqJM09/Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:34:57.2700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bc3175-1d18-4ea9-d99c-08ddda550c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

Correct the counts of nr_banks and nr_errors

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cbc40cad581b..090bf6cf1b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -76,6 +76,7 @@ static void aca_banks_release(struct aca_banks *banks)
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
+		banks->nr_banks--;
 	}
 }
 
@@ -229,6 +230,7 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 
 	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
+	aerr->nr_errors++;
 	mutex_unlock(&aerr->lock);
 
 	return bank_error;
-- 
2.34.1

