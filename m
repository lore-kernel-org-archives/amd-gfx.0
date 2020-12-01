Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12268C64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 09:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FED20770
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 09:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p+9L+Xsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FED20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA7089CA8;
	Tue,  1 Dec 2020 09:09:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AD789CA8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 09:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agfWmlSIWu7nIP5CW+reig7PYAXyKT3P7+66jUWCLp5XYowcK6hf00FMLLOws6MdoKqiScWI0JNoRGcbCCeh/E+88vsDqmJy2gtA2zA+YVCMRQH0nxLbananUS1yxgzvO9iAJDnoJghwe32dPlsIDVtxBJ16SbN7XzmGsNOQ81dZEShDcyyCNEgEz4U6m+0dgDXdX3Orzs1aVPynq7ILyPvqaxswh8YB15JeouxNMBuRxbkksI+YtZQOdpe9/xbqcFmO2iQupFuViWiywJ6LHw3B+/CmbcuXVQkw1z2jNYPSxWemBSCOEuru6aVwX/CWGkPDTsMTYuwIwqHx2n4Plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oCOPu9gh2pxHDQL6KiP7NNkQuV/+vTc7G1KszSf6e0=;
 b=ZGmcTn0NJaCyAu37ZovqE9707rKjr1Qs0EhiAposjLllR4N1xmvmNwitC0vZO3F3pxDsk2sJXQiBajrsVo5MTPX84Upo6JCXTqUjneoc/4g1n+lNGq8m7de1v+uQ/ahBu432IKRueEpSFlqnhE8QFoz39a+xMnD+THqIokmFBkIJ/dA7xtevrG82h37tbWzWuy2vdcZLSmUX0rAvuhEM8lxMBXQxpy370K5AD4C5q/FurSHulzz82gsM8O+CLg0VffuT1RyHRjY8AhaV2rYcVM/X0bzDwRbJ1GgQS5AJjw4Hh9CyDgNy/cQXwdIxFCz8oek7A1gKaIsCsowGm9UCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oCOPu9gh2pxHDQL6KiP7NNkQuV/+vTc7G1KszSf6e0=;
 b=p+9L+XshKDIl3PWnoVD/MULZsShbrOQLRM3FHb2FMqyGrLk+iBPsiNkQSj3qkMUYHdyDCefTetbD/Pcpngdvw8CpDWEKnmzg2XFGCbfKkDGggWjjLnkCZGf0dzGuixY72yFiNJj8hb52Czogh4lR6fmaGC2DNR0oy4xTlrMUETY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Tue, 1 Dec 2020 09:09:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 09:09:31 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: invalidate hdp before CPU access the memory
 written by GPU
Date: Tue,  1 Dec 2020 17:09:03 +0800
Message-Id: <20201201090904.2566339-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Tue, 1 Dec 2020 09:09:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 946c0f97-100e-47bc-a29c-08d895d8cfff
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3577593276E1A6934F379697E4F40@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Atqv7QiL6rUDkl7LcpcJWflElYzLkT/ayRt1STe/gfQCwHGnsFvhfQhf5m38eez7iaiT8RIe7v/HJ4BfkyLTTNtQqJ8vqTgOljz1xbSDEHoDFNw+4cVZY335K7qvNIjwzkhhJ1ryV2I1CKTlkmOxaVQNkSUT2qqI/qUxP55VxE0W7MfNJD5aCIv3ti2fTeerXwEnYcfrrc+RL4QJC1/SZP5JRDp9i6H8cX8pjrCYmiYZhrrsmnPJIOMR9sF8PPq+N+SRMT2N99YU/RlRvS9jO65t2bBoa1uQUfSXqeraEOKzyYYaEgY6iLKaw3f2rS3kHk8qH6n978JHFe7LyTXSTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(6666004)(16526019)(316002)(186003)(1076003)(26005)(2616005)(956004)(5660300002)(36756003)(52116002)(7696005)(66556008)(83380400001)(4326008)(44832011)(6916009)(66476007)(86362001)(478600001)(2906002)(66946007)(6486002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?chY+4VvdgUBzguCGeuGPXe5os9vb+MybcZnNh4spF4IWrG0p2UBDZqzbXUBp?=
 =?us-ascii?Q?q58c1SF+r07vsQq+a7iIqHMd1W6BPSuitl/mk9z6GQnbMPMWVFtTPx0+nT+o?=
 =?us-ascii?Q?PbAf4USQFcL4dyMTQ5FjcUiy7l1mUn/u93uAV3eS5gRgoQAOikDrpkTAfo8K?=
 =?us-ascii?Q?08nNZUIUekbrW4if5z1nuPSCahbNoJ7Vl7vfpOaLIh0pdGLNOWsBI71Lgd46?=
 =?us-ascii?Q?LH5JEmwfUrtr4WHJpqU6aJVqw+ssFgVDDa2uDX+73tEzZ+9fuRhLyVZ7rVfp?=
 =?us-ascii?Q?TPMc0I2pAAZjKo+m0411VzytcZFmHHhnlXSY3LCJvl6kfRyvMYXyJC/2O+vE?=
 =?us-ascii?Q?aXkvNvm2YHngn/Gcw945oFmiApwZ0rhP3UG8LAl+5qZDItJD7qMQg1lXDigi?=
 =?us-ascii?Q?dc2r4/7EEEZatdPry/LuhX5Fb+MhMXWdkDPFtS5BKD6V8V71R0SW0swyrG5P?=
 =?us-ascii?Q?KKd4QA24mwmca9px4t0/1qAt5RPlREDZbxO/B/JDpM4C8s+J764m6C9q6GAf?=
 =?us-ascii?Q?kBngKmamJIMavaxVOjx0k2lNeV9N5tJ5KlKNnRf/zYJmzY2m3vypII2aVDCx?=
 =?us-ascii?Q?byOeAL0iCEInLdh2KG68Oy4jwGC/Z6uuKOgoghCzXU1ltEtnmEUgSeqbNisA?=
 =?us-ascii?Q?h4a0jbek9pjX/Y6CQPBYgBan7q6ZJPs/Y+bLChTEgXb03rxKiXeqhY75ItmR?=
 =?us-ascii?Q?nMILRm7sVU7aLyCgYOT/xxFX9M/u673kXUjm4H3EgEg7qyBvswo0hs0FleNr?=
 =?us-ascii?Q?QC6kQWyrM+VLuuMTMmLz6gHz5AH4VDt7d+qBeb/BO3S8y5DBZBq7rkf+QWl5?=
 =?us-ascii?Q?PQPUwcH5FbpliEqoPDJI/S3r+guQzT1QT1f/lh5U8NK4d0jtatByzjoQt6At?=
 =?us-ascii?Q?LCJAlzJ+kPfrCVjS2Vi5pgOpzlPDHgdrIQxUOcReJZmtzc++OmCnneqqPI2p?=
 =?us-ascii?Q?jM/0IiozGzkVTIxnPOKnHFWi70ieiit372kFtV8VK2VKYHbKmIMbrYDnc7KD?=
 =?us-ascii?Q?91PC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946c0f97-100e-47bc-a29c-08d895d8cfff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 09:09:31.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RYiskIJrl4LYmKGftXzL2cWtDSLJcYknkkI8NEztNQVtA7kKSSmNpMl2acShnnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To eliminate the possible influence by outdated HDP read cache.

Change-Id: I93ab87a44d146ca546ca08be21b979ea6713c6af
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c  | 3 +--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 3 +--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c | 3 +--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index ea2279bb8cbf..47b34c6ca924 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -139,8 +139,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id,
 			NULL);
 
-	/* flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_asic_invalidate_hdp(adev, NULL);
 
 	memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 85e08a552685..a70d73896649 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -60,8 +60,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id,
 			NULL);
 
-	/* flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_asic_invalidate_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
index f54df76537e4..b52ce135d84d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
@@ -68,8 +68,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
 			return -EINVAL);
 
-	/* flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_asic_invalidate_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index cf43629d29d2..741fbc87467f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -192,8 +192,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
 			return ret);
 
-	/* flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_asic_invalidate_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -307,8 +306,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 			"[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
 			return ret);
 
-	/* flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_asic_invalidate_hdp(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
 			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index dc28f22aeb38..f8260769061c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -655,7 +655,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 		return ret;
 
 	if (!drv2smu) {
-		amdgpu_asic_flush_hdp(adev, NULL);
+		amdgpu_asic_invalidate_hdp(adev, NULL);
 		memcpy(table_data, table->cpu_addr, table_size);
 	}
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
