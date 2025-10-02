Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B29FCAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1486410E1E1;
	Thu,  2 Oct 2025 17:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5prWgcRN";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A11110E824
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=triA+gnI1J4uQbRYcVqvy09qVtB/DRY6NthDxKRRihaBg/1e0ltc3lB5q0Elgz823zZtQPX+gvq+3Tbg/eWVRx3sqa6BbAc0krIT9mw6Wb1CqkC9Pd988qHBukHiq561SUQuURu2XvREsX5Q+FeoWmaTVoBPIFL1csbO4NdreoU5m4fIYQGWMsnsrAG1mFQqfNeL0LnaZ93npkMplBMnLgIzEOcrGVClD9nuG8Mu/qSMarD0+Buj1LLUzNIEWTG68/IoJtFWMhiVxwaT2sA1KYDxFaG1rrGCr5XAl5obMwMJX1in6ayGaANuadKQtQ/mYX6H7EUXGtXgalW76xaFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hmx1LsalOtulYOdX3FBh0ePBtpTFshaZKRwoA+J1Ck=;
 b=a6APnJO4MblALPQ0qcHAvYabhxTkwqNQwae6VTKuyXJ5PHhmO3FlWfahUnRbtQohZWcmnuAMavgAAT3UIsUDINVvLk+wbXKJBjrHYIC+1LqhgW44oTP9m2Y2cYCLuo5+BvNdKHxsYrFMDeO8y5ooquQrbUtZPymYYI64rEu9KOcsFDq9D3OjzVl1qAvCKWp5/qGlVBcvwIdIgPtmMjwoozJbnWuBiGcqqWJBDqgQEfjFBWcvt3AhDUgUsXtmQ/9STs2ZY7IWFZSHm5ovVPfoOC3Yw7R7ZltHXzhavOPnP7W9EVtJI8Dd7h+nQVvuF8LVC6m78PqfV7IUhuy4glBt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hmx1LsalOtulYOdX3FBh0ePBtpTFshaZKRwoA+J1Ck=;
 b=5prWgcRNWq5uVBaImXqoN6GpoaT+jFR8pXLYZb2t0ap+kowApgEvL3Zyrf0vtgbANumPGyvV5GxFb7cdHVGFBHZStg8a95j0HabxIcXB1Zi18JcJDe5ugOOGJBBedEkK6ItSSvo1caedDJO3VUHjRu2d+3FPpko+1Ri4EzQ5+3Q=
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 2 Oct
 2025 17:43:38 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::6b) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 10:43:31 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: svm unmap use page aligned address
Date: Thu, 2 Oct 2025 13:43:06 -0400
Message-ID: <20251002174307.10583-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251002174307.10583-1-Philip.Yang@amd.com>
References: <20251002174307.10583-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 855a5ede-7dd0-4466-1583-08de01db37df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q4aOcUBEAWFwIRWAVmRfnm/SZKNZYTGefJMJgLENOomL6iICxwL2GrGzY54a?=
 =?us-ascii?Q?Foan6W4IUAEkCDW2cJSSRTz+72s/Q9ds8nhaWn4TAi0Wip87Mw1P72jqLo6J?=
 =?us-ascii?Q?HRcUoflfjJYTbrQuRxQO7NiC13vDxaK8UUrreSIesdpkotgdsO2amU+TXtZw?=
 =?us-ascii?Q?Snxf5lYlc5Y2f+D7U53q+Eali4H0HWQGUTm9k1ShYpMaWnIEI4H7dLQPQQUv?=
 =?us-ascii?Q?DsSkcuzeqK3gx0JyK9R5Ie4ufklTQ5TN9kJKSwHlIgvZKP8FxXzUZ5/97O0I?=
 =?us-ascii?Q?cJrM7SMZ/be8R7xVb6yhIiwYGGWR3yGSQWNiwY6451KLMFpaXdZtwFYEhQyb?=
 =?us-ascii?Q?xA2qS9wHcpHpykwibrtrowDqlQGI+05V5k8NsxqhvBrV/BB0tW+YypPccAQF?=
 =?us-ascii?Q?TTQXPF2WBw0T1nvhHreAVVPSUk1jQ/Wqti6/3zVKcqsYiOSvZ3tzX33zrcA6?=
 =?us-ascii?Q?yfJb51JUEzR2YedpfdQGz9e/C/MuJawqhRpwUZO5xpSFALL24VN56wS8joka?=
 =?us-ascii?Q?E8XuSnhaUF7TIM7xx8giomQHZqzKxc5hxSSDzv4SA+09bfshFQGFzo1sTFYA?=
 =?us-ascii?Q?cpK2Iak5EVdH0C8fdjxZ03mmUdQIu+xmVymBp69eo4MPW0f8ucNTlhwfv5X9?=
 =?us-ascii?Q?rf+P5qWdN6hWsDl0srdSVnWqG1lCH2PVaCN1wnPX7dS5atGzlXWAz5KK30ak?=
 =?us-ascii?Q?rpN079wiVFAShXmr8arRHvWc53y4FFG1mGzKMHsj31PjCfkeALlnLEZAk6yy?=
 =?us-ascii?Q?RhOrULRLGc36SZZetZvbPDmybML7GFBH6Q3/KoD6TMzN33iWO2CnVAq0oxTg?=
 =?us-ascii?Q?cdSrU0yhXcBe6qd2Rke5pltK6STR5cC9CWVmKTHVxxL6hnvWIKKpHwryav8D?=
 =?us-ascii?Q?BycC1IKLCYf9h/h/IiTng9TEx+jSBf5wkNoijfFc6IcXDDyGPEpjW5+mgDgx?=
 =?us-ascii?Q?bj2ijSK37jJpSUunWzefHNk7UWXVyoi1l8AFzQffl6wsgnV49XchOwnBiZOE?=
 =?us-ascii?Q?MsEn1XUUeVeGYSRfVdOKydUnj4VqRV/o/c0RNkWc2tEzLCkE8DzL7F4Qh8M2?=
 =?us-ascii?Q?O2Zw3z5yN6aS/HAcEglUsaIe9mAi3O6BHd2l4OVo7m57ok65ijjivYCxwOpH?=
 =?us-ascii?Q?4YpX7IVYGud0s8cxcCmhxUSe2QTyMBU3uv155JE9dBrzF3avb3LROiLxdofH?=
 =?us-ascii?Q?/7klF/2juH1cUo2nvtSRLHs0A7qOcPjIoQ2+HmfIeDZF0P2tBQb52ynYw7UW?=
 =?us-ascii?Q?kF1XlXWChl69jByaihlJULzSDQV83wRQSram5GJwOq4c9ZZ8XfcC4wutHEF7?=
 =?us-ascii?Q?jLurdIZKMqS8zgA6nAPVutFfc24Rr6SmBcOBBcPmsNMTXVx7r4dKELhJasuv?=
 =?us-ascii?Q?D8njSbYAqzBc0vvDMpU/ncbZmxAZKRCc4KRapkL2XAqidbUmyMz5CswzV106?=
 =?us-ascii?Q?cwkuuhwyo33X4Ic6YKcFxWqXWxJvOw6xqpbJfq+VJTaCG/vCvUZjqQeTCgAA?=
 =?us-ascii?Q?KUqMwH0aHmCFU99w0eW4UaVIt6OVjzEUBDof/1AT4ehxeDTrLzv2VYHa7XxY?=
 =?us-ascii?Q?7l62Ksrd1PzZBO9enmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:37.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855a5ede-7dd0-4466-1583-08de01db37df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

svm_range_unmap_from_gpus uses page aligned start, end address, the end
address is inclusive.

Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e8a15751c125..742c28833650 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1723,8 +1723,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				svm_range_lock(prange);
 				if (vma->vm_flags & VM_WRITE)
 					pr_debug("VM_WRITE without VM_READ is not supported");
-				s = max(start, prange->start);
-				e = min(end, prange->last);
+				s = max(start >> PAGE_SHIFT, prange->start);
+				e = min((end - 1) >> PAGE_SHIFT, prange->last);
 				if (e >= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
-- 
2.49.0

