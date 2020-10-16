Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02E6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3E5206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3egbIw4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3E5206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210AA6EA63;
	Fri, 16 Oct 2020 03:27:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB7C6EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bix/Ba6YCIV50mR7BwLx04vTT5GMK3OkGFq/dJwSP1S+BEMuMK2Ks+9Necs0oT5DqVuR1knA6VE9COyYv8pdiY92GA+vR6+1yeht5Uhcxw46BhfboakWklJrbSkPnXea8B9KajwJCZx1ktNTJlsneko2rFNRzbmLBqqnQqMl8X9Jv1vLMrt66POY13Js8a6rLXtK8UpJPoKlfdLelSdvrF7uVSoh4qM/vL5kT0tHIKe2j8CCksEqbWkj3LstQ7ZrFg5dAlmq9nr3e3GSo4sbDjOUieOmaec8X8SXpIUMgfeKqd/zsGo08/IPzP/ZkzDQ2g8owxV/4J5aJq7xT636MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlWuq7Bo96fU+rv0NnlZ5tYKjP3uLCPIgPrh7chRUt8=;
 b=fFGzhVa3CNo9UBtxWsORyZPu1765LiuFUE3uaaXrcXtTVLw6fHRFMdzhDfXHKtxZ0TsMOxdahl+suB2k8mGQjDlNhsfyod8B4PNBufAHRzfc8yEZk6ZrxyR7CBY+zRQgW17zfPmgvMTdpI6+D0kbfw9CwDZ15Oi9e0wqtBpZY4Rz0S38k4mdCjwZSoVvd0/gysTz9fGUkYaMuabB/4U9sizU4nhmoZXlNay4ws+21sWjpolmEnnqP5VwlI99r0qPbT2Bjo49fdGw+Mwdiyi4w/CgQbdON1mbLHzzthkmBC01HkCjkVSG4jOl/r/YRtzPit18aZJPSJ/tGRw1la+pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlWuq7Bo96fU+rv0NnlZ5tYKjP3uLCPIgPrh7chRUt8=;
 b=3egbIw4jJO3aVRyNgrEGKcX5a4o6A9XWvg7vGEqnb6HjoT9DD0tTwT44GtWorlXzgSUazkDP7hp6oZUzvh7/tKTro7nDlh97DK1UWp5Adfy7QLKCmk4HJqL7E4tst3NXxM+hSn/E/ffew2kC6izdc5JiYDt4U5IOVih4+JWjkC0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/40] drm/amd/powerplay: separate Polaris fan table setup
 from Tonga
Date: Fri, 16 Oct 2020 11:26:25 +0800
Message-Id: <20201016032652.507-14-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de7f5bb9-fd80-46c7-b571-08d8718378ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680C8AF88F759BA10DA8DDCE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9guqfAGu3bTNmKHkKUz/gH0/UGRpB5AWHoIWQOjiQbMKYgv4obzqtmyQMts7vmUVzQvoNgaD45d4RvZm2eDcHpYyXb7rU5UDIehp+CMtJI9K8cJilQ30LYO5NTC1bDu1z+oYN5GdhgJnxMojeQJ5qzQ5b9cPFer1s2AJIoXVT1J9d9K4PSGhnawCfHefTNVx/W8e8DiqUIbgTZZP/tjfCAx/Got1IEArhdImDblLvt6ekFrbdH//5GCmQ515ZlCg7I3YvTdZ6tYDrSMtPNyIbOpqz4LOTy+iPuY28fcN7PYmyKKsfR1tsiDzDDE5PlY0E/+3/jOxUvXk1qQ3pTSZCwK3Qg1MhDaOgqA4HKYuuRYdp7jiaXeI6EXU2+l1wij2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OxN9pqrYtOjc+nVmPAGTpY4tC15eOISZbsEop5ltOZeQOBt2zhKLAPPW6/Pk4jHxKC5VJLO04DyUbccMev/QARsKlIzOnwrOY2bMQo/gcH0KXiWuDwVa8In5jxZlXeYMFmgXpehpYKak5kSaiO9bxaPLQCT9YmAQxvIeZxPZmZxASVKZOFer2b5Cpmx+n1zzb4UMRG4yxqLKTHccaCn76WEh/TuCbjI6+Uu2P86bbiVKthHJqkS6xs48RLXi1zGQbTXEgC8QXViXrjUr6qlDEnVuimWIcVyxsLXN+mCcIPpNweDWth00VCbPzsbgcMjYIx7cmt6sS5bAulYTjZU4Ssqs5yv0e/qNEkFkF9JIT8weHXmi2ny3T9ptDqKG92exmRYx2uQHaj+8MiiCAOCdTEcvEzGimW3YwJUzOivcu/F4nXIja3cQguZX8vHNJqBzBMifnZgnFFE1CItoCiKGIQMej+Cwg/Y1llXvg7bi88ll6ME1VLtxc//15IubYLssM/Zk3aqNpzPlult5jbZaQKQFls0RgG9GOq5kl1qRO4grIGiuGvJ8KtSUoJvo+xpTxhUzPz23hRdgzLJN+Ahxp7DzoQ7CWOxMQWt/Xx4ofhtN3PUJYy7KkbH1OFiJJzdvaDwJ96+dn95b+APEqRRbog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7f5bb9-fd80-46c7-b571-08d8718378ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:55.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfEevNBeZYUKDPqOY4lS08Cx6sQSnyUXajtMETQPVso0nzftTUmyX/cENB2YM2O1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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

Instead of sharing the fan table setup with Tonga, Polaris has
its own fan table setup.

Change-Id: Ib6f69b9d1dbea30b480dbe0932ac073c1aa303b2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 30 ++++++++++
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 58 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12..614f61ae214a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -315,6 +315,36 @@ typedef struct _ATOM_Fiji_Fan_Table {
 	USHORT  usReserved;
 } ATOM_Fiji_Fan_Table;
 
+typedef struct _ATOM_Polaris_Fan_Table {
+	UCHAR   ucRevId;						 /* Change this if the table format changes or version changes so that the other fields are not the same. */
+	UCHAR   ucTHyst;						 /* Temperature hysteresis. Integer. */
+	USHORT  usTMin; 						 /* The temperature, in 0.01 centigrades, below which we just run at a minimal PWM. */
+	USHORT  usTMed; 						 /* The middle temperature where we change slopes. */
+	USHORT  usTHigh;						 /* The high point above TMed for adjusting the second slope. */
+	USHORT  usPWMMin;						 /* The minimum PWM value in percent (0.01% increments). */
+	USHORT  usPWMMed;						 /* The PWM value (in percent) at TMed. */
+	USHORT  usPWMHigh;						 /* The PWM value at THigh. */
+	USHORT  usTMax; 						 /* The max temperature */
+	UCHAR   ucFanControlMode;				  /* Legacy or Fuzzy Fan mode */
+	USHORT  usFanPWMMax;					  /* Maximum allowed fan power in percent */
+	USHORT  usFanOutputSensitivity;		  /* Sensitivity of fan reaction to temepature changes */
+	USHORT  usFanRPMMax;					  /* The default value in RPM */
+	ULONG  ulMinFanSCLKAcousticLimit;		/* Minimum Fan Controller SCLK Frequency Acoustic Limit. */
+	UCHAR   ucTargetTemperature;			 /* Advanced fan controller target temperature. */
+	UCHAR   ucMinimumPWMLimit; 			  /* The minimum PWM that the advanced fan controller can set.	This should be set to the highest PWM that will run the fan at its lowest RPM. */
+	USHORT  usFanGainEdge;
+	USHORT  usFanGainHotspot;
+	USHORT  usFanGainLiquid;
+	USHORT  usFanGainVrVddc;
+	USHORT  usFanGainVrMvdd;
+	USHORT  usFanGainPlx;
+	USHORT  usFanGainHbm;
+	UCHAR   ucEnableZeroRPM;
+	UCHAR   ucFanStopTemperature;
+	UCHAR   ucFanStartTemperature;
+	USHORT  usReserved;
+} ATOM_Polaris_Fan_Table;
+
 typedef struct _ATOM_Tonga_Thermal_Controller {
 	UCHAR ucRevId;
 	UCHAR ucType;		   /* one of ATOM_TONGA_PP_THERMALCONTROLLER_* */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 4fa58614e26a..4ed9f8106b2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -949,7 +949,7 @@ static int init_thermal_controller(
 			= tonga_fan_table->ucTargetTemperature;
 		hwmgr->thermal_controller.advanceFanControlParameters.ucMinimumPWMLimit
 			= tonga_fan_table->ucMinimumPWMLimit;
-	} else {
+	} else if (fan_table->ucRevId == 8) {
 		const ATOM_Fiji_Fan_Table *fiji_fan_table =
 			(ATOM_Fiji_Fan_Table *)fan_table;
 		hwmgr->thermal_controller.advanceFanControlParameters.ucTHyst
@@ -999,6 +999,62 @@ static int init_thermal_controller(
 			= le16_to_cpu(fiji_fan_table->usFanGainPlx);
 		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainHbm
 			= le16_to_cpu(fiji_fan_table->usFanGainHbm);
+	} else if (fan_table->ucRevId >= 9) {
+		const ATOM_Polaris_Fan_Table *polaris_fan_table =
+			(ATOM_Polaris_Fan_Table *)fan_table;
+		hwmgr->thermal_controller.advanceFanControlParameters.ucTHyst
+			= polaris_fan_table->ucTHyst;
+		hwmgr->thermal_controller.advanceFanControlParameters.usTMin
+			= le16_to_cpu(polaris_fan_table->usTMin);
+		hwmgr->thermal_controller.advanceFanControlParameters.usTMed
+			= le16_to_cpu(polaris_fan_table->usTMed);
+		hwmgr->thermal_controller.advanceFanControlParameters.usTHigh
+			= le16_to_cpu(polaris_fan_table->usTHigh);
+		hwmgr->thermal_controller.advanceFanControlParameters.usPWMMin
+			= le16_to_cpu(polaris_fan_table->usPWMMin);
+		hwmgr->thermal_controller.advanceFanControlParameters.usPWMMed
+			= le16_to_cpu(polaris_fan_table->usPWMMed);
+		hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh
+			= le16_to_cpu(polaris_fan_table->usPWMHigh);
+		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
+			= le16_to_cpu(polaris_fan_table->usTMax);
+		hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode
+			= polaris_fan_table->ucFanControlMode;
+		hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanPWM
+			= le16_to_cpu(polaris_fan_table->usFanPWMMax);
+		hwmgr->thermal_controller.advanceFanControlParameters.usDefaultFanOutputSensitivity
+			= 4836;
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanOutputSensitivity
+			= le16_to_cpu(polaris_fan_table->usFanOutputSensitivity);
+		hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanRPM
+			= le16_to_cpu(polaris_fan_table->usFanRPMMax);
+		hwmgr->thermal_controller.advanceFanControlParameters.ulMinFanSCLKAcousticLimit
+			= (le32_to_cpu(polaris_fan_table->ulMinFanSCLKAcousticLimit) / 100); /* PPTable stores it in 10Khz unit for 2 decimal places.  SMC wants MHz. */
+		hwmgr->thermal_controller.advanceFanControlParameters.ucTargetTemperature
+			= polaris_fan_table->ucTargetTemperature;
+		hwmgr->thermal_controller.advanceFanControlParameters.ucMinimumPWMLimit
+			= polaris_fan_table->ucMinimumPWMLimit;
+
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainEdge
+			= le16_to_cpu(polaris_fan_table->usFanGainEdge);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainHotspot
+			= le16_to_cpu(polaris_fan_table->usFanGainHotspot);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainLiquid
+			= le16_to_cpu(polaris_fan_table->usFanGainLiquid);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainVrVddc
+			= le16_to_cpu(polaris_fan_table->usFanGainVrVddc);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainVrMvdd
+			= le16_to_cpu(polaris_fan_table->usFanGainVrMvdd);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainPlx
+			= le16_to_cpu(polaris_fan_table->usFanGainPlx);
+		hwmgr->thermal_controller.advanceFanControlParameters.usFanGainHbm
+			= le16_to_cpu(polaris_fan_table->usFanGainHbm);
+		hwmgr->thermal_controller.advanceFanControlParameters.ucEnableZeroRPM
+			= le16_to_cpu(polaris_fan_table->ucEnableZeroRPM);
+		hwmgr->thermal_controller.advanceFanControlParameters.ucFanStopTemperature
+			= le16_to_cpu(polaris_fan_table->ucFanStopTemperature);
+		hwmgr->thermal_controller.advanceFanControlParameters.ucFanStartTemperature
+			= le16_to_cpu(polaris_fan_table->ucFanStartTemperature);
 	}
 
 	return 0;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
