Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE830D73EB4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDD210E04F;
	Fri, 30 Jan 2026 02:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5ckqiee";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E19F10E04F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi9su8evIAHRwjQUacpng4zpHnAl6cMJGGFS7QLpu1d9kj59F6iBELf9rVK0CS6hV/cimIEQjy+DzmG1BNnZBoSkrJO4S1nMEsXYnNhEXvVfR47apk6lwFtntQYQI06FPjp8flPLPd1qfUHRBs/BdJ6OCaRNHkKfGMBH9TrSWtctQqOTR+W7/LcajOlFUG5MZiS7yDUTaHTy3pJGJ3k1SXT9fl0F8SxOYKxxlKoACL0jO+IGl4LSTdWmXdFZTq8wqIeqRkwlEuXf1Vmk3G8Df4D0RPLTaXu1M3bwfs+cLNQYOutNL6gsODllOa8bNxE78chEKlbWW+HZliGfC5U/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zgcmZT3WZ0utG1xW7rom3SyP7Fd3f5TmUT1rC2CLG4=;
 b=Bpd+L7jFq4R4A+xEL3FOND4W9JawfISquiAYZwxkI/SgCdDI/RsaNCOjjgS6TDsoLcGnBoaIp1uFVy9JSulXX3YJAToySu9VwISj/gj5YehD7q2G9nZ9VH3VgTUkthp45Kd3Pdflnoj/DbbcgoxqWD5lIic+505bScInITSWkpvIReNH3R7BdSMalFsoMHG3l+QjKVbii015JVAqNbCIdQ/1gtUbC3RFjoDYc+FeM6MoivVMzih/9y6onxkvMWxBPDTCuCv8Yx7sL4r/aSSkvbdlJUPpmm6A+K7lie3BgERegYByjZBxb/P3N9LEGEgGz4HkHcmeL1UqT2/+w88m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zgcmZT3WZ0utG1xW7rom3SyP7Fd3f5TmUT1rC2CLG4=;
 b=B5ckqieeClasyJJW/Zi7klQU/x+q7fSiHRciBjAl3nUPvpAS1TSBm+nvrfb4IKfqlJuylktlkb1MPD5ZqrfLmXyVhZtQDxSDMEFEh7aTqVq5wjT0da10kOEPj39BqZoWtDH2LCtjLoboQeGavMMm56+ZxyqqI0WQH0v7fzWnT3o=
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:16 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::c5) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri,
 30 Jan 2026 02:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:16 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:12 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Date: Fri, 30 Jan 2026 10:29:37 +0800
Message-ID: <20260130022950.1160058-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bef074-32a0-4196-eae5-08de5fa78108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9WbzvOxp48aBs6ja7Y7VgrWTG8qkRdZh0At1511VggQ+ILwP6FkSC70lrxhg?=
 =?us-ascii?Q?sI0/3uKDm1KsYHfCfIDSl6ChXD0WdY5MKRn00g0yoUgaHqhJNPfMyq0aXtFw?=
 =?us-ascii?Q?tAMvs5Z7q1QCY4K8G3pIdRjzbwpatgJjZI3CjUgSQa5DteyFgu2gOkCRxnQ6?=
 =?us-ascii?Q?MEdsirzbh460rESXCqu2hgtjaN4WqnKQlhFFU2rT9+3JaeR5b3yVuRqZoSb4?=
 =?us-ascii?Q?AoCEOKQIO9l/4kmlR+ca7RO7BLRggfcJI4WZy309oScB9On8jnuJz4bh7iYH?=
 =?us-ascii?Q?Pe3miD30Cuv88ramLAx0MNIeFNqKsAsbKUikZNGthmZ5YUhrQN7gXcyyrkCY?=
 =?us-ascii?Q?1ofDOeyC7jKr5hxY64UoQz0vDvCwUHjc+FOPr/JirfMwOxIH5USYPqk4DnBI?=
 =?us-ascii?Q?UMepm1ta/YLh3l2pC37Le1eTAvKEgGcPfqls/6rU+frbGl2jTVJMPIZiO/Lt?=
 =?us-ascii?Q?Tbq98UiqTMUoRdyVDbWJk0t11kFfRL8gTM9GIA3CJDTX7HdByUcZXu5rCjT0?=
 =?us-ascii?Q?up/GBdejNIXxG/SwTbD5P1/RbMJjV56ja31G2Qfq1Ky2r8rellXMLnWFS2oE?=
 =?us-ascii?Q?+R7c4yVKZZdkZ4aQrp92BVvZai76TXW+c3tYEkxO6PWcfvWWQ/PyEaJ9lw6W?=
 =?us-ascii?Q?OnggNI8TOLqUXDZwoQ8MUwe7KpjrcWx9EJHP0MteI5+hB122lGWMCGEMNl+6?=
 =?us-ascii?Q?PpmRQpKsuYiz0KCtnP84Oax635wZwrs097xLK6ISBGsxKWkXW1WZP94pUKe2?=
 =?us-ascii?Q?RPqmAb6q2kmYlPuhvBFlfw4BckcJuO4XDOz8cZCf5P5g0XOCfhIBUpS+3RHB?=
 =?us-ascii?Q?bAkdgWZjoH648lVIHdAEXF+UaLvTuXrVYpVBsV/Dj7q2YS/GLARSghnlPs5C?=
 =?us-ascii?Q?2c2XzuDW0rnUii6BP5o0DmFyqq/TSNFHzbHIKe9F+AFAKBkC3PbrwpyqGKaU?=
 =?us-ascii?Q?C2YIyHZyb31VOT5qO8Xg4qdJL+J4GLW+xARUbYbmzc/mMKOK+pzbiZLHmlM6?=
 =?us-ascii?Q?iC2TAn6sas7GGgrm3Lntt2NmjVNCy+zdusVkJNUoV+PEMIfH72Gfk2mnMbfe?=
 =?us-ascii?Q?Tno1dRHl6Yfal6RMOhtqzd+sU2mfUEUUCuIci8e7wpcZcP0oJVEq3dsllykT?=
 =?us-ascii?Q?v4rQ9msIwW6qMgkKKlgzl8fZPGtmErsU59lQcdu4gGMlaX09hKNlShRfkXm/?=
 =?us-ascii?Q?PJrFPN+meonryBM9+Iy0MvYKcI9FLaMMePMM5DcwMUPQOTmGbTPLEYSK9RXY?=
 =?us-ascii?Q?U02mhjPd0mI/lybybloEZU8i7OovuTwZe/HxQfOOABcZFGTUqxOsaO0D43RP?=
 =?us-ascii?Q?mtjw49mN6K/L6xnv303l7OrLYr0sJnS+sYWKRKD6ajyai6sUUMldyV4z8Bby?=
 =?us-ascii?Q?7mOKuI+P0+lqf6jWU/ybH0nE7+uIPHR2IpR7OlubgzjEvCLbTf+OEgDm7OE+?=
 =?us-ascii?Q?1S4tdi/YYydjOlKNIGFS5VMnA9cartMCKAmNIYZGFPIBaOParolFwaLiOIK1?=
 =?us-ascii?Q?oKXkPNxhj9q1NvRHCKzn9Fn0/CLk0290/F+Qn0NCG6uAjCd/8k/Ea6XHsIzZ?=
 =?us-ascii?Q?l87tRTE2rnK90b9w8MYxdUXCe3I2nC+lEt++ZwfE5P3fsX7/HZ85Wtsn2XoJ?=
 =?us-ascii?Q?F/Qjuc5nWzSHRJVEE1Li1luZHU6gAYzFrCKM/LyPqoQd3n6dSIO8CgN3Keov?=
 =?us-ascii?Q?GUgvCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nAnNU01lJ7AYHVSmEsJh5BliAFRJtdWItEO6lx2oX0uG5/N5mSeXbkX2sK4I8RYrKULLXrgJAi64RbPp+RY+gcCVMJ4mGa0m1R5GA2XVWF5zyp0KNEVSv576OicuhNVuxHjZF8GitwQH9j3Bpdl8MJogJkA0OOiVZV+qhzcBFrQ4PJJ2peJWtaoXKD3oKhRFtvvJCWkrWxFMt9LkPOZrx1YCPl7/7zehwwUq+9UGZpRJwKWbwd9PdW/zZ+7QM8sBhpmVAbZdWJK/zZTmxGc249IQ2Vtz4+V+jZ4Xbok0cyf32zfAbXtFvHRbav6/On44w9cA9FGoBVKgaEwCD3p986nLM0fFtk/I8zNo+e/N5v/ep1jGqNfrY2K85cALJjIt6Jfikb7amCKFT9M4kStdnNwRY69iwnuS45oNji4vYDzg8p+DtIFiEeGPJCDRElvI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:16.0783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bef074-32a0-4196-eae5-08de5fa78108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
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

add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 57f4069bc827..0fcd6a1c0e92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3499,12 +3499,22 @@ static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_ty
 {
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	switch (msg) {
 	case SMU_MSG_QueryValidMcaCount:
 	case SMU_MSG_QueryValidMcaCeCount:
 	case SMU_MSG_McaBankDumpDW:
 	case SMU_MSG_McaBankCeDumpDW:
 	case SMU_MSG_ClearMcaOnRead:
+	case SMU_MSG_GetRASTableVersion:
+	case SMU_MSG_GetBadPageCount:
+	case SMU_MSG_GetBadPageMcaAddr:
+	case SMU_MSG_SetTimestamp:
+	case SMU_MSG_GetTimestamp:
+	case SMU_MSG_GetBadPageIpid:
+	case SMU_MSG_EraseRasTable:
 		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
 		break;
 	default:
-- 
2.34.1

