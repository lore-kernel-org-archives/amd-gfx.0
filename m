Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EACEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCC510E15A;
	Fri, 30 Jun 2023 11:56:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BAE10E15A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl8JAAwVS0v0/f2sPWCHLOIU1vCT4rHUrPnHjS4BPx7hs2FV6f+rUm4nA6Av1revggjonUSagswM0+WEcjLzV/zyBE0wqhGI7YxQfCY1pfAK05dtebb1K697ddjCWNPqIDZY7DAv1aBr9AvNq3a6kAaewc1iRFXwsFFYMx3P66WGMx0qW1q5vOpbNrpezVY9jsuCVipjpjaBK5nafyDchJotGX8YrXZ55cQCoEzIPu318JroclXEqqtBFYa86Xz3r4DzolokEr/xw8Zrshn5uYe7UVjIWRclhtg3ZZG8SoPmDpfAFQMg6ORBVjDJT8+YxKm0iT2N49J3IpaUAqcJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR+1UTKCC0Z6Z6c1SJmxbYaJB1HZ4mZlsGHNkNyEyuU=;
 b=c+lPQUaywyY3wq1Mj28MSz/RT6DBOfOJ/cuHtbAMAg0V0AQKW6m2aHTFx8T51ECZJK8hSrDjXb/gjtVgZ/bmQTcOHkxtDscIcMrk2du64asyCARaU1aqd6mdR6p+SQxxE2rpbmGwxpmJQFMCIYfioB/QXkXqxTPlxvVseoTcETu6m+Klh+sYpmO8PdkyIrOYgIbkXVzAc84y6sGK/fBdabxkDbvsPbkAQqUDdwylF2gmZIVWJJKhAcSLrm/wLZXLn2Ssp+Kye9HPiRlo4gaOREfPO5FhjlVOCMfAwKldQK8Y2NiQZYwD1AsScl9sCtDes5tMiLpACC85qLQOrDOxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR+1UTKCC0Z6Z6c1SJmxbYaJB1HZ4mZlsGHNkNyEyuU=;
 b=XGZr10iTVK+Z+yFMrrwtXky1exp87A0wkpKYTbGg2pQTpZuxXb6j0NQlY2mbZe+mD1HmbRtPsEDiJf435Ufsi4CwCtB0Z2r6ci8BR8fN8MQMbDw62FBklHijmpWmLh+yR87jMbYtFQI1U0aAWNhwnTjgBNgA9xwzPgE00iV/0sc=
Received: from BN7PR06CA0069.namprd06.prod.outlook.com (2603:10b6:408:34::46)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 11:56:35 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::21) by BN7PR06CA0069.outlook.office365.com
 (2603:10b6:408:34::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 11:56:34 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: drm/amdgpu: Clean up patches in gfxhub_* & gfx_v10_0.c
Date: Fri, 30 Jun 2023 17:26:12 +0530
Message-ID: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 816826a3-0755-43b3-7ef1-08db79610d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6PAZ0unCP2uVCNDqS9j9AovFORUOd8vWNwy2cLJurF8eogZDETp1SilkOFv8c6yfDityzrGNkYkFRXACBpZfRq6ptbYob6I3nNPrDhuFX+NifPG4lLG8/aJGzDG4QrUniNdpkSsAmcBJf3jw8uW655PkIQpHsel9PJcDs5N3gI1Wa4BCYWNAM17jhES4msAa/xTKFzCzQXVvPG2ea5EgHQCbtdaAeGnw4hOExA1fh2OrvtC9AR48Xf/SWVeiJydM0CrPslSNu6HyTyWz4KEJT0BEPGd+Yl7bDd+Yh4gOPtkZWtpgzdvIUuvA1BDiHPslQcm1+6JTdsoOW2HmB/szkXoZt6M/Vl8cfO7vm8Se+CwDNY3iXB9fXe3+HLgrop6qxe1+oPyXnI7mwtEuKwEa/PKoRots4J3qMQkoOWTyagaA0RxJszRovYa1F3wvXu2EmNa3u9JjINT02uVZm8FIxUbsLFp+0gEXoePbtUjOcB9pOoed5NV1XyAPVjOIOZicmJaX0G8djT87dBNR6XWU/gHqse6TdM23zHfYCRELfH00XgL9rfP/Yv392ubcqlXSsC/5QbFNAf73yaTP3L6l862vqFTH4cjKmSp58uanyETgV/FvIFAaSXhO8H6JnbKVrIFzOduvhHqpMoqkLoQ0KHAwxyqtUahUK8f23KpogMIYeYWRWFOPuzOiGLela0gqR6OkruZjZv4uuFJISK5kIxVtP73MErDLDy3G9zOrrTEQFbh5/k3mYBTzpXqJ9StqFitBrD5m9siSnpOGx0eUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(26005)(1076003)(44832011)(7696005)(478600001)(6636002)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(4744005)(47076005)(40460700003)(83380400001)(336012)(426003)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:34.7508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816826a3-0755-43b3-7ef1-08db79610d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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

Srinivasan Shanmugam (6):
  drm/amdgpu: Fix warnings in gfxhub_ v1_0, v1_2.c
  drm/amdgpu: Fix warnings in gfxhub_v2_0.c
  drm/amdgpu: Fix warnings in gfxhub_v2_1.c
  drm/amdgpu: Fix warnings in gfxhub_ v3_0, v3_0_3.c
  drm/amdgpu: Fix errors & warnings in gfx_v10_0.c
  drm/amdgpu: Remove else after return statement in
    'gfx_v10_0_check_grbm_cam_remapping'

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 185 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c |   4 +-
 7 files changed, 114 insertions(+), 104 deletions(-)

-- 
2.25.1

