Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB4DC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 19:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A44010E0DE;
	Wed,  9 Aug 2023 19:10:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E290810E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 19:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHbAzZC9aZt8q4OsV4nl6Fm8PIPehE6wH6EBEbg4pl5maqs07iVePigMER3tBNJQoAaXRMvqreF08QlGdmwrqCjXsiop1RWp+6334yHhj5NNA1LITg+WiW+uLxRW9K4Pp23dMXN4c2iOvJokeQZyDo+fm2aNp4tjCbV9o3HKeFMrargievQGDCuafHI985xujdF/yJcT0KRI1EPMcsuFRR8uOFbtM1hJFbAhmIkR4q8H90cJ2nMT0fbFXfK6c4jOPQzhklJ0/RymvtUnoLgeWBGEiQQ+nKhxLaBQ4fuTECHlR8qQZKyns6XJtAE9aq5tLO48txqPyX2yQbRMH7uRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8heIvirtb+J00CT/38PWAsCFPIe9iWvJuDDtun3S61w=;
 b=fqjk1/c3kDg0WdDoKXZTdi+ipnsU8WJQfv0CUsgcsocRXf88l2G3WcrHw/7DMExxQIaikTvSexBsrNHT46JPTy9TtlrWrtVohdTbTd5eN/2ACsG0/08Cq4xXqua+8SIvMYvcWLO8K9xfsK5p/m+oQm7HehPBacDlwpRzzCLmkOO3jAXEFOPna5VZxkxCG/d4e1/1tOebmFxZ9FA7cFR3J+fLVHEMWYUPTVhNl9YYt4DyZJadGmYNq3Auknkhk1O+aOZadvLBMW+3w3zHm5maF2bAZiV/ViSUtKBBETZwCLXTvzvvMvX6RjyfNqx1SJGnmOl/K4QgCTzVdtDRDDkT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8heIvirtb+J00CT/38PWAsCFPIe9iWvJuDDtun3S61w=;
 b=0/BnOD8KtvKnIfVMJKS4mdieLAf3p7BVs5tHtVTFH6pqm8ifEHl0wQwp6GTGlDcyqYUEp3z4ZDP5Fc+Loh9QmG8kuQrCtrOmp00tQJN8In1gRRSoXtdJqSxBmuJspOqliFyKNyqU29VBaMfegJk9dE/KiPBMhVGwzywNMKEEhQU=
Received: from DS7PR03CA0273.namprd03.prod.outlook.com (2603:10b6:5:3ad::8) by
 MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Wed, 9 Aug
 2023 19:10:18 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::93) by DS7PR03CA0273.outlook.office365.com
 (2603:10b6:5:3ad::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:10:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:10:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't allow userspace to create a doorbell BO
Date: Wed, 9 Aug 2023 15:09:55 -0400
Message-ID: <20230809190956.435068-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6cf05c-2071-492c-13fb-08db990c454a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ds+dkysh3lGBcZ9buanvTddMq7oMXNKQU8PtEv9rMT5fqcet9p5WKl/ucCkH+0rH1Q60Qzc/bGrKZm2ttSPbNhzIsdBniM9fI/teVokk/smmXrbcitxhe5kRuiRXvzjwHL+jSdZqeeFt9cXCu2xWb0aW7DLNYDENNDJQvJ+fZ7Xs73gk+haQHvbn9pCwYjIzaQVH1iCurZqF5mvBL0TvX4bLh6NAOZRT1ynrOmDdEqk3C1UJ9z7XhYeG64LIBYlhEO9QsA7bn8yn6eRYWRErCJa0yK/PmDcqo/ywol/tMkWzZaesSk7cexB4agQYU5GCVNVnQ62oUkmnB/mGbQbA1xaQ9yaVappySxkr7FvWgLXDPpO+i4JDHfmyXx4ylu6KfjCJvQpMIgJf+WrcvAvEW6eosAdNpqVgqtSq1nAvErb3Apt/JyDSNiiO9onwKV2TAub0IaK2TeSxedlcFVFHopz/ICpMUDfqjzD+in+aAdmQuBbM1RJAN6taom5/2cGSzeaH/vzD87N0Q889/reUT7dr6ghtpqIkELGgPM+6QmLkOFA5fBxcN3tgqu4SUD45w/zJ0gaLDCK0KqXaQnlAOpLlnmCy3NxLUeRr7At1LeQvMYlz8y+9CPn300ssnBLwLHOrVwczsAua8Z4Ny0SpZlQW1JLQvyIwlIiZqSLb0JdvpgqonsFOWNMkx+Y89t4l20OOe6LkOMDCOlQjW73Tp1T0qm5S7QV/lkEtYVrWDrZ+xLCyLga13jvmZXtUf8A7g26Y5PTBC3AwXvydru6AKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(1800799006)(186006)(82310400008)(40470700004)(46966006)(36840700001)(336012)(16526019)(41300700001)(2906002)(4326008)(70586007)(8936002)(8676002)(6916009)(356005)(5660300002)(478600001)(4744005)(70206006)(316002)(82740400003)(86362001)(40460700003)(6666004)(7696005)(47076005)(36860700001)(1076003)(40480700001)(26005)(81166007)(83380400001)(2616005)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:10:18.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6cf05c-2071-492c-13fb-08db990c454a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need the domains in amdgpu_drm.h for the kernel driver to manage
the pool, but we don't want userspace using it until the code
is ready.  So reject for now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 693b1fd1191a..ca4d2d430e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -289,6 +289,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle, initial_domain;
 	int r;
 
+	/* reject DOORBELLs until userspace code to use it is available */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
+		return -EINVAL;
+
 	/* reject invalid gem flags */
 	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
 		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-- 
2.41.0

