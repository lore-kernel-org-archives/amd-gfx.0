Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3150C7EE43
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F7810E5DA;
	Thu, 24 Aug 2023 21:32:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D10B10E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCUoY6Gu17D2Pl4rtM9G/Uv8Kydcc9IYbVZHfCefzDKurPs2FPCAkFe3VLn4w6gQKkJCUs0cWNdmCKbHW+b4YD3N05R342VINw99llsypzr9I9SHLY8Pnm+o4bPImEuQqKf66v60z1Vxtd6Va38FOdlY65wQTtBTm97QaIvtfyZRrWcywnW5/8UO1/675A5lXjiH7lENYGbGJt3UW8DXfzhi+PNtVbABzc3FIEKcnPeZMMM52dC8bMXTMxorwai86zVIHftmwcMy46cWSM5udGNKUu+mdS1oLXV/POrlUVUxB0esghxdqpCopcgNnEr2pwXv32SCD39TCnmT92/nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVLvkcQYSmap+25/4FhaFmKuXLJJmZSoIRaKqkyNJ+M=;
 b=VTxPwoCj+B2Tc0dR9xpkz2IPHzzdbHB1n5Ay3EyYjfWJG8dqM4l93QQLo3bCiNEzGBGK8ecaxdFTBt9LJY5AmyMO88q9flHs6wmn5rmA4Fq7Vfqm8zcuTphDmMFOvQjg3C3+KmuO+jej7UTXimhr41l968GHdcu913J4PygxjpLP+3u/xvIoE5V6poGS+oI7Pi71vzn2hiUaTFjCV398y2KA9mhvKYlAVyXsBybsvEfF1hmDgtbSxt3SPAjvVc/uAzVX4VnuVxcq9lmrifHbYXZqXkAyJGBIuIa+Up/rjBMjhnVgBHoMa67hm2CXURZFeBOoaBbBYzB5ZOVVBTMtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVLvkcQYSmap+25/4FhaFmKuXLJJmZSoIRaKqkyNJ+M=;
 b=gpAwwitQdmaFVDHWwg0IFLtWbXLUDQLrfWfXq84y47aUMkv/iAimgS8XwiUZnN2oV0pH3q7p5OjdKtap55y3vPWiRwZpMonY3FssgpzQIZCvWjrnGXcrU1xRKvnEVJz09sipkvONcOBadU2WRsWmd3xGoFu1CTgZFMk0ADtDtfs=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:55 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::cd) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amdgpu: add user space CS support for VPE
Date: Thu, 24 Aug 2023 17:31:25 -0400
Message-ID: <20230824213127.2725850-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 6578da11-5f40-4c93-6fb4-08dba4e98a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfpEBj/2mJIuOTDgJSD+sGgHeSE7cEbjqOX8wWvZpLHpULYploul/Y0MBiOjjVEG/NNOg/Rguz/SjW8NUgg4T70HOczrMTHc9UUXLOuibAPsNbRjIlKI3JT6IDwVZktdmP2qOLZdF454klp9gBHtJG2cFgU/O7J1Hfdwyd/3alBGfx9dZZ4SwL6n7LfBELSrKSlx2G8R3sFajIPvjWwQmmpBzzDd0ucXAJgtMUA9/5FpgVyO2FLvjiYa1lkGucuuK8j2+eCpnxcWXuM607QCx8r+Ql5NaywXZfTS9VNvCTluiOaVCztTJYxZLLEy7TYU1JthFqPRqYfYdiEQr5aoKAvTXyhBQgce6+HNq+GPgsH3HNcaMq4XI/4TQZTDYEyPrz8IHhjLyzTHD79UNOYFLb5H3cudPeBHH9/SlOpQGWJ87xss/3RJLuol2dqCmQBP5CZSQKyz2WoHjDHMikn4kuEUgoA6lFhTU48Kbg0Jutj0fknNK+N/NdIW8+RJO8vEoc01Q8pHxNpaParXIR3tsZrbKqGGn265iTQrrET2w9smxNV5Bz7l2X8Grb/GOjoJr9uiRO5L0QV91xR8XJhrTwOSKGgSUXm4HJ4pJeXYfpFqD6I+vH1oxGJfmCCGTbfgfXFcG9/plbuo4vdyL6bIcu1E+g/Ki1dJ+ps+He4vvZNS256ybHXOMrxxsHIwLFWMpBpTPSEuggyNht4wMsTqUZRTKS705q8+GIjs9fLNtdV3bbkewiKZt0jjHBtxye2S8OhHa4BVzaT2RjGBfvNrtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:55.1900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6578da11-5f40-4c93-6fb4-08dba4e98a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Enable command submission to VPE from user space.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 410acdd4554c..c1648c8c5de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -42,6 +42,7 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_DEC]	=	1,
 	[AMDGPU_HW_IP_VCN_ENC]	=	1,
 	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
+	[AMDGPU_HW_IP_VPE]	=	1,
 };
 
 bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 5b253e3be56b..b3630ceaff4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -51,6 +51,7 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_DEC]	=	"dec",
 	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
 	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
+	[AMDGPU_HW_IP_VPE]	=	"vpe",
 };
 
 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 99f4df133ed3..21c4904d283f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -469,6 +469,13 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		ib_start_alignment = 16;
 		ib_size_alignment = 16;
 		break;
+	case AMDGPU_HW_IP_VPE:
+		type = AMD_IP_BLOCK_TYPE_VPE;
+		if (adev->vpe.ring.sched.ready)
+			++num_rings;
+		ib_start_alignment = 256;
+		ib_size_alignment = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.41.0

