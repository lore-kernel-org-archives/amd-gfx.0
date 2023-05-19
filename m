Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FFFC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 13:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD96510E04F;
	Fri, 19 May 2023 13:23:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0559410E04F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 13:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2+iaLKQi6xX+TKj1fFxiO3ciDmYyA7sf9BNy5uVeD2qVWiZUMZK92DkNH7ovgSiDEOUikPkHfWQdcmhIKH8OT8UCTuQFPwFRikhoCiF4PJEvEL4Rcu2Gb0UollFDUqHrdIPwaOX0/EKKJX/bKqUN103nx2nxOucuvD+Vs2kx0UQkMh6j8RC2WmR6unJcPuQeAnK8IYTzqX8nK760WmelDTkPLkIuYD/GvPUV2qnfLA48FSQ/MI8nS/yq9Aeivh3sGGbwHHk6Zz/2Kf0RbaJFvKs0/MmZW8erz8gGqUzhjBLbDyQFtyMDLYsGClRbz/911kgfkAvq0eFAaEj+yruMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zpdIGr7TT8EjBWxIGHuJeHB1+KrRzfj0P4680qlnPc=;
 b=Da5Mw9+zevT6jnuunJRFLQz2a94v9mPG+pC5pdDM5hzZR2k13XpsXQ96hixospU2Q2E1lqlwKHTaecBYa/SE9bGxuNNwRnUsqSAJzkYQEWnTHJXiy7jWHX3ZDltt+fx6rT2kVP40LarT0KTeDz8UtlWOm0VYjydiNuf4JEPDivJz+pSYdct/owCkVxVA4pEFHe/dfXDkpxbfY6KrafJxa/xE9WRl1mWtl+PXTeuHWzqCqKOSDhcRKCTxpJZ2twErq3BlrSA3XIOc7dssYDfpxonTJBXJb1hvj7+BD+81uxSMK/gdBab/vnrrNJOVA66LPkr4Pqi+T6+cl2HHVfzRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zpdIGr7TT8EjBWxIGHuJeHB1+KrRzfj0P4680qlnPc=;
 b=p2YYq4H67/liVBIQVShyMiO8rGxCA/BffUUIniix+BLukePK3p1yRiSbbtUWq/xilomWXFPc56N+5M06cI22Ql/qJ2LB+xyckFZ+sANLCALyR11kZktKNDxPrFMqM9cvmODi1zP9o6/cl/9BxV0B+Kxe+5dF75/LEajDqHFqruY=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:23:41 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::1f) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 13:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 13:23:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 08:23:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info function
 in amdgpu_acpi_get_node_id()
Date: Fri, 19 May 2023 18:53:19 +0530
Message-ID: <20230519132319.388311-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|CH0PR12MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: aa806467-3a5d-4075-aeb6-08db586c42a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YzYr4sZy/vMKsZSbCcrsPB30Ik2uYiVGH47GZl1jveOVkc+vfp3uC8W3zQzvxphwD86z7T+nqaR3Jy55HeETngTQNWyZPPrWHz7YkCK3AnZcYim7fEty3GuPbzG5cXS08wHVld4oMKViXEnUst6kmOQiJWMkpP4lLtl+hx52ydm0Mn0+xSqeeXaua9P8KceX5pwp+HqGBy60/oIAhwdjf7W5F0a4Q5XEyzHZOZqf//dmCrPsZhb9xBdDnnc28TNt/kZ6d7sXm+J40ORTQqkvpgwocV5tFB47rB7ge/Dr+8h84S8aVfFiYgBN2BqPLK7IccttROvGtyvKQ/59RV5sMwgRdMZlXT/reFXiqPbV2q0243+Pl1Ob9AddrzGCwhGcCa9wG+ReDzQYckc4mM6CQZNiAnP+VgDkcmqMSSJZSfn86KVAXkBDNWurUJObiOByiCJRXLy2cjka1TDa8E1mHcht+CIQJoG1nOPJwG9aaecUmJvSBWmTz/Vcad6rw3OWd0MU2rJq28JQEltty69KpGuC34zBxDNvWWoCTjcpLazgi0a4e2vH6RzFYSq8f1VmD0utBFwhCuop/nUbOq3Dq5nMB/zGv/e0qBKTVVbN1hANWYj0ut8BxmY1FzJxY3z5UbRbWY//INJ560F5hCPxlql6QhUwSqNHnPhJi9s5tMKEpYzA6R8PMASOv4ufOOS/iNd+p4lec3DkdBkfaLJUJeIj0721Z6KPckUc+Os9sw3R1VZONwTbumahnEe6cAWMWkvBmfTjtmDccH1exQE/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(54906003)(47076005)(478600001)(40460700003)(86362001)(66574015)(2616005)(426003)(63350400001)(63370400001)(83380400001)(36860700001)(1076003)(186003)(26005)(336012)(16526019)(81166007)(356005)(82740400003)(82310400005)(36756003)(6666004)(40480700001)(7696005)(316002)(4326008)(6636002)(2906002)(70206006)(70586007)(8936002)(8676002)(44832011)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:23:39.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa806467-3a5d-4075-aeb6-08db586c42a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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

Fix the below compiler complaining error:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:860:33: error: unused function 'amdgpu_acpi_get_numa_info' [-Werror,-Wunused-function]
static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
                                ^
1 error generated.

By guarding amdgpu_acpi_get_numa_info & amdgpu_acpi_get_numa_size
function, only when CONFIG_ACPI_NUMA is enabled.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Guard even amdgpu_acpi_get_numa_size under CONFIG_ACPI_NUMA (Lijo) 

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7150c09933cf..1a66febf6981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -841,6 +841,7 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 	return r;
 }
 
+#ifdef CONFIG_ACPI_NUMA
 static inline uint64_t amdgpu_acpi_get_numa_size(int nid)
 {
 	/* This is directly using si_meminfo_node implementation as the
@@ -886,6 +887,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 
 	return numa_info;
 }
+#endif
 
 /**
  * amdgpu_acpi_get_node_id - obtain the NUMA node id for corresponding amdgpu
-- 
2.25.1

