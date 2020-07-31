Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C897C2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ugntwNwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BB96E993;
	Fri, 31 Jul 2020 02:44:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F66D6E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsyUk2a9iDlCq54MPBJdOVRzzgNlnn1RETSMKQhRAgNwoTwZd+lE2rWMJeCsK9SxpvM5dmc7kS2ZhS7a6XQzEHWPg6hXEohdBOUbc9PPiZRMnUBetWyQq8QleFylJQuMypRdZ+J1Bg0KbjbIEKwOJuzlPMmYIT2sv7dBxlPy5A2/cnLtZS+MOXfjXDbBBQ1MGTBOaR5V7x0kA0mnEUFwIGzVdIyvgsmx5mzW5gCjK3DG1NhONpnedOB6lTVJClUdFoRO9vgUy7jyYMGdhjl1YKIliKy6HVGlOxnkwu/uNS+Tl2+atSiy22w4G7oZQyCwnpdn5p/XOfFNd0NSQLXEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx31KR3Y3u/ei/1ksWaM4/2w3GAQgii+OZTaJpPQMAU=;
 b=jMRhXCXGp9sMMaiY6LSnxvVl9YQoneTtCIy1Pd5/+USy7fT9JUxJ2s69gE5l/F0S6FWn2+6HBqjhZphUv6KkWu8ujLfcax6iBBlwE3lyB6k4XMR9QlcrrYs9CG6rPb6JJdJYpvqav0jbegd4zuqNbU5q8VAj6S9KYM+cYI2zd2gtcwn8H49Uml3OVOyvWt7x9c49YbHsNtZgreKSZPT+c06+3vK0gvchtl8vCDpfTX9P33oC22w6SEssX/cw3OnCGmNHteUhobSY8M4xcWBJzaa4Pag2wacRtggCRajQb5ezlTPXYcuyrgVc6gil0KVJbb/U/swQq/C9/g57kibqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx31KR3Y3u/ei/1ksWaM4/2w3GAQgii+OZTaJpPQMAU=;
 b=ugntwNwCyKVF1uMIyePie+//L987y93LCK97gm3jVPN1EOzRZZ4AxmRh6u8eHkOOyuPnL/FslOcE+un+6nVlDIU82teVSidg6OrUXruEcwI/UPMm1tj1PotY/HR4hJ0uggqrH8QZu0HXBlDJOh5xda9OGnhvB0KZINz6K6xf4ik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:43:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:43:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/17] drm/amd/powerplay: update the data structure for NV12
 SmuMetrics
Date: Fri, 31 Jul 2020 10:43:04 +0800
Message-Id: <20200731024316.28324-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:43:56 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22a2f730-1622-4876-d0a1-08d834fb934d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435818F9295BA41838BFFCAE44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsoO14q5HELUPADkuDLB9YQIeaIBJ1t+SojxNHNS2c20WHyfguT7dULqGinDrEsbwKicrjYo9eTR4KnNYIlE+fKZCauZf/ttmuDQjadUJJ48TWkQVdoxbsKoCLbZDm40FSlkgi+aH3TcpqebrIzB8hEhdQYF+HCPvDMpP4LNLU07isiwj8N8YWx3lnvOBaqlFmJN72UODO4YBAqdLu8o+DX8dgQGCmAiUA55eA25G3DBN+JwGhuH5fv3hEkXeKLaLljasQe2d8iv+tVB7vGdNjvAWiowwYtGNweMd//vWPXHI4bjrVumq+XTAemkf/8ElxWqjK+cT9MrSpXdOiI+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6666004)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0rGI9na2Y+noVxuveUkez1pfMI6rCYWYTkuyjM/CqH0NKCOB9cJpJrpFx68rKFY59zPdLxS4MZeMdKzvTaNwjuLanQtDevXQRH1gXGjmCWzhTnSX25tVVOcSWpHaOiL2A/92efN9BA+UYuzM+GivmEygxIIcDYeioi2ht/0tCchQF1QPKq61sH9sBHtgmNGAmPi5Ey3RQGki1hwThXqr9obZ+uInKGzgKDw/v43RSqOfsfnyeoGsCArk1hEwo1pYjn8b44oYPc9a3mPFGhD4VgDZ2WfgtaUsdBKr7hJyjEvplVCp1M2qbe2mQq2z+YkRGEynltsf4jMIhUnVfVPHHHUqvjdYp3f6DuCLQPs797V2UFn6cep6j88TsM/sJ6ZR2s6nzUHb/hVCJ880dJNvzdKhgHRT5emJ0xdRn7xHiiuuV1D5JxOVV3nkaQHTJ+xcctrD018P3kkLT3yVffLqL38T7kX/WqZE/4mdqfhf/R6qURSsfe8dt43PnCXrHkijpPQanQPrX3A9JYWoXhAyrMMOQnm5Wn5qm3Y1wHj39fmXwW2UHw+CBUlLiJmId1oFfno4fYTYgE4Z/SRVw2BdTHfbDn6gaJ6u8rdPltB8AKtIriVkhFjO42LOYzvkSvcHjp/EyLkN0oSuwAeWOcXyUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a2f730-1622-4876-d0a1-08d834fb934d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:43:58.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juRtKjMVFuiu3QhMUKnmk1V6NgIIDm1D7I+IbSCZqRuAyMEKyU1ZIHH2ZjXDOEqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
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
