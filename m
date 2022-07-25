Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C03C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 06:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201DC113F90;
	Mon, 25 Jul 2022 06:19:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF3E113F39
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 06:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRyQzwfXwJoyM6ZWjApL2og8utmekYxfFlGYBdWlkogukqM0HKQwR3o3lHCSlTAZAfh4Q/dK8BTxLSSA9nyxNvjmJVAvx9Xnck/eDXbD9I78N945nq/anRC6kLZgaIk0Dtw0aL0MbNtA7hKEHnvJ5R2g8oiYg3+8XiP+OP3Ua2LWrTls2XbCtAYISsRqR7g3PdBt/W0HmXVjClksBKer0m+f2W/GZU6OoSR5fmlpQoSYZJ/Lb2bM3R/n29vFo07fvmSN9mS4qIwdJn/WfpFCXUduEmaCQHozb3SQkuG/udnVI/lUrf5lSr3FoSIFn3aXRNWbS7BZleOAY2g3Nt0pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c19Gfe+IG1W91dLyfAunasUFHJ5yrLxXQ0F+XEHGRI=;
 b=m+fuM+pYAfm3/6xRY0Dk90VCBI3UaQ2xVE/7Pkc3/HjUgXngs1CLS8re34AFbJdDBdSBTU8ETAEuk1c/4z0APBqw4aQwbnOIP2Ub8H7lY3KOqcEiEnl/ObeB92vrLl86sPrOMgUGx0N1EQQjFx9MvBwAu64f4TYvQc8mVn+KHedRAadqfSH5n0qZ1V511nOgQ9dWWRXnNoUNqWtrFXdK6TCNuiCZbHy9H3tEq2EG27Wf1TurP8mcOAov4qhGtBT7RO2SRb0BNe0cDeZe7UHsleLT7Znh1uvlPG3qfSrOvvQMXO/e+hq+LQ97tJCKvPpre0iaCzf34VK++03THnlqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c19Gfe+IG1W91dLyfAunasUFHJ5yrLxXQ0F+XEHGRI=;
 b=bLNIdVzMo7SvEOL4fnjukNRw/v3yf6t3H0+QLa6bCSKdfzxeg1kKUnlL4R0sWxdH8qYX1nt1ZStyS/1E1TgYtVovWgLFvW2Mc615/xRop6ncVyUTpvbue78WrqNgcKY0UouOb5sGR96PWd/fT73OMUlUxe0mLtPhSVRNj6mrUMg=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 06:19:21 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::5d) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22 via Frontend
 Transport; Mon, 25 Jul 2022 06:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 06:19:20 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 01:19:18 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm for consistency
Date: Mon, 25 Jul 2022 14:18:30 +0800
Message-ID: <20220725061830.26989-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01019987-d7e1-4fcc-c3f6-08da6e059cce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0a61uSalfJlxkLzuieIbK0F/9H4wEAoFfMlp+9Q3JOAjypXZx2IMjSprI5e6NGAXGbF1CQcjIGMDqkddHliHb+ykvypvmzahS3X8HuY6edAy2v4UHZw5nBRcFoX5oqLMpGdRjyE20y2uVeZXh3249fKC/rL5TRmtrdYItP7F9Iaeh5KXDGqjGbrDFGDFi/vyFFsrw6YAQnLBGy6tjHIw8Ohn1z8bdrLiaQqFnO0wketRda7E7rpaL0NO43EytsGiuil8jGw7GgPjo2qZFWL+VYZvLzyJ7rg9ryFZ0ThpbXwxWvNVANTrXlt268hnMSxyMGStiJB7V8oUlHe1KE1t4+OCCENsoohrOAu6kZOLBZvIFxT5D/mzcBeY+EjUeQbtJxzvCoRzbYJgxO9HWgfOjdN9WGlh/rxox7RPinCMhe/Tk4Tr/uaHT/d/y5Zq6sqtcjKv3P/mDYkOLzcz3IK9Xm+WQSiMfU4vKzL4cRAkwPdiFTF8pn7wgAXUPZg4QNTXyHyeVoGDEhR3l4pghxLBCyc2XgFfIHtE0KBR/p6vtldouSPNMiCa6mGanvamXnowl7VZxpvgrGUjfNW8UPLdTVuoa3CtyzXIF9i+BCKCpeGX+H30rRcwSnc+SQWQx50ZVwKpkFFXiltuBBM3KE0FpkhZAheHBwmNiheegvtbcRiqV89OgUfvEvvd5qn9t2+ijsofztmzQDEssPXsJMQCMCRlZx2duoV/p+CIMNaiPDSm+D0fFN1FuvGsuoS7g0Q76y1HTMv1jV0EJ4C11bJV2t3hxi19jSLbdzA6yESu23KOXqPrfywJO4BV5+bOHeZzU9y0m12Qa2CFbMLDFwDLjwwxPVO5OcNfdvRuxIRp1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(8936002)(70586007)(36756003)(70206006)(5660300002)(44832011)(4744005)(110136005)(6666004)(316002)(82310400005)(6636002)(2906002)(478600001)(2616005)(26005)(41300700001)(356005)(40480700001)(83380400001)(186003)(1076003)(82740400003)(47076005)(86362001)(336012)(426003)(16526019)(40460700003)(7696005)(8676002)(4326008)(81166007)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 06:19:20.9940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01019987-d7e1-4fcc-c3f6-08da6e059cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Keep code consistency when accessing drm_device from amdgpu driver.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 84ac2401895a..698a59ec3dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -150,7 +150,7 @@ static int vcn_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, r, idx;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-- 
2.17.1

