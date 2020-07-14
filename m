Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEAEC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C692075D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hte7Qd2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C692075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B987892E6;
	Tue, 14 Jul 2020 08:04:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D294D892E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXrkmaenz905GHo9jBrgwZkP9/ZAJJC6SB2Wo1Rtc/1XFnnTssWQwdkwSHXsT9fPX0SbombkNIkzElfDzcqDHZDWfgegBzHFlheR7dNV1da+H0/oXRnNODuhhc8yxDUXnuVGx+Llcss8ZC5Qgu5I05AkVIRld8EwIOPFZOgFWxUC+cj7nNcJGL/QdCz5KZ5IDNSTcSPYZmA+ZDjX6RFSqjc/0aAhGXpxB0YIE+lLrHl1JuvFtWRfU6tHeQwPfaazRaq3XXhwDDdsnylXJHKZQkU3i0v/AJLHlbjrx/Y9/U299sW3gxEiLajmmci+UIIRVIvQZOjFf+8Ez5XF97yWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AT2P/zJEXk2lXyAf/XIzFSdyWC0EQn6HAvwiJL1AJ0=;
 b=SywmGnaa9uuvQ2VEgxjvBRCj3mKhyV+N2PmNiOHmWGX9HedPVhl8XeWqCn1bbemfgSypUb+2nwGIh26BMQCfuGsZIHZ2HrFAZxw8p2E9FxbnPYQ/AsM7aDJyZxFJYT5EBq0eKkzLKxRKfevypuyTdSQVjzXl7RNzHHpu6anUJ8gk6k0LrXP4RYCA6CK+ycPeTO1vz576KKdWdt4RwsrjepcevEGTo3N3Kyq2vDy/h86F9pHVQzkkqc8esNdFnjz34VjtvT0hEhxg3YhrrYbEhUqR+JDyuwY3DjgMSoongTpaTGqQB/sqrRgQNIODAMmj3Eg58YTWne9ZB11woGzC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AT2P/zJEXk2lXyAf/XIzFSdyWC0EQn6HAvwiJL1AJ0=;
 b=hte7Qd2U+iSqPMuQP66E3ptG2ma1dCzF+Tvff7MASzRnWVbpFOYKwIfk77+oJsib5b/YIWkuioE8OOX1UCSIO33zPPY6PhxOba6+ZbDuj1Oz4mV0934tm/bUXjd9mhA+/IQr4hGuzPln2A1q0fAGlQmeYavHoDZUMxtr5QAXJTc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:04:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:04:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/17] drm/amd/powerplay: move the API shared by SMU v11 to
 smu_v11_0.c
Date: Tue, 14 Jul 2020 16:04:00 +0800
Message-Id: <20200714080416.6506-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:04:40 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93a73234-789e-4def-e959-08d827cc8fc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43559BD6D9C3CFA858499FD3E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:75;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jUS1sf1Q2BMXuKE7KpQuWkCwdZsxrON5iWwj9LrXtYU0t7oPrN+lT/HKDl1MXR2wyqaq0xs39+G89EFyO6RGRmzuToYteVMAQj9gnG/1YsIJ94RlB4ZqXlFCzBXh67OaAq7m1HneAnhc8RZWtftKEoyz+zEZUuHcjfdHMg/GBCpThAimuAY4MKswKh6Y8Ygz/j/yqsCjisl8Mh3167nCKyYndA4nh/5t0mKvCFwmbBcuMQiOwdl30uUdofRLa+sL354TaWgRkZYy5ZMXnUqBfp9nFYSLHfSCbf0uFYGagfNIWvTRxNvzb0ExZewdds0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +8cHg4EZoI3YFedLPb63q9uW2A9IccUpCiMuaH7vui1jj0dinRR1JLUJHppLavYlrNaBZ/LTGiTcDAzfV183BiDRGJXs4heDfaq7sQse/mmyJLtkeWzMDxKEiDW2T0kLKOc/eqFWYuZQl4xxO1587DLDS0hqHouF6J/zoPNmnLiwgh4PPBL+0VCYVLEHcz1XBTGHuLgTLiJpCCwaKsPfIMxS6GEsI046EdMrBpBoI8EY8BXZ1MCjaCK94QlZWMhoJYbs7R3P5E1qYDNyfZNXJStujbWxoCSbtzxQPj24NUeFSGecerXY68DLdrFBQZzx2R4Wm1eW3VYznOzeSbnFS7xMzt5r5SOC45Ji1cS3qyTPu2oKChUjaAXI5rhoecIZSjFJMrjh2LDBYaVKaxiDluW9UvcI639zM1sAHetpxFUFdmJTzLDe2N6qm8/AvFdIO73o1hqKv55Ehcl2m6p6I9wk41N5lHfIbiykmIp5EiOzqtuUdSKSNcdr76fDitAY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a73234-789e-4def-e959-08d827cc8fc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:04:41.5228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBed6YItsDPrT37QEc/PXIyfARCz1gnPluHcrL1vMjs9/5coBtHm6c5iXDmTsGDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

To fit our original desgin and this can help to maintain
clear code layer.

Change-Id: Id89476c14709b5676bbf043371a27f27b94a58ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 16 ---------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 ----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 ++--
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 16ff64644e2e..0daea412d0a0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -675,22 +675,6 @@ static int smu_late_init(void *handle)
 	return 0;
 }
 
-int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
-			    uint16_t *size, uint8_t *frev, uint8_t *crev,
-			    uint8_t **addr)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint16_t data_start;
-
-	if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
-					   size, frev, crev, &data_start))
-		return -EINVAL;
-
-	*addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
-
-	return 0;
-}
-
 static int smu_init_fb_allocations(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 56dc20a617fd..03361d0194fe 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -488,7 +488,7 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					   smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 52e5603dcc97..28894b8bab67 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -674,10 +674,6 @@ int smu_baco_exit(struct smu_context *smu);
 
 int smu_mode2_reset(struct smu_context *smu);
 
-extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
-				   uint16_t *size, uint8_t *frev, uint8_t *crev,
-				   uint8_t **addr);
-
 extern const struct amd_ip_funcs smu_ip_funcs;
 
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 9b724e4aceaa..8a4053d8eb8c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -175,6 +175,10 @@ int smu_v11_0_fini_power(struct smu_context *smu);
 
 int smu_v11_0_check_fw_status(struct smu_context *smu);
 
+int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
+			    uint16_t *size, uint8_t *frev, uint8_t *crev,
+			    uint8_t **addr);
+
 int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 41bd6d157271..ff717b800086 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -467,7 +467,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					   smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
@@ -487,7 +487,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
 		break;
 	case 7: /* nv12 */
-		ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+		ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
 					      (uint8_t **)&smc_dpm_table_v4_7);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 48c5424f6f37..8a25921d28a9 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -398,7 +398,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index fbd561a4d0eb..416aa536a57e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -370,6 +370,22 @@ static int smu_v11_0_set_pptable_v2_1(struct smu_context *smu, void **table,
 	return 0;
 }
 
+int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
+			    uint16_t *size, uint8_t *frev, uint8_t *crev,
+			    uint8_t **addr)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint16_t data_start;
+
+	if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
+					   size, frev, crev, &data_start))
+		return -EINVAL;
+
+	*addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
+
+	return 0;
+}
+
 int smu_v11_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -406,7 +422,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						    powerplayinfo);
 
-		ret = smu_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
+		ret = smu_v11_0_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
 					      (uint8_t **)&table);
 		if (ret)
 			return ret;
@@ -621,7 +637,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    firmwareinfo);
 
-	ret = smu_get_atom_data_table(smu, index, &size, &frev, &crev,
+	ret = smu_v11_0_get_atom_data_table(smu, index, &size, &frev, &crev,
 				      (uint8_t **)&header);
 	if (ret)
 		return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
