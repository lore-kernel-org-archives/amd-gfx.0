Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50FC43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32AC206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qduotEB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32AC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7946E9AB;
	Fri, 16 Oct 2020 03:28:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0796E9AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjbmo4SmQPA1Kxzqe8bIXHDYj0P8BRTE78z0xHzIF/X2KKbntF58AOjQeofr/TbcVc09uiviv99KW7UOcszBjEnQEZDIreEugqTgGl+svkrV/4043dWMY9QV7rRbkE/ZS0bhaZcBTQqARpgNE5Qt36V7C4dfT36AyY1kJStfFaYiXgVq2yIeZ7Ru1yAiWA/CbXVHXc5mJ1Gfrk+G/qBKa5KkIn/WC8PF45O4vrH7cJzf6OlzAGczJ/8+HDmflQBab5y62Vd+NF/egtrET3qHLkcWP7OFGOrvx8/iypK6N9Fe7pGusYTyADzcsv//ghyZV/hvv7kT6CUfSfzJ+1I2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjsWTZZMgqJ8TimwB9KO/BPazcbXF7rqCOmfqnGjSFs=;
 b=L/DD2Owo8mQqW1h9dRlSuJksvFvD+Y/IISi5ZkneYfigc5/kmWkWRsX6ujlGqr56mEJp9V+X9Ow1SrjWLUr2tLiRlC7aqTe8M/YUB1EKq6VaIl9SY7CBOCy2n5tDIzCe6NfMKxLZ/YZaLX4JCsKYnonhVer96ZvQptnPkMU1ltOlNkRJyAB0kYNx+Mw7A3Kq40mX5EedBrqhDg96q6E+58qIP+j96Tt+ZkQfqTcm5sVzCaArkn5Bg/kt4iEipR0uHUaNsl8IvhOL+XuaTfjfExtovMf50XwHEJvnOu95oQb5vLcM3xxoYUogT41g2yhMwuyc2yiGAUYhc5Y5wjDwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjsWTZZMgqJ8TimwB9KO/BPazcbXF7rqCOmfqnGjSFs=;
 b=qduotEB0hNJkgNj3ORpNbfNnww+NI0yZaV1T7q1eksYangLRa3puBKrC07RsWwS2FqS62XqMPsH/IfRilX1i9sl/JcegpTBrI5QincXWpJ87jZDbU/nApfMrY0ghfjBCtTCKauSNywmggQg1WMP05ykz4AcEscxDLTzCGR33yyw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amd/pm: correct the checks for sclk/mclk SS support
Date: Fri, 16 Oct 2020 11:26:34 +0800
Message-Id: <20201016032652.507-23-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2832b920-1581-4e8a-f4cc-08d87183823f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135456E03C9BB1FC2882D8C1E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4+guj2KvaKoWoPWflq+QlakvVP5dCeakDnsYy9UcrEBMici7cdWhyxdohMzpa+3pRDCUEVDniU5V15sYjrIz4QA3ZAN+XDjqu1eaQww56ewpilbgL2VlFdWyNKC6DFHSu2IlVJUxAOQlsBNaHSNUGxkFOdl6ajSAwS+KZQ/vNcBqGWeeYfn7TIWVGO+ZtPMdMvGq9bj2OPxNfQfWHEEiAmUgcRzvi+5jZj2SgKMrzbC2xQhJGC+i19+brQjQQP1oS2bjR/hq1O/95hYR5mvStxmFY0iKeKKAt9jdrZoSCq5tH3bxYfUMGa2mi94hbJmqZQFjj3xTsRzz82zF8PpHl4nTPLsg5xhZalfJnUrbmMPMEhmfptwLRVjnFFOBl27
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rcakbS1aInXfvqPpCvJ9P7YvFG7AqASdD30FUGuZSBw+J33bE6fouZ/VewsZWzppicgFHAU6bePsaEyI0/HupaKxmRsHmfMH6NIMfMww6wfkdLY1Hl+WoYw28cAyexIxnKiMWaGIxB2s5yuIVcddlYIO8hGQt1I/zQzhv+KSvuhz6Kf7rglHSffSNUuBFvu60ooDp9umL7smBOtS8E5m/Dr5stpg+0YsSe0CSEIFjnjMMqefcdz8yGNo945TpSbTI7HQWyCXSWHnsYN+Ht6FaiTDtsOcKGSLZawK8pJAvmi1Qduhp/EzbBBhL9MI3rNl8n3iTzYx6upOe5Dz4USQ4mPZhnWBjurlvLMkWXSOPdLIAmwJN6ZFPIQqNqYTg9olCpQFNtqcwrkCRHwmoJcug+tWCesXTU0br/k3NQRXXIw3j3APdYkSjfnaOin2TG5gWJ9ON6EfmsNIBEnQYfShou3oQxY0Z7XIRv6ZHYENgaT3dXlyAyJj8ktty8PBMI3LWSeEkla2M1F5ysV79lkWppI9jifoF6P6RGI2kO0jo9Ah/jQ6BxvXF4Wt+EvGamHX3fxg2jq9xaoJmQDtkRVLdmQ8DW2BE4iaO7/V38uMAnbxdyXa2pzR3j8wB3jC+fVXl29Iqv1trIVFi3yEsJdJUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832b920-1581-4e8a-f4cc-08d87183823f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:11.3928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA/zbmEXpb0uDxpaZhorJ9PQcdO8t44BZpV6LlueaQz9yqc3YelE14i4P1UTIw0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct sclk/mclk SS support checks.

Change-Id: Ic3842b06aa632d5bfcee09a2119dbbb74d0f008a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c      |  5 +++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h |  2 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c |  7 +++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index f48fdc7f0382..68a7aed16196 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -478,6 +478,11 @@ int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr)
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 						PHM_PlatformCaps_RegulatorHot);
 
+	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+			PHM_PlatformCaps_MemorySpreadSpectrumSupport);
+	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+			PHM_PlatformCaps_EngineSpreadSpectrumSupport);
+
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 					PHM_PlatformCaps_AutomaticDCTransition);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index a553ae312e65..401b3b516db0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1231,7 +1231,7 @@ uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr)
 /**
  * Get the asic internal spread spectrum table
  */
-static ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
+ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
 {
 	ATOM_ASIC_INTERNAL_SS_INFO *table = NULL;
 	u8 frev, crev;
@@ -1245,6 +1245,17 @@ static ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
 	return table;
 }
 
+bool atomctrl_is_asic_internal_ss_supported(struct pp_hwmgr *hwmgr)
+{
+	ATOM_ASIC_INTERNAL_SS_INFO *table =
+		asic_internal_ss_get_ss_table(hwmgr->adev);
+
+	if (table)
+		return true;
+	else
+		return false;
+}
+
 /**
  * Get the asic internal spread spectrum assignment
  */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index b3951b19fbfc..b3103bd4be42 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -296,6 +296,8 @@ extern bool atomctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr, const uint32_t pi
 extern int atomctrl_get_voltage_evv_on_sclk(struct pp_hwmgr *hwmgr, uint8_t voltage_type, uint32_t sclk, uint16_t virtual_voltage_Id, uint16_t *voltage);
 extern int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr, uint16_t virtual_voltage_id, uint16_t *voltage);
 extern uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr);
+
+bool atomctrl_is_asic_internal_ss_supported(struct pp_hwmgr *hwmgr);
 extern int atomctrl_get_memory_clock_spread_spectrum(struct pp_hwmgr *hwmgr, const uint32_t memory_clock, pp_atomctrl_internal_ss_info *ssInfo);
 extern int atomctrl_get_engine_clock_spread_spectrum(struct pp_hwmgr *hwmgr, const uint32_t engine_clock, pp_atomctrl_internal_ss_info *ssInfo);
 extern int atomctrl_initialize_mc_reg_table(struct pp_hwmgr *hwmgr, uint8_t module_index, pp_atomctrl_mc_reg_table *table);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 27ca0e6b724f..03a139f2c426 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1811,6 +1811,13 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	    (adev->asic_type == CHIP_POLARIS12) ||
 	    (adev->asic_type == CHIP_VEGAM))
 		data->disable_edc_leakage_controller = false;
+
+	if (!atomctrl_is_asic_internal_ss_supported(hwmgr)) {
+		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
+			PHM_PlatformCaps_MemorySpreadSpectrumSupport);
+		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
+			PHM_PlatformCaps_EngineSpreadSpectrumSupport);
+	}
 }
 
 static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
