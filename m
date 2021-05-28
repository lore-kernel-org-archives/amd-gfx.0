Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1CC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9E561132
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9E561132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A906F634;
	Fri, 28 May 2021 23:06:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27A86F634
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcZxizg14Z1StTlUEmjkPlxp2TI23e9Kh+4aG3iw4CPZIiRctOUrRTlzoRtsB+kUJ5I8a0RrDdTXnmoMkPElvMXep7hEi0tTZa3MbTtyMsQZF0ICaJDyeUDbBL2DX82eYfbXD4JTTHZTtN1gIeXC+8A+vNHz/bSdVVEs9OyfzCqGtN3JiE8e1R8Rxwd7eaUxJyJyGo+fWrJ4dqNkGd/5qQHedK7AJxneJUFgw5l4iHIE3s6PFhkdn/vwNxr4HwxlH6Rrv3KsL5e93KB/bmx5dQ4OYrLu8bHN6xvDBAkPYJCa4M29ENPSGz3vEqn4wdipU9biJOvqrs5VNE7/KTo74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+6p3mse/t1Hmd9pin9FCqKNVLR7JNBYHQmBafYOzEA=;
 b=Yq8rFznZus/J0kFokZOLUa/V9fbpuGEiYIwA7Ma9tPVQoMPrnMwabxvb3qS1MXDqRgTHsLXeb73Ri4s5NS6UfQi0A6yfll8v9BjYrI37doj0v+rm+BfeJn3JlsNVMltcLBsESpw6mlxc8vOCSS8eVBMnWF5nQVu/Jbi66mwkkWLmGdzBM7AIRPwolgGWjbn87TiHIOxoknmpDzY5Y+inSJnfAUDNwdZ57WCsR145+xDKSC53zXTKCISlLg8suIRa3+3FZpqYn2vD91Y3rQSh9ftw6gxm0I7QbKlATVxfk67Q2QNqdsMJtU35ExNnMl4UtOmC25JHrFaQW7BSCosc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+6p3mse/t1Hmd9pin9FCqKNVLR7JNBYHQmBafYOzEA=;
 b=ulaU/Kd+eCuJbW0gwMrUmywU1zhFAI7JJHq/c5TkUApUad82L/IcrWRz6sbJW1KJfSJtJ2s/J4NYc2flpZHjyWvaX9F4j7VtrWeUuCByTzhgsDIITellhF+NTAmN+KpkJQAv9KXXaRGavnQy2LX/VfmplTB+B88HEUxtVHd9coM=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by BYAPR12MB3157.namprd12.prod.outlook.com (2603:10b6:a03:130::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 23:06:41 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::b0) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:41 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:38 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] amdgpu/pm: handle return value for get_power_limit
Date: Fri, 28 May 2021 19:06:20 -0400
Message-ID: <20210528230621.16468-6-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea068b25-87ec-4e75-8414-08d9222d4196
X-MS-TrafficTypeDiagnostic: BYAPR12MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3157FCE1E92D4941BF34681EF0229@BYAPR12MB3157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUsJZ+3lvnD8FqdB7UOdjYKuRhBvP8/u9LYs+P6HkVZAaPQsEJbIcRDb1U9kxFyWydkvFTBJCt1dWcZcwjUbYftuEf2xdMOeH+WaSy050KIpX+9AylF78oOpjl4ykIq3Qnj9baW4gxeqlS3YF82W/vR8Iapnynwr+1HINitWQKegQiXg3MFeJ+02Mv2hrOFsxJ2rA3TRx2NjrJj5qVBkp3+P4FMxUfWSCPKrpSwZCVy433SKMPniwtZnLx86EfBQqt0nQuC9TS+atJtGQEqtbOdxgJCPGlHwTp86N+x1XT52oZOQagQ5okwYQsM7yHzJKB1sAUjeOIvtpL5mVAl6FuTRdukI0zAJ7sRuz5UqGyGspJLv7g0oL7/X2rbvIYFFqwSelxb7nIoQdJxmSBgxsB05FRRt+pbnfkUyIc8b6wpiTGO4QcA4qfFpakkzHsMmSGGnx0/0E/hW4aKPeubKXHIJ9VRdhdAnHRwlu6eu6gHbRbY8wxxrtuPPynOXiYeb5dyr1rL6u3HYyGloRSKmjEyDicLYFudU3G9LJq5MDsJOnT5MLPZW1s1tzbdz2GqgpljH/JY9w/mLhJ8TUNOsZG6exkFGa612cxXP6N2OBQy7un6pwSvPveg3+ep9eCNen0mRHxkbTbqei86/5bUtnwfWrxsAgqjwNRudNJx2eqDmGZGUAKWIupIvnK2Rk23t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(82740400003)(82310400003)(16526019)(86362001)(7696005)(186003)(1076003)(356005)(36756003)(81166007)(8676002)(44832011)(5660300002)(336012)(2616005)(70206006)(83380400001)(6916009)(6666004)(4326008)(36860700001)(2906002)(47076005)(478600001)(8936002)(70586007)(26005)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:41.7232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea068b25-87ec-4e75-8414-08d9222d4196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3157
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 39 ++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 44715848705a..aa138abe6e1d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2734,13 +2734,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, sample_window);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, sample_window);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2771,13 +2774,16 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, sample_window);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, sample_window);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2808,13 +2814,16 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					  pp_limit_level, sample_window);
+	if (pp_funcs && pp_funcs->get_power_limit)
+		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					      pp_limit_level, sample_window);
+	else
+		r = -ENODATA;
+
+	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else {
+	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
-	}
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
