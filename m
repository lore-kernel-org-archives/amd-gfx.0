Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD21FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 13:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F9110E6A1;
	Tue,  1 Mar 2022 13:05:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0F910E9E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 13:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbzgUVnYhOVGyMD5i27jpDOQ/6f3BQQjAgHLjFns3c49MiLjGLAe+IQkSwVFNZ+Bhwkk7NQtLMkcn2CLd8Lgf1GRsGV2Go1SOiQDtMH+5qCznSGSrq2im79XEg3t4q/W8QupgtrFVSlPosOheB+CwXbyI12TYqwxPBSe9C1Vf65rCA+ilHcOjMsoB99ZJV0lofIcOiqiItpRai7ZmqdgnDw5RiuZr8ODKExvpWefSODLwlJQWa6S+CV5YXhcAsGmpHLIkfr9TPHbTRvgtfENa/XSqkqZG9xrWiB7q/M5ZHGSQug+KR/lXvNGs0e/6LURv11judbmTjhQsTDId8dWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeealwcpVWGDtVEGACtekJWD03uHqr+tTBOPL6wW/LY=;
 b=ewOf/7X9kkOl+pnvc8WJuPmRSpppftMI0pSVAT0sGiHZ47FOb0010smQu8moM7FUaU3KnQMc8+QfJQe25B5gcCfkVIaywAqKUWACB0fDHaYOGOUK9jT/GWd0iYIXk9iiQS/idjc9q6yepLzgEd6IaF5azWlwI7iJ5i3oURlfhSiIttlGZh84uY6O9pfqKKLItRQw2vDT54shdVuKpepXsUknB3vId9v3vOGQcbyD2/nNHahoTbpEJF7byFK7H13O5SivKhFNpnQikv2S/2ka1iPJ9SVGYQscdLjbT1dvxl5ZFPHPREO+W4ouV2U0CJp3os4cyXciPme/4je+49E5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeealwcpVWGDtVEGACtekJWD03uHqr+tTBOPL6wW/LY=;
 b=q/vIs4B69oVFnh4eMtGnQ2bBkBBoAjPB7LaIfdn2TlhQX/700y/N0Dtt6oQvgVFmAGksSDebx83jlXx8lFIw9U9blrDieJ8KMohHzfksuHAgtA2w9bLpdFl1iS57GbATXubakIzmqGxg2FS5EFnnvlPElNqtr6Up5qFGwH1IZ6w=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 13:05:52 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::5c) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 13:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 13:05:51 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 07:05:49 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add noretry=1 for gc 10.3.6
Date: Tue, 1 Mar 2022 21:05:05 +0800
Message-ID: <20220301130505.3723500-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301130505.3723500-1-yifan1.zhang@amd.com>
References: <20220301130505.3723500-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62f1f07-adc6-4f33-5470-08d9fb84369f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3166:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31662AB59B8B35B547F2867FC1029@MN2PR12MB3166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dwzm4nxOdRtXTFGqtuUUuYPU+b63ZSRwjAy58g6XFXdQwzgJ1aCSZJof8pDY0eRMbGK0fEk23+BypM+aG4dm9tMXX0d8FJgmIRlym4+23Bd0tPkgbTuzT1Fj4u4P7mu6Tlkd8kytjgJKdNakbDrzO9L4tuSGN9aYVdTAUBurSiDIXTEsabeqPUGpP9IkIPkux22jDsaDQa1BnD2qa6gCvSeDSJxyUWyHV3/J4+xCUaobF/e+GivFKXwIueasGviYEXo0zKi6Ld8k1V+OZFQZTPYUWy7uweM1L9uW8Nk9meMrsWj5LKWh80XUz1LC9tXtDVRgbOZXgBmNb+OM4NOKvb+eZ2W/rUqwm8tc24WAg5JJ6UvkmkLTe8Soxo6OFu978RGRT1rNV+ev90MFf3CJtNGvz7vZ7fD/zns6xOI9DkKxSvz+DMSvtQvEzdwHs44Vvc1zgsOrYSzLeO3eqBedkwAyqQhY3V1uOxkGP84lxevsz4LJt4PbPi/UA4Y++uTshkiq3W1Mn4lWp3xrwgREIhB8Ij6tW4Uz8QsUfMuikAj6+KtBV+Ztsmp7Iv/B9yVM54TCNfKrzzYv8sySkD13Db2ixtbW6NRqrrd0eNPdFfeQJivQ6xI1jt82U0GAjc48LuArxb0WoLAIUuzZ4LrIqm0WGl8akcvGC6S6TPdq8xLCT0qKCIdE8T4FktTe2I+N+52HzwpNxwjZQa+fWxE0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(26005)(6666004)(70586007)(7696005)(82310400004)(40460700003)(2906002)(54906003)(8676002)(70206006)(1076003)(186003)(16526019)(2616005)(8936002)(5660300002)(4744005)(81166007)(356005)(336012)(86362001)(426003)(47076005)(36860700001)(508600001)(36756003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 13:05:51.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f1f07-adc6-4f33-5470-08d9fb84369f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3166
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

By default, set noretry=1 for kfd exception test.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ab75e189bc0b..4bbd8501c6c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -595,6 +595,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 			gmc->noretry = amdgpu_noretry;
 		break;
 	}
+
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 6)) {
+		if (amdgpu_noretry == -1)
+			gmc->noretry = 1;
+		else
+			gmc->noretry = amdgpu_noretry;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
-- 
2.25.1

