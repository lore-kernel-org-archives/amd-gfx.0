Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C5EC87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F18710E800;
	Fri,  1 Aug 2025 08:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0KcuI9G";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D44C10E7FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvq3TIY2N8qPN8JMvgQbuic6jHQwZ/Z0cp/lRwt54B6yxvEOld5CgoOSJ9VaeehN/CuuurIGd41AqC6Wg9tNCY9xxvfPzjy63o9pqxjxrgwYsBm2Got+TA1nSs9R8G18J1XdmDbzKf3beuYKlkZj3+p0PlrDq8tOIN24l7yyXJ+M9uKFY/fsCake4JcWAj+2yp/CIxR1xmWtyii4NCJk6OhsO+s9UGadePUCnIyXriTbf87G+80eXA59Ivgb6bnfWSAUHApGhUKDfnuYXHbRtx7KAcFmH6yZVdFLZupYekCPqMIekUeH5zIdPT9AKDfj8XC0mFOEiM7KikJm1b4j2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR6RjxEGMMij+Z67G4waPp+nmyxL/UZuBqNhlGRsWKE=;
 b=U7JSRANm92qtm0ZMBWdZ7OyNu75Pqk70Sxdu0dlF3mqs50Y/hmBCp4OyLN+53vL6Oh82dLR7+oyi51FPup6ne8MvCsqi//UdBiCgKFNgTSgp/ZRQClQl013oCkp17wnuw127rohPRALKZhxDhi+bKN3KZ0KNtCEpXPQ9CYoRsNvB10uKSyqVmP1/2oDJdFr9nIa9q3sil/RhLIxgGpQ1PsBIxWcKkuOfRQsKFZeZVHz8pDY7T/nT65eAIDF97i+IyVP1gVceBrPfOeRmopIodvdzsqoRj70qVLiXQdwQXSs/GbKJPszId139UHO3WNu6Ab+UCsiJxA0zIplTq0CD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR6RjxEGMMij+Z67G4waPp+nmyxL/UZuBqNhlGRsWKE=;
 b=w0KcuI9GJf7BW5K5REobw8NnP+ofR42ppjd3SEAJ616vqxQ2/rwVz/QH6T0zOTi1whL7gmj7qeoyylPS53LkvkC5uiG/kqHgcAPWtSXK57Zqwa2g4Ni6S3NgI3S7QJNLDO0MdEGdmATNGI3TTnkU9CT7AzaRfhPGtVNS99mX9E4=
Received: from SJ0PR13CA0061.namprd13.prod.outlook.com (2603:10b6:a03:2c4::6)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 08:56:25 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::39) by SJ0PR13CA0061.outlook.office365.com
 (2603:10b6:a03:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Fri,
 1 Aug 2025 08:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:24 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:22 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 03/10] amdkfd: find_process_by_mm always return the primary
 context
Date: Fri, 1 Aug 2025 16:55:49 +0800
Message-ID: <20250801085556.8504-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 971fcad0-c2a4-4723-c13c-08ddd0d94b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eqVLl6OKDKfJl+NPVcuP/8GruygrKju8r2SGEXWmt16m3Af9MnkdlEz9BEep?=
 =?us-ascii?Q?Ca6t6U+30sr7twvSwBJvnSzzcPAkX+5eslTYO4w4jSUgcFjU1t2sd+mTYZz/?=
 =?us-ascii?Q?FkQPJbv1RXO5nOw71fXrO8MRSsKL9EixrinqeXrli4gbjAkQNqu3mzzlpy4o?=
 =?us-ascii?Q?5pafIwwiBgW/+0QitegYzGxfb3+1di24xSSZ9tGI4AGnA5NhNKK3Bl0gCacj?=
 =?us-ascii?Q?fXv50nUuzORy0h5OI4My7H5fvtc0py3kaOXs92Ojaht1fzHZR7v2NXNvV4tU?=
 =?us-ascii?Q?+N0ZzX+JNav0Xv0BxVr4XYGWni6gkkDV3R0OykkHuoKzTIEPP+i3ptbdJEm0?=
 =?us-ascii?Q?34agxG6aUGRgef3uy8RcdkwyI22FJX9bNl/klp3PTjbbCdTyX3CkPe618m46?=
 =?us-ascii?Q?GHlNfa5nUQtgs0H+8jGloAz1jS1ykbdjXgD/09O+hZGmqlk7j59UQiZ6gwQW?=
 =?us-ascii?Q?wZAeNjVbYwYfasSEqFFNMYPkaWMY9H07GJJtBQTozGSVppeco/gavKxFSPaR?=
 =?us-ascii?Q?4WK+7TCjFHGOSmvJU5BYanEnvQulPHzICSauAKuUtm+Ukk1mC2UEgxKjhJMN?=
 =?us-ascii?Q?mBh3MXlxnHCY5Um7lQMbjaIgUQPHJPv98X2yoJDBz/Xc21/jodKoAAsirK1l?=
 =?us-ascii?Q?qGVx48jQjWej0FB7/XfXlWB92CXBdR+IcYl9onsdKjxt/GmSsxLQXP+nj1U9?=
 =?us-ascii?Q?KcRNfuwAv9yo6lKLVHry66oahsz2b1SNf34QVhkLZRSngCJucacNRf/8+5lB?=
 =?us-ascii?Q?mo3T4FZl4gyQuPA82/rezMRPLUY43Q8pNUtWGUEHCDck8hvsyK6WYIeau8NB?=
 =?us-ascii?Q?zKrWt407sYj/cqkyeh5h30eCwxTfcBefUsYELqldTsoo9nLRe2TBKaCo2WHF?=
 =?us-ascii?Q?w2HTN3y9LPLfsHlxS6JulF1m8yPb1QTwakleF6c0gVwkErlLyTGVLKZd8FpP?=
 =?us-ascii?Q?QW+yiQTN2wWEDdnkfRRuGiXpyplHGnZr4KQDGtncsGyHhQIZBMh6Tdhgp0Y9?=
 =?us-ascii?Q?WhtbbIMPyu3R7NhO2sByKrsuw01VgveReOjaq4ozmON2jVSXciIy38VLfRbU?=
 =?us-ascii?Q?iYOO5Xj8Nq6BQFCF3izBwQSBlFVp8318g/cqZ6aXXssLxZFiauS1g87Kjqv5?=
 =?us-ascii?Q?uw7/F2vrUWIfeaO4xZIyzdD1JeVmvM1FUjeJMTiW0bYJgOy9bus2hwtob5r3?=
 =?us-ascii?Q?7a73x1UHlvBnA3opeYVc71rYF4yaUbWMgrLXKfHF2VYNxleC1zL+/D7dybOL?=
 =?us-ascii?Q?DC6XwL69FII7zFnPbc8N+sQ0lZ7TxgdXlOkgBJEhd58vuovJKq1UBGl5qI9S?=
 =?us-ascii?Q?7mSrpyQv04yTTvx4VGdINd1ssBtIzVpX2dOBjyoBKBDpLDxrpLK4egp5LO8f?=
 =?us-ascii?Q?O6Ev9tVWpa8uec9IxE7IBAu9U72OXtH/Z2+qpPYM1HerJUVRLqdn23lBIgEk?=
 =?us-ascii?Q?6qSh/z4jyD/3gDpgWXm6WdjvxiViXp7m7LVlza3EslTbpGTgdy/epFsoFpjD?=
 =?us-ascii?Q?V8utW83v3h5Dx10WDy1u75HXtXnitMgg+fCq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:24.9333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971fcad0-c2a4-4723-c13c-08ddd0d94b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

Up until this commit, the kfd multiple contexts feature has
not been fully implemented in mainline kernel yet.

For backawrd compatibility, not break existing use cases,
this commit changes function find_process_by_mm, let it
always return the primary kfd_process.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 955ca8725bc5..3f4ac9122203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -935,7 +935,7 @@ static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 
 	hash_for_each_possible_rcu(kfd_processes_table, process,
 					kfd_processes, (uintptr_t)mm)
-		if (process->mm == mm)
+		if (process->mm == mm && process->primary)
 			return process;
 
 	return NULL;
-- 
2.47.1

