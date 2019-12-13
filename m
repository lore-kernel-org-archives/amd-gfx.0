Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F1C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 03:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E2924656
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 03:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l0Xz+FPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E2924656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44136E264;
	Fri, 13 Dec 2019 03:24:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D85F6E264
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 03:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5k0Mqmgc2kZP0m+/kKUUk+mBInEWdCVV6EY8p+a5NaNiAm1q1FnqYAn0gO3FIxQN6Se4GFFnp2wqWQd05wIv+jtiCx9nsY6Ypwvejo+8prxMSGSFbF2UXQzXjogidfsi+j9rJweN0QKUwC4gv2+iyXodpeeYfQ/E4iZRbEC74bpMqfCjQNoFpAuXtyuYMYDnx9QwYsLU7agwklTwunXWBcIoemMyzbcwrWC0FjZgkZ7PKOstNvYEPtmTh8ZBViepLYlpd9A1d2rijAnPPDeWwm4ZytsXYZgY9gBNuthrm3vmEGuni0yZacQsT8mXIAkL7JgsczlnJrb5/D+DpKtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asTR8PN5MfYCEfOpnrLwjtcHH7b0H/bsbVk0i8Cen/M=;
 b=FUb6igpAur3O6BVOOxonO1epDx+Vgym4batq8+KwXKWTHOxrfKetFi81JQgMial6qiKJKMCmZsmxMit4b7TxO/ujHwq5PQDU+wLMF6ZuOIhuVSSEyJh6AnQ+O6eswkLue6J318UStzp2GYhCejW5oVbdcSgp02toFwzeLYjCRJ4NvBIOgumvmV+kSpchmS330RsUo12NdA49BR1k6IFWbGrGhjJ4MqtzciW6KKQQpCDN8D9wlTVBps5OlCnf0V0wvxaO9eiLh/5YuA0lFStIpSB9gj0zl5escjezfgHPdR6Ya42nkNDholBkLVrXCxug2nHhgd0OxVCAjuM59nS6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asTR8PN5MfYCEfOpnrLwjtcHH7b0H/bsbVk0i8Cen/M=;
 b=l0Xz+FPcIgS0PueTICh9pYLFsqNXDx+BScOc0y+5S/0LcC61wKaOfnU3bvSQ9zUVTiaa98420vrs7nJKspg1GcknL9MNn3BIu75A3v2IbqEvGGX4yBj05bRT8ux15AHZ38CACnudCLbrwpDIvWv46UpxxpKL4463L6w5KT29C7Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3904.namprd12.prod.outlook.com (10.255.237.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 03:24:22 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::a0b1:2a79:d019:8c9e]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::a0b1:2a79:d019:8c9e%4]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 03:24:21 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Prike.Liang@amd.com, Aaron.Liu@amd.com,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Date: Fri, 13 Dec 2019 11:24:00 +0800
Message-Id: <20191213032400.12829-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b05f72d0-cae3-4356-f474-08d77f7bf1ef
X-MS-TrafficTypeDiagnostic: MN2PR12MB3904:|MN2PR12MB3904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB390461AED5C2E50F0506B54CFD540@MN2PR12MB3904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(26005)(478600001)(6666004)(8936002)(86362001)(316002)(186003)(6506007)(81166006)(81156014)(6486002)(8676002)(36756003)(6512007)(66556008)(66476007)(2906002)(5660300002)(2616005)(66946007)(6636002)(4326008)(52116002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3904;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H38uQen7+mQXZBvxS1ZgSDRWH7PyyvI9wBSXYvIMD+ld5eTVnZP/6EUKt7uwfIzXXrXqRWo3gLHOEWALk8Ca25QjkMdTvc6RAqvdkVcZWflORh2W/V4RngqScw4bxWR4NA699iCQEibEmnHuY6C//yCqlTavUcTVrdwcZ0fWv7wkzKVb7pwjmNTuWTwJJnBmbvbsAbVtEXqF2RXKgJ4CvmSoMEeUytmZqMKq1EEkMTyVSU2lmpxJMd7OtGnR9fLmqBYWp6sTQYo/XVvWflLO7z4K8XHxj0rCydKKZPn9+e0sirBUKGxjrWFcnekem467A2Jqdj3ecjaQjMTrXNGtHeGjKYTFWU7nVWc6ziqwf3sc0/mrld6QfjZ2+6HOUsPbqGcBtuOo/56k7Fib3YUNaDySCw8JiVehC6hAd8o7tq5Lewj3Zm1QEmxZa82oS1t2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05f72d0-cae3-4356-f474-08d77f7bf1ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 03:24:21.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgG3V+fhOn9Tje3eX9/v2AHNi4YzPFFrQHSYL9ElY5lk/JXeUtkYTFS4P76xMbHfMqj3UqAx5XSqbIypp9hDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

When smu version is larger than 0x41e2b, it will load
raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
needs to avoid adev->pm.pp_feature &= ~PP_GFXOFF_MASK when it loads
raven_kicker_rlc.bin.

Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ea58d0e5be4c..68409bb7c9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1038,17 +1038,10 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		break;
 	case CHIP_RAVEN:
-		/* Disable GFXOFF on original raven.  There are combinations
-		 * of sbios and platforms that are not stable.
-		 */
-		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8))
-			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		else if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
-			 &&((adev->gfx.rlc_fw_version != 106 &&
-			     adev->gfx.rlc_fw_version < 531) ||
-			    (adev->gfx.rlc_fw_version == 53815) ||
-			    (adev->gfx.rlc_feature_version < 1) ||
-			    !adev->gfx.rlc.is_rlc_v2_1))
+		if (!(adev->rev_id >= 0x8 ||
+		      adev->pdev->device == 0x15d8) &&
+		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
+		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
