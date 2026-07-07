Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DC7C44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBCD10EE0C;
	Tue,  7 Jul 2026 15:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sansLrdW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0930910EE07
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyzcTpFPVimi4DECCWsZ34e1MHXsqrqgrTpNDvcOY1TqwNCftJ2kxac/+5pGdW2Ww+qhF+66gjAaVnSv2B0NIEENyrgo6G7XJPCxxJaxFjSpn91LDMuRAkWlgmwbonJ33ib1hAJq1MaX/3dsD+X/anzfOopxfQ5usSYcMAhfaZxdj4XgKA9M8pN3JF2AteKevy89hPpzaNRYj12zAzQRYbr/g3k6iKYBmMARVbeW9qPIYuEdMq6Ru+nxr1QBZjYPLdqATORHUP7RuB0hZOf2f+VS4C8gnl1B2oIFE+bDCRP8R7NolwtlM8v7aQMnj3zEipNqydDHrADrizhVULFGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl9r4ykErR7YsTqlXxgJxG5cK4DevBGYQ9qDT6RJMrU=;
 b=PTEnUKFKYySmnuamWjMWerp1bnO0zdgYmr/VGEuzjmFPdhrGZIVv/+OVWjckkeaDc2EUHmdI38YTsbzqzuIuM/WFrAEzaN9cIkcmXzltvCGKgKFIQYpPdwex36jXVyDINx0ysSaDrdMQmYjtGZ5UUlstvXXqsmJWLeNOLUfQrSrxb/kY7T1pUO+m1mcj7IbG3LB3xan+NXRC+rLe9f1uOXjR85JJEqQQ7sSRng7oQOjOYbvRu7jxnlRUoqwDkDHzzoj6KmYUWdyz0MgoNcOF/z/Hb+HYl4uh922tWU+4St4RCLsDAxK4W50R4IsYuPWRWbEG6yTO8nMyhXAzUjN1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl9r4ykErR7YsTqlXxgJxG5cK4DevBGYQ9qDT6RJMrU=;
 b=sansLrdW8ohyfbHgGL9jfwcMHvhxZBFsrteyTOCXB7YUvmRNQlfjpUug4nbLoj45/M7v9zWVimBZfdHfSucBiHklhIR4V8vKNTpSWtEYPTYYwNI7SrvFnKNzzOfo6KKlNjjaJpomVxZw653NyQFTPfRSBYdokX1p6omylqHtJTE=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:29 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::1a) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/30] drm/amdgpu/cik_sdma: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:41 -0400
Message-ID: <20260707154203.2603209-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 741cc955-a0ad-45e0-9801-08dedc3e5a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZLm9fXD59qbirlME8k2Mn5uQ/mOkHCexXRjh6ZWbtqK5TB4NxkxsoWMolvpm/7kLhM/nLUule582XiT6XwjDgEgPF9vFN7DnHC9WmRPqSg9qy+yI7VaI7mrUwPrLYlO7zR94ciFT6R/Yq/qt6zt9DL3ugdnTZMjcAIXbdfAjOpKcX1EW3jHoRXg8iwsXy7qUMWTXMdNyFI2T7ONf19ySCRCCt01UGd2f6/qDamgDKfmKdDDqcTpOqsfitshJDnIEuKevN64xTd95FL6a4s3BgvMSJtu3Otq3cDQmzPCUyRyLDZ/sexZNxXbMGNeYJdd10HSK+1cPjQliwKtfG4KxEu5/qV+omcRCTmowAYHxDpk0g1wAu09GiJdsrUol6PTG1W+tktma3P68O1TV+4HhKMHTW112LfjmB36fqdcLFpwij8V1Qvz5Plo1b8pUbdUkcJkkogkRzlyt6SCQXSdO8q616nHH0MeP3lLF6Ho6UQrgrlPGEPuqRk6zdVYYOzR3PmHOf3+XvKatq4tVSKUWAW+q2eu0OYHyjokjI8ekkMsUMQlytUG201RIZSZHEhfskWgIKs1ZGSZ3OSXkdmOXatW5iGAhKjcHd1WjL0MqZwQd8YrGluiIALh25NpkC6dCSVJk06+q0JA1rynJnyl0kqVcjxFXBXmr6i74h3GhJGulBociq2Z4cWVfKPH8iUY1g6tjc/pSb3ZgThtoTAXYJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t5E40Rzd8pvBlCH62EJz+NfENKQ/bkgfR8FmBEUtkNScIrpQHCS22byylvxuMsb9a2dK+oJXYossL0mVJBBPzD2gwtRqPA1/jchTdUNbQjNwqMyptM583LKedz/M2gOmdomto36/+JlC7L8LGKgFYg3TB3x8IaJ4K6zcWTMqC5yctZ9+iZtykQ/dX3A2rQdIPugiuVnFsBxsfpO3XPh2sOat0+330EePkIGcKtEf/jk5FpwebqBsfMKXMS2l016coF0yNeknDtpWO+B41XrH5dK2iRJeVg2Tdplthjok6+Wyxrmq3C/ll8SDTVbEle+rwab5ODoMpH9rEsuElvdPfmIqwcZj1EZfDy2VkbkRY15iLV1wbZN4TID3GYjyR/18SQzr64KsoyA+UC+n1sEqDZnxFSi66OJQVosXCjezMfxM3D2MO2U62k2vEUwgujy4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:29.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741cc955-a0ad-45e0-9801-08dedc3e5a33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index b703ef1fe3406..b951328d94cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -125,7 +125,8 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 	case CHIP_MULLINS:
 		chip_name = "mullins";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.55.0

