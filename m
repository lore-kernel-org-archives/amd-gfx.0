Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF22BCA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D4D10E4CB;
	Mon,  8 Sep 2025 11:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y1C9GW82";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69B610E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWovMVegsBIiLJEn/efj09QVJQq5d9aChDcMURbXkDkT0OtsILksKjfo52foHSCo/v7/3DHKzxJ7JuU63PXvF5nnaLsU/HcKGKftdzL0sVx2aIogUqc9uz500B1ymkoDApgny3sbcRC+Ze4OvqS+KfxVmGbSsHsVZqLuG9JW4DeQvbNHpD6TbkN+Mb9MX+n34pZPIK8Efwt5s6iXELLQH1pBv2aeZskglIAgvLo1k74/ACl5BnYIbvg/PYncwrGJqB+EqDkHvAMslk1ARk5HUSQBCd1PyopN92636kYa/GDM/hzSOCHEvE2XK0ms46Rk8hPk7S3EmqBycl1exht9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVX5ZrtkDpbFHXRs3y5KKYMmBSA3p/Dflwu+OAhgDQE=;
 b=K6K954l0L2YeSnlKcnDnlQ14Jy7I9yBKiMSOA6yVK8mp4ZFsNqaRM01XGF+vvrBfndcxaSdBJpSPvTYuGinLzi+1I2WlXeu6JycgTUsDBAfLn0zuRJrfR8k3SdKqMmgKcvqotTKCgD8HaVbo3kxW7OTSbH2C5z0zJhl2401DmjX2cracZaLPpFwRMeHwwv8tRe9oa2gNmRY//Zkp4jBZPD+7umz3+YBRZVrIMfHha78NhLpRSiNQ5K7/UQnSz8lTLckNnmIVVXiSk8r/XDsI8h7LSafVz04QVvxM6FLxy0wYdgVPFlwsQGhzbXpgdulik3Z0+q2pTll4lgL3Ry6YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVX5ZrtkDpbFHXRs3y5KKYMmBSA3p/Dflwu+OAhgDQE=;
 b=y1C9GW82V+g9UwN8Pnrai3SxCyD2vPv1x/0FU13F5qOOkor8S+MEJdhxQsyfxLcC5i+ICYAflPZqWPYJwacMs5nyS9Xbn0k+wEtNkrWfHaOG9gt5Iii4ufEfFa4UJ6RkNe3g5vk2iQxEupK74Ni7Gk48ojP0aSN9iJmEkvInDvo=
Received: from MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:03:08 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::fc) by MN2PR07CA0008.outlook.office365.com
 (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:03:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:03:06 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 7/7] drm/amd/pm: Update SMUv13.0.12 partition metrics
Date: Mon, 8 Sep 2025 16:31:18 +0530
Message-ID: <20250908110231.2888628-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9105bf-8211-4955-b849-08ddeec74b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tIBTfUQXAkg7E8q7a9D9UbZcMR646JRtRgefG27jCL2wduUSFnuecyf+pq3y?=
 =?us-ascii?Q?2YuC6SoPr7G19ZaTCrd++NTYq0IAQb9kZQpetfc8eZljdXxq2IiIvsPm7O3G?=
 =?us-ascii?Q?CMeXnqrl/adBljN3zDjmsDiJ2QiwME0pIdoKKYEsn01HvIRW3lXPuU9+pDKM?=
 =?us-ascii?Q?3dvkdVHylmzrdZtFBUckoDLdDlPmy3IKN/7p0jic9A88FX/rmkqBr+xCofce?=
 =?us-ascii?Q?rZCrqCunWzabk3P/8GSPHLI6EnXiMprrKJmqxd4f+ns4o26HTAV7dtDUWeR+?=
 =?us-ascii?Q?4EVZY0hoLFYwcAVo0dBjjCXy9IUK48OFBzbGUpTISKlsXGj0Y4MEd5SUNIFv?=
 =?us-ascii?Q?anv8ulxdIFqTJRl5M15mPHhK20IHuWLgOW1pkkZgjh0gZGbiFXYc1ug8hvLk?=
 =?us-ascii?Q?K3bCK9yu9dlaUFLba5qFEz53pBH5XUBoiI2v2eWiWoVFEztFF5YRacgJN0ce?=
 =?us-ascii?Q?rchiPsU5IN2oFxbgGy/cYmXh6pEUxK8QmmShcD2VhMptfm2eEArG4aks9IRl?=
 =?us-ascii?Q?+ougr6DogweTnU73/Ls+MaSRpL7ldavG/HdgP6+sp9ZWjucVmUoEr7bxAoSo?=
 =?us-ascii?Q?ODNRhM6OC7pjEA+t4PyO9FJhaq/0eNr/+3DRAvkfi+ANwiDMu9JTHqGUA0XP?=
 =?us-ascii?Q?YHIdsz/Erl1ApgYTcxp/PZMh+ejCLKDcGybrDkh1DV5px/hJ8lu13V6BIQrg?=
 =?us-ascii?Q?su+Mrs2OxkPc8i/8ErRdqhznKhkPtC0/amlPOD7hKZD89RrODC0KQuKbfQm5?=
 =?us-ascii?Q?ZM3ZBER/9NJipq/rdcQ6GNYd2eSdX7DX+YfRAMqDidkZjUv+4uSFW+tGToxb?=
 =?us-ascii?Q?f1UHMfhKzkDOcgJf2i78ph5UsKW934nMgCTwTzHvqeawQMfeVL807DB7cixF?=
 =?us-ascii?Q?zAmAoM7WBo5FRgCtdffjSUHgMVrpZem9RaNVuAdcxlA2bQ2QVQrwwy8eXEiO?=
 =?us-ascii?Q?xfZSn/ZGuhkgT7yhk7c5HYfE7lf8ZOLf7IwyVAuk3S42Ojx6Jh3ouJmdhCx5?=
 =?us-ascii?Q?2648QqkBWQ5UZN/30QSLaOC69Ww5s96q4NKaceQpKY1oTVkoAEHJk+nAXrth?=
 =?us-ascii?Q?KOQCO6BfFpeGstRA97+BKIWiB1tgbUqdRGyKChfyuhX7krBsHav7kEAdHiK6?=
 =?us-ascii?Q?RqbLciNNLieyDWNBizJK6UUmmTXTx5xWoyG8ofKGVHLJQWsX75Aj/BOfNkR2?=
 =?us-ascii?Q?EX1huSiDEnzfiQty/ggqvUv91A8Vge80jEpqfkcwrFa41cwzmLVC2f4tCOo5?=
 =?us-ascii?Q?Ns4RPK4qHlqJx7Wq71bnD1ulex2d9rezI/nopJ+YY6VRUNkfkTGgm5FJgv15?=
 =?us-ascii?Q?XVzLAfe8fBjbX3aN0qUUc9FjPErVZ8zWNoOSJanocybvvKzTZsf1VLYqj8Gi?=
 =?us-ascii?Q?qw5jKseOLEoPAk8QSmhZfYBGL9HWWQQDZ+zfM8YLd6xqQbhy5RVhia8/oi40?=
 =?us-ascii?Q?k7XDra44qGKJoNBkHduyBpwwtdi2iW83lgEk6IihiFI0vHvrBrYRaPWUjNjL?=
 =?us-ascii?Q?lGVv4WG77VIFEBhsnXT5yFFdnEJIrIwVaPTm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:03:08.6464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9105bf-8211-4955-b849-08ddeec74b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792
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

Update SMUv13.0.12 partition metrics to partition metrics v1.1 schema.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 09f1e4072db6..2cfc221dc3bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -671,15 +671,14 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
 {
 	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTable_t *metrics;
 	int inst, j, k, idx;
 	u32 inst_mask;
 
 	metrics = (MetricsTable_t *)smu_metrics;
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *) table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
 	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
 	idx = 0;
 	for_each_inst(k, inst_mask) {
-- 
2.49.0

