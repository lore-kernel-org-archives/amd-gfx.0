Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29429C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 13:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5945810E076;
	Wed,  7 Jun 2023 13:51:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ADE10E076
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 13:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9MsoO/ulOqxixpuBvCw5EQeQPxHQYnWCUzr2ptHeWsW9aGgQQdFVuBlh+G0P9lU42ZXhelzlf3rK9dlHEEYsCrjsx3ir9BKeoYGDJXHeUn76yuaX0X4LBmeWSDV8yscjcsyMA6vCS9v+N07K4Q9EG6dYLc//JPeBebfzdCVWM3TuMJ/V+jdD6bKf7TiiUmuvRLokg2vsKqjB0H+k6IZ4FaL0d92U3JZcYmg/CNnMGKRqIygyAFVWaddZdLOen+kTXHT+qsdTVcXa3oTjtdmapBvipShb00cNeb3AmZIQJCztAOTlAtH6ErOTa0i35baHH/bEQDP3FuQ+p5gN+SXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y0mndUAq9DKvAy8Kt/G1acgUm1VV/uuzVknbMMpzEg=;
 b=WR3O37kkjbbqnoUd1ecw+kVo8NA45inSywVxmRNX9GRF2SOqSkqwRgyxWqaVR5sctuKC5sg6DITR1Bl5hwDSuu6jiLj/YsJouN042AiEcgeA0uf3HSfibZMXrDQVLkWpm8qxQmMLOD7CVu+h7rbH8R/xctPfKgv1vW4svnXlM9DTX/Bf4t29ZpPHzDqrFxP9exrGUozhyJCRDt9akhDM13LHLYxWjRdu0mM+t/oPhDeNX66wSbsiVcyOKBfGnsBvVtMyBjH5JBNef7R0ebyD3FV7YvkyEBAuFGUPbAoZebS/uNnou9f1XSzVRA1hicRT4GZuIP28YEx9JnUw5RmQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y0mndUAq9DKvAy8Kt/G1acgUm1VV/uuzVknbMMpzEg=;
 b=BJrTfQW2ktRGr1yO7orizuOrPEBUM2oAjvA3s41MATt6c4zSTWhOgpWF3jln1sN/k6V8OTEmbTN/EmS1JeEB+7jtZFMJ9pCbytrB8DDwbx+NUuFVadEeMxyiCWZiYPI9W9J5NQIK7GzMSchv+nRoZy8bFDkeMoGyApHKu2xKABg=
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:51:11 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::24) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 13:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 13:51:10 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 08:51:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Chengming Gui
 <Jack.Gui@amd.com>
Subject: [PATCH] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Date: Wed, 7 Jun 2023 19:20:15 +0530
Message-ID: <20230607135015.3089577-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d252cd-c5d8-46ce-edaa-08db675e4021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWsmDaAxrDn7zX9MGEeZfkDfp7JRedSRLF1Dtebpqx8rotO9jNIl5ijOCv3LpXPoHie/NkWH2nsTFAtC8Jbz9SBLXiC+a8V0BYWVRamf3bQD9Q/Qo6KSTIZ8N6Pps5G/KJjmcOjAntz3BCF9HQqjno552uPz7UrnqXD1uIn1g5cgxd+UoLCvxonv3LcbJ+jKaCYtbYG9MyoMrGiPRQxf1jHJpCQnIHjRL8b0J+TFAze8LnAiEaI2EWR8F2xGmJy6ZlGPIcUZltKSUo2+qSRySZ1W6SG/OVE9CP6LyrDdlcy2uf9RTHRXHaUmTL4744tS29PcWmwRYP02bPpa+AZxLt+IgaTJtix7gGwPTdiIeL95YO7uvdatNE0F4RhJ9tUA04SJp5HIZ0blgh+bA5hr28uUDoSy5L5fafl2Pbt5qx8VpQtucOr7P+xlMI5UAAruNRNV9nZRl3hS+D+44HQlOjN9kOXe8QUx89ofEWfaAqfn1Qnh7Vpc4Ci+MU8ll1IoponfeevFeZ3SIH6cJZASeECBTl6IMDTrGoXDHu8q5znHd88sJXyZ6R2KJnR8/iRtDvy/Si2w3Llaf5buGyLgvKtjbD3dyKO/CrfJzw0zfERb4LTcb7Prh/0Lew/wyDXu1X/e53AOD/aNl1PiWWtNgS5ADKQrmeawMYh8p5hZLLV7lipH8Iw5JAFWkgC3UUykTvl45nXMVdCkGoJemxzQp9lC75rilxvLjJNBrPX/h2MSkhTfuWsgGZDahwFBS/N5XESdkEJ6Gq8M+tqRxAHkiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(66574015)(47076005)(83380400001)(336012)(426003)(82740400003)(110136005)(54906003)(44832011)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(70206006)(70586007)(356005)(81166007)(5660300002)(4326008)(86362001)(40460700003)(6636002)(36756003)(6666004)(7696005)(2906002)(36860700001)(82310400005)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:51:10.2203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d252cd-c5d8-46ce-edaa-08db675e4021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

proposing "sizeof(smc_dpm_table->I2cControllers)", instead of
"sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header)"

'Fixes: 7077b19a38240 ("drm/amd/pm: use macro to get pptable members")'
Cc: Chengming Gui <Jack.Gui@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 85d53597eb07..29a34160dedb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -442,7 +442,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 		return ret;
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+			sizeof(smc_dpm_table->I2cControllers));
 
 	return 0;
 }
-- 
2.25.1

