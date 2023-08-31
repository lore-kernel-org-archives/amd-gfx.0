Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C28C83F10
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 06:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7070210E574;
	Thu, 31 Aug 2023 06:10:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451E910E574
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 06:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEkYJ8gfRWBH6lNrxtkQir8BUo9xdnKxVKYOdDou4GDX0qOmsutHjbZ2oBsnb/UGK/t+KFwRbPwhyd6ToNGp1/iu1aV5nVgoYQHcOodhFNjF8lUsVHEjzcGkQtpJgTKSmzq528exj50JAi7i49dztQSI1aWz3NzQwjG6nf4NpqCXJK2Jhyq9ty3FL33t2qfeH0xStfB6IlhtCuP5lYh3l792Mm87smeCZI4u2xmPXx5XycF022WucwVGgOyJB1CmxNNG+Nm6FAGsm1C71bVKJfFARwKzBfSBYU0Z5Q1g1teGo7Z3kpfvA8iijLp+UAxk1l5y0nvIeBNZ2W/1vSB7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwW08V0V2YxxSQoS9ZSPhXkmfOUfXfFHtjyNk6P9i/s=;
 b=gCSEYczDuJqbPRD0oWdMC/0eq0ons/qgkTEIOzqdHUHNwu3mBXYxkabxTBpQcaQAzuqJt2S9g6m2EXIKqfee9J+glVAl0ZeYTOrCe59Cew1wV57txrQmLOSSQ6BRI0pPFu1VR+N1wFq+eH764I5YPfgxhMtwsavLvx1b1ovDsZ/iXb3p3vk3a+gxs7xFsH2CJITcZjm/0UabrD3fdnD2KWV705oP2WKdLuvsi97jMOLYI6YR9T3sN9p/UUGP8RM2hTbLlrhgjVHwENgjZwzMshjmOU7bnFBJyyZuzU9qwrxCfJzImBfs4oUlpUDyhVNxdXIUzpJgE963T2GBVywZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwW08V0V2YxxSQoS9ZSPhXkmfOUfXfFHtjyNk6P9i/s=;
 b=5iDaaY4bkUg0Pa4ciW8XY1/fqf0zl3DMyonTuDhGNr6/vR9OYOtHYcKVyjQjuuZm0n/CMKha+NAXi2pwSpShPvmKTcMm2ls3Xc0VGkNCUChdPgegFGOrVYT6wY+ruIhqOWvLAV6KHjAGNhry5nFmKNm5n8r+gLyGNyof1bKy1mE=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 06:09:59 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::75) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 06:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 06:09:58 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:09:56 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: only poweron/off vcn/jpeg when they are valid.
Date: Thu, 31 Aug 2023 14:09:37 +0800
Message-ID: <20230831060937.4120912-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 889bc219-a567-4f00-6b74-08dba9e8e7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpS4rD38curfhkwDR7mfnJwgC/KUuobAguc66ZP51OaBzXYYQ3PAcUr100GxP4tjWMB9wBXRzfeA+ibvll2T4g35wd/gFO2KQdEa9Gpbszsmiy4n4TE1sni9FZteHKJvzEsqEH8x7OBIvV0bUgaUZYy4U+4bF+SN+dPRjqCLBC0A+zW5c2akmBLZchpNt4p6mfYnYDe91ZSXf1wKMxmnZR9nsESgraNUDHGj8R90X9ccP3btrLm1XLvU+jZ61JOSkpiRauqPKBAU8bN6wcFpTMGaMkwuYbV4+xWiMIY/xZ5ulZzvQkY0D1FKYI8QSG7iRqFC8dsguE+jhKD/GQlEpfGT4TY/n78LUaI9nz8eYtasWoUIEQH1Z+8FsVKaBGodc2LMOuEqiwx3FXss53Rw5q/ud7a8XQTFLg7p+gSWwQ33C/LY/60OQdHcm06S65LfLHhoYRdWBgc1COSrR1WJJzWCT5CihnedAW+bJnsry4bFSKQWv4/IlTqSM1PxwxmxdvXcLuBrEUPBV7YhthtuyDdzSpIXhuqrDgAnvD7DtwxuhIaa6Rulk9N4KXveQaAstScLo2aIwCo11v59V18FaLZAiVqkY6bVCG7ZGcVR/GPzJXAlTIyWdkF9aqyt3bV6K/uOyu/QgQQ67TdzwCH6WaU2SJp107MXGc6x5ybJj5QcE14q46lPmhT8b5KaAhc/plq3Nxr+j19mLD4E53WOjQtP9Cws2cekk8GQi6uIuirO/Wd1z5cEze5ces8jMKEUIdB0S3NX4/nFRo//jHcJvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(40480700001)(83380400001)(4326008)(41300700001)(86362001)(8936002)(5660300002)(8676002)(1076003)(26005)(336012)(6666004)(7696005)(16526019)(426003)(2616005)(36860700001)(47076005)(82740400003)(356005)(478600001)(81166007)(2906002)(6916009)(70206006)(70586007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:09:58.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889bc219-a567-4f00-6b74-08dba9e8e7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Evan.Quan@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If vcn is disabled in kernel parameters, don't touch vcn,
otherwise it may cause vcn hang.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 31 ++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..f5e7ce011cab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1454,6 +1454,21 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	return ret;
 }
 
+static bool is_vcn_enabled(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
+			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
+			!adev->ip_blocks[i].status.valid)
+
+			return false;
+	}
+
+	return true;
+}
+
 static int smu_hw_init(void *handle)
 {
 	int ret;
@@ -1475,8 +1490,14 @@ static int smu_hw_init(void *handle)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
-		smu_dpm_set_jpeg_enable(smu, true);
+		/*
+		 * don't poweron vcn/jpeg when they are skipped.
+		 */
+		if (is_vcn_enabled(adev)) {
+			dev_info(adev->dev, "yep, vcn are valid\n");
+			smu_dpm_set_vcn_enable(smu, true);
+			smu_dpm_set_jpeg_enable(smu, true);
+		}
 		smu_set_gfx_cgpg(smu, true);
 	}
 
@@ -1651,8 +1672,10 @@ static int smu_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
-	smu_dpm_set_jpeg_enable(smu, false);
+	if (is_vcn_enabled(adev)) {
+		smu_dpm_set_vcn_enable(smu, false);
+		smu_dpm_set_jpeg_enable(smu, false);
+	}
 
 	adev->vcn.cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-- 
2.37.3

