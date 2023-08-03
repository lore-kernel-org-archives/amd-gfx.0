Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC09C001DE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 01:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1707710E0A9;
	Thu,  3 Aug 2023 01:36:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB7310E0A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 01:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM4qwFz/qJJjuRi4iGBuxsXfL2wD4J1lKZVEOzbNugmfaWEA6/aYNssFkRHLaDZPg9L3fmd+DKlJZYy1Sg1AB4MxSg/FmTTrVskWdnhmzB66u8TxszDZgSZJf0EWJCAtiriFm6FPB85IdnFiLkgHiphZAltOwU745e3x0SvjEwMA172L0DLr3DuQhlknqrQ+4X08eu9O3BhByp92bfzja30W7ZAfkJsOmURN9xQ57EuDwQnMqbdYDZRznx0tfkrkKxOtmXTTBM6j8Tuq01Uh4TbjX1xZDjl0FbYdRfAjni+RKeKsJb0ay64yIcOfxF19lfSu76k4UGQDjqscUR2CQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdrwfKb4Swr366OCp/dB7musC3DbQ0gF75MK8wP0qXU=;
 b=f+u2XhKbEw+zhQsTVlcty6/0lcX09L0kV5qBlS8Mi0RTnx455Xs4UIzDpQdyzPJUJUWL7WwtDJDxpzSVfrUYFYTMlmbqQlySapWDc1EUxC8lgS+xSHnjjA9z3+wr5YlS/Az5VgjqpZyaPTtQKQP5Hc+AwVWxr4fX3M5POmoB5gxTysKMPY53QKrKqsecAOhN9V8P3EX6yt+YsvcTljTvCXnuPY8/2wyNvikXoLbvCHWcr1MHFcSyijFdiHb9Lwg2NuHLJMcCieEOptlWJ7VBC1VUxgzy3mI/t1Cwtg7hYZA+bx3vI3bjSCz28cbnfg7QPd+g2huLc7CDZjPdUy+ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdrwfKb4Swr366OCp/dB7musC3DbQ0gF75MK8wP0qXU=;
 b=Z7u229Sj0KPwP1Kcv68k7KtMYrBPLTG+CRYAYBoYfH8KHUNZqVCpo/g5PtI4gcn2Fb3CbCEPJMy3A0WqA6bLNXMCspFU0f8lBtytxDno7QvU1pU9z+Xa87s3iTC+VV4F7qiD2aq5YPvqDfpw9GCqhth+MVQbhilOqqPDb//PbqM=
Received: from SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::12)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 01:36:19 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::ee) by SA1P222CA0131.outlook.office365.com
 (2603:10b6:806:3c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 01:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 01:36:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:36:17 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: correct the way for checking custom OD
 settings
Date: Thu, 3 Aug 2023 09:35:58 +0800
Message-ID: <20230803013559.506617-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: cef0dad2-d35c-45a1-318f-08db93c20949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pv819frt+m91Qoucy4aR4igRczZNmEI2FCi/Y/7Gtw7O25im1E6sWK20nNJEkyk6ZU3/4eb8byNlYKRC6I1w0HYE1x+E2KiShTE/5VxBVHrbSk8A+uw2dEAPIWuB+O3exkVgzi4aGwKwjCwi7E3pe8P2cUI4SITtGYQJ7SG8IzVmkYtHc1lemJNmHf0MvJENwJWB3zfsIF99YEvKuXbKPeVknTu1NG6a8AjQmohWuSMqrQ9ZhcZ3gy8RR03rx9wvGuIXMGrzK1Kf1SRTc48NBR/nB6jMAueOM+mTSYGOI/NBH4zucSL4eE4QHzxuMjVWfOkBxPcr+Rwo980tiaVTeg5YzcIYumpvbC09cacNZA78iMBCxUBPffmQbRWAPLd2SBfqS0Qj27hDzlyJdvL3hp+P6zy8qa4sA5Eu6ka7MeynYmgFx/YLvvS2os6aXSzlsjj/mAlJneaKt+RZdZbTba//aVsqdIZOAnTo8JBulOAq9COzTIYsVFWilapws/s8PARsyT+Xio6K9OUdPiIEjjtggfo9LDaPn0l8odMeJiNUXWyyDRypN7xxpmurnDwXvanXaNzK7pG9VifbkGSjv+2cKxIqryxIL6gJsIqUvxlHKvAp3jVFPsD1MXUZEnk2SvXs/TmzkOj05TCqoJlEeUjOkfipp01NiPOD4U0fOiFzhpOxDfvlnYBzPuwHoWb2xBv5QSPpmV/s86OI0q5eAU+n6v56+cT0FCxI7pen5d6xPJCY9kjWBykfaLo/+yYwcq2QRZqBBycy4Ib8JfvhWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(44832011)(4326008)(6916009)(40460700003)(426003)(70206006)(70586007)(2616005)(186003)(81166007)(356005)(82740400003)(16526019)(2906002)(336012)(26005)(1076003)(83380400001)(36860700001)(47076005)(54906003)(40480700001)(478600001)(86362001)(36756003)(6666004)(7696005)(41300700001)(8676002)(8936002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:36:19.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef0dad2-d35c-45a1-318f-08db93c20949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`FeatureCtrlMask` should not be included in those settings interested.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 16 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e2265f50bacc..2570e03e0fa7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1360,7 +1360,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t offset_of_featurectrlmask;
+	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
 	uint32_t feature_ctrlmask;
 	int i, ret = 0;
@@ -1534,10 +1534,10 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		 * It does not contain actual informations about user's custom
 		 * settings. Thus we do not cache it.
 		 */
-		offset_of_featurectrlmask = offsetof(OverDriveTable_t, FeatureCtrlMask);
-		if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
-			   table_context->user_overdrive_table + offset_of_featurectrlmask,
-			   sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask)) {
+		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   table_context->user_overdrive_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
 			smu_v13_0_0_dump_od_table(smu, od_table);
 
 			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
@@ -1547,9 +1547,9 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			}
 
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
-			memcpy(table_context->user_overdrive_table + offset_of_featurectrlmask,
-			       (u8 *)od_table + offset_of_featurectrlmask,
-			       sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask);
+			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			       (u8 *)od_table + offset_of_voltageoffset,
+			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
 
 			if (!memcmp(table_context->user_overdrive_table,
 				    table_context->boot_overdrive_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ebb961f60316..aa381991dede 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1349,7 +1349,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t offset_of_featurectrlmask;
+	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
 	uint32_t feature_ctrlmask;
 	int i, ret = 0;
@@ -1523,10 +1523,10 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		 * It does not contain actual informations about user's custom
 		 * settings. Thus we do not cache it.
 		 */
-		offset_of_featurectrlmask = offsetof(OverDriveTable_t, FeatureCtrlMask);
-		if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
-			   table_context->user_overdrive_table + offset_of_featurectrlmask,
-			   sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask)) {
+		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   table_context->user_overdrive_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
 			smu_v13_0_7_dump_od_table(smu, od_table);
 
 			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
@@ -1536,9 +1536,9 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			}
 
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
-			memcpy(table_context->user_overdrive_table + offset_of_featurectrlmask,
-			       (u8 *)od_table + offset_of_featurectrlmask,
-			       sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask);
+			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			       (u8 *)od_table + offset_of_voltageoffset,
+			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
 
 			if (!memcmp(table_context->user_overdrive_table,
 				    table_context->boot_overdrive_table,
-- 
2.34.1

