Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA03BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E64110E1F7;
	Wed,  2 Nov 2022 16:59:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AD210E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBZ5gigg/qS6OWvdkfcKGqZIjx2wORoDjzdq015rRlh1DpzaW9eA3kEEamiaRWFFJqpegr9YR3OqJtn3NOQiJL2BZim01tv6JTaxLBhg2A4detGPrrqpYX3CRPKylVFgiq6oTU+4TCaWSOLMOTuIqMOVbfyxKOOEWsQ6UkjT8fc6oS5gzAKH8orQoyQ/0xvWcX1UdiXT+R/Fb+D2ba+0yGc+qwpy3D8daByGoSa5YAHSXzryZR81YdzYEEbVeTcUsWKREJfgjYBInPqD7N7jG3yWL77FwgS9wmepvK7OGoOyFUJm2Ncl/nz5xxJN6acYMyucOk45ANEOwzP7E89iDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wd6fFxOfAkgYU3Q2JdfSFR2j3B/UwwM7qmFT0m/wAA=;
 b=jzmwbVunovaj6zL7B+eZsXsuqejf5/+Vp9bKHOj2h6xfREgI4h2Lh2RRMI4qwYOSWDne5DsrUXMPhEJY4z+Ak/2JdWzgZuwMF8pEqN1sj+kg0rWnRHZNxbN8WLp3zP/taVGhBnDbJrbH0OO6DOwXZp46bl3ikp1P5uahkFh3gk/FyLF5zKPAZ4A3BR7L9wUOMfg5Ja9nUGf3cMC736pXR49FILv0BkORPMAi01qG4SV2j/eybzl2Ptx6mij/pg4y/vWbYjYkfWrhdc7M3L537IkOawyilzn59xJbpH/TiD8oFuJ2texIAk0inyX13N0pdZEgisn72550fghGO7TYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wd6fFxOfAkgYU3Q2JdfSFR2j3B/UwwM7qmFT0m/wAA=;
 b=FAwf2H0fLXhb4yEsXba8e5rn7NHi7fw5wDjFrXqj47sbk1IZsYACjfMfHxZG5IYNj/vdh6Rn8S310sS0k5939ABO1WqCefvxOBRnYm/Oo4wgPexetdMF7GVnHvuDBSlSwiVnZAyzNcKJrYCr0FWvc4/2oW4RopEqRw2KzaGuHM4=
Received: from MW2PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:302:1::30)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 16:59:29 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::32) by MW2PR2101CA0017.outlook.office365.com
 (2603:10b6:302:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5 via Frontend
 Transport; Wed, 2 Nov 2022 16:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:59:29 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:59:27 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: add Vangogh APU flag to IP discovery path
Date: Thu, 3 Nov 2022 00:59:12 +0800
Message-ID: <20221102165914.1995657-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f3767e-8c1a-448a-f439-08dabcf39b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m87YJQ/Js4KE5YSai6pfqQSmRvycLz/E6j4SW+S9QRaN0NjabDIvlKGa7Oo2F/cAgOzlnQSVSUbz044RiUInrh0xojxIBn23JSrbPMEdKvLAJOvSKU62GuM6c2i4rA1DeRUJARgyGRf7XqnCLdRLR7r5cyPg6WSymPD+7ryVDkp7HXbWDWLTCLDuo6kYZmnrGtMisTHmZ+ZVRdW64LtMcJWnlTxwITvtkLKfeGaFn5qI73J1IlQfA4RNJxbsm7re5tfGHdexld8bzOUuEK3L6AHdl/uF1IuFLRb3sIL5F7Rh7vrQgqJvRSb3RzvsFw5qZuZJ8KSiK0MP2rmGlApg0GR9Ywj5j6yg5szY8bYn8LjKljdUzKaL+dqiLUwTpyPujEcr1+sDlR/CmA/eYsCsJ+0unoc0mobCh9oF1EJn9vPgUFrnkYD/y12dBAOKDX2aQudxFIr6CG00RE8qC9Mfm/ztKS3wc7/jWoNIkWniE5K0wvOwst/lrUjXKHRcWouR8QTonie5Pvc4o4NAiMxEbFHRaZK4IDoPDfe2TFLJgt5kTyHX/2zttDF8cZoCJ75s3Xju+jN6AiYxjFI8Yi/hfAxkSfilpoEkziryUjiHP+9/dRlES2PM0mVssmvmBKOdDl9ETAr3JRinIqwMKH3zlaB8Jtwo2Ud+xuDdmAR9eBK1ypQlM0+Flz+IrI5pRrFPQw1mLVL12QFOHW9LrZPUs4VmBfYBFcljrgF7G6b0SL+q0NjnOf9uThfKgWRRPSUPMymELkh/s1oWTI2YMzeDb/a+FfCwvNkrEwG4AXgpR5+jhm9IuzFbSb9eVH2hAgrU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(81166007)(36756003)(86362001)(40480700001)(83380400001)(356005)(4744005)(478600001)(2906002)(6666004)(7696005)(8936002)(54906003)(316002)(4326008)(8676002)(70206006)(70586007)(6862004)(5660300002)(37006003)(6636002)(41300700001)(336012)(82310400005)(1076003)(2616005)(16526019)(36860700001)(186003)(26005)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:59:29.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f3767e-8c1a-448a-f439-08dabcf39b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the missing apu flag for Vangogh when using IP discovery code path
to initialize IPs

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 95d34590cad1..c1b1f223f3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2153,6 +2153,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 1):
 		adev->family = AMDGPU_FAMILY_VGH;
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		break;
 	case IP_VERSION(10, 3, 3):
 		adev->family = AMDGPU_FAMILY_YC;
-- 
2.34.1

