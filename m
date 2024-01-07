Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03004C47074
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571110E0C8;
	Sun,  7 Jan 2024 15:40:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B10810E0C8
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e86x0rfS4vdsMQ6cjTq3obgg7mPLitlauU4iHh80xYFjUN0unBp/e7I8nzWUGDp1T5eXVJqYfDF9eYsOa40rMKg6ivdEy69n+zIfyYIHViDup2jiKj5q6NgHn1vQZ9ydJv2JlpS/4nHhJwEhIRybQ1gdF5sEiR6ayArDxFPkYJSJ3PxB8b8RA+WdfJyOoHObMSzoteN4q8pEhSUzq8Miy1QgJkBzHLyBemkHv7wlOOENbnZG79IHIMxpvU3x0oam43IitxoRBS9qbAUvu5tesqwJC3NlnsuvVmRSevvVkFl4epWy4Yu7f+FVXFY7AXQ1nL0IoVv/qqwwCV8q4ypCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=D4Myx9WyZPIUe2eB37OPwEgp1WSMrTfmzcNK6INim8GGamCSDBqMkknDlkNywF5JCf6SfTyp58FguYGjvnbL2cKpfnVsIPw42BMLPf8ynY1cyAUnGPkaO/rVF2IrCSTKEdEQFUcg8fiMGalCGnQdW6q55qTDBVx5vvDR4O8AdixAyTxrTOk/KA78VszuFMVpe2WnoOf5xZICStc3AyE6VJJGFsXPWnyZHQwV3D7fcX+xadFCniveDsfDfro0rMsLRfkUlYmOmZ0eHYv5R7luPTacd0Toz8W0+zoS4JX37sh1JT8k2IBz13ncK5csbzCWKJ6XdAKge09nj37Bif7mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=sfr8h1Iw7Y8OuaseMRlFDRfToHU7nsov8AiXglrs0a5LGg8SOjJi8uh7B4dz5yxANHwJclQVf2fhAQoWgInlwgVf59619VoHyBs7+y/qfcntdwNfTa+jNgx8n2NYh9bo/Z3uqWXvBq0fdGa/gsviVapvAT24zxBJufImnK+7ua0=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 15:40:42 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::f) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Sun, 7 Jan 2024 15:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Sun, 7 Jan 2024 15:40:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:41 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:40:39 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Date: Sun, 7 Jan 2024 23:40:05 +0800
Message-ID: <20240107154011.12927-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240107154011.12927-1-Hawking.Zhang@amd.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 753b8000-88d1-4927-dd69-08dc0f9701ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIRHbqAF+B3q0iPlprBRBsOMxAPUnMQ6Zzj3BnQbpJ1KcqlDiOEWttggQdk5uWZn/hsS7WFGWGuNBga28mZRXGzfp6s+XGxjQyS76LIN/AeNG1l6iFV6SttIS2gpbFAyF08BFmgF2SKoTpeeZsZYoaDVbpLxXtCxAb7HWuw1KQWDrAAqY9D4xEoOEVvzG5NazpN3/7TgeRfZ8rGr+6zWu5JRklmOINvSO6McCUwD48JlFlxPAUavl1iGB5R4F8yFN1+K+cjWH6x4ED+5pWYhJQgR9pPZlEhm8SzNman2Lde5tcF/6OQrLpIxCNBY1wX3AZkc1Nm0e713xHR5ynn4Fh1TGXPAQszjTDwF6ihweYT7lQMebtdi3e18SAn6HW02Em8S4yfy/7N+OxJwa2TfqqLNx1mCs44FL4RX43skyMETRbudqF4izrXFo8Nxs1nnG7HmSz7epLbgipzIoLg78Bo0NAGhvmhhDySVeKPBcfcfRMr5PGFETf5lK65BYfT9Divp3wyjYFOfljVVWj86Ui0zdgaKnAx5IusgFgWJCe2wrYtWFdjMXFmyDnSKYTIc9K7GH8KeAKcMJVSoOIbkSMd1mBZAuNeMWZ1ypIcBJVgoO6kIdkaOoj/jJisGveGFAMHmI+o+NwJnnxlqdAIOHykddfAAi7kSYf/KlBMQq2XEqzATaNVVFqti8eKWfnZKBtVsh+ppTpC1ATLPxW+LZw/r6BEkqiJT2yn6Y5pWUkiOiiCwjvlSdcQyqfouY8IGS7Aapt0yMFNpj9Q/MqumIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(41300700001)(2616005)(26005)(1076003)(336012)(426003)(7696005)(478600001)(6666004)(36756003)(86362001)(81166007)(82740400003)(356005)(47076005)(83380400001)(36860700001)(2906002)(40460700003)(8676002)(8936002)(70206006)(70586007)(40480700001)(316002)(54906003)(110136005)(6636002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:40:42.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753b8000-88d1-4927-dd69-08dc0f9701ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report boot status if discovery failed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..302b71e9f1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -27,6 +27,7 @@
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
+#include "amdgpu_ras.h"
 
 #include "soc15.h"
 #include "gfx_v9_0.h"
@@ -98,6 +99,7 @@
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
+#define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMP0_SMN_C2PMSG_33	0x16061
 #define mmMM_INDEX		0x0
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 out:
 	kfree(adev->mman.discovery_bin);
 	adev->mman.discovery_bin = NULL;
-
+	if ((amdgpu_discovery != 2) &&
+	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
+		amdgpu_ras_query_boot_status(adev, 4);
 	return r;
 }
 
-- 
2.17.1

