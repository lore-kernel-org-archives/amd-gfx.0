Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C914C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5887206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kwtzc8qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5887206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9336EA82;
	Fri, 16 Oct 2020 03:28:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB196EA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ84NvfCjk4zDF/uV4qD7EsjkbjhWb6QcfKj3XA2HqQINAt2RRM8T/87j8AjmK5ovZWQAEZU35jRkiGeWOBvNU9ETVCKo62REfEnG/5rpToxRhkPRkCi68FaPnyPl569vZdWirHS6yCw1xmfzXuBRLGJC2z/6l+e1uUk4XPo6i7g762XvbwlOoJAqRiNnRPE45Ii6TbJG+6YIqz+yBdb1880tkwdiQfpO6k5J1dtAUCVDhrM201CeYw6OPeNT9YrYxhiPy7GSyH4J8ZG5fjNuk6tvbbWwmhnbZLJdKo+tHE0XG3eoLGv4rWk/t76x0AFc2bcd72hGTmU1cykPl9y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uFPTjVPvw7xCf17mz5tsDIvKPdKsfAB86IUD/Bfkas=;
 b=kUaKNk4XXWlwpCQhoGvIP57eemSVDJO0T+edf2PI0GKbkM5KBBPZyDu8VzndiRRS8FCOZNruwiQ1Rqw3X+3lc0fce8Ce6P8BuhUWjUTl3bD9A+a+3uoDVvjlxSz6gvn/vFiv98kVvCsaeBVTBUuf+lvASm5MdV4wKBP/1EKAisvtzPNXtCCIUd98DpfSClUj5jtPcV26X1GI6e9fw+SVidLISPo8Xh+w1rZyN6qJ0pxZOQ1nSBSe0Ewh3VqW6qnDFu8mT4/WPpl8r6yxpWGvzQR1foErx94g+mQiHBMWyWp4gLD09fWifNqTGhLbxEgfOQvkH5cnhhc3gGtB+DIqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uFPTjVPvw7xCf17mz5tsDIvKPdKsfAB86IUD/Bfkas=;
 b=Kwtzc8qawWplE26OikWzvQDbYWqqiOiNaC8z0Fyf99VQt7dBnDDPtTaBEnJ9YeEvg9iqj2h4uJ/+VeM4LzmEl3uWnytI4X5kaX2VXFtFwUb+mHKEpH661Wy/d5INj2EehmGs2YNsfUDTuzfzAzF4mFDKOhVQyACKLTMOWRPb+KI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amd/pm: correct Polaris powertune table setup
Date: Fri, 16 Oct 2020 11:26:35 +0800
Message-Id: <20201016032652.507-24-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfe429f0-34f6-47db-c0ee-08d871838342
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354C5CB9273D37200F5E8B6E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ugnak2vY4cJzrXcJfq1HPP9oo+Itfq0X8MawUarblzEychVJqag+Lh6/rcEyZ8/pAiI6RnnZYkiJT7JPtMqbitK8Oql8LfePa+eNsQrRQv3RSh9ANeyOmsLn3Yoq4EG6S3zBE0BiLIokIrhL6+braxDmB5X5jTeAaWw7ngIDsz5HdiBp11Fb/ecRhsi5+SvQtsBELhz7rigZCTEpeBcTsBfCpOvJxPa0uaMINFvbcuTdb3dwsMvuZL/VYX0MNcGFebD79oZ6CPgKPgGYjjHn469xLm4iIBjFq5uyNb+wO1zTPSep2eCQCP1VXzOtSs398aoSYaeAr0FZhSa8Yk2F18kZ10tsOtB4S3TXMo09LK7Yu5PeoB/upPVWqMqasVih
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pWGfKbLtzlCrli3ZiQEOQSJpm98cDVbjD7Bol5ro7c2UwCg6K/20OH35QLO73qSoWt9ByPXLCmSOxdbY8NgMh7bjsz6WIQfQe9JqfluHHkmvke8UPXkkC+5bvDtEp1eClF3+JTlS3/OvcrHTtVN6YYs88UK0aL5YbicesZNqI9wTNVkP5YmdguUpSBbsHyTtijFQT8CeASiRlBUfPgCdmFCKdEv2znIGmVkq2CvkeAe0yTynow45kwTHSQ1g+qGjxdwkfzW8gKKSVrXpAhuAtWXiTRQKfZ34uIYHORlfYjn8QYte4N/y/A6iKlTVHtGorKO51JmXirjIXG4VQyllmnoCIBEwKAXa0OJfIoyUVN+Pvwc/9kD+R6cSRfxE0Um5ljWwLxT1W+7p+9mc6HLtApiZ2pOh+TbmuoD834lZDZlT3HwuNdx0bFiv6fwymYou56A99MQ/WHisDv7X6h7zNSKxQ9x7eZQXyl67cxfUFe9vpgS/IwZL+gXgbbRmf9C8X7hrBCLHBjODcSVO09g4YIDkEX1kXdPxqCoSlGWL7rOI3KKpJp5OXxrZ+6qatDprTgjzQkghnISznlxZeu/0Gy2CATJ6A9wdtvL+0ZVsvVik8hDmg5KFVC8vguUQLo/fJTO2YZo4pk1X0P2+QUjfVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe429f0-34f6-47db-c0ee-08d871838342
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:13.1208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjhdR760EcwDG1RmE3UaGnJ72BZk9rzzUxaSDVXRGHKN2VOcCV4y9ch/POxrJQAn
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

Correct powertune table setup for Polaris.

Change-Id: I31fa01c5e5f88233616e51966b4fb5a161e35ff0
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |  1 +
 .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 36 ++++++++++++++
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 49 ++++++++++++++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index dad703ba0522..0e4707a76f6d 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -441,6 +441,7 @@ struct phm_cac_tdp_table {
 	uint8_t  ucPlx_I2C_Line;
 	uint32_t usBoostPowerLimit;
 	uint8_t  ucCKS_LDO_REFSEL;
+	uint8_t  ucHotSpotOnly;
 };
 
 struct phm_tdp_table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 614f61ae214a..b0ac4d121adc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -419,6 +419,42 @@ typedef struct _ATOM_Fiji_PowerTune_Table {
 	USHORT usReserved;
 } ATOM_Fiji_PowerTune_Table;
 
+typedef struct _ATOM_Polaris_PowerTune_Table
+{
+    UCHAR  ucRevId;
+    USHORT usTDP;
+    USHORT usConfigurableTDP;
+    USHORT usTDC;
+    USHORT usBatteryPowerLimit;
+    USHORT usSmallPowerLimit;
+    USHORT usLowCACLeakage;
+    USHORT usHighCACLeakage;
+    USHORT usMaximumPowerDeliveryLimit;
+    USHORT usTjMax;  // For Fiji, this is also usTemperatureLimitEdge;
+    USHORT usPowerTuneDataSetID;
+    USHORT usEDCLimit;
+    USHORT usSoftwareShutdownTemp;
+    USHORT usClockStretchAmount;
+    USHORT usTemperatureLimitHotspot;  //The following are added for Fiji
+    USHORT usTemperatureLimitLiquid1;
+    USHORT usTemperatureLimitLiquid2;
+    USHORT usTemperatureLimitVrVddc;
+    USHORT usTemperatureLimitVrMvdd;
+    USHORT usTemperatureLimitPlx;
+    UCHAR  ucLiquid1_I2C_address;  //Liquid
+    UCHAR  ucLiquid2_I2C_address;
+    UCHAR  ucLiquid_I2C_Line;
+    UCHAR  ucVr_I2C_address;  //VR
+    UCHAR  ucVr_I2C_Line;
+    UCHAR  ucPlx_I2C_address;  //PLX
+    UCHAR  ucPlx_I2C_Line;
+    USHORT usBoostPowerLimit;
+    UCHAR  ucCKS_LDO_REFSEL;
+    UCHAR  ucHotSpotOnly;
+    UCHAR  ucReserve;
+    USHORT usReserve;
+} ATOM_Polaris_PowerTune_Table;
+
 #define ATOM_PPM_A_A    1
 #define ATOM_PPM_A_I    2
 typedef struct _ATOM_Tonga_PPM_Table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 4ed9f8106b2e..801a56502670 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -613,7 +613,7 @@ static int get_cac_tdp_table(
 			le16_to_cpu(tonga_table->usSoftwareShutdownTemp);
 		tdp_table->usClockStretchAmount =
 			le16_to_cpu(tonga_table->usClockStretchAmount);
-	} else {   /* Fiji and newer */
+	} else if (table->ucRevId < 4) {   /* Fiji and newer */
 		const ATOM_Fiji_PowerTune_Table *fijitable =
 			(ATOM_Fiji_PowerTune_Table *)table;
 		tdp_table->usTDP = le16_to_cpu(fijitable->usTDP);
@@ -657,6 +657,53 @@ static int get_cac_tdp_table(
 		tdp_table->ucVr_I2C_Line = fijitable->ucVr_I2C_Line;
 		tdp_table->ucPlx_I2C_address = fijitable->ucPlx_I2C_address;
 		tdp_table->ucPlx_I2C_Line = fijitable->ucPlx_I2C_Line;
+	} else {
+		const ATOM_Polaris_PowerTune_Table *polaristable =
+			(ATOM_Polaris_PowerTune_Table *)table;
+		tdp_table->usTDP = le16_to_cpu(polaristable->usTDP);
+		tdp_table->usConfigurableTDP = le16_to_cpu(polaristable->usConfigurableTDP);
+		tdp_table->usTDC = le16_to_cpu(polaristable->usTDC);
+		tdp_table->usBatteryPowerLimit = le16_to_cpu(polaristable->usBatteryPowerLimit);
+		tdp_table->usSmallPowerLimit = le16_to_cpu(polaristable->usSmallPowerLimit);
+		tdp_table->usLowCACLeakage = le16_to_cpu(polaristable->usLowCACLeakage);
+		tdp_table->usHighCACLeakage = le16_to_cpu(polaristable->usHighCACLeakage);
+		tdp_table->usMaximumPowerDeliveryLimit =
+			le16_to_cpu(polaristable->usMaximumPowerDeliveryLimit);
+		tdp_table->usDefaultTargetOperatingTemp =
+			le16_to_cpu(polaristable->usTjMax);
+		tdp_table->usTargetOperatingTemp =
+			le16_to_cpu(polaristable->usTjMax); /*Set the initial temp to the same as default */
+		tdp_table->usPowerTuneDataSetID =
+			le16_to_cpu(polaristable->usPowerTuneDataSetID);
+		tdp_table->usSoftwareShutdownTemp =
+			le16_to_cpu(polaristable->usSoftwareShutdownTemp);
+		tdp_table->usClockStretchAmount =
+			le16_to_cpu(polaristable->usClockStretchAmount);
+		tdp_table->usTemperatureLimitHotspot =
+			le16_to_cpu(polaristable->usTemperatureLimitHotspot);
+		tdp_table->usTemperatureLimitLiquid1 =
+			le16_to_cpu(polaristable->usTemperatureLimitLiquid1);
+		tdp_table->usTemperatureLimitLiquid2 =
+			le16_to_cpu(polaristable->usTemperatureLimitLiquid2);
+		tdp_table->usTemperatureLimitVrVddc =
+			le16_to_cpu(polaristable->usTemperatureLimitVrVddc);
+		tdp_table->usTemperatureLimitVrMvdd =
+			le16_to_cpu(polaristable->usTemperatureLimitVrMvdd);
+		tdp_table->usTemperatureLimitPlx =
+			le16_to_cpu(polaristable->usTemperatureLimitPlx);
+		tdp_table->ucLiquid1_I2C_address =
+			polaristable->ucLiquid1_I2C_address;
+		tdp_table->ucLiquid2_I2C_address =
+			polaristable->ucLiquid2_I2C_address;
+		tdp_table->ucLiquid_I2C_Line =
+			polaristable->ucLiquid_I2C_Line;
+		tdp_table->ucVr_I2C_address = polaristable->ucVr_I2C_address;
+		tdp_table->ucVr_I2C_Line = polaristable->ucVr_I2C_Line;
+		tdp_table->ucPlx_I2C_address = polaristable->ucPlx_I2C_address;
+		tdp_table->ucPlx_I2C_Line = polaristable->ucPlx_I2C_Line;
+		tdp_table->usBoostPowerLimit = polaristable->usBoostPowerLimit;
+		tdp_table->ucCKS_LDO_REFSEL = polaristable->ucCKS_LDO_REFSEL;
+		tdp_table->ucHotSpotOnly = polaristable->ucHotSpotOnly;
 	}
 
 	*cac_tdp_table = tdp_table;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
