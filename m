Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96547C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 06:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F4F72F0C;
	Fri,  3 Dec 2021 06:54:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8DC72F0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 06:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXncLsp43pA3GbnEa6JF4LQQmtorfsSz7HUGFhGsOfoEj3jBo30D/cMkLgymqTRjtzSk7mLvPyljVQRfKlWNiFQnJ4+B7J+M4INTK5XfOI00A5RdWU4AU8MABMM7BWf8/fh/8ItxUaTTo2d2ttyGkUC7gs0ejeZZcwk1K/Lp52HWg/24ld7cmZ7tZlneL8c1YjTHgksv8UzrZyDRgz7lDze8EiCC4bRRvX05o/QQ0MgDXigBxSZb0ZJj8LbhN22YefxeM7YqGNzwbNv/5e+IatQ3jImEKIzsTGlxifsKyrFQxHUG42UXtWyaYy4S9s44rF/nFAVdkgl1d8bOAo2Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pG/BkbaQB+jt/oRv3OLACFSWSM9VXQheaMIt00QBQw=;
 b=eNErOHWMIpncaOSzZDDmVffgOcAFvixJsEOMcK2lZ4UPOyTtjjjMJhaRB1aMd8TiaabDsRojNpXlCpmVo7CY8P5xaZXNBoj7f7yJh7ziUV8FBpyX+dl79vxZjtmsQ0ff5Owz1Lrnrtu8wvdSDs+3dsFjC2net0nIqqEUDthHeJBvGSnRFDZBV6Egkrh+6IkoTdoAa+ncK40EH1y2FIWmxl6NHpY7c/gcdjf3H0BRuUqGJDlEUef11tslV75LsTO9E2spK8XPfa0+FHOONARTYTRldES/JGQ027zjInhPZ7HVXqNJ4AWXdAu4poaGlz+ZBDcFIQhIO1+hq35ktRujLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pG/BkbaQB+jt/oRv3OLACFSWSM9VXQheaMIt00QBQw=;
 b=nQ3YhVyFHMQGEdghFb3QXnEMBeMlTkbiA+WN/yW+e5M6nVadrWk6CgHGHu3t8sQHLAaMp1dHn7b1hZ68zl50rhKYij4eYbfKYwr/OqBrycMy3ZH5Obb/3JsLlVUJ7R7dkDva9jcRC35B4Yew6R0KDOv24jgQSmgBOKTnqtpo4OY=
Received: from CO2PR04CA0155.namprd04.prod.outlook.com (2603:10b6:104::33) by
 MN2PR12MB3597.namprd12.prod.outlook.com (2603:10b6:208:cf::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 3 Dec 2021 06:54:24 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::3a) by CO2PR04CA0155.outlook.office365.com
 (2603:10b6:104::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Fri, 3 Dec 2021 06:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 06:54:23 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 00:54:21 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU hw_init/fini()
Date: Fri, 3 Dec 2021 14:54:06 +0800
Message-ID: <20211203065407.3714697-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84b5b2f-817c-4ce6-b174-08d9b629bd6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3597:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3597067849463D31CC4388B1FB6A9@MN2PR12MB3597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6PeE/y2SxiSfCu3BJukESAlQ4GAcNXpbsB65nNmWHVd+ufned0V8sk8qMsfWBIgmLVjgMYMDlgvp3Hg1WvznmRHGQmUNpN96tXm7b8jTOJDx0Bnd9ZYhpTtDcsbFQyln40sJ/Fe9J5pUm2HD3TGf6Y5qU8pjNJFioJrqk41NKwxUR4B/QCa+Hj1GPM9aCjkr8Jb33tpwx9CB6puZTfSUxHX9Mw27h9ONJRnY0Xkwynfq4nfsx5lMXpwDFgLi+6S/GFNSPC/sNYRkolzg+500DByRCtksuc1st583c9bQLM4CldbyPXUNGZb2jO8mD+VyMoT5Guquztu4GyO5fXNvgGdbCtReYd3v99Wda1rod8wU5Uh4yf5/B9qwqj9uPuFdQZIcnZXinaq+OgnJTG4DiC1MKNS4gImJrcJ3iUknXeKBqnvKzzyAWAFv4brYvChx8fxbzsLTkyWsBlauT4YIaEePWgWTc5Tc1dtrfRDnpZ8OuNG8sy5iON53qkw9gPKNOl/14U7UhNSwQJ+U2ndA8EVRCULkFoRj6zrGSEBWJZMNE5WE5zVYTfRZhnrJt/qq543cnbDiZMhRahuW4tWUFOzjsM4Z4Zjf6ZDaH9WJIVyz7iETBqbC8lTXI4BZYguwWgTjNYjgBwQta8q5EB6lgC863RPsrtPewWANqdGBYeJEVkqU/3KvL4Wwb+7z1NOXXd23/EmN6oAFniX4HlBpEmosHvYPHAWUYtEfkePdq6y65gQY43Xscmc9/HmxQ+fTdKYW45L7xBJ9XR9MJ6TeaHpA0GhynbT7yTKDUZK+zU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(70206006)(508600001)(44832011)(6916009)(81166007)(36756003)(26005)(70586007)(316002)(7696005)(82310400004)(40460700001)(1076003)(4326008)(2906002)(356005)(5660300002)(16526019)(2616005)(47076005)(8676002)(86362001)(336012)(8936002)(83380400001)(36860700001)(426003)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 06:54:23.5717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84b5b2f-817c-4ce6-b174-08d9b629bd6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3597
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
 Lang Yu <lang.yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we don't find some neccesities to power on/off
SDMA in SMU hw_init/fini(). It makes more sense in SDMA
hw_init/fini().

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5839918cb574..2d718c30c8eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
 	}
 
 	if (smu->is_apu) {
-		smu_powergate_sdma(&adev->smu, false);
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(&adev->smu, true);
@@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	if (smu->is_apu) {
-		smu_powergate_sdma(&adev->smu, true);
-	}
-
 	smu_dpm_set_vcn_enable(smu, false);
 	smu_dpm_set_jpeg_enable(smu, false);
 
-- 
2.25.1

