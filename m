Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E188EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 14:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CAA10EA37;
	Thu,  3 Mar 2022 14:09:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3D410E89C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 14:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0+9f4L2tOgiaKIvVXK5BxNuyvVQI1asTutIvqTurMJx6Orwk/pkRMzBpZ7yE5ru37VsxzXBLYahchwA3vTeb8tP4EpGTJzI9qkDCVuNtToK9dUmnDsYR00Z5nmEMbjGZcwJj7f5lcvx9czhbdK0rEK0OnEM8J8MA1sIJNkfOnFDb6Ai9khkEUlm5y3I6D2ysjefrR2T30fxGXwuYfUhbzadqszyjT1LGSXCCGzSWprsF9dtbvA8vnXOa1ukC49UNXGFhLkwb7Im4DxlCV67Om1v394B0SLOv64ltCuOuulHZciKUJzPxCaVUoCmOxVfKz2Xf0wXzf33G3iLpcmTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVKwhmewM4rl7+ia1ZRxM9BA1jJCD98NIjGgn7itRbM=;
 b=MUZx51DPUVDLMx3HeBqTrkN+080DSA5XyQR/yvnsplFse26NsEqpwzEgttdQqrLqlnXvoXNEe3zhYKAsWB0HbTtaMknSj6wPkXYS7YrYozgKDq9s3PHVviNjVQ8JX/AJu1er6CFr2J6u4mRPQuD4I3ljoBVMj3YDxfg87YNgyIRUHfXHB4Kkc/VGzxKCvyGc7mtfZdrPdrNQ8sGEriPSp0hp4P7+awxeCQFTTMnQIe0INTB9yOjJFnrYyMmQlCZJvud1EYrk0dOW38xRX4/Ea6P2pEgOSEpJj3KbrPh68G97uyvFq9cU2aFu1jhqNGnHQWoUUDEAyVp66jElmNb0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVKwhmewM4rl7+ia1ZRxM9BA1jJCD98NIjGgn7itRbM=;
 b=x+K+ANVcgjlWOjRV7Jg86MuoV/rTbk6kSyQkOiPp7J7ZTbC+c97l79zR3+yuwICJTF5zimpCdLYi67tZTgRPeUvn7hQovKWGRrW7ajBmdXN0NXJRSg1JIMwq/JNVx/h/tUwbVg+9rLJDPHj0MvjyHW9VlatyETf2ddsFpKq+hxs=
Received: from DM5PR21CA0026.namprd21.prod.outlook.com (2603:10b6:3:ed::12) by
 BN8PR12MB3394.namprd12.prod.outlook.com (2603:10b6:408:49::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.13; Thu, 3 Mar 2022 14:09:46 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::92) by DM5PR21CA0026.outlook.office365.com
 (2603:10b6:3:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1 via Frontend
 Transport; Thu, 3 Mar 2022 14:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 14:09:46 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Mar 2022 08:09:45 -0600
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Date: Thu, 3 Mar 2022 09:09:41 -0500
Message-ID: <20220303140941.27787-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba961cf-165f-4f4b-638a-08d9fd1f78c0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3394:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3394970C4CA6E3557C4A183D81049@BN8PR12MB3394.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zRjk1GICdF5CxDIGwR4BldQGYR+/+3agT329HfYUaNYUPFiunY9qnoo/56H9KMnuTd7PExJC/S6Ybf5uSLx6sH1kAETTC6PIwn4E/TaoOpbfCiWbpArejoNAD1s168pVFJcMl7I9wnDnjipRjTzzJ95CQ1LfUdfXSOsjL+GkT5HIuprz6+IXgzxI5znVz/2gX0/mU57eZOqjalyLp8Gfp5tkjvJh1w6Fg4Tejj1QO5B19g/AZYF+64oh/Z7bG/7N6eYd5JU37UkIcNoYTj7FagNVySIpGn+ARq10+aSesgFFW/LDNfJn7jmWrxIZ5STA1Vi39V7FcHbSyr+tOEr6gjPuu2dNcgX3iB1kiI/GGlA7EYEx3+0XNx+EG0ZkZNALeTW64IH3GVQsc2yQ+foVbsEfU2e7e+i8WxP3nAtfR6yz8xfEJKllKYBAnGJtcKjUFFkaODdmmZdZk6Ij2RxRELo3fNHBx85U+x+FAfdWuiwAU6fRHBiXooCEkd8Hl3MDhC6EFOr1STyV9d8fM2kmys4QCnJhSuU8bAI46q2C7SfRVUyy/7ZnE0sjJlra2nYc2PfkuymF3r7umnA9S/vA/5HMg6H/Rs2+lDJ7S/DGHRMPGWpd7/srGG7cAHWFqjcHHGVu7Q4yNh50h8bgqjBriumNfPk0hldC77v8M2Y+ULvH39EI8DODh4w/RaVdHJ52unGTj/gYYso7TIKgRpwog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(47076005)(5660300002)(40460700003)(70586007)(70206006)(336012)(426003)(16526019)(81166007)(36756003)(356005)(2616005)(83380400001)(1076003)(508600001)(8936002)(186003)(26005)(82310400004)(8676002)(6666004)(2906002)(6916009)(36860700001)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:09:46.0386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba961cf-165f-4f4b-638a-08d9fd1f78c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3394
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DFC CAP support for aldebaran

Changed incorrect call to psp_init_ta_microcode in psp_init_sriov_microcode to psp_init_cap_microcode which caused it to fail even with correct CAP firmware.

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_ta_microcode(psp, "aldebaran");
+		ret = psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-- 
2.25.1

