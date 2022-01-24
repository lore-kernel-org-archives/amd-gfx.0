Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CEBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 06:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11DD10E6D7;
	Mon, 24 Jan 2022 06:45:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBF710E6D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 06:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us2NrX9hr/zk+cB+kpBMEnaka8SFx9PFoh6Z8D+whxJfyw8O/rxowmdA4+IlItUkjd9OAscgxr0eOTu0Lv81f5bFqqYH8TUCQQikya5IbHm1zF5mUINX+qHqLpeTeS22B8bZzjnWd1m5n3Yv2GrpYV7JJCVV93io0OspqhTaE5I61MW3HO4ocIyl5SPNOmfBy66lJp4IBCBmFOBBfVP8aSZsXQWP4IwqqvEDEaw4hjCa2cbhf7azk8Nmc6b8KF/C0WNFX/h1WjWJp9iBiOkJLYDECGXBD/O5IWF/xf2HK/En3Yf6Z8vHkQtKJ2BKAP4xEZZGt8PMsoQ0akMU4X+5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azvZxrQH2uEyc7CHtAT5S6Errqjfh+u5GuKQu/2GsMA=;
 b=M+Glg3yvauMElqUdBNUBT2XfMgNYgQZmEPJFMuV14gfjGlwFpPSI8hSEIemFZXbOzTjHzl/E5Sff6o/l6AWUk0/ivZo3l5KYVf1B++g4lov2rQIfB6+j8ndx8cpnGfjld3GGnnNp0qxQFS2z1mn8m9R6l7tfjJkib32rmJnHjeONcBwi8rnHn2iFqCmKB2hxY54LN1m4qTzcjEXRoPVfpAe2mNBuJttbtZQVrwEDoIkFJoakk5yoOuBajIiXhGiJsRFenBgayd/XzCCAU71QCD85EWsdCZdQ1P4v2AZ/YARMWPjWnsOHr3PjNlxHm7TJpFc+mPywvqE+YbnC8nKiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azvZxrQH2uEyc7CHtAT5S6Errqjfh+u5GuKQu/2GsMA=;
 b=twj6PPYfcYuUIoAGbmCKWo3zoJvIYxFtgRLe3cIAxHwVbkPLqRVJFblDz8+UUDUGalt/4mFFbu6PJ3Y8C1/ETnVoDHtS1gtUST85hcyieI0HdhDYI/M08oSmbCKiQloeF0e6wcK9gjOf65ptABM0QDpGOLB9KvUITQFPMAo7eVg=
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 06:45:46 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::e2) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 06:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 06:45:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 00:45:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 22:45:45 -0800
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 24 Jan 2022 00:45:44 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add determine passthrough under arm64
Date: Mon, 24 Jan 2022 14:45:25 +0800
Message-ID: <20220124064525.1357499-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c87e61-88f8-4cb4-6434-08d9df052647
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682ED1525868C54D5DAD005FA5E9@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmCNwa4GwW6YrlHmdYnyn+D2fpO2M18eRG9cf2c7NvYAWwr9b9FRyOLup8inxc4mc72SfkR/uxRHThZdOYdYV3aGrNp7l10IpeDsG+Z6WNskSCqq31DstTuSiNlnuwtCSpaaiEFX4WUQGumoDmT+5DcPZy4HCzxQIum7DSNftxUfLXWGUcmBWW5aUVyW/mYNc3ecXFRShXEuOahd+Y6gFMp1rzxSKgCVZmgBHlIRneypQf4Cktj0EU/nSEYI46UkkelTZ50twD8TCnqSNfF1+LvsNO4C6OyJ+CgUd34zhsBk6rcYTi1V/dXQO4GULHuYTt9d2bQZvS/UMDfk1MBkuocdO4I5qjagZ9o7M+Rg0DEIiFYU5rxRbXmQvWuyRr77e60BBQmEafDiK7GO90BFtpbY69cSHGo4X+uEQ7Q/Gx9yUDPdYmV3OXI327LfntWW/tnAlGpt3IuUZBC9ubC6gP82ueP2T1CA8XcnYDfmZOshnm21tM8bxObUYZIgIVw0vcoetAquWVDt115IhURxB1XDvVyu9W9UJXolLR7egcW+e1+A4OCMpwl35qTo4IhKf+te5pXx0STQImZgH0hL9gdjkDBqykhfh7PIndgPN5mJEC48TH8l9tk8IWA7T7zQzqlA2OOyOYp1H6q/bWDv+69yJLWaX3zq7ovP7bMf5Q/OyDBHFvWo7DeqNtWVGbS3R5BaNWvegIw3yV+J1nimRWnqI5IQfnvipHabUJWDshQxtawQo2ERmwuR34pnbd+QR3EyPFsPdnFkkfGNj95pKWfuHJuoDh6lBgSic8vRHug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(26005)(47076005)(316002)(82310400004)(1076003)(6916009)(81166007)(4326008)(36756003)(40460700003)(7696005)(8676002)(54906003)(8936002)(36860700001)(2906002)(6666004)(70206006)(336012)(5660300002)(4744005)(426003)(186003)(508600001)(70586007)(356005)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 06:45:45.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c87e61-88f8-4cb4-6434-08d9df052647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add determine for passthrough mode under arm64 by reading
CurrentEL register

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index c5edd84c1c12..40803aab136f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -296,6 +296,8 @@ static inline bool is_virtual_machine(void)
 {
 #ifdef CONFIG_X86
 	return boot_cpu_has(X86_FEATURE_HYPERVISOR);
+#elif CONFIG_ARM64
+	return !is_kernel_in_hyp_mode();
 #else
 	return false;
 #endif
-- 
2.25.1

