Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96446C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DDF10E545;
	Tue, 17 Jun 2025 08:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f3XSosZq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FA110E534
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4XSwOgh9VmBKtzrhMhEEInx4XOj1fcfmfsBqcGL0JzAsQ/O5TDk71UEiav3ED5zOaVA94PHLFfubrS7owWZvTJYaygWDhL3YV8/XnZHdpKGGS3KnoCopa1TCszilxG13pDV5Lyq4tej6e0nAYcEeh7ioTBizR5gQ0B0qSdVaRSZiGxpB02lkMDJTjN2neQpUEOO/MtFTvk5UR1a/RfmLfJjYkb430HJf5IatIiGCUxa3rjhI6yftyJqD+psGh/tHO+ExhpLTf6qTLEsPiT9KoRZ68VzBDtQSQ97y2CMlAddL4H+PIJAtBF5HhiDMEplPMKlHcSV2g/SwJDezFr9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7d4cCHx2EmcAolJc3S03Er5x3731Q9USVsSaAAKxHU=;
 b=nf2Q0tHS0Nv2NB1sNnoMBh2/ARXNhyECzZoNU4XjB8FR7mWQJ10jTfh6+XHp1B4FH3fh2h5M6mARLnePqFapqqrx/pp1qP4Y6cMWveK+K61t+osD09kUrNUhuTVYcU+DCo/Ly+YBf8yevpr60jp6nR3CLF3cWVpjJ/3Q0ixtq7Hkp/NvzNje9CaanDqXmsl3sYHYUG1RSB74TePrnaKPUlnERkx7UwuuE0JWHhcn0t6RKJiQs16p/PJ05qjyjQYyC78kbdqYFX7I2nx6pMPrEzBpO26jLuvE7I7BMNYYX3pDuvTgp1/xyf5NQHkbKaXjNtxmz/UqQfn6ayGMG/3WvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7d4cCHx2EmcAolJc3S03Er5x3731Q9USVsSaAAKxHU=;
 b=f3XSosZqUpcyTmKRjNrtCJHvADxgGZDSgntrhd8nEvCjKNhMa4mo0dVym61Jrh5FCZZF1GhF7W6SquEicrqOfo+ZLNQzo8ePwuiu0x6Tq6UFtYp/4YmxniNMXH/iA73G9lljGJNho5kbVGV6JRnBzXCUH6TrSfEhP1cylbssUek=
Received: from MN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:52d::13)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:02:18 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::37) by MN0PR04CA0002.outlook.office365.com
 (2603:10b6:208:52d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Tue,
 17 Jun 2025 08:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:17 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 03/11] drm/amdgpu: unify the userq doorbell object destroy
Date: Tue, 17 Jun 2025 16:01:43 +0800
Message-ID: <20250617080151.1093481-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b803639-6f45-4aff-998d-08ddad754784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Apn/2jPxZuihyeKP+ihI7Aa5DXYM9wh3Poze+bW9Io8LIitwemUEE8380rmw?=
 =?us-ascii?Q?63sFG3hyp58H/PF1DjS90aQQ4XXd/q4ewDp/IcNBWN1h1VtPGTdNICNixiq8?=
 =?us-ascii?Q?mU2IrImAWk+eD0prRKxlrEoQwima+5CCfePsRoL81K2ssoZCKyiUlvqIP2IN?=
 =?us-ascii?Q?ulsdxpUtTPegHMjdhGJa2+4PQW2t3palDKi47GLvTNmhaWBmUcE6ZL9AVFXY?=
 =?us-ascii?Q?qjsC4jOMzr1bd9FowXOz3zLIABUS+FTn4j7X/RwQEL7zA0AiLXMBnMmZ89iT?=
 =?us-ascii?Q?mRyMXs+36eL+F2Z1VQoRHVunQWzYqg54NQud00Vq8bFb352HrXehHBwGkCdj?=
 =?us-ascii?Q?OXdVQuYq347WdhT//NM4ZDjVGfrpcWdOooGlEIjYdRP2lVvV4IXDxl/3bUYm?=
 =?us-ascii?Q?SUzURM0kx3GzZiQRPFIbqsrnJ+gvjClYqtZg3FUTGynUmuaxepZqBRoiViPW?=
 =?us-ascii?Q?LGW0wKvdJlTJFeX+hnlIN6E4R6kuxtVDZFvt9tGeQ8ecM2uLYlrDQTS+wv6p?=
 =?us-ascii?Q?BAEmN0c+V6ncyuOlklH3PVrOuHHQl4hjKjjmd5z32p9+bkJG83YMZbS/RvXU?=
 =?us-ascii?Q?qFCEo3rzAn2do1addznwMBcujyDsLDQb+4zd2TmU46mhf+ctcMOACZmSzuYH?=
 =?us-ascii?Q?pbzLvuLEvIQxJNpajRJMC7ngkmcbUAp40e7gxuwkSPMxHfSXpD9QwlsCenm6?=
 =?us-ascii?Q?bNYVLrg4ZM1Xrcgb6xVhs4W24NqGDGKdk6vwecgzVU6Pc8lns4kJcZqZS55S?=
 =?us-ascii?Q?zf1CRkO6ny5IyzJ5U32TPAiap9Xo2RyTpADr6uMkWzUuXaGJzNyEWA95bGZc?=
 =?us-ascii?Q?TRlBZNv2RCQKOW4cpB1rRG/OakZb3BybodJ5JV6vSatw9HpIySomrLEclLaV?=
 =?us-ascii?Q?Ug30KdItqXp3OGUSGAu4TBrryOUK4BVNCW0ujjQPtZBjElqeUOz7iNbUPT3E?=
 =?us-ascii?Q?x3PQNiBGpY8RvBv5YgCV5kBSFqF5Rm+xfUHzxIrm7Ufg5hoobMk18ycAqzep?=
 =?us-ascii?Q?8u6JlSVX+CB/a/dveOwrxDGl97H2SbUS0LmYWDZ4y+h9Z2K2wOapFX06eIsO?=
 =?us-ascii?Q?PGkSAfv5GXx+KHssKz22Trm7cPcB1zQX+52NAj5NyS3i6Giu1E+SzUKgDxOC?=
 =?us-ascii?Q?e/ro2QFMBrPwKIVC85Nx/hsywQ/0Bm/Nw53bYoJ8r1CvN3Xx1F69018YggkK?=
 =?us-ascii?Q?dnvnRLcCqAhzp/O1AX8Qu6vFBCt5RAMXTG0ojmgcC3S4kl+FVUhB+Oixtyww?=
 =?us-ascii?Q?UgXc9dEreAG7UQtphiLdbFkJcbRqwcYR00+UUsQx96GACiMjsn2OXz55GThT?=
 =?us-ascii?Q?B7peXT6tFbA/tmFwgkMuq1RN05+i/NjDU4RbVYpQ+rTIfCNn5pmJwcP+y6+z?=
 =?us-ascii?Q?85sVUQ0XsNoNy7kkrqhCZIriqZ3sHJJfjikO7sGX1UuSdMx6b71P2+RtBzJt?=
 =?us-ascii?Q?EjtkswVu4h1biHM893MAex0V1fYtuzJlXKdzubqwPLUnFio+TnmPW6j9rBPM?=
 =?us-ascii?Q?295iOjIV69G9yzV41cJijC1AEzYhbs1hOE5S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:17.8711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b803639-6f45-4aff-998d-08ddad754784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e3cebe532c7b..dca0f76c9fce 100644
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
index 39decc0b00f7..c6f7b613e684 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -343,6 +343,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

