Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2FC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEB4206C1
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fR/zoJSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEB4206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FBA6E948;
	Fri, 30 Oct 2020 03:04:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BA86E948
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 03:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZehjlPRMIL/KEVfcVK//KFk9MTf/sLl0J8zXB0dbbgcWWn6TIYWqe+A5yQBH86zQuOu21MkdhWmypSQer6lCh0sgeYSWCT1PMqO3nyP4rrkgZBWtZraMisIaF74fsgeox532d85lLOdw0iheQJIaTphdXxeHi2TERBPLupW7JowPr9uF1Iv0/WIaKDWu1pcCNeMY/LM4Kdiae1u/oyMIumZZaCWae3piRCxCREi9ujRSfufncI3vRvKwzn+dmbITIKkmgMR2IlVtpZQoVtaK4lEzpfzd0gE8Fm0kN0rGHxhUXiAOhBXf2xQ5uqna8mdyF3brZZkpSoxzozHAtVc/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpB1cUZT80YVlg7CMguu4/7dqKDjILMSWZdgnMk75Po=;
 b=ecHF7dbgZg0o+R6cTYMg3443z9Lam/gD46/mk3g32MYccEpViQvSKk6YBJopw6ALOTBVhoRixFdRKqXMPZsUfUdWHhM94GzAGf1fBzPK34vNGRaOkFqnK0ZBYrgVx3j+ty9+93WyvOMZtxNRGacOV+F7UKq71w1Rv863wOY5A6IJd5byt7otfLzI66YK2J71wI3n8b4S3svF/JNX5jLpIXgU5nxmPG2NfDyD1wC1lVJtxB/Hswp15yuf3vHFgtZQ5cosJEjQch6hJ+64+WQEi0OsRhgmdMVIoUq0JudiIGo4vB32ajs+1YjxxQ50+S5HYRueoCt2i7QbHoiDPiIFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpB1cUZT80YVlg7CMguu4/7dqKDjILMSWZdgnMk75Po=;
 b=fR/zoJSKZrxkjsagmMsQqpzV0TEHi95i4HUPMGCwG7zvSlzN8oQzytp2FXGoaxsVurQRZpIIbqXE0mnbT5sPlJPU6dt/Mr7qFZ/KAw6wZmG3z1fbCsE6pW9FN4gVSYmytDdRSt2sUmbL8OTuLgTMZ5bth+oTortlJZGFV4k0AGI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 30 Oct
 2020 03:04:50 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 03:04:50 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add the reset function of the pp_od_voltage_clk
 sysfs file for RV/RV2/PCO APU
Date: Fri, 30 Oct 2020 11:04:27 +0800
Message-Id: <20201030030427.20560-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR02CA0184.apcprd02.prod.outlook.com (2603:1096:201:21::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 03:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df79c665-d761-4fcb-dc06-08d87c8090f6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2468F63306A4E8288254C636F1150@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMZLdYvbRYYkUcu4RCUTD3UqUjDYIlNoA3Z11V8DLrSQgAWydllVgJOTotFnVCbv5nYiSJaNqFddkG0anT5qrO31K7QwAcZqXSKzTcqh+fEq/I8YGi1xesdnV/zbOxUFVSQxdPjiygHHEka+YoKdlkx6Qp0CuFqscygEFNF99QgPD415MBP9pQh1p6YAcng5t1jT4N3YvCzK3j+PjUBTN43NDC+1zcB8aaxa4mCzxJOPR+LHsGludyhTo3YWJiN7uHjqZxGvafexBGcq94F7v1r3UmPSqvDwCrNRMOF4Hy03pXsAZ450Gcg68d+Sg4H68FwdsmKy8tEyPq+a35cN+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(956004)(66946007)(8936002)(16526019)(86362001)(66476007)(66556008)(4326008)(2906002)(83380400001)(5660300002)(6666004)(6916009)(52116002)(7696005)(19627235002)(2616005)(54906003)(186003)(36756003)(316002)(8676002)(26005)(478600001)(6486002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kH3ZhiGmVahSGx+XcXq0nfjSWHEkn+udIBOlwwThr7k0DxgFKbjJip1BCUE+SXW3JNIsASA8ibbLlTXq/OXwCdKO2eltT1j0D3yVtQd2hsjP4J5+PbI4xCVeSuotgohhHWHDOAmK3imIE+R/KqxHgF0ZGcrLSGISgFcB6Iuiuh+gnVxWddAWpW6zJqpZsxzb6L/VbFR4vlhT1Lyhk5IIKy7SwMzvB0TYj6D4CT/JnX6Bcjgy0KMxXMQ6rIicvk62JLhJRHKqNXutkWsUHUIfYHht/bF8szSLFxNRhwQmV656Uk6BVDVftTJsyzB7oc2deVB0MtHSyXnenk6soyG5uMOzkDZtxweFYLTu6RUSNRFmhwefMndIOOHpe6VFfI9etqk19ZSfytriE4Kn5UYGQbzgrMiG5bP4JqYIq3VFiFycR2I2Pe0/UPHXz308eLC326b/QtV/To8gXVC2Ecr6UIaWZozqscLDnvm4lBYjvCpoyvtp0tVTtDYYhGHwU+CY+blcjW+3pcQsr0rIm0+dY8g7d1cO4EbcH17oSAdD0Kexfurxm3SdOAFXwT9toAhSAvZ/C+tJ3OkigWvDpc/zbaaBocur8wHelHwV92A6Ji6ZqwjrPE1aYXqSvX1wwcQ3vKtnMUGTiqAM56COWbXkeg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df79c665-d761-4fcb-dc06-08d87c8090f6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 03:04:50.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ylTDz6gb/Xe1Y+m+XYP5vrLMjz86k6urgX+sfEyZD3C/OfDKEYcjOscarZ7Q239obLq0cF4DHrkRhRic0lJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, kevin1.wang@amd.com,
 Xinmei.Huang@amd.com, ray.huang@amd.com, alexander.deucher@amd.com,
 Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add the reset function of the pp_od_voltage_clk sysfs
file for Raven/Raven2/Picasso APU.
If the min and max sclk frequence are configured, this function can
be used to restore the default sclk frequence.

Command guide:
echo "r" > pp_od_clk_voltage
        r - reset the sclk level

Example:
1) check the default sclk frequence
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        200Mhz
        1:       1400Mhz
        OD_RANGE:
        SCLK:     200MHz       1400MHz
2) use "s" -- set command to configure the min or max sclk frequence
        $ echo "s 0 600" > pp_od_clk_voltage
        $ echo "s 1 1000" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        600Mhz
        1:       1000Mhz
        OD_RANGE:
        SCLK:     200MHz       1400MHz
3) use "r" -- reset command to restore the default sclk frequence range
        $ echo "r" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        200Mhz
        1:       1400Mhz
        OD_RANGE:
        SCLK:     200MHz       1400MHz

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 32 ++++++++++++++-----
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index cf60f3992303..bbe7f101acbf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1421,18 +1421,34 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 	}
 
-	if (size != 2) {
-		pr_err("Input parameter number not correct\n");
-		return -EINVAL;
-	}
-
 	if (type == PP_OD_EDIT_SCLK_VDDC_TABLE) {
-		if (input[0] == 0)
+		if (size != 2) {
+			pr_err("Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
 			smu10_set_hard_min_gfxclk_by_freq(hwmgr, input[1]);
-		else if (input[0] == 1)
+		} else if (input[0] == 1) {
 			smu10_set_soft_max_gfxclk_by_freq(hwmgr, input[1]);
-		else
+		} else {
 			return -EINVAL;
+		}
+	} else if (type == PP_OD_RESTORE_DEFAULT_TABLE) {
+		if (size != 0) {
+			pr_err("Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		uint32_t min_freq, max_freq = 0;
+
+		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+		smu10_set_hard_min_gfxclk_by_freq(hwmgr, min_freq);
+		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+		smu10_set_soft_max_gfxclk_by_freq(hwmgr, max_freq);
+
+	} else {
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
