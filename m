Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C7C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D6B206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qf+kODpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D6B206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF456EA7C;
	Fri, 16 Oct 2020 03:28:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80F96EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi73RiudCYgYgZae3yGxu4qrOm43/wioKS6uWILvsSgYFyo74a0XEwF9HxfkjCec+leCquW0vo8+3cBW9WpXl2ykeb0tBJCwFaFGI7UWEGFKZlfRHAdZ4POVM6FLyOhi7VlNKNlfyzFc8IrFTrUMlW3Bcu3/bSVlYzPwyHy+2iyfUmfwPrtApUiuo+9Us11NX39YRL1Z+n1FdIUKVrQ0CshkExvV21XZbzq8mPssVxvYCTEhdo/gKdb3z+6E9VjoeUY4AmYGT1OzVJZFEcD6Hi8EH6MI9disnETMouaTY0Adp+qseWPGI7yOa8PW+/WChc6iYgMgC+1d026iiSp/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbUcmpZG6rWSViGmVp6Rr+sWUm+05RIadE+E977lDEI=;
 b=XbSo2Mx1eQG4HvRTJ3GiZNV4L8uVImMVbZWGnAlyVH+/OM9RRLqwxBY5tEx15NrpYRdZgO7szUgtuii89hjsKpOOwJqXb8+c+i5Bsi+Nrsf4RjFja0OZy7VLBQiXWcqSHLnrFIU9uiGPB1gJwhoPqDEUcIZjuco6mq8ABI9e7GmzJBEYvVMq9U9mYH8+yM2GoAyaPTEB2kFpD4L6f+KymWLUg/pjqpi9jOD9tzqaOwaTDj5heOerE0EAcYj4jayqetFNWaDRiazaZeyaB7C7vKGxQJcJ4GuN0GNoXcNQIRxFBM14SmpDOpDyIRLGVj7I3SFYbibLI50lI2xaQG/Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbUcmpZG6rWSViGmVp6Rr+sWUm+05RIadE+E977lDEI=;
 b=Qf+kODpHRJ5ZAYbsCDCD9VOTj0v9dIGz3qNDpJMVs+rdmv/EMMV1mcv09Jz1AzEn3haR52hE4lK2AnYLXe+5HjSgONb/ef9ug2cvtk4VDwqemGnIccJG3ygBtcFLnf2zzLSHqpWeWoWaQO+5mcJg3yldsjvnhGcBMnGXmwj1jcY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/40] drm/amd/pm: correct the settings for ro range minimum
 and maximum
Date: Fri, 16 Oct 2020 11:26:28 +0800
Message-Id: <20201016032652.507-17-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49018967-df0f-42b7-0901-08d871837bf0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13542D3FA7875B7CB1482602E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jws0rTHgIkBVbKOTystRZQ3S1isqHi0aG3fp57MFpSULGfP/ltovhc5N2X58YTHCrf0VzQ4Ojwdp1tVFg5qAZYhXaf+Dk4Autd8WISN8ia7di2OAzzBqPZ9FfxOpgbkewBteAvULEt246UMOCpK8+HYml/uAEp63dKoDWJbqsnQsRBrncscWy2P+dS4mhnBcfkZOJv/8ww0S1dwRgaFY3hJklOQiBaoxDEmmCXq8j5JS3gg4vT9y9FlBLJcz1fAyXLIuesRBkvoqugIthD5WeKCykQaqCycI1E3zQK75jTT6d3451Y3FVAMYOKubpI9nD2oBOXX1PgKNsOdamS+/GEsKTC2dHjui6cWxI02KA6zp2jCxzlDd7MxuXfR/VX1P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V9M1a+qK3aGLVWuXshjaDotuavCy2+moK/aLgdvppLmYyRl3g1y4JY0/ZcKODVNyXBuNNZ8nUk+w4WOI5s2IDYvAzyMEOnnmiO0l+fNstapWwDeEKwK9A+ai4b8U9P0+1Orm7XmB++B4HUctEE38d26F46d/6lPd/23SDl61IAYGPe4G+KgnVqMAEGQahMm0lQaYlyOzQZcG2t6jwChC8qat50iixyahIqmZFzDv3n5Qevn56y5g9EUpGNdDo1BH9xwL3pVteAZtaEnrmxbAFdwEEXX279tkgzRtmJ22kuLwxKeM6bLebFiKRZOnJuE3SYTnuzboGNWBaTipcuzYQ2pG8IoVJf+Huv7wZe69kpODsbGVTZuvi0yQC7/5vAiHZAOM2z2xSFFJENZIiF/kmI6c4Rja4uLJp3lyhXLXN1CzO9nKh2mi4Tx3mYvPy6Cg8LKa7xtVrGOqYMsYGmesoC3S3lgTIGs4qUYRvAOBrOW7XRBq4mXWZX8gNAidEar1LPJSyIE9V9v95UX4/qJoU5APjjfkpfnC51KZdL/Dh26sRPU/QZRi9FO/ysLmZ71y63Sa40UnBFLXC4r9M1PeUdZnev3mJIK9DKkGemCs/fU2Ex/uaxjy6XHas5IFDy5+fzpxkDWmAtM1iYy9bNlCKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49018967-df0f-42b7-0901-08d871837bf0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:00.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xwZiLceswiB39DBoVMk94KSHPVEVEWTPJYpgVexJvtpqP+CgmGHiT3ZpIo5OVN7
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

Make the settings more precise.

Change-Id: I0d1aa32fec21824591e58841a5c7f17b35ddb720
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 62 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |  3 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5a812f170eb0..b32dc0d6e880 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -97,6 +97,9 @@ static struct profile_mode_setting smu7_profiling[7] =
 #define PWR_SVI2_PLANE1_LOAD__PSI1__SHIFT                  0x00000005
 #define PWR_SVI2_PLANE1_LOAD__PSI0_EN__SHIFT               0x00000006
 
+#define STRAP_EVV_REVISION_MSB		2211
+#define STRAP_EVV_REVISION_LSB		2208
+
 /** Values for the CG_THERMAL_CTRL::DPM_EVENT_SRC field. */
 enum DPM_EVENT_SRC {
 	DPM_EVENT_SRC_ANALOG = 0,
@@ -1696,6 +1699,61 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 			      PHM_PlatformCaps_VCEPowerGating);
 }
 
+static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t asicrev1, evv_revision, max, min;
+
+	atomctrl_read_efuse(hwmgr, STRAP_EVV_REVISION_LSB, STRAP_EVV_REVISION_MSB,
+			&evv_revision);
+
+	atomctrl_read_efuse(hwmgr, 568, 579, &asicrev1);
+
+	if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P30(adev->pdev->device, adev->pdev->revision)) {
+		min = 1200;
+		max = 2500;
+	} else if (ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+		   ASICID_IS_P31(adev->pdev->device, adev->pdev->revision)) {
+		min = 900;
+		max= 2100;
+	} else if (hwmgr->chip_id == CHIP_POLARIS10) {
+		if (adev->pdev->subsystem_vendor == 0x106B) {
+			min = 1000;
+			max = 2300;
+		} else {
+			if (evv_revision == 0) {
+				min = 1000;
+				max = 2300;
+			} else if (evv_revision == 1) {
+				if (asicrev1 == 326) {
+					min = 1200;
+					max = 2500;
+					/* TODO: PATCH RO in VBIOS */
+				} else {
+					min = 1200;
+					max = 2000;
+				}
+			} else if (evv_revision == 2) {
+				min = 1200;
+				max = 2500;
+			}
+		}
+	} else if ((hwmgr->chip_id == CHIP_POLARIS11) ||
+		   (hwmgr->chip_id == CHIP_POLARIS12)) {
+		min = 1100;
+		max = 2100;
+	}
+
+	data->ro_range_minimum = min;
+	data->ro_range_maximum = max;
+
+	/* TODO: PATCH RO in VBIOS here */
+
+	return 0;
+}
+
 /**
 * Get Leakage VDDC based on leakage ID.
 *
@@ -1714,6 +1772,10 @@ static int smu7_get_evv_voltages(struct pp_hwmgr *hwmgr)
 			(struct phm_ppt_v1_information *)hwmgr->pptable;
 	struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table = NULL;
 
+	if (hwmgr->chip_id == CHIP_POLARIS10 ||
+	    hwmgr->chip_id == CHIP_POLARIS11 ||
+	    hwmgr->chip_id == CHIP_POLARIS12)
+		smu7_calculate_ro_range(hwmgr);
 
 	for (i = 0; i < SMU7_MAX_LEAKAGE_COUNT; i++) {
 		vv_id = ATOM_VIRTUAL_VOLTAGE_ID0 + i;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index 69d361f8dfca..b10e5bbffdf5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -328,6 +328,9 @@ struct smu7_hwmgr {
 	uint16_t                              mem_latency_low;
 	uint32_t                              vr_config;
 	struct profile_mode_setting           current_profile_setting;
+
+	uint32_t                              ro_range_minimum;
+	uint32_t                              ro_range_maximum;
 };
 
 /* To convert to Q8.8 format for firmware */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
