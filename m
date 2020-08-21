Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F40C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D4F2075E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yl2ATzkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D4F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFF26E060;
	Fri, 21 Aug 2020 04:42:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F6C6E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 04:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Li0Zkksh2leY3niIwD6LfMaNW1txuMjGhDU0qHzm6mhdlO1h4LEPlTwezdEkp2jMhfyy1b9T4GjqKMXXInQyxqrfOV1gE7UiulYDxe2LDqR2ndiTwqkP1ExWjI77LzeiNS9Aj2WU9Jvt+ePrk+pLQjpcQ1WnhEB3iuugd/ARgwlYuV/XkI/AS+vYpbe8r7WgXFzXiJ8qiSSAcanqXIbg37kJK1kxwfl5W+IPohqI3VxO7oSBpIVS+nY8dRTzigtkw8KIdblwUesvA4zDBWase95d89gZayntB7xn11MOiadUUevnZkej70SbWEJR+/nrH24oEeMfKvah5seXgxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWf/xpO25s4cj2Lr93pbel305q2VaW+gJlu8hr8XVZg=;
 b=EDxCXSgtQ9s2lK/AFJRJZYpAqcQd1kckFoDMZKJ6Z3fxX+BG7Uyet/AYYDx5tkz6ZyAA8hi5dN6Zkg9MKa/6VA4RZ5J6asminne6JNt28BtQYeQdLebp3PetEaWgCQ/3GG7ScQAQZrp5SputZ+/+hFhE20LxAR74jAv3dICrLtvEfALx2MQEVZ3xQEMDzE66ZZEYvX8mfjyhMiSkDrUhl286P3GpMWD1Sz/IpVNoiZutr+AuQmEEEYbvAB/w7VN0fuUmyeNhtSC0mZm4ogMwtU6Cl4lnica3Hv/ZiqoMS1scFCeI5XI8i1RNMZPOMokcDO3VJMN8ce3VcFTtUph7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWf/xpO25s4cj2Lr93pbel305q2VaW+gJlu8hr8XVZg=;
 b=yl2ATzkdR229S4DCuCqcNKMVIjMTpOtb7HzcpVNzAl9ac9vxlb8b355PLdoDHMf64Zwbx+FjAgXzt31zqMhzjh7zfJN0GZER9dTkDQkn0Eg9in5ZgXkvO7/uecGXiMIYoQ5XpcztfUJ+FEk0IZqU6t1aZwjcBTyYo5XL21K1iaU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 04:42:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Fri, 21 Aug 2020
 04:42:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: correct Vega10 swctf limit setting
Date: Fri, 21 Aug 2020 12:42:10 +0800
Message-Id: <20200821044212.3039-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.0 via Frontend Transport; Fri, 21 Aug 2020 04:42:33 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60181d2e-7c85-40b6-53f7-08d8458c9f77
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40433F0336C5CB6C55114DACE45B0@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXdm2UbDtw4Uc1byyC9U2LMXPsh/oopJCwvsPVDiTKI0c4OVL/scd8I4NAdJJXTDSkWCAUmLFX3U0DC/3/g0EEu9oRN8B5xQXXBQ1MtN1V4WbKTp6VGgac5/oQ7AheCBrATLjDyMKxnxV3iikVDmS/04CJI56iWAfVHSc50ZugKHdxDKnWpN6pCkDZIqb7m5WSBELntBzqlalpJMJZtLhKd+RwlEeobF+39+PS7bbkgWrXaZqwW9rXBBADLXte7XDFQUcb+NG3gK9X+DNtCuMXdEHh5idfmk2Mnt9tD5emBLTSXR2ZUiNXFdiX7bZgVyQL7AXPI32PSlMtAsPEd3SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(8936002)(1076003)(4326008)(2616005)(66476007)(6486002)(478600001)(66556008)(7696005)(52116002)(36756003)(44832011)(5660300002)(956004)(26005)(66946007)(16526019)(186003)(316002)(6916009)(2906002)(86362001)(83380400001)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uI+gUYskZkDnczfDSD1wWkOhUGyMC4b8aLbsX8YVKNzilzl39aGwL/qoxc+0W2+vMjTudmXaNPJSmEvuD6uysHIa2TWJVVgN6XG/t8t6a7GLBPviNSPkU+29vRRLYqY9tcZpM8Tu8cStHLeKb1rmu/VAPp3GYHbXo4FE14Ea0+3yjO6DgVuoyqmei+EaZdEBTg9k/sjN7hX84He376qhaYF1+DceH/lEnZPuAkMqdxS7dBDGPIH2LHBslnuooGneJYNmbySqDDbmm1KaOcp8VIxBTLDMUZ9JcNwzKqwCUOJhu/IJyFRBe0FdsAVhO3Gf4WrsclArMHpdlTqm9vifVblTwH4mjg7Lw6qLq6TwQvCeLYIHpd0wTLh72LW6A4Kwzb4UgAUtsacAdRRyVJutuBjf4xZ6gIBNO8U/a58LbMVasNo5UFYJnM7elfXQ1JRQ2AhkXEEUFolRk9+t+AFal9lSyvX9lWFBQQvgTCMtAf3uMsgHiqrk4WcRBrxCAezF5GCA/GAGY1jNCF4GjHNwciQ0PUaosBFC1QdQiMk8vhoNGoXBDUvtXFirseCKg8jLd0bZqip/z+JPml7vAOVeqIzDqUUnQdYNS1RyCKENFfxC8fw1r1/vS3xyhNWhUc4CTh91CtbaqoERccdT1mxxGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60181d2e-7c85-40b6-53f7-08d8458c9f77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 04:42:34.8859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgYMx6sZbuvd+iJy1KJXEr5l2lvgb1pIqUgDKscnoYkvwX3ubQ65JQo8h3ws6k80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

Correct the Vega10 thermal swctf limit.

Change-Id: I220c18bcb0772bfb8cb674337bac6dccafbd7698
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 468bdd6f6697..ce9514c881ec 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -363,6 +363,9 @@ int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -372,8 +375,8 @@ static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
 	if (low < range->min)
 		low = range->min;
-	if (high > range->max)
-		high = range->max;
+	if (high > tdp_table->usSoftwareShutdownTemp)
+		high = tdp_table->usSoftwareShutdownTemp;
 
 	if (low > high)
 		return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
