Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447C32078B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447C32078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DDC6E88E;
	Thu, 20 Aug 2020 02:20:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094CE6E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 02:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4o/Rp3iw4aGLgKBu4bjcVZTPnXlX99sH3PHj55T77ZxhWwsm++EocOPn9rKO7uZjru6L2n9m6nr6QzP96B4OH+MTB4vHyXbTZeQaJmzl/ag4QQqT1r9xfnst/t97NW0q3y1n8bIjBZSLUl/q/P4AtWhXdH8xi8GA7BpIbmZ4GMRPeSU4bkEn8ffzcx0cP8+FZEup+TEdnABJqvJJ10rDJW7hjF8rloTOwjuey6kaz+irRylj3+nlSxmzsNudVjwWQ9YnrzoIAH8sa59b9mItzSIyDGLl5ynaf4WjlTl+tDOAMQb8ZA7/3XmT8O2nHnKnjFTNqRmSDGQAE1sIW0ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CU8AsDTm058nMK8QZxmR8zDEgRDTH9IcLl94fkhdTQ=;
 b=m3GvIvybotlwfacKP1hzPR2iwUrcaWcx4EqI8KDVwnImRNVPF63fmXybcmB29mYM2peqglljUfqH5p80687yaLZHP9zmhtJmSDMTnbHTJRJsezRKPWcCZuX7LMHX7KttMgcUeky6yZEsBy718WczSG9+rOWdfPPmY/6pzXr3nOZ6GRuP2oGnU20EYf1NZGt/dBCxSzD4pJqsxqyF4t/CbsShz9uoWUfGGmn01ctueGLp7CdTH7XYQBq1SBuL2mJs4WuMG9SbITjAeW8vECl6g1C8/WFnc2kwHAyzfHnP6Ut3aA3caiJkxyvaKzddmsXgCJ9P6YZkTcZvXIWNHrG8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CU8AsDTm058nMK8QZxmR8zDEgRDTH9IcLl94fkhdTQ=;
 b=u8UsMqTWnyH+rXNoVC6Mra+4EyBjfhjhwydrDiMiRcAi1pjadKBhWRmC9V99u2QFrwdjW2OB90P60lkM8rVM+4ubkxtPj8GE6366JfBueotMU1q9TX0l+up5S6kVfXUAFiDRWofjfXgEe2vrOJsy4zyYaKBbj/Bxc5LwzEvlf/g=
Received: from BN6PR10CA0009.namprd10.prod.outlook.com (2603:10b6:405:1::19)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 02:20:53 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::bd) by BN6PR10CA0009.outlook.office365.com
 (2603:10b6:405:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 02:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 02:20:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 21:20:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 21:20:51 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 21:20:50 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery
Date: Thu, 20 Aug 2020 10:20:41 +0800
Message-ID: <20200820022041.19161-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696ce482-d3b2-4398-f726-08d844afa9fe
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4344C9FE5CB4F734DE664957ED5A0@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0CkqAEZIrDaPJ3Doa5OykZHWlStAtmSXjjV+dYb67AZpX1X8gztCXqxC8EmyqzFoDd3ReAkzCbl95VxTZqLewBmLFT1+nCvV0xSImOdYAiiwGkhFyJ4msB/Xb09dpN/7l0hu2rWiN7vmg8VMOyeSfReBxbxh0T8UjziyDsWcUhyGXw2ZUr7glXatVi3nU4qvDFCzvQbOUdkhhJy1zWeRwMMoIRTH/omG9e/azMS6ANpgVD5AOY9GAtI7wrTPmEG+TJwzYu+GCvn5dPcEzXCOdx/G7RxwvYLTJFJIZyhV+CfCC+C7G2o5B23nZuCwANMaHIMCz1VK/yAo+yWrJSHX37KTAAn5alhtoY1CHuBdu3sWdFNMsGQVh+aO12t/EDFPuWZZIb/A0mYtyfKnyQtr0PUyZM8coAq/kaqSaCeMhI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(336012)(83380400001)(82310400002)(81166007)(356005)(82740400003)(6666004)(2906002)(478600001)(70586007)(47076004)(7696005)(70206006)(6636002)(2616005)(4326008)(186003)(8676002)(316002)(1076003)(110136005)(4744005)(26005)(426003)(86362001)(36756003)(5660300002)(8936002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 02:20:53.4529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ce482-d3b2-4398-f726-08d844afa9fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

in single gpu system, if driver reenter gpu recovery,
amdgpu_device_lock_adev will return false, but hive is
nullptr now.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 82242e2f5658..81b1d9a1dca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4371,8 +4371,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			mutex_unlock(&hive->hive_lock);
-			return 0;
+			r = 0;
+			goto skip_recovery;
 		}
 
 		/*
@@ -4505,6 +4505,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
+skip_recovery:
 	if (hive) {
 		atomic_set(&hive->in_reset, 0);
 		mutex_unlock(&hive->hive_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
