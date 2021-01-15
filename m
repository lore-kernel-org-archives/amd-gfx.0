Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE3222583
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE3222583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55758996E;
	Fri, 15 Jan 2021 09:36:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AB88996E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 09:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCmoXImpbAGt1Kxm/mtiVLVe4jatjnEAU+Hi0l6zyz3YuoKP67RybH2fDM0QZmHrsULgCQMLEPEk9eVAysc9PUSgPkzPHrqXdRwQXdzROU367RRWR/AbPgiQ7/sKYlKpsihkPyAVPV43wngRACAbC8Ofm/wRuSotBtM+vdhudcyLKg7L2gRTjl+fpPfPPOOcFF2mscX+yRcJ3wWA/FADaRpbKBnUiaq+oTuUtRAemBUGz1XeC+xI7MSGTp9Lu/jbGn/+UFbdUsd1Sp0ygZLt1ScZ+9OjQGNZRdAKFwveqjTrqWK1kMd0PJ4FjhLErrZ+FJ+5951EwKHOAdDLws9Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocTvct3xrh9syq4i0cfXqhYt/ktW4wqbafYlZHGGqU=;
 b=kCVUz6LJf3NED4dzbI5Gh3xeH0IC1nlSNvFKovE9wowMRMfY8+zLDrQefk/4tuJOEekcnWW5fwrJCkp2M0p5F1UTL5gOFgn4Dd69TJPiraMuA4jC54OpiaZzl7d54jgpJAIz3saj3wp5JLBYGglhR8eONmbVYUOuQl0Jzvib8mcO6ZC4eCoLHGL3HXHnEP7JKl4tryoISGlVXnt2W9rUNc497iVgSYTnRbaz6Rt5r3an78O8JBIBcNtjIvXJcyIBDF7ABZVIlH4Xswy2E5hMa7q5Hz+ZqRA5UUBopNhB3VKaH3wkt3KB1EHGbvUt73B826gWDgE1LJAyTU1Tq11Lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocTvct3xrh9syq4i0cfXqhYt/ktW4wqbafYlZHGGqU=;
 b=n75FGrIr6m35a8+tboKxmZySvXi0lZyoEJ2cLSBlnPG33OEkf/SPveD/l6dNxybdV3HnGtAfc0w0m85P8bUO2414QqC2xUvRfncR3ukqqAl5p9NoLPLhdNq8lgK7gtM3HxEbaN6DuC157YqvunnMQ9ph54EFCvn9T/SyVCE/PbM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Fri, 15 Jan 2021 09:36:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 09:36:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: clear the cached dpm feature status
Date: Fri, 15 Jan 2021 17:36:10 +0800
Message-Id: <20210115093610.389656-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6 via Frontend Transport; Fri, 15 Jan 2021 09:36:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0cb96db-18f7-4480-d81d-08d8b939085e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258DB10445DA679A679DD03E4A70@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlualQQvvxgRvo6WAPWoUa4uQYG3ZsFg/dz8U47TKyeVBXfNOXOpifVjoo3MVP+NJs+kl8BAMG8yvZN7zEo//u6U3lYYtAbAxLzEZVbsOibQufXLmGnxq9zr9qclZwrXcMMMAXU8/ACwtuVSuclI5arbhwSML3TJ8gFWSyTrv4Hl39oPowYvjANZKqcDZQBO6v+CkdMVa+QL5cCTQnGlX+lSWRQsyaa0H6xld4zV8/56o0m1OGgZCv6NKoq1lapURfM50C/KVQK2rTkjCd13kALXTEfLyo7QZbGHrIC1YFs/sTBhVcto03GEU6u2WKRWFIDkXGqDlXgxhgq1Sjk/8jmaht4L47lYyxXH8CqhdkwdcHHdpPm9QB3ClhxEEWGAWWWluuBvcOoNxJ2UWPuQKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(478600001)(4326008)(8936002)(36756003)(86362001)(8676002)(5660300002)(83380400001)(52116002)(6916009)(6666004)(2906002)(6486002)(66476007)(1076003)(66946007)(66556008)(16526019)(186003)(26005)(316002)(956004)(2616005)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HIzdW8Sc5j7/z15CogJYIQKbhSXnm2A3tC70d4dx4MMtGlt6DfWAXlS6iCMp?=
 =?us-ascii?Q?ofqTGNteq2QG+4uRXZGVFEQ/cPbKfl3MvXlGBIz34Zh3WcUJoRAqWUZ33o3P?=
 =?us-ascii?Q?DFNhnbmK1JkKIdtHick8Wp4S+8hSDNIeNi6TSuINGCpEsCu+EE6w1ERBRcNj?=
 =?us-ascii?Q?bcDeuuYarxetbSn/EWKtCuvt9PHWhGcuu0wcmWvaojBP5mYN9H/PeftU2syq?=
 =?us-ascii?Q?RFVh06CSxzoPIZC5nkYFSPYGupxiOP/Yp1GN5IRNHrEBltDMZSXIyQBw03q4?=
 =?us-ascii?Q?I2Q29cm65WdcyB1JMawl7gvTuWgcasr/JS9Z6FNU1jF4UTn3IrPd6oyiqErq?=
 =?us-ascii?Q?IMcCin/su5UWNItEScGLtNdvIAkihTOEMRGBX50BCwYTvuPIPra+1wbki1dH?=
 =?us-ascii?Q?18eWHgFbgMHGIWiGPuHJSWhaGcIKLfpFS5vKKTCbYL4xcJ2WO3dijSatjf8b?=
 =?us-ascii?Q?slZ1bF/qRoXL+ZMrDgLfzkji5yISc/FuwDf7DMznYHfJ9+NIeOJnJzTntyeh?=
 =?us-ascii?Q?WA6xYlqQzb34ZG235hRLZcMCW5Fy6AGnI29SZ483jtVK83pcbTZhCB/n+3DY?=
 =?us-ascii?Q?26WspzEH0ZThKGfhNec0pTz7X9HZGcUkKkH/HBV9IYjdUoK+kv5JBSFbPxse?=
 =?us-ascii?Q?9flEh3L3XNuU32UoWNfa6E2BrRWfBTNXknWuNQWNdtEk7YaWygQzfbphaX9g?=
 =?us-ascii?Q?2Muzezz1ZpK7xyFXt6UHdlQDf0DdeCUN07Y2kP18i/AHWl5tLVXvhjvHC/a8?=
 =?us-ascii?Q?wZ8v80f8ONlwqIe4m4IzYakuD2HEbLkB3R+NORqvzA0Yqzf27tizNvJfycis?=
 =?us-ascii?Q?0xUJ2AakYgVkQgy1G6QaWNAcU8DbQ3EFo6iJ22hIOpqrPZjhM2VPy10s2WB2?=
 =?us-ascii?Q?mYXD8+iF2Mst/DHOZ326XS9cU1VLJYSVxFyJLVgNfXBCvHHmpPA2tc5nHZfd?=
 =?us-ascii?Q?91xecJAZrlJda3vE/l2PAoV8X574swu7kObHE6dbo9ZY9BzwBedplDeVoKfp?=
 =?us-ascii?Q?Wnrk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cb96db-18f7-4480-d81d-08d8b939085e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 09:36:28.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0BcBSA3L+AT1c+MFsmzhSoE+5RI1YQ10/2Q+ACDOfEB+cNyGXpqnP+RQomKAnh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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

For some ASICs, the real dpm feature disablement job is handled by
PMFW during baco reset and custom pptable loading. Cached dpm feature
status need to be cleared to pair that.

Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7fe61ad3ed10..facada52350a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1175,6 +1175,16 @@ static int smu_hw_init(void *handle)
 	return 0;
 }
 
+static void smu_reset_cached_dpm_feature_status(struct smu_context *smu)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+
+	mutex_lock(&feature->mutex);
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+	mutex_unlock(&feature->mutex);
+}
+
 static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1197,16 +1207,20 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
+		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
+	}
 
 	/*
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
 	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
-	     use_baco)
+	     use_baco) {
+		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
+	}
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
