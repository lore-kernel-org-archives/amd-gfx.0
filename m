Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D02F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6871A10E92E;
	Tue, 21 Apr 2026 18:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgu2sScD";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F9F10EB81
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIZcZX5sJW6dkISelEKBMteBZ5MDgqnq/nJyqUGSbZt6IwtqcNy1Y87buJGk/u8ROiCQNHYJO3xuSFRzsPKRMDu8URUAZqJAZ6wcYqJqM0NyseXgzrn1nMUyBusE8v71YR0XNDyh/CXmWCTdZCUFyq70FybLj5RYYFhrigZ9SEe2zwiXc/cslmBZ6UMpEHktc1HP6vyFRsjDpzUlwGOhnk65t815vPTGWxWBUWE2NBh+SQ8kRI81w/HeZ87va3iIPSMEbL+zyxuXyOvOzZ7NmAix/a3e18RrPVTg5cPFALwJxv7y+93vAJdQRpu6aAjrUoN/4+m8YRl9xcg7UJyRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQDll/tUFcRe9WqYI9QYTP4JqEP8rOiSjxfJRmqn6HQ=;
 b=po1q2IV61L2oX4XhObXr5byFkpkGO9G0YyWH97Eo6pEYPX4DZZRdO68NpmJjUpBvVKGGl1bhw3aXf0F6B/608Vd/Ep0F/a2oIW/pYMJ5mrgpUOm9oCeeN2oq9jP3gGiFklriJV7LmlAv8ZWwBVSc6dxLJwEI1iKuxG9ORAaZb0G7dlyJ6/CLW50FlaMi59lqypw6Mb1hFk/xBOxX2WHQ+aqCHE1hrWtfmmX8KXf3Dc3N5plcrxjKmZuJO24eEAq46FlcqXXV0yy1905DlHY2/7aKPci7wh1KC1UAQPNlQN2100DkqhPlJax28ynWbAux/BgQ2chi8JKMTP0ZA3ZqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQDll/tUFcRe9WqYI9QYTP4JqEP8rOiSjxfJRmqn6HQ=;
 b=sgu2sScDuU7w0QNduveM8Ck+/I1p2hlVYej7BDeq3Np2qU44BmlxGcav6H9QCITc02ShSBKeXjGh9oNMpW3vjQyog4aACjZi/8nzE+t/apM0eLYWiusXvsWME+bxC6bx78Qj+F/F3DIH175gWvXvR8eBArS/+y+/4vmjpPJ5bTE=
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 18:07:54 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::f6) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 10/11] drm/amdgpu: Add memory exception records to
 WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:26 +0530
Message-ID: <20260421180627.2402093-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8205d7b7-ae3c-4b79-ae18-08de9fd0e8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MsHHkO+y3RBzEWMgq+fvCDAkxeWyG0vVetZvK84rMLP0/wUQ5hJN5Ti9UCsNOS44VKGIUTMs/6HBEtq1DlWPTSYzk7AmbZyR2UC7efJYJPyXxlK4qcO9iodvDKTS5OBf+H22Hxep8hmeniota0qe+rs7FcyLumJERHiAFtAQqKouvx9IVvjEvppSZPEZIwXsDjnR+G2HAlBOFfYsCa9E4BZrVzdepCGTqOyRL3YIE6a5gU/VUJHNUtv0UJJrfBbMuJ1aEdoaNLdpPzY9rznjQKO32RD6ybc4ntbzIoW6sm1SZ9UxcrAS3PM7CLJFyH1hJnPTyZWIWsJXIG5mVM5z5DL1asKWvd0OedYbLkfy2RQxtKO9wH5Ie8qf4mFrCYt9UEksqLXz8h+2YpYqT3Wh0twK3y02Da4d7gsDWMzN38WcuKrf7Cmyjlx82QuyDzVBL3J+Qi/0R8DLrSsMVhzTe8jlb/aP4Nx7pPNUgKd9my9p6xxPs9Bu7Gu/yqxfVQgB83i1j980iREzfEcMriDJm4TN/KPVcmnlzt2yr97myyZHef2APU5/pF9D6b/MLqz1lGg8t1uICIZMoaqcJgTM2zcyFlAp2m+MMXR6FKal+sRG4hf61xjIOeVm6L2hJN/WLMo9f0XImKIxry9fp89yKARB5nfJvrCq8cSF9J+rPnf2c4GUOG9LE1sGEM/vHaYFBeA+b2pICNZsmOY1KlJge24AeZrZ7KZDeOnp/D+4e3mPBvmDHiti/9ngqvQXMLHjT/DivbKTFu+8hqILcKwbpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PqiIoIur16g+0SXbFs6chpN7UAP2yNl8bAxflTnMj+JfMeUQ9iVBkhZETjsMEQgqtGtZH+gE5Ct55XnrxEajKfsym94DXEmnvUD3W65JCPEzWLvYEgX3CTJ1HeGesPzB6CSxKV81psTbc70S1e/gQoUVqpj2utETT91hyiXq33MptKcL1sH0rFr/dFm8ZxYQXfF3QwwBNvYxZxXg5mGK93nMtK7FA/sFHxikrz1bwurdApFvyIgej8Ddda6da8AaSTXU47H9L4BuA/zTnOgPLjr+m287K108dGx+i7JBQqiN+1ZKq0UTJDfKzNBQe4C+Yw2cFQlUsaEWljvPXLYdI+fWlnzP7c9z0bGWtPbrI2br3R0KT2+9edIoVybYa+bjKuD+U2Zt11TOIHBRqih7TyJU5/P24sThNfFjJdpIscRHWJtKVN8eLL3kCWYJ6+Ma
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:54.2922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8205d7b7-ae3c-4b79-ae18-08de9fd0e8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
index d49fdb70045e..9d03921927c1 100644
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

