Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502B1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7896911A7E9;
	Fri, 26 Apr 2024 18:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zNBOE/Z4";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C40511A713
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMM9WbFsUsfhodA0kFoJ4qdO6mfFpq+tr9xW1nWWteGLoziW9xfs/TwP1Pdxmdug+E98TYxsQBggYRTn2qhR9/FRPVRJTj03Mu6cKJ1sUFWf0gZaZbzT318tv8a0ZKdrjLlTDVUnHT1h0Ql7DjwrO9Fln5o9y1wD6DXCeLiZzaLdrieL1VCpbcFsk+g6WQZcITbwk1vi6oQxUE6nMZrk4Aw2aauImhSCH54PNSMZfSQ/kmd3/pUFU74lxMjs5HU38j9ICy16YRn7nihaVyzPlLrpZ4raFKWeSNXkcWBCD8yFimjKMh2Ke1fnkouRa4j2BSWdA8geZDyuQfNAe3SMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r2jAYeFkOo4E3rCBW4DfL9VSWndxaiq+LFwUT4FvO0=;
 b=ayvj4mCC6ZdnNshjHCKGUCU0qhz8nMklQwm70XxR+l0oEJfgiAvHHQ3alrsB6Z4YB8vx9ThSZOfeFtP+Fc6eChl3cydTazxqahctrauekOUCLmGpYUue43UDvHGhbUhCXGr7Go10xjode9oViMsMF/luhD++aSgYWJYz2eCwrAST5G1tlmUKh6/qOuPFkRhnDGqjgwPZcl+yUJOcsHAZz7r/eicNsEVxjGIDn/DeKcOu01FVwUmGPMSBgFIbJC7CrdfcI+jqDvQZPFP2I9iNr5RTGvoaaQaUxvSF0SVhsnN28PF20sclBPJB1ZjVnpGefKlJfdb92038nfrcb9XXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r2jAYeFkOo4E3rCBW4DfL9VSWndxaiq+LFwUT4FvO0=;
 b=zNBOE/Z4FqxU6vMBDdoAcDJwH6HBaeolx5vFm9774zfxXXVdDU9V6G+CHfBM42LT8O2vJKFaIvK1qknFDaKdYMjVyqcEa6pnWRxT/agMayhnb1F8w1L2ysiOHDFThkWuDMPNVC/VYHTdmGFBmbQscWY8ekwiW5Hib7NLn7sMTtA=
Received: from MW4PR03CA0053.namprd03.prod.outlook.com (2603:10b6:303:8e::28)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:50:34 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::37) by MW4PR03CA0053.outlook.office365.com
 (2603:10b6:303:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Add new members for sdma v7_0 fw
Date: Fri, 26 Apr 2024 14:50:11 -0400
Message-ID: <20240426185017.660146-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4e78d2-90d4-4c57-a4d2-08dc6621c0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hesJ9IfNeBjOwkF3pIaEwDriYJuPzp4IfuRbaMvmmdR3NdFE1RgRObTDG4mG?=
 =?us-ascii?Q?52bxgzw573Gy9VMvSACNgWzHK/JZTaGIYyGZA/g/uZcTst89fPq+mvFV9a6S?=
 =?us-ascii?Q?9JUociDkY2Shbsc1LTn7Ubr98v3Gfzv6Wo9U85LMREC21epP5ZsOEKCy74il?=
 =?us-ascii?Q?fvxWkYAqoQLPXd77zJ8X1/57s53xgKbuudyHy31uUwzjN0cDz96q42EIDmZj?=
 =?us-ascii?Q?Bss/dsVQ7/ABS3WI6GYygfRfslIowznO6o676osUXrWn8QszE3qH1UcdpM0/?=
 =?us-ascii?Q?laNBTfChgbMZHjA538q6O/ZAsTTw4Uc9VWZZ+3WBes/WL9svSAOxXLktWLtP?=
 =?us-ascii?Q?FatMm3fACe9Xc6fkRlTkiLjYwbhSV4h8cWQA1wzojpjdkAZlY7O3rGuHZi3W?=
 =?us-ascii?Q?+t/D+bty4M3W7aOr5y8qB1w5MgJjo1j0LJPg90UUcoLuZuPfc4FE0hw4atAr?=
 =?us-ascii?Q?36S/FgUJ/veeq/ULoEARVbiMRFlK9j2dsHh++X5JC8PhAs/vCRlmCpmBks3O?=
 =?us-ascii?Q?dKx1lyjyCfR5IHXqFADFzpfHKcWrafqZqUHq6CnsyHLSO2zgQMj7XbkGq8LL?=
 =?us-ascii?Q?5ymT2Kq3HouJJ4cIqy0nOK03cg1YrRTTWdCkriBJ1uRk+BmoQjH6xAlunO7u?=
 =?us-ascii?Q?2PbyEPUmIjE+VBGIr2JKYNGykfOA14Mdv1c9SxQtwjoSITXlXvKmll/W0EQG?=
 =?us-ascii?Q?vVD7zAfg1uKGkxPwuEqth1/IEXPPydcWQgq+C0pkk360f7VIhrW7xNjTF4pX?=
 =?us-ascii?Q?wHTHbns2XuILs0z/WVE4CBbXa6hq19JO26BqTapzP17csbqLGSOfR3xbV6Qr?=
 =?us-ascii?Q?t1CYJlf7xKMkdk9d1c2DxZIMVQiyl8WBNL2SylAhkFY9SO2sGj36geafAWFK?=
 =?us-ascii?Q?8I63YVr5BzJb58bFsujg884cwjiN+G/NdEZDCn7LSJK2rfBqjbLbrqdOayBk?=
 =?us-ascii?Q?WvWMqW8oLK9Gn1mWjF7wxJIaOv5ZdbE4giqdy0VGVeiXmtH6OHerTeMLdyWz?=
 =?us-ascii?Q?RiDR0x0ZT4qRzdn5aIV8MDg0yRgZeJzAw6gYq6x7kyfKH8TogLZoCjhu9csE?=
 =?us-ascii?Q?/JAHevb122ri+j20BWfFCKMpsPiht6+Gryu2TRgxMV31AlJ+EAPp+nbZox11?=
 =?us-ascii?Q?Cy2jP6d36tEjU6VEtIG+nWkwaRHYqpoqHy8yEQMiQohbrLGrMLuV99whIzLo?=
 =?us-ascii?Q?GV2HYnE6KY0vDLIDfFwhjv80gJFCGhtXKi/x5rrvAhxaoISW2YgVFc4MCmW1?=
 =?us-ascii?Q?YWUhyvsnpJzFFORFpwJbniEQEraAs/G66/rFY1awUiOB7kKQxqPAIerWPgfG?=
 =?us-ascii?Q?cxHKOtJ9tb9ovmG/hY4pdoJIscJ2W7u56Df3Bm05/DjGumKL93IkSSE+ZITf?=
 =?us-ascii?Q?Mk3tdDxcTTj4LfscT15mEvT7UhMZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:33.4480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4e78d2-90d4-4c57-a4d2-08dc6621c0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

From: Likun Gao <Likun.Gao@amd.com>

Add new members in sdma instance structure
for sdma v7_0 firmware.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index b51a82e711df..d3706a484870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -60,6 +60,10 @@ struct amdgpu_sdma_instance {
 	struct amdgpu_ring	page;
 	bool			burst_nop;
 	uint32_t		aid_id;
+
+	struct amdgpu_bo	*sdma_fw_obj;
+	uint64_t		sdma_fw_gpu_addr;
+	uint32_t		*sdma_fw_ptr;
 };
 
 enum amdgpu_sdma_ras_memory_id {
-- 
2.44.0

