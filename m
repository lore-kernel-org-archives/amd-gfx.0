Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D9C46CD4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 10:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD26A10E238;
	Wed, 27 Dec 2023 10:04:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E16110E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 10:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI0Civ9GhAZxNvsoPchNrmaf/KX3cGjD2tKkIGC/5Q55HuObeTSkwsEaCp7X4zsqdHKIy3IRSHdUqhzc0IM3DDNZk5INtW4hZusA8iJRT4KyGQlANubNnT5afeSnHSnaAt/V/ruBBSzlKBfe7xo3QgHgJ9KBU6+vYFeWwtWr7Ti2W/HQp4sqT4dOxxMN0mcac6/BZwMTNaiZM5Ftjg+7Y06jCkfZLyJDKQ4O2cR7OS6dArriQG2qkHW8+hcbCtSefwei2HXbBajJLXgSWAo2Mxopk6SgyL85gvJNsYgxTYWMFm+YqeAru6zmpE8GzyDl2RUIN9fYpoUGpz1+wP18fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QJ5jGls7VSudl1yj5sP9YZ65V8ZA1kK0Io8bPI/Yy0=;
 b=fRIx3ajmNU4AkXFS72iI6ZXs7dGs77t2DsF2xH8xP+wH9L1K1aAIPqG5aQy2Ghxm+SOySXgbYzwhAoEVCUJOq5egcfCRW5l/9x+G7x7k2g4Mlh19gU2fdSTzW4s/n2DDGXdI28MSOPoS83ieCINUMCmj4foyzraXs2znKBGrUWJ+Hz06VEu1XH/EGWl+w9bkVEUgkf2QbI7kN7NGhAxq/9wWjv2PwVQ53gb9Z3PbYYCL6twPGe1ICMSCYjQELpGndvSyO9Zfsd6PEpsRDByyWTQcBXhH9A/hWiROC1pgas1CwAzqUBN2wUVE7/d2oCfVqT3wA0umdDN0MsCNIzuliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QJ5jGls7VSudl1yj5sP9YZ65V8ZA1kK0Io8bPI/Yy0=;
 b=jrt4EGPj5WJNhv2eBiiucWfwTlt+QNhezyXa8T7dEk6qL5Jpg3wUEKQ78QK5yyWKJ/9SLyDJo3RQiwqf/Shbwbd5j+odNuIceYTMOBUurx1P0g+P26zdWEd/Is8EjMc89UrpiT9vNr1ftu+KRAoVGOa4FbDMUgXQLN6txoTzBfc=
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 10:04:38 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::af) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Wed, 27 Dec 2023 10:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 10:04:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 27 Dec 2023 04:04:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: Remove unreachable code in amdgpu/atom.c
Date: Wed, 27 Dec 2023 15:34:17 +0530
Message-ID: <20231227100417.3504719-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5b488a-c3fe-4322-240c-08dc06c33c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQjfsqF2ZxnAUijm6LOueI/cSRi42nKh1AEqm5P4YZ5wQL3PBr2dKLla+7qMftaTLg8WX6YEw68pyC5WFB8iIdnZD1Ibnld5UA0DovAb/LA8madFczhJNqI+pN1qm7UxhBZr1kRCUF7zMIbMZbKUQWha/4HtJpuDmmQe38guDVWrrJ2m1TbJJd/FMpIfLNFbtE70VqMSostR4HVq1i5LJq/SilKljnT5fiGDJAR7jjp9InZfT4uohiiny6lVfhzV6QiYPeviOQwskNn662TBg70Y0CjPe2esgtWUeBnbdrMYCvEsliVlOFrB2pZ/T8ugS6H/zY7JN5v8XajYZ08Xig8A4ogfCnAFeFaCNW8ckGwEmWWMa9drUL5sUv2Bs1VYdTATXN8TgYF0VGodnju997sYFlNz9Hjd6lE1OA3hosvvq3br3DDMr+22Br7XFTvt8e+0tRFrOXVKsYcraMu39MC5AY7oacEcfj5cVGepLStHkiCSEOeXUHlQYM8drOPPvPYe4lNGaEfRL6v1NAoza4y2H6JaulSEoyWKXtYdQ6qcxNMP5Foco4K9yPgS3AYpmdS9X5q0MkCwuwJRlyJlPhewU0VLXBoFaQOmSbGbCoOAv4sIap3qiaYOIsoiGMgoPuDD7+Z/4Eqo+yZ4uV6NHUO07Bp228ZmRncyQcoxwFD6tx3aPrCj9YKM+VMwvH3WHryiHIdv2CProBpwwyrKw+fLnAtk/PiZBxg+VdrZ0DRkbmHPTOJPMj1N21jvTx2n4sShXbiGJAQ70xQujpLqOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(40460700003)(6666004)(6636002)(70586007)(70206006)(86362001)(7696005)(356005)(81166007)(82740400003)(26005)(1076003)(41300700001)(47076005)(83380400001)(2616005)(5660300002)(2906002)(8936002)(16526019)(8676002)(426003)(478600001)(44832011)(316002)(36860700001)(4326008)(54906003)(110136005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 10:04:38.0768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5b488a-c3fe-4322-240c-08dc06c33c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:316 atom_get_src_int() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring unreachable code.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  Removed below redundant code from v1 
+		val = 0;
+		break;
 

 drivers/gpu/drm/amd/amdgpu/atom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c221000782c..10ec7d75ce7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -313,7 +313,6 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
@@ -395,7 +394,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, uint8_t attr, int *ptr)
 			(*ptr)++;
 			return;
 		}
-		return;
 	}
 }
 
-- 
2.34.1

