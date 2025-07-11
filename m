Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E34AC83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7C510EA01;
	Fri, 11 Jul 2025 09:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PHhaYGr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5455910EA02
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH5vm9ISmS6apRF/eOwovDj3kIKKzrNAvAPe/Luqo9ypt1jvqdl1eeuaHsnw01w0o6I3bMrnJpASkTnNMTlDXM8bmjKeybGEmqa5l+BWZjX/mH1ESFf3MboQLQDSOlhWbxQ3DkNXS7rtD+706KYrHRu9A+Rs4lH3vDPzVntbx9O/8c3qglQCbkRjQAMLAuDSvy6LY3UnnVewffCtk2kvST6x+yiyBB30u1ZKEbsaRdGNdw4C/q9k2tuUZP+Xt92YRUdi9RWtGr3gNc30wHel/vlXfv0FqKTfv5GrNbIR34U3plUiA2L+QpKWydkC3fgkHzjeaijHR0GTSXZrUJtflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9orUNwUowxvBUM9wK6TP1OAdOHTEcEq1ZYcKr+1kSU=;
 b=kahm2z3aD9sukJnrJ1gdgUWqKK3crXQeCtcgRSya+cTVaUj9Nf0U0hcNTrPgCZVbYfpVOfHNYx5kVoMx3DDHeyNANc6lvNkWmNtV3XqYzDOx4UhO95Sv0v6b4SHL2yJbZqm1LZtBf8sgcZGxtS1RB0kKchefQfvQAZwkI12urdPaJDaI7fCs2kX/PxZAiyOqUmEU4vCAJYS3Xau2VXIIlwya6sSzeCMmRKTYAsNs+/vb5wcYkh1ygPKAtr+Ya+Y9PUR4g0IY52RQT0vdBPC4pK5o4lx4T3bDHkbnoPtQpeiojD6tT9B6u+pWZg+NSzoMWiG0633EX1zfQ/BObunNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9orUNwUowxvBUM9wK6TP1OAdOHTEcEq1ZYcKr+1kSU=;
 b=5PHhaYGrZLMdmp7zvRqCeW09Op7h9URKSUK/rNhAZ7GdhY2A41C9u+PSyCB6rEXzR2SuMnXxyI9dfp0vq2rkUGAs+5kr1FT2BzbNb8OKM9tA84FLTzSR0geNzfchVr/4RiSud1PcJUUgruaNqf6r4gCB0cYwJBOf9AIVjcjQys4=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 09:39:57 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::fa) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:55 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v6 10/11] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Fri, 11 Jul 2025 17:39:29 +0800
Message-ID: <20250711093930.1411470-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f065a4-d4f3-40be-74d1-08ddc05ee5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Y3AprrTgr0Ig3knR9x8kXGOzEsaVV06dWu/2RogVaabNgkHcqMDqm3IuI7c?=
 =?us-ascii?Q?z1Wux2qEFKFDvqYjU2aK6OeTUOGJPZC4hCn8s72iSS7VDvQtFdpfmbEVNO3T?=
 =?us-ascii?Q?Br9VMulJQeXd7i5vF+ujOBGlrsglaVct3uFtEcTYzgwQI+rtK5MDAzK2AHd8?=
 =?us-ascii?Q?aL2PtEewSKS9SNy9WTssM5VcACtg/P/gCNt+14layi9/VyzhidNb8Zc6ZTA0?=
 =?us-ascii?Q?VureSyti3H73qLL8x9S9tr/E5L4NIqsTKjfkSgd92SfAc7xEd7hcFncjFDQ8?=
 =?us-ascii?Q?dTQ8cvgVlpKErDIf3aV8wGXA/vPppsu7tKOTv+2NZAmBo7q+I5W36pzzN6+n?=
 =?us-ascii?Q?upY5jWWJ5UXjYc34W+kQ+of/r3UZ4JRBI3b6mQ2bv9AqVaezpHFnbpRdPgtW?=
 =?us-ascii?Q?zljx1iHZCA2JbSjUS2ooaYGzF1WkC6DTJLxFwPjWG1AYEZR4vWGW8eRG4c9e?=
 =?us-ascii?Q?K6a9Odc+PABIyhLuWUa2CCWTZNVTvNDgZYX6/a8YwJzr7o26wMoS1h4GE51J?=
 =?us-ascii?Q?lcMTHCSAa82kePNEYJmu9CFM2GUSmiiMjlnxfQgNtITpeNAv9eOsxyhCjCs4?=
 =?us-ascii?Q?tgyKdDlLoZyFgSbx0XMCY6DNIYhq7fS6BAzVIoyJt03gVddSuWVjLmgEusSs?=
 =?us-ascii?Q?CysoI8GM0oIc6Qc6svD2vKtrYIaanLtoNOgUEuP85BxGZm1ZYLc23bqt9cHZ?=
 =?us-ascii?Q?O+F4Bbh7kDzhvJwWAskpTQ3/dxEI6k6zOxNN0bhxKIbup3DdIQ+irlkTQecx?=
 =?us-ascii?Q?iz8XO4bRAiO03p1Et+dDO6rYfGjiREZ9n/olpeJmFn4mPTdli/AvNwtdNBN1?=
 =?us-ascii?Q?O898oj1yjaH7PV1BudmXdz/OuLMSY4e+5i5IxL6B+RJTR2AgcyhZcF9q/doR?=
 =?us-ascii?Q?QCUZlfMx6uoRk/qm0Lo8mWlSmZvE7q5BVW1TBBP2CUMOYyWYT5JBN6ugl41g?=
 =?us-ascii?Q?ipn5byorGMgzWFlIu6TSrEC31j9qk/uN1SFpHkT0iQ9WFyY/Fy5EYYmOKTrN?=
 =?us-ascii?Q?V7/pMoROvyLeY3l0nXXXp1ih12cXBe2qlFPLFNS1LE2B1MuTk0EKfWx0UbmB?=
 =?us-ascii?Q?o8XCg0SjfsVpd65yEjM6/tlKtnGc6FQkdZw3pn5B74pRSpgBwmcifzxBNYTo?=
 =?us-ascii?Q?N9PEq5kGagKVBNMSgtfVcuKy6d10/1QDgx2HVX3nlaRsS1pERBoEibSwfX1b?=
 =?us-ascii?Q?nHdA6sedO7SolpQ8YQ35S+t/GYJ9Dk6hXkxJp+Hl4nJrPHHz0SGhk/1UtiPH?=
 =?us-ascii?Q?MnqthH3TCcE1AY2lSLSvNBU9zvCdLihR880I2w6uCojezxU5YQKqd4v9mERN?=
 =?us-ascii?Q?FySlFTX63xxDxLysqtnRc5tKbFIXbfa0y2PNHjhvmfJzorQ05mrYl0otrWC0?=
 =?us-ascii?Q?P/Hf1l0HasBSnKB9riFS24UBXbuFDQD6Rkdv7s4HDePiqgz5VeGKoyGCvMty?=
 =?us-ascii?Q?dyEdD21tCWRi5xjlE4UDKNg6rXF5NYEUmO2FPyKpOn/pNbRQWohsXDt+XII8?=
 =?us-ascii?Q?GbW1u4pWwYiV2r/PEuW0T+p2Lv6whYI/Rm3h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:56.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f065a4-d4f3-40be-74d1-08ddc05ee5bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bfe7b229011e..54f44fc834fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -777,11 +777,18 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
-- 
2.34.1

