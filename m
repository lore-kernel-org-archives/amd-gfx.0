Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E33EC5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 06:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B74210E05B;
	Wed, 19 Aug 2026 06:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csQb0fwm";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF14010E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 06:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHPQmfJjHBmmiUjB9vK05vPMBqTUk/rRlXpWec7abzGOVJgrCKaNczHLO3Kzmxbf6RidZ/d02XpjBAov/D6hKs6tgJYRZuG3dJml78H+I3Fwuy9MlMl6aJEJeJEpYZZpsDc45yh90RuiWoTIV0zgcubpL4Gf8tXCrWR9SPhXyX6FOwvcDzYm3L4nivC3VC4bLO1hFcB2oW/iQbOqobmzOL5wNZckyW9hgZmgzNeoomfGHXXvxAPp+e65qC5EGe4UZXHdVWjLA2G0P4x5vVmIp5+vcl78itUW58Cqjt7lCihQzAdr5OdKnTzCsZwD9Re5Ad2QB9Gyeahn5VVUeLABSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBXEv5YSXLKvBvgGc0fs1BfOW1yNbATE6k/0DAwgJaM=;
 b=S8xnHx8VGHDjUcARebios4ucVrGWhDoaLDdq/VU/fWwIXpHD2YFELeYrwg+1pBYyOKgmP6Gx1WEn97Y6dDNKlCNnB16Hw8R5joefqww0EEyBEgTAuMNQ2I+G8b+U7iZ+B7PNTWr9w4cp4m1Zlk7Ebf70x65nJ1TfxPHwfl3ast/+7pIwbj3XPi7MyW/m50E9IVf+gmLO1zg264UOJiENEh9iAeyFZoVWYAL551eEyz4SpeQOd1H4v+LK1XPuGsboVnVyxWKN5fNnxhC1NLtPJKqh/ArNsQjIGVxGMvcFrpcUkiF+X4LqYKmcSj76Xa+Lxyjd8Cz7Hm0159I8YDZaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBXEv5YSXLKvBvgGc0fs1BfOW1yNbATE6k/0DAwgJaM=;
 b=csQb0fwmYTuLvQlXrKt6ELXPiPCpyDMk3BPv0yNmzWk7qBzdRrmhFK3Lc1oE4J6QB5704HZXQix8+BnS5nfuEsXtRHyynv0v44HJ+Wc4VxAIgats0ZDZGVAXwyLLOWikw6CdfWSXNzdfx8ulV6vaKj0rQ1QAR7/mk3+07tHHDDQ=
Received: from BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::19)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 06:43:16 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::a6) by BLAP220CA0014.outlook.office365.com
 (2603:10b6:208:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 06:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 06:43:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 01:43:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 01:43:15 -0500
Received: from dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 01:43:14 -0500
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>, <frank.min@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD rings
Date: Wed, 19 Aug 2026 14:43:13 +0800
Message-ID: <20260819064313.3609274-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c036e13-ee1a-44cb-4e44-08defdbd25f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: hrrA6Tt++rhmOlWBcA/1TZyN030VPN5WbsU7euNllPAtjfSpzHHgM1Yr+zKWtgOMGkpbK+X5pnEYg45dEvfbCpsjq2KFRrKG4HLoHbprxTWiDOHL/KnxlLrScPuC6CKHQlQtnRHK1pQYX0SpzsLLGjGKpqYyAQTKQ4q6d9aj61lufri8NZDXbWsau76GKb7BZF0w5rAihgjmRYu/qt84FZt2tpJg4arxehb0T17sisHObdItUHVUBf+meNUosFmvsVttjnfP5yp//3ahkhS7Uj9x59O+YyX8StI9WWq6/SONLTphvzvfkCKYKs5PslBKpbuOeSit4AL0kYbzJkNxRJq6oMA8Ye9au1JyWM99OCAxQ2fYscSJ6dpKmfJ09uB5oNab6fd7jvEBLiF2erBgJ6EqOat3kLMUXmT7usnRz7UK9zR3+pO/EcJGM1lIekJRT1p+MACrEiq9Y7lwsknVjRSvfWAfISQNg+KbeL04zmiMxHG7Ag0+pGpemiH9+bfUNuLyKQJx80qa7f2dkKkkW6vmKpSDJeYcExvv2OUcjEwXnVDUQNiZY2N9M4mE9busc5aCHWYmw8efbO9kTv9gsvT/JKdH7WWbJBQLtME82qo+9zS2RJh1VYWDFQY2YhdJtHVPmkY5WeMeZMLoZAJZzrnIX1sKkla+75xdVMYF84789D+yzm3Jt/kWvJSxE7kLZxnQtRnb+ob8WQErhQmocw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 49iS6Id3ScidH84J4+qcbxKhvARxLi0DOauTvcVE3MNfNd8KqplN2HmSCq3ipcYajORp43oaJE10PrxxzZv9GgN4yXsmvoTWgRgCZglYtJi2lggcbeE5mVZlCIQgyWOA3Kr0IWgY0wCTDQ6QuVK5YjTEjmynoBsGkFV81ydqx7aSBwtPRHTPyPt+oXW5lPGKd014+w3B5ijEQMZJJpAKYJx6kDsSnx/ufl7w5hD3vkwosMfU85hu2EoNMfZ5D84zp/De3gK2aNzUn7Mv7ztoznPhu4719YBssS7xBeSutY3jfSm8O0M7+50Zj/ebK7uIRakhQsvRuiVhkcc1ucFlBIEkdAXbEMTzLRDLxbGRkFcfrh81JFm3fuU3gEkpetzxD8kELbuvqNlfhqEBY1VvJSVG+kBWKJo3ySA49s+YuQWzbyYrdH0ScljSfSK3Ffsy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 06:43:16.0174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c036e13-ee1a-44cb-4e44-08defdbd25f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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

uvd_v7_0_sw_init() does not initialize the UVD decode ring for an
SR-IOV VF. However, amdgpu_uvd_resume() unconditionally force-completes
the decode ring when restoring its fence sequence.

Skip fence completion when the fence driver is not initialized.

Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -ECANCELED")
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 228a405a94c4f..ecd7caa95d4b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -517,7 +517,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
+			if (adev->uvd.inst[i].ring.fence_drv.initialized)
+				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;
-- 
2.34.1

