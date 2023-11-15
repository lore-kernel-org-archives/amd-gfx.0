Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DCC07548
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 05:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A56D10E23A;
	Wed, 15 Nov 2023 05:18:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D716610E23A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 05:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+b1NMNHZjGjTKzxcWQihwG4VijyvIo2RYF0qab25L0FlfsDpA4QT4Wto2W+SPgKC6qfCSewwVmM+2l8maWcZ+H/uB4S1cFH9tjRaicbrMI+TaU2Ew2PIIomzYREKBvsjvO262JW7nqyB7I3vCz+dplv9MNjQpnUuP/SEw2hBTvo1kQgtDT6IA6C2Aqu1RiLV1Pc8K6Rr+pBHv2KfcAYb04/W8iHCB/KixmKRTLOA6V3WrxTEgS2tZJ2ajIjo3iYM68Oja6aapxBOvim9UFK2S2+EfJ4Wfq256P+No5uK+qkhBbO1GIevikMsjAsGtYjVN4AfrZCAAvkvZ65EzgVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDf5QPbgJ1GUt+nsNn7tHdMVhOZW5euKABhwZWhGQeE=;
 b=cSkzIiM/uIEyBWpXgN4qytGNAE5AAH5NZ2eDRwqex8DijAAVL/+j29Ybk3Gi6kHoPtNNDeSzi8q/q5xARo58Tn9bu2gH016SK2RES/WeP7MgXKS1E4mCAMUBJcuaVtYIxzEXx3LQGXWClYg6kybi3xSQxHxODsOVmnCB03SEfkXNQdI1vU6nK1yJ7rzjaBYJGfQ0mPgkMXFVLfymuYeA1jfWqr83DTutWAX9dWIUppQpguX+nom8vY/hHPzs6nbyHkMYMzBYJA/XMYwzV9tuRS2QxSuozynV0aiHpNo7kx422Pg8bchtGrfnrEP2qwmHh3/dhdFZuPEYhyw85Q3t8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDf5QPbgJ1GUt+nsNn7tHdMVhOZW5euKABhwZWhGQeE=;
 b=dX25kTo0uh6evX3ZtuM9rs/lBiWoErXQ7I/7gChHdO16aUxKGawivGvPUN1kOWm7HxQSAClXhumIkPqTAZnTCDUJkRlQgI+HB8H78qWzAWSn5gYZWy7vdw9QISaERejVi6gIYCR3vr528OciVNjtwfB+JsJs3sALQlSzQtbWdf8=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 05:18:31 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::4a) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 05:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 05:18:31 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 23:18:27 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix the error of dpm_enabled flag
Date: Wed, 15 Nov 2023 13:18:08 +0800
Message-ID: <20231115051808.357777-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1725074c-98db-4a54-e90b-08dbe59a4ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otJGO/qJBAvOWzd84t9Wwe4z8xMRAwMlDNQ7uvGpzUTZPFB1G28Z3/eu+it5cKXupjlNbkzip5uFnl8gONFsmurcki/WLrG4QDa7govBulocX0kPwxBdsMty2NXH9TTGk9N1WfX4AekO+dP72/Ex9Ey/Jayq3Rsb3ihatp7NXfu1WlJh8t1AhWOFrAO8p0L/859i7b41l2Q8zxS3injL4GWhng1iiBCjHdg94sNGL4qlR6cifZS0QYOkXeIQtUhG7oXFP5SWL2Dt4m8c0icD6QK3ESQKeTU4WQy6pOcMhBLVxkK97Un0VzbM78bkewlzhq1b1QIrC6jHUigLVg/MuPzHN372bEUR7zJxk7N6EjTJT7jCK9TiVFgJtr4abx2hZ7NarwAq6FMq8BLj8dUb+rjx6sIm5T4lDPh//ISO8YLxsDM6NXd87W50TFBoJNfjZWT65ps12qVVezmcDwU81j9BjIE+5I+RQ0tGpqCptt4A6rCsHMLV+/hSmNPiy9LEte/SergK0VS+Bj4CqkjPMuLATTDtt4jAvs9K/bB3EdjU0iVcSo1spunMHaayj1jbjV5Mlnm1gHM5tBTMVJFqvo4boO4iNu/TnlFekbsRmcHtVVdHOhSfX7reh4UoTsbEZBokW0gED7+gn2kBceFzO/FVyecuLrZzps1GVRiI6soXH14CtChmKS25t7Ap3g73Gx68nNNiK5Rm7ThXTOyFRGOhotPZlZnPTKpRJjcGSi/8ARx6cuYJjJJpyb4KQaKrP+5xhe5jYCbok50ZfJOOTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(7696005)(110136005)(2616005)(426003)(336012)(47076005)(40480700001)(8676002)(4326008)(8936002)(1076003)(26005)(478600001)(16526019)(70586007)(6636002)(316002)(70206006)(6666004)(2906002)(4744005)(36860700001)(356005)(82740400003)(41300700001)(40460700003)(81166007)(86362001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 05:18:31.0615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725074c-98db-4a54-e90b-08dbe59a4ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set dpm_enabled flag to false only when dpms is
successfully disabled.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1b9896001172..4bb86315e8c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1740,6 +1740,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 		return ret;
 	}
 
+	adev->pm.dpm_enabled = false;
+
 	return 0;
 }
 
@@ -1762,8 +1764,6 @@ static int smu_hw_fini(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	adev->pm.dpm_enabled = false;
-
 	return smu_smc_hw_cleanup(smu);
 }
 
@@ -1808,8 +1808,6 @@ static int smu_suspend(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	adev->pm.dpm_enabled = false;
-
 	ret = smu_smc_hw_cleanup(smu);
 	if (ret)
 		return ret;
-- 
2.34.1

