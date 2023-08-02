Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DAFEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 01:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C64910E47B;
	Wed,  2 Aug 2023 01:39:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA53910E47B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 01:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzOU1p4vnYP/+2oOTrbtvsaXrBTKOgetdw9i8vg94NTlX2m4wGUfbl2h2ggnLjTd44DFIRCzMU3Bkj09jpYg6XCcThQzKkM+CV3RJ3A3N7S8jjrA9qVZzXQ5jKN3NoeTLJMY1ALbvhLXHYB+uKB6B8pCb6YCFe+n+VH3l7MJqBl2vaHs5zY9/VDoXbfrInVAOeBoURwqTD58UzKTZRTJWSq50wcR1k5HH9U0A22ZmiuU3l6UzNJ9IrtABNbXBObJ7q+ZXnxTqZsaE9byMn/s7USQrKs8iHmWQNorCY6ed8RZZmGHjC0H+CLIHD+qEnhyyEHnUWI1wNjTnwSeILYU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5mfDrB+ieCPrBlbloTVTnOwZnNtR6tXSfRJe1QgIvE=;
 b=k0a5PwhGyvW1vsNWM7Hs97xgNpuBLc1BlSIj487jQ4FC8ZMOuxg/1IZSgTJMrzaUUSJUIDuPyGET8FHqcR5CmngJW92kJAgXExxq+K2PiIamMSqexcP7YWaefH385Eb3tI5sc45RJ1dptjYQDADwcyCg91oT1tpuYCH/QpDluRYPTFhk7ci1LzOwca7D1gqAkwvKCfEAyNdPUiVRM7ZJhTJ2bJ1xClkMBhIIeKms2d6wVmtfC4XPlh/byWE1OCC14RYN6kiyq1eQVM7qDhp6P5/L8xjeY6bCMo/ezpm4g30q5kuyDfWHA9kJUkJdMOcnQ/w/ghd+Nri/O44sVtlqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5mfDrB+ieCPrBlbloTVTnOwZnNtR6tXSfRJe1QgIvE=;
 b=tD6ZWDBNrPwzdC9NJtJnHg0mLIwee1i0YLOc0c0ao3A5SuqfZiLAKKQa2HNJiidromL2sTCUfuMdZtpjMSBsIV0P8gsW39b4tmZH3ZgF1Ehk1Q8b8rKr+H7j0n5D+/dT/denqPU65obIwFPpSC5DRaCnegeVO48QNmi/7j37I1M=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 01:39:42 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::24) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 01:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 01:39:41 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 20:39:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] =?UTF-8?q?drm/amdgpu:=20Fix=20unused=20variable=20?=
 =?UTF-8?q?=E2=80=98i=E2=80=99=20in=20'gfxhub=5Fv1=5F2=5Fxcc=5Fgart=5Fenab?=
 =?UTF-8?q?le'?=
Date: Wed, 2 Aug 2023 07:09:26 +0530
Message-ID: <20230802013926.3091620-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ebcfac-b88f-4bf8-3db0-08db92f957cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PYpGFsh+rAlAg64BQ5e6tui0l98cThGai5rDQCti2hTlV8kbbH9gUurJrKfE4+cvxhPzHGpf67cPNUHoF/xL7HyQoMavK6G0IJ9/Or8xnHEg8XTRDLNN/HhKOT8OEPRCoOOLv9sKPN4XWwPxzRXsh2SwpELxLLD1Xa66XRbde9ZeMjhOjZYLj2/37uSNIDquNBObx6jJuf0B1guKnyDF6vxylJ4aPmQ98j+2uaboFDzG6nEyYW7QcJQvhJkvjir/3RjikM+HA22pub6aOG2oZTrVhyM8eUbuJOTClLwxLICNOStFcy+uIbnR/cdCL25TMuh2j/Iq2LYGmcweU9Ojzh/Uxc+2NufqpsF1WvoPeq+G6Kc0gqUpGyYnPhEkPneujwfMJecOGwM8+R0I3FPIGqu0tgyg6yXB2Uft//7mlRF8+daRTb8MeDNniBcJrGBsFVmPV63nU7EPl0s5POHCe2blTwLimyO5ivXyBxCiXHtcF4riQmC260tUK39G3IatlWTCjvMy+ddcFjHJT8jkaOCzZ57kktn+SekCclNVlPHow7CrzSUaoAK87sODKpmUyjvHusUm/QhWjYjb+w+0dX+KI9vANgUGXzGSOu13O6odqdERtsse3eYvXUxf9H+E3oFoHtZHUYRlwyaPSSxvKCp5VVmmBPS2huqwK/UKrz6aRytO5eizzw/Nb37Og7M5wEpaGpd1QLIsakxwJ7PL1wPBv2mujC8PO/+09OAsjOAlBIcnP2sIFO+nUznhc2oBC8fQaWAhQ9BQOlrCy2IqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36756003)(478600001)(40480700001)(86362001)(6666004)(7696005)(8936002)(41300700001)(316002)(5660300002)(6636002)(44832011)(4326008)(40460700003)(47076005)(36860700001)(83380400001)(54906003)(110136005)(2906002)(70586007)(70206006)(66574015)(426003)(26005)(1076003)(2616005)(81166007)(82740400003)(356005)(186003)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 01:39:41.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ebcfac-b88f-4bf8-3db0-08db92f957cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c: In function ‘gfxhub_v1_2_xcc_gart_enable’:
drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:405:6: warning: unused variable ‘i’ [-Wunused-variable]
  405 |  int i;
      |

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index db7ad3af7439..0834af771549 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -402,8 +402,6 @@ static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
 static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
 				       uint32_t xcc_mask)
 {
-	int i;
-
 	/* GART Enable. */
 	gfxhub_v1_2_xcc_init_gart_aperture_regs(adev, xcc_mask);
 	gfxhub_v1_2_xcc_init_system_aperture_regs(adev, xcc_mask);
-- 
2.25.1

