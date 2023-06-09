Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EBCC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 08:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DA2892F6;
	Fri,  9 Jun 2023 08:45:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C716892F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 08:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDMJgwfmElfCnJK83tsRnz3dcluEAXmJnKPbuVUQJLL487OC9rsy9GKo72jgM7hy8x9dmzwfw3bEORhEVWf0YWT0Mba4xKIhGO+5RQ5hB1ka/WtDqU/Ig/WP9CHjyHn6p9/OUycKGb3/F3HPZfGIaI/c7d+tnYI/j6BTwn67ZbTelV+xOEQlPdVm51UetFPIZZZXs6LGHJOueEcDXUpWj9EBvGltC+C6H87YnHhKidPp55p4aYLFPwVqXrhyi8y29fyI6qkkYA2NXxzDA11VtVP3myNDz0wcBA1vVAdtXkR6n3rhVpv/U/uH2wwJSc7sbXxPAH3MG8gLrnjFWutinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LViHHp2F56U+r1M0n6TrI8MRiDykNZuu1UYAHZsvgJ4=;
 b=AqwmW8xu9oEZYoX1PGShBBKd9hW4EKIBNyD8NvlA40RlnGbr81pj6C8NRsEDlHog1vmcH60fXsBeUkMgOKi3FpJ9OU19Xs7mdPYvx7itiMCgdPjhQDtx/ZiQtMFzZ7nQOnMD958NvQixsqMDUwmnPVb+MFXmiKLdnahNvxk3s1qmc/zoBEAP602iCv5JbrxVBTI5Bc8acLJgUCCxStGaflBhByMxXP2A5y34+krH0pu6wdoX3oHe5i9gJE9isgu20Czh4xrFduW1LwP1eDpLFH4N6G+PPZ3+mesC8YbLA24wS++icxM6ZiNjIc+dbPX9JMs+l5Hq8+ETMQnhWT6Ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LViHHp2F56U+r1M0n6TrI8MRiDykNZuu1UYAHZsvgJ4=;
 b=am8cA1GrvWVkNrgaJmATK6ZcDtc9uKv7V9seNtOy8M3Gm3KqH/cociDEhFzZGTaP3NVrFttE4MY1rs+6uOnTPq/FYcyqonGZpMc/w3vn5SaEakt4GvNiX/HCrTDBhXBR+8dblvY0KsXuqu2lVexryXDoQEpaJRda6Xsz6tcdfk8=
Received: from DS7PR03CA0239.namprd03.prod.outlook.com (2603:10b6:5:3ba::34)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 08:45:32 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::19) by DS7PR03CA0239.outlook.office365.com
 (2603:10b6:5:3ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Fri, 9 Jun 2023 08:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.27 via Frontend Transport; Fri, 9 Jun 2023 08:45:31 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 03:45:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, Chengming Gui <Jack.Gui@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Date: Fri, 9 Jun 2023 14:15:13 +0530
Message-ID: <20230609084513.261487-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef9317f-a57d-4a6f-50f6-08db68c5e245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKlw43JM+oWajB69Lb4Q8KhDymetiXZiC7gZITluAS1BOzA6jvtJCw8MkeDSVnsPfk0w26111P5K3GcCxmVA94k1YtJMt47nXXIa58XONTKKQ+wZm8a15Li7r9tUd5RvvdkSGLtyhd/HLTnPBmiWnWI3a5eBKon9tARd9Qh+juwSOh2nBriws7Tr6FbRQKQtNxrLXGVeZp6IiVuVw0w26/JaxrLW9L1eI0sRlDiXHDVyZhI/ahbThZhykUp517/OqBLiegYE3uNCdsYJC3Qaa45DzOMLOtuoMopSgVuLmFxVm+QodPdcqn1OHMXIOYq5dxGeN89Pcl6wF5VzUEDcUqpamQv8r2Vi79IkYdJwpnTYoV4/0ZFoexYwC6Lq/ju/E2iNkZSVOvCUoIRJlVnrymL/6ZLQ2Gsi73SO4qX66E/XurhHm5ml8Y5oz/nezAH0wYOgcWp9AXhh+rr4eVUC6Vkx5fGoVKPQlxJsMOluc/vd5/cld0NPtDHk0hIAR/mh4kIx9+wRUmAnXgrSNR9haVqHSi1fBVU8qlteOXaab5Ke5swe5L0llthQfNNtW8P3NJyAFnkyUL5x+Pkqvu3KrwWfLhoU2spLI+3yXcv/HzZzWMIug5MXzR+4LjEy3z7EOxcCcbHFYhW5qirZEeRbLsqUVE8QD3JlpOTqIngLzkWHXEGoeipPs9dVln3ITPjt4bfAjEQRmJDypEX5FJx7aS8Aob32URIiQdyHmfIBvxYFukJhGP/gvVHNga8IXrkzLvx/GOLd0XaxyqICjPsQQbDyjHP20ugN+cXH2rtY+5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(316002)(41300700001)(110136005)(54906003)(44832011)(356005)(82740400003)(81166007)(5660300002)(19627235002)(2906002)(4326008)(70586007)(6636002)(8936002)(8676002)(70206006)(478600001)(6666004)(82310400005)(40460700003)(40480700001)(7696005)(36756003)(2616005)(186003)(86362001)(26005)(16526019)(426003)(336012)(36860700001)(83380400001)(47076005)(66574015)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 08:45:31.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef9317f-a57d-4a6f-50f6-08db68c5e245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/firmware.h:7,
                 from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:26:
In function ‘fortify_memcpy_chk’,
    inlined from ‘sienna_cichlid_append_powerplay_table’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:444:2,
    inlined from ‘sienna_cichlid_setup_pptable’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:506:8,
    inlined from ‘sienna_cichlid_setup_pptable’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:494:12:
./include/linux/fortify-string.h:413:4: warning: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  413 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

the compiler complains about the size calculation in the memcpy() -
"sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header)" is much
larger than what fits into table_member.

'Fixes: 7077b19a38240 ("drm/amd/pm: use macro to get pptable members")'
Suggested-by: Evan Quan <Evan.Quan@amd.com>
Cc: Evan Quan <Evan.Quan@amd.com>
Cc: Chengming Gui <Jack.Gui@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2: 
 - turned to the way used for nv1x (Evan)

 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 85d53597eb07..f7ed3e655e39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -431,7 +431,13 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 {
 	struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
 	int index, ret;
-	I2cControllerConfig_t *table_member;
+	PPTable_beige_goby_t *ppt_beige_goby;
+	PPTable_t *ppt;
+
+	if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
+		ppt_beige_goby = smu->smu_table.driver_pptable;
+	else
+		ppt = smu->smu_table.driver_pptable;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
@@ -440,9 +446,13 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
-	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
-	memcpy(table_member, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+
+	if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
+		smu_memcpy_trailing(ppt_beige_goby, I2cControllers, BoardReserved,
+				    smc_dpm_table, I2cControllers);
+	else
+		smu_memcpy_trailing(ppt, I2cControllers, BoardReserved,
+				    smc_dpm_table, I2cControllers);
 
 	return 0;
 }
-- 
2.25.1

