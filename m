Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACEDCD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9844A1120D8;
	Wed,  3 Jun 2026 16:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbbv2TIc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE97B1120D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml54csMoqBS/qSV4e13SY37dlIepQE/kZ0mhcRtzA9DdVQfqWaJYeEUHPiII/nA/qleLUVsrjc6z3L7eeYudPe+EXGO+Onh5csxOQEcIrHmdKVJ5M5wfTPN4LGqQ0UxIcyQ6ryb0gHgD0N2upCJdWOzhRJ2AG9jVbiItfeX0vNjTX+7CfsIaZ6KFxfAhFrGLBt/gZk+Phmzqnuka5okzHPJHS4UzoKV2ZXrTLTIZGjwNkyOeA57lanuSQW+ytf29AqU9r5rZkIxzHjABK6yXhIqjAn9MyMuvZ97kRwH71OSJ/bf9IWK+GU4JLary2GjVkQjfPGGi9c4wTWMBymIGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9dbYkb0+urYIIDIh5C8ncYuLaBG0gBRJIbylh02FX8=;
 b=nhrAKDuuNrk+dat+nPEo5wT4dLpAUdSuouQp6zeobNx4HU9WJvx8zRGlydHHUvNdZLvNSryIEfEgViLRTgtL5PQi0NwDVirglSVzYbTEFequh/RdABpKriwReXID7ij1NwCfY0ugXADNkU+A21+io2hztm2k2y/4unMZgg22nZ3KtydYJnBdL93z0hNte6yKCzzudzvA5+SikBLJAfE4tplz29FKuil1B/rKtkEfIGa6/qM0XBUc4/5NJRP8mPMNSn98485sgR2jE7ea6VX0IBMRez1XUHAsL21A4ipVMaiLeK6Q+DdrE+/9k8vIY+w/kugoujIU+8YnmbEClzj77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9dbYkb0+urYIIDIh5C8ncYuLaBG0gBRJIbylh02FX8=;
 b=wbbv2TIcmZPkyrkc4SakOeqFusRootULCiQmI3WaoOz+fx7jzVwVRZeFMpgcqn1kAfkFnYh9YyZpKzjWvCV9SQ2RPdTlindyN1IwcLzB0lCqx7Zt+myU372pPE3oFlAEu5omvc/fInijghc4cpxKr4/gQvMcxH+GHys8e78BAoo=
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 16:35:26 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::4) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 10/11] drm/amdgpu: Add memory exception records to
 WAIT_EVENT
Date: Wed, 3 Jun 2026 22:04:49 +0530
Message-ID: <20260603163450.2678374-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7145fab3-61e2-449e-95d8-08dec18e1dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qttaqtsIHZeT3f/D6vvqKpGOwcCkqoNkYZnk0UxCRURpK25rBaQjirwwDvY3tTUmUOd+kxuq8Yq8ZGtCuW6DjlDknzRf5dGtk2Hxc1ntc5PMJtY5c4G3JdJ/oWefQpIOVGiyxBDC72xdeoB5eHQqDHK3095kCvqH4eQGBlaBXYG659cdEgutn8Owu8yXpS4Jd9OwvR3q4eHbbroLUbDRPaJvFYmRv8b/rBQUouSqnhY/8BcTiWOpltCYxbRcBauTdPb2vSjOFii55yWsDPg41BHS6o5BaP7f/7MZu4yc7mRYnHyjHZcET7iQu0Q7bhVp1wbuyTJACR0taNeehxNdefyb8qihDBhB6yWuLGcbAQY0YUA5edi/vxGLZeMBwKqGPS9ZjG6H3k1cHv8WMX43ccnGfk67CmqUpwaq77oPjeNMADkGxUhgB4h3Mbie4ohDktFADuF6kXP1HB0KA73OHlOhPkrFPh2O+vxGVWioIVB0VdJwjtQJSDOEUUhrG79TOb9uxMCHIz9ZLsiTv0FjDmQsBLIkSO9Rit/J9pFB8wjYihuPo8QbObxA+ODVYcAG+1hAYGx5ihobt79gvJkH48avrQtwnfW0Bsvq+lPrT1DnSTSG1nXP1mpnNuMu3OZ/pGYSKl8dLtwuEXwRmx/SSniyO8xopOLHBU9jNEueZENwk0e/VMQNqa8JERhkdf2ZqwntIBZTYEBSYFOcL/0LJNXBCfBXx72Hatw0o/yMlHQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hMUvbGQkeGe+wzNOaxsbJ8Q+2XSnMqF+FP4o+XP5hpjaCW9bmkTpYKsnD5Xvf7cPfa7NfuB2tGHRKLvLCjBQ/qU6G44+/GGDwetvwAndLjeufNAvbz3sVMq7ASBcA6oEl56w0ADS6spehAODkZeZklHus45QpH9s1VCrGlwJMo5SA8Q7rBVDGy0L9US0huZwNs9YkEn/4cbmM8ZGuMMumaMXcnmM0z2VNKao+3knk7hjizJqUe64olgNn3zLRlHjvU+fvEWTtg1r4A8mf32/Rux19Iw2uXPHUz8yKAXeRQlmYXLZkhGRIL9O1vvO+x+/AtUveyrsf0fJew02/5YHoc+ZId5ZYjS0pJ/e9aEkIotdvgV3WChpLiUN/QVDK25A87MCnmXIHv5/FBmeazvtoeEtZdMXeh+9rjTM4Y5hfdo6fnrWY1yDk8VVisv6jTae
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:26.2099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7145fab3-61e2-449e-95d8-08dec18e1dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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

Queue memory exception records into the WAIT_EVENT path from the
KGD-side VM fault interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes
fault address and status, avoiding any additional fault decoding or
KFD-side dependencies.

Emit events as GPU-scoped (queue_id = 0) since queue association is not
always available at this stage.

This does not change WAIT_EVENT UAPI semantics.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 337f3cb9e5ef..4136f2a8e31c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
 #include "umc_v8_10.h"
@@ -142,10 +143,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
 				struct amdgpu_fpriv *fpriv = file->driver_priv;
 
-				if (fpriv)
-					amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
-							      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
-							      0);
+				if (!fpriv)
+					continue;
+
+				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+						      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+						      0);
+
+				amdgpu_wait_event_push_memory_exception(
+					&fpriv->wait_event_mgr,
+					0, status, addr, 0);
 			}
 		}
 	}
-- 
2.34.1

