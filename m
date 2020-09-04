Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44547C43461
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D8E206C9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xAVkoWEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D8E206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9608B6E241;
	Fri,  4 Sep 2020 08:27:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134786E241
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfRQZuQRMxLuj7SRy/MEe95JPlduUHvfJiGU9DMhz0RrQMMjsJQlfhjvPWUkTql2VIVbKoy18zlBYuRwOzx+ovgxbptFPoAKgvyXv72hZHvqXKPqLHq9s+vSjZ0MomLaKOXjBUZWTiyulaBHP1aOos5w26z90NTNrcNa6lA7Eou1v5bT0FBSazXu4Mmnt7ORG5iao6oyKRoTFyOXdmjdf6AOyw6ahyBPPQCcVG30rOZkOsMA3gbCREdikd5yOcPiEVnCLeEVyLoiEIvfRtKXxrcToXdWc+qgzqEgtOjWb38Gb6LtnzInEn8m7J6nIvHuvqf/FzCxOui8+xoWkabd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GIM71j5cksaV9LY/NGySwJVvtFqqkAJrbsWkbCaQRY=;
 b=YAzjqWksUrGFEc0sKuRm1mn5S+CXukhiUdnvnq+GhLuQcXjYse9lmLfwCRlxMuVuUd+KtoyDYkB2Mk9yT9PwkyeAyL7qzzUSiPIcT6/gOdORJWeP3OuBmbMgiAjJAh3ODs7jGp2lSSImOpuXlj7FthnxfJ+S37A5zySmI37gQ3GDkvn/g0rmZZ3iK0ttmNkZJq0OVdqRVZh6AzqxWwrKIWRFtvQtuJPzPQW4FHfb4Q1qfrHUac79NF27yAhnIl/z1jUx4dyyUPckF7WUVEmUEbklcGsxGOdam7LW677c0Aw3krx75ahNgld6/DMo1dWmxVH7V5byCw2B3Uj80rVQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GIM71j5cksaV9LY/NGySwJVvtFqqkAJrbsWkbCaQRY=;
 b=xAVkoWEzp0UIAC0kKW8SlYksBRlTdpcaEroF6HC8S4Y4hBvgX+u+7zw5o9RBieqeiVPrS3G3y8JYY/U7DBlpMGdCfAKeYlT4NxZBvs7tUo7TrTO4pHF2VR8C5TengNpoNWGleGf08a80udiWhs3Nq/+IUwJBr8cftb0IMmfFuYg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.24; Fri, 4 Sep 2020 08:27:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:27:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: apply no power source workaround if dc
 reported by gpio
Date: Fri,  4 Sep 2020 16:27:13 +0800
Message-Id: <20200904082714.19995-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0043.apcprd03.prod.outlook.com (2603:1096:202:17::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.7 via Frontend Transport; Fri, 4 Sep 2020 08:27:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db1ee925-f144-4b82-88bd-08d850ac604c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3468DC3D294376B17B09CE52E42D0@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBGRxhAapBYkkdrbnZvvvtLoQIPY+Xxcpo2bRcUTLRKyOptQGlDPt3K5UZS9nIrBrssqYSxN8MbqQfgvIpQzu/FmqvvigUPu3KhQ8fMd7qdBA/BkTSuTt8YbAuEqHrG4nsgzAQAueD1Oj/h26ZYvM5v6O7Dbty8gxnOXYuop21Vamn46jFb6tP86SRdz+wJUIiO6b/OofcdwKu/2HFHFjbuJugLmB9113MuG5Vena4x2oCK8zeSd48FvOcFWzp82xqa+l/vEI2EYOQHsO8hfJ4bR5YahEItS9PCh224pNpAan+DxpflGip5NRG6uQ+xa9EuIrABSdwGHGSwxkZ+T8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(8676002)(478600001)(66946007)(36756003)(8936002)(7696005)(44832011)(52116002)(2906002)(316002)(5660300002)(16526019)(1076003)(26005)(2616005)(86362001)(6666004)(6486002)(6916009)(83380400001)(66556008)(956004)(186003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JEzkHSacDoy9VJiCHwzuWqAp/+mDkDRCkFez14TBmHK7cQuCnrxhZ6/yHmn8GzlkzujN/abhEYfe+hMTW4Fq98hTn43XOY6cbN10xRE19/s6ISjdgimQliHxJgokuod46molfzEI03xjNbHgmS8OVR2SPUlAQ7C0yqW3SL6iYnjsCbziHPBAFi1fjeBsxL3shIG1TkNqFaay4yY1VWK2AOQy22NXnOY9Xk1JV/8EWxnKbm+S1u4z2DVSvei6ta8jqAU3QIRVE9sy3ZXszJ/kGIpJ+wM8VOrCX/X1wvXz3THujoWm8U5e0LzgRCAlfdKkfdQo53wf60mVpKFjQdVKVBqhibrxvP4i3Z49J+YQpt5hJWUTz9wmhsrBvwWe0PbJZbtcSJ3k8xbB11sEAOAw+ilqqvDYFTe9hzofIkdlaiz+2Y0MlNnB9d3rbM7zDFXfmwzoNyeUwadPus6+KW4Zqd8Ew4o0gYFDo5tGYYS1CQ3wVVrp5iwFoo38XaTTgw3YFV7DuvpPrSJzrVjK0wW8XcTP3Ig30uZdvDdEUmRptexCjIfJZzyMha/3s1hMuUf46HoYO91bu89h33Rv0CF00ENK/QmguN/UlvL8aJIgV+XoHkew8445QdDL8dTe7qVEC7nCU+jOng9FfMyPSj0gGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ee925-f144-4b82-88bd-08d850ac604c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:27:35.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xvp9WdPwA3LSJRvOxlGIvYMkE7zxx07jFAN4H7zjTagFw806WPlmdBpogxdmA0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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

If dc reported by gpio is supported, the power source switching will
be performed by pmfw automatically. Thus the power source setting
workaround for Navi1x will be not needed.

Change-Id: Idd6231ce1e33a4e292e7eff3b0f8b779911944f1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 489a84792002..35258f980de5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1013,16 +1013,18 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	/*
-	 * For Navi1X, manually switch it to AC mode as PMFW
-	 * may boot it with DC mode.
-	 */
-	ret = smu_set_power_source(smu,
-				   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
-				   SMU_POWER_SOURCE_DC);
-	if (ret) {
-		dev_err(adev->dev, "Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
-		return ret;
+	if (!smu->dc_controlled_by_gpio) {
+		/*
+		 * For Navi1X, manually switch it to AC mode as PMFW
+		 * may boot it with DC mode.
+		 */
+		ret = smu_set_power_source(smu,
+					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+					   SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(adev->dev, "Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
 	}
 
 	ret = smu_notify_display_change(smu);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
