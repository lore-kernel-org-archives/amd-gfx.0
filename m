Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEA522B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y+U1q2C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEA522B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E8B6E84C;
	Thu, 30 Jul 2020 03:30:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104E16E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzIm8ua4lJh3I7JPM+IVzAYATkUoPamLbM4Y/As2MFhmYZY3BsPnY2404H+8H+RwLjF6GLveZ7234qjNXmHICdfb6hw8tTDoI6r0lyCwtqe0z/M/jtiy0YcJ5UufTk0mgZqTzV3LLfC/wHqI9aSjAqrm9oKBMXpkYMQVqa9CZzttJLpliVp/+Qrl6qqwDlyelJfTbdYC19gW1G3Omq7Z/u2CgE+Ea3x3sEqu0+RG+fhGna6pIP76VkID2D6lTs4kvy5z8E2ksYeOZ7TyFG/MQ6iFU3l0IUTqi41VByTzprUIR24/CUoYFEidppdrgM0lvx6flirz5Shul2ODdyDzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx31KR3Y3u/ei/1ksWaM4/2w3GAQgii+OZTaJpPQMAU=;
 b=NcMWlNOcMlxKeuxc+6uIj/V1EZxJJ7Py1GUImn9ZFt84v+a7qfknutsaqUvQjBBKuTeRW2jQwSpy7lt/iEZhOulCuUJ6UDQS2HVFCevQVEh20AHXT/gf6w51zFEh2TBjKHPgopVIzvi2AdfJKY9zbF3LcHxGOkOJ5O6Thn8JVTOpHIoxc9ITxxNXRqNfNDYM4B8S89CVGDsem+FsNsxBoV558S0GtpZLkqL9/3IpCDh2ya1Uv+cd5i1RHPrmtUvQUBVAWXvVmRsugiV9MbzzkLQdY9jk4kVqjv5YnajCI3hktLUb1ovSUfKsQSMMW5nSLvsRuYVNofBLsaxCI/U54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx31KR3Y3u/ei/1ksWaM4/2w3GAQgii+OZTaJpPQMAU=;
 b=Y+U1q2C4ODPX+A5M3bM3PTVzFvgw6pNKoZUOj2HpkTeO4YzkOU8Nx3Pi2LbBWXTRTWcasnJaz5NlNXVqw9OABsWFHj2hmmrPkP9TKSHPpS6NePOUkL3ujW83Yz2wWP8R7J7ZD5MNhW4k67vxFJIUHpcAdVWjE86jGI6moPd2hfA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:30:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:30:25 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amd/powerplay: update the data structure for NV12
 SmuMetrics
Date: Thu, 30 Jul 2020 11:28:36 +0800
Message-Id: <20200730032839.2517-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:30:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5c10dba-5623-4d65-3e02-08d83438e5fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13550291E316D871EFD38D12E4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKcBZhIKyahBvDuwFVq+MEJrY16Q5nUUV+9+apGuIMouEumVwEnJgy/6XFjVW4GdK613EHCJbnY+qEQ8PVcLzbALFgnmIyTrVQUAnJfCp45nCKbOM505ZonnJpOrU9k8c3QXejHm7qAv+t3GL20SY/DWvI/CZ3fqpee4s7oEAm2yq1Bd7xwWQuKlqXlgEerxXmUsT3DVio5xeYwY5dXGiWulXDR3ZS7C0hRvZYGKYlKaTkTXPiuIknNnCbmswpPn/6UxAoxCOMJZO2X69dLbFy08eAOKOcuq7OY4hywOTeeWcKf8E3XPVZP1747E8+b8liZug+DuYhe1JXY08CONUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: k0vAUnmA86tfRnGge8PsHJtyyjjjfwxZD0btjqquN1P3WxIDAfGCIoy3Ys8CdGNh1ppFE/6+jA8noCrMJXt21pB/+ockyQ6hsmGQKneYPmhaEhWjpHl4Vmt1NEbbE24QMzvTQzYpI0Fb+4Mf9hrHSkTUJwNR9l3mQ/7z64lVL28sfAHpYi1VfZiWqdp9GNgGiIEfTGQtzZy24Espi/gKBzr6HvfCyjtlx1ho0N0uL5J0SGGQK7EmXn6oCc2c6qp3rqKVvKl5089DS/EhNkr8wvu2AfPtBAePHc2pj3QOzqCzBtpyHDzuArwMSqsyMo75wAAtkdJcIUbQg58njBTg3gMNJV4ahwhGJyL0xMYcrvyUDRiH/QdrtrmVq5ozExxbUm3x+KyhNj9b5OB63YkPSrn6HJQPcI2CJe0SG1eDxb07izpVqV0VsOcbPHC0UgvZ50c7xcn5PAgjeIDQn2/S8FsVNlCOAQO7jjwCHf5xNMoVAUO5D0+NSRZOSHSJtR/z028VGbtVmAzU4NCeISldNxpvml6ISxrAz7E0xu/RL/KW/83Zvgrfqp1EZoi7oyjGJGXarUVU+Wx/iKdMdGOJg5uosZOcLUXDAzbEjbcyEP8ZPfN4RZLUvIx77hLuMXwYCxFIOdrpPelbdDgKlbHPeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c10dba-5623-4d65-3e02-08d83438e5fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:30:25.7139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEo35yaSGPHvP0yaEe+NyRyIWwSQ/15HekmitXCqb8qpyEXwwrCNfC6tXTAn4OQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Although it does not bring any problem for now, the coming gpu
metrics interface needs to handle them differently based on the
asic type.

Change-Id: I88ee78c26795267588f944d4f1983e4dbf23ba85
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../powerplay/inc/smu11_driver_if_navi10.h    | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 18 +++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
index 4b2da98afcd2..246d3951a78a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
@@ -884,6 +884,45 @@ typedef struct {
   uint32_t     MmHubPadding[8]; // SMU internal use
 } SmuMetrics_t;
 
+typedef struct {
+  uint16_t CurrClock[PPCLK_COUNT];
+  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageSocclkFrequency;
+  uint16_t AverageUclkFrequency  ;
+  uint16_t AverageGfxActivity    ;
+  uint16_t AverageUclkActivity   ;
+  uint8_t  CurrSocVoltageOffset  ;
+  uint8_t  CurrGfxVoltageOffset  ;
+  uint8_t  CurrMemVidOffset      ;
+  uint8_t  Padding8              ;
+  uint16_t AverageSocketPower    ;
+  uint16_t TemperatureEdge       ;
+  uint16_t TemperatureHotspot    ;
+  uint16_t TemperatureMem        ;
+  uint16_t TemperatureVrGfx      ;
+  uint16_t TemperatureVrMem0     ;
+  uint16_t TemperatureVrMem1     ;
+  uint16_t TemperatureVrSoc      ;
+  uint16_t TemperatureLiquid0    ;
+  uint16_t TemperatureLiquid1    ;
+  uint16_t TemperaturePlx        ;
+  uint16_t Padding16             ;
+  uint32_t ThrottlerStatus       ;
+
+  uint8_t  LinkDpmLevel;
+  uint8_t  Padding8_2;
+  uint16_t CurrFanSpeed;
+
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclkFrequency  ;
+  uint16_t AverageDclkFrequency  ;
+  uint16_t VcnActivityPercentage ;
+  uint16_t padding16_2;
+
+  // Padding - ignore
+  uint32_t     MmHubPadding[8]; // SMU internal use
+} SmuMetrics_NV12_t;
+
 typedef struct {
   uint16_t MinClock; // This is either DCEFCLK or SOCCLK (in MHz)
   uint16_t MaxClock; // This is either DCEFCLK or SOCCLK (in MHz)
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 3a3c555f0e82..a34beb27849e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -456,13 +456,18 @@ static int navi10_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	struct amdgpu_device *adev = smu->adev;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
-		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	if (adev->asic_type == CHIP_NAVI12)
+		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_NV12_t),
+			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	else
+		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
@@ -473,7 +478,9 @@ static int navi10_tables_init(struct smu_context *smu)
 		       sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(adev->asic_type == CHIP_NAVI12 ?
+					   sizeof(SmuMetrics_NV12_t) :
+					   sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
@@ -490,6 +497,11 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 				       uint32_t *value)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
+	/*
+	 * This works for NV12 also. As although NV12 uses a different
+	 * SmuMetrics structure from other NV1X ASICs, they share the
+	 * same offsets for the heading parts(those members used here).
+	 */
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
