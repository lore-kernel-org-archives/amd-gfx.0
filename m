Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B05113138;
	Tue, 12 Jul 2022 15:14:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343EA14A507
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5SZ+lqRO091I+ESCKDkMaB9d3xhayuvGIBSDL6jVuEd16QMQ1pgujwKO232XQ4ExjZgni9Fy2WzDqvxTmKp1QW8jYwGs/amX4dDK4MCkGcuWiBFwSKAuWCLEv89FFEwgn5SI6CMAcVHrXiBJkOctGqxnEAu8oE1zxX/q6wphAvU9o1pcAzxgoW1NVMScrSSMm7H9iikpbictXZPDklNmV8Sc9jBy7zyk1agjo0e+9/n0/CQJYrpL4PtwFG/hDCaj52GP2Vk0I1YEtMK5G67OU26PShdk62YH75n+t5n9Y91ZFEXExAgpzT70noyqONZngodIiSjCdwNjPd2Zp6Ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlidmqvqNGpCkScZhxcQi57xRQB6vnVihM0aUi4fOSA=;
 b=V+2UjOXJErZuLX2IbOaYo2xX02oa09KcNeryR2T1BDmCT/D/abms3+TQ5qCuM9muCcCcm7VJwwa1Xhh7R9SKHjcuo6PgB1dpsJxCwgLbiUFfLAJ2KI7yV8r+cMI/CWw1JoRhnsioX+gSMNTfcGIPEoNKcFoINPJKxod3SuaYoVlZwLySP4FLJ64PI1lBJNKS120CMd3af51CYH5nmrDqnETabEbrubBMmbEBMaDmx0Pycqgee0oCSA/Hy2PkKQ+Pi6SnLaaK1JkfPXj52fBuKHanA++MZLwSaQ/VsbBJRaHBUqQbC8n7u5b9PxAtCPHMgg3TULD0hQpIBvx6kCsBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlidmqvqNGpCkScZhxcQi57xRQB6vnVihM0aUi4fOSA=;
 b=nWhpSUsIl4ROaPDsrmMYrPb1b0jS4Fn1ovVTirxQZezx4q1e/w+T3VXjk9UlB5drC2zYu3mO1E4O6PR5wXM2b0lVEe2UvfsG5BCXrX/uU4z+nzxQypy/OdUjTy6a5hCnTkl0MhAl8SeChRD4ONOwo9YIRMlb0GBRCR7GElTt5i0=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:14:02 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e6) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 15:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:14:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:14:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu/gpuvm: remove unused variable
Date: Tue, 12 Jul 2022 11:13:45 -0400
Message-ID: <20220712151348.3047904-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9ee750-0060-4bdd-a83d-08da64192778
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYYM+ixA2iJ4yRo3p0d6dAQJSic60GnZz4HKxviY66pc0Tkgr+iMyU8MmhRhx/4FziogT2z//8ZJEi1bxVgNOEIR4JF49FdZYNyLUM3rnqVQRbxJ52Nj9TWefdzlEiH7CJyimE0pOqUt/uJelnAK+gkcyUmW7MrnpaNilmn4Vnv0RoJbL4NmzFuPyrjmDOyXi9wdbXi4Vs9xyNNLequmnATM67mN4AhDTpCFCR1SFMIH/1QAPr8/mGx7cJiVrJsiY2inTAjYmmk6eNeOLDiT7OsfyRfRAi+K6rg7Dt4LGJbtD1CcsivdzYKm+2rFBmjYXjoCNSg2h0ZBSb5im7nDfmmA7/tQ3EKgJUarP5hABDSfzk4FI4UwNqSjNCioEI3dU1noiATxzgAek9hHpRhKrb17yMSdQs8uHX+yUlwczJTscYLzLLprL6PzLSt0NppVV8iGte/QmTHwxNMol7UIDE+mudx4zpvWBRPnZ1jC7bJNMnQYtBWe6rQzJquYAiYODhFeDUod0fm5toFuA4cubQh2PDLPU/Qjx6ZYJMDiIiZEQNed5Z+gqpk2D9/du3yPACJstd5REbv09tv7dqpxFtyiC64MO/xhE07M15Osam3Z051U1SyoMiELkmaLGA53BpUdRgAkJtnxMINS1y9DxfzwntSNmPwzU3ny9M7TWrGYs9qNb3sLlWJ0w+sp/RDHpnIkFUZbEzoO7yGYEE8WYmvvYwPfSsfI/3dJcIzpA6d8cTLQExKpWaIgfRb7mBQwP8RbqqX0ynSAZUuH00BVonBuba5Lh1tMu/PCo+l6ur3kDzTbkexcN41QkB2lhIRMLizc42Cvxm8AZJpryTgBni64dGIdCCLkf30/7qHkjgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(40470700004)(46966006)(36840700001)(4744005)(40460700003)(5660300002)(41300700001)(2906002)(8936002)(6666004)(356005)(82310400005)(40480700001)(83380400001)(426003)(36860700001)(86362001)(8676002)(81166007)(316002)(70206006)(70586007)(26005)(2616005)(186003)(6916009)(4326008)(47076005)(16526019)(36756003)(336012)(478600001)(82740400003)(7696005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:14:02.4900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ee750-0060-4bdd-a83d-08da64192778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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

Not used so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4effee12a4ac..d1657de5f875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1576,7 +1576,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				    struct amdgpu_vm *vm)
 {
 	struct amdkfd_process_info *process_info = vm->process_info;
-	struct amdgpu_bo *pd = vm->root.bo;
 
 	if (!process_info)
 		return;
-- 
2.35.3

