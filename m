Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCBCC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D39206EB
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NA7eFxE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D39206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6376EA31;
	Wed, 26 Aug 2020 07:45:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E4C6EA31
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 07:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx5uX3q6K5bwMoM+/dr7TZQu9WMKtRT/vRMplkZ3WQWV0+NUL7mODKNG6WvzhdOkKYdd765n/oOPQsO6Uh4SzMh7eiMiRnwxsL0mpKDqZUvOdS3TugcbR/u2qlNByqeIgLvyZu4b9U12VOdWvtkkH7jJ06mnEQL3MZLcwpsqWJK9sKghxqsDK7MZ1honMxoSrgpQ66s+eNV1Uzijs394nOqhEIYLZBjU8QcR/EibphS2c4tMTvjDefpL3+2JKgCGDNAHI3zoCBDt15623D+IzsNMRUUfYX0pu3EQxTt5e6zeEAUa95Vsx4VVntYuz9u3ItQ4Vym6D7CWn1WbxUiVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW9P9RbsIipxLnkBk8Loa0Pibby6qCKduLm20lhDKX8=;
 b=Jp7Hvh79mhEH+lpMrwXWiscQWgGc7OxVxE52HsE6f/oDDWxVG09B0TWAWwsiGTMqXyo13jgQHdH1i6Hs/eAL9m81/BAUQsc6xLKBGHxMKVrNBFyLcrVSZOYLN4PSML+vHiru2UNajGGlpB6a+yqqNPkV9kq0GjtxalVoU/Sja9aE0U8RSC0AqdkjQ5SrjtHsdN1idanQVg1LyGd+GJ8Yu31x4NCa1TgkUjY25yAc7bGLRL9Tr6kgFQJfE9TPn1e7zbCTtBj9mXAN5BHtfWAQ9WNdT0fXC1ENarW7gECXmlSQ2C03avRu9aNg/g5li6GgCkNEjgaJtX3GY15OKStEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW9P9RbsIipxLnkBk8Loa0Pibby6qCKduLm20lhDKX8=;
 b=NA7eFxE8GrcfMu+TIA6D36tyc1HRFdjZwt07C4RiPb12JkOZ6oRT/MZhU5f2JLMbja6JsjZyDdDKRYIrcq9lPagxLyO1BM/WLZyWQdN/FTbE3UdP7ziPzvEBU/fcixl/mnUi3vFTC2PtHMU7rkzVkzmQEBaR5uCLaUkcwHRN5xg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 07:45:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 07:45:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: avoid false alarm due to confusing
 softwareshutdowntemp setting
Date: Wed, 26 Aug 2020 15:45:00 +0800
Message-Id: <20200826074500.14603-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 07:45:21 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1992161-1c8a-44eb-f30b-08d84993fcf4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449364EB18EE2A0CDAD6D65E4540@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNcc7Opoz4idxDjBBirVH3pVD4dkP8yA5xZwrEVmuRsXiZjQ1BNZWe7DAcOPMflpM2h9dOuvPYUx7icT+S1QNQu42UX7mzZW1CCPHtfaZ5SbpmVkGHRaqrUyX03AbY+RN1UNzsUuah2u5bSiDTL4MG9zxo6/QrO1zq2m8pz0Z9qmiDVEphdg8/PE2eVK6KOzFGel7ksalD73T08kUh5TSzGoqEHQCWukmZZcRWVmsVz3f0iDBgwifeeGjKoOnHGBvU4Sne9zkr2OYnYTkAaFs4uZ+rTm2g7LEbOAubWAHHe0N9e9lCUf65GOC8ETw06t/osG7qexRktSywDeDyYeYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(44832011)(6916009)(316002)(36756003)(8676002)(8936002)(52116002)(478600001)(5660300002)(4326008)(186003)(6486002)(2906002)(26005)(956004)(2616005)(6666004)(16576012)(66946007)(1076003)(66556008)(66476007)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sFaImiyx8DncRht+/ixV1JFhZlI+J740/e14UeNfvXIuQDaC1Ceo862+vyCk1vTBMiDvNPDqM3IC0yU++EiQL0oQabDq3sgyDpx/gaCb4gNs4yNZliZBWICEVXubdgtHvW9Qc5SvjvRDAdL6UhMv63PmgMt/5x7ubdGolpJy/HmSHKjUONaG3/X/nfNsfuaOeS4tby1MhWyk0aMWja3I/amnlb0mGxIfZDaKIVsKdpozt39qrRd0swkOv+daxnJSA3lTLv4zKdkeyJRLhMVXJnGZfqPqKLRQKdggcQ627cn43GCrn4mDTsOy1i2haTwUP3BWn1TThHrA3sxXL03bO5XbOH2kCDiioP4I+ms+4EOZJOSw3LGFrcQgOugZLmBQUcY1jBlSSkKP88U4tBcuNRw0yuDS9WIV818ewX48Ey9hHf+Jj/ChXlBBEMTYe8KenUbCOi9VXMmA5rPdyPOGrT189Q0BfMZz5XBpfQwGbs01pihAyzR2lCB7UJBDU13HK3sm6pLNRqFI+5RQdzsh0ntRAspqe5WywBa+8WXUiiNdffu3fKVh6neUEMvjy1FC0798FVe/dHCGGRZ/hkLn4zLqrZkm5sZGcb5CnWamN29CfwhNx1Rb+7302SS5m573RMEuydSrgis63iqJdDFT8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1992161-1c8a-44eb-f30b-08d84993fcf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 07:45:23.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DWxEApAkQGdD6PQi/L17lmX4LU2Ps33R+MUBHJRsm3MxoJtnqmOnuk1N1D1Zj50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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

Normally softwareshutdowntemp should be greater than Thotspotlimit.
However, on some VEGA10 ASIC, the softwareshutdowntemp is 91C while
Thotspotlimit is 105C. This seems not right and may trigger some
false alarms.

Change-Id: I940cc6e450eebccd93ccdc3428187f6b7c09dcda
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index d572ba4ec9b1..952cd3d7240e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -374,8 +374,18 @@ static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 	/* compare them in unit celsius degree */
 	if (low < range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)
 		low = range->min / PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	if (high > tdp_table->usSoftwareShutdownTemp)
-		high = tdp_table->usSoftwareShutdownTemp;
+
+	/*
+	 * As a common sense, usSoftwareShutdownTemp should be bigger
+	 * than ThotspotLimit. For any invalid usSoftwareShutdownTemp,
+	 * we will just use the max possible setting VEGA10_THERMAL_MAXIMUM_ALERT_TEMP
+	 * to avoid false alarms.
+	 */
+	if ((tdp_table->usSoftwareShutdownTemp >
+	     range->hotspot_crit_max / PP_TEMPERATURE_UNITS_PER_CENTIGRADES)) {
+		if (high > tdp_table->usSoftwareShutdownTemp)
+			high = tdp_table->usSoftwareShutdownTemp;
+	}
 
 	if (low > high)
 		return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
