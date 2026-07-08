Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159FEC44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 17:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A448210F1DA;
	Wed,  8 Jul 2026 17:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UdvCrtA4";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012054.outbound.protection.outlook.com
 [40.107.200.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554CD10F1DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 17:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfplpNRPL7EjfSP5xV1pTPQ8qd18jxr4WxSqkp0r2eqZeGMrK2lyoloN0ScDM9s8KYxgNWYHAjQId6bPS3IEUj6a0z8VQNI902/Iu9MI8BzBMB1mvX+pnlV20PvtUfKOQtk0kBZM95d9zEmYJMLjMINd511Q2lfJGv3kMrqWZEqhq74mbn4Zzl5vOOdSiqBRsMRNn/MpdXWTf0xFCdHeGYQtKPzdOmlqeBkbow4k0vVcvV4Op815oEht9QxQ7gSAf986PqDdMh7b9yo/klBMp1G72CF9jrBGsC+/Z3FgCaOcKPHId/dGkwSsKo4Z9rZp+U/ROFOxZue4ihLYUXznOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaJYWfC8xns2j123Coo92AY57wo7/CmdNiilfh+uIuw=;
 b=DK9sXrpfeR19OABQ/+XBp7GWQ1RxoP8T/QdUJeh9f2zKDcGbXbR0UFYtFRoiQp7xVyulIl3ewMkWsHjF0ijV5RP1jTTzg3kB7PwraIwCyWM0+dtrQAQb1NZjCUawZ2FuhoG14X86qJ+mhvvh/j+S/moTZJyQ/fUqqHzYEa10ynlvnQJtV1Na+93OIt332de2kBkyjnk6506fwyLUg6EkidV9M1qEj0ElXtPS/rNOESKowM7RbmCnBfq/vL5d8EUu0r7zP0PtAoRx6Q3QZsXYMPgEym0dPF+bB3ATJ38z6vLehK0RNkYFQmh+TW7ItZvM3PoMm92b0gikPP7VaQL5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaJYWfC8xns2j123Coo92AY57wo7/CmdNiilfh+uIuw=;
 b=UdvCrtA4cmsTSi3kOWnhcoV0RleAFoPzQjbpksfahKWeE/KbzSjPtywFhzsPlCPsMi0jjWkvwzk6ej3ZjqmuXbuwu8ILzyPxzj0dkTdLSkSKHEl5gQi/1c2PqEZTtZdg6ppqHwtNXNGu6iqLF40vWm6Fsy/HqD5+HluPjGG6dGQ=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 17:45:15 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::8f) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 8
 Jul 2026 17:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Wed, 8 Jul 2026 17:45:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 12:45:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 10:45:13 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 12:45:13 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 <Kanala.RamalingeswaraReddy@amd.com>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 <Praful.Swarnakar@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, "Matthew
 Stewart" <Matthew.Stewart2@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: Fix device family for DCN42
Date: Wed, 8 Jul 2026 13:45:01 -0400
Message-ID: <20260708174501.179428-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c80d50c-530f-404e-b302-08dedd18aa95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PWH1Fmz+fz2O2HRs45/4a9kAjWmbHvsvrOD+pYR02P+YVqniCNFImh5ef2zoX5LOFfheOuhWULqy96SVHWZTtn5o5WVu2QVsYRqawFPVY3Lt48XI+LJrK3xZR0gEQ/TDWvYT46fNHtOlV/PeeXdZyVNTYjxN2E2uWM8WgRy6gZ4VbEgCMfuiiuAPT+0PLvtns8gHI8DZFLcm5jTxyuY/EowxIsyeBX16Z3GpjoI+172yvMKW1U3hqRaEWKqX5lDx60QFHYMtyGl1ZFG1YG3LUMWG557gw6tIL7iUai2SXqa31eaPSnN15KxnidhiSn5hQmXqqK3wji2oi63b/woXYofBoEThu8NbmFG8GLp5jgnU8ZKrRtMzGLNouBUvSCundCC/CgW+F39yE6mzu+E4cPInwTBoLbxKr3wiifLjLydF2WoEJgwfMLRky+fAjtDgR3lg4GQPGTpUrOXzqEjsUpvRtDXemT88B16JpCGkjqn/XtMDSaKre4PIdALDy0jYib9HN9cA4sgDk0n+dnMqUvJOoijZ62fX26uj+pwn48EdA66i7pt0EC0hQTsvKQNbCxmWOrETyZPIYpnAesYBwyLVYZ/S2EiB59a1t6QGgaCDqu0kDGoyquhMCGEdUneVqnnGx5E/kbQpCOvNUZ0Pt5SwQCQmpadQRPA/2e5LvpF6xiFWHaUTneYBPnPYd51cVeNLPTo2UwVwtG6NMch+GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YkvkEvBx429gnU/Gq6Sg5b7OcNR5C+Hnl4rUhwDAuLCvI0QIGAqPEkE10heo60L4KsUS2bHC0w+ea0W6kY4SChVKafyi6+yg+iY8Fk4DwIxNmnevc8XThtKdbO5A7rOE2a+KBGxdqwpMcSAbOkANiShvWK6XAqiJYEEtowk4sVawKZC4P+eh3D/3CBnW50SYN3a5C3jNsQJroYoxQyO3cFrFdz90632yQPCmvxQOudMg5YYEXmTiWsoMFeCfZqD8CI10jEqd4RjPG/ob5IO24ZR/RbPCxzYEDdUM06E9O1xH1carOJMi9M1bf3+OZ0qrnM0PgpK5MBvpOTEw/wjUSV7JV/5EFKxpj1k/9bfqUsAvyZt5DqAViBkq++0yix10d+KEgk8eZc4WQ9GndibU/qE0BPQy6F+bUN5XnCxof3U2btTIlpF7u8EGhJl+HNho
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:45:14.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c80d50c-530f-404e-b302-08dedd18aa95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

GC 11.7.0 and 11.7.1 should map to AMDGPU_FAMILY_GC_11_5_4 for DCN42.

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f33278fcc0f4..f52566e05caa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3368,9 +3368,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+		adev->family = AMDGPU_FAMILY_GC_11_5_0;
+		break;
 	case IP_VERSION(11, 7, 0):
 	case IP_VERSION(11, 7, 1):
-		adev->family = AMDGPU_FAMILY_GC_11_5_0;
+		adev->family = AMDGPU_FAMILY_GC_11_5_4;
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-- 
2.34.1

