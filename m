Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BF6C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AA810EE0D;
	Tue,  7 Jul 2026 15:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVlPVlOK";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED86E10EE24
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkDbxBq88yyynQkAfTJQtCeNLKo2xEaugb814klXXKytSOUqdknKkMYhRuPWtZBffDcnbSGgYKVC/YdCnTh+oHFdawIA9qlZVW+k3KkPKzQsk1sI5LSxwBb/YeVj3CfggdF7L0LK6dbrwMQDIsiWOmycb/tssP1tNTvt4D+3Ru4krBtgiW0KxZZt7gK6QYduaNMKw6zQFn98xOMRiJi1VQQ4dts/ORjg/rbOSEvgR0KVIo6cNWKrWoKlQLOm8O/wDTspQlE3VQoCd94i9WQqaiW8guAEU9snKFsHxTs7qjvJl8ELwdipy5xXKW/KUwOQAb8mg9mHinZ0C4ndK7ED1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFNEWrJ68/zwRW+LlfXHfNOLFSWE2yl3y/B+xHuhIkY=;
 b=F8JG4kxnLEVjXCn26jC2eTxN1oEMjDvnuL+WHgoaa7CWZjq9yX/GNow8RDa5IXyeB61MC7ZI/2GZhehsm78DclYE5Irvvo2bvHsnSTCxW8IJ0M8KwsGnBDH/ETFZ9yGsqHr2TeGcQKTLgeBTZJpCR1369cTkBSvTSfhSWjXy6wZLezGrQaerAJUlNSsDDrT6wwRFPykT27+n+7bx3IPdsW99goaFHxREQWeHHkrp+I1jeOA8KYCVDjfm/7+QMLmDM5IhVb/k6gGU/7kA/aBzJgElRF2WMaTCEkSafBD3ofyAOkjq6gKEkTELmrefmrx3zIGjSZhWD3S9TQaEW1CWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFNEWrJ68/zwRW+LlfXHfNOLFSWE2yl3y/B+xHuhIkY=;
 b=nVlPVlOK+h42Tvh/Qsv3buWnIP9SvAYlt8Wf4tPi965wOtaRY/iw9CV3KrkZ1ZDqNTfSMHBy4ibcu+JQsnd9K0wtz0xc/omO0/O/1oyvRypxl4Vef6ydEv7NCWEElSr9hiQYsON7FsD3+TqcYCJqv4dwRXden/q5kuN1V+mgbaQ=
Received: from BL1PR13CA0073.namprd13.prod.outlook.com (2603:10b6:208:2b8::18)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::8b) by BL1PR13CA0073.outlook.office365.com
 (2603:10b6:208:2b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/30] drm/amdgpu/imu11: WARN() rather than BUG()
Date: Tue, 7 Jul 2026 11:41:46 -0400
Message-ID: <20260707154203.2603209-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 173287ef-fe19-467a-89a2-08dedc3e56c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: sLmQhRt4/mUPmSvDaopjAnAIxAtY47vgeN41d7POwq9nP5jBM31BIp/ntNHfZZNguAVxtcnQ+SpoEGB8UZEiArVLrYRFyx6riU8ROZiuoCVT3KUycjHwBvP1X1vVyXWGo/fIE+RoOs9t5yqgwv6vUsUHyBaz6E6Ur7K+x/LHyXK3KROyakjxNTvQTpHsS46xuy7fbY+7XUVjiRPy3AXe5gD3AlqoH/8uyC5CxaAR78TDeGworNRiJR/tTjqo4W+I+ZwoftxAx638ipQHEYqVBhsvzGg3BTFtWVuQE2c4I2h/x+A277XI5sPFHeuuTivPAETaAVCwWtJ6SdncuQ6VrJe6sQQmOCeRj0zRvb6XKlrUOybJRo2o523GffLJvBacWVUmwsBvwGOncoFDM1D/Wu8wv8q2fEQ+NafUDaGk9PxI6ebzTigDJAhZJx93aybS9X52F/BNCoBTvvlD6Q/X+Qbg8u9+zkbgU219qBFD1gLRYA1pMzjZSwhWZiv0f9hrsp9lNxB/otIUIy8TAb3OVc1aAP4G4rXIvOgZussH09LsHPqs1YGsl2arPW2DnyfCim/+0N2c71cLX31acvcrkdvVdWP2L6Uyesh0ciSl9pBtJY9bIwKpJZob3AQNUnKkR6ndQf7RSja0DyLv+rFwBwmzz9mWOXwJ1SVfFSXrmJ2HylygMkHe/KSpLu6U0vbz1+kj7iC0JgsrHT+c8Fxj7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HfmQ2WnRS1C8FcTt9BIIiKhe0v7KBhKhjPF+DKnBDVGZW2ribumpkX0VL38Lnj4f6/B9Y/4nIEGVBxNy9j14NRxMGhCEWLMTYmKrWRpKwtb6wLIR8I8ezVmpcW/knLeyRbMQnK4ObAc3ndbVDtHMMk1QrnUlIHpE6r41bFyK5qeMWfBWghsKv5qhkca5xMd6/gjRTY6DXTIoF04Zz/wKNKgiwZeokisDp5Eey+qAi1LGZE+zuCRfX5lJs9jXQceChVl92HoE1CRjvu+ZkmJTIk4RkJw6gAUSGbIWMWcD8B1CtHLW/LBuha5QxasBuUDZU/NPRxFqPp09+ewSk+SRwhCRUojttlS1q3eLXMocpJOB4u+vtaBOfzWtsCLWDxSb/2mOupVnhMyc9l2AR1/EbBpcxafUXZGTplrCqoQhEUJHKKCOK2VdTkBmUHbUhhFl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:23.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173287ef-fe19-467a-89a2-08dedc3e56c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 05b164f38c97a..138eb822ba137 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -377,7 +377,8 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_device *adev)
 		imu_v11_0_3_program_rlc_ram(adev);
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid GFX/IMU IP version 0x%08x\n",
+		     amdgpu_ip_version(adev, GC_HWIP, 0));
 		break;
 	}
 
-- 
2.55.0

