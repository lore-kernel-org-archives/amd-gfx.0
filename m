Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0804BC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 23:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761DD10ED06;
	Tue, 30 Apr 2024 23:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TfBKnLh3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7315610ED06
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 23:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIiip6qVa8rUtGtbctGuYE5Xjd2lLkBzCULcbt3wcj9srsEoDy5TqN15RP28eZltMwJ9mUjy4N+8a35rGrXAFVLowUprSMiuJ9zIylro5LX2tC7S/2omPjE6XhB1DiXwzBYHLziYHGevBpOOdlM51XbIEzRvPxpIcHJYsuXBandMaBJiyrNlRutbOjx7YzCdZPTtQgkv4pB9fVBBR4uOT8+/QAhz4fgjFk6pW3hEihXKmfTsf7wjxQoRLqRvVHNRnxv9EE8KciCWu+MevmQapp8UPXqVZJbNDmQEqoHh6NDuGsfPLDCovvqWKlwHaryCr6OQM0oMmjyEazUh9HL+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDxVvO1+/o9Z6kv6JjyNEoOMbw4yw0ZlCXP0Dv+fPl0=;
 b=XPYA1yhzHh7H1vJD2/0kipqNcfA7yKMVIq28wAKa7ZA9/ygxQ9IrF7bOJtasqYuyGsvzZbKGBIsrXjPY65xfLfBqMT7SVjRp161+uLHl4S/bqP+Q3vE0NeGbl0AmTCCk7FcpGdMu+RZky7x/O4ws0WV8DZZgLs1QnJoFsnC7E6tKYDUecw7NPELDjfldEYsIMMfIRny5tFdT7sr2p+KFGhOmiZSw2YXfIMGJhK9AliibqpXkvkD8CotbGQBd+NKRpBmohMPGnwpxFr+pU7l5XPA7jAPXZzGexBWnXFCEEI6MgraknzvNosr+o/QjyYF8/S4XIRoWFidhLBtIhtf7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDxVvO1+/o9Z6kv6JjyNEoOMbw4yw0ZlCXP0Dv+fPl0=;
 b=TfBKnLh3KjjvCQasZtA318tUujFgTvQ7NzxukuZ1qW+QIYH7jfHDBz3VI2gWHlLdSWGLDOuUdEZjkQNt4Idz4cqRw/UxlSeKTWY/vLX2y2y1yXNqCB4GCVbUMck2karh7QsEHrRiIeapeaCvfj0z+PkH73EbO4mtOydnjS2eH1I=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 23:29:13 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::f8) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 23:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 23:29:12 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 18:29:12 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Date: Tue, 30 Apr 2024 18:29:01 -0500
Message-ID: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 043dd6b6-2bf9-4c70-46e8-08dc696d57fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+RMQFBHiI5Zh2JriQJYt+ziA00ZBwah/ISAOoyDT0tLWW8Opqw1n3+YERug?=
 =?us-ascii?Q?rIBtikcUDQXgD2fpPptwPPuwqk7W1NphyYu48GP3U5fEfy6sPtN+buHQuM0G?=
 =?us-ascii?Q?qf17GJFbsvDMszZPRQGY89VJDtYjDEuSZlzXek4CQkCult42cMi8wpqVsT6T?=
 =?us-ascii?Q?EoiYSEO2F3uxZXWgWI7lmmEV1gI+i23rMMwLUXOgxld4XMvQqnKUwzsPpXh4?=
 =?us-ascii?Q?FrfDZ4lNAdH7FSZy0/Vds/VU/2F3RcY087hvkH9Ufgh9IOsOAwlnhHMkKgJQ?=
 =?us-ascii?Q?sBKvu+L2vGoKXuwmzoAflwZ+/B62TJMS+DPGffaM1DOzdt8LoqhwTm664AzM?=
 =?us-ascii?Q?+R2msWlhNZ25lP9UZHNxgfC9DtJR/0XwQ/nVac0XgSpsZkV4bUKjolW5JQ31?=
 =?us-ascii?Q?CfH/SOFHBSR/E7nu3q5RZZSS2m3eb3/Llgo5sAyp4H3R6FVcgdEzGjiktL6d?=
 =?us-ascii?Q?9JHr7OYsxw/JI/ESc+sXjfCW3Hv5p90YtuPCmVEmu2TiaRh9kTsgBAShy2Yv?=
 =?us-ascii?Q?q+eYyJz1jZm5UnikzRAn9mC0DlOupEdMsP3Z7oPXOb0xtKh8rohHROhV6sLR?=
 =?us-ascii?Q?q1UtfQjrk4JrAwQ+3N4Hx/ScAG1vEfozYCi+dUd0D2LPqTI4qzhHHlhksA3P?=
 =?us-ascii?Q?icxVuKh2eRVMJ3oMAuKoyreyyETHKS9BOS4s9CUgI38/2mLWwYs03gEqbX5x?=
 =?us-ascii?Q?ERLua96A4umlXb70aYCJzXN3UQfDAWD/2Ne5Gwm8bJoJyk6jlmZtNzcYL+aZ?=
 =?us-ascii?Q?ox/kqWAYPjUTj0AD4APo/MXF7pHRhOszX43e+MF9/XWyZ3OeZsllUmBvH8Do?=
 =?us-ascii?Q?Rgj5t6Y+ucfBovDrZMJ5vQOuBb3XMntWOmf/4JkgKBW7PQiVvlDXWeSN3WH1?=
 =?us-ascii?Q?pX56cs1gN/W2MS/LplV5F4axPvk6QXfOM1ZzxzBpnjWYP1VG/LtEUFs0uBd7?=
 =?us-ascii?Q?NF5uhSfPjH+VsVVi4UXmflb5K3SSKWFteFRRLfuTn/PcH8RuR8WeMrl0WPTk?=
 =?us-ascii?Q?u9AYUP+zD9h95L9RqVS1SXYV8JUd8ekBjm/+VFuHVqGtRGeBhl8e8UZ8oHRI?=
 =?us-ascii?Q?Ou2m8PVeYI0KPTsMHtShMlMADQXORRnyxrGrILiD2CsenxQ69IeSaIErloOW?=
 =?us-ascii?Q?d5mWSfBVeXCcv+9ZDg/zf8tgAhx+YzS3Yzab6KZuU08LZicC6IAjXQSOMau7?=
 =?us-ascii?Q?EjP/VwftB/lNQ+zB+BO+vWYh94UNsLV6bFvHoJaGwoOAZjy98gFO1tZ/kB7H?=
 =?us-ascii?Q?df+ZuV4Z5Wd89MpwcusiEryllpLtzVsi3e1la+IlsqzXqYHNvF6rCzyPOlVe?=
 =?us-ascii?Q?LufbX1a8Go/4a4n3enEiaEvTTaI28N9e323b0WZf1h+4ksxH1GC3Q2Y3XeTd?=
 =?us-ascii?Q?GBw+Xt98yce5Q9QrK/v1Czd9WVHe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 23:29:12.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043dd6b6-2bf9-4c70-46e8-08dc696d57fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

Analysis of code by Coverity, a static code analyser, has identified
a resource leak in the symbol hmm_range. This leak occurs when one of
the prior steps before it is released encounters an error.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96..dcb1d5d3f860 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	start = map_start << PAGE_SHIFT;
 	end = (map_last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
-		struct hmm_range *hmm_range;
+		struct hmm_range *hmm_range = NULL;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
@@ -1696,7 +1696,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		svm_range_lock(prange);
-		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
+
+		// Free backing memory of hmm_range if it was initialized
+		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-- 
2.34.1

