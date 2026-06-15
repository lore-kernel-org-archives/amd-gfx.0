Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CA7CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D8A10E77E;
	Mon, 15 Jun 2026 23:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FsSVoLDy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E71110E780
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmh8o4/CyPLCjNLXrTOdpsl3Df0JR55pYqTmCDZrPFkOrT2024CCR1ip8d/BL21MtbzkIdP0mU3YY1w/xM1lYHfuCWK1ARxo3fywdQ8gF9TuSKzHn1KHkJl97F3/wyRz5zsARkqo208cjI9ogmjLKB7vQw0tI2lNqWFFcnGDfbh5bDLWgbTXgkMRZMe+d5vC3yvfdvLUs2snJvg503qwINpIVms8euG44CypOW2YB5fdZKJ/uouS/Tg2+Wgjo/uP6lRwMXGlG5tysIgdfyw4kcUjVuPvzzqZ2ML0xKtL8lSx3/tdrXduRyI0YqI17mixzymMXseeqIYjhuBIyjVvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSRIXSg6tO8DzK8l0HU+bn1qAshPGen0Ptzks/DFmRM=;
 b=KZBp7j/9NUem2j+r26cceqM2LcEc0fJEbLMT+iDEzodvtdXAY3pVHMkeDH1THLgzDLuk7JxKqjl9u0iFqJbTR3vE28YfWdQWG3MSaz/qYJAdHTtZ78+kECXHzaj3uphA8UeRyXNz0T4YTvTulpXsMV89jLDr3wjmKjqSl5y3zu3Z/ZRVuA/jBe7jr9XsYmF2uKGFzCgoqmhLK/CN2HghkC3wGDa8CRcEklM/ZO1t0g2G4CwYXbj+jcsg67wLGSbDMJTMt6DawA5gqa2Mw3K4GIQElKV3/ahJBYIVAmvgw8Fl1JXSq4g55xVahlHh9eVYiSWMKCiBk3Y2t3MiXFX1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSRIXSg6tO8DzK8l0HU+bn1qAshPGen0Ptzks/DFmRM=;
 b=FsSVoLDyY1pporDmo7FHdpaEkbCPjWoI3VQwQvONUsY8CvY6CyfBAaal6EVFjmU7zlVDKmZBd9qh2EptVYuFwbtifsdvUwY5N7FqQCX/CJeOlCwvgg/ia8vY4yeRfPToy5MGLVEnH15H0MEC8zBeruZrBjkPYDR0kyQZgPdwpTk=
Received: from CY5PR22CA0047.namprd22.prod.outlook.com (2603:10b6:930:1d::34)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:14 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::ac) by CY5PR22CA0047.outlook.office365.com
 (2603:10b6:930:1d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/43] drm/amdgpu/psp13: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:34 -0400
Message-ID: <20260615235645.737189-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 518289a5-a102-4924-bcbd-08decb39d292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: z7/sO1848c0LtUTmABVezvgOdhS5S/3Cq1F7br/gJ6q9WemLh4cu2by+dknhN4O7rxPZHyGFawPugn2wJXSgVtUd1Zp3APulHK1ATr+Wbxd2+omAguLXIbV6QpuyGjEFHqYXUlVRoIWt5I6vN97Oc7BCjjhCsJLq47/L29OCCBu0RgDM0B3UqJE2YQ8gMU753RK/oixq5Wtz1ZdqzLj5wodWxoZMkMEl6eEz/+uwQ42t6uMNM6uR17snOm+WQUzxQagKhHrhX8K8k948p7w9OH8YHASGQXaGCdaEG/V+vcIvtXIWDjH4pobuSG7EWMbaGpk8F4LBnb03lXwDLzONX9XXlZvdYMk5fDAuFruMgWs0Ojovr8wTSJrMKb8jZYiWrCKd3exq7wlO3a54D5el/7GkO9+Cr2QNbsZi6Hxjw5xynih0Fsd1wgdiHxE+z2naywK1+UGCqMtHfIq0smJgcycVLZlaOfNRUEWtmcaZmguA+3+AX1krcYE3gk22j85s38WiEU1JfeLX3kM4j/eFRPCVHyM7lDaz33FLHAcIZSSn8T4svy7OfS5qSValsDSjX0wDADpROmCb8mg7Qk+jW0P+w7Pq57mS9FMGIYy0ml16gWj/RsHBYe3zc1Fnab96k4HEetb5cnKJ1g+2yRu4SlVuzE3FdEu3z7u1ykj0QVSg/N8Opq/QlypczR1YsRSExRLCbnkPgWZFGo7uzIniIVmSnVlNV1VlpAj28Sg936Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FUjBUXDchhLqQObXy1k7AtnmjhuB4alHoizIQsvpzy4qMOXDtT1P8fE/tNRTm9ovdmhCO6eyK9tm1MTI5BWb1S89pR/PUG1YpVwtmWe4VBkDIO3t5vTncj5MJk9ukK4QiCimATi/o0XSprUrsNCbkpRyZtYNUlp/xGxPTA8tZYc5FuknkPBXUQuOpEJpja7DOStbVBfwpLGE5U65vSUaK6hRe2dzJ/KFAgskgzgBQV1MYvK2h9fOn7b8pnfTELI2jxHhK/CscPp9BRilu3s3RDyNOMIbRgCyB2LGHpvsEpzs91uzbbeU7BNQb5fQF9lgkdginE7TUPGxjurxoHG0s6kseTKH1cWQOsNecIACTxvnfgI9+EQvxo7R021mvzPHCHjizgCcGN4dKM0a4c0iwKJ6HhYhatQQik2hnTFusk+UsDGCPCylxposEtyKIkYL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:13.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518289a5-a102-4924-bcbd-08decb39d292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 00b4a34e6601f..4b0ab1025c2fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -133,7 +133,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.54.0

