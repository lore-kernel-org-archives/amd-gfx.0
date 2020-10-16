Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F091C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E163F206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FkpB5VUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E163F206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CB06EA7E;
	Fri, 16 Oct 2020 03:28:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7EB6EA80
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXum89qnn5TxF/cOOxjZ0hjyAukzatE2ykshmXppZMzvgoLpdbmbwH52ByKFWUe7E6CeNHLxdxmjA9A0LvbyW2ELnPS94RG2Aene4H/wGewRgHZhEQGlhk+b3D3rhXlXRhmJ0kcgtdYFkOTRTLivp/0jHR7P0GlM7EBM46gShsBWTPvyP+l7rSvMNTIpfzuVdODLisrSidFtm/3qd0+MJKu8EMtsZtqVr/m9vbo1F6z0G/eN0WhXSuSQpehF/guVfwJfEqJig/rGMpRugI0P2tnShlZ6Z2rMPoh5dgvbKcUhYGNv7z7K5sPimN+Cr3t7tUNpd49RQ6FuIbfj5qBdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqOuNHpWraRKb1ELwPvonwaJ94ps0AXPRJ8bwQXaHlk=;
 b=M3tqSRn7Ed3DLZ6sG0d0vQsaQhNwINt04KcLvxI7siJS2d5Zt/3toK5X176c0I6tibdb1Q6bvDvs4fjunu/TkV5LWbdYAzIOeiohwqVjdj1slIePFwUVd4rDRCt3AuQBIkziTpuagvKGs7uN7Dz89WxJLo1uNv4ZbgS7jxxQibKPzrMvrtXIFOACQ+vWiRFaFHWZL4TWuFEg9xEqZ1TBT8k5CKOubAaMCLK2nh1aAgFFgLG/fGgIhJdtB84pT/7bXXhmHAKL2KIRfPfHpO9i4czi9kfE9+LBSjhHiXZxNinuXQ+CRctJTRJrZeXfBstQKFbnNkJk1OMeOGRb+kMPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqOuNHpWraRKb1ELwPvonwaJ94ps0AXPRJ8bwQXaHlk=;
 b=FkpB5VUVt9f7Ix2S0eW8eFE7mWTxlILN09/HO2G4So6ToaXpUeo6LPmlcQYcfooaTvi1j4lw8Pwd7gMP1gU5COdUx7a9eLH1VPXvVgDS3VbF2xYKD7u18f4iPTFMYHI25KpMEULlHDjy1uPbIEfO1+z1uNbT5gu2LKykKZDqIsY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/40] drm/amd/pm: correct VR shared rail info
Date: Fri, 16 Oct 2020 11:26:33 +0800
Message-Id: <20201016032652.507-22-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cff777a-30f2-4a50-0b33-08d871838130
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354BC21731DE056BF500A27E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaD4SfJJFeijm44IYxqlo7Y1H3uf4BVM0O1JG8hxpVGj1599+MfnIlz0+ERKJ2cKTCwYmbIuTmUseA4zoiBu6+Mvb6v5NyXRik1s6xdFs+2M5FeSYtF4hsy476xQFM4j73SJTTXXjtDtG2GJmY0z8cHTWySywVPq3h8GTrI1Dbh1fhWwEG+c3/QeCPDayPn50Rshhd/E3nA5FdbY56DQsavJSjzcDpP4cvIIPn3SGIIqm5lbJ7kciMO/uvLZwRagSVpB/wgH2ZkrmWHPgp6h02mdc+4O3K4JWvB9sb3gIvB6sUfQjhsT3wgtGYJjsYPuamDm1rxgjJJxvRHF7y/HlLLvhi/yrCVtSa23ogt9M66IWG+l0mSkVCwnhj9Rjbds
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(19627235002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dvVu2J4CmsYKZkOHZr7CFqQmcDUhiYMNqqFqR+l6MO0XEsVmkPNgkPI0MdTKc1cq8GNvKUfJ/rOviOtJX8pqOudtN37zJXHwm6uA2bWyMwbkOegMMxlQJ5JmpHlD8kXzzIBWiDtK77R2a2KRRKkACGFO+DWxp6U1IoqabxpnbqCE5BGdxrOMdQ6Xgk0B3MZu8skllq1NUIYLuIkBwg+grPtm9kb8Rx930Uc+Vjwk8kt4uu3VJaP8L7RjyW8Jzm9jgB54IiSNqrYN3Li6LPOdq4Oi0VzkQo1e0EU3RVcUrPvoC4gjcvSVLHoQpOXr9qK/zdofYO53J8Ti+fKmna3IcAvc3cqXLugfEex5ljrQnVsIsWjoCsh7pHnjynMeMXiSTmGju5kTWatpEEk7OsjnA785eDhrTYYOR5RGjVdcD1IaRoGz5X7W1ISpPxWh5mFdD2n5IyMzmJNiYyayUdmnkbFkQz5Q/HSBNlg6gcSE9LBbfc08o5HM1UpiJ7LS7aMl7HEsSQflNTIbSF3YoZT5DWFi3wXeAasIqHvch/l2MR8cepny1vxb8ayC5M+kFoo0KC5nB7wsRhtkuKeqM3l/1F7nvhe5O/H4qnxXpRaT5jkq4xrTmbWTAHjxodrQIrQtST69yBENXir171mHDJb5KA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cff777a-30f2-4a50-0b33-08d871838130
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:09.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFyE+IzcFgQxjZFzowzQ+ISKMhuv/6S/VooUeh5Uka0emeOuFKJvjwKSpTSIZfLC
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

Add VR shared rail info.

Change-Id: I6ea756c42586c10543489dbdf558ce88c2416e1c
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atombios.h             |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu74_discrete.h        |  3 ++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    | 14 ++++++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h    |  1 +
 .../drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 14 ++++++++++++++
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index e6548bb6cad2..c1d7b1d0b952 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -5636,7 +5636,9 @@ typedef struct  _ATOM_SMU_INFO_V2_1
 {
   ATOM_COMMON_TABLE_HEADER         asHeader;
   UCHAR ucSclkEntryNum;            // for potential future extend, indicate the number of ATOM_SCLK_FCW_RANGE_ENTRY_V1
-  UCHAR ucReserved[3];
+  UCHAR ucSMUVer;
+  UCHAR ucSharePowerSource;
+  UCHAR ucReserved;
   ATOM_SCLK_FCW_RANGE_ENTRY_V1     asSclkFcwRangeEntry[8];
 }ATOM_SMU_INFO_V2_1;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
index 899d6d8108c2..350889e408d2 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
@@ -271,7 +271,8 @@ struct SMU74_Discrete_DpmTable {
 
 	uint8_t                             VRHotLevel;
 	uint8_t                             LdoRefSel;
-	uint8_t                             Reserved1[2];
+	uint8_t                             SharedRails;
+	uint8_t                             Reserved1;
 	uint16_t                            FanStartTemperature;
 	uint16_t                            FanStopTemperature;
 	uint16_t                            MaxVoltage;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 0d8a693b77e0..a553ae312e65 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1427,6 +1427,20 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 	return 0;
 }
 
+int atomctrl_get_vddc_shared_railinfo(struct pp_hwmgr *hwmgr, uint8_t *shared_rail)
+{
+	ATOM_SMU_INFO_V2_1 *psmu_info =
+		(ATOM_SMU_INFO_V2_1 *)smu_atom_get_data_table(hwmgr->adev,
+			GetIndexIntoMasterTable(DATA, SMU_Info),
+			NULL, NULL, NULL);
+	if (!psmu_info)
+		return -1;
+
+	*shared_rail = psmu_info->ucSharePowerSource;
+
+	return 0;
+}
+
 int atomctrl_get_avfs_information(struct pp_hwmgr *hwmgr,
 				  struct pp_atom_ctrl__avfs_parameters *param)
 {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index 3ef3ccfa6aa7..b3951b19fbfc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -347,5 +347,6 @@ extern int atomctrl_get_edc_leakage_table(struct pp_hwmgr *hwmgr,
 					  AtomCtrl_EDCLeakgeTable *table,
 					  uint16_t offset);
 
+extern int atomctrl_get_vddc_shared_railinfo(struct pp_hwmgr *hwmgr, uint8_t *shared_rail);
 #endif
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index c4590a43a4f7..6afbd138f4ea 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1016,6 +1016,16 @@ static int polaris10_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static void polaris10_get_vddc_shared_railinfo(struct pp_hwmgr *hwmgr)
+{
+	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
+	SMU74_Discrete_DpmTable *table = &(smu_data->smc_state_table);
+	uint8_t shared_rail;
+
+	if (!atomctrl_get_vddc_shared_railinfo(hwmgr, &shared_rail))
+		table->SharedRails = shared_rail;
+}
+
 static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *hw_data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -1041,6 +1051,10 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	pp_atomctrl_clock_dividers_vi dividers;
 	uint32_t dpm0_sclkfrequency = levels[0].SclkSetting.SclkFrequency;
 
+	if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P30(adev->pdev->device, adev->pdev->revision))
+		polaris10_get_vddc_shared_railinfo(hwmgr);
+
 	polaris10_get_sclk_range_table(hwmgr, &(smu_data->smc_state_table));
 
 	for (i = 0; i < dpm_table->sclk_table.count; i++) {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
