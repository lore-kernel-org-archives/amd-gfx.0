Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E627C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B050210E457;
	Thu, 23 Mar 2023 12:32:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B83910E457
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXcIi7fmq5ImldmPflQHkZjZhrmB9GvZo9ZhGGN6gzePq27caWnJEPvSSV3I8/1Cm94Y1BOAE80AbAPNiJoCT+pp6GWwvdxQ2TLRLUHvjsIvfkz9CSqHIfnMZW5HuK3KtqmDh4a2WstSsPyEBEXgCJ3/ukVoNejEzlMZc1hxQuQMjtpKTK/hcDQk3isZceTnz+Enyq5jLuqwHnwAWLGypI5Zs+r8WXkwlwz0HCaC8LG8kdIGCt8zfYEkvxjjSuWXZWrSYnTx2nv5vUOBGC3dQL00HvRvPgzgMDiLBG+zAlZFK813vOiwchmoFb1gR0TGBwX9c1ED14O7ksijHCGipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KlrYDKXV8rM0xF/ajZ23J/FRANryd3CwDzDMYyIoIs=;
 b=Wt73iuaEDilxxy7hG9ePBqb7dVa3I/t18biYlVuCy9PLF7VkUIG73rI+FnMScMAX6Py4mwMTbC4JmlwlX62y13qVaw7cBlaoJ4IFtA9YujWZL+xI8ZFiHvhsHb/8BCXM5+TRixOlgni3avnv9jBago8MvRcXyxE/DRiTYLJA5uqHAiUsq6FuersDwEIzedRzu0xjg8EJkMK84BlA4muiDeh/syt8GOKP24SAyAU23rOqc8lsgI7BQKKpDS1WAqtTPZmqupDYZta/a5rTx1EuhIHEuugJY32uWDjajqkS8zULfT5fTnwInABL7fw/kjH8PnyHRojNgL4n8eroz94fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KlrYDKXV8rM0xF/ajZ23J/FRANryd3CwDzDMYyIoIs=;
 b=iQ8iYZo7fk8lXXg1USNurCYUdxSyOr5snIThu1JWopfqYSMnrWgFkoxIH5I0gNetPXDYwLkDSLpgdmNUDw+4govCQDFkbvUnd6jgORwlk8d4m5VGwG4xOa3kNGvx03EBD0J2Cs+3RBuZSGBQhAntCYO1Na09RjTlHPEWxMe8Aqo=
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 12:32:42 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::c8) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Thu, 23 Mar 2023 12:32:42 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 07:32:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Candice Li <candice.li@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Date: Thu, 23 Mar 2023 18:02:24 +0530
Message-ID: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a195aa-98d4-4175-86d0-08db2b9ab281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIkDG7EE7d1ujGknBVRzVbEJEl/kcbiLnkGyV1a5OX0SXVL7Bh4rxczsScb8Nue/w1+e1IFWF8dAVdMnU1feBkMOF1duRY7EGKiprQ5Q40fv4Jt77Y6cM7VsIXQ1LR20PDKRmwCDZgoqa/6mQOnQarDC6pHpt3+IZZEIzmUkCcsQPB5O14EAbg3jnQLgBCzSC41B6VfFJb0hTBRS4Bebh2d3hlf6EgsRRMHAzElJpc6GGcr6p4yhRH1tjpkrqB8dbTYbmzIZHjNrkIASNUc8N83XlVKaW/0aVu8KeDpmB8SbzK6XXOBvcflDLESNKrzLW1bhfqhvagLgrcte46XHa8teZzhO2ofGwBN68OjbHI1Nr42CXjOCL7pc5P+SmQx1ikmJwePJR2M/cOFfpPmmlDp2vgkchUJoomuLQvVyR4FaDMJWr6q32Aorgqzgz3BpAOnbzrFYBSIEXBr/Nvn8diR8pFUhY/SuQJ7JawVyogSxf60Ek2X1T7WTnNORaztmjO/+YRd23cXo1IJJlCbamGgRcOzyLvQpFJqHtUSyITrjLS3yczqpLzJcHkW9/yMU7aojDF8QhSwHdTPk3ZbblUdExeV1um0/G0Jln+TwUX4cCBPVoFaRoiiUZOFodaZfNrU2ak664RK4MYgHAtlO3l1D3ztMl4fKHGKd8IBbDVojNmy8ERn2IBz1VPcv8GFw0Mit6/vUxV2CntXwyMVs036bYk6WZfDR4bK5AonZFU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70586007)(70206006)(8676002)(36860700001)(110136005)(316002)(54906003)(6636002)(44832011)(5660300002)(81166007)(82740400003)(41300700001)(8936002)(1076003)(26005)(426003)(47076005)(66574015)(6666004)(336012)(16526019)(186003)(83380400001)(478600001)(7696005)(82310400005)(86362001)(36756003)(40480700001)(356005)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:32:42.2379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a195aa-98d4-4175-86d0-08db2b9ab281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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

CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2567:28: error: bitwise or with non-zero value always evaluates to true [-Werror,-Wtautological-bitwise-compare]
              if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
                  ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~

Presumably the author intended to test if AMDGPU_RAS_BLOCK__DF
bit was set if ras is enabled, so that's what I'm changing the
code to. Hopefully to do the right thing.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Candice Li <candice.li@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b17790218811..fac45f98145d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			adev->nbio.ras = &nbio_v7_4_ras;
 		break;
 	case IP_VERSION(4, 3, 0):
-		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
+		if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
 			/* unlike other generation of nbio ras,
 			 * nbio v4_3 only support fatal error interrupt
 			 * to inform software that DF is freezed due to
-- 
2.25.1

