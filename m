Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1CEC02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 03:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0391410E160;
	Wed, 22 Jan 2025 03:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nauc5/qU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCC210E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 03:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9uTUWuxQcZ5FCAtIxo9S089/SiBLDGO3PquBci0LRZmgSuv5rB1SMrUDuIpu8+v9/F3VZNFCBtoqyymJ4BCQvHVXIJElZijhdtXtmEuXHTZoV+CxaqLHpiK6wCA+zMD73ozHyrUnVDat5R9RESLYb9LsGneZmEiCCS/p1GP+34Dam5P6UiqXmLuD9+BsaTIwT5GggYmBtaPdjahpJq0eIGVfMsyhQeQ/A88fPbV/+VTZ856T/QsW40+dh4lP9zfyDyHvHhSxnXSOi4owzTf7PHw+zop09UKaePy2Jh0BMW/QT413Da4+HOYkMFivnWTkf4iSO30du7YQ75z3NJ01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ+FdAm7hlnPmlBvXWuOJg5gLmd9GaTSp8Rwm46BU2s=;
 b=ruzPzX+ZMAnTK/jahXtHKrqGdNalqb/2P2r6/cgGPf8CP9bm6/CsReJZXGcBRMp9UHtUrkQ360sxTJjnSoZ0tbpERBNOBhIRkPqiUmV6UP7H8YCCRCrpZ/LIRtCQ5NyFI/qZFgRfVnabeRU/ICzlGse8twuR6qEMtdbDLquE1cTBsOOVQs1b5U3+UbSiinnCKVSgpFIKC5Rg05Up/51sbA5Vm2DlB7HzgW7exroerRBr8r34LXEcMk/fdr9EwSFdTBGXLelRY53/Qa0t/ktBy7m1MRLny4QcAumsMmKqhlGfJvk0Mp9JiquVdfUJjdBCfeC7RxYnBAxfCpWGWSlwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ+FdAm7hlnPmlBvXWuOJg5gLmd9GaTSp8Rwm46BU2s=;
 b=nauc5/qUQmZtiGIfGqDhVo2drgeC6p2AnPt1uHUX04w1htBLC5zYQZX6VbU6LU/sP4vMJXfPDKH/N0OaaubKjzB2BQZhb0zj1zbnS918sNjEUgD65Duh7meL2+pTEBCOA31OW5ORhJm2zQWAo2Iy+sg6F8nAlEezrIEEEJ/vI9c=
Received: from SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 03:45:42 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::da) by SJ0PR05CA0115.outlook.office365.com
 (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 03:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 03:45:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 21:45:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm : Mark MM activity as unsupported
Date: Wed, 22 Jan 2025 09:14:51 +0530
Message-ID: <20250122034451.1578850-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d031d46-25b8-45dc-106f-08dd3a973e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQeMYTR2I5hLZXo/d+zwm+MtkpWtQ/mPpJWI+ORM3bDb58UAj3uqp3bIMEgq?=
 =?us-ascii?Q?IAUF7MKZgbXLn/62lZA/uJ395FUtR+KOvOG77xRosyeYEGIcvITqcbnTzw4Y?=
 =?us-ascii?Q?xoc11RRfaHFMjzE5emGZppB1SmnLPov6mQj1Zc313iI9omj5Jostp0dCO8eA?=
 =?us-ascii?Q?s1N5EsaMavYJHCjWHBwJ5Tl7F2k+jMomvPec+UoIyPgRG+CMelqa+kESzBdq?=
 =?us-ascii?Q?hFEaRDpit58lD33dv8hBNgjsuzSk35aXfpZRd9Z2fj04+xevf6gEsX3gx7Dy?=
 =?us-ascii?Q?F0MapEeltR7GyhQWnhq1tCrNhJmwumgQxmKuX4pkqaW2QmGIXe36WGIWaCWu?=
 =?us-ascii?Q?8LrL+/1S622N+gwpp94p6zroy4dC9Fn7lLtNwdy7uT22fpKv32gUH+1iUWvw?=
 =?us-ascii?Q?P0L0YLH/civ+fWYw397blmlXUYKyhXfvhxlvKGF3cy7H9mw3bxzBMoUfAZAh?=
 =?us-ascii?Q?7XA/5LvqowM6plArEDkVwgx+vay/33v0aWiYCKr8mmZg1mz8sHjCdhQsI+dS?=
 =?us-ascii?Q?0GHPOygaY/iEuhgCtxPMeMSnOjTcY/qpljnJbupiUEQE8hJEqX1rKo1QTqfX?=
 =?us-ascii?Q?PmY08wbzjpWMJFOhg3VsTw9y9/m/E7nUQFx9n1Q1qGGOB3fZqj0I0CTOc+je?=
 =?us-ascii?Q?TXPpBzLOR6ttFUGWTWIooqByxtJn7IP1fufwKrGfYooy9xiz/0bpyJu6OPey?=
 =?us-ascii?Q?voiENTFXJkTJuE2vOi/iv4F2gfTgELE6Rielq9UHLaSI2LuKFt29jfTNryxX?=
 =?us-ascii?Q?2rw6H8Zss7vDMXu972rFAYG2bTxHTzYNoNNrhAFt5W5jzuQC3aQZNImW61Zt?=
 =?us-ascii?Q?2dTG8wz8pxkw9KGsowXKgbVEBeY7PIOqcEpqZ9iNPiNIXgsmzNzwFvEfVTSe?=
 =?us-ascii?Q?oTAuEjshiPHd5I0ru9BtOu3UzPZZzE+4kDrSlCQJP9RDJEy3CPbgecTAmew7?=
 =?us-ascii?Q?qbOTbF7hdjPTsdmuAwezerricCAuekig02AmK6qP5Z8BEz/qmmnm0zRHE+7q?=
 =?us-ascii?Q?9lE7sS9YesxTnZvV1t7rxVJ09mN8YySzMKWtuFCiQ+XG9NJPSWARdf2nGDYp?=
 =?us-ascii?Q?2Fb5JFLgVFK4W/LV7b1nXnGH9MT3eumFPlzBFzUdBrcRQZcQtka6bHUxbgOt?=
 =?us-ascii?Q?7gwWz+LtwIYhswdXdar6TR+1t9b0s0BMBvG8177USWcUIMEuHeoB1cN6XuOT?=
 =?us-ascii?Q?No1ZQKfUC4KO6UPOlggmilm5F/zQ6J8Tw3K7cldgfv7b1/N6v8OgFbAEb+Ot?=
 =?us-ascii?Q?LMf1KaWpdeEwuOCmVWBeO96N+s+Fe1PHl+zQHpswvu4CjxA5ei9GMo71lxQ6?=
 =?us-ascii?Q?u7N2kYCdvPxJEf83EKxzyLW+xKJwu2ry/tLDmkv4KAzBlQvsDTODm0+p77Dw?=
 =?us-ascii?Q?wGfBLear5qrQX2buom9zAYp+6JJ/AdiV2Muucez1yXJ4YSHbbhoh6HLpvxWL?=
 =?us-ascii?Q?6mnmRuanVcS2NInncihTR/twHCoZm8TTDGBPKPXcTQZNwCn9bc8/xT0fSGCK?=
 =?us-ascii?Q?97Vla4qvpbVSqtA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 03:45:41.9738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d031d46-25b8-45dc-106f-08dd3a973e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

Aldebaran doesn't support querying MM activity percentage. Keep the
field as 0xFFs to mark it as unsupported.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f6b029354327..83163d7c7f00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1732,7 +1732,6 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
 	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
-	gpu_metrics->average_mm_activity = 0;
 
 	/* Valid power data is available only from primary die */
 	if (aldebaran_is_primary(smu)) {
-- 
2.25.1

