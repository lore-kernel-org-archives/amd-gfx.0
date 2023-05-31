Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A8CC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 09:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2965510E1C7;
	Wed, 31 May 2023 09:34:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4193E10E1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 09:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALp37SkqQMDTaHavtgHBigyPZ1aBeNpi9DGMs3r+iDLRBQJ8Rr03103v7LT3aSG3uPralt0zOTTFC6CQBYhuRCHXkcHzbVqrbjJ+Oe1f4apj6vmxwac7BKd9ilEZSrDJyUKNuIUCHvXwf21AShcI2d06p7PJmXPMOz4uwCwN0u3e9W9gQ1qaisFOElk4aA6klyr9nITtFmM4/J6XDlGLebWMaIeszEZEHMBKf5m92YcEQvcHic8qB6dnLpjW0zohdCS+JIzsHenWtbR8bWRSea12mzyBiMLJ4hhuwLgsMkNvU5zC9MVSR7g3Tj+KOfjzRnUKmL1TQ1oNwfBgbOlMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSybqvnKTSuS0bB0Sx2i5VanRam11f9AJJQYrGgEXAA=;
 b=mUoBb23u9q6SSItIZO7qqEy+8bz3jrRso5e07M68L6jRzZsqkc+eZWJUAy6HkjrpTpl3IHKWVSArpOgKJVM+qdb7zChmcAzLJjwHU9fUkXhnyNBDaExbfQRl2MzvDfQjvI6hCUrOTo/vooaidswzhJs3HymFDL/RCO/Z60sxyEj7gsT0I0YbZeHwNKMdRPi6AGZ+tvPfd7gaTVW5KQXEJOz4VoGcU5Vq5QC+U1ZVXFNlOuzBpbu4yQ0epWoVQIH2cJa/zOMEeDIC4v5eN/HDx2klwPku6Gr1Nv3e/RVI7/GWwNqF2KhW7e+lJ/kyD/6d3PuvGQx+yxM932RROD0ggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSybqvnKTSuS0bB0Sx2i5VanRam11f9AJJQYrGgEXAA=;
 b=HAql1B5XaBsfghA2sc6cKlQ+AlMaIviC7RoFRHJfNnqQO7dcVQjCu++0/zPOG2hp8cR6dAt5aDQVs+S05O9RWtKtxbzXLiifw56vePmzCwaCMAXLT9iSFstqF/JEHyaev8qbkRFOKhnoTgjkfkcJ2GaFlLxvko70ycl3M5Ksy88=
Received: from MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 09:34:09 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::86) by MW4PR04CA0117.outlook.office365.com
 (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 09:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 09:34:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 04:34:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 04:34:07 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 04:34:06 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Frank.Min@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Date: Wed, 31 May 2023 17:34:05 +0800
Message-ID: <20230531093405.519280-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: daf793de-daa3-4d27-e2b0-08db61ba2f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCuzVuVhu0cPuJPTm8DdHlyuKk31gATHeln82LmbC8Kyuk1/DzfF9YI/+NGzPxMQvLCsJXorDxvNH38XCub4RiW0s9hyI/4ya3Uh2W3YWlSnFhVXCc49HjEKH8wn3wlva0p3N9Nc6MPfSMO+KWhjFCihFD3kmxyu0kffpz7589AIo1fb8NnWdV0LalPSj/zS+Vm/CyHcAsXRQ+XrL0eB29JWpF52AdQdO/8QqGuJBqpPPb9wrmAwxX8aEYnPVql05ZkyhSMPb/iNJ8+tzcGKizsXuc8QJYmhNcgvHsob2Mw2ovuTj9wjEmGU2YTutWAu/04vXTDJbEQh/u1bMafsSIk3GfQoBZN9dSjHh/07UCYL0EPp2NzIo33R73fvY4H6spxXNBwvYlZQ4KEHEfwPmy9VcQ/EKurZZxtrMZmOchegFnBNoxnqFQ9iyZqrYtt39Zx0QPRQEik8hv2g9dgjOAJIWDn6p2zXlIbIX6IMcSmSkePNot3FgB09yHPLkSDiPoQIqbwY6Sq2BJdSd7qTvimw7fKMuvcPOp9KHoGugSQRMZhmDp13Lxg3OeIC0SgJUR9hVaOu9QTPU6YbY66yEZIPFXkPMdvnKnKZ+wjWK9Idx/G1jcFFTGnxoS1B/N1FMly3gMvLmdJCS0UtOkoUUS8koZ4XAYLkr9FmkIn+T0gPSqQnMAzmOKd8vJDEk4t+kIY5y3bXGfZRWW4ySGS+cOZKowBd9rzF2N8FY8qM98hTOff8vZ3PVcDcQ1JU0Pf79ToupiO1920FsOZaJoGFZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(81166007)(356005)(82740400003)(36860700001)(47076005)(2616005)(83380400001)(70586007)(70206006)(336012)(426003)(54906003)(110136005)(82310400005)(4326008)(86362001)(6636002)(478600001)(2906002)(316002)(186003)(7696005)(1076003)(26005)(8676002)(36756003)(41300700001)(44832011)(5660300002)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:34:08.7161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf793de-daa3-4d27-e2b0-08db61ba2f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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
Cc: Bob Zhou <bob.zhou@amd.com>, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

uvd ring in uvd_v7_0_sw_init only initializes ring in bare metal case,
so when executing amdgpu_uvd_resume to restore fence seq in SRIOV,
a null pointer dereference will occur. This patch correct this.

Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -ECANCELED")

BUG: kernel NULL pointer dereference, address: 0000000000000000
Oops: 0000 [#1] PREEMPT SMP PTI
RIP: 0010:amdgpu_fence_driver_set_error+0x3f/0xc0 [amdgpu]
Call Trace:
 <TASK>
 amdgpu_fence_driver_force_completion+0x18/0x50 [amdgpu]
 amdgpu_uvd_resume+0x1b2/0x380 [amdgpu]
 ? amdgpu_ring_init+0x73c/0x820 [amdgpu]
 uvd_v7_0_sw_init+0x358/0x450 [amdgpu]
 amdgpu_device_init.cold+0x198c/0x1fdf [amdgpu]
 ? pci_bus_read_config_byte+0x40/0x80
 ? pci_read_config_byte+0x27/0x50
 amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
 amdgpu_pci_probe+0x186/0x3c0 [amdgpu]

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b7441654e6fa..70e7e9585d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -506,7 +506,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
+			if (adev->uvd.inst[i].ring.fence_drv.irq_src)
+				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
 		}
 	}
 	return 0;
-- 
2.34.1

