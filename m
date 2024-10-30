Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34268D7497D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 08:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BAD10E75A;
	Wed, 30 Oct 2024 08:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMTTXtzJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C244E10E75A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 08:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqqQhxYaFIWTpGFQlTaaCr6/VMH+z28E1ULCKtTGdortibzDnONbnPnB9P8Kk6G7za4jikkdq9TQO0nx7epZCKS/whb/teEq9udIiccxpKZvo1WEE+al6nYaeB41PvYbVAh9jlNF+wvpLYDS7QuQ/dr6SFpqsZyzGczNLbYa3s5qfyue8gM7UqIBkFIC+kHJL4741R9lwFv2njzj5mq+IT2Q/bZO3NKVzWJbsTNWR2Un7tTJvaeGuXZqotHkCwBB+rweXRty16afn5lfMi+mNTh6J9HhbFqLAtS8gnuyytWBczXXZKkAyByZqZ++0pSC9RhRDv9oFW1wth6O0rXa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGdJT4o+o5J0GZfuxiLLl54eZ7fbf4c7XZg7o8L/ZCU=;
 b=kF7ZvyGmVUufyQI5eQXOxpIdWosMFLY28YA+fTPKWbJiAOwH4M0LYt8kTAgOYkf0MOvyOh8BKrCMora21CYPG3WzSC+CbEpLGb1yof5MGrIOIttguA0ZBVy8d2A0j4izV6v1vlkHiGWkdazf7Wl5DM1XNhOLlFGbhPynLlM0Zt7wUaMva4jF1DkQ6aEh6ChIy8bZcWy6IP2sJ17oI2mPQnNeOr88yBusNWHCAFmr747Byy2qDLBnxyG2PobptI9dzknHyT0YQBy/HEvL70Uxle8D4rFyFXw6gZmQL6DjJIcbjRIH8fsOuzYH16dSHi/qCrgV7oQ+8+ReB6oQdTCz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGdJT4o+o5J0GZfuxiLLl54eZ7fbf4c7XZg7o8L/ZCU=;
 b=MMTTXtzJfgnL2lv3iV8diCHyzk1TzIgHGtKEi5Wrmu3vCKZU/XGFWEqLgC6fEO+wNvPVM1fFNX3uWeuUQNFpyp+ryU/UhyhkkbBKa+ZfGuuZEkXRqTXq3dB4R0ix2oTUv6UIZ68mXn2nIU8zHH01pmKeNPozRJ4y1El3NM3o1bI=
Received: from PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::26)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 08:31:34 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::2d) by PH7P220CA0019.outlook.office365.com
 (2603:10b6:510:326::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 08:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 08:31:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 03:29:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add compatible NPS mode info
Date: Wed, 30 Oct 2024 13:59:37 +0530
Message-ID: <20241030082937.3185224-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbe3e39-dab8-46b4-c1ba-08dcf8bd4308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lV/ZyF6Drx7x9uGJNKYod/zbhuX5wVKRLB0kLL0f2uaEBx5sFuIFeAd5oJlJ?=
 =?us-ascii?Q?Ez/J62WhPHp3SHeS8bDU67EaeZNaU5ANMg0arhqSoO9tdcnvSH7d/e1I9q1p?=
 =?us-ascii?Q?3a2waIJ9NteifRdzJnNNGivaPfuMfG78C6+8A7J5ThtxQLZjIGTBRxJGz5uP?=
 =?us-ascii?Q?i7pg3oFTx2eoTWImw2jsN7VUmQaPLmCo6gP0EGz3OYMe6xkAb2gLYavx6G7U?=
 =?us-ascii?Q?PiTm7c5tLKIelE6hBjN9ACgYfQGBE1HRj/fgfW4JdBlunKznSubpwUlMHpVx?=
 =?us-ascii?Q?Xh0jvHB5TUlO1eEUB5jRuW53vBeiX7E5OorYa57nIFJQqlP0LhbfHKqzLtXy?=
 =?us-ascii?Q?swDXa9/89h5VGqEADVl0uo4WYRmBceRuy+nhon9Df8DAIa9wlQrF1EZI+l16?=
 =?us-ascii?Q?mf37xJwGTFPkbtSViBe6TVfAbNfm3RjC8z89jQx2GrQ4tsVIYlbxuuqleHYI?=
 =?us-ascii?Q?N2ONWRqsgHlYy74rpknPXpk5ComYLZ4VSFo7LH0zBX4ttsjwVxPgiQzuWgXC?=
 =?us-ascii?Q?sOb+SalH/tEZvUWD/dy1fL4EBxvC/K2k2zubw85pqV0ZM7BjjR7TUpqfUb4R?=
 =?us-ascii?Q?rIQZeQMQ91hT5Ve51Irh9n/fKdFyZ9/21uGVSmPgRBT+bix73BnKCPxlhG7W?=
 =?us-ascii?Q?RlE/zDrw7H6prgUk/2lvoSQsatM+OlaeZoK8I7w9JZRRamlMA0GnKFQySqDw?=
 =?us-ascii?Q?3l00Ec1fZ3CNtZx7A42Avhh8eOxao+oO4Wut4BoWvxXusEhGKCBYhpaRlVbg?=
 =?us-ascii?Q?NXND9X/CqcRucGKFWV8puLcJ0YoOvf3/G1/MO6bpdg7nnSPERxjN8LB7j0zP?=
 =?us-ascii?Q?SH8W89dYH0Jd/MddvUzXwM+ipRHW5USFN3FyAcB8LZVkg6u5RSSk56JIw6/O?=
 =?us-ascii?Q?dOtglp3CKrxr+zA3nvll0W59SF/M4D+wmm+WWnxkkWTyR3HK0BSiYr4uui4H?=
 =?us-ascii?Q?YPYE4yKJT5jOexyWaHcopyQVZcth90yiJcYYDR+pJyPTK199sm0/Duhl3+fm?=
 =?us-ascii?Q?GAeWd9l9D6T5+y/uIMj2Rp4Wuh0O1u5czm/7KbOSZJa10zx3Y+MdNx542+9Y?=
 =?us-ascii?Q?ASMVQ5cwW6lrJKu004JYCUS7kK3D9gdCvDuwz/vJ55Ab7WFMrxom12OQOmuY?=
 =?us-ascii?Q?RHq6ctFgkTFgCp8+xy2cjypz5n1n7ma9qDcuTcPR6QwhDnez81I2bDkNvTlb?=
 =?us-ascii?Q?NPOSRN8NCljhK/vJVmIgAFLQyrR+H1aE3OceWds1W/qV6Pa+bsiT2eraxnqg?=
 =?us-ascii?Q?sX/OReRfB6qOw2sLuenJv22d8mFKJJeN4F45p+RHoPn/HgeUNLPLVPgIEmo8?=
 =?us-ascii?Q?TWRSlwUsnl5DddaUNtYcARE04cxX/CQ14LGb6/2GefpXiunuGeAFqQF22KHu?=
 =?us-ascii?Q?+3UnKOg967WD0qq3mSM3Vd/zFKZQ/ly2VDIjrwmZymcXd+QSJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:31:33.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe3e39-dab8-46b4-c1ba-08dcf8bd4308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

Populate the compatible NPS modes also for providing partition
configuration details through sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 7ac89d78a5bf..b63f53242c57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -77,6 +77,7 @@ struct amdgpu_xcp_cfg {
 	u8 num_res;
 	struct amdgpu_xcp_mgr *xcp_mgr;
 	struct kobject kobj;
+	u16 compatible_nps_modes;
 };
 
 struct amdgpu_xcp_ip_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 890976b7ce77..fccccea0d2d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -455,6 +455,7 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 	int max_res[AMDGPU_XCP_RES_MAX] = {};
 	bool res_lt_xcp;
 	int num_xcp, i;
+	u16 nps_modes;
 
 	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
 		return -EINVAL;
@@ -467,23 +468,33 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
 		num_xcp = 1;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
 		num_xcp = 2;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
 		num_xcp = 3;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	case AMDGPU_QPX_PARTITION_MODE:
 		num_xcp = 4;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	case AMDGPU_CPX_PARTITION_MODE:
 		num_xcp = NUM_XCC(adev->gfx.xcc_mask);
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	xcp_cfg->compatible_nps_modes =
+		(adev->gmc.supported_nps_modes & nps_modes);
 	xcp_cfg->num_res = ARRAY_SIZE(max_res);
 
 	for (i = 0; i < xcp_cfg->num_res; i++) {
-- 
2.25.1

