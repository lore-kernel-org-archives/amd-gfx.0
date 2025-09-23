Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EBCAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BFE10E574;
	Tue, 23 Sep 2025 07:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLzoRxQf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF0710E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzLTnbbr7OaNSTN7XvccuuFe/nrqXfYk4Lfa6JJSYOnT807X8CNWazDIBkg/NbvdaJnxCY3xj0gApYdEUwh1Yvu6y9pwkyd6zxH4291UvNcw7axFaWW86LZIoeXGCEb+YJM52okXUXEeaVIj+yPs9yX2msYElfuKSqxJHfSmdI1cGGqTHGDVOlVsyLHeploP9tf3+rjHeBQr/CRmNfaW5cUlFCAX38lZWPzQp+ChLcIbMX+5FWANRGstf6djA7d12dT4qdr6YREvsTQQeu/mAe29zQBEMPxpCKbsZIQSQWkoeO/lqY863sGKfznijCdAcBgHo20ybskMvzCQxcv4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhcgJeZk3pZuEBgwoyYr/c3eFu1zELXOGYeq3WmTRKc=;
 b=uaLJVKETiYM9/XTZcYIkNwk9yrdwrMgnF3b89VxYQvm/DRHtsyZILgF5sslEPehiSohRMOZ6TZayzcgc0SLq5hKls21FbQTvdkt6w5YfnjehmQWm/CCXjJBEfUh5Hzdk/CYR9sex12KYDvUjue5Uh1Fb6tQu5xnqpwxVSIO7sXen57nzh1UrNb8XYoG4Crz3a6h/a5EIy5XIL1eaf9ZBjXAiHjE9LzHBBwvKAhkwKyrU87h7rhixxc6axbIz3tAZaanYwXZpZyrllbMA1/sailVQul1GCy+Vb9dI+bngdRrNMT4sdkf1HhNmuaCsvVpBfruCkSnWzHePiZ2QGuKW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhcgJeZk3pZuEBgwoyYr/c3eFu1zELXOGYeq3WmTRKc=;
 b=NLzoRxQfh/r2fRpcdSzZKcpvJ7JvVLiWyeBhRGJW0hO7B4wN3rBs4UKDGwnEJ8T4Z2hfoEkbsB6TN3MVXND8209asfKX4YTIfxERsZqZ/utzBnwD4enVfrABpUvxMMDFfwcQwOPuvbpfjEDSYb2aqw3CfLOscmfZp0B+sehkc0c=
Received: from SJ0PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:33f::16)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:40 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ed) by SJ0PR05CA0041.outlook.office365.com
 (2603:10b6:a03:33f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.18 via Frontend Transport; Tue,
 23 Sep 2025 07:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:40 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:34 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 03/18] amdkfd: find_process_by_mm always return the primary
 context
Date: Tue, 23 Sep 2025 15:25:53 +0800
Message-ID: <20250923072608.252345-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 45525a58-6b63-4dda-3c85-08ddfa7289fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0WBK6J7TsYyD/t/v2QHgtlBh6HDMVDAFNc4J4Jo5b/KrIXiu9a77Cs7zKG0K?=
 =?us-ascii?Q?uWW2owQKomDhmlKu0gH4cmTvBm80EBdhj65P60op86z3SOGAWz5JBhoJRFCs?=
 =?us-ascii?Q?5N6DQzqvG+S2cAHxU9PzvzpsRFnt2dKJTvm7RMLO/jakiuRnOyjRzCCLaDDl?=
 =?us-ascii?Q?ZbFy5lqnlFygK53xO6FdkbEmOTdsr11jhLo0XmeC12ftmxVjFmFZp7AIpJ3R?=
 =?us-ascii?Q?qjMxrp95G1A9q0TQYOGKI2adyLuKC9bugogAFLXGmn5Ri8ZtE88gBKXnUPu+?=
 =?us-ascii?Q?ZCxdv6rlfaSo8J1eTuH9s04T1euqZ0six9XMSi79Sd80B8gs3rDniFTQwZJW?=
 =?us-ascii?Q?2RiO+SR3fofGOxK2LMENq3s7gvTOEbmarkLdjNg8Yojo8ciJs3ODlcDzTE/E?=
 =?us-ascii?Q?sfTW68fYHNA7RKwZT7Ail25qoBeCRPGZrKTFTp4QNoFcK/4Cm2NkF/H7BwOY?=
 =?us-ascii?Q?9TboAZu58vSJcj7PTCurNkLiXnTndFV8yWINT9KxhOZ6kjbrjoVQhCHWg61x?=
 =?us-ascii?Q?/yo5cK7lQPszb9DDILWFOIu+JNcD78cp/yVEN9NEyMvWzo7idrHZW1OaSiY+?=
 =?us-ascii?Q?fOvfvLsxCY6R1HZZoOA0ahKpC0TcgjBAECTIkwYLYTo0M2OAckbZKP/l+oM/?=
 =?us-ascii?Q?d00eJJ8Z3aj8owzRwVKPPgr67FfMlJ+RSWteLSSAt4NMSOAnLUgWQcwntxXd?=
 =?us-ascii?Q?r359Qxm+ktWCcrzih5mVgiDtPxIAioIkCMdF6MUlG1B/u479QqlgYQp5TgtP?=
 =?us-ascii?Q?P6KG+wgjcyTnivj8dqDySjrni8P3pFln1WSlOMrrwJot9iJg2xNZyS1F5+i6?=
 =?us-ascii?Q?v6LftEHc87r8F41HOd/6lMFnyV5pADlgRpqCoRDcUBySMfL1y6dnHKp1C9V+?=
 =?us-ascii?Q?KSymNGZCGRkyFJZw1WV54RoOuMEyIhTLupNhVxxJpJ0kVnUfT09ccBdpEpPz?=
 =?us-ascii?Q?j7+LvDHX9XTTguE8RuCr+UmiF5dmxyUUoIvAjoxYBgA+5lwpgMJSEQZOvtLm?=
 =?us-ascii?Q?uMMcJMd0FTr2X+f6ZEET4svtn+MeUvg5rS0dLnoK9UBotexH8hsqkDBhsd/p?=
 =?us-ascii?Q?6AoF7Oy6AKr5A4Qz+ehbCb7tR1eO/jl+FhcCThvVxR50hGFO7JEvAhK2Yg89?=
 =?us-ascii?Q?qckg++Wfo5pYmYGA/urOg1UDZuhvUGqtnfkX8zsBwMRv7HSKPO2WtPJv+Uq9?=
 =?us-ascii?Q?8HvU4wRUSfQvmKrjfzgHiu70NuqFSW2Q+rgYLsGrJpZI1T1HtpV5cNPW68mu?=
 =?us-ascii?Q?5vMN1u6xdo+ixvOY5dlOid8XlKkdeQf1AC9MIlv3SnpMxhHDZgi7E9SVhtio?=
 =?us-ascii?Q?4Hghb02N4Ul310p2miBCAqOJ0VsodiFEU7n6Sem2Tj+uRK/+dEXbrW3RLAGg?=
 =?us-ascii?Q?FGQH5vvxsYLQMMxas48kVFyNgQ25OCWDxjpXDBHBDr54oSoqpVtpf4yc8Qb1?=
 =?us-ascii?Q?kRoJMvcguF7NlFAUPNcvnKGT+oqs+ykm5wH4o8u8k6lAjaeAUlEJlL549oGV?=
 =?us-ascii?Q?Ys9ovurhgTFHGT1RlRqffJ5rGAVoEovBDqJ5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:40.3467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45525a58-6b63-4dda-3c85-08ddfa7289fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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
index 762e306d85db..88421e57a072 100644
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
2.51.0

