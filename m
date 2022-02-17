Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BB2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 09:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEBF10EC19;
	Thu, 17 Feb 2022 09:07:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4AB10EC17
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 09:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wiy2I0IWmopzYGfsuXw8RrrvPF/WMSF/wvFHxamx/0yNWyiwNZEpbKmyWAmDMhxtTP98rZaCrUFvYWHjOyHVwVZ9MvFy77p8lsBhMZwb9ySBC1fjpaclm5pWpIny74uN4vJvmFWEDYrEGO6HqjOgjLTLvYnw8RZY6ubSlAtA7pKD5veJlJg6GLE20pi43J8aiPFljG0HnR7xTZvZJufGIUWu0zWz4OqCMEVSwe4yhARLx+BgNThEKFFgMuo8H2ADuw7+aiU3v4RynhEzpIfivvKi7y/YDVd5p44hbFNs2h7dC5FlyADd+cSLomSB0R5HIws8LfBJP+JF0QoqytWIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zouJWUCrIZIZfmzocpw3SlYQIUu2KbH3Av9nOAnhDO4=;
 b=OoE4f7wKN/eFnsIRQpk38CZPk88Myv0vOYuX0iN34yqHO11DwWyHDvM2kMO+PYETlYlrg0QcCzV7edOt/KcLb27VPqGFWaMnLJ4wVcCFuPJgyDwutI26C51YbqSi/KXTTUMzNun1/NiCsY1KTmoRlkHaTUsne/oGpHUOfH0+uEjo04UvZp2iG3onskm82+0ouVWjGpYx8+CM1afoEM7mb3DaX5e/jDoJQm13iRjf6Ak2JIcdX7MgbLbmjJ1Tep/WrL/yfmQVUdIPY5b2Sw+PYBcI9N+Hj7oVJcv6rAt8pJUHGfzP7yyA/S9UV/1xFsfkY8nSi1rCYJ6hoy6gU7se9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zouJWUCrIZIZfmzocpw3SlYQIUu2KbH3Av9nOAnhDO4=;
 b=PdTcEb/Jfjf8hPOEW32ju9aUaY1PDGNIUs3awdYr+ojlqHXHM6wGIzvnwgi3TAQWbCauO9RU1hiyJn/PvaJvY62v0oDGL424s7jd/81hUU13OHrNHMdq9mweNpXmd5SrqxqqZk+E1GlIOTUAkxx21Ndbof7uGFr8v1iFAVG03uE=
Received: from MWHPR21CA0057.namprd21.prod.outlook.com (2603:10b6:300:db::19)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 09:07:19 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::91) by MWHPR21CA0057.outlook.office365.com
 (2603:10b6:300:db::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Thu, 17 Feb 2022 09:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 09:07:18 +0000
Received: from currycode.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 03:07:16 -0600
From: Chen Gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: do not enable asic reset for raven2
Date: Thu, 17 Feb 2022 17:07:02 +0800
Message-ID: <20220217090702.1573034-1-curry.gong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62d644b1-ed89-4a78-57f6-08d9f1f4e668
X-MS-TrafficTypeDiagnostic: PH7PR12MB5928:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59288307DEAFEFAF3338BA819D369@PH7PR12MB5928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDp8DEwrGONpjSJYQlcXFbT/Y7J1OWvzT33G8mX47mnzV+lqrQPZZmaSdMcVUWyTC5LTIj//FNM73Muj/IBlqiGWLNbj2JuhZ1gLlFrsUvVoZuF3J8Oh4KnyB5XiTrlopVG1sf1ln3mwn0R/3fO/cE35ul81Eb4FGrmiZAhQ+5hmh9tujtQOyZnKmcWoOramqvz/Qrx6GKur0yHyX1bczTAo7RY4XanHMJovw/oWAT6HXWz6JHKa7tIawn5l9R7EvPD+j5U94gvzk/z8F/sJIgct2GlSp5HHUQj1owlIy7gs4LJwPO5AXgsuvtlQGk97j79HIA3FfLAukpCOOy+pRndEs3hxPhZiZQ9/RqrFSnWPKdYf++3UoS9SZDLLiOPml9/HJD8ghVBcSa6ybjiS+kKiF1gzglV910/kg+68agVySBd0g378hdMIaMirfsAYtauqICynbUi9mCIGRemCv182QeHRAHffEyWbF/mWuTcIQhRklZqZv4CTsZJXVJ12+0/3HSYUMZ9rcHQMdrByYzh4PnJx/Y3LgYw2uyeSxfjdp7lwwO+oaxU0+ppU10UOes2TMeZytjsDgdOMuPxbYnHIdkJttLPlsHAGDUUE/eg627Yg/ITHk2AXLwJwlnhxzDDzEsIce52z5nlSfAPRO3Bl6vkV7Birzx9ShfIQ/JpsRKz3QqQsUTs2VO7551MAJG1lEvma4L9PNHB8btVTfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(2906002)(16526019)(186003)(26005)(8936002)(70586007)(40460700003)(8676002)(4326008)(81166007)(70206006)(356005)(5660300002)(316002)(508600001)(426003)(54906003)(336012)(6916009)(7696005)(47076005)(36860700001)(6666004)(82310400004)(83380400001)(86362001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 09:07:18.7673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d644b1-ed89-4a78-57f6-08d9f1f4e668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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
Cc: Alexander.Deucher@amd.com, Chen Gong <curry.gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The GPU reset function of raven2 is not maintained or tested, so it should be
very unstable.

Now the amdgpu_asic_reset function is added to amdgpu_pmops_suspend, which
causes the S3 test of raven2 to fail, so the asic_reset of raven2 is ignored
here.

Signed-off-by: Chen Gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 25e1ee2bd2f7..4c6775ff7619 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -586,8 +586,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
 	/* original raven doesn't have full asic reset */
-	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
-	    !(adev->apu_flags & AMD_APU_IS_RAVEN2))
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+	    (adev->apu_flags & AMD_APU_IS_RAVEN2))
 		return 0;
 
 	switch (soc15_asic_reset_method(adev)) {
-- 
2.25.1

