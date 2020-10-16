Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AAAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFA2206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nptiaKS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFA2206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3416C6E1A3;
	Fri, 16 Oct 2020 03:28:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C186EA7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxGMP6a4vHrgDoWDPwpQkUv+48FBPssRCQMQKwMT9ywX+ou9lY5aS/T+dgUmEOAmJ5eZVl2K/1zr8+qd8CjdkKIAkt+KCYJBf8GGl5G503dJHcoNaBOh0qYGPV/tQPLaLNgjRPdYaneJfYfgQ8eof1aCqJlJ4UosdX5gA6DIVh/ldGTaCdlVasnWHzYRwkTja2lFxZ3Y0+Zgp20ZVeIgZtQIIa9N+X7WMTIfZkiH45pY7F3VmbIB43qj7fOBlJXnBAzDc5SDuyu2V195VX0z0hiUYn/OONUlVwPLV7peBS1jEbo+il+infaPGHeeI27dzQdOSQHhJhm8WzRu2UBMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMzm8Iwta3lFbv1VSg+lt+VOPtpe+dAkDtOu8iQm57A=;
 b=EXpn3pX8QLlj8JzTlb/yvTRrELzRU+LQH0rxXIvWisahPfs9CsS11OnPXIB9Cp604ZdvW/s9S6Xa2z532UP1dS1fGUuwyU7A9J44k6MR/bXWsmC4gT1j3NOq60EYARWI1bm19Ri+N4r2hXDsZMXDQi/3T7mC+tYAeloBlknjI2CiIvoaGvGKY2q0yQsOGNzIFpZYpEbx8PRUj+VLPjohRDLxB1fu1eb6NssFmH76gxVHfvE8A6AQolp0On70qDCY2gYF9pLQtkyclSH4hvRB/2Mx7ALcCw3h/nMFwIB3SY9OnIphKV4AnZET1ftzOUjnJu5w/cgXtxTvTbiqBq7C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMzm8Iwta3lFbv1VSg+lt+VOPtpe+dAkDtOu8iQm57A=;
 b=nptiaKS03uqTf8PX3FwFzBEQHF0l7gB2sGnMMlHeRAr57D3Si5S1Phj3Ku5m1EB4a+GbM8r8A60lR95oDhRnw8+PMERyxs9lRyiM3Qkw5IimQi9d8SFSa0BOz3moCl4bc06c7m2GY61FJadxFWdEFsiq7/IHDdK0jvj4Pgta81o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:02 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/40] drm/amd/pm: correct polaris10 clock stretcher data
 table setting
Date: Fri, 16 Oct 2020 11:26:29 +0800
Message-Id: <20201016032652.507-18-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ab236e5-e173-49a7-00b4-08d871837cf1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354B97D8804CAE6707C9F07E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGZYBWc95HlvbJasw0QbfCX0jm8isJLRTJgv0cstMXDxmDfDNpmo0xUtg9cWO5bCmKmCPqftHHyBuH/13MUpQ7Wt1SkLgeovP1E2wcr29g4szAv82KkZJXbfQuyYr95cmGxSsE3tekD8MuDXOO9YnLqzxbzwNqgySZSb1sr2eUMnSoGWYndKGfDAXSAJyuhKqIo7YHHgf0n3reppBflkEg/40RMh22KaQv6EiJooHAk4ZFsh08xbkHmotpYDbqIcgmekfasdSYuY3INrVcbnLPmBWjZ2znU2VunMtZ268RKpbvOqgZvrQzQIcmv3aF4S4ouh//p1f38HenBuKsLbF0XMX2q8Klxcl7txk3PE97Q3IUqkI0iHVCuxKCq1fVhg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(19627235002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gTNtlGQXTSloPR25o5J7fF4MCrMxiM8LklEHF7AHoX/uP+m8Gfe2T9ox2wiEyKUbT3eon9Xkj70WwAe1Y0l4s+JV490p8m156PiR5/Wx28vPd8Vw5T3PUsQnqIZljEvLMnLjk90f9IZeJLn7UOfNuKUTVpoYGtRqcaGWWRWCwzWpLEvNOX8zTGQwxhDxPPGkJrrUrLmA93Kiy0MiAmSiNMHvY85vBB/Dh3q6GWZQ7qGCUQK+ZgiK9hFmpv0MQ/RDlvg1+9LBgmBAPJc1wGEVPJ1B/LbyhV3nORpPd0y129sKir4f7d1HJKQM/9aMTLwvQletu0OCjNIeZK0p89MWe8ce6sC7/Iq53Tz8azaRcmJ9zk7Hbp2SITIUlzbHt1EIAwnxvx8aZDjrnFhLqsdfTjWdOoXNXE8X91P3F/85gY3kSwyKA0Ls8Fb1zlTPLARY7qfQCE7YfSN+2WhuEBpxAzm//dDQ9zvRGeW6Rr7pFkubeQdkQLNCCZpw0RWXvBhL4DSUQQ3HNEqKnI4GIHNN5KxmnQIMXAWRj+6D4xhjv12him/54l3ZHsQ0i5wS7rzhfN8hxs/SjNMybbOzQbLZNNwN9eR8BWO0bqlMQPdIhVkKJ+I9ytjZeTpIWAkbyhUHTi6dxm2IdzwcFQoTw/ZUHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab236e5-e173-49a7-00b4-08d871837cf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:02.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PLQfiCMtAIkqq+2I+T1a1Kg5lK6uy8p7VRYwOlg8p3r/JZVPgnb6NPPJKAOutCM
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

By using the saved copy of ro_range_maximum and ro_range_minimum.
Correct the setting for "LdoRefSel".

Change-Id: Ic6a842739bfba88c90c23bb712da688c8234a635
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 42 +++++--------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 0c55574bff7a..9b7e9ddc5a1e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1600,49 +1600,28 @@ static int polaris10_populate_smc_initailial_state(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+#define STRAP_ASIC_RO_LSB    2168
+#define STRAP_ASIC_RO_MSB    2175
+
 static int polaris10_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 {
-	uint32_t ro, efuse, volt_without_cks, volt_with_cks, value, max, min;
 	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
-
-	uint8_t i, stretch_amount, volt_offset = 0;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table =
 			table_info->vdd_dep_on_sclk;
+	uint32_t ro, efuse, volt_without_cks, volt_with_cks, value;
+	uint8_t i, stretch_amount, volt_offset = 0;
 
 	stretch_amount = (uint8_t)table_info->cac_dtp_table->usClockStretchAmount;
 
 	/* Read SMU_Eefuse to read and calculate RO and determine
 	 * if the part is SS or FF. if RO >= 1660MHz, part is FF.
 	 */
-	efuse = cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC,
-			ixSMU_EFUSE_0 + (67 * 4));
-	efuse &= 0xFF000000;
-	efuse = efuse >> 24;
-
-	if (hwmgr->chip_id == CHIP_POLARIS10) {
-		if (hwmgr->is_kicker) {
-			min = 1200;
-			max = 2500;
-		} else {
-			min = 1000;
-			max = 2300;
-		}
-	} else if (hwmgr->chip_id == CHIP_POLARIS11) {
-		if (hwmgr->is_kicker) {
-			min = 900;
-			max = 2100;
-		} else {
-			min = 1100;
-			max = 2100;
-		}
-	} else {
-		min = 1100;
-		max = 2100;
-	}
-
-	ro = efuse * (max - min) / 255 + min;
+	atomctrl_read_efuse(hwmgr, STRAP_ASIC_RO_LSB, STRAP_ASIC_RO_MSB, &efuse);
+	ro = ((efuse * (data->ro_range_maximum - data->ro_range_minimum)) / 255) +
+		data->ro_range_minimum;
 
 	/* Populate Sclk_CKS_masterEn0_7 and Sclk_voltageOffset */
 	for (i = 0; i < sclk_table->count; i++) {
@@ -1667,7 +1646,8 @@ static int polaris10_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 		smu_data->smc_state_table.Sclk_voltageOffset[i] = volt_offset;
 	}
 
-	smu_data->smc_state_table.LdoRefSel = (table_info->cac_dtp_table->ucCKS_LDO_REFSEL != 0) ? table_info->cac_dtp_table->ucCKS_LDO_REFSEL : 6;
+	smu_data->smc_state_table.LdoRefSel = (table_info->cac_dtp_table->ucCKS_LDO_REFSEL != 0) ? table_info->cac_dtp_table->ucCKS_LDO_REFSEL : 5;
+
 	/* Populate CKS Lookup Table */
 	if (stretch_amount == 0 || stretch_amount > 5) {
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
