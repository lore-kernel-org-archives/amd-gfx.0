Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E887C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1291910EA8F;
	Thu, 28 Apr 2022 21:30:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE4010E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDS4nNVIhtSjedmU9iVV5Ip+S/cPEdFt6GQ/VKw7onKEGO2yU7O6S38EInq+n2+OMx0bDVpDwi+DJFofZ69QmnWxzxJyG6YwMfff3uOielx7IHcpAE5PyvewoXHyxHPIciu+JGIKCoaCTltRuBPSLjT+oB7rZzOOGl7zxTgkUdTAI+zoc22EtspBH4VOjoXd15Z3vzCI/U3JmcVZk1KrlvKxzlvzn+OJQEtqQqnbDB4/h/j/sd9I75mEOzcrPtiMYkA/8N5qQmTSzCOleKWcG1XE6EtWAOlQmbwadCE9ex0fjSqA5fdKMT+FO+rDIE/uZQwzchx0lm4RRr3MPKmbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PF2fIoT7mrKrBcxk7+7uVQbLuPpX6d/ykvaAg3ayn4=;
 b=biMV0+yDmrokENz8rTo+2D6rkbTpRlAvanxkzin1yE7pmbD2pMqAvDSdUTbEPN5Wpqkl1QbjbXrmUAmN4NYXdJxGr9YmNKkwnEAVguHYt8OWfcntRtEKbKhLguVlf3Kim9D+HtCvj6hhsp3tFo8Ea5+SHvD2F0ezIAfr6zu8zkLeXIW2QeX+W6V7dhQA6OfZp74xfEh4fDfJrfu9e19p6JXSv68Z1osZAA5txEXRl0sWAnqyRoGbSitZr7k5/obTkuqiVH52RZLsrOp+Nj1ogj16LCTTDJqhHKutCDmBlIEyPzvyvz5M5drrPKJ0EfNaLS24f51fVuHgp2fFK10+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PF2fIoT7mrKrBcxk7+7uVQbLuPpX6d/ykvaAg3ayn4=;
 b=nW26RAQOqcBe2SUxLGmPyGhu4aZVl06T88etWPtDZXV79tqUMIcO4W8t5kzYdVCESR0F8IaFDpeHHPeI9xXm06ZDrRL4pNboXzOFj9gZf26Rn5tClNRL2kqi6uWO/QZs5QREkonuf0Ej5nPGHhFH0S3QGGn5OHcL9H7vq6WTr5g=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 28 Apr 2022 21:30:08 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ac) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable the support for retrieving combo pptable
Date: Thu, 28 Apr 2022 17:29:46 -0400
Message-ID: <20220428212946.700296-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c2321c-39e3-4b9c-36ff-08da295e4473
X-MS-TrafficTypeDiagnostic: DM4PR12MB6010:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6010653D47F32BE698351118F7FD9@DM4PR12MB6010.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH9Hc+C3VZvgLVHCEZKhzP+785DNE/8VhphVguh3NM+M133Xm6H5ZXhmai6xhYeBr9NbexH2rvH3yv59lFS8wTyLNwO0SsJ66rDK60+B5rdo+rmOK9XipYdNYypOYStGODsYN9AsVWdtyFQczluSTDAxs3xcHoSg1ztSA5ou71ptuEf4CJjdPdShFwFvaZHYcBKE6+PGGQ9ZT3j1GiZR6C8Ny8k/O8lfyclJ/MlAY9rn5xabZ0EHEvjWxZS2ma0385lwg7xoVZzz/RxKmIC00Rac1JxUutzH1S58kLCfSAM+szh7BK0SLxFIt3IelP0NLLH2dKCj0YDydFIp0f/YroIs0pA0K3yRzMR9sFzXYS27EmfG6t4yyLK1k24//x3zi3RBWXwMFqusduHygs9XLuto5ws7655Owqd0Pz6r81ax7qkiTWnuG0A443fc85JTHsHMJl4FT4DrlIv73SxA4FNW7Ulx4nJ9HOezvexmXp7zQubdnsCCEhOCmSx2ssUuu7z5HgUBnVWjks1IdvPWfe9luhTP0mD3cYb/fbDC4PcF7g+pTnEOU+Bbxs4oZVGqjNSMD+QuwZXc297ntPUpOJaZ6iydwhklJlHTNmqgAcT93En0NJZJM15dAxFR3FmNT5WkSmZzz7DV83OD7yQTfgiMqBAoNa+6oB6sVft323Mh6DbZ460y0gZ5fIMksmouYACbBtNlpNc1r/r3YwB1DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(7696005)(5660300002)(36756003)(70206006)(36860700001)(16526019)(186003)(316002)(83380400001)(8676002)(4326008)(6916009)(8936002)(70586007)(54906003)(2616005)(336012)(426003)(47076005)(86362001)(40460700003)(82310400005)(508600001)(81166007)(356005)(6666004)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:07.6537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c2321c-39e3-4b9c-36ff-08da295e4473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

We need to relay on this way to get the raw PPTable when
SCPM feature is enabled.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 491357321020..49d2c0eb014d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -321,6 +321,7 @@ enum smu_table_id
 	SMU_TABLE_I2C_COMMANDS,
 	SMU_TABLE_PACE,
 	SMU_TABLE_ECCINFO,
+	SMU_TABLE_COMBO_PPTABLE,
 	SMU_TABLE_COUNT,
 };
 
@@ -336,7 +337,8 @@ struct smu_table_context
 
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
-	void                            *driver_pptable;
+	void				*driver_pptable;
+	void				*combo_pptable;
 	void                            *ecc_table;
 	void				*driver_smu_config_table;
 	struct smu_table		tables[SMU_TABLE_COUNT];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f12319883a80..622881ab34c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -971,6 +971,17 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+int smu_cmn_get_combo_pptable(struct smu_context *smu)
+{
+	void *pptable = smu->smu_table.combo_pptable;
+
+	return smu_cmn_update_table(smu,
+				    SMU_TABLE_COMBO_PPTABLE,
+				    0,
+				    pptable,
+				    false);
+}
+
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 {
 	struct metrics_table_header *header = (struct metrics_table_header *)table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index a4c593ed8b03..1526ce09c399 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -99,6 +99,8 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 			      void *metrics_table,
 			      bool bypass_cache);
 
+int smu_cmn_get_combo_pptable(struct smu_context *smu);
+
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 
 int smu_cmn_set_mp1_state(struct smu_context *smu,
-- 
2.35.1

