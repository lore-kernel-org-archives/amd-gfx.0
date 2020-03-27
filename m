Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57337C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCFD206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bHFw1OPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCFD206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7AB6E32D;
	Fri, 27 Mar 2020 03:42:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915936E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5Bk4cZiemOBwocnQmCJ4oZolz5xJqf7/EsLdd+jVlZ3DfomOsXPPR3z4Zp0K7pJWBAiucFAyhHW4vaAYDjRc9mlOqKdTWYERdNsfw+QLLR7Akw39kfVDg2QlzwLWfd5uXNDbScfo8Ref10C5tS02SHY7JVZEFOPzu0D07ODq5bmbI1v/ybxldFC/QsbJBqC/yduomD3Bb38ftHANjwIkEPQsWgOAY4mNuDEhjOZeeLMVaLJSFdaGDEQa6JPC172FH3cfyxuHHIFWUe6mUPZ5hPApVzh8ORU3p4QK+5aUFJlA1mrlM2WFJ2ryl6kEDa4UmOEP4UTKa7oetklVt8pXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtvxfTBuVrrMPKuwR2mcpo4Tdlt+5x62VoRS5NvUb9E=;
 b=HZti7XMYIT96enK9XiJABNrYyva9+tElErECJx1+pK+UM6PKOvxGhFb91DcAeEW59u2bfKTWbxSxX0ys39UNZXTR3vZPTX27vxq9fIO85lt3jcen2hwZPQGYXqbkNm9g5ZmnLIKT6Pbzix/leUoY7/ZqeuBPIHrOmbfCL9snYtnVsm+AxzwrkK4RqEw8Z9eOGA2Sk3CyrJN/+P1Rk3TaR6Ve+gVtUYPUlGhsRNIsjIPMktRP19OpyypcDUURRYqwoqc4oJUrga3jRA6B7LBuh2qwmDuWg00oOBLhlEwFGYa2RtsjG+RIgCAaiwTvqdPmXnk+8ODwOTwJzVZfrlza/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtvxfTBuVrrMPKuwR2mcpo4Tdlt+5x62VoRS5NvUb9E=;
 b=bHFw1OPO90ImjKZo8fsTy1G3jJevvdigsVldd7BiHT2FwQQM9oGkU/nFVfqpFdnBTQmWj8bHnaIP0GVj1b8YoCaooMYx8EQjxBD+DAI3592o3hm+0quWBx/AUtu8pJfElwBkhsbRM8HxrRuMKQSKA0x7bruO6TWClp3RvKh6aPE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:56 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amd/powerplay: avoid calling SMU10 specific SMU
 message implemention
Date: Fri, 27 Mar 2020 11:41:35 +0800
Message-Id: <20200327034138.7653-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:42:54 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c010d28-bf2f-4878-aa56-08d7d200efbb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43738EC01BF80E5DA9C08CE9E4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(15650500001)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTShdoL5EYKa1om3tvN4j8aXHZO8lEn9HyHT7kCK9B2V+PUzd0y6A56KRQiLJ6axAMgY3uVKcE/Q0GT6i1Gr5YTZfd1ji6mWMPry7Cg1B5ty8ROyMZmTWJO2OT4J/DDWB4A4mmlyj7Rfkom0iBRLLnlCTrium78OFuj+HurmkTjtZvmZA+yqLAKoHW9snqyKuVzBqFkgRoeP1QBTLWRBOoABWutx/qH3KrfPOeWTuk0lAntVcF+p2vm6vi3GA0PcBDdk9L/bPjQK7M0Q1ZK5uNBIFbEcvO03XyN5cZIJiBkfdkGtNcVvuEMg4+3MDH59ZBOTFGrG0kPCsq6z4rpTDl9EgnN9EAXTqtAbl8L1t4W+04G7eV/wCP2SZppQ8HGyQDbif5NndX8lSx34dCvWA0h0GV2IBoVrn+5rLVYVMicRH7gCqaoMAdJrbyLJB9Pj
X-MS-Exchange-AntiSpam-MessageData: B+EFzexikxZA32HgW6PDsLfRYn/r8+7QXccI0JK+WI1ezPxH7lMnkO1l/jKGj8Adffr8F3ovzZJlBNnn3vrBG6XR7L15WkEsmmUI299I4LQekqNSdehp6uB/+vJTp5lBpiM0Gcgo4CxMzzkYvDDiMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c010d28-bf2f-4878-aa56-08d7d200efbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:56.2829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R5wDQ44GnDbGqhk6frZbl5Wu0u+jAXACRfcyZGfTiwFdLgikhxlucafCdgfN6CZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for coming lock protection for SMU message issuing.

Change-Id: I05ec712b05dcb2831c948a1df26695619ba8014a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/smumgr/smu10_smumgr.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index 2319400a3fcb..d652673b244f 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -126,13 +126,13 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"Invalid SMU Table version!", return -EINVAL;);
 	PP_ASSERT_WITH_CODE(priv->smu_tables.entry[table_id].size != 0,
 			"Invalid SMU Table Length!", return -EINVAL;);
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableSmu2Dram,
 			priv->smu_tables.entry[table_id].table_id);
 
@@ -164,13 +164,13 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 
 	amdgpu_asic_flush_hdp(adev, NULL);
 
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
 			upper_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrLow,
 			lower_32_bits(priv->smu_tables.entry[table_id].mc_addr));
-	smu10_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_TransferTableDram2Smu,
 			priv->smu_tables.entry[table_id].table_id);
 
@@ -181,9 +181,9 @@ static int smu10_verify_smc_interface(struct pp_hwmgr *hwmgr)
 {
 	uint32_t smc_driver_if_version;
 
-	smu10_send_msg_to_smc(hwmgr,
+	smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetDriverIfVersion);
-	smc_driver_if_version = smu10_read_arg_from_smc(hwmgr);
+	smc_driver_if_version = smum_get_argument(hwmgr);
 
 	if ((smc_driver_if_version != SMU10_DRIVER_IF_VERSION) &&
 	    (smc_driver_if_version != SMU10_DRIVER_IF_VERSION + 1)) {
@@ -218,7 +218,7 @@ static int smu10_start_smu(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetSmuVersion);
-	hwmgr->smu_version = smu10_read_arg_from_smc(hwmgr);
+	hwmgr->smu_version = smum_get_argument(hwmgr);
 	adev->pm.fw_version = hwmgr->smu_version >> 8;
 
 	if (adev->rev_id < 0x8 && adev->pdev->device != 0x15d8 &&
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
