Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9357CE6B275
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 05:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D5D10E084;
	Tue, 23 Dec 2025 05:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svSpk8Ca";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AD810E084
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 05:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD45hd9AL00IliF/Zk4/8lUQl1k8+KkeZfTU2FWMBn2ntMXR5NOsGXdguSe8VtKa+/DaJvR4+zFk3mdJ0ls6NRX3g2BYEKMwtmh9WTfEs924YLnhhmVyRTZyYQQSTovq3mAJltZNOmaHVpEvBf0z7Widn9ZZTCt9cFgJp7fpQDsQ82O2J2FgcinFghJncuKdS51KCqvt0uk7TdDfaKh+C6LT1xqvVj1WY4ZwIvY4DKfUm4JhyBf9F5f6PJhqGpZbfp87pt+jYK+Xx5uovFJD3lv5M/v9DsWPVbRYrmYWDN6gGdJPigDMk6fMCycoshtpc7Q0uYJDq2E4z4Eg4ipwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPTcI3ughP1TVU4X7UzQ4sM77XunRaLOvrtF7RjLG1I=;
 b=R9v+k+BZ5lpNvsJBi063QVn3S8aNo9ZOb38YiO8Bogn0U/fvmHR0vHyNMdCNK9SEyS18ZBUMGPJ19Me2SvG/V9ZlJ1+Eh0BKu37gZ7lZWU77O+UP5QZmTcq9a6Ek/zlPnoyAXbgzbqfiTu6+c5ztEx9eITxGEfIDC4Q0Ghjx7F8jhkZDLU2WFEJTof7sf4CURXCGABFcN8eFT/WdoGNISlZNyC06kvQGwPNHkKFranhKIex0+J+FF5inn/e/4gvcC2TCKFjYd/BLeqH2QhJYiaqoQngjAhkNKGlD0OYCh4fNQutOjgRjpbUK6wU7v67O+71a3HOeV/MjbSmzXLzA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPTcI3ughP1TVU4X7UzQ4sM77XunRaLOvrtF7RjLG1I=;
 b=svSpk8CawKfOFjFUJ1vef7EgnCRXlwzi4F5OC63rxlvOi9mqj81b5I2X2ZiEETwY8xkYAxWVjzv06FpksD7JQz/owRdCXX0joUW7F2uLoruneQu22yCSHF9grUlCFm8UdisbA0rbN3TUqnNHhX8Hb88dQ5HNtQ1Tx8Xr6ImVD/4=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 05:49:34 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::52) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 05:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 05:49:32 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Dec
 2025 23:49:31 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipeng.chai@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH] drm/amd/ras: Replace NPS flags in ras module
Date: Tue, 23 Dec 2025 13:49:17 +0800
Message-ID: <20251223054917.1498759-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 8103bef4-985f-4db3-31fd-08de41e70c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BDi3uhMo+x45EXOYVBklC7He3zG2b4Jp7HNkaxvlYfeu4tnXVp2yqDFCQ+EY?=
 =?us-ascii?Q?ysw4IejnUJpzc531EzCwrFbTsfoH0Zo+pGOZPhrNDE8hZux73mHwXglxxbvZ?=
 =?us-ascii?Q?EEXecCyB+V61nLzqrD0YPbZWksvRrjPI+MBLdCdBXpP+uEhE7HmmBIkk/eZj?=
 =?us-ascii?Q?8OAQqFcF/ksvyFyGhepv9v0NcpIIMFxCNndRxZ6Wx/sbok21HdXH1IByZe9t?=
 =?us-ascii?Q?AZhIaY4oszJDmjSVqPz2twCy/4X+A+errUySDGEH+DLqb4JK5FYlIBrd2wee?=
 =?us-ascii?Q?VqOmJpFaRGjDaVz3JDeBGDQ+7T4/u2y32+FGQCSenM5OSncVgrwdxp/4Rtn0?=
 =?us-ascii?Q?3BeBs7QEFu37/cdGxV4287Kea6ZEgFyjaOLZd7+5YViDMEmG0UC+KORU9F0V?=
 =?us-ascii?Q?rRN09phk0Ijn/1hLWyf5ZLVhx1/YgzXlXfhvuJC0FYvYqIzR2DNAD4J7puIn?=
 =?us-ascii?Q?SXcuhAh50qGo6G0MK26jE0K2EC2kYo7EnXJ+fGGRnopvzvTSlxLNDLv8AoK2?=
 =?us-ascii?Q?zwekEK8biOwH7nVR3mGZRaFsUIgoc55QkJTMriby/LnnOJgZ3m80y0B27RTD?=
 =?us-ascii?Q?U8imEA7XFCa7/1yarTy7l+FlHepcEQSO+kzzeksgf+nulVbxItIGDOtJsjhs?=
 =?us-ascii?Q?0bNb18vTUpW33Uz/bsovGVGsHu2I0Azch919JqwxYt128wOrnpnK+WqO6klw?=
 =?us-ascii?Q?+MPyTO00LZFtH8GEERTXPgBW/3AoPMx0WQfzknL1aLIyYJQPd6z4zvC/brC8?=
 =?us-ascii?Q?Vht/6F4HNt2Ih2GuQgNsx7LxWkArl0OHYzPpY+ZwE+TAKoCKNtyMtzb+CHCo?=
 =?us-ascii?Q?wDWeubg39amUFwcJHpFsooKIZlbJyZWOzw7ACtJcCiZkogwatX1ylhJCWpMT?=
 =?us-ascii?Q?kZsE9Avdt+wM08tbMU87gjJbhxQqZ6VyLOLOJ78YPzfzbK188UvhnWR/8A5T?=
 =?us-ascii?Q?Pfu0PKRiZ70p3Fq0zz9Oft+Off0gY7HAJsu+OBiEzCwwFy7nazoJITIAcryf?=
 =?us-ascii?Q?DvBYcZjJymqqITcNqQJc8YNBUyC0IXs4wzY/RQjQ0TU6Ipt3WjAEucQBz/bY?=
 =?us-ascii?Q?aZTQLpuPiMzgsZpM9q7LYfT5ELj2dAWBL7GkQJ6cwjed52UvfQoI6QqDMQnw?=
 =?us-ascii?Q?sEPMvVSDGr0V4i8F0smuKYH2rvvGTKrcRa+/RDqSaCQriDCxKg7mw0tHFvLd?=
 =?us-ascii?Q?8ka477hk0TM+ghdZfheXqfFSRSnpjudcb5obRyOLTCnFxi4IQg3hqalE8PWz?=
 =?us-ascii?Q?3pWWuwJ/4Fw2PtU0o4rd1OJtwHEr8nmes9yY7l2UAWi12GyXY9RdFNiZqUWF?=
 =?us-ascii?Q?SqzW7FfNWQL4cHmG00CDiqw5+kMZ929leed8SNY7zZ9NUf2sew7P6mG0Aid+?=
 =?us-ascii?Q?3pj3AzzcyrSZ2rJaTaAWp2W0Hxy5H/XnvSY6nhlURaYBhtYxoy15Dp6OV2x5?=
 =?us-ascii?Q?GG+s8lz6OMptFdWJEEiwVOrP0dSVx8liEDMq/wVlpbNWtOmvjTNMBQgnwtxF?=
 =?us-ascii?Q?dAJ8gWHjOSeMKpt05v+7RpLNmdiM2T5f07nMsEGdXEvb4OhKgOQF7jDuAYH1?=
 =?us-ascii?Q?n+n2x/WBRdTCoXp60EM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 05:49:32.9679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8103bef4-985f-4db3-31fd-08de41e70c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

Replace AMDGPU_NPS8_PARTITION_MODE with
UMC_MEMORY_PARTITION_MODE_NPS8 to pass sriov
compilation.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 7e70560b590b..f2fccdf5e329 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -613,7 +613,7 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		return -EINVAL;
 
 	cur_nps_mode = ras_core_get_curr_nps_mode(ras_core);
-	if (!cur_nps_mode || cur_nps_mode > AMDGPU_NPS8_PARTITION_MODE)
+	if (!cur_nps_mode || cur_nps_mode > UMC_MEMORY_PARTITION_MODE_NPS8)
 		return -EINVAL;
 
 	memset(&record, 0, sizeof(record));
-- 
2.43.0

