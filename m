Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCAAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A95910F51A;
	Tue,  3 May 2022 20:51:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A865810F505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcA44po1Is8A1Zfk92P05LCd6vjD1K8F+BwUxeG7LhfYzBEdE6hEdyGUVPyPWHgahdMVGnfiWAHQLrZoCTH+zkLg4dAqJl0i2UCmgwUS5qY7NWwtaNOy7awq2MI24sODboKZR9iI69XbsN1IovGT6Oe0y/9/UkLqDAZpBMizz+hHHov3PvNUi+WEpZCF66u8uUIu7suGZyywMnwNgPqA+pIDhKbje2HFYE13H40D5kI6Bc3QO8PT+k81YRvrSW1zYhojhTp0WWWFkBtFpxqAQgRAqx1DiYcCdaXLA3+P9l0bCWiTDJ97ZvwhvrLNRvCTp7kSHY28R8TRMk7nh/3rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5hIJG2Up+3BvRkwvB7tO0zbVZcZBdEe3CyN/emey+A=;
 b=khFm8DbUPVyxhPS9xN9UCc6tEBJkExszBqPeSSBGt14zeVgaK9NuwOJznWGOfJ8oBq8sGjyK/Hve7hz+kTXDb5HtZVMBIRCviqAunQqYIFKWm7eEeDKeiBXGTY2USneUVVN26lP9jxfQX1lENAuJ4CJHmedreejycFezL/GN9YEbf6gJ2FCMOQfpfNRsyjW5ao9mYi1OgsMWgej+IakhQ/xkT3mdHJLvpbd1bINmfbqNqviteZSy2A3WHAFgYBORH1LpEpd+G9y3nt8BWNvH6s2w1KiLej/R5Bc4KkOaztdILn1OVTXPUgvd+EiY2RWTLG0rp9Lmk+XfjDvetwSurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5hIJG2Up+3BvRkwvB7tO0zbVZcZBdEe3CyN/emey+A=;
 b=NjPBn112G0mB2grrjjfsSFVI4Vfen2BUckzmljHg+u5P8n+fEl1pMG9j2qCm1eQezDT9i7J9Z2w2snGpbn51VHk1kAoQilWJV9QhNkD3fltd9LrlJaca4cuzBjmgqzPOtmaXrbXWnLcFVCcfc2ZwEUzUDE8JLXwU42yXF14wTAY=
Received: from DM6PR08CA0037.namprd08.prod.outlook.com (2603:10b6:5:1e0::11)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 3 May
 2022 20:51:30 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c0) by DM6PR08CA0037.outlook.office365.com
 (2603:10b6:5:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set GC 11.0.1 family
Date: Tue, 3 May 2022 16:51:05 -0400
Message-ID: <20220503205112.1285958-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4dac9f8-4283-4ea1-39c8-08da2d46b2e6
X-MS-TrafficTypeDiagnostic: PH7PR12MB5783:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB57836C9A8E5EC0667702DB95F7C09@PH7PR12MB5783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scyxFZeURC9x5tmlXTI2ttpsIVBa0jFKQ3uM+vDRHnKA+VEvMbuaBiLbJ+xsZsefZ5Kt+NZ3oYSbMh1KxlsxVykcVO5tf1YcUECivjMootetE9/qwZNxrDmB1qKo/6YlzNj7fVoaUzwssXbuHUvmn62CO08a+McriBb2OXnI6kCKZglxo1u6LfL0nPJ20cKN/kIRAVFr/hE+DeU2xlXYdnH1KixNuxKEuN9Ny6vrWkdpxdGxbKLn7d2DfyjyfdJXqp6E5ZVdxclLkgka8JONcNVEQM8IjSwNe9BVahGxR8Xf4jzuWmLVo8XMCwllzUySvs/mZwTuZfS6bTyeFMMk+58Y81LdLYXIeirXCKdMWHlQELvN8AwSnkmuY8OWja4yXIaT32picLAaZc/PPjH/sBFoNqwhCTqqEsSwV2NOAVL6XAqDb/kbbNZ5qctK5ub3dw0CFbEq0/bSmcLFLHPlClFIWoBuoFagVW57u//PVbku1cZWISiRywllTIuWswWvJu1t31gqDVakvLZTwTO4rjdhlnoZ7bLpcSLmlbf581Gow4+6EHy8U8C2+Ghl0eW3IoURGLRZgm7wYJnXxjMn5dSW9HWifNVnvfzKm+9Ko+0ygmy7DphP3ECPAIP8FXUjImsLoJJ0/Z12YNIXu+ZAyzrTbu3KvUHXWcvu6Cz7reSxV8/LFGCCPhymykLdJIvlcoWQLer4z5GOrmF45+J8Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(70206006)(2906002)(82310400005)(4326008)(8676002)(47076005)(70586007)(36756003)(316002)(6916009)(356005)(81166007)(6666004)(4744005)(40460700003)(5660300002)(8936002)(426003)(2616005)(26005)(508600001)(36860700001)(54906003)(83380400001)(1076003)(16526019)(336012)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:29.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dac9f8-4283-4ea1-39c8-08da2d46b2e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add GC 11.0.1 family support.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3931c1af2b2a..5c6d8a68c540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2135,6 +2135,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 		adev->family = AMDGPU_FAMILY_GC_11_0_0;
 		break;
+	case IP_VERSION(11, 0, 1):
+		adev->family = AMDGPU_FAMILY_GC_11_0_1;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.35.1

